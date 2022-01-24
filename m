Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C154985AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiAXREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:04:25 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56860
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244021AbiAXREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:21 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2015D3F32C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643043860;
        bh=+59EwcCO1RI2K6NXx9nmWMGLlCdcb4Skfl8EoAq/R8s=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WvHeSbDZFYvLKBAX2ytHoHQfOPhC1QmZ/mR4F5VhSa947wjWm3ihszIir9Ru1LFLt
         pTAxSGcIG6Eu6PvqSwNpH2cAyPlUSutK99sbIRHZnLrWuUl0O8cLkDHNrhKdZSXZUx
         H9yCLqt5UJgIvM1baQ3M1t/nBveVrsfgasnUL5Gx57AUleI/T0C50GfxugnVkwUPJT
         EjackeoOmTHvgYR1WM+KmdKPoqM2VKelkt1q3dnMd0IU4pyc0EUJy5P9AF7Z2kd6ya
         GCn07WUmYN/4a2Z/lM3FyL2mNsFZovyHK7ZLDcOlEJih9LcKtJ/93XtTj+zRF0H0gf
         RgTZIJdFKiWmw==
Received: by mail-ej1-f72.google.com with SMTP id x16-20020a170906135000b006b5b4787023so2352252ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+59EwcCO1RI2K6NXx9nmWMGLlCdcb4Skfl8EoAq/R8s=;
        b=eQVb+xAfJ4CPZ3v9l1L3xs1yB8M+2QU51qdSddwXGprzIRKGGB4poUpTtOdyVducXn
         bw4q9ZwRopIUiO4TFn1w29I/C/07lXrFyGmVzJETPkVWIpCPdj9OQ1WANRwoB8AYZEK2
         JCA5P0dQ2vjVawLv6w4UfJiLZFJl+yFca5AW07/QQl/Rzb7GvrndyOsRAYWLUYH56NVa
         Y/Jn33Ap38jROviiPpOBKllxernuKuuYeInuTvGXMtmPq+l4ktzqSypBvNxkb7Ezvrou
         95NmsghFl/Y4AShDKLkQqWG+cauuLjzXyakpCfCIxDtMTpM2Wf5tnn/MAc+alghqxArS
         S4dg==
X-Gm-Message-State: AOAM530W7RT3caiVPep/IZ14g7pjxkl3+3hXreFBifyR83Ax0PFP+q5e
        LesFQnIJGRHUqxWB0sGO2Qixd6hYm6ZoewnZa1HIG09ymHcyhwyroBCoIZPH3nLKAn+43dglSNu
        5Q0F7ljts2p3lU8XkDykkwJNby4X5nfyfzMqWTTxP0A==
X-Received: by 2002:a17:907:97c4:: with SMTP id js4mr7790584ejc.586.1643043859695;
        Mon, 24 Jan 2022 09:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6bIUyqSYlsbbcqUfcmbGdWW0EqG6ljBFLpi0TFeXsvlHolU79XgsL0Uo+9k2arEBqkIsRjA==
X-Received: by 2002:a17:907:97c4:: with SMTP id js4mr7790564ejc.586.1643043859512;
        Mon, 24 Jan 2022 09:04:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm6903846edh.75.2022.01.24.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:04:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ASoC: dt-bindings: samsung,aries-wm8994: require sound-dai property
Date:   Mon, 24 Jan 2022 18:03:31 +0100
Message-Id: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu and codec nodes must provide sound-dai property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index eb487ed3ca3b..d5cc221787cf 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -33,6 +33,8 @@ properties:
         description: |
           phandles to the I2S controller and bluetooth codec,
           in that order
+    required:
+      - sound-dai
 
   codec:
     type: object
@@ -40,6 +42,8 @@ properties:
       sound-dai:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         description: phandle to the WM8994 CODEC
+    required:
+      - sound-dai
 
   samsung,audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.32.0

