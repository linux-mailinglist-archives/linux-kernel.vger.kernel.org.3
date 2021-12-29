Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4884812DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhL2MrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39788
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238737AbhL2MrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:10 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF001402E5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782026;
        bh=NVZDNZbcxMe60AjIyWq0dP9vH4MaxZTaIUYRQc7qGok=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=djHjds5mqAE5iZ0sNZ0J4lLmqZVemEnqtWnTifxeiXDAIUBVhalJ1hAIxf/X/mlBy
         Tu6MLEmkSHMGupy6EpXz6/Z+OP0l391FK6vGVCIamBOJ2lOj1vX5pOV3ALyJuU2ldv
         xfqTnX7jJrSwQyNiukZikhd4Lnk6kM2Xqk/HlOw5yuB8x+HDxlNNco8+tBlPzSBJMC
         1tdXQgbje4w4xbWB1n+zOYA7a+d46a3hYRVw9w+lvkEMaxCBRzVv+T023lxvGtkBYR
         tcncKDPKlBcTOKa2/mi/U6BgTexhi6ArLwdZQAPL5z3+D6OXeqi1COpBf7SdDV1Pv4
         kDHYIu6uL9Y4w==
Received: by mail-lf1-f69.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so4450282lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVZDNZbcxMe60AjIyWq0dP9vH4MaxZTaIUYRQc7qGok=;
        b=NSUN+zemZP1kN8MS6/EX2s2g4Hpj5v51yR1OaMslDahIGdZg0/S2L0DlWZJNhiSP4s
         Klz8qzpKPWLKG/R9QqucAzmsStIKNtlZeCoSrOaGbdQOBgnsb29yAZrIl8rSKCYABrua
         T2uLPz/DAoZM+4A/x6FizkJ43qS4W1N02bV0hBnwwduKAp5S2asVmu332WeYZgPl53I+
         BstDy/N6Zmb8VClXLEDGb0EkfEbCk4znOKZoh4Qch4fZhshzvyraL5j7p98Ryuu/fbZU
         /AmaklJpKYXc1eadz1TwYGTTR4Qb0wtcLIIsQEJ+yQuIfnIkr8NhMCh0lasQL5bqbr5V
         ZfaA==
X-Gm-Message-State: AOAM532i068YdSRpxZ9qUG2xK3z1NU4/1AQjsY4u8U3AExzAGHZ5llm9
        7M8G0AsF8kMMjn0MOUGZHA9s2eNNFAJYVL5v4i3PuH+5fLmoUITajGw6CkktD26Oyhz69biDUzt
        TYyw15fn2pSkGKi9uW+IDMNzfjJJLfVw0I2ryVukKMg==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr9998749ljp.172.1640782024259;
        Wed, 29 Dec 2021 04:47:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysgtAYCi/aDd+5Ib3QCtjvGG5GYx3B+fcDxG5/MXwsPeTVwy8kTmO4sA8Z7NWAnwKjLlaM4g==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr9998733ljp.172.1640782024076;
        Wed, 29 Dec 2021 04:47:04 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:47:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 3/5] regulator: dt-bindings:  maxim,max77843: add MAX77843 bindings
Date:   Wed, 29 Dec 2021 13:46:29 +0100
Message-Id: <20211229124631.21576-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for MAX77843 regulator driver.  The bindings are
almost identical to MAX77693 bindings, except the actual names of
regulators.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/maxim,max77843.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
new file mode 100644
index 000000000000..1ab58c756d7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77843.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77843 MicroUSB and Companion Power Management IC regulators
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77843 MicroUSB Integrated
+  Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77843-regulator
+
+patternProperties:
+  "^SAFEOUT[12]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Safeout LDO regulator.
+
+    properties:
+      regulator-min-microvolt: true
+      regulator-max-microvolt: true
+
+    required:
+      - regulator-name
+
+  "^CHARGER$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Current regulator.
+
+    properties:
+      regulator-min-microamp: true
+      regulator-max-microamp: true
+
+    required:
+      - regulator-name
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.32.0

