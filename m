Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0073149D60C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiAZXOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:14:04 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37790 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiAZXOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:14:03 -0500
Received: by mail-oi1-f171.google.com with SMTP id u129so2607463oib.4;
        Wed, 26 Jan 2022 15:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=id2BNeDZg3dDDMILDpcowwdo+5CZ/wFbYJt0PkzxCcQ=;
        b=XjY0Lgr/g65wWPh1zNhVrNO8NIe3DIJZuDmG/190pnk06xvCRlWsrmRXgUS7wQiZxs
         WVV13wBRXuEDqTWO2z2h+y5kmLvZxoUV1/6ch5IAt4VFVakSmGPivXP5deMVyfNjcGJ9
         O4O/LstjDttXxaoRr7TJsVWeryD4oQGggedUuOUHIMflWHDNtbjavD5M6fnqP4Gkaqs9
         tX9SJ5RXzD433LVfKcGneOllKXlqNhoaM99EhTdvfAGRDgEG2C3sHm7DogN0Yf2eQUXQ
         PXEPrQzDjKCs9jdcR4U2Q242HkRdTdJDQqMhllcwqvG7sRR3NaK4IQz28ziHxzD5wUuS
         cFJQ==
X-Gm-Message-State: AOAM532D5afOqbo+jN8BM8sgwo9A/bgB0OpTBKjuWtyqG3mEF3DH9yVm
        xY8T6JtIcdOLPjNjwR5vZ1vAfOKVVQ==
X-Google-Smtp-Source: ABdhPJx4p4fTjtNu7f3jrQHEOC8n0POr7czD30dfR5wcQ3Z5adbSkF3RGNPVmZ58NMouU0ijrbVZow==
X-Received: by 2002:a05:6808:ec4:: with SMTP id q4mr621505oiv.326.1643238842514;
        Wed, 26 Jan 2022 15:14:02 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p26sm6081196oth.14.2022.01.26.15.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:14:02 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Fang <derek.fang@realtek.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5682s: Drop Tegra specifics from example
Date:   Wed, 26 Jan 2022 17:13:58 -0600
Message-Id: <20220126231358.1637174-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to complicate examples with a platform specific macro.
It also complicates example parsing to figure out the number of interrupt
cells in examples (based on bracketing).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/realtek,rt5682s.yaml        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index d65c0ed5060c..ca5b8987b749 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -21,6 +21,7 @@ properties:
     description: I2C address of the device.
 
   interrupts:
+    maxItems: 1
     description: The CODEC's interrupt output.
 
   realtek,dmic1-data-pin:
@@ -94,7 +95,7 @@ required:
 
 examples:
   - |
-    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     i2c {
@@ -104,10 +105,9 @@ examples:
         codec@1a {
             compatible = "realtek,rt5682s";
             reg = <0x1a>;
-            interrupt-parent = <&gpio>;
-            interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
             realtek,ldo1-en-gpios =
-                <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+                <&gpio 2 GPIO_ACTIVE_HIGH>;
             realtek,dmic1-data-pin = <1>;
             realtek,dmic1-clk-pin = <1>;
             realtek,jd-src = <1>;
-- 
2.32.0

