Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973849418B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357341AbiASUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:10:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58640
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357278AbiASUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:10:19 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C7AD440023
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623018;
        bh=GRu1K5Z3B26B9M12OsHXKA/4Epty9FsW9mnGuNMchEQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ef73SsVzIsFg/zign28CXPuAF35dEXeYWtTH0hMuISwXS3XDW5GqZeM5QT5EsSL21
         0ZPcSsmvkOS70EA8g/Y+BrAc2yIoYEeF4qXVzck3jxOivBLIj6UvuFv3U4xFpoZ4YP
         TlRPH7hEz9nt29xkELqtvZqhftsGNi/AXByVDbyEv8q5P5KWCvdODiXhSx0EXeFR9J
         UN0bLVapgs9P43BTwtNyHX3RR8Fn+xsJFJHQWQ37eL/7uqAS6JQzyhbtMEaO/7ad9l
         8T1KG+weuPcvaH/cvUJCYKjj+TSBn6ZnKH07ssvQeCZ2BCPt8WTko/aGrDh2qWITha
         5snK7MkgsFfuQ==
Received: by mail-ed1-f71.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso3714119eds.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRu1K5Z3B26B9M12OsHXKA/4Epty9FsW9mnGuNMchEQ=;
        b=nvfCmGdfUaud3tBba/HNEmEoseh1QtS384m/onNBPhWQ6ov/FjCdTEUdAR6Fb4fkvf
         eJzJcatiSoSStdJ1tFipt9azDBL/iq7NiTChB2E88oswffrD1WhiJXWe9smv60bQz5ao
         9YK2P2xG7gYR89P/ENBiEmWrLDRnjemggYVmZbCsbEXD/JFF3I0y1gtcaFRQeo0VFiji
         vDg9AK/MVJQ6BN7PvndesgBxhX7PwmhkUHw9r2FotCaGCHhfX9RH1bejTNWKF4WCBIUw
         qglZDvV+B7AbOJCE+pMAELyMAOiQ3525xlQhCcSR0+odE2Qs2nu0S+n/o+Xm9FpPcsVN
         l9AA==
X-Gm-Message-State: AOAM533B+ofMwzn7JK3zeWiqErnYQywCV8RK/J5On432H6MXqQJt9RbE
        nPYFbwkVGxJ2RBgwl77Fg2H8jPZd6tP/mIShz/zZVMolVdkyJXPY61mAmnkkswwHHMvcQK2DtVp
        0wzT/py65DMsajFQ6kxpfHoEFmjvkWwgSPuDT3cdjCw==
X-Received: by 2002:a17:906:4fc4:: with SMTP id i4mr24859422ejw.81.1642623018347;
        Wed, 19 Jan 2022 12:10:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxat/3cH7VlKTaOJ6D43ir//wPM5jj+urjF4BtAx24WJHWak7JOycKsnfW1x835sJOSJKku+Q==
X-Received: by 2002:a17:906:4fc4:: with SMTP id i4mr24859404ejw.81.1642623018122;
        Wed, 19 Jan 2022 12:10:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 4/5] mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
Date:   Wed, 19 Jan 2022 21:10:04 +0100
Message-Id: <20220119201005.13145-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ChromeOS Embedded Controller appears on boards with Samsung Exynos
SoC, where Exynos SPI bindings expect controller-data node.  Reference
newly added dtschema for this property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d793dd0316b7..e9c46430fd8a 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -32,7 +32,7 @@ properties:
 
   controller-data:
     description:
-      SPI controller data, see bindings/spi/spi-samsung.txt
+      SPI controller data, see bindings/spi/samsung,spi-peripheral-props.yaml
     type: object
 
   google,cros-ec-spi-pre-delay:
@@ -149,18 +149,21 @@ patternProperties:
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
+
+  - $ref: /schemas/spi/samsung,spi-peripheral-props.yaml
 
 additionalProperties: false
 
-- 
2.32.0

