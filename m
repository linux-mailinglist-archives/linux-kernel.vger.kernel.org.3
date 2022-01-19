Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37F7494185
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357262AbiASUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:10:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58604
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357260AbiASUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:10:16 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F1BB3FFD9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623015;
        bh=/U9f8dPD0Cr+afsp5QbiqjtMEBMAYndRUEG/KOD6Wsg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QwhXUBPJY3arxS8uKXHf216WX48cvVL/vjmEfSJwfUxhFhHZQDkUMbFZs+MGc00O3
         C5yvcnJjjSH0sLk67CjSYUrFcCzA4mtnrOsAWno4vqMM/BUy1RW0Aj7khOB6XzyOQl
         GL/L8r7+dFocM8kv1fSMHB22+r83jWnTjHB4kpzSkdvOVcm7yHLbTtf9mob9+WwIDp
         c1jst65JtmxzYh5u57fjqaTk9ia0mL4czN6EwLmYF+u/yy/V4AeVVSMOvwZIZ+HPje
         nDIQppkVaLZvQ6eYFNGeHqon8mzTs2ZSey6zb6WA+rk+nmVyo5aF6lzCpNDjIGapul
         e0UL9i/OHVmCA==
Received: by mail-ed1-f69.google.com with SMTP id t11-20020aa7d70b000000b004017521782dso3686076edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/U9f8dPD0Cr+afsp5QbiqjtMEBMAYndRUEG/KOD6Wsg=;
        b=ASL/Idns0Pp25aVfWtLodDvhv7zAoXUG2/fqHavjf3M4s2kMoy1vntL8m1nuvyUHdS
         LM1/za94I8IlrSPRZQE18CNd2LhShldt0kGrjQn7oVCtmLgNk96dV252WA7PiUhILbwa
         d+6AzgI0kwr/FlFG7s/cKGqgZ0wwWOo5p3wxwPUFt9yMj1LgejFBV4VB8NnmbgUg6Vp5
         cxj3IXOvTN8GA++KxJonUlHbduZNtz0NEN+96egO/z5EPJs9ZIt7vJzCisiPgod2zpB8
         0eCJwwJc6iMMtXnjo7Gx6mAUNAkhoFrKm5lBzj6pK9erJFi45saTsFtrd1NIsWk3T2hs
         sDig==
X-Gm-Message-State: AOAM530qs6dJZL+g39an4jJ7azg0o9xI7jOzHA/IwCOk4MmCr9C+8gAe
        S3re/+5U8jHF8Yjoe5mPHx4A3BpzOKQgDwXqKsMhRXneh7/Ja+bIZxBcQaLcshqmdjXs5Pj6hua
        ba/HZS3GbLvtIlsG17TiySmAaC8fxxb32/xf0/RzUgg==
X-Received: by 2002:a17:907:3e8b:: with SMTP id hs11mr25905129ejc.461.1642623014932;
        Wed, 19 Jan 2022 12:10:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6G4Pcq2PpBiIWNzcOvMneMjKv+CbHSXvc3Jt8O4GTIE1653G8oTh139/uMfxxcKKERqZ2kA==
X-Received: by 2002:a17:907:3e8b:: with SMTP id hs11mr25905113ejc.461.1642623014691;
        Wed, 19 Jan 2022 12:10:14 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:14 -0800 (PST)
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
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 3/5] spi: dt-bindings: samsung: allow controller-data to be optional
Date:   Wed, 19 Jan 2022 21:10:03 +0100
Message-Id: <20220119201005.13145-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC SPI bindings requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
index aa5a1f48494b..cadc8a5f061f 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -28,6 +28,7 @@ properties:
            - 3: 270 degree phase shift sampling.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2, 3]
+        default: 0
 
     required:
       - samsung,spi-feedback-delay
-- 
2.32.0

