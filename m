Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46E4ED4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiCaHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiCaHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:45:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F608F4625
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648712612; x=1680248612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKSqajc5w+VnfCzfjS7pP1UanKUBMj0RJmyzjG22UUA=;
  b=fGivf1eeL5axLhw/NLp/aE2T7lPVaAOtnTyoRxRNdgrr6YKcVZu4bEU8
   QukkDpYLRGmTB8P2SPjE75yoos8AA8vdO0UQ6iKKewUUryHMhM+yRsNvg
   GUj+yG8N0QEXRLb1AUwviN2UYRCFF+TzPGv9g4K0GOHjkqwz+wnQdOoEf
   f0ufbagv8dPz9K+R76tCtOqR8SIeZANSL8Msg9wIBGNehJzDZCv/ZtMEZ
   /jskxX1OtqyBva2q/2A5So1lDvTXtuGpH5mFMLqGWPCLuWW+ru311aNkp
   s+0rnBA5vwC8gzVUjf/XRHeiiR6gCnGy0UBTlU2dZ2jtxm5EVRq8V0J1s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346185090"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="346185090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566240236"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2022 00:43:29 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 1/2] firmware: stratix10-svc: extend svc to support RSU feature
Date:   Thu, 31 Mar 2022 23:42:38 +0800
Message-Id: <20220331154237.4158001-2-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4ab174c2-8772-d543-9784-31b4660efd82@kernel.org>
References: <4ab174c2-8772-d543-9784-31b4660efd82@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/firmware/stratix10-svc.c              | 19 ++++++++++-------
 include/linux/firmware/intel/stratix10-smc.h  | 21 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++++++-
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 8177a0fae11d..0f46fb323066 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		break;
 	case COMMAND_RSU_RETRY:
 	case COMMAND_RSU_MAX_RETRY:
+	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
@@ -428,6 +429,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_RSU_DCMF_STATUS:
+			a0 = INTEL_SIP_SMC_RSU_DCMF_STATUS;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -484,8 +490,9 @@ static int svc_normal_to_secure_thread(void *data)
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
@@ -493,12 +500,10 @@ static int svc_normal_to_secure_thread(void *data)
 
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
index aad497a9ad8b..044319be6c45 100644
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
  * Request INTEL_SIP_SMC_FIRMWARE_VERSION
  *
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 18c1841fdb1f..cb76ed792912 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -107,6 +107,9 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -114,12 +117,14 @@ enum stratix10_svc_command_code {
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
+	COMMAND_RSU_DCMF_STATUS,
 	COMMAND_FIRMWARE_VERSION,
 };
 
-- 
2.25.1

