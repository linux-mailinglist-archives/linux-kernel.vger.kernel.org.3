Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2E5402E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiFGPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344354AbiFGPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831B31354;
        Tue,  7 Jun 2022 08:52:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so36098033eja.8;
        Tue, 07 Jun 2022 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JN5xhLwiBOldWzvgregOvN11Mr2QiqXZtW0+iAWNzDU=;
        b=ZJ3cPU2qkypxdskdyl73XczqLQyMtJv6Oa2h2SOBdAv8Q8f5LDTHp0i9ZZWcQC2c4d
         CuJlztpSVo0wYJeJMj4+PlGgihmqWsDNrSfL59O9Hm4Zwl8gQQvoNLj1DgK1mYqWiX/B
         AGwsv3tOZqnHg2WO0cdaJ2SaYfbjBKlHHvBjMUi3UwOaYNT8GcwnrJoKI94JNkDAjsE/
         9GfKkxwCdbklcMvawXToH/6IcwA4XrupIb4a+rppb/hS+FT4zcsQgZXg0DAIIrVeDQms
         q50UM5GeUEcuE6+ISm+yFtTOX6yL1nhqJ3WyhHbHU7bb7VJG2l50wAh/DU+5tRS0/xpC
         60nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JN5xhLwiBOldWzvgregOvN11Mr2QiqXZtW0+iAWNzDU=;
        b=2GOIrvH3KjK9aOdjc3PEk6vXYVHDSMA4m7lmcAmEjFvGjRQ/45CLB/Q/mcf3IJdszM
         zpcKkWg0ysdp/nmoa7TnNfac6GhqCW8qSKLAgSxduwSHUnu8Eqcm2WizETIqej3to5M3
         zVSQxGBzKeBsqQPFm4bspfJv2h78kFuUg7R1xuL3aTOwba24hCCOCfkOJsXW7Z+GGmnM
         ar12s+bjbPb4Q5hUUYbeFARCyVGa3mfIyeU5dDyYDB6bLK5eB2sPaNCTNGv4h8dN5vVo
         c1q6yrC0c9nH+P2Imi4oik9f0QeQAZTkJ6Pgt2Vq2S8EsBqihS3W2TnP9/m0g9coWcAV
         6DnQ==
X-Gm-Message-State: AOAM5311BcdICpJV+askxWnukJt3oFT+auVsAaQAzC0ocIwkyodLcfbL
        0KY5JvswigP/oVgHG5S9xXA=
X-Google-Smtp-Source: ABdhPJwkchT3sGKbbebT6+BGrpEkyvoUK2gu4V8a7qJv07KhrqvzS5yVWoNY1M1Q1kTAQGPxfud/5g==
X-Received: by 2002:a17:906:c187:b0:6fe:976a:e01c with SMTP id g7-20020a170906c18700b006fe976ae01cmr26742253ejz.527.1654617150150;
        Tue, 07 Jun 2022 08:52:30 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906308a00b006fece722508sm7893877ejv.135.2022.06.07.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:29 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 03/17] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Tue,  7 Jun 2022 16:53:10 +0100
Message-Id: <20220607155324.118102-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is another X-Powers PMIC similar to the existing ones.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 3a53bae611bc..33c9b1b3cc04 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -84,6 +84,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.35.1

