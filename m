Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA64C8467
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiCAG42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:56:25 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CD75C12;
        Mon, 28 Feb 2022 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646117745; x=1677653745;
  h=from:to:cc:subject:date:message-id;
  bh=75AX1RVUHEfaOArSmBUBO+QF36pMQ24mrlffZJTZDK8=;
  b=mg7UT5kPT81hTM1qc21tCbMu55PUDklEFPjThzLfMOR3TZM+yy68c7f/
   wvx1rWFDX6v0mdj1z74x+9zmClo/l7jH0qmQqEUblUcRc+t/X2IywJBQP
   ZuUFAujGxLNVETp6+F9eMSlfuyC2wUfDFYFPUfobnOKJ6SxY6a41gywts
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 28 Feb 2022 22:55:45 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Feb 2022 22:55:43 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Mar 2022 12:25:31 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id CFEC158A5; Tue,  1 Mar 2022 12:25:29 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Date:   Tue,  1 Mar 2022 12:25:28 +0530
Message-Id: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset GCC_SDCC_BCR register before every fresh initilazation. This will
reset whole SDHC-msm controller, clears the previous power control
states and avoids, software reset timeout issues as below.

[ 5.458061][ T262] mmc1: Reset 0x1 never completed.
[ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP
===========
[ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version:
0x00007202
[ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
0x00000000
[ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
0x00000000
[ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
0x00000000
[ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
[ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
[ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat:
0x00000000
[ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
0x00000000
[ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
0x00000000
[ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
[ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
[ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
0x00000000
[ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
0x00000000
[ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
[ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER
DUMP-----------
[ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
0x6000642c |
DLL cfg2: 0x0020a000
[ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
0x00010800 | DDR cfg: 0x80040873
[ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 :
0xf88218a8 Vndr func3: 0x02626040

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0..f10b3c7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -284,6 +285,7 @@ struct sdhci_msm_host {
 	bool uses_tassadar_dll;
 	u32 dll_config;
 	u32 ddr_config;
+	struct reset_control *core_reset;
 	bool vqmmc_enabled;
 };
 
@@ -2482,6 +2484,45 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
 }
 
+static int sdhci_msm_gcc_reset(struct platform_device *pdev,
+	       struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret = 0;
+
+	msm_host->core_reset = devm_reset_control_get(&pdev->dev, "core_reset");
+	if (IS_ERR(msm_host->core_reset)) {
+		ret = PTR_ERR(msm_host->core_reset);
+		dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
+		msm_host->core_reset = NULL;
+	}
+	if (msm_host->core_reset) {
+		ret = reset_control_assert(msm_host->core_reset);
+		if (ret) {
+			dev_err(&pdev->dev, "core_reset assert failed (%d)\n",
+						ret);
+			goto out;
+		}
+		/*
+		 * The hardware requirement for delay between assert/deassert
+		 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
+		 * ~125us (4/32768). To be on the safe side add 200us delay.
+		 */
+		usleep_range(200, 210);
+
+		ret = reset_control_deassert(msm_host->core_reset);
+		if (ret) {
+			dev_err(&pdev->dev, "core_reset deassert failed (%d)\n",
+						ret);
+			goto out;
+		}
+		usleep_range(200, 210);
+	}
+
+out:
+	return ret;
+}
 
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
@@ -2529,6 +2570,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
+	ret = sdhci_msm_gcc_reset(pdev, host);
+	if (ret) {
+		dev_err(&pdev->dev, "core_reset assert/deassert failed (%d)\n",
+					ret);
+		goto pltfm_free;
+	}
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

