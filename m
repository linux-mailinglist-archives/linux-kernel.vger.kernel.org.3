Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF68509A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386514AbiDUINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386472AbiDUIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:26 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 01:09:38 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6691E3FA;
        Thu, 21 Apr 2022 01:09:37 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 23L82Bu4008355; Thu, 21 Apr 2022 17:02:11 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 23L81pou023347; Thu, 21 Apr 2022 17:01:51 +0900
X-Iguazu-Qid: 34trpTYxFGvHYfA6HI
X-Iguazu-QSIG: v=2; s=0; t=1650528111; q=34trpTYxFGvHYfA6HI; m=C7/iOvyqr0mp6XzSqSaLODep2G3TdSKSUIk0yN+KuYg=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 23L81oNu017170
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 17:01:50 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] arm64: dts: visconti: Add clock controller support for TMPV7708
Date:   Thu, 21 Apr 2022 17:01:43 +0900
X-TSB-HOP2: ON
Message-Id: <20220421080143.2135566-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds node of clock controller support for Toshiba Visconti TMPV7708.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 01d7ee61ad25..1683113a3c43 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dt-bindings/clock/toshiba,tmpv770x.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -182,6 +183,12 @@ wdt_clk: wdt-clk {
 		#clock-cells = <0>;
 	};
 
+	osc2_clk: osc2-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -216,6 +223,20 @@ gpio: gpio@28020000 {
 			interrupt-parent = <&gic>;
 		};
 
+		pipllct: clock-controller@24220000 {
+			compatible = "toshiba,tmpv7708-pipllct";
+			reg = <0 0x24220000 0 0x820>;
+			#clock-cells = <1>;
+			clocks = <&osc2_clk>;
+		};
+
+		pismu: syscon@24200000 {
+			compatible = "toshiba,tmpv7708-pismu", "syscon";
+			reg = <0 0x24200000 0 0x2140>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@28200000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0 0x28200000 0 0x1000>;
-- 
2.34.1


