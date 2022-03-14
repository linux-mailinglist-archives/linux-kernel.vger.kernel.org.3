Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4424D7AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiCNGLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiCNGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:11:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09B193E5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647238226; x=1678774226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/GTVYDVsmfx7aGuqBitNrTumwZ02qW9XCrsh3G0ASY=;
  b=Gvbop9bP6vGWQYuXJsNurkEpunShY3QeXM9IC2EV/yOufagD6L74YTBd
   Uik7/+Ve4alHXkEWTw2xoPKS09W8j8fxn/7uD4K/NQC1zbqEJxy60AEKG
   e2ooBlk9WCSzpx81SaY1VAKkncN8WyF1GExF53QPGHiWU6plRqcCzvZMk
   nwdeU9ChWwQSSyPQF6x9hAllpTTGzXAGvlITON9i0yrvuoIaPieq87XEV
   V/GTwZZ1YT6N5XuD5CVEQoPw9bZtGDGAi+1pKuzRL8PkwgV/q19lwq1jW
   0nhtV97mDYqPZei5V8p8tQsaevSUW59UVA/Syr/zYXgWmUne7YxeaCQET
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319169407"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="319169407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 23:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="818682897"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2022 23:10:24 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2 2/3] firmware: stratix10-svc: add new polling command for FCS
Date:   Mon, 14 Mar 2022 22:10:15 +0800
Message-Id: <20220314141015.2165254-1-tien.sung.ang@intel.com>
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
 drivers/firmware/stratix10-svc.c              | 38 ++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h  | 25 +++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  5 +++
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 17757b58a8e5..f6871aa66cbd 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -248,6 +248,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 {
 	struct arm_smccc_res res;
 	int count_in_sec;
+	unsigned long a0, a1, a2;
 
 	cb_data->kaddr1 = NULL;
 	cb_data->kaddr2 = NULL;
@@ -256,24 +257,42 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 
 	pr_debug("%s: polling config status\n", __func__);
 
+	a0 = INTEL_SIP_SMC_FPGA_CONFIG_ISDONE;
+	a1 = (unsigned long)p_data->paddr;
+	a2 = 0;
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
+		cb_data->kaddr1 = (res.a1) ?
+				  svc_pa_to_va(res.a1) : NULL;
+		cb_data->kaddr2 = &res.a2;
+	} else {
+		pr_err("%s: poll status error\n", __func__);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->status = BIT(SVC_STATUS_ERROR);
+	}
 
 	p_data->chan->scl->receive_cb(p_data->chan->scl, cb_data);
 }
@@ -298,6 +317,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RECONFIG:
 	case COMMAND_RSU_UPDATE:
 	case COMMAND_RSU_NOTIFY:
+	case COMMAND_POLL_SERVICE_STATUS:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -424,6 +444,13 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		/* for polling */
+		case COMMAND_POLL_SERVICE_STATUS:
+			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = 0;
+			break;
+
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -464,6 +491,7 @@ static int svc_normal_to_secure_thread(void *data)
 							  pdata, cbdata);
 				break;
 			case COMMAND_RECONFIG_STATUS:
+			case COMMAND_POLL_SERVICE_STATUS:
 				svc_thread_cmd_config_status(ctrl,
 							     pdata, cbdata);
 				break;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index c3e5ab014caf..579efb14cfb4 100644
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
@@ -404,3 +402,26 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
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
+ * a1: the physical address for secure firmware to put output data
+ * a2: size
+ * a3-a7: not used
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR,
+ *     INTEL_SIP_SMC_REJECTED or INTEL_SIP_SMC_STATUS_BUSY
+ * a1: physical address for the output daat
+ * a2: output data size
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

