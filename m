Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA864DE9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbiCSRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbiCSRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:39 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC51DA8C4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:47:15 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 595583F65F;
        Sat, 19 Mar 2022 18:47:12 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] arm64: dts: qcom: msm8992-libra: Fix up the framebuffer
Date:   Sat, 19 Mar 2022 18:46:39 +0100
Message-Id: <20220319174645.340379-10-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319174645.340379-1-konrad.dybcio@somainline.org>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the necessary clocks are kept on after clk_cleanup (until MDSS
is properly handled by its own driver) and touch up the fb address to
prevent some weird shifting. It's still not perfect, but at least the
kernel log doesn't start a third deep into your screen..

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index e638fc489539..4e06641eb384 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -29,13 +29,25 @@ chosen {
 		#size-cells = <2>;
 		ranges;
 
-		framebuffer0: framebuffer@3404000 {
+		framebuffer0: framebuffer@3403f48 {
 			compatible = "simple-framebuffer";
-			reg = <0 0x3404000 0 (1080 * 1920 * 3)>;
+			reg = <0 0x3403f48 0 (1080 * 1920 * 3)>;
 			width = <1080>;
 			height = <1920>;
 			stride = <(1080 * 3)>;
 			format = "r8g8b8";
+			/*
+			 * That's a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet..
+			 */
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_VSYNC_CLK>,
+				 <&mmcc MDSS_MDP_CLK>,
+				 <&mmcc MDSS_BYTE0_CLK>,
+				 <&mmcc MDSS_PCLK0_CLK>,
+				 <&mmcc MDSS_ESC0_CLK>;
+			power-domains = <&mmcc MDSS_GDSC>;
 		};
 	};
 
-- 
2.35.1

