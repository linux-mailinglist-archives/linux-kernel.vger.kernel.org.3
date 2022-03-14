Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476DA4D7AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiCNGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiCNGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:11:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE7403C0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647238199; x=1678774199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r3F/N6GYLf+WnOSzTB1WCQEvCmSrey+aXGvhWvhYY78=;
  b=UeKUibCwV58ST0x4MTw4rYCCuvgxlhLL79eKIPPPuBOeh2jYTMoDcOlm
   LNuEhlVnuOu0qCOxl+1LvzSGxvWFObbwO7+fns9Mka/PJuoZnXoDhUrwG
   TU5FFZGnx4/trmYR7xnJIT2l9hToYp9C4IDRtGhZNjzNWNSXxIx43kENi
   urs2s3ywLUu0raapaGmBmNTrXzfQjp6gLDQRAjsPxYm2wDJQ9arFfHVYP
   9AXct9v5MEkjDpsajX69nPCW5iCAAP6fEd6N/ml9+1osC3wjMbtSwHDeB
   SFh2f14yFSDXo+TLosMUrvfCOec2Ky2Aq0zL5liVhWzQL87qBxeZKr/0e
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319169353"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="319169353"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 23:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="818682672"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2022 23:09:57 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2 1/3] firmware: stratix10-svc: extend svc to support FCS features
Date:   Mon, 14 Mar 2022 22:09:50 +0800
Message-Id: <20220314140950.2165205-1-tien.sung.ang@intel.com>
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

Extend Intel service layer driver to support FPGA Crypto service(FCS)
features on Intel Soc platforms. Adding an additional channel and FCS
platform driver ("intel_fcs") as part of the probe method.
FCS driver uses the driver to send crypto operations' commands to
the secure device manager(SDM) on Intel Soc platforms Stratix10 and
Agilex.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c              | 30 +++++++++++++++----
 .../firmware/intel/stratix10-svc-client.h     |  4 +--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 29c0a616b317..17757b58a8e5 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,12 +34,13 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				2
+#define SVC_NUM_CHANNEL				3
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 
 /* stratix10 service layer clients */
 #define STRATIX10_RSU				"stratix10-rsu"
+#define INTEL_FCS				"intel-fcs"
 
 typedef void (svc_invoke_fn)(unsigned long, unsigned long, unsigned long,
 			     unsigned long, unsigned long, unsigned long,
@@ -53,6 +54,7 @@ struct stratix10_svc_chan;
  */
 struct stratix10_svc {
 	struct platform_device *stratix10_svc_rsu;
+	struct platform_device *intel_svc_fcs;
 };
 
 /**
@@ -1029,6 +1031,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[1].name = SVC_CLIENT_RSU;
 	spin_lock_init(&chans[1].lock);
 
+	chans[2].scl = NULL;
+	chans[2].ctrl = controller;
+	chans[2].name = SVC_CLIENT_FCS;
+	spin_lock_init(&chans[2].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
@@ -1047,8 +1054,22 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_device_add(svc->stratix10_svc_rsu);
-	if (ret)
-		goto err_put_device;
+	if (ret) {
+		platform_device_put(svc->stratix10_svc_rsu);
+		return ret;
+	}
+
+	svc->intel_svc_fcs = platform_device_alloc(INTEL_FCS, 1);
+	if (!svc->intel_svc_fcs) {
+		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add(svc->intel_svc_fcs);
+	if (ret) {
+		platform_device_put(svc->intel_svc_fcs);
+		return ret;
+	}
 
 	dev_set_drvdata(dev, svc);
 
@@ -1056,8 +1077,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_put_device:
-	platform_device_put(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
 	return ret;
@@ -1068,6 +1087,7 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
 	kfifo_free(&ctrl->svc_fifo);
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 19781b0f6429..468490590f85 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -14,8 +14,8 @@
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
-
-/*
+#define SVC_CLIENT_FCS			"fcs"
+/**
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
-- 
2.25.1

