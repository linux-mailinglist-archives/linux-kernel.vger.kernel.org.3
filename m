Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95148582EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiG0RP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbiG0ROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:14:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F977574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:42:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so5000632ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KzYOY2dB+nJ4Wrasac8i9wLlDQ6Egt9GBa/do8G+Sig=;
        b=K9uKvk75SJSfedHogdY+kWH/CsEe/wSTIPBB8eidVqGxr8FXX0fnBnnafTEoJASqQJ
         RaRG5tZJjdpbbu2xJkLg/HYItJKDJIqsavU8GE7u0sMaidntxyIak+tzCQn7fq+YqNvg
         XjE5ptccosCYau06VrSBVIkvoFpc7xRveMXYNZ+2ZlpfaILOpJnoWLTxphoTlRfcNEj2
         PW++n4ci32WZtTJkwiFPKoibx+hzJOjqHV7SI2lCHrJ0N8ZofhOeDnlagmGYfi8hgiWz
         p0FkuVR/bUtB0Dwo+DAoxbd2ugzgly77uA9utvOfbC1kbfgcCR3d6qQeFesv+ns7jaKE
         p8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KzYOY2dB+nJ4Wrasac8i9wLlDQ6Egt9GBa/do8G+Sig=;
        b=jtJucIyKTHVvm4cgcpCnOTKNTk3pVFybIyWEX61JpmY0gjFmfeFSjfye8/r9eW6dUR
         iRbaQH9FKzrtMJRKm+5zeO0xBcyj5U9lanZfGRuQt93ITOltXubXDf77YZ1bHxGOnI9Y
         +CG6RCLy5MiHEcrWJ+RwBmsUpoQTlB4cbWrERLH2wq9u8dGo8OR9f6TbINs65LoMb1ta
         B/hV0qmChFufeCg4nuZcwN/t2sHjJ++p1prYTpQZkeZ2dFyV6yiwOEOyImZFJuLNSWjj
         21Aqk4+U9mJXzn9YUfy9YF3FEnBIjZSgYXzoTq5oMNIk5eEbFT/QNM2FpdwQiueHFiwJ
         rtZg==
X-Gm-Message-State: AJIora/zYo8Ig3ASFD13bsVbKbMGQp1nqC2KZkTZmTCDXRV1JgQOu2KM
        yWud9UVzzMRpi6uWBV8U7Lq90w==
X-Google-Smtp-Source: AGRyM1tz+0k7fZ2bna3hFG6H3YS6grlcQvMVem+eMziNNndSW6tc8FrubWz77g7n/OurMqXq4uHOwg==
X-Received: by 2002:a2e:3210:0:b0:25e:b6d:4d90 with SMTP id y16-20020a2e3210000000b0025e0b6d4d90mr4717724ljy.282.1658940159071;
        Wed, 27 Jul 2022 09:42:39 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 197-20020a2e05ce000000b0025d70efeaaasm4049508ljf.75.2022.07.27.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:42:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: ariel-pwrbutton: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:42:30 +0200
Message-Id: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.a

The binding references also input.yaml and lists explicitly allowed
properties, thus here reference only spi-peripheral-props.yaml for
purpose of documenting the SPI slave device and bringing
spi-max-frequency type validation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Technically, this depends on [1] merged to SPI tree, if we want to
preserve existing behavior of not allowing SPI CPHA and CPOL in each of
schemas in this patch.

If this patch comes independently via different tree, the SPI CPHA and
CPOL will be allowed for brief period of time, before [1] is merged.
This will not have negative impact, just DT schema checks will be
loosened for that period.

[1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
---
 Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml
index b4ad829d7383..442f623bb294 100644
--- a/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml
+++ b/Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml
@@ -17,6 +17,7 @@ description: |
 
 allOf:
   - $ref: input.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-- 
2.34.1

