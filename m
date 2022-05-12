Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96258524D69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353956AbiELMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbiELMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DC1EA1AB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s11so2303888edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fq96Yl0hYueuqSgds4c6PlO8kmctV/m/cnU1KhcHraw=;
        b=PCqsv/gg6jZ92nkltPSx3hZK0SJT1p5ATrESEA0hLBEjSQbAgmm9etobHe817K0A6Z
         DoyPmbbrUDwmsHN1nZTa4fZsx2eOmUQdJLZZ/P8leYbce/mDtiDbdceDJxDBe59ltgYc
         TpzgIPPK+iVkkbtCP4WIUQMLJJm2QZUNBXjzYXmpLzthHG0N4hkzigT4aoa2NqYNZUZr
         fnHluivmLgErtsouR7myFYgTeYI2MUjfw6fXhuE4hjTgCbZDXmlKuHf24aIroZg9rV+3
         9vucmXS+uDTaXIN/CvogmFNyEVw2VJ4W8rWGiWZ5UL0Jn79KDu8lvlr4Upp5QxSvd0Wj
         9MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fq96Yl0hYueuqSgds4c6PlO8kmctV/m/cnU1KhcHraw=;
        b=CPH0QCnsgzuQO+aFcbfnlIK9AxqNJlMelx6hIiyhpo1sJnzsGeJKla/w1uYQ10WQoU
         +guYrwsMqsgM9TgmZtTXpArAezCfVEfEUPX1UrG/1xO9l31rHHXsVrwQ3KblbBcoQgMv
         8HKwL0t8ej4TbBp/fRwRGVURB/P3iBUWaPPCh/bjzc98Hk9ppDky45eZbBrHBBlh3ABa
         KdE6fSqw1gqn3/8iK/IyyQsn2QjsvLUOdOGl1EtWF/t5rDdoZ+GS3EGoS1Byz6PPup6m
         55fyS/oLIwqUUGc821ULIaERNj87Enf6G4fnX6WDmpBcDmFIixtl2G6V+48Llc7dQuTM
         M9og==
X-Gm-Message-State: AOAM530Wgl2XKqQ3yOBx3v24ZhT9pw3yy0T+9MUUqKfvDsClNq8pauk5
        pJVwZ4lp/uCMscpzAOzZeguTCQ==
X-Google-Smtp-Source: ABdhPJzynV2uzKdp2WSUU8yeG6U1/9zm2d5StHnxb9agqqTBto9aZ/6CiqOKSVZr3qCNhWVeWFm9mA==
X-Received: by 2002:a05:6402:128b:b0:425:d1d7:b321 with SMTP id w11-20020a056402128b00b00425d1d7b321mr34537869edv.179.1652359753632;
        Thu, 12 May 2022 05:49:13 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:13 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 02/11] dt-bindings: marvell: convert Armada 37xx compatibles to YAML
Date:   Thu, 12 May 2022 14:48:56 +0200
Message-Id: <20220512124905.49979-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Armada 37xx SoC compatibles to YAML.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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
index 000000000000..4460608ac1e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 37xx Platforms Device Tree Bindings
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Armada 3720 SoC
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

