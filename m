Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93553904A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiEaMH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiEaMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:07:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A24EA2D;
        Tue, 31 May 2022 05:07:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t2so5044407pld.4;
        Tue, 31 May 2022 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjL5ChPbIi7K/V0MdTfM2rPQhvrdOuYsXgOFgMyivaI=;
        b=XUW9GdGy4TqDailNbK9B/jsEL99PnLrY7N6e/R0pDDK5Mj+ioTShKiwSiYxB9IrpFZ
         Mu3bFnjNhNRaCm4FfOxekdr+q7O7xZKCPbbEoseMPnqAarbIXgRmHW9h3DpetYJf7ROx
         Ja+9DYEYKdvr64YWdrTt4qJ11drlS3wdTSWTi7j13Ai0e/Q7DhS7yuAPTQlrJEyqP4Gk
         kDB08TOcStQLLZ1WkA02qea053UKUM83GOEnr0x5ERuvahMFRYEzMfEmWRCIc4LSeeS4
         RBFRcPlfiABIdr9tYu6684lGowuRpNzZS7laB1vAZXldhJ6Huk82Yv+uPmFry5CRdKBf
         ZjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjL5ChPbIi7K/V0MdTfM2rPQhvrdOuYsXgOFgMyivaI=;
        b=mXzbOtLhdjEADiKnWrncmM7aqWioeiYEv2zChJKuGiTIqAib0sZwCbciZu32q+8zT5
         VRDWkwABbI4qF4E5cW+3TrjbCT+Ob/jlCtpRMf7et1NDq/k10IVkN5TXqbDvkkbvxnfE
         ibGIPYm3Tz5jwRLv4Vlh3392P/8es4scVg1EBOifVQp8QiSyaqHeOguUT3DQz0L0HqrN
         eACwZoY6Qr087cEtCerozUySPXKILu20mbdnZYu7e7P+Mo2EYvrBbACFPgkJ2I1NgDAq
         fHGpNY08TGaS7T64M0WhmqwdvHJ5bOuq7hpdc2f6StbLK4QWgzxXGvrkdGQGCZdsFr3w
         mfNw==
X-Gm-Message-State: AOAM532WVrEhNCzZdYw8pDrKKz7EgLpixm8QKFvgf8xC9rzJ+DDZHSXx
        Dr1BINUAXMoZ9Rb3xoJvRJdNwzBsCt8=
X-Google-Smtp-Source: ABdhPJzhoIKkLqm77ivXQGmG9uiBv7avEg57jLy4emn49XKC6kCSn41nkMkpf9Cog5z8VCg8vYRfpg==
X-Received: by 2002:a17:903:2310:b0:163:e054:9c0f with SMTP id d16-20020a170903231000b00163e0549c0fmr9477567plh.57.1653993044377;
        Tue, 31 May 2022 03:30:44 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:30:44 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/14] dt-bindings: usb: Add Mediatek MT6370 TCPC binding documentation
Date:   Tue, 31 May 2022 18:28:04 +0800
Message-Id: <20220531102809.11976-10-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531102809.11976-1-peterwu.pub@gmail.com>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add Mediatek MT6370 TCPC binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 000000000000..49316633f92f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT6370 Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT6370 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.25.1

