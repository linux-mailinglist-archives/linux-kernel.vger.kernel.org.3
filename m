Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE44FDEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbiDLL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbiDLL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:56:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02160A8B;
        Tue, 12 Apr 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649760010; x=1681296010;
  h=from:to:cc:subject:date:message-id;
  bh=374d2KEtS0jWsYeS7dQ6Ghuf7T7NoRUNsq5r7DmUasA=;
  b=JPj7baWdlM9khb9S0P9mDFtxUU+xzqcHZgvvJcnrS42Y1kTzwGttG/LP
   BSAB/PC8VrEbqB2dIj5unKZn/7h99bb7JwhpbZiA3hc2CwauEI8dqY80d
   90XndUlcV9d10quzD3FIf5Q/1e/sZxG0oZfgq/WZMJW0fP1835/RnK/BL
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 03:40:10 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 03:40:08 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:09:46 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 395D45A26; Tue, 12 Apr 2022 16:09:45 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, chris@printf.net, venkatg@codeaurora.org,
        gdjakov@mm-sol.com, quic_asutoshd@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Date:   Tue, 12 Apr 2022 16:09:43 +0530
Message-Id: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
[ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version: 0x00007202
[ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt: 0x00000000
[ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl: 0x00000000
[ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
[ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
[ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
[ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
[ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
[ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]: 0x00000000
[ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
[ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
[ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP-----------
[ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg: 0x6000642c | DLL cfg2: 0x0020a000
[ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl: 0x00010800 | DDR cfg: 0x80040873
[ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88218a8 Vndr func3: 0x02626040

Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm chipsets")
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0..0e5fb62 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -2482,6 +2483,39 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
 }
 
+static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
+{
+	struct reset_control *reset;
+	int ret = 0;
+
+	reset = reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				"unable to acquire core_reset\n");
+
+	if (!reset)
+		return ret;
+
+	ret = reset_control_assert(reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "core_reset assert failed\n");
+
+	/*
+	 * The hardware requirement for delay between assert/deassert
+	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
+	 * ~125us (4/32768). To be on the safe side add 200us delay.
+	 */
+	usleep_range(200, 210);
+
+	ret = reset_control_deassert(reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
+
+	usleep_range(200, 210);
+	reset_control_put(reset);
+
+	return ret;
+}
 
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
@@ -2529,6 +2563,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
+	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
+	if (ret)
+		goto pltfm_free;
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

