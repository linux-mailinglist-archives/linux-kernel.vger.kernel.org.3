Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41C4D7958
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiCNC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiCNC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:29:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C83117D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224904; x=1678760904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J3EyN5CmsHDtGv3cA2zqDYKsnnV6QmN09s4D6EwjkII=;
  b=ZdAn1lvvRinYLPXOCi8CKi98smaqiC3JDe04sePfJ9TXjrpVzFKbfHHz
   GTiYEFA/wKVIK0fmH47Bz3GzzkRhwRxXOM6u99bp4c0UyMwfk3G/6Z9xW
   8d/mqnwGVk1wHVx/Sjx6DMk1gR0su5gdlCXySwm2+MwpC6Hf68nh9/jzj
   8+3/oI41suqYXxBgw9jSYpr9Ib6s+ipS1OsbKNaOURcEEZXDsG5pj8Wkm
   2Pae6SBM/A/El4fkd1XtGjv5dmh3/F3mn/vuZ5A39BQWMWCZUngLphgaP
   T6d5MZw8QAE3aS8Gc8wU4la3acBA5nOP3EbMpEXkiKBNrU87XcZT1dqFS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236524028"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="236524028"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="713543929"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 19:28:20 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 3/3] firmware: stratix10-svc: add new FCS commands
Date:   Mon, 14 Mar 2022 18:28:07 +0800
Message-Id: <20220314102807.1746893-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Extending the fpga svc driver to support 6 new FPGA Crypto
Service(FCS) commands.
We are adding FCS SDOS data encryption and decryption,
random number generator, image validation request,
reading the data provision and certificate validation.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              |  92 +++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 114 +++++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  41 ++++++-
 3 files changed, 238 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 59dfc997684c..55b3078b9aef 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -99,8 +99,10 @@ struct stratix10_svc_data_mem {
 /**
  * struct stratix10_svc_data - service data structure
  * @chan: service channel
- * @paddr: playload physical address
- * @size: playload size
+ * @paddr: physical address of to be processed payload
+ * @size: to be processed playload size
+ * @paddr_output: physical address of processed payload
+ * @size_output: processed payload size
  * @command: service command requested by client
  * @flag: configuration type (full or partial)
  * @arg: args to be passed via registers and not physically mapped buffers
@@ -111,6 +113,8 @@ struct stratix10_svc_data {
 	struct stratix10_svc_chan *chan;
 	phys_addr_t paddr;
 	size_t size;
+	phys_addr_t paddr_output;
+	size_t size_output;
 	u32 command;
 	u32 flag;
 	u64 arg[3];
@@ -317,6 +321,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RECONFIG:
 	case COMMAND_RSU_UPDATE:
 	case COMMAND_RSU_NOTIFY:
+	case COMMAND_FCS_REQUEST_SERVICE:
+	case COMMAND_FCS_SEND_CERTIFICATE:
 	case COMMAND_POLL_SERVICE_STATUS:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
@@ -336,6 +342,15 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr1 = &res.a1;
 		cb_data->kaddr2 = &res.a2;
 		break;
+	case COMMAND_FCS_RANDOM_NUMBER_GEN:
+	case COMMAND_FCS_DATA_ENCRYPTION:
+	case COMMAND_FCS_DATA_DECRYPTION:
+	case COMMAND_FCS_GET_PROVISION_DATA:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->kaddr2 = svc_pa_to_va(res.a2);
+		cb_data->kaddr3 = &res.a3;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -362,7 +377,7 @@ static int svc_normal_to_secure_thread(void *data)
 	struct stratix10_svc_data *pdata;
 	struct stratix10_svc_cb_data *cbdata;
 	struct arm_smccc_res res;
-	unsigned long a0, a1, a2;
+	unsigned long a0, a1, a2, a3, a4, a5;
 	int ret_fifo = 0;
 
 	pdata =  kmalloc(sizeof(*pdata), GFP_KERNEL);
@@ -379,6 +394,9 @@ static int svc_normal_to_secure_thread(void *data)
 	a0 = INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK;
 	a1 = 0;
 	a2 = 0;
+	a3 = 0;
+	a4 = 0;
+	a5 = 0;
 
 	pr_debug("smc_hvc_shm_thread is running\n");
 
@@ -444,6 +462,45 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+
+		/* for FCS */
+		case COMMAND_FCS_DATA_ENCRYPTION:
+			a0 = INTEL_SIP_SMC_FCS_CRYPTION;
+			a1 = 1;
+			a2 = (unsigned long)pdata->paddr;
+			a3 = (unsigned long)pdata->size;
+			a4 = (unsigned long)pdata->paddr_output;
+			a5 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_DATA_DECRYPTION:
+			a0 = INTEL_SIP_SMC_FCS_CRYPTION;
+			a1 = 0;
+			a2 = (unsigned long)pdata->paddr;
+			a3 = (unsigned long)pdata->size;
+			a4 = (unsigned long)pdata->paddr_output;
+			a5 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_RANDOM_NUMBER_GEN:
+			a0 = INTEL_SIP_SMC_FCS_RANDOM_NUMBER;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			break;
+		case COMMAND_FCS_REQUEST_SERVICE:
+			a0 = INTEL_SIP_SMC_FCS_SERVICE_REQUEST;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			break;
+		case COMMAND_FCS_SEND_CERTIFICATE:
+			a0 = INTEL_SIP_SMC_FCS_SEND_CERTIFICATE;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			break;
+		case COMMAND_FCS_GET_PROVISION_DATA:
+			a0 = INTEL_SIP_SMC_FCS_GET_PROVISION_DATA;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			break;
+
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -502,6 +559,22 @@ static int svc_normal_to_secure_thread(void *data)
 			break;
 		case INTEL_SIP_SMC_STATUS_REJECTED:
 			pr_debug("%s: STATUS_REJECTED\n", __func__);
+			/* for FCS */
+			switch (pdata->command) {
+			case COMMAND_FCS_REQUEST_SERVICE:
+			case COMMAND_FCS_SEND_CERTIFICATE:
+			case COMMAND_FCS_GET_PROVISION_DATA:
+			case COMMAND_FCS_DATA_ENCRYPTION:
+			case COMMAND_FCS_DATA_DECRYPTION:
+			case COMMAND_FCS_RANDOM_NUMBER_GEN:
+				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
+				cbdata->kaddr1 = NULL;
+				cbdata->kaddr2 = NULL;
+				cbdata->kaddr3 = NULL;
+				pdata->chan->scl->receive_cb(pdata->chan->scl,
+							     cbdata);
+				break;
+			}
 			break;
 		case INTEL_SIP_SMC_STATUS_ERROR:
 		case INTEL_SIP_SMC_RSU_ERROR:
@@ -875,15 +948,25 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
+				p_data->size = p_msg->payload_length;
 				break;
 			}
