Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D4497A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiAXIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:24:03 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42862
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242153AbiAXIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:23:56 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4AB323F203
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012635;
        bh=E9f604EUNMRc1K0x625ft9mXrJ60309YtLmhBOy5gsM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WmfQ6/k5biHVhPXmcpnVGNMbmiVsK2/ApbS0Ms0uu7oR+Veem+kFqfY8sDudVBP4v
         w6bizTaONN3RrP5lFxiACL3wwKQF6c1ixs0LxMgLumjsU5pX6dmWB8Zk1fqGcKJ/r9
         u4PQCMYDmhB/P+qtVuu1RnMVDbXyV+5f//E8RbSvq8+yosoTY5IATVHZZiXGeTnoO2
         wx3DO9ipqsAuNfx+KkkLLCvg5uNt1EqED+NxVUfhgLEI0XBglSQF2Tuw6RmujDMUZe
         qa0JN+JFlBH8GeW0iV4Kwv2zzZT6YG192YScfm+zvde0PzZTkOaLDxTt7633tCZyK4
         u7WTOXS7mN1bQ==
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so1535642wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9f604EUNMRc1K0x625ft9mXrJ60309YtLmhBOy5gsM=;
        b=aqxPA4VGqGf/8xuZsQQDlzhFD6XRbieRogWHI3JCDy7ZeScmbUy311kmORlVfD2WmT
         1LpynBH344RBRBfXCFuWYyRKpAh9PYRSx2c0fJO3CRpp5IHAhksJJeMBhUZUUlI115wf
         qym1jl6WIDVttpRaGijFttr5qhp277OvdMcFARzRAs87EaMglgyNKt7fct8OLRW8bEk2
         dg1L942zw6slpvVOtzcNl3YGh9l69yR294tHsnTNtROprpaLnK7kk6cIROShRwgcFPj8
         Bocg5lPk0cYnxqb9Hz2xL+OklFMUAWjwqzQzajyKpuny/5/mlImbYsFRa9/qtiVZDTLc
         9xCw==
X-Gm-Message-State: AOAM532a4xOy1HqAXAPpBPB6mOW9j6/qHfjPpFlkr/Gpyl+N/u2HHsfO
        IZEnOOzPj5n50HbDkpZYM4rfww2X7PYUjP76smv8O7N2EnYdspSp+gcupYhZiSaTpLyxLx7HH6k
        eNjVfxvUoxfUFjS7LrKd3YRUj/O2pcVa87H97PcFDCA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9501292wrq.339.1643012635037;
        Mon, 24 Jan 2022 00:23:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpvjCvKyZkS3eDZZP0ZWE7Zg9akUafDchzT87csJ7JBjny0Ukmeg3wKlAmCj1K+MrEAi1FMw==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9501274wrq.339.1643012634897;
        Mon, 24 Jan 2022 00:23:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 2/4] mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
Date:   Mon, 24 Jan 2022 09:23:45 +0100
Message-Id: <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChromeOS Embedded Controller appears on boards with Samsung Exynos
SoC, where Exynos SPI bindings expect controller-data node.  Reference
SPI peripheral bindings which include now Samsung SPI peripheral parts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d1f53bd449f7..525ab18005b3 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -31,7 +31,7 @@ properties:
 
   controller-data:
     description:
-      SPI controller data, see bindings/spi/spi-samsung.txt
+      SPI controller data, see bindings/spi/samsung,spi-peripheral-props.yaml
     type: object
 
   google,cros-ec-spi-pre-delay:
@@ -148,18 +148,21 @@ patternProperties:
 required:
   - compatible
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - google,cros-ec-i2c
-          - google,cros-ec-rpmsg
-then:
-  properties:
-    google,cros-ec-spi-pre-delay: false
-    google,cros-ec-spi-msg-delay: false
-    spi-max-frequency: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - google,cros-ec-i2c
+              - google,cros-ec-rpmsg
+    then:
+      properties:
+        google,cros-ec-spi-pre-delay: false
+        google,cros-ec-spi-msg-delay: false
+        spi-max-frequency: false
+    else:
+      $ref: /schemas/spi/spi-peripheral-props.yaml
 
 additionalProperties: false
 
-- 
2.32.0

