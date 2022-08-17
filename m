Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8C5969F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiHQG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiHQG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:59:55 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAB7548D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:59:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u6so12694748ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T8mEAjhvSuf807GzmZdtFyBkcO8AriF01XtEs+oENyI=;
        b=ZDe4f8rBRD/nLRfATuXlKD5cmTgKTlfaGSgxw8cogZ2x0CHVjVhJfPwSBHK+EdjGd9
         gsAXmXv2X2QtxNNkwpe+VR/0LSSt2VlDkJecLNDEKzhrBQGWuW89amSFEUHmUESWrt29
         gApfl4NFqrKbfhBzg4ggQhoX4giYs0cqu6HprqzccvVePc7eJbdgyEta3+NVpVIkMs7z
         PuqqlrOLjIXGOx1oBNkqS+uZDZiohlZP3INg4T2lwXs/OMZEEKcvMtkDbzkqFbNIZCcz
         RqBb4cLiAQd0n7MoOmggTGZfv9Pfzz1zLMkYR51mUmEXeUAkr7R7X9kP6LVE9zhQ8BBA
         F5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T8mEAjhvSuf807GzmZdtFyBkcO8AriF01XtEs+oENyI=;
        b=7m7l5Ea3D7sVtWT2s5uemd7ZzpVw+7+8+4pV/oRu0OcdIyo4FsuQSxYId0C9x0ONqP
         geYk06dZAgUlpbYwQ1cvZDXqvV1uCtxxmwZnwc/wE9QCPFcj7vBvY7b95dF8GPjK+6Hn
         uZlX5jLNaRD8hBRWTLKrmXHfh3f6ZcixgJcxIlBHO+MraiaFXjeuotiBmmz9ks0j3S++
         bGppRDHyI2qHg5MEW+VVlr1Kg6tzdgCvVcZx80A/qjSXy7qZOYGuwIBn7zuvduoQECPN
         kMfoX3VaYwdjUnGw7N0hlUU3om3N5r9seKuRblXv7TPkBE9vGnGhxlzc6sT24EYsdx8x
         7fmg==
X-Gm-Message-State: ACgBeo3DZrjyu6miskB9mJ+2Lio1M0LBMT3U7lg3IvYxiFHsiCcWPZcK
        nRyZVG2d/3ZPiZDfnc1naaEkmw==
X-Google-Smtp-Source: AA6agR5ZWB4VyEsHr4MsQ8nU9jhFKRqPQT3NKS8uS+134p7RR8nZdMXG+PIf63s3ds+fiiGWKv2eSg==
X-Received: by 2002:a2e:9415:0:b0:25e:477b:adc9 with SMTP id i21-20020a2e9415000000b0025e477badc9mr6957078ljh.109.1660719592462;
        Tue, 16 Aug 2022 23:59:52 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id o2-20020ac24e82000000b004896ed8dce3sm1599480lfr.2.2022.08.16.23.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:59:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez
Date:   Wed, 17 Aug 2022 09:59:46 +0300
Message-Id: <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
References: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
Access denied:), so change maintainer to Peng Fan from NXP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
index fc2e7de10331..519b123116dc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: i.MX8M DDR Controller
 
 maintainers:
-  - Leonard Crestez <leonard.crestez@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
 
 description:
   The DDRC block is integrated in i.MX8M for interfacing with DDR based
-- 
2.34.1