+		if (p_msg->payload_output) {
+			list_for_each_entry(p_mem, &svc_data_mem, node)
+				if (p_mem->vaddr == p_msg->payload_output) {
+					p_data->paddr_output =
+						p_mem->paddr;
+					p_data->size_output =
+						p_msg->payload_length_output;
+					break;
+				}
+		}
 	}
 
 	p_data->command = p_msg->command;
 	p_data->arg[0] = p_msg->arg[0];
 	p_data->arg[1] = p_msg->arg[1];
 	p_data->arg[2] = p_msg->arg[2];
-	p_data->size = p_msg->payload_length;
 	p_data->chan = chan;
 	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
 	       (unsigned int)p_data->paddr, p_data->command,
@@ -979,6 +1062,7 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 			break;
 		}
 
+	memset(kaddr, 0, size);
 	gen_pool_free(chan->ctrl->genpool, (unsigned long)kaddr, size);
 	pmem->vaddr = NULL;
 	list_del(&pmem->node);
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 579efb14cfb4..548bbf362a3a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -403,7 +403,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
 
-/**
  * Request INTEL_SIP_SMC_SERVICE_COMPLETED
  * Sync call to check if the secure world have completed service request
  * or not.
@@ -424,4 +423,117 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_SERVICE_COMPLETED \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED)
 
+/**
+ * SMC call protocol for FPGA Crypto Service (FCS)
+ * FUNCID starts from 90
+ */
+
+/**
+ * Request INTEL_SIP_SMC_FCS_RANDOM_NUMBER
+ *
+ * Sync call used to query the random number generated by the firmware
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_RANDOM_NUMBER
+ * a1 the physical address for firmware to write generated random data
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FCS_ERROR or
+ *      INTEL_SIP_SMC_FCS_REJECTED
+ * a1 the physical address of generated random number
+ * a2 the size
+ * a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_RANDOM_NUMBER 90
+#define INTEL_SIP_SMC_FCS_RANDOM_NUMBER \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_RANDOM_NUMBER)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CRYPTION
+ * Async call for data encryption and HMAC signature generation, or for
+ * data decryption and HMAC verification.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CRYPTION
+ * a1 cryption mode (1 for encryption and 0 for decryption)
+ * a2 physical address which stores to be encrypted or decrypted data
+ * a3 input data size
+ * a4 physical address which will hold the encrypted or decrypted output data
+ * a5 output data size
+ * a6-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *      INTEL_SIP_SMC_STATUS_REJECTED
+ * a1 mbox return code
+ * a2 physical address of output data which stores encrypted or decrypted data
+ * a3 output data size
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CRYPTION 91
+#define INTEL_SIP_SMC_FCS_CRYPTION \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CRYPTION)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_SERVICE_REQUEST
+ * Async call for authentication service of HPS software
+ *
+ * Sync call used by service driver at EL1 to query DCMF (Decision
+ * Configuration Management Firmware) version from FW
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_SERVICE_REQUEST
+ * a1 the physical address of data block
+ * a2 size of data block
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_ERROR or
+ *      INTEL_SIP_SMC_REJECTED
+ * a1-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_SERVICE_REQUEST 92
+#define INTEL_SIP_SMC_FCS_SERVICE_REQUEST \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_SERVICE_REQUEST)
+
+/**
+ * Request INTEL_SIP_SMC_FUNCID_FCS_SEND_CERTIFICATE
+ * Sync call to send a signed certificate
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_SEND_CERTIFICATE
+ * a1 the physical address of CERTIFICATE block
+ * a2 size of data block
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FCS_ERROR or
+ *      INTEL_SIP_SMC_FCS_REJECTED
+ * a1-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_SEND_CERTIFICATE 93
+#define INTEL_SIP_SMC_FCS_SEND_CERTIFICATE \
+	INTEL_SIP_SMC_STD_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_SEND_CERTIFICATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_PROVISION_DATA
+ * Sync call to dump all the fuses and key hashes
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_PROVISION_DATA
+ * a1 the physical address for firmware to write structure of fuse and
+ *    key hashes
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FCS_ERROR or
+ *      INTEL_SIP_SMC_FCS_REJECTED
+ * a1 physical address for the structure of fuse and key hashes
+ * a2 the size of structure
+ * a3 not used
+ *
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA 94
+#define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 82e8c9336cf4..1010f14d927b 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -49,8 +49,8 @@
 #define SVC_STATUS_BUSY			4
 #define SVC_STATUS_ERROR		5
 #define SVC_STATUS_NO_SUPPORT		6
-
-/*
+#define SVC_STATUS_INVALID_PARAM	7
+/**
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
@@ -66,6 +66,8 @@
 #define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
 #define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
+#define SVC_FCS_REQUEST_TIMEOUT_MS		2000
+#define SVC_COMPLETED_TIMEOUT_MS		30000
 
 struct stratix10_svc_chan;
 
@@ -105,21 +107,48 @@ struct stratix10_svc_chan;
  * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_FCS_REQUEST_SERVICE: request validation of image from firmware,
+ * return status is SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM
+ *
+ * @COMMAND_FCS_SEND_CERTIFICATE: send a certificate, return status is
+ * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_GET_PROVISION_DATA: read the provisioning data, return status is
+ * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_DATA_ENCRYPTION: encrypt the data, return status is
+ * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_DATA_DECRYPTION: decrypt the data, return status is
+ * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
+ * is SVC_STATUS_OK, SVC_STATUS_ERROR
+ *
  * @COMMAND_POLL_SERVICE_STATUS: poll if the service request is complete,
  * return statis is SVC_STATUS_OK, SVC_STATUS_ERROR or SVC_STATUS_BUSY
  */
 enum stratix10_svc_command_code {
+	/* for FPGA */
 	COMMAND_NOOP = 0,
 	COMMAND_RECONFIG,
 	COMMAND_RECONFIG_DATA_SUBMIT,
 	COMMAND_RECONFIG_DATA_CLAIM,
 	COMMAND_RECONFIG_STATUS,
-	COMMAND_RSU_STATUS,
+	/* for RSU */
+	COMMAND_RSU_STATUS = 10,
 	COMMAND_RSU_UPDATE,
 	COMMAND_RSU_NOTIFY,
 	COMMAND_RSU_RETRY,
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
+	/* for FCS */
+	COMMAND_FCS_REQUEST_SERVICE = 20,
+	COMMAND_FCS_SEND_CERTIFICATE,
+	COMMAND_FCS_GET_PROVISION_DATA,
+	COMMAND_FCS_DATA_ENCRYPTION,
+	COMMAND_FCS_DATA_DECRYPTION,
+	COMMAND_FCS_RANDOM_NUMBER_GEN,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
 };
@@ -127,13 +156,17 @@ enum stratix10_svc_command_code {
 /**
  * struct stratix10_svc_client_msg - message sent by client to service
  * @payload: starting address of data need be processed
- * @payload_length: data size in bytes
+ * @payload_length: to be processed data size in bytes
+ * @payload_output: starting address of processed data
+ * @payload_length_output: processed data size in bytes
  * @command: service command
  * @arg: args to be passed via registers and not physically mapped buffers
  */
 struct stratix10_svc_client_msg {
 	void *payload;
 	size_t payload_length;
+	void *payload_output;
+	size_t payload_length_output;
 	enum stratix10_svc_command_code command;
 	u64 arg[3];
 };
-- 
2.25.1

