Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A95AE291
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiIFI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiIFI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9275FE3;
        Tue,  6 Sep 2022 01:28:33 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:414f:4149:b474:40e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EDC16601E58;
        Tue,  6 Sep 2022 09:28:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662452912;
        bh=akOO5a5VBwwM5ULG//oclOrBNsePI3P1QC1EGSuXwY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOtKsM2WfKk4SKLR5DQpzTodDHpKTPKD/VqD6OAtrCcql8pM6SUb7PbYxAkPUgr7V
         FBaUHFPcxIHmB0F9TxjC89nnDRlvLAzrrt5bhCh6XwqxUregIivMSa028kL1ZmTI0x
         qJ0LrbNXXS0EjUun8GBPUjKj+CrwVHHp6FMr/MAAkqedA7wx2wkcidkxWlDe4k4KZV
         HAxXGW2lMK/Rwhrzf4rbRExrcB/kpjz5R45PC4Ug2lyzfuafFC0aXlGuG40lHVPlRn
         d7xyRa2LbbY+0W5fJfQBVSOCfSgfEUG88d+xc5wU3GTGL3vl0LfdWCXR27swSwU3VE
         M/azYA3O2whMQ==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
Date:   Tue,  6 Sep 2022 09:28:16 +0100
Message-Id: <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
Inc.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2:
 - Enumerate pi4ioe5v6534q as requiring pcal6534 fallback

 .../bindings/gpio/gpio-pca95xx.yaml           | 98 ++++++++++---------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index 977b14db09b0..81140b066683 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -15,52 +15,58 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - exar,xra1202
-      - maxim,max7310
-      - maxim,max7312
-      - maxim,max7313
-      - maxim,max7315
-      - maxim,max7319
-      - maxim,max7320
-      - maxim,max7321
-      - maxim,max7322
-      - maxim,max7323
-      - maxim,max7324
-      - maxim,max7325
-      - maxim,max7326
-      - maxim,max7327
-      - nxp,pca6408
-      - nxp,pca6416
-      - nxp,pca9505
-      - nxp,pca9506
-      - nxp,pca9534
-      - nxp,pca9535
-      - nxp,pca9536
-      - nxp,pca9537
-      - nxp,pca9538
-      - nxp,pca9539
-      - nxp,pca9554
-      - nxp,pca9555
-      - nxp,pca9556
-      - nxp,pca9557
-      - nxp,pca9574
-      - nxp,pca9575
-      - nxp,pca9698
-      - nxp,pcal6416
-      - nxp,pcal6524
-      - nxp,pcal9535
-      - nxp,pcal9554b
-      - nxp,pcal9555a
-      - onnn,cat9554
-      - onnn,pca9654
-      - ti,pca6107
-      - ti,pca9536
-      - ti,tca6408
-      - ti,tca6416
-      - ti,tca6424
-      - ti,tca9539
-      - ti,tca9554
+    oneOf:
+      - items:
+        - const: diodes,pi4ioe5v6534q
+        - const: nxp,pcal6534
+      - items:
+        - enum:
+          - exar,xra1202
+          - maxim,max7310
+          - maxim,max7312
+          - maxim,max7313
+          - maxim,max7315
+          - maxim,max7319
+          - maxim,max7320
+          - maxim,max7321
+          - maxim,max7322
+          - maxim,max7323
+          - maxim,max7324
+          - maxim,max7325
+          - maxim,max7326
+          - maxim,max7327
+          - nxp,pca6408
+          - nxp,pca6416
+          - nxp,pca9505
+          - nxp,pca9506
+          - nxp,pca9534
+          - nxp,pca9535
+          - nxp,pca9536
+          - nxp,pca9537
+          - nxp,pca9538
+          - nxp,pca9539
+          - nxp,pca9554
+          - nxp,pca9555
+          - nxp,pca9556
+          - nxp,pca9557
+          - nxp,pca9574
+          - nxp,pca9575
+          - nxp,pca9698
+          - nxp,pcal6416
+          - nxp,pcal6524
+          - nxp,pcal6534
+          - nxp,pcal9535
+          - nxp,pcal9554b
+          - nxp,pcal9555a
+          - onnn,cat9554
+          - onnn,pca9654
+          - ti,pca6107
+          - ti,pca9536
+          - ti,tca6408
+          - ti,tca6416
+          - ti,tca6424
+          - ti,tca9539
+          - ti,tca9554
 
   reg:
     maxItems: 1
-- 
2.35.1

