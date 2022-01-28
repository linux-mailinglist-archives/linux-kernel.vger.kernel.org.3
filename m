Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95049FE62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350302AbiA1QvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350150AbiA1QvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:51:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C75C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C65CEB82657
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D319C340E0;
        Fri, 28 Jan 2022 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643388668;
        bh=vqwjh0qM+UtpuS8YB1k8P2rC7R/IlLOJ/WcGHHj7opw=;
        h=From:To:Cc:Subject:Date:From;
        b=NqPzWMwMa6LBiJ9hGIoCAoqa8WX8+/p0zHbV0r4LBuUVeN33LBxnX3akkOi1kF/e3
         3tmuta+RXCz6256pVYh4JvESqs745LKPfk5Uj/F83Z37JBEG4dzi1uQLRBpisqD3qd
         pFY0uDJwaemiBUYJLc5+e/EEuGSPzJymi8m1v1whwFBb8HxnjtpdpLs6qG8aylbqyB
         riyV+k/j1xUxc14nC+qDJ0S+fA9373tdGdY1nnBkm+k24AIL5F6ueuLtSkXYFThynw
         TY3TSvXa2I4LE56JeIJSy9sfyFsP77Ysk/g4bFNd7GlGfB/J/vqX/Z62P54Avf7Qrs
         Ih0xxBVZ/lm1g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     hdanton@sina.com, Dani Liberman <dliberman@habana.ai>
Subject: [PATCH v2] habanalabs: fix race when waiting on encaps signal
Date:   Fri, 28 Jan 2022 18:50:58 +0200
Message-Id: <20220128165058.2797574-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Fixed by getting the refcount of the handle only in case it is not
zero.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
v2:
 - Use kref_get_unless_zero() instead of kref_get() and then checking
   if the value is not 0.

 drivers/misc/habanalabs/common/command_submission.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0ea9a73e4aa5..ba5215b77852 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2063,13 +2063,16 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			idp = &ctx->sig_mgr.handles;
 			idr_for_each_entry(idp, encaps_sig_hdl, id) {
 				if (encaps_sig_hdl->cs_seq == signal_seq) {
-					handle_found = true;
-					/* get refcount to protect removing
-					 * this handle from idr, needed when
-					 * multiple wait cs are used with offset
+					/* get refcount to protect removing this handle from idr,
+					 * needed when multiple wait cs are used with offset
 					 * to wait on reserved encaps signals.
+					 * Since kref_put of this handle is executed outside the
+					 * current lock, it is possible that the handle refcount
+					 * is 0 but it yet to be removed from the list. In this
+					 * case need to consider the handle as not valid.
 					 */
-					kref_get(&encaps_sig_hdl->refcount);
+					if (kref_get_unless_zero(&encaps_sig_hdl->refcount))
+						handle_found = true;
 					break;
 				}
 			}
-- 
2.25.1

