Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8155C34E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiF0U1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiF0U0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E719006
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC13B81135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E104CC385A5;
        Mon, 27 Jun 2022 20:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361605;
        bh=S6sYovHV9TiZOorN/9SR/PSbBF1PStF1Rrk+75FPCvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrJPNr0+5qEan1I3/TD5fESe6gr13cgFZ0fCiR+4XOgJ2Ot2tONR2PNcWiMHFOpQF
         kye83SvCJ4kiqvf2pkIdA1mYC8TVuyf3qufZ5ADJehTfrNotcLQK/gFzJSzGunmrjP
         agKY8WH/wGo9cA1U89Z4vJCssA5J1uEQprhJ6UgZIlalj8W1PHUhSbtv8d1TYSO3Fh
         YFrJJVbSBuCqxtxw+Xhi3IkL6Y8v/+8C2L4/narhmlRGgIL9uKqwVfUDO0CtENY2yT
         TU8Y1YOZeY80nCiqimETQZSLGOJPmDgeq7IRdmXtwcErOhNlZdbsRh0kPFNsBWrkGG
         d6rJ2uF52qe7A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
Date:   Mon, 27 Jun 2022 23:26:19 +0300
Message-Id: <20220627202620.961350-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627202620.961350-1-ogabbay@kernel.org>
References: <20220627202620.961350-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

User will provide a nonce via the ioctl, and will retrieve
attestation data of the boot from the tpm, generated using given
nonce.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 58 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 52 +++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 51 +++++++++++++++-
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 9f0a24ee5af4..60093088ba43 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -13,6 +13,14 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 
+#if (TPM_PCR_DATA_BUF_SZ != HL_TPM_PCR_DATA_BUF_SZ) || \
+	(TPM_PCR_QUOTE_BUF_SZ != HL_TPM_PCR_QUOTE_BUF_SZ) || \
+	(TPM_SIGNATURE_BUF_SZ != HL_TPM_SIGNATURE_BUF_SZ) || \
+	(TPM_PUB_DATA_BUF_SZ != HL_TPM_PUB_DATA_BUF_SZ) || \
+	(TPM_CERTIFICATE_BUF_SZ != HL_TPM_CERTIFICATE_BUF_SZ)
+#error TPM attestation structures are not aligned
+#endif
+
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
 struct fw_binning_conf {
@@ -525,6 +533,11 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_exists = true;
 	}
 
+	if (err_val & CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL) {
+		dev_err(hdev->dev, "Device boot error - Failed to set threshold for temperature sensor\n");
+		err_exists = true;
+	}
+
 	if (err_val & CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL) {
 		/* Ignore this bit, don't prevent driver loading */
 		dev_dbg(hdev->dev, "device unusable status is set\n");
@@ -2905,3 +2918,48 @@ void hl_fw_set_max_power(struct hl_device *hdev)
 	if (rc)
 		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
 }
