Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819C850B5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446920AbiDVK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446915AbiDVK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:56:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5D554A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:53:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id el3so5141446edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RVvHDXAJWoZDHyRUS5Z8ElTEe2hpFYC3GtKhBW1i3c=;
        b=DAEYPhMW1X5ON+JH43mht/kUU4C6srvbBA/LeLZFJYM6Ty5mlofoQ+tF2erExLjFw5
         MBbOc4gDfqmeYJa9mDoj+GhSEnrIK30zcPrqy7hS1NnSz+bNqyDPW7eIS6baU94VsE8C
         oR+FTl86haRpvRKPZT8UcmQOIzh2GUcuWIHCuU1DH0wvJWRIwvrdaboydd/s6924jqRV
         nQ8L8jsiJaGH0BEZCqyATSlYRJq6YgwbWcokz4dqJBnNMXPlzoQLVwjsJAQiRqXnXxf4
         Alz/rXJdLLvgxBFFq7u/YF2TGMj8aD98QUwJ7N15kLxLhXXFu0KHnXKoex/ge22wvctX
         Zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RVvHDXAJWoZDHyRUS5Z8ElTEe2hpFYC3GtKhBW1i3c=;
        b=qDPM2OjUPNVFOx5hJRB+KOxgbJtzaHWoKOSlvMVn2oTNfHUxIn48VxYa/O5+W5aDIN
         9AH7B4uRWtKSuWGmg9Vl3Row715KPhoLBBdIesHRkvk2lF6lO76PIFP34b4XGAWnHHCD
         EpkbtRfk2dL7jf9UANO65snZniwFySZ0SRtmha/jAxGaL2LQDHDXmo8Oq5Gof94JQpMA
         UzTozjVBQUNmO3P6CL7INmXTVc4REVyYNt8AIZ79l4Ci7BA+6zSsvsqGzc1WMowrvhmW
         3slaxXzQ50TgE5JMV0JP2sNH7WBSfKs5pEWV4brbJqtuN6vizVflzZoKmKuSYlFnsk5a
         f6yw==
X-Gm-Message-State: AOAM532jxIFW2U7yhueHUkh1mRtrQDoN1LZ2XsmOHolNm8pRwF7d3Cei
        ZexH0sI+fnElyfMve0bPAMQWmA==
X-Google-Smtp-Source: ABdhPJwJbC8CLWWjiAWNzVuHtDjzfdxVLuA/zVjfa32D4147wmidhZOPRaD+SM0A9TlIvAwtjgOjaQ==
X-Received: by 2002:a05:6402:190d:b0:424:494:e217 with SMTP id e13-20020a056402190d00b004240494e217mr4230721edz.82.1650624826923;
        Fri, 22 Apr 2022 03:53:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gr21-20020a170906e2d500b006f27265cf75sm492934ejb.78.2022.04.22.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:53:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pinctrl: nuvoton: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 12:53:39 +0200
Message-Id: <20220422105339.78810-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422105339.78810-1-krzysztof.kozlowski@linaro.org>
References: <20220422105339.78810-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 3cf0f8a43c37..6271eac82fec 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1898,7 +1898,7 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 		}
 
 		ret = irq_of_parse_and_map(np, 0);
-		if (ret < 0) {
+		if (!ret) {
 			dev_err(dev, "No IRQ for GPIO bank %u\n", id);
 			return ret;
 		}
-- 
2.32.0

