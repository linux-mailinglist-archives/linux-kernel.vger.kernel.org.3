Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E205B1639
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIHIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIHIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:04:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB48E110B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662624274; x=1694160274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5NirQSUli2jH8XetYreEzP+PSiSLk2xwi9i64a3oC/w=;
  b=GjSjmC9MXpk0BTnZAZp3uBuPkcA32EPn1dKBfxDvUuZ7393v76S38UeH
   y9uq67xfdVKoYiaktO/uh12JGIntuMN4nMEMGPhicPnzJ9ALSfPTq/2kI
   CunoN6fqFvyiO+Qnglqo7F4xc6cYlmqBiPhrnumC3Amqk+r5+XBdZMwV6
   aE7dP4inI5rR+g/WMymZEX+IFgpTQBSr3faKxEFcn8TvV/bdh2x0oTZlk
   EE3Slor30kdwhQlKI6jxKW6XRYyijrwJu/h52s+HsvRFxDHaqUl8X6oBj
   OnmSbs5RJDHhOjGr4xfXufOj0NNN/QWLJWsRIKqVCVSJPSHWpFDsTA29C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358833922"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="358833922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 01:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565847676"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 01:04:32 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] firmware: stratix10-svc: attestation
Date:   Thu,  8 Sep 2022 16:04:18 +0800
Message-Id: <20220908080418.2493165-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Extend Intel service layer driver to support the new attestation features.
FPGA attestation provides trustworthiness of FPGA images currently running
on a FPGA device.
Support for single certificate to allow unauthenticated updates to the
pseudo time stamp.
Get certificates and certificate reload features.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              |  89 +++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 209 +++++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  47 ++++
 3 files changed, 343 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index b4081f4d88a3..2f295e353efb 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -328,6 +328,10 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_SEND_CERTIFICATE:
 	case COMMAND_FCS_DATA_ENCRYPTION:
 	case COMMAND_FCS_DATA_DECRYPTION:
+	case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+	case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+	case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
+	case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
@@ -356,11 +360,28 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_FCS_RANDOM_NUMBER_GEN:
 	case COMMAND_FCS_GET_PROVISION_DATA:
 	case COMMAND_POLL_SERVICE_STATUS:
+	case COMMAND_FCS_GET_ROM_PATCH_SHA384:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		cb_data->kaddr2 = svc_pa_to_va(res.a2);
 		cb_data->kaddr3 = &res.a3;
 		break;
+	case COMMAND_FCS_GET_CHIP_ID:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = &res.a2;
+		cb_data->kaddr3 = &res.a3;
+		break;
+	case COMMAND_FCS_ATTESTATION_SUBKEY:
+	case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+	case COMMAND_FCS_ATTESTATION_CERTIFICATE:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = svc_pa_to_va(res.a2);
+		cb_data->kaddr3 = &res.a3;
+		break;
+	case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr2 = &res.a2;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -512,18 +533,74 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = (unsigned long)pdata->size;
 			break;
+		case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+			a0 = INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED;
+			a1 = pdata->arg[0];
+			a2 = pdata->arg[1];
+			a3 = pdata->arg[2];
+			break;
 		case COMMAND_FCS_GET_PROVISION_DATA:
 			a0 = INTEL_SIP_SMC_FCS_GET_PROVISION_DATA;
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+			a0 = INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_FCS_GET_CHIP_ID:
+			a0 = INTEL_SIP_SMC_FCS_CHIP_ID;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_FCS_ATTESTATION_SUBKEY:
+			a0 = INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+			a0 = INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = (unsigned long)pdata->size;
+			a3 = (unsigned long)pdata->paddr_output;
+			a4 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_ATTESTATION_CERTIFICATE:
+			a0 = INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE;
+			a1 = pdata->arg[0];
+			a2 = (unsigned long)pdata->paddr_output;
+			a3 = (unsigned long)pdata->size_output;
+			break;
+		case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
+			a0 = INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		/* for crypto service */
+		case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+			a0 = INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
+			a0 = INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
 			a1 = (unsigned long)pdata->paddr;
 			a2 = (unsigned long)pdata->size;
 			break;
+		case COMMAND_FCS_GET_ROM_PATCH_SHA384:
+			a0 = INTEL_SIP_SMC_FCS_GET_ROM_PATCH_SHA384;
+			a1 = (unsigned long)pdata->paddr;
+			a2 = 0;
+			break;
 		case COMMAND_RSU_DCMF_STATUS:
 			a0 = INTEL_SIP_SMC_RSU_DCMF_STATUS;
 			a1 = 0;
