Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB2570D60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiGKWcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiGKWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B38545CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7166114C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BC0C341CE;
        Mon, 11 Jul 2022 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578713;
        bh=jbM3K+afyQ+gzWof+Lqt1sl5FovGH7PC69g4VIwVwqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSqjSwZIpNCp6P9KxrX1n26ARG33wMglzckVDG62ry/n/om9sH3YPCBYMqtEbZcdF
         N/u+3dOK9w1icIFviOGA+/SEV+DBirexDYwmqbMgvpim9NXDL96ifrHA8lW97BezQx
         s0vhkiSvglBjUWsNqiS+E3AYLvB6wrtdK2WXhiM7xkrFnbcGRGZcYmckaAfFOohm1j
         ZRj4oxPT3HX+ySINVbV+pbwk/9ZxVMl9vEoHMBYYKXmwgzOOkrnpdc5PBaEEe2q5mg
         fM/mRx/Ow5c/+81m4buas2BxZD1zty/PdrKe4fHe4ZOrfjvk0Hcr4/n9bwhU0Xey8a
         9XBsbVs0/VikQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 6/6] firmware: stratix10-svc: To support a command ATF Get Version
Date:   Mon, 11 Jul 2022 17:31:40 -0500
Message-Id: <20220711223140.2307945-6-dinguyen@kernel.org>
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

We are to support a new SMC Command of hexadecimal 0x200 that returns
the ATF Firmware major and minor version.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c               | 10 ++++++++++
 include/linux/firmware/intel/stratix10-smc.h   | 18 ++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h      |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 7fea94fe2ca0..b4081f4d88a3 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -343,6 +343,11 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
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
@@ -524,6 +529,11 @@ static int svc_normal_to_secure_thread(void *data)
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
index 8fc4aa450517..a718f853d457 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -466,6 +466,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
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
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_SVC_FUNCID_VERSION)
+
 /**
  * SMC call protocol for FPGA Crypto Service (FCS)
  * FUNCID starts from 90
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 82a20e62f15f..a776a787ac75 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -114,6 +114,9 @@ struct stratix10_svc_chan;
  * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
  * is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
+ * @COMMAND_SMC_SVC_VERSION: Non-mailbox SMC SVC API Version,
+ * return status is SVC_STATUS_OK
+ *
  * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
@@ -160,6 +163,8 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
+	/* Non-mailbox SMC Call */
+	COMMAND_SMC_SVC_VERSION = 200,
 };
 
 /**
-- 
2.25.1

