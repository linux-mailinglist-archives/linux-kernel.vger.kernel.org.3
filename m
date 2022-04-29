Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFB514536
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbiD2JTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355713AbiD2JTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:19:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E9A5E91
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651223792; x=1682759792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xybt8AugoPhkYIM+CjYQCGzF3Xeoot+D4yzJuWGb0mY=;
  b=Yt1rBll5YWw8DpgmTlel54b8wC3UXH8Py2m20fVGUulGQe/5jZx9N3rh
   9egHwaqvl1WkJuyqxw+4n1n2+jUye7vk3HL6YTjShVTE6wKMJk918Vcu+
   41/QhPNFjTcThWqDMEyDM3UIY6iPN4x77HGPr7bMx/c0cFSneV8EmbuUq
   XTRyyQGAFFmHhT/TITItbPNTkHj0KgcACnJbfL+FvTdiuTkofblKKzeBI
   1u681DhLgGGkGGhi0UbHb13TWNrpcuwcJ9w9Edryxo5VlfrVM7240QMLq
   6ID+fCoB010VDoX5762Rb7IoT8ecWi0Ge3MGM80UBunAm35TVfR1ZkNfd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="264174761"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="264174761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 02:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="542306400"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2022 02:16:30 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] firmware: stratix10-svc: To support a command ATF Get Version
Date:   Fri, 29 Apr 2022 17:16:15 +0800
Message-Id: <20220429091615.1064585-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

We are to support a new SMC Command of hexadecimal 0x200 that returns
the ATF Firmware major and minor version.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c                | 10 ++++++++++
 include/linux/firmware/intel/stratix10-smc.h    | 17 +++++++++++++++++
 .../linux/firmware/intel/stratix10-svc-client.h |  5 +++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 8177a0fae11d..999ffa83e8b3 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -310,6 +310,11 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
+	case COMMAND_SMC_SVC_VERSION:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->kaddr2 = &res.a2;
+		break;
 	case COMMAND_RSU_DCMF_VERSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
@@ -428,6 +433,11 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_SMC_SVC_VERSION:
+			a0 = INTEL_SIP_SMC_SVC_VERSION;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index aad497a9ad8b..d44605d2aa71 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -420,4 +420,21 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FIRMWARE_VERSION \
         INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
 
+/**
+ * Request INTEL_SIP_SMC_SVC_VERSION
+ *
+ * Sync call used to query the SIP SMC API Version
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_SVC_VERSION
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Major
+ * a2 Minor
+ */
+#define INTEL_SIP_SMC_SVC_FUNCID_VERSION 512
+#define INTEL_SIP_SMC_SVC_VERSION \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_SVC_FUNCID_VERSION)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 18c1841fdb1f..0dfd4672b346 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -107,6 +107,9 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_SMC_SVC_VERSION: Non-mailbox SMC SVC API Version,
+ * return status is SVC_STATUS_OK
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -121,6 +124,8 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_MAX_RETRY,
 	COMMAND_RSU_DCMF_VERSION,
 	COMMAND_FIRMWARE_VERSION,
+	/* Non-mailbox SMC Call */
+	COMMAND_SMC_SVC_VERSION = 200
 };
 
 /**
-- 
2.25.1

