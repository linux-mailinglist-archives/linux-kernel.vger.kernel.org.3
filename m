Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB37533475
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiEYAqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiEYAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:46:50 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB032FFCA;
        Tue, 24 May 2022 17:46:48 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 24P0kGQH032106; Wed, 25 May 2022 09:46:16 +0900
X-Iguazu-Qid: 34troEDgosQr0Nhwun
X-Iguazu-QSIG: v=2; s=0; t=1653439576; q=34troEDgosQr0Nhwun; m=PqN0SZ2Kbn3J0hN+mlzV3+eKzFQWVJyC5dMeA4DgRlE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 24P0kEX6037176
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 09:46:14 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3] dt-bindings: watchdog: toshiba,visconti-wdt: Update the common clock properties
Date:   Wed, 25 May 2022 09:46:05 +0900
X-TSB-HOP2: ON
Message-Id: <20220525004605.2128727-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock for this driver switched to the common clock controller driver.
Therefore, update common clock properties for watchdog in the binding document.
And this matched this example with the actual dts.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Acked-by: Rob Herring <robh@kernel.org>
---

 v3: doesn't remove timeout-sec.
 v2: send to linux-watchdog.

 .../bindings/watchdog/toshiba,visconti-wdt.yaml      | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
index 690e19ce4b87..eba083822d1f 100644
--- a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
@@ -35,20 +35,16 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/toshiba,tmpv770x.h>
+
     soc {
         #address-cells = <2>;
         #size-cells = <2>;
 
-        wdt_clk: wdt-clk {
-            compatible = "fixed-clock";
-            clock-frequency = <150000000>;
-            #clock-cells = <0>;
-        };
-
-        watchdog@28330000 {
+        wdt: watchdog@28330000 {
             compatible = "toshiba,visconti-wdt";
             reg = <0 0x28330000 0 0x1000>;
-            clocks = <&wdt_clk>;
             timeout-sec = <20>;
+            clocks = <&pismu TMPV770X_CLK_WDTCLK>;
         };
     };
-- 
2.36.0


