Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9308557CC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGUNr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiGUNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:47:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E9820D7;
        Thu, 21 Jul 2022 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658411168; x=1689947168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fQCPrJb9lHyi4oxZ+pNt0wwlX5RQtHlur9Kl1f9gxRE=;
  b=eNS027HcYP3OjWp0qunzouJvNGwaiEzkIeFLFtyifGGK5UcWIAqXAatx
   ABmpwPmk5xx9/Vju9lfohyiXX4BZ8asN2RoI0SjBttTx/UGoA7oO03Z6z
   mgzIz1hMrJe6EYim76S2GjhyQ1hyGPToShoRNLhqMMJVdG03fmTSEydRQ
   jEe7753UhvO95l7gHGxzHcukb9GrrcrS/uNMi7wApJnWHRi6NI5ihTmN1
   weyNpD2KumcUxpgEGeFjwR/9a4Sp6CkDCl9wAFcOfIFz9RckkHKCRWtZs
   PeIPcQ8tndUTKr4SsVrLvrPXXMg9aPUbkhWSSPlesfvCTiK+tenB5MECW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="267445062"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="267445062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="925655444"
Received: from 984fee006c34.jf.intel.com ([10.165.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 06:46:08 -0700
From:   Srinivas Kerekare <srinivas.kerekare@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH] crypto: qat - add check to validate firmware images
Date:   Wed, 22 Jun 2022 14:01:55 -0700
Message-Id: <20220622210155.69684-1-srinivas.kerekare@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function qat_uclo_check_image() validates the MMP and AE firmware
images. If the QAT device supports firmware authentication (indicated
by the handle to firmware loader), the input signed binary MMP and AE
images are validated by parsing the following information:
- Header length
- Full size of the binary
- Type of binary image (MMP or AE Firmware)

Firmware binaries use RSA3K for signing and verification.
The header length for the RSA3k is 0x384 bytes.

All the size field values in the binary are quantified
as DWORDS (1 DWORD = 4bytes).

On an invalid value the function prints an error message and returns
with an error code "EINVAL".

Signed-off-by: Srinivas Kerekare <srinivas.kerekare@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
---
 drivers/crypto/qat/qat_common/icp_qat_uclo.h |  3 +-
 drivers/crypto/qat/qat_common/qat_uclo.c     | 56 +++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/icp_qat_uclo.h b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
index 4b36869bf460..69482abdb8b9 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_uclo.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
@@ -86,7 +86,8 @@
 					ICP_QAT_CSS_FWSK_MODULUS_LEN(handle) + \
 					ICP_QAT_CSS_FWSK_EXPONENT_LEN(handle) + \
 					ICP_QAT_CSS_SIGNATURE_LEN(handle))
-#define ICP_QAT_CSS_MAX_IMAGE_LEN   0x40000
+#define ICP_QAT_CSS_RSA4K_MAX_IMAGE_LEN    0x40000
+#define ICP_QAT_CSS_RSA3K_MAX_IMAGE_LEN    0x30000
 
 #define ICP_QAT_CTX_MODE(ae_mode) ((ae_mode) & 0xf)
 #define ICP_QAT_NN_MODE(ae_mode) (((ae_mode) >> 0x4) & 0xf)
diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
index 0fe5a474aa45..b7f7869ef8b2 100644
--- a/drivers/crypto/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/qat/qat_common/qat_uclo.c
@@ -1367,6 +1367,48 @@ static void qat_uclo_ummap_auth_fw(struct icp_qat_fw_loader_handle *handle,
 	}
 }
 
+static int qat_uclo_check_image(struct icp_qat_fw_loader_handle *handle,
+				char *image, unsigned int size,
+				unsigned int fw_type)
+{
+	char *fw_type_name = fw_type ? "MMP" : "AE";
+	unsigned int css_dword_size = sizeof(u32);
+
+	if (handle->chip_info->fw_auth) {
+		struct icp_qat_css_hdr *css_hdr = (struct icp_qat_css_hdr *)image;
+		unsigned int header_len = ICP_QAT_AE_IMG_OFFSET(handle);
+
+		if ((css_hdr->header_len * css_dword_size) != header_len)
+			goto err;
+		if ((css_hdr->size * css_dword_size) != size)
+			goto err;
+		if (fw_type != css_hdr->fw_type)
+			goto err;
+		if (size <= header_len)
+			goto err;
+		size -= header_len;
+	}
+
+	if (fw_type == CSS_AE_FIRMWARE) {
+		if (size < sizeof(struct icp_qat_simg_ae_mode *) +
+		    ICP_QAT_SIMG_AE_INIT_SEQ_LEN)
+			goto err;
+		if (size > ICP_QAT_CSS_RSA4K_MAX_IMAGE_LEN)
+			goto err;
+	} else if (fw_type == CSS_MMP_FIRMWARE) {
+		if (size > ICP_QAT_CSS_RSA3K_MAX_IMAGE_LEN)
+			goto err;
+	} else {
+		pr_err("QAT: Unsupported firmware type\n");
+		return -EINVAL;
+	}
+	return 0;
+
+err:
+	pr_err("QAT: Invalid %s firmware image\n", fw_type_name);
+	return -EINVAL;
+}
+
 static int qat_uclo_map_auth_fw(struct icp_qat_fw_loader_handle *handle,
 				char *image, unsigned int size,
 				struct icp_qat_fw_auth_desc **desc)
@@ -1379,7 +1421,7 @@ static int qat_uclo_map_auth_fw(struct icp_qat_fw_loader_handle *handle,
 	struct icp_qat_simg_ae_mode *simg_ae_mode;
 	struct icp_firml_dram_desc img_desc;
 
-	if (size > (ICP_QAT_AE_IMG_OFFSET(handle) + ICP_QAT_CSS_MAX_IMAGE_LEN)) {
+	if (size > (ICP_QAT_AE_IMG_OFFSET(handle) + ICP_QAT_CSS_RSA4K_MAX_IMAGE_LEN)) {
 		pr_err("QAT: error, input image size overflow %d\n", size);
 		return -EINVAL;
 	}
@@ -1547,6 +1589,11 @@ int qat_uclo_wr_mimage(struct icp_qat_fw_loader_handle *handle,
 {
 	struct icp_qat_fw_auth_desc *desc = NULL;
 	int status = 0;
+	int ret;
+
+	ret = qat_uclo_check_image(handle, addr_ptr, mem_size, CSS_MMP_FIRMWARE);
+	if (ret)
+		return ret;
 
 	if (handle->chip_info->fw_auth) {
 		status = qat_uclo_map_auth_fw(handle, addr_ptr, mem_size, &desc);
@@ -2018,8 +2065,15 @@ static int qat_uclo_wr_suof_img(struct icp_qat_fw_loader_handle *handle)
 	struct icp_qat_fw_auth_desc *desc = NULL;
 	struct icp_qat_suof_handle *sobj_handle = handle->sobj_handle;
 	struct icp_qat_suof_img_hdr *simg_hdr = sobj_handle->img_table.simg_hdr;
+	int ret;
 
 	for (i = 0; i < sobj_handle->img_table.num_simgs; i++) {
+		ret = qat_uclo_check_image(handle, simg_hdr[i].simg_buf,
+					   simg_hdr[i].simg_len,
+					   CSS_AE_FIRMWARE);
+		if (ret)
+			return ret;
+
 		if (qat_uclo_map_auth_fw(handle,
 					 (char *)simg_hdr[i].simg_buf,
 					 (unsigned int)
-- 
2.36.1

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

