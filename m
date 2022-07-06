Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507FC568518
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiGFKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiGFKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604718E13;
        Wed,  6 Jul 2022 03:18:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k129so8574368wme.0;
        Wed, 06 Jul 2022 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJNTQf7wx4UpBpK95P+gz9d+4LtTZzJuXzrg3Y7Mt7c=;
        b=L2NeBaoN7El73L80ZFgNLUvFZs7jMts2IQmJJGctRO/RoZnAyB+GEk1A0kRyUEc31G
         mf7lbH0+jk4mC4A7J+nmLX+RjUPrXmp8Gm8gWSnVJDHep928/AV5h1xTHON6zqqPjsXc
         Zyx55oPMz45az70bhN0r8otQF7CrR2OEybnYYIfVoKAZoaOm6MBAUszTjD4jmnRKDibO
         6vZWA82v7oj+0D1jzJzAli/aKGlbyEk/Q1g72WolWjJaZ4JbzY2yOuZ7HUmt9FprA0yR
         AVzz43s9QSzIs8hNOKYBoXWre/SiwtvxUXPf6l2hv6zVsJtnbLid6A4mxGioiG9Mb1lc
         HcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJNTQf7wx4UpBpK95P+gz9d+4LtTZzJuXzrg3Y7Mt7c=;
        b=u34zs6MXVb3W6dTKvgT51Si9lxgbix/ZPoehghpkylZqFTgpWQeWEyLiU45KywTIMG
         muWNRzhtIhoNRhvDFPm8yWMrGgHbRNNSLFHNzBQnA5XYZflEx3+KtYOF62rX7nTj2ER5
         k2fvx1TFf2lwnJeM4aI2xyzELHRYAIyfeFeTBEb159BswdqRQHCeYID50bz+8kbOWTRT
         XHSW5YfX6O/ziFJ/dW15v01ssBIhJSPca/MFDkYYo3aDlOrCNpV/Spvf+gjHNNUYTJOS
         4Ol7iDQ8qowjVOWaKVirI3MyvYWiDNTl/yuhIm49LvvLLjEMr3qHIi4ZXH2R7I4cPgxd
         pSXQ==
X-Gm-Message-State: AJIora+DtQCDleqQ3t6UJ9mCAi2hECDFA70yuzbxJLZXUP0l0dWDfWAL
        F1kTVyILxV+DHLCaoEIXgs0=
X-Google-Smtp-Source: AGRyM1uYrafmUmR46v+n6KVJxMJLJCN91maIllVX13nkm80SypCmhGAuLKGIO3OdTUR9bXdrK0zy5Q==
X-Received: by 2002:a05:600c:19cd:b0:3a1:77b6:cf1d with SMTP id u13-20020a05600c19cd00b003a177b6cf1dmr37825084wmq.141.1657102711717;
        Wed, 06 Jul 2022 03:18:31 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id i30-20020a1c541e000000b003a032c88877sm21478518wmb.15.2022.07.06.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:31 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/13] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Wed,  6 Jul 2022 11:18:50 +0100
Message-Id: <20220706101902.4984-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
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

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
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

