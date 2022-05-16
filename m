Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9B528471
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiEPMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiEPMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DBB393F0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i19so28407058eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE7hxsrfkGvYZ2LG8GhfvDdrQa4exclsJdIMUiOtgcw=;
        b=WkaIcKCA0s+PoEKaDzZ+vpSKNSF2FzwM4Ocg+Zo9F/J9A7q9EGk8ZqZfdcUxMAGy8g
         3ixNejsD6naRO6730LwImN46u87gpHN86aajL3QKdKW+9oXSx5Xw9eldCCpFvqUGDs67
         p+RhhaIfulk/s3bUj/ZkzqTqInEY4ulx+HNAJWrBNa+2UWkm9x0LwQMYgPwYk0srHwBn
         FLCTObTH2Ws6Ozzv5BpW54vbnxq02Yw2ZlDzr4IMTX6mEr4e/i5TFa2mCmf/B7b5iark
         DAJmA0kD3dWSwv3SM+p36+vMmYQr43nnWoLQMQ3Z7gAY7+JArdJG3IKJNunb6wezeIL8
         cLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE7hxsrfkGvYZ2LG8GhfvDdrQa4exclsJdIMUiOtgcw=;
        b=tkmC5sdl+RdL1/mMZXaLvMtbsKJIcv08vOqUF1aveXSQNpdX6VpnXs1md21k9YJIS4
         VgN7y4SsOyWSWuK6pV3dXFQkOYYYYT/3FgVcnGI/79bFE0vtYEMkZsz6kWWzqmLvmZeB
         h4pTvggjvIY0BduCWnBFry8o/36QTrBciMSi4NPeo+4Bmxf9v+BGDeLQw52i4LxHccCI
         tet/IcpFhVGeu8Epew9dP3lLy4c6vbv02HoJmq45kQOpaXGLQtAPe9vtFXOss8lgXwvQ
         SHCbbO+4u/51A5OTxWJ1dm7t022L9hSd23BFlyvu9o6RCEZZ8k0ew9HOMZ+dwxuNzbs6
         mdBQ==
X-Gm-Message-State: AOAM530cYwhrWukFdiRAIgatsa5XoH0rtApwSUT9em8hUeyFciMZuAB1
        POe5h+8dBIhZydoAm+XB/i8cyQ==
X-Google-Smtp-Source: ABdhPJwuKnsKJiHR6rlKCzIdR53SyIRgd7Y05Lvb/xVXcT8s0b2o1qBxanDHfInzQDfbL6XowHlNVQ==
X-Received: by 2002:a17:907:161f:b0:6f4:378a:c2d8 with SMTP id hb31-20020a170907161f00b006f4378ac2d8mr15726164ejc.289.1652705322366;
        Mon, 16 May 2022 05:48:42 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:42 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/10] dt-bindings: marvell: convert Armada 37xx compatibles to YAML
Date:   Mon, 16 May 2022 14:48:20 +0200
Message-Id: <20220516124828.45144-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Armada 37xx SoC compatibles to YAML.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Change the title to "Marvell Armada 37xx Platforms"
* Update the 3720 SoC boards description to include "boards"

Changes in v3:
* Alphabetical ordering
* Remove Armada 3710 SoC as there are no boards currently
---
 .../bindings/arm/marvell/armada-37xx.txt      | 26 -----------
 .../bindings/arm/marvell/armada-37xx.yaml     | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index f6d6642d81c0..29fa93dad52b 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -1,21 +1,3 @@
-Marvell Armada 37xx Platforms Device Tree Bindings
---------------------------------------------------
-
-Boards using a SoC of the Marvell Armada 37xx family must carry the
-following root node property:
-
- - compatible: must contain "marvell,armada3710"
-
-In addition, boards using the Marvell Armada 3720 SoC shall have the
-following property before the previous one:
-
- - compatible: must contain "marvell,armada3720"
-
-Example:
-
-compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
-
-
 Power management
 ----------------
 
@@ -48,11 +30,3 @@ avs: avs@11500 {
 	compatible = "marvell,armada-3700-avs", "syscon";
 	reg = <0x11500 0x40>;
 }
-
-
-CZ.NIC's Turris Mox SOHO router Device Tree Bindings
-----------------------------------------------------
-
-Required root node property:
-
- - compatible: must contain "cznic,turris-mox"
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
new file mode 100644
index 000000000000..cd7a77d1fdc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 37xx Platforms
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Armada 3720 SoC boards
+        items:
+          - enum:
+              - cznic,turris-mox
+              - globalscale,espressobin
+              - marvell,armada-3720-db
+              - methode,udpu
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+      - description: Globalscale Espressobin boards
+        items:
+          - enum:
+              - globalscale,espressobin-emmc
+              - globalscale,espressobin-ultra
+              - globalscale,espressobin-v7
+          - const: globalscale,espressobin
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+      - description: Globalscale Espressobin V7 boards
+        items:
+          - enum:
+              - globalscale,espressobin-v7-emmc
+          - const: globalscale,espressobin-v7
+          - const: globalscale,espressobin
+          - const: marvell,armada3720
+          - const: marvell,armada3710
+
+additionalProperties: true
-- 
2.36.1

