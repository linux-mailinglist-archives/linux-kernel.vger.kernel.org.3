Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3C48B452
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiAKRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:48:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32872
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242182AbiAKRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:48:48 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92C9F40046
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923327;
        bh=KtzaeAS3vHdxLiX+UAOcYpw4x029KYpzx4CNQuL/lKY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QqoXNe126LMEbui0jdtl1XY0PTGNk+bQAEt+2X+dsgkPraYGEaH8ODy3nFVpReTRm
         gZxDcxV0m5t+2WLQVHINOjM88Nl78rL1kwcA5mBVBZ8kBJ4on6x3VzE8U0zIRx7Owx
         QRlJuuXBBiNLv7AaHDl6Jik5MFdrFNBekhC6FfqpsN+2Tmola4qBxwJTit2HpMQEC6
         +qy4wI0+u9hDNWQ4BPzLJ7KXgPiHfcavOT2TRQf3TITtWWYKCrmt7iXgcoCXRrO1Vi
         gwwRO6qWiSMUR0Kg4uRayhhya03/gQabXm3I2FFvjb9Px8J1qnwubLztaHT1t2jvv3
         fbHF8/DVmp6Dg==
Received: by mail-ed1-f70.google.com with SMTP id p8-20020aa7d308000000b003fe9b0c4760so3835709edq.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtzaeAS3vHdxLiX+UAOcYpw4x029KYpzx4CNQuL/lKY=;
        b=eWz1FSZthscEN+3FJ46irL0ayEoyrdB3UTbalWHEQneG1qKBwmYIN9bIGgdB7reNiD
         OXJh1UenfqUFBNEmhaI3oZVh7S7Vd5PLCecWx292l7wWoYozD7Q8/CO4ka0GT+iDYaYa
         Qf5naznx0StKpr0PqcEBTXYKRCic2800sjFMr4m6Pb1kGLo9uvbiYdt6q/6r6NRfTGKW
         2xDBlu1Y81GfbsEjsla+sKqyi4WmTCYh4ZN2QucRbbukqOb3mKSfAIvBWePTiCol6gnY
         lhxWna8Ojaq2kZhR3ni5vUTCSOTyR0Q3sQ61CIlKV+fT0M9sF5pBj3eURaVGEtSqi85u
         JkwQ==
X-Gm-Message-State: AOAM531DxiuQs1g884ibvEAfb+/MlbQ6QxgvyN8WVUkKFcwPiiK97Lw3
        SDw3LJJb2nSA8pFba639gddQxO6BQw1PEBk/CNAyc+ykN2511rAHy80K+ln8M1AFynjVrpnNPiP
        oqnIeC2ZH6HrYaJc+dJJRTmxzGLLjOl4b6xGEpS8XmA==
X-Received: by 2002:a17:907:6da0:: with SMTP id sb32mr4730975ejc.455.1641923327247;
        Tue, 11 Jan 2022 09:48:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOxlUAVlC4YuYQpRipmbsqUYnDmolm/iGG7kaEKNH1SQBIaGmimpIrXXHt3wLrnMj/QIsfRw==
X-Received: by 2002:a17:907:6da0:: with SMTP id sb32mr4730956ejc.455.1641923327047;
        Tue, 11 Jan 2022 09:48:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i23sm5224489edt.93.2022.01.11.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:48:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: extcon: maxim,max77843: add MAX77843 bindings
Date:   Tue, 11 Jan 2022 18:48:02 +0100
Message-Id: <20220111174805.223732-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for MAX77843 MUIC/extcon driver, based on
Exynos5433 TM2 devicetree.  These are neither accurate nor finished
bindings but at least allow parsing existing DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/extcon/maxim,max77843.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml

diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
new file mode 100644
index 000000000000..f9ffe3d6f957
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/maxim,max77843.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77843 MicroUSB and Companion Power Management IC Extcon
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
+  Integrated Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77843-muic
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Any connector to the data bus of this controller should be modelled using
+      the OF graph bindings specified
+    properties:
+      port:
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - connector
+
+additionalProperties: false
-- 
2.32.0