@@ -597,6 +674,16 @@ static int svc_normal_to_secure_thread(void *data)
 			case COMMAND_FCS_DATA_ENCRYPTION:
 			case COMMAND_FCS_DATA_DECRYPTION:
 			case COMMAND_FCS_RANDOM_NUMBER_GEN:
+			case COMMAND_FCS_PSGSIGMA_TEARDOWN:
+			case COMMAND_FCS_GET_CHIP_ID:
+			case COMMAND_FCS_ATTESTATION_SUBKEY:
+			case COMMAND_FCS_ATTESTATION_MEASUREMENTS:
+			case COMMAND_FCS_COUNTER_SET_PREAUTHORIZED:
+			case COMMAND_FCS_ATTESTATION_CERTIFICATE:
+			case COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD:
+			case COMMAND_FCS_GET_ROM_PATCH_SHA384:
+			case COMMAND_FCS_CRYPTO_OPEN_SESSION:
+			case COMMAND_FCS_CRYPTO_CLOSE_SESSION:
 				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..b6aeda88d87f 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -67,6 +67,9 @@
  *
  * INTEL_SIP_SMC_RSU_ERROR:
  * There is error during the process of remote status update request.
+ *
+ * INTEL_SIP_SMC_STATUS_NOT_SUPPORTED:
+ * Secure monitor software doesn't support the request
  */
 #define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
 #define INTEL_SIP_SMC_STATUS_OK				0x0
@@ -74,6 +77,7 @@
 #define INTEL_SIP_SMC_STATUS_REJECTED			0x2
 #define INTEL_SIP_SMC_STATUS_ERROR			0x4
 #define INTEL_SIP_SMC_RSU_ERROR				0x7
+#define INTEL_SIP_SMC_STATUS_NOT_SUPPORTED		0x8
 
 /**
  * Request INTEL_SIP_SMC_FPGA_CONFIG_START
@@ -464,7 +468,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  */
 #define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
 #define INTEL_SIP_SMC_FIRMWARE_VERSION \
