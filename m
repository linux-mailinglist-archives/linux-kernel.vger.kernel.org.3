Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBE4A85EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351071AbiBCONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:13:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:49619 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347868AbiBCONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897605; x=1675433605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ntjqmSSCL7cxYM2Sj8jtNAG0EU19qpU9TQ6MKxl5Rc=;
  b=mJrcr9uMxR8txSVAF9QnbYBYz44agw4IhGMzH0vlg4ZON9dvxVEviTLo
   c+w3h3QboAMsDteYbEc6Fvf+TKjvq1l+kq4n6KyptE45LaA1zobsISw/B
   8WJLr2vE146sn5uwMOjn9UmGczqrHZVXJ34LMo2RYOWmRijEVAjmeLX0R
   fZ2IxpF41k9QTb6DxyP3wpU+2+Q+vbZHXoAtOQMPKYRVEQSa8yP+WXxrR
   Jw/lyBiuwqHD7LTqmp2DDt6pQstOmr2W2dgbCTit5vI8mqggT4lYLoM2b
   ywVTKu+JlrM4o+aSvC949MyBYYsaip+UD0lTI/dVNgRW4uqFzzCHR+JPo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248102385"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248102385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699324086"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 06:13:10 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: [PATCH 2/3] crypto: qat - move and rename GEN4 error register definitions
Date:   Thu,  3 Feb 2022 13:54:33 +0000
Message-Id: <20220203135434.584967-3-wojciech.ziemba@intel.com>
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

Move error source related CSRs from 4xxx to the wider GEN4 header file.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c   |  6 +++---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h   | 14 --------------
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index 68d39c833332..f801d472819e 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -229,7 +229,7 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 	void __iomem *csr = misc_bar->virt_addr;
 
 	/* Enable all in errsou3 except VFLR notification on host */
-	ADF_CSR_WR(csr, ADF_4XXX_ERRMSK3, ADF_4XXX_VFLNOTIFY);
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3, ADF_VFLNOTIFY);
 }
 
 static void adf_enable_ints(struct adf_accel_dev *accel_dev)
@@ -256,9 +256,9 @@ static int adf_init_device(struct adf_accel_dev *accel_dev)
 	addr = (&GET_BARS(accel_dev)[ADF_4XXX_PMISC_BAR])->virt_addr;
 
 	/* Temporarily mask PM interrupt */
-	csr = ADF_CSR_RD(addr, ADF_4XXX_ERRMSK2);
+	csr = ADF_CSR_RD(addr, ADF_GEN4_ERRMSK2);
 	csr |= ADF_4XXX_PM_SOU;
-	ADF_CSR_WR(addr, ADF_4XXX_ERRMSK2, csr);
+	ADF_CSR_WR(addr, ADF_GEN4_ERRMSK2, csr);
 
 	/* Set DRV_ACTIVE bit to power up the device */
 	ADF_CSR_WR(addr, ADF_4XXX_PM_INTERRUPT, ADF_4XXX_PM_DRV_ACTIVE);
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
index 12e4fb9b40ce..857b93a3c032 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -39,20 +39,6 @@
 #define ADF_4XXX_NUM_RINGS_PER_BANK	2
 #define ADF_4XXX_NUM_BANKS_PER_VF	4
 
-/* Error source registers */
-#define ADF_4XXX_ERRSOU0	(0x41A200)
-#define ADF_4XXX_ERRSOU1	(0x41A204)
-#define ADF_4XXX_ERRSOU2	(0x41A208)
-#define ADF_4XXX_ERRSOU3	(0x41A20C)
-
-/* Error source mask registers */
-#define ADF_4XXX_ERRMSK0	(0x41A210)
-#define ADF_4XXX_ERRMSK1	(0x41A214)
-#define ADF_4XXX_ERRMSK2	(0x41A218)
-#define ADF_4XXX_ERRMSK3	(0x41A21C)
-
-#define ADF_4XXX_VFLNOTIFY	BIT(7)
-
 /* Arbiter configuration */
 #define ADF_4XXX_ARB_CONFIG			(BIT(31) | BIT(6) | BIT(0))
 #define ADF_4XXX_ARB_OFFSET			(0x0)
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
index f0f71ca44ca3..44240977832b 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
@@ -122,6 +122,20 @@ do { \
 #define ADF_WQM_CSR_RPRESETSTS_STATUS	BIT(0)
 #define ADF_WQM_CSR_RPRESETSTS(bank)	(ADF_WQM_CSR_RPRESETCTL(bank) + 4)
 
+/* Error source registers */
+#define ADF_GEN4_ERRSOU0	(0x41A200)
+#define ADF_GEN4_ERRSOU1	(0x41A204)
+#define ADF_GEN4_ERRSOU2	(0x41A208)
+#define ADF_GEN4_ERRSOU3	(0x41A20C)
+
+/* Error source mask registers */
+#define ADF_GEN4_ERRMSK0	(0x41A210)
+#define ADF_GEN4_ERRMSK1	(0x41A214)
+#define ADF_GEN4_ERRMSK2	(0x41A218)
+#define ADF_GEN4_ERRMSK3	(0x41A21C)
+
+#define ADF_VFLNOTIFY		BIT(7)
+
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
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

