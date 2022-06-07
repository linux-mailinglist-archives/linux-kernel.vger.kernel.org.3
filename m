Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801A5402E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiFGPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbiFGPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F743EF9;
        Tue,  7 Jun 2022 08:52:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er5so23553305edb.12;
        Tue, 07 Jun 2022 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3/ArNj3Gx6ysweu6QmWCkRaXZNp/b8pZqhl3nfQBWw=;
        b=UsMhWaiO2fkpM4Yapfx5SEztkIqvpQigF3auKVZ0gEXeCdCQZw9y8MnYynSqc7TQU3
         0rcp1/xbcNRJtM7bIx516KBZ33Ae9fQ/U6fO+zI3EJ40oQx87siSg0LL/JeYjrhitvdJ
         HtjaIeDp2+qgIXWL6MBduefBczoFO/PZsC7uS+URPzwxHGDXP1g8kPQ4DtZeVCCar0Z1
         XiJHkEQRCAMyuhfnASmU+7ShokiGsu2TjJjU+ZQ9JvXjsM3oRMegGKOf22nBdTkM+uJf
         GUPE/NT6rxw86Iydrt5p9x+cGPWSLHbxaWSfj0BcConM/tQUWt01dQ9mDkh/k73afp4w
         p4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3/ArNj3Gx6ysweu6QmWCkRaXZNp/b8pZqhl3nfQBWw=;
        b=x7M6CKgVq+qoiTwaSS4G/T7eTpXFanounInv8fQFMQQyaa3Nz3QxhYESl09BRkPo3R
         jGI1Oi543jhePeG6G9vYhw+78d8Q8Gh4GRC4apLzs/ZSdYTUpJzjovAkFjBD0j56mDci
         yH4EOQB00Lq2+4oFDdnj4VGLqQu+ltXpcjYjnS3EzWoL1F0Oz0wM7Pc83RVzbnNJ/iPd
         k5dbJGeHZUynGW/8DdQOJssY5xeqDTbwb3BBzFopgmwgeM50EBGLB52UH6yrE6qvvjFw
         loaTGdeOreKUoGeKHpb4FKQQ7eJq0gIe24G3K/X/rXLywgsPYO2QW6sGAPEX6qWPpEn7
         NgJQ==
X-Gm-Message-State: AOAM532V188+3J2OzGnMU/nTZdumYhK58gPwYGlzlCF9okliPhrPczpy
        RVwVOGup9VJ1o6/dx4XISrY=
X-Google-Smtp-Source: ABdhPJzEggWR5iwv+1zMa4+J5JWYp+qT+YOij72pwmnzUeUi2YugZUts1AB1bnVuJvlIHVxOExvAVA==
X-Received: by 2002:a05:6402:51ce:b0:42f:41c6:4d70 with SMTP id r14-20020a05640251ce00b0042f41c64d70mr25640623edd.335.1654617151752;
        Tue, 07 Jun 2022 08:52:31 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7d147000000b0042dd792b3e8sm10659503edo.50.2022.06.07.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:31 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 04/17] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Tue,  7 Jun 2022 16:53:11 +0100
Message-Id: <20220607155324.118102-5-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is identical to the AXP20x, except for two additional
GPIO ADC channels.

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

