Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7B47F6C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhLZMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:43:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59680 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhLZMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8C360DF2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8F9C36AE9;
        Sun, 26 Dec 2021 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522590;
        bh=MCS6kpvkc3EU0Gw/dDorqcK6eG/lH9vq5sJQPpyCiUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdTcZCsEpAGKurSOzAupn31WztVrT/4X3M1cwd8vib4oPwJZzL/WOaXcYTrPHW2jC
         obW8GaqUt3tJZpycqILKmntOaHRX1j5c9Lu4uRk10hZKILejdiWT/Ix8LL/EbBwH4C
         ijslNX98d8bceolKojgqGmKEzSwV13ckHYSYRW7A6ZngF0gp+1QvLm7vO5yiRM6uHi
         dvAVNCNaL86q3s0Ph9rPY+T5d3xnOEx3k0D/KtmRPFMNIHPn7Pq08fG7umPLUp0KD+
         ijGufeqCsB7zuLBl9lxQgcDApMmAGwoiOpIroqjq0ZD935cgFUIAOfnVmKDUb4O7uu
         nCwUkh261ZfwA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/5] habanalabs: handle skip multi-CS if handling not done
Date:   Sun, 26 Dec 2021 14:43:01 +0200
Message-Id: <20211226124304.237107-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226124304.237107-1-ogabbay@kernel.org>
References: <20211226124304.237107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch fixes issue in which we have timeout for multi-CS although
the CS in the list actually completed.

Example scenario (the two threads marked as WAIT for the thread that
handles the wait_for_multi_cs and CMPL as the thread that signal
completion for both CS and multi-CS):
1. Submit CS with sequence X
2. [WAIT]: call wait_for_multi_cs with single CS X
3. [CMPL]: CS X do invoke complete_all for both CS and multi-CS
           (multi_cs_completion_done still false)
4. [WAIT]: enter poll_fences, reinit the completion and find the CS
           as completed when asking on the fence but multi_cs_done is
	   still false it returns that no CS actually completed
5. [CMPL]: set multi_cs_handling_done as true
6. [WAIT]: wait for completion but no CS to awake the wait context
           and hence wait till timeout

Solution: if CS detected as completed in poll_fences but multi_cs_done
          is still false invoke complete_all to the multi-CS completion
	  and so it will not go to sleep in wait_for_completion but
	  rather will have a "second chance" to wait for
	  multi_cs_completion_done.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7073fa6b9f0f..d39343f90bc2 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2453,9 +2453,19 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 			 * returns to user indicating CS completed before it finished
 			 * all of its mcs handling, to avoid race the next time the
 			 * user waits for mcs.
+			 * note: when reaching this case fence is definitely not NULL
+			 *       but NULL check was added to overcome static analysis
 			 */
-			if (!fence->mcs_handling_done)
+			if (fence && !fence->mcs_handling_done) {
+				/*
+				 * in case multi CS is completed but MCS handling not done
+				 * we "complete" the multi CS to prevent it from waiting
+				 * until time-out and the "multi-CS handling done" will have
+				 * another chance at the next iteration
+				 */
+				complete_all(&mcs_compl->completion);
 				break;
+			}
 
 			mcs_data->completion_bitmap |= BIT(i);
 			/*
-- 
2.25.1

