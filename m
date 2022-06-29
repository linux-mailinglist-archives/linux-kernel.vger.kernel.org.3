Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D065602EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiF2O3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF2O3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9F1EC55;
        Wed, 29 Jun 2022 07:29:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r20so22782131wra.1;
        Wed, 29 Jun 2022 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJNTQf7wx4UpBpK95P+gz9d+4LtTZzJuXzrg3Y7Mt7c=;
        b=AYU+MwgyLByuAmknrOSdWfRXNOnJYrfon59biHEvoKVbu3bIzgKbSutHxHh7LyHfC+
         Np7z8e7GVpFNH1utmFHS7pw1TrgXifW25dkxBC98hR8yJz3rbDOownuhRjKHPLJDGLhQ
         oUgkN953SAhIRw4VwHbWurpSXtpAzzwIqPRE7uZ/sfN+UWLjHHEO5E8cWPtEX0634C+Q
         OlizGcMLmhXoKkxj9d2HAqqfM3M3CmNpj5FLKnz+0qoECs4fD6x3W1Yxg6PBkZfo1XEc
         IeYLM6bGd4vFbNqwe3BS9CbyZ3rTctNwZOaia/+WxsCn+oXc00zN5+HcNjHG5laMk6gl
         Jr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJNTQf7wx4UpBpK95P+gz9d+4LtTZzJuXzrg3Y7Mt7c=;
        b=iYwz6i3Tn+M/ubEYYKFMpLqISgd4xnOV4JzpXea2GW3dkWfbq/VzN3uAZhgF7z3OEo
         0DQRKmbpmiQkTMOMJKB6DkvzHDj7WKdEzrcLlNeN07EYtQmYWxKz65iyB5rRQK8jgWm4
         PQvuFg5Yo4BiVXUm5wnU0uMSre02sUGG9zFjf3eRBLecmi/WJqJiSpEn1iKOFy/yozLQ
         g6npcLHt6d+Rnwx0qfK1hdEUZUntk3bo7uS0g8jMZgXU7gU7GkrqUTb6WXWnkrCmJI5Y
         qJ3ZVXJ6xUkXD87HiZod+E3WQFEpnVq7vqaaDSmftKrB+sRWyZcWo81H/zNrXU5p5JiW
         JwZg==
X-Gm-Message-State: AJIora94PuC0rZBvUq6XPEp5+dcMAAM7fV1WHz1p6J3gCDIN7rwgW9rF
        KF3ZLpzaFrjOHjMzo8ZBza8=
X-Google-Smtp-Source: AGRyM1sAUHHusomS3GLPEpYp6RNLaaaU8yv5kidsSF9bXSVny3h7Qk0Vx3Qxa3I0hf4NoDs7jY11ZQ==
X-Received: by 2002:a5d:59a5:0:b0:21d:205b:3c5b with SMTP id p5-20020a5d59a5000000b0021d205b3c5bmr3461203wrr.97.1656512986736;
        Wed, 29 Jun 2022 07:29:46 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b00213ba0cab3asm17130495wrt.44.2022.06.29.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:46 -0700 (PDT)
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
Subject: [PATCH v4 01/15] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Wed, 29 Jun 2022 15:30:32 +0100
Message-Id: <20220629143046.213584-2-aidanmacdonald.0x0@gmail.com>
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

