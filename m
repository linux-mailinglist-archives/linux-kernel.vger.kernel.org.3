Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD15506E4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiFRVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiFRVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994EFD07;
        Sat, 18 Jun 2022 14:40:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fu3so14593326ejc.7;
        Sat, 18 Jun 2022 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=Uz7O84UAhZvGo5bbE+/NVoZHx/nhpGBwYqjML5R0nFRmrzyWZQFBXVCbWLNaDW5sna
         ac2CQ7dLXb8AhpIaOIr6setm+KZaWOXC85K6yjmQ1Jky35lYcyS8zF3976a93UxPzd0z
         OAvsHvsAJCYzk8y3WMYNEyuh5DkHGdpuitLl+QQfWD7OPfuiy6oLC33D65ENpZdTTTUS
         nd2y4Zo/Wth9LCjAg1R/6RSt6sVhjHpDn4IW0ll3/PEMAomAp3/rsNxgJx+sY2i2EEHg
         SDWFi/IaC2orb8kfhsq9oKDCZLu8Ap99Fr3z0RNjXVkRg4zmlF8awErGLIAcSKGnNxQ3
         WCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZG+WV9b/8zIynOLD+NGGVzMJIIPqNVNIfED/0tYW0ms=;
        b=DP/3ypi60xmvSDN50X2JNJkkC0gc+s0fQvBZ3zwJpz/TWdOvotaGEFHksfeM+fvb3O
         O/0lpDzV3/751r9z3xiVfoWi9voqLeq/NhOm5NU+/MLH6R+skIxB5jZAu97Et1+Cw58D
         WoZpOZ83hnHeoqi45YbzycrrlAVCubGG5rzsLXiHr0QYYU1pw/Q4MVF3ecqx0aLkcmlV
         dVomwTbmWrBaUTmCCxphV86II7IIuy5A7YzB8L2Yxg+PBr7Hpy9TPQk0C5q+MYYgDrTR
         mxwFbE0yAOioymG7adK1+eI5DjLLpH+Aa5NOaV/D93RQ0k3uhWgB7Ohu5nOjBQz4t0FA
         KOZg==
X-Gm-Message-State: AJIora+mcn7XDUfCp8YuErl1gpPA8VXFrICbrG7+rDTMYdFSHtJXZZkJ
        zT/vtEnm8WwarfV9q6TiAsA=
X-Google-Smtp-Source: AGRyM1v++c4MTJ72L8D/IyQXqEatkeb5RGdFPbMSYsT18gVDInP/EyZwk9iUcfkTwNyb30NwLTQsIg==
X-Received: by 2002:a17:907:ea7:b0:70f:a27a:dac0 with SMTP id ho39-20020a1709070ea700b0070fa27adac0mr14847843ejc.25.1655588406949;
        Sat, 18 Jun 2022 14:40:06 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060d6200b006f3ef214e2csm3944813ejh.146.2022.06.18.14.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:06 -0700 (PDT)
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
Subject: [PATCH v3 07/16] dt-bindings: power: axp20x-battery: Add AXP192 compatible
Date:   Sat, 18 Jun 2022 22:40:00 +0100
Message-Id: <20220618214009.2178567-8-aidanmacdonald.0x0@gmail.com>
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

