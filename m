Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76049329B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiASBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:55:27 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:40555 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbiASBzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:55:21 -0500
Received: by mail-oo1-f46.google.com with SMTP id v10-20020a4a860a000000b002ddc59f8900so306893ooh.7;
        Tue, 18 Jan 2022 17:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDFvNpRcxcRiXHoR8iY7a3oJbQYZ0Hd88REO6KoIzUs=;
        b=r7k/7J8CjLoq+dwiNOl8CnCUoTLDPo/0Osl9dgf6wj/Wmtme9H3Npe44Y5zcHbQofx
         KcWGJcwgAZVMBWMyMhsQTg+JDW17qp/PXuttfM88AbAzDe2+hU6ZASPFZyBSn9FlYoAP
         rqVpgx7zkNwlMmXsMbLu+BnniJiYsStIBTkAuOg8x6DkZqO3y3DveXaWXFZ25DndZzj5
         EJbrha0ZsvQlaa2vlWJXN3daAc6W1EvODdIHV0R94UbKBl/cBf6lrQ1Gn/VF60tPc95o
         TZkTKxqhjcbiBSJ0EdaHR59w6SrlU1+Vx9O/EXEuURTP0UGdttWn6zd53EDdlXWoNBzv
         D5Sw==
X-Gm-Message-State: AOAM530jv+bV2ifeAmMgBTArQZ1RGlzAdaUtR8l7kcqIjGWvtWjw3iMv
        jzUMrM85r8yDrbEQFO76VQ==
X-Google-Smtp-Source: ABdhPJyIkjaF5D1ayxhHq/GXg3NF4Mcjtn5miWb4tjIttgOUmnukw2u3sVMTHlix67afNbkf453Gew==
X-Received: by 2002:a4a:d184:: with SMTP id j4mr20125402oor.20.1642557320567;
        Tue, 18 Jan 2022 17:55:20 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g22sm6683714otp.38.2022.01.18.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:55:19 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: lm90: Drop Tegra specifics from example
Date:   Tue, 18 Jan 2022 19:55:13 -0600
Message-Id: <20220119015514.2441231-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to complicate examples with a platform specific macro.
It also complicates example parsing to figure out the number of
interrupt cells in examples (based on bracketing).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/national,lm90.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
index 6e1d54ff5d5b..30db92977937 100644
--- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
+++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
@@ -60,7 +60,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/tegra-gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     i2c {
@@ -71,8 +70,7 @@ examples:
             compatible = "onnn,nct1008";
             reg = <0x4c>;
             vcc-supply = <&palmas_ldo6_reg>;
-            interrupt-parent = <&gpio>;
-            interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
             #thermal-sensor-cells = <1>;
         };
     };
-- 
2.32.0

