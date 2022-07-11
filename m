Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2198570D63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiGKWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5952E72
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D7AB815F3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD4BC341C8;
        Mon, 11 Jul 2022 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578710;
        bh=cLXTxU2gelvkFF4Gn5e4UC2mcdZnC0WgJshS0cSrKsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1qgkruvSFck6qHRfln1S79eLbzhhAebqNKHHqDmbR32MddPCGMcjhEycZ18dxneF
         LzG6ik8TVTSKSczxJHVrc2B0RQmYy2fLahRt0WslDKWbCORvoDS6rFDrURNtOb+dV+
         Wqu3kOcdp6fuDI16v0yzyDkH5l0lvhJ3dpKZyHUudwnulw6X/T8D74tpkoWMs0iGhB
         SGG6Aq9m745D7wDYDdZYARGmg80sPc7SeDknoGCzFGo/p0FK3IoCSQqYK+0olD4wf0
         8lNXwRnIqmLWz/7ohbq1FTIl6p9PUMCssCRNJ8CLmiNV+/OuZ5ghpOz4bonfMsv8tc
         AqUpr3JAezYcA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 2/6] firmware: stratix10-svc: add FCS polling command
Date:   Mon, 11 Jul 2022 17:31:36 -0500
Message-Id: <20220711223140.2307945-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711223140.2307945-1-dinguyen@kernel.org>
References: <20220711223140.2307945-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c              | 42 ++++++++++++++++---
 include/linux/firmware/intel/stratix10-smc.h  | 25 +++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  5 +++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1fe748c047df..439a4bdf8207 100644
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
@@ -430,6 +453,14 @@ static int svc_normal_to_secure_thread(void *data)
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
@@ -470,6 +501,7 @@ static int svc_normal_to_secure_thread(void *data)
 							  pdata, cbdata);
 				break;
 			case COMMAND_RECONFIG_STATUS:
+			case COMMAND_POLL_SERVICE_STATUS:
 				svc_thread_cmd_config_status(ctrl,
 							     pdata, cbdata);
 				break;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index aad497a9ad8b..0de104009566 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -403,6 +403,31 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
 
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
 /**
  * Request INTEL_SIP_SMC_FIRMWARE_VERSION
  *
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 24121f8e0d7c..5d0e814e0c41 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -106,6 +106,9 @@ struct stratix10_svc_chan;
  * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_POLL_SERVICE_STATUS: poll if the service request is complete,
+ * return statis is SVC_STATUS_OK, SVC_STATUS_ERROR or SVC_STATUS_BUSY
+ *
  * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
@@ -122,6 +125,8 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
 	COMMAND_FIRMWARE_VERSION,
+	/* for general status poll */
+	COMMAND_POLL_SERVICE_STATUS = 40,
 };
 
 /**
-- 
2.25.1

