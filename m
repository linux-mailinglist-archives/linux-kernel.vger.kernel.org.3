Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDBC4B0F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiBJN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:58:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbiBJN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:58:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76989A;
        Thu, 10 Feb 2022 05:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501494; x=1676037494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7F2YaYgBAf/PxAB8HDZk89iTLG5JHpdRKPiLykD8JGQ=;
  b=ZKyBEo4iAn+rvjZ2OW4q2QWzqtiZgkLoajP9J87q9V3uWCcDhqN1sIGh
   D/xev1aJNEVc+/ELKJdS2DdjBtj70WCuiJ78+zQLVmwsVZQQml15/DzPd
   X3mglpil/EsuwVgOiuy/3jPe982nzGxjqpyzRrzFKvbJgKdE8l2GZz+zZ
   hcQa1P4g8XcGhATOWomvYD472dYGQMihEPviVqgLMa98fmq02CzDY4bJ2
   oouqbk/yTWLQ096Xi5OxVY3/i/iiSgBB5oroTyopQNthwvtge5wYXM1cT
   3c3ZooLcwJjR/Eofohnaw4YsODHfx8c248rXn8MMieAcCVag8I00p3DkG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335910168"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="335910168"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="526487231"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2022 05:58:12 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: [PATCH v2 2/3] crypto: qat - move and rename GEN4 error register definitions
Date:   Thu, 10 Feb 2022 13:38:26 +0000
Message-Id: <20220210133827.2366901-3-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220210133827.2366901-1-wojciech.ziemba@intel.com>
References: <20220210133827.2366901-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 68d39c833332..69fb271c85dd 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -229,7 +229,7 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 	void __iomem *csr = misc_bar->virt_addr;
 
 	/* Enable all in errsou3 except VFLR notification on host */
-	ADF_CSR_WR(csr, ADF_4XXX_ERRMSK3, ADF_4XXX_VFLNOTIFY);
+	ADF_CSR_WR(csr, ADF_GEN4_ERRMSK3, ADF_GEN4_VFLNOTIFY);
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
index f0f71ca44ca3..43b8f864806b 100644
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
+#define ADF_GEN4_VFLNOTIFY	BIT(7)
+
 void adf_gen4_set_ssm_wdtimer(struct adf_accel_dev *accel_dev);
 void adf_gen4_init_hw_csr_ops(struct adf_hw_csr_ops *csr_ops);
 int adf_gen4_ring_pair_reset(struct adf_accel_dev *accel_dev, u32 bank_number);
-- 
2.29.2

