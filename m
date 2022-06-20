Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2459551B55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbiFTNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbiFTNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5231C10D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52094615A3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287C4C341C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730295;
        bh=hr/hOCgCt4RQ3cFJyt/AXGGsYG23Z+eJMh/aP+XrKNE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kX5M4PEbSQlEURh8H08DBP0x7o8veNMVW+bl27XYz9kmuii6Uz817HUhzCpCMkAFj
         pW8zZbZQaUQLMwc/7X90fXFv4nNnBBWu0b8aBnx0AQYM0Dpd8xatBkHsa2yB8V0xQV
         xG82sfgE6M1bfsDIk/aClkM/MiLd5rvVPsbvhdxZhhthIgE7CZSeCnn5yMUmaA0vSJ
         6Usm55NKS0EF8Fr3r6B9VGJyrXtxO4JLTJMmvg+UI+j4bZP28wLXnUFPiNBMIY1hf6
         oWalZU0Gn2fEQgPvCUhkMbHx+sXqCdTCvGZ/SxJXEFji0jf0ane8TEMcbNmvaZrAZg
         EE/Uc3PnJCiuw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] habanalabs: check fence pointer before use
Date:   Mon, 20 Jun 2022 16:04:29 +0300
Message-Id: <20220620130432.1180451-14-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fence pointer can be NULL in this path, as shown by an earlier check.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index c050f38b7091..e5549a9da42e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2581,7 +2581,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 			 * For this we have to validate that the timestamp is
 			 * earliest of all timestamps so far.
 			 */
-			if (mcs_data->update_ts &&
+			if (fence && mcs_data->update_ts &&
 					(ktime_compare(fence->timestamp, first_cs_time) < 0))
 				first_cs_time = fence->timestamp;
 			break;
-- 
2.25.1

