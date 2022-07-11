Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD19570D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiGKWcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGKWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368652E65
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B5D61210
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797ADC341CB;
        Mon, 11 Jul 2022 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578713;
        bh=CWWDMw8Ema4+wJZBxwpQqVwfxg0gwQ+fugl43TqcK/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ3z8bZ9IFdQSPOixRXf29BP0hRBsilOzV3yzwxm3slI/hzIJk24nY/1ovB7kWTxY
         VlMp3Y5q3Nqi5FsHf47Q2ma65N9Sf7lhvSyZTVQ/rfOqBKFscNfiaDpQ3EC30A9FKa
         Mh9//OVp2fFpMfpKdYSNfS6MmMowEc2ZCbSuyrkR4HtuooJ6WsFUnSflzty8wpP+SF
         wmjnQ4JkX7Mgj5hXCQ2A9JjEeiZrEm/1QoRcCMuhxdKYPE52JLtyyZgsJd9VZ+zRTq
         BSS2WkGyfDcKVAR4qwZpp8PkhGt0TvfJacc0aIzzg1FeSOR0yWH4fZvBbf9662vg4q
         FiYuh4xCd8X+A==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Kah Jing Lee <kah.jing.lee@intel.com>,
        Radu Bacrau <radu.bacrau@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 5/6] firmware: stratix10-svc: extend svc to support RSU feature
Date:   Mon, 11 Jul 2022 17:31:39 -0500
Message-Id: <20220711223140.2307945-5-dinguyen@kernel.org>
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

From: Kah Jing Lee <kah.jing.lee@intel.com>

Extend Intel Stratix10 service layer driver to support new RSU
DCMF status reporting.

The status of each DCMF is reported. The currently used DCMF is used as
reference, while the other three are compared against it to determine if
they are corrupted.

DCMF = Decision Configuration Management Firmware
RSU = Remote System Update

Signed-off-by: Radu Bacrau <radu.bacrau@intel.com>
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c              | 20 +++++++++++-------
 include/linux/firmware/intel/stratix10-smc.h  | 21 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  4 ++++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 1cf9f4f47b94..7fea94fe2ca0 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -338,6 +338,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_RSU_RETRY:
 	case COMMAND_RSU_MAX_RETRY:
+	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
@@ -518,7 +519,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = (unsigned long)pdata->size;
 			break;
-
+		case COMMAND_RSU_DCMF_STATUS:
+			a0 = INTEL_SIP_SMC_RSU_DCMF_STATUS;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -596,8 +601,9 @@ static int svc_normal_to_secure_thread(void *data)
 			pr_err("%s: STATUS_ERROR\n", __func__);
 			cbdata->status = BIT(SVC_STATUS_ERROR);
 			cbdata->kaddr1 = &res.a1;
-			cbdata->kaddr2 = NULL;
-			cbdata->kaddr3 = NULL;
+			cbdata->kaddr2 = (res.a2) ?
+				svc_pa_to_va(res.a2) : NULL;
+			cbdata->kaddr3 = (res.a3) ? &res.a3 : NULL;
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
 			break;
 		default:
@@ -605,12 +611,10 @@ static int svc_normal_to_secure_thread(void *data)
 
 			/*
 			 * be compatible with older version firmware which
-			 * doesn't support RSU notify or retry
+			 * doesn't support newer RSU commands
 			 */
-			if ((pdata->command == COMMAND_RSU_RETRY) ||
-			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
-			    (pdata->command == COMMAND_RSU_NOTIFY) ||
-			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
+			if ((pdata->command != COMMAND_RSU_UPDATE) &&
+				(pdata->command != COMMAND_RSU_STATUS)) {
 				cbdata->status =
 					BIT(SVC_STATUS_NO_SUPPORT);
 				cbdata->kaddr1 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 8c198984a47c..8fc4aa450517 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -403,6 +403,27 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_MAX_RETRY \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
 
+/**
+ * Request INTEL_SIP_SMC_RSU_DCMF_STATUS
+ *
+ * Sync call used by service driver at EL1 to query DCMF status from FW
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_DCMF_STATUS
+ * a1-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 dcmf3 | dcmf2 | dcmf1 | dcmf0
+ *
+ * Or
+ *
+ * a0 INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_DCMF_STATUS 20
+#define INTEL_SIP_SMC_RSU_DCMF_STATUS \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_DCMF_STATUS)
+
 /**
  * Request INTEL_SIP_SMC_SERVICE_COMPLETED
  * Sync call to check if the secure world have completed service request
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 677720792259..82a20e62f15f 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -114,6 +114,9 @@ struct stratix10_svc_chan;
  * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
  * @COMMAND_FCS_REQUEST_SERVICE: request validation of image from firmware,
  * return status is SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM
  *
@@ -146,6 +149,7 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_RETRY,
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
+	COMMAND_RSU_DCMF_STATUS,
 	COMMAND_FIRMWARE_VERSION,
 	/* for FCS */
 	COMMAND_FCS_REQUEST_SERVICE = 20,
-- 
2.25.1

