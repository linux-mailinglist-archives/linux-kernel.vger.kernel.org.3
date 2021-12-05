Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD67468BF7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhLEPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhLEPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A6960FC1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD321C00446
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718966;
        bh=/w4AutpfxtGwg8kjXs9WhQ66b/fuK7Yh2Ze5zFX4tos=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cE9lzTpqqMTw9zuQ0lg/QgpFdFl5b8zsmL4TAFyej1IxmNJf9cYHbq1YYKJAw2/tU
         3sk6zpp1bgcCp+Q2W/FwwOBAVCbGNzYomBNb36KqSpz51vX4pMMUKhzPCw6jldD7Rm
         C0NgNWR8ZEgVYdFIJML8KtlzqQYd5pWQgBEXDzgDJc+fgtUD/MlIQhRehT+RurqY1H
         a+oEKilRfUazLXdKmbpQGhi2NxZKra6jp6fIPCGmT8Llh5Dc1uQ8hHsVisa6FwR+JN
         /Mww7xEAVGmqcacFbV70tyB48mlKQpqv9HfF5oQ9dueY/SksMFCEmgVDJqMZhMEEah
         K6Bba9ONQv4Yw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] habanalabs: save ctx inside encaps signal
Date:   Sun,  5 Dec 2021 17:42:32 +0200
Message-Id: <20211205154236.2198481-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute context pointer in hdev shouldn't be used for fetching the
context's pointer.

If an object needs the context's pointer, it should get it while
incrementing its kref, and when the object is released, put it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 11 ++++++++---
 drivers/misc/habanalabs/common/context.c            | 10 +++++-----
 drivers/misc/habanalabs/common/habanalabs.h         |  2 ++
 drivers/misc/habanalabs/common/hw_queue.c           |  2 +-
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index d169418197c0..a63ebbc04787 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -1829,6 +1829,9 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	}
 
 	handle->count = count;
+
+	hl_ctx_get(hdev, hpriv->ctx);
+	handle->ctx = hpriv->ctx;
 	mgr = &hpriv->ctx->sig_mgr;
 
 	spin_lock(&mgr->lock);
@@ -1838,7 +1841,7 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	if (hdl_id < 0) {
 		dev_err(hdev->dev, "Failed to allocate IDR for a new signal reservation\n");
 		rc = -EINVAL;
-		goto free_handle;
+		goto put_ctx;
 	}
 
 	handle->id = hdl_id;
@@ -1891,7 +1894,8 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	idr_remove(&mgr->handles, hdl_id);
 	spin_unlock(&mgr->lock);
 
-free_handle:
+put_ctx:
+	hl_ctx_put(handle->ctx);
 	kfree(handle);
 
 out:
@@ -1953,6 +1957,7 @@ static int cs_ioctl_unreserve_signals(struct hl_fpriv *hpriv, u32 handle_id)
 
 		/* Release the id and free allocated memory of the handle */
 		idr_remove(&mgr->handles, handle_id);
+		hl_ctx_put(encaps_sig_hdl->ctx);
 		kfree(encaps_sig_hdl);
 	} else {
 		rc = -EINVAL;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 4f7d39a29a42..8291151948ef 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -13,13 +13,13 @@ void hl_encaps_handle_do_release(struct kref *ref)
 {
 	struct hl_cs_encaps_sig_handle *handle =
 		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
-	struct hl_ctx *ctx = handle->hdev->compute_ctx;
-	struct hl_encaps_signals_mgr *mgr = &ctx->sig_mgr;
+	struct hl_encaps_signals_mgr *mgr = &handle->ctx->sig_mgr;
 
 	spin_lock(&mgr->lock);
 	idr_remove(&mgr->handles, handle->id);
 	spin_unlock(&mgr->lock);
 
+	hl_ctx_put(handle->ctx);
 	kfree(handle);
 }
 
@@ -27,8 +27,7 @@ static void hl_encaps_handle_do_release_sob(struct kref *ref)
 {
 	struct hl_cs_encaps_sig_handle *handle =
 		container_of(ref, struct hl_cs_encaps_sig_handle, refcount);
-	struct hl_ctx *ctx = handle->hdev->compute_ctx;
-	struct hl_encaps_signals_mgr *mgr = &ctx->sig_mgr;
+	struct hl_encaps_signals_mgr *mgr = &handle->ctx->sig_mgr;
 
 	/* if we're here, then there was a signals reservation but cs with
 	 * encaps signals wasn't submitted, so need to put refcount
@@ -40,6 +39,7 @@ static void hl_encaps_handle_do_release_sob(struct kref *ref)
 	idr_remove(&mgr->handles, handle->id);
 	spin_unlock(&mgr->lock);
 
+	hl_ctx_put(handle->ctx);
 	kfree(handle);
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 57bc55c2ddac..0ad08fdc89ea 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2757,6 +2757,7 @@ struct hl_device {
  *            wait cs are used to wait of the reserved encaps signals.
  * @hdev: pointer to habanalabs device structure.
  * @hw_sob: pointer to  H/W SOB used in the reservation.
+ * @ctx: pointer to the user's context data structure
  * @cs_seq: staged cs sequence which contains encapsulated signals
  * @id: idr handler id to be used to fetch the handler info
  * @q_idx: stream queue index
@@ -2767,6 +2768,7 @@ struct hl_cs_encaps_sig_handle {
 	struct kref refcount;
 	struct hl_device *hdev;
 	struct hl_hw_sob *hw_sob;
+	struct hl_ctx *ctx;
 	u64  cs_seq;
 	u32  id;
 	u32  q_idx;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index fc841d651210..6103e479e855 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -574,7 +574,7 @@ static int encaps_sig_first_staged_cs_handler
 	struct hl_encaps_signals_mgr *mgr;
 	int rc = 0;
 
-	mgr = &hdev->compute_ctx->sig_mgr;
+	mgr = &cs->ctx->sig_mgr;
 
 	spin_lock(&mgr->lock);
 	encaps_sig_hdl = idr_find(&mgr->handles, cs->encaps_sig_hdl_id);
-- 
2.25.1

