Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B149D603
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiAZXNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:13:13 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47018 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiAZXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:13:01 -0500
Received: by mail-ot1-f51.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so784746otv.13;
        Wed, 26 Jan 2022 15:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3p0DCKZpOVWZSmNX3sbE+ojVVTWAiXUYNmg5RsLNew=;
        b=gF9pfhqZdxhKzORp95m/k9B+9kSvmAmLEkxChHrRMvBMmpc3Xgkm/DkfWiGjGniv66
         1Pr1YBXro2nfBRAFBn7p/E++G290Kwhx811oqcni9PW0oTz62DYHGdtqDEcV8qlOypmN
         dwrdcSK1D5B/73CJbVzhEKtY0ZLxyYBWVzVTgOwFJ8trCc7MrzbvqabksGKuCW0s7FSj
         O2tCn3xXaSOWoXfvR262jlLnQF2Z4KpEZG6PgB7I4ryf45auZNjjvn+2EjP8caPNqyUI
         BWpWEJ7CLuWmZ+W1EhJawBAkv8+F1qEBG5PSKCr5K6QOSxaEIQitatvWdw0+EO1o880x
         SPeg==
X-Gm-Message-State: AOAM530CoOElIqSp4pO8ghYGPT4lYaa/+jnqvVS/yb6s+ALztNyhWwxb
        qDsPzlBMq/rFeh83VN2JDg==
X-Google-Smtp-Source: ABdhPJwUxe7qYMLH4IuC6/ftnBuE0VaSqCoenhc/lm5+z0BKCeJMDxL+ZRx3VXlEbM6ssJblSjHK8w==
X-Received: by 2002:a9d:7c97:: with SMTP id q23mr639926otn.165.1643238781109;
        Wed, 26 Jan 2022 15:13:01 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id u25sm9629588oth.56.2022.01.26.15.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:13:00 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: regulator: maxim,max8973: Drop Tegra specifics from example
Date:   Wed, 26 Jan 2022 17:12:50 -0600
Message-Id: <20220126231250.1635021-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to complicate examples with a platform specific macro.
It also complicates example parsing to figure out the number of interrupt
cells in examples (based on the bracketing).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/maxim,max8973.yaml         | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
index 35c53e27f78c..5898dcf10f06 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
@@ -113,7 +113,7 @@ examples:
     };
 
   - |
-    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     i2c {
@@ -123,8 +123,7 @@ examples:
         regulator@1b {
             compatible = "maxim,max77621";
             reg = <0x1b>;
-            interrupt-parent = <&gpio>;
-            interrupts = <TEGRA_GPIO(Y, 1) IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 
             regulator-always-on;
             regulator-boot-on;
-- 
2.32.0

