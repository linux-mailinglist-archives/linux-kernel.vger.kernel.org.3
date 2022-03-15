Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C64D92CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiCODGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiCODGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:06:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A44831E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647313510; x=1678849510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wsMKIkbjb+jwBLMPXVcgxoSbz3jW3P6F1/aD9d+UBWU=;
  b=fQe/fZWCO+jKD4EBPCDI5QOolbtWRgV1/tlNHl9hrlKze3CCryFBoVSA
   rmCK4zQvDHg2O8/rXRaNN62DG+iqkvRatvdgXCmqz6JNk1SCuLirkcjMV
   rii0SFmcpjaxgzDlapYFJ+mxeu4gfG8DJ/He/GGXv0EW2QYo/fnAfIscM
   fY0dzyTNP2k/SAr6OahKk2PfDAhaOrmsM2C3ymC4xjDhblzOqgW9Ol1/8
   X1uxi5yfCHWIHOg9TiHqzTfUXvbnPBReWtQBBPeQuziAQETD+rOO0QSxj
   S4aWfHGbPEjGpae6/xz5ESmaz3t+CiBDXwyLbsLIOXPIM84efpqCF64LJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342626135"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="342626135"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 20:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540248715"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga007.jf.intel.com with ESMTP; 14 Mar 2022 20:05:05 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v3 2/3] firmware: stratix10-svc: add FCS polling command
Date:   Tue, 15 Mar 2022 19:04:57 +0800
Message-Id: <20220315110457.2871548-1-tien.sung.ang@intel.com>
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

Introduce a new SMC command INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED
that polls if a previous asynchronous command was completed. This
SMC command is used by the new FPGA Crypto Service (FCS).
A basic example is that the FCS sends an AES data encryption
call to the secure device manager(SDM) and waits for the completion
of the operation by continuously polling the results with the new
command.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 42 ++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h  | 29 ++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  5 +++
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 17757b58a8e5..cb5cd9f42177 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -248,6 +248,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 {
 	struct arm_smccc_res res;
 	int count_in_sec;
+	unsigned long a0, a1, a2;
 
 	cb_data->kaddr1 = NULL;
 	cb_data->kaddr2 = NULL;
@@ -256,24 +257,45 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 
 	pr_debug("%s: polling config status\n", __func__);
 
+	a0 = INTEL_SIP_SMC_FPGA_CONFIG_ISDONE;
+	a1 = (unsigned long)p_data->paddr;
+	a2 = (unsigned long)p_data->size;
+
+	if (p_data->command == COMMAND_POLL_SERVICE_STATUS)
+		a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
+
 	count_in_sec = FPGA_CONFIG_STATUS_TIMEOUT_SEC;
 	while (count_in_sec) {
-		ctrl->invoke_fn(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE,
-				0, 0, 0, 0, 0, 0, 0, &res);
+		ctrl->invoke_fn(a0, a1, a2, 0, 0, 0, 0, 0, &res);
 		if ((res.a0 == INTEL_SIP_SMC_STATUS_OK) ||
-		    (res.a0 == INTEL_SIP_SMC_STATUS_ERROR))
+		    (res.a0 == INTEL_SIP_SMC_STATUS_ERROR) ||
+		    (res.a0 == INTEL_SIP_SMC_STATUS_REJECTED))
 			break;
 
 		/*
-		 * configuration is still in progress, wait one second then
+		 * request is still in progress, wait one second then
 		 * poll again
 		 */
 		msleep(1000);
 		count_in_sec--;
 	}
 
-	if (res.a0 == INTEL_SIP_SMC_STATUS_OK && count_in_sec)
+	if (!count_in_sec) {
+		pr_err("%s: poll status timeout\n", __func__);
+		cb_data->status = BIT(SVC_STATUS_BUSY);
+	} else if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
 		cb_data->status = BIT(SVC_STATUS_COMPLETED);
+		cb_data->kaddr2 = (res.a2) ?
+				  svc_pa_to_va(res.a2) : NULL;
+		cb_data->kaddr3 = (res.a3) ? &res.a3 : NULL;
+	} else {
+		pr_err("%s: poll status error\n", __func__);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->kaddr2 = (res.a2) ?
+				  svc_pa_to_va(res.a2) : NULL;
+		cb_data->kaddr3 = (res.a3) ? &res.a3 : NULL;
+		cb_data->status = BIT(SVC_STATUS_ERROR);
+	}
 
 	p_data->chan->scl->receive_cb(p_data->chan->scl, cb_data);
 }
@@ -298,6 +320,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RECONFIG:
 	case COMMAND_RSU_UPDATE:
 	case COMMAND_RSU_NOTIFY:
+	case COMMAND_POLL_SERVICE_STATUS:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -424,6 +447,14 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		/* for polling */
+		case COMMAND_POLL_SERVICE_STATUS:
+			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+
+			break;
+
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -464,6 +495,7 @@ static int svc_normal_to_secure_thread(void *data)
 							  pdata, cbdata);
 				break;
 			case COMMAND_RECONFIG_STATUS:
+			case COMMAND_POLL_SERVICE_STATUS:
 				svc_thread_cmd_config_status(ctrl,
 							     pdata, cbdata);
 				break;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index c3e5ab014caf..703ed8a58c69 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_ECC_DBE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
 
-#endif
-
 /**
  * Request INTEL_SIP_SMC_RSU_NOTIFY
  *
@@ -404,3 +402,30 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
+
+/**
+ * Request INTEL_SIP_SMC_SERVICE_COMPLETED
+ * Sync call to check if the secure world have completed service request
+ * or not.
+ *
+ * Call register usage:
+ * a0: INTEL_SIP_SMC_SERVICE_COMPLETED
+ * a1: this register is optional. If used, it is the physical address for
+ *     secure firmware to put output data
+ * a2: this register is optional. If used, it is the size of output data
+ * a3-a7: not used
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR,
+ *     INTEL_SIP_SMC_REJECTED or INTEL_SIP_SMC_STATUS_BUSY
+ * a1: mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2: physical address containing the process info
+ *     for FCS certificate -- the data contains the certificate status
+ *     for FCS cryption -- the data contains the actual data size FW processes
+ * a3: output data size
+ */
+#define INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED 30
+#define INTEL_SIP_SMC_SERVICE_COMPLETED \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED)
+
+#endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 468490590f85..82e8c9336cf4 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -104,6 +104,9 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_POLL_SERVICE_STATUS: poll if the service request is complete,
+ * return statis is SVC_STATUS_OK, SVC_STATUS_ERROR or SVC_STATUS_BUSY
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -117,6 +120,8 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_RETRY,
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
+	/* for general status poll */
+	COMMAND_POLL_SERVICE_STATUS = 40,
 };
 
 /**
-- 
2.25.1

