Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A594812D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhL2MrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:13 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39750
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238669AbhL2MrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:07 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61844402DE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782026;
        bh=iLh2tlnNUtVUmnMt4eZqM7IntfyNeEM0k2CAHpGK5VM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Xt6pXXmUBbMxdEqk5szvOEw9YSCCjQt3evSRfTXUCEa0kUZ1/2bW8vD0u2Yi7pCS8
         NFKgB3DJy/FruQVkUDsggPZxbjYPcLyCZxDXTKdknQRwq5sdT8NNeMOlzuGzXbLyqM
         mm5/yb2qKK5E01xw6Vsq/rwFGPfL0Ct4E3s7hmV/hXrpWwP2A0Muq8KVfAtGn/eGd+
         9BeXox8qlwwZk+bSeflTJT8JzH/zrNKi1JsviJf3jbZMOMM14JjJJNAZAq58D/zmuJ
         yCIQJQPSSzFH2D1o9LW7Qm/gzKXkkauGe8D8+QWu2LUzP0uOdrjirB8RjuaSUJN6Zo
         ysyVnj0O5/MsA==
Received: by mail-lj1-f198.google.com with SMTP id l6-20020a2e8686000000b0022d9a4d18d5so6208734lji.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLh2tlnNUtVUmnMt4eZqM7IntfyNeEM0k2CAHpGK5VM=;
        b=CAedV5KioKIWtnodO2EPNbRx3dJYjY6Kr5TC9QIuCezOy3GLLrwoUeJCfxqMy65npB
         RBCeRC+UgZpySKXM3dMKVXT17PnORn/URNL/sRr6kyjDt/ZImaG8beynmVdPcrhqWNXg
         w1ZG9K184Bhort+jvLYrB9SO6OspcOgZSY6u+LYyPpcN7j83Senw/RMo6llIY/y/n+mm
         JSKztv6iOEcJtbAtDJIt6ImoxcmeZ0XTL5bUhdU6Y8aa48nc3LNylOot6Go2gJYeeGxZ
         gRrk/vl0TpeX7WoSlwGnAX+OKTNpiqEno0RveS9ySzcvE+JV7yWQR48/dct8akVY0AbD
         /kVA==
X-Gm-Message-State: AOAM531VXc7zqO16R2Lfhu5IK7p71IIA53z0Yj0CJ8etnDGqmlFEY/QT
        Rm62EzkYED8wc9YZ/A5NvCLG25bVPkwQ69VwaguSZ8tYv0HASis7FNTqBFRkg/L4KtObif6BXCA
        ARixF0OVtzIalflB+NuKEHDsALt3kVI9rOFTLW4E0pA==
X-Received: by 2002:ac2:5f55:: with SMTP id 21mr23246717lfz.283.1640782022892;
        Wed, 29 Dec 2021 04:47:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQwlfEHGHgz1XhNgkfKoJmRVwi/su6Y8k5CHBskV1bmWZtSjIVx4kz65FqRHcXJCAf0dw7zw==
X-Received: by 2002:ac2:5f55:: with SMTP id 21mr23246702lfz.283.1640782022719;
        Wed, 29 Dec 2021 04:47:02 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:47:02 -0800 (PST)
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
Subject: [PATCH 2/5] dt-bindings: extcon: maxim,max77843: add MAX77843 bindings
Date:   Wed, 29 Dec 2021 13:46:28 +0100
Message-Id: <20211229124631.21576-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for MAX77843 MUIC/extcon driver, based on
Exynos5433 TM2 devicetree.  These are neither accurate nor finished
bindings but at least allow parsing existing DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/extcon/maxim,max77843.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml

diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
new file mode 100644
index 000000000000..1f15a6c700f6
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
+    $ref: ../connector/usb-connector.yaml#
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

