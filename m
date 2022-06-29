Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA35602E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiF2O3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiF2O3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF3E20192;
        Wed, 29 Jun 2022 07:29:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so22763138wrd.6;
        Wed, 29 Jun 2022 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L37cZqiPeh61uyBOeFS0ogTNZ+AXYHDO+L87O5zgaec=;
        b=Fn/Pq/hUbOZOjDhQlZBHXYezZ9/Q2v89EsCo8X5XOMvU8OdvtRaNWMVO/mGBN5XOWy
         /HiscbvEtPx0JIb0efyvUtD7aiZX7pnGivh/9tKgJ/9DaJqyz7qPiu8PqbeSwmPreiY8
         BSL8jAsi6mUGPH42fa6FNAG6Zn/JTFSDI9d6FqsKg5V+15Zl5O2nC2/NPjchnIk4sb/2
         BN2Q5mNfAOoYIgC8eSAIvTdacy1pR08daNlyMQBP9jBBHx+jZc19KhbO/lzYKlj7CjcA
         lW2H0cjLjVO9/1UyQvB4K4+ZsJd/LdEkevT+kgpJpcQ5bpheSE7e85xTe/8xCF65dunE
         IucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L37cZqiPeh61uyBOeFS0ogTNZ+AXYHDO+L87O5zgaec=;
        b=zhtui8YkdTrl+Aj8/vTas7wxwQijWlEL+2hNGE8Ql0lIDetdG+ixhYdWUfJgqCkTzW
         Fm7Zpv4R1t7pVi4nr3L65iRdXAqq2Eq8k4iJoP0gioBVXQ1lC0/EcWOda066Ik/0+l4/
         itQ9reFP3fQ9xd+MkFVq1m4VoZ/p1LEfWur9QF4u42OD/4z2LqNX6ZGb6mHXaap6fajx
         PG+hVRZCKCF7g8JH+u0nUVVSDVwyVOrIIfIxgTvZpgoVA0PMJ9nuWYBfokkMwLJeU7mK
         ILg9coWx+r5bZjUGeg5luHTwSYIM/ZoYq/P+Sb0tx7nxpTqjCESaf0EgJ5Wdz7bYBAYt
         qpLA==
X-Gm-Message-State: AJIora/TtPjXIAkoBnexmtkKoDYTWs22Q8DKheVIMrbUzoCmbrKgx2JQ
        w4pGccLjbNsm8kG4dGeV6Wo=
X-Google-Smtp-Source: AGRyM1v1FxbDYISKvubRumj862hkSIeXFrs7F7HvRvmsrMk/yCB5ZVU0GiwPC9R/2m8cJUbnGFyLHQ==
X-Received: by 2002:a05:6000:1888:b0:21c:9a16:5cdd with SMTP id a8-20020a056000188800b0021c9a165cddmr3446851wri.562.1656512988821;
        Wed, 29 Jun 2022 07:29:48 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id bq8-20020a5d5a08000000b0021b903a018bsm12903452wrb.92.2022.06.29.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:48 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 02/15] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Wed, 29 Jun 2022 15:30:33 +0100
Message-Id: <20220629143046.213584-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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

