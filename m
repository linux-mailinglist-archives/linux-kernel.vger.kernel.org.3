Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DA7568540
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiGFKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiGFKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C2205EA;
        Wed,  6 Jul 2022 03:18:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so15039709wrv.10;
        Wed, 06 Jul 2022 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L37cZqiPeh61uyBOeFS0ogTNZ+AXYHDO+L87O5zgaec=;
        b=T/lN8QFr6wdOyYmuXuyCXh3kbrxGt8Y9hyMgoMsIfTZ90+nuSOYbqhJtHz00+kIcBf
         obDtY4vgrSJPkEQc8GOZD/219YXDSoUCD8IZg+op9MjecLB9aTaoQsfktn5VvImIkGHb
         gS0WBM9MZ6lTBIorRE4WKrM2JYH4uZPfx8vniThwjsIGUWrWu/Lu01ZoXfI/PlEpIZKp
         UY0KdpRjRL0QwMFHfLvNnztP/ZuPkHQSAmBRysXjdzbvXVWuaIbYWBVdBhaUOjrYl1e2
         NNx5SAWgjquSTaKoH2DV8AihqwYnTg6NMVcJyIn22D4Qp0k+CB04Hq8kIzTkxBckbigx
         FwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L37cZqiPeh61uyBOeFS0ogTNZ+AXYHDO+L87O5zgaec=;
        b=o4uFT139rpwGh6+CPjDGQimCazkOin7987Uxu878kfYZg/tfcgKSKCxz4EiUcck87o
         k7IzKY4ZFi5j1secwKUY6WgBUKJstzJ2igw0xLQOZe2G49HCfNAuusWVHBsVePvfFHiw
         0zjhiWURdeDNe3ABqrDb8itLmnnZPVRKktnYAaQsw9fIx0BlIXsk44AoJU68E0mbVzKZ
         HGDqFesePlR5e8xYpeGOIqtl4abMEOn/nVfIvDoVT1P+HMumDZCOH6rzkyd4Tt3my0kd
         AALfR8ObzQ9jk0A/I4q3FSgyIxD9CtdYax/sXXMp9wqNriLpknG0Lc2SEIXnYvgoUgM+
         1dVw==
X-Gm-Message-State: AJIora/9celharNn+5cfVtosKXC6hscPrBOI/5xdZ07Ri0fGUJgvXhc3
        sQ6c54anWxDC4F1uZxcMq9CuIuXuZGI=
X-Google-Smtp-Source: AGRyM1v06F6rMF2tQC8E+DP0wpVLWt+X/B9q6Oi4FT6T542jjyXu7mMfS79YYKCyAmHQOp3GSuGesA==
X-Received: by 2002:a5d:4a92:0:b0:21d:7788:c376 with SMTP id o18-20020a5d4a92000000b0021d7788c376mr5394409wrq.173.1657102713460;
        Wed, 06 Jul 2022 03:18:33 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b003942a244f40sm22648140wmq.25.2022.07.06.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:32 -0700 (PDT)
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
Subject: [PATCH v5 02/13] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Wed,  6 Jul 2022 11:18:51 +0100
Message-Id: <20220706101902.4984-3-aidanmacdonald.0x0@gmail.com>
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

