Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1214745F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhLNPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhLNPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44C92B81A2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F481C34601
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494358;
        bh=EkVHTtNLsU1PxfQXuO3EIH1g5eBZvVgFE7N9G2PYHbg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SRMvMvxk8NjZ8QqC96EnIvCvE/GC2oPoHY0K6MViJ+Py2J13kfHywcaFrsskNSMsH
         x3dSKMb0nZUGfXCWprJJTNGgomf/IunBajgmvbrRPe+TnDf/C2nwDRvpirjOc9ASc5
         uteHJhBsGJ4VwdWgIGtHo9AvYSUksmCn/Q98pdituM3V5BNxOZEbdanTToLHe49pND
         In2xp6Z3AllMUmYgyhctKEW5sc441KIB+mum9yBsT0BqS4Yvd9BZDVoR6fW5KhVwZL
         PHbf/vqedDdYXLD3AMp2PGy+QtaI2YDlYZJSkPb8J8BYWW+zpxnN2eAKKxpJ0TBxLW
         F8gUskTLCdVMg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] habanalabs: remove in_debug check in device open
Date:   Tue, 14 Dec 2021 17:05:42 +0200
Message-Id: <20211214150551.1568192-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports only a single user anyway, so there is no point
in checking whether we are in_debug state when a user tries to open
the device, because if we are in_debug, it means a user is already
using the device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h     | 5 +++--
 drivers/misc/habanalabs/common/habanalabs_drv.c | 8 --------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eda1c70f6966..362eee3f028c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2561,8 +2561,9 @@ struct last_error_session_info {
  * @init_done: is the initialization of the device done.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
- * @in_debug: is device under debug. This, together with fpriv_list, enforces
- *            that only a single user is configuring the debug infrastructure.
+ * @in_debug: whether the device is in a state where the profiling/tracing infrastructure
+ *            can be used. This indication is needed because in some ASICs we need to do
+ *            specific operations to enable that infrastructure.
  * @power9_64bit_dma_enable: true to enable 64-bit DMA mask support. Relevant
  *                           only to POWER9 machines.
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 62a02ef43bb7..d59201f93de9 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -153,14 +153,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	if (hdev->in_debug) {
-		dev_err_ratelimited(hdev->dev,
-			"Can't open %s because it is being debugged by another user\n",
-			dev_name(hdev->dev));
-		rc = -EPERM;
-		goto out_err;
-	}
-
 	if (hdev->is_compute_ctx_active) {
 		dev_dbg_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
-- 
2.25.1

