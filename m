Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878652E88F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbiETJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiETJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:17:53 -0400
X-Greylist: delayed 1005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 02:17:51 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC68CB36;
        Fri, 20 May 2022 02:17:50 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 24K917bT028914; Fri, 20 May 2022 18:01:07 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 24K90a3e020094; Fri, 20 May 2022 18:00:36 +0900
X-Iguazu-Qid: 34trvzMrv8f6CEmUZq
X-Iguazu-QSIG: v=2; s=0; t=1653037236; q=34trvzMrv8f6CEmUZq; m=oCtpcilmw9sapkrx804jsQH7wnrQENTBrdGAFPG45Cc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 24K90Ymr009957
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 18:00:34 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: watchdog: toshiba,visconti-wdt: Update the common clock properties
Date:   Fri, 20 May 2022 18:00:24 +0900
X-TSB-HOP2: ON
Message-Id: <20220520090024.620928-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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
 .../bindings/watchdog/toshiba,visconti-wdt.yaml     | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
index 690e19ce4b87..52c0e0c022ea 100644
--- a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
@@ -35,20 +35,15 @@ additionalProperties: false
 
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
-            timeout-sec = <20>;
+            clocks = <&pismu TMPV770X_CLK_WDTCLK>;
         };
     };
-- 
2.36.0


