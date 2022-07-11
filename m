Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC0570D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiGKWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGKWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7852E7D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C95C611F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B942C34115;
        Mon, 11 Jul 2022 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578709;
        bh=hnPirb/Cj9dkurnAnavzWRfntXOHgedcvCNBeLS/u7I=;
        h=From:To:Cc:Subject:Date:From;
        b=gif6OrSIsoeBx4hgHOp62r6YMWDTXAIyxQQ7of8EfaCJD7z8pYPQKTZEaMx24uChh
         HKwcUEqBwkKsDDMgDteqZs5R/pCUq/ptMLHnjAeYFh42FePGRP9LMN8lH1GvuG/cTu
         fuuIpQoQ4OPLfTonkVYgLtZYTd0UtCkDGQULbtfX9Bw5qQmFY3kM2ZNb3dHVEJpi0g
         qCoEvdx8mv+DFvymMuR5ao5tHaH44WuCDbffKDtF167xZh+eTPUvZmZuJd2xodY6L3
         aivwDtqxdmlW4qtDWbM9o5dsGfLOJBEgtSshVcPIu2cgydH2yKXxFAWLPnUVBXboxG
         ey7rjrKAXjuUA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 1/6] firmware: stratix10-svc: Add support for FCS
Date:   Mon, 11 Jul 2022 17:31:35 -0500
Message-Id: <20220711223140.2307945-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Extend Intel service layer driver to support FPGA Crypto service(FCS)
features on Intel Soc platforms. Adding an additional channel and FCS
platform driver ("intel_fcs") as part of the probe method.
FCS driver uses the driver to send crypto operations' commands to
the secure device manager(SDM) on Intel Soc platforms Stratix10 and
Agilex.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c              | 30 +++++++++++++++----
 .../firmware/intel/stratix10-svc-client.h     |  1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 14663f671323..1fe748c047df 100644
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
@@ -1036,6 +1038,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[1].name = SVC_CLIENT_RSU;
 	spin_lock_init(&chans[1].lock);
 
+	chans[2].scl = NULL;
+	chans[2].ctrl = controller;
+	chans[2].name = SVC_CLIENT_FCS;
+	spin_lock_init(&chans[2].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
@@ -1054,8 +1061,22 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
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
 
@@ -1063,8 +1084,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_put_device:
-	platform_device_put(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
 	return ret;
@@ -1075,6 +1094,7 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
 	kfifo_free(&ctrl->svc_fifo);
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 18c1841fdb1f..24121f8e0d7c 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -14,6 +14,7 @@
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
+#define SVC_CLIENT_FCS			"fcs"
 
 /*
  * Status of the sent command, in bit number
-- 
2.25.1

