Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997C24A85EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbiBCONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:13:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:49628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351052AbiBCON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897606; x=1675433606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ifFMPOyNjQOM1qILQbZOgrEhHyVk3P9ravPA8cedy4=;
  b=Hk8GjpotpJXDN6TOm5yqUWGb79BTPz91ArAwu0d5T3UqmZ3+TOCyffX0
   OPkW8cxGfj75M9NWfn1lf4zy0YurwZ9yUXtB0Erwl3Nkg1oBAwIQgEezd
   rNrM5YBKS8sW97cxSBBtj+dr7t14Rtyn7dh0bF7sxE6/mtNDiIolQnlyT
   sZvmzqg/8S8ZIs+R3i1FyLMAiiJCQ9QNglleBdFw25ft18bIl2rLykg6B
   diJfjEYtQ2M/dMdDiDp4ngGiHaIEryhD1+vnbrIm5Bb3IqOIIn48rRndd
   jav5jBiyLob/q4AE0S+1f93eaL4W4OuHCcLibBre8/WqbAWetsP0EYBIM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248102383"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248102383"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:13:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699324079"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 06:13:07 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: [PATCH 1/3] crypto: qat - add misc workqueue
Date:   Thu,  3 Feb 2022 13:54:32 +0000
Message-Id: <20220203135434.584967-2-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220203135434.584967-1-wojciech.ziemba@intel.com>
References: <20220203135434.584967-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to reduce the amount of workqueues, scattered across
the QAT driver, introduce the misc workqueue. This queue will be used
to handle bottom halves, Power Management and more in the future.

The function adf_misc_wq_queue_work() has been added to simplify
the enqueuing of jobs.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 .../crypto/qat/qat_common/adf_common_drv.h    |  3 ++
 drivers/crypto/qat/qat_common/adf_ctl_drv.c   |  6 ++++
 drivers/crypto/qat/qat_common/adf_isr.c       | 28 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 76f4f96ec5eb..077549176879 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -188,6 +188,9 @@ int qat_uclo_map_obj(struct icp_qat_fw_loader_handle *handle,
 		     void *addr_ptr, u32 mem_size, char *obj_name);
 int qat_uclo_set_cfg_ae_mask(struct icp_qat_fw_loader_handle *handle,
 			     unsigned int cfg_ae_mask);
+int adf_init_misc_wq(void);
+void adf_exit_misc_wq(void);
+bool adf_misc_wq_queue_work(struct work_struct *work);
 #if defined(CONFIG_PCI_IOV)
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index 6f64aa693146..e8ac932bbaab 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -419,6 +419,9 @@ static int __init adf_register_ctl_device_driver(void)
 	if (adf_chr_drv_create())
 		goto err_chr_dev;
 
+	if (adf_init_misc_wq())
+		goto err_misc_wq;
+
 	if (adf_init_aer())
 		goto err_aer;
 
@@ -440,6 +443,8 @@ static int __init adf_register_ctl_device_driver(void)
 err_pf_wq:
 	adf_exit_aer();
 err_aer:
+	adf_exit_misc_wq();
+err_misc_wq:
 	adf_chr_drv_destroy();
 err_chr_dev:
 	mutex_destroy(&adf_ctl_lock);
@@ -449,6 +454,7 @@ static int __init adf_register_ctl_device_driver(void)
 static void __exit adf_unregister_ctl_device_driver(void)
 {
 	adf_chr_drv_destroy();
+	adf_exit_misc_wq();
 	adf_exit_aer();
 	adf_exit_vf_wq();
 	adf_exit_pf_wq();
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 4ca482aa69f7..803b89ba9670 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -16,6 +16,7 @@
 #include "adf_transport_internal.h"
 
 #define ADF_MAX_NUM_VFS	32
+static struct workqueue_struct *adf_misc_wq;
 
 static int adf_enable_msix(struct adf_accel_dev *accel_dev)
 {
@@ -341,3 +342,30 @@ int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adf_isr_resource_alloc);
+
+/**
+ * adf_init_misc_wq() - Init misc workqueue
+ *
+ * Function init workqueue 'qat_misc_wq' for general purpose.
+ *
+ * Return: 0 on success, error code otherwise.
+ */
+int __init adf_init_misc_wq(void)
+{
+	adf_misc_wq = alloc_workqueue("qat_misc_wq", WQ_MEM_RECLAIM, 0);
+
+	return !adf_misc_wq ? -ENOMEM : 0;
+}
+
+void adf_exit_misc_wq(void)
+{
+	if (adf_misc_wq)
+		destroy_workqueue(adf_misc_wq);
+
+	adf_misc_wq = NULL;
+}
+
+bool adf_misc_wq_queue_work(struct work_struct *work)
+{
+	return queue_work(adf_misc_wq, work);
+}
-- 
2.29.2

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

