Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9E5496DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiAVT5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAVT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8DC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE83460EBB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612CBC340E2;
        Sat, 22 Jan 2022 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881458;
        bh=SvhVeoILYVG0AQMVqf6rwnis9fmzUAIERQ/VXLC4vEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVy2jG0LV90/vrKgowMrFZhFu4i6F8bE9KrfHsSgdVa/xjPpAfIKG/YWgKS3dRtUG
         jJeMrBA0tAd4ymHzmPU7mDDToRsD6MdwfTwiA6vWfnokhIt7f8ISkZQBsgj0SJKf63
         yhvdmbg4IIN7I0VWhvrtaeuYWC08kPmnVNt/WcbWlRjARJBhsXHz7E5HFHtgpeALxp
         6ac0zKnLCUL3gaq8zMhFlQvXrQkaa6eMz13aet2CjTisgsMXzG7DjvFdv0NwSJCWBQ
         kskmOF3C3TtI4poLNo727gDySnwccUxVROBMZIhD4lUndNdo0z/M+PpdZJrHuxBm0p
         DRRt7M+nLXKmA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 02/30] habanalabs: fix race when waiting on encaps signal
Date:   Sat, 22 Jan 2022 21:57:03 +0200
Message-Id: <20220122195731.934494-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Scenario:
1. CS which is part of encaps signal has been completed and now
executing kref_put to its encaps signal handle. The refcount of the
handle decremented to 0, and called the encaps signal handle
release function - hl_encaps_handle_do_release.

2. At this point the user starts waiting on the signal, and finds the
encaps signal handle in the handlers list and increment the habdle
refcount to 1.

3. Immediately after, hl_encaps_handle_do_release removed the handle
from the list and free its memory.

4. Wait function using the handle although it has been freed.

This scenario caused the slab area which was previously allocated
for the handle to be poison overwritten which triggered kernel bug
the next time the OS needed to allocate this slab.

Fixed by getting the refcount of the handle and validate it only if
the refcount was not zero before.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 2f40b937c59f..96ec1fd3882a 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2063,13 +2063,22 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			idp = &ctx->sig_mgr.handles;
 			idr_for_each_entry(idp, encaps_sig_hdl, id) {
 				if (encaps_sig_hdl->cs_seq == signal_seq) {
-					handle_found = true;
 					/* get refcount to protect removing
 					 * this handle from idr, needed when
 					 * multiple wait cs are used with offset
 					 * to wait on reserved encaps signals.
 					 */
 					kref_get(&encaps_sig_hdl->refcount);
+					/*
+					 * Since kref_put of this handle is executed outside the
+					 * current lock, it is possible that the handle refcount
+					 * is 0 but it yet to be removed from the list. In this case
+					 * need to consider the handle as not valid. To ensure
+					 * that the handle is valid, its refcount must be bigger
+					 * than 1.
+					 */
+					if (kref_read(&encaps_sig_hdl->refcount) > 1)
+						handle_found = true;
 					break;
 				}
 			}
-- 
2.25.1