+
+static int hl_fw_get_tpm_data(struct hl_device *hdev, u32 packet_id,
+				void *data, u32 size, u32 nonce, u32 timeout)
+{
+	struct cpucp_packet pkt = {};
+	dma_addr_t req_dma_addr;
+	void *req_cpu_addr;
+	int rc;
+
+	req_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, size, &req_dma_addr);
+	if (!data) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for CPU-CP packet %u\n", packet_id);
+		return -ENOMEM;
+	}
+
+	memset(data, 0, size);
+
+	pkt.ctl = cpu_to_le32(packet_id << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(req_dma_addr);
+	pkt.data_max_size = cpu_to_le32(size);
+	pkt.nonce = cpu_to_le32(nonce);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					timeout, NULL);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle CPU-CP pkt %u, error %d\n", packet_id, rc);
+		goto out;
+	}
+
+	memcpy(data, req_cpu_addr, size);
+
+out:
+	hl_cpu_accessible_dma_pool_free(hdev, size, req_cpu_addr);
+
+	return rc;
+}
+
+int hl_fw_get_tpm_info(struct hl_device *hdev, struct cpucp_tpm_attest_info *tpm_info, u32 nonce)
+{
+	return hl_fw_get_tpm_data(hdev, CPUCP_PACKET_TPM_ATTEST_GET, tpm_info,
+					sizeof(struct cpucp_tpm_attest_info), nonce,
+					HL_CPUCP_TPM_INFO_TINEOUT_USEC);
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f61389115c26..4537845658f8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -66,6 +66,7 @@ struct hl_fpriv;
 #define HL_CPUCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_MON_DUMP_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_CPUCP_TPM_INFO_TINEOUT_USEC	10000000 /* 10s */
 
 #define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
 #define HL_FW_COMMS_STATUS_PLDM_POLL_INTERVAL_USEC	1000000 /* 1s */
@@ -3604,6 +3605,7 @@ int hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long *va
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 long hl_fw_get_max_power(struct hl_device *hdev);
 void hl_fw_set_max_power(struct hl_device *hdev);
+int hl_fw_get_tpm_info(struct hl_device *hdev, struct cpucp_tpm_attest_info *tpm_info, u32 nonce);
 int hl_set_voltage(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev, int sensor_index, u32 attr, long value);
 int hl_set_power(struct hl_device *hdev, int sensor_index, u32 attr, long value);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 96e12ab7a924..9db5167978e5 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -660,6 +660,55 @@ static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int tpm_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct cpucp_tpm_attest_info *tpm_info;
+	struct hl_info_tpm *info;
+	u32 max_size = args->return_size;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	tpm_info = kmalloc(sizeof(*tpm_info), GFP_KERNEL);
+	if (!tpm_info)
+		return -ENOMEM;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto free_tpm_info;
+	}
+
+	rc = hl_fw_get_tpm_info(hpriv->hdev, tpm_info, args->tpm_nonce);
+	if (rc)
+		goto free_info;
+
+	info->nonce = le32_to_cpu(tpm_info->nonce);
+	info->pcr_quote_len = le16_to_cpu(tpm_info->pcr_quote_len);
+	info->pub_data_len = le16_to_cpu(tpm_info->pub_data_len);
+	info->certificate_len = le16_to_cpu(tpm_info->certificate_len);
+	info->pcr_num_reg = tpm_info->pcr_num_reg;
+	info->pcr_reg_len = tpm_info->pcr_reg_len;
+	info->quote_sig_len = tpm_info->quote_sig_len;
+	memcpy(&info->pcr_data, &tpm_info->pcr_data, sizeof(info->pcr_data));
+	memcpy(&info->pcr_quote, &tpm_info->pcr_quote, sizeof(info->pcr_quote));
+	memcpy(&info->public_data, &tpm_info->public_data, sizeof(info->public_data));
+	memcpy(&info->certificate, &tpm_info->certificate, sizeof(info->certificate));
+	memcpy(&info->quote_sig, &tpm_info->quote_sig, sizeof(info->quote_sig));
+
+	rc = copy_to_user(out, info,
+				min_t(size_t, max_size, sizeof(*info))) ? -EFAULT : 0;
+
+free_info:
+	kfree(info);
+free_tpm_info:
+	kfree(tpm_info);
+
+	return rc;
+}
+
 static int eventfd_register(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	int rc;
@@ -753,6 +802,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES:
 		return dev_mem_alloc_page_sizes_info(hpriv, args);
 
+	case HL_INFO_TPM:
+		return tpm_info(hpriv, args);
+
 	case HL_INFO_GET_EVENTS:
 		return events_info(hpriv, args);
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 719b2ff80985..a97d9f03915d 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -629,6 +629,13 @@ enum pq_init_status {
  * CPUCP_PACKET_ENGINE_CORE_ASID_SET -
  *       Packet to perform engine core ASID configuration
  *
+ * CPUCP_PACKET_TPM_ATTEST_GET -
+ *       Get the attestaion data that is collected by the Trusted Platform
+ *       device during various stages of the boot sequence. the attestation data
+ *       is also hashed with some unique number (nonce) provided by the host to
+ *       prevent replay attacks. public key and certificate also provided as
+ *       part of the FW response.
+ *
  * CPUCP_PACKET_MONITOR_DUMP_GET -
  *       Get monitors registers dump from the CpuCP kernel.
  *       The CPU will put the registers dump in the a buffer allocated by the driver
@@ -687,7 +694,7 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_RESERVED,			/* not used */
 	CPUCP_PACKET_ENGINE_CORE_ASID_SET,	/* internal */
 	CPUCP_PACKET_RESERVED2,			/* not used */
-	CPUCP_PACKET_RESERVED3,			/* not used */
+	CPUCP_PACKET_TPM_ATTEST_GET,		/* internal */
 	CPUCP_PACKET_RESERVED4,			/* not used */
 	CPUCP_PACKET_RESERVED5,			/* not used */
 	CPUCP_PACKET_MONITOR_DUMP_GET,		/* debugfs */
@@ -783,6 +790,9 @@ struct cpucp_packet {
 		 * result cannot be used to hold general purpose data.
 		 */
 		__le32 status_mask;
+
+		/* random, used once number, for tpm secured packets */
+		__le32 nonce;
 	};
 
 	/* For NIC requests */
@@ -1193,6 +1203,45 @@ enum cpu_reset_status {
 	CPU_RST_STATUS_SOFT_RST_DONE = 1,
 };
 
+#define TPM_PCR_DATA_BUF_SZ	256
+#define TPM_PCR_QUOTE_BUF_SZ	(512 - 2)	/* 2 bytes used for size */
+#define TPM_SIGNATURE_BUF_SZ	(256 - 1)	/* 1 byte used for size */
+#define TPM_PUB_DATA_BUF_SZ	(512 - 2)	/* 2 bytes used for size */
+#define TPM_CERTIFICATE_BUF_SZ	(2048 - 2)	/* 2 bytes used for size */
+
+/*
+ * struct cpucp_tpm_attest_info - attestation data of the boot from the TPM
+ * @pcr_data: raw values of the PCR registers from the TPM
+ * @pcr_num_reg: number of PCR registers in the pcr_data array
+ * @pcr_reg_len: length of each PCR register in the pcr_data array (bytes)
+ * @nonce: number only used once. random number provided by host. this also
+ *	    passed to the quote command as a qualifying data.
+ * @pcr_quote_len: length of the attestation quote data (bytes)
+ * @pcr_quote: attestation data structure (TPM2B_ATTEST) from the TPM
+ * @quote_sig_len: length of the attestation signature (bytes)
+ * @quote_sig: signature structure (TPMT_SIGNATURE) of the attestation data
+ * @pub_data_len: length of the public data (bytes)
+ * @public_data: public key and certificate info from the TPM
+ *		 (outPublic + name + qualifiedName)
+ * @certificate_len: length of the certificate (bytes)
+ * @certificate: certificate for the attestation data, read from the TPM NV mem
+ */
+struct cpucp_tpm_attest_info {
+	__u8 pcr_data[TPM_PCR_DATA_BUF_SZ];
+	__u8 pcr_num_reg;
+	__u8 pcr_reg_len;
+	__le16 pad0;
+	__le32 nonce;
+	__le16 pcr_quote_len;
+	__u8 pcr_quote[TPM_PCR_QUOTE_BUF_SZ];
+	__u8 quote_sig_len;
+	__u8 quote_sig[TPM_SIGNATURE_BUF_SZ];
+	__le16 pub_data_len;
+	__u8 public_data[TPM_PUB_DATA_BUF_SZ];
+	__le16 certificate_len;
+	__u8 certificate[TPM_CERTIFICATE_BUF_SZ];
+};
+
 /*
  * struct dcore_monitor_regs_data - DCORE monitor regs data.
  * the structure follows sync manager block layout. relevant only to Gaudi.
-- 
2.25.1

