Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1914DAF06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355419AbiCPLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355432AbiCPLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24949CA9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EFF2B81A79
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E48C340EC;
        Wed, 16 Mar 2022 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430901;
        bh=OWoHbt9lfDDO29WqmBNjz+gu8+TCKSF5VTE8H5P7DpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFeIVDtKkcP+uV8MVHu6/P6s7ezpoe3+AADhOefouZRQfwEt/+FzaoDRHy+X/Ro2/
         IdK7ZGIunlessggnMucFOZ7MBLU3LcuEH53WOSOV1WK3u/soQmnm11FVPuiefJoYgd
         tkdI5Qm5vsRrz2jhGtYCw0QGcPBq8CDFWL1cvqGoi8d5hUiS0RoOPIDcfo5gdpct9p
         3fFVt//G6gNfPmpHnqJ1kDGDmzaVun7WlB2AMCmpg8IzgLoeb5iciGcol+ZhMGuxYh
         noUWIu2uCz9dSJfWJilYo7uizi9V/T4vy7cfoMSedYd2GIfEkElTJBUniMUs0Q8QQO
         XS3RhcfX4ehUA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/11] habanalabs: add new return code to device fd open
Date:   Wed, 16 Mar 2022 13:41:24 +0200
Message-Id: <20220316114129.2520107-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to be more informative during device open, we are adding a
new return code -EAGAIN that indicates device is still going through
resource reclaiming and hence it cannot be used yet.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         |  4 ++++
 drivers/misc/habanalabs/common/habanalabs.h     |  2 ++
 drivers/misc/habanalabs/common/habanalabs_drv.c | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index dc9341a64541..3eb392b4308a 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -107,6 +107,8 @@ static void hpriv_release(struct kref *ref)
 	hdev->is_compute_ctx_active = false;
 	mutex_unlock(&hdev->fpriv_list_lock);
 
+	hdev->compute_ctx_in_release = 0;
+
 	kfree(hpriv);
 }
 
@@ -150,6 +152,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_ts_mgr_fini(hpriv->hdev, &hpriv->ts_mem_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
+	hdev->compute_ctx_in_release = 1;
+
 	if (!hl_hpriv_put(hpriv))
 		dev_notice(hdev->dev,
 			"User process closed FD but device still in use\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 564797766f42..0079f43bc596 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2710,6 +2710,7 @@ struct hl_reset_info {
  *                        cases where Linux was not loaded to device CPU
  * @supports_wait_for_multi_cs: true if wait for multi CS is supported
  * @is_compute_ctx_active: Whether there is an active compute context executing.
+ * @compute_ctx_in_release: true if the current compute context is being released.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2828,6 +2829,7 @@ struct hl_device {
 	u8				supports_wait_for_multi_cs;
 	u8				stream_master_qid_arr_size;
 	u8				is_compute_ctx_active;
+	u8				compute_ctx_in_release;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index ca404ed9d9a7..e870c32a0733 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -150,7 +150,20 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		dev_err_ratelimited(hdev->dev,
 			"Can't open %s because it is %s\n",
 			dev_name(hdev->dev), hdev->status[status]);
-		rc = -EPERM;
+
+		if (status == HL_DEVICE_STATUS_IN_RESET)
+			rc = -EAGAIN;
+		else
+			rc = -EPERM;
+
+		goto out_err;
+	}
+
+	if (hdev->compute_ctx_in_release) {
+		dev_dbg_ratelimited(hdev->dev,
+			"Can't open %s because another user is still releasing it\n",
+			dev_name(hdev->dev));
+		rc = -EAGAIN;
 		goto out_err;
 	}
 
-- 
2.25.1

