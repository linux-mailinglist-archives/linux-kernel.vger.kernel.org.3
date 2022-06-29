Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8457A560301
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiF2OaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiF2O3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032931EC55;
        Wed, 29 Jun 2022 07:29:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so22763138wrd.6;
        Wed, 29 Jun 2022 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=acwvd10g+JlEA4GvNK/Kdz7Oj5A+muFPi3vh5CoiC+bovtAKJT3lWNpdPhNNTFgaQH
         ojjHfwAVwE9n/5cgi8gk7qRV3oN7t+kf7hg2HmeXw20j+Q6zzcq3skR5YRNE3fBe44l4
         EHSqlA8I7X/rE4eRkj3F+J0BT/a+ngPoHlpGI533vnKEErUSb5I0tknOgWSonejwdLCK
         7JnavG1z6XmZPaqcwl/WNmDXyiTisPFiZu1bGCQBP3EwBwZuoerbQ3vvWC6n4NAdNDnV
         O1jiFHcFdjeCrl8YH7RZJnN8lMhpv5c6P7EXdIlD6n+MKct1tOW9pVPZUeoHKsGJUVNZ
         eCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=nYDv31CHy0zT7MGISjxm5wbj4MgE/CwAKay6tGe0jnW+MoLe5Uh2cKNy7ygdRK4c6d
         Q3N2yKDAI8M4qX5lYzKmE5kWd7zoM8OggpUKNlh7RW+0uqhoHDxMCdDJtJA7qmr5ilv7
         fitdYpsk+q8o8aed9JlMid1KbEMxOhjNmGlm/6VD9805uD8ASWsiCzAAgv0sCwCi/A7b
         zDl9IzHzOvel17S20yrEa/m8PY3Pg67VCJFwbQ108TDOyHoEnk0qzALCW/lrcFEQULT7
         G2S698OyS79/q/+GjDF8naVvDZxRLI03xNBdDyNy++u3CzPbitjurymBr5JLE2qT2lSW
         H6Jg==
X-Gm-Message-State: AJIora8N6I+3dXE82cYNoyaRM9vYhfm5xpEAcBKgWpAf2M8pgkLHpWxm
        LWvEAMJTL+mWUQAiDnlFXQw=
X-Google-Smtp-Source: AGRyM1uFtX4RK80XPeqS9v9Uhu/4TlS8QqTn9bEyqhOjC8/7aySG0wCF38J6Qk3htOroWUcH0bm+ug==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr3327742wro.603.1656512994642;
        Wed, 29 Jun 2022 07:29:54 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b00397623ff335sm3467907wmq.10.2022.06.29.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:53 -0700 (PDT)
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
Subject: [PATCH v4 05/15] dt-bindings: power: axp20x-battery: Add AXP192 compatible
Date:   Wed, 29 Jun 2022 15:30:36 +0100
Message-Id: <20220629143046.213584-6-aidanmacdonald.0x0@gmail.com>
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

The AXP192's battery charger is similar to the others supported by
the axp20x_battery driver.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index d055428ae39f..b7347683a07e 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -20,6 +20,7 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - const: x-powers,axp192-battery-power-supply
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
-- 
2.35.1

