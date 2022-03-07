Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0574CFE20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiCGMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbiCGMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:23:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF380214;
        Mon,  7 Mar 2022 04:22:15 -0800 (PST)
X-UUID: 3649ebd76a494fed91d4a5093eadff4e-20220307
X-UUID: 3649ebd76a494fed91d4a5093eadff4e-20220307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1065495557; Mon, 07 Mar 2022 20:22:09 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 20:22:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 20:22:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 20:22:07 +0800
From:   Tim Chang <jia-wei.chang@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq dt-bindings
Date:   Mon, 7 Mar 2022 20:21:49 +0800
Message-ID: <20220307122151.11666-3-jia-wei.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add cci property.
2. add example of MT8186.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
---
 .../bindings/cpufreq/cpufreq-mediatek.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
index 584946eb3790..d3ce17fd8fcf 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
@@ -48,6 +48,10 @@ properties:
       When absent, the voltage scaling flow is handled by hardware, hence no
       software "voltage tracking" is needed.
 
+  cci:
+    description:
+      Phandle of the cci to be linked with the phandle of CPU if present.
+
   "#cooling-cells":
     description:
       For details, please refer to
@@ -129,3 +133,40 @@ examples:
       /* ... */
 
     };
+
+  - |
+    /* Example 3 (MT8186 SoC) */
+    #include <dt-bindings/clock/mt8186-clk.h>
+    cluster0_opp: opp-table-0 {
+      compatible = "operating-points-v2";
+      opp-shared;
+      opp0_00: opp-500000000 {
+        opp-hz = /bits/ 64 <500000000>;
+        opp-microvolt = <600000>;
+        opp-level = <15>;
+        required-opps = <&opp2_00>;
+      };
+
+      /* ... */
+
+    };
+
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cpu1: cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a55";
+        reg = <0x0100>;
+        enable-method = "psci";
+        clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>, <&apmixedsys CLK_APMIXED_MAINPLL>;
+        clock-names = "cpu", "intermediate";
+        operating-points-v2 = <&cluster0_opp>;
+        proc-supply = <&mt6358_vproc12_reg>;
+        sram-supply = <&mt6358_vsram_proc12_reg>;
+        cci = <&cci>;
+      };
+
+      /* ... */
+
+    };
-- 
2.18.0

