Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC555070B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiFRVk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiFRVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA4BEE06;
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so10359641edi.1;
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTWYl8eFVS8V+tgK+PG/nLpDdI90oIP74gTXXWq0/OY=;
        b=bb2uMIjvHoLD7jBaZ/2he+6IOIwbhEvRTuFtKkWCMZJkzus7XWK2fddybnHk2Kid+L
         VI46zHN/7JFPxxx1zcFySiGJOyVtSPa+ANZcMsik8j7DLgY1QddGgVAQULJXvN8JW/DH
         e/HrucOmcCCDLIVCWVAa6AdVfzM45vCTlOmioSTK9vZQhx/5FTu7miRl9PUPL+3Ap8v0
         Ix6sBS67M25cmz377Wium2u1hRKm2mssXVwf0oegkGPK0s5rV7QwxxJUcc7PKh16QI4i
         iAQ9mujPbTfHUTrBbLcyTJWz6XfdPao33EpTs2Ap1ZHxNmR7UdNmzSfhW9DoyRSHJpi2
         y2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTWYl8eFVS8V+tgK+PG/nLpDdI90oIP74gTXXWq0/OY=;
        b=HQQB1ZbZ7O8ir/Nx4rbJLKAgpmE2mobauSjE5xT9trBVKsWh4zdq0Ea5fqpa8Q23tz
         ZhsDV/P8UYdM0Rx49t/NxvbkpzuHeasCo7B48DPmtOgPcDuVMrv0l2t77iXLXUhV7F9s
         bt70BvAf87lhCgLB0/Bu1GuU5WKx5v8eqNQZqd1YPdbhB/qLoMnYX057oCgeJ13/PVP2
         XXuGwM6QKOZRDvMje7JqXune/86VJPXYYk49GExPmst87hzpZY0CSWrxwnxFfWqQvFZU
         q9IuiUywcU0hSc2FqP3HiHMhcqI0PfSUPyq3QkotziRd8dmvU4Wtgf4XPzpCMy3q2VK+
         5Neg==
X-Gm-Message-State: AJIora+rm7mlCaLfUyEpuQ14yBHlPjfjiAk2doF/JgWjFrqaCw04NARz
        aqDahJWVKuuc+DpnjYQkay4=
X-Google-Smtp-Source: AGRyM1sgarex7+gRyKI/S0vDtIF0jLSdAPGscGn5Pk6VKI1/cnWJDDQaMnsJ6tei9akXm5MVK6b+iQ==
X-Received: by 2002:a05:6402:4386:b0:431:9cc4:1214 with SMTP id o6-20020a056402438600b004319cc41214mr20255510edc.45.1655588402550;
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0071cef6c53aesm2893165eje.0.2022.06.18.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/16] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Sat, 18 Jun 2022 22:39:57 +0100
Message-Id: <20220618214009.2178567-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is identical to the AXP20x, except for two additional
GPIO ADC channels.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d6d3d8590171..1a68e650ac7d 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -14,6 +14,23 @@ description: |
   Device is a child of an axp209 multifunction device
   ADC channels and their indexes per variant:
 
+  AXP192
+  ------
+   0 | acin_v
+   1 | acin_i
+   2 | vbus_v
+   3 | vbus_i
+   4 | pmic_temp
+   5 | gpio0_v
+   6 | gpio1_v
+   7 | gpio2_v
+   8 | gpio3_v
+   9 | ipsout_v
+  10 | batt_v
+  11 | batt_chrg_i
+  12 | batt_dischrg_i
+  13 | ts_v
+
   AXP209
   ------
    0 | acin_v
@@ -50,6 +67,7 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-adc
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
       - const: x-powers,axp813-adc
-- 
2.35.1