-        INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
 
 /**
  * Request INTEL_SIP_SMC_SVC_VERSION
@@ -595,4 +599,207 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED
+ * Sync call to update counter value w/o signed certificate
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED
+ * a1 counter type
+ * a2 counter value
+ * a3 test bit
+ * a3-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
+ * a1-a4 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_COUNTER_SET_PREAUTHORIZED 95
+#define INTEL_SIP_SMC_FCS_COUNTER_SET_PREAUTHORIZED \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_COUNTER_SET_PREAUTHORIZED)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN
+ * Sync call to tear down all previous black key provision sessions and to
+ * delete keys assicated with those sessions
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN
+ * a1 the session ID
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR,
+ *    not used if a0 is INTEL_SIP_SMC_STATUS_OK or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_PSGSIGMA_TEARDOWN 100
+#define INTEL_SIP_SMC_FCS_PSGSIGMA_TEARDOWN \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_PSGSIGMA_TEARDOWN)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CHIP_ID
+ * Sync call to get the device ID
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CHIP_ID
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR or
+ *    INTEL_SIP_SMC_STATUS_REJECTED
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 retrieved chipID value low 32 bits
+ * a3 retrieved chipID value high 32 bits
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CHIP_ID 101
+#define INTEL_SIP_SMC_FCS_CHIP_ID \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CHIP_ID)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY
+ * Sync call to the device attestation subkey
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY
+ * a1 physical address of subkey command data
+ * a2 subkey command data size
+ * a3 physical address of to be filled subkey response data
+ * a4 subkey response data size
+ * a5-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the filled subkey response data
+ * a3 size of the filled subkey response dat
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_SUBKEY 102
+#define INTEL_SIP_SMC_FCS_ATTESTATION_SUBKEY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_SUBKEY)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS
+ * Async call to get device attestation measurements
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS
+ * a1 physical address of measurement command data
+ * a2 measurement command data size
+ * a3 physical address of to be filled measurement response data
+ * a4 measurement response data size
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the filled subkey measurement data
+ * a3 size of the filled subkey measurement data
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS 103
+#define INTEL_SIP_SMC_FCS_ATTESTATION_MEASUREMENTS \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_ATTESTATION_MEASUREMENTS)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE
+ * Sync call to get device attestation certificate
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE
+ * a1 the type of certificate request
+ * a2 the physical address which holds certificate response data
+ * a3 the size of the certificate response data
+ * a4-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 physical address of the requested certificate
+ * a3 sized of the requested certificate
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_ATTESTATION_CERTIFICATE 104
+#define INTEL_SIP_SMC_FCS_GET_ATTESTATION_CERTIFICATE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_ATTESTATION_CERTIFICATE)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD
+ * Sync call to specify what certificate is to be generated
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD
+ * a1 the type of certificat request
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CREATE_CERTIFICATE_ON_RELOAD 105
+#define INTEL_SIP_SMC_FCS_CREATE_CERTIFICATE_ON_RELOAD \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CREATE_CERTIFICATE_ON_RELOAD)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_GET_ROM_PATCH_SHA384
+ *
+ * Sync call used to dump the SHA384 hash of the rom patch
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_GET_ROM_PATCH_SHA384
+ * a1 the physical address for firmware to write generated SHA384 data
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FCS_ERROR or
+ *      INTEL_SIP_SMC_FCS_REJECTED
+ * a1 mailbox error
+ * a2 the physical address of the SHA384 checksum
+ * a3 size of the SHA384 checksum
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_GET_ROM_PATCH_SHA384 64
+#define INTEL_SIP_SMC_FCS_GET_ROM_PATCH_SHA384 \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_ROM_PATCH_SHA384)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION
+ * Sync call to open and establish a crypto service session with firmware
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2 session ID
+ * a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_OPEN_CRYPTO_SERVICE_SESSION 110
+#define INTEL_SIP_SMC_FCS_OPEN_CRYPTO_SERVICE_SESSION \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_OPEN_CRYPTO_SERVICE_SESSION)
+
+/**
+ * Request INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION
+ * Sync call to close a service session
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION
+ * a1 session ID
+ * a2-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 mailbox error if a0 is INTEL_SIP_SMC_STATUS_ERROR
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION 111
+#define INTEL_SIP_SMC_FCS_CLOSE_CRYPTO_SERVICE_SESSION \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_CLOSE_CRYPTO_SERVICE_SESSION)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 0c16037fd08d..629cd8cf2cc3 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -138,6 +138,41 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
  * is SVC_STATUS_OK, SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_COUNTER_SET_PREAUTHORIZED: update the counter value for
+ * the selected counter without the signed certificate, return status is
+ * SVC_STATUS_OK, or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_PSGSIGMA_TEARDOWN: tear down all previous black key
+ * provision sessions and delete keys assicated with those sessions,
+ * return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_GET_CHIP_ID: get the device's chip ID, return status is
+ * SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_SUBKEY: get device's attestation subkey,
+ * return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_MEASUREMENTS: to get device's attestation
+ * measurements, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
+ *
+ * @COMMAND_POLL_SERVICE_STATUS: poll if the service request is complete,
+ * return statis is SVC_STATUS_OK, SVC_STATUS_ERROR or SVC_STATUS_BUSY
+ *
+ * @COMMAND_FCS_ATTESTATION_CERTIFICATE: get FPGA attestation certificate,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD: reload FPGA attestation
+ * certificate, return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_GET_ROM_PATCH_SHA384: read the ROM patch SHA384 value,
+ * return status is SVC_STATUS_OK, or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_OPEN_SESSION: open the crypto service session(s),
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_FCS_CRYPTO_CLOSE_SESSION: close the crypto service session(s),
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -162,8 +197,20 @@ enum stratix10_svc_command_code {
 	COMMAND_FCS_DATA_ENCRYPTION,
 	COMMAND_FCS_DATA_DECRYPTION,
 	COMMAND_FCS_RANDOM_NUMBER_GEN,
+	COMMAND_FCS_COUNTER_SET_PREAUTHORIZED,
+	COMMAND_FCS_GET_ROM_PATCH_SHA384,
+	/* for Attestation */
+	COMMAND_FCS_PSGSIGMA_TEARDOWN = 30,
+	COMMAND_FCS_GET_CHIP_ID,
+	COMMAND_FCS_ATTESTATION_SUBKEY,
+	COMMAND_FCS_ATTESTATION_MEASUREMENTS,
+	COMMAND_FCS_ATTESTATION_CERTIFICATE,
+	COMMAND_FCS_ATTESTATION_CERTIFICATE_RELOAD,
 	/* for general status poll */
 	COMMAND_POLL_SERVICE_STATUS = 40,
+	/* for crypto service */
+	COMMAND_FCS_CRYPTO_OPEN_SESSION = 50,
+	COMMAND_FCS_CRYPTO_CLOSE_SESSION,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
 };
-- 
2.25.1

