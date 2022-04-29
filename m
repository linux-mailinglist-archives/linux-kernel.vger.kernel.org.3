Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE22514231
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354427AbiD2GQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbiD2GQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:16:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF697E5B3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:13:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i19so13455008eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVdXSHSh7EwA/4nqmLTvK4Lay7sxQolbudvBwlJyLB8=;
        b=gQOVoQeNfTBai5DFopXLol0qcvPH+FLsNpUjfjRfy2qL4OVU6Q2vYHplc1VNAQndU+
         YGiPmTXclJbU4IOL85DTmUCdIatSO6fYbIxAZFPpOF+vVGtfaiSqKyAK6L9i8ECLWZQi
         QHZwtzEBVay2bJjvMWpccuYhjoa5HJupJPBlPjDS4Jlx/2I2mviW5AGFOMZjC55d1C6z
         OKaKSsdJeqAmG/MvHfbYOu9XUHKRoVMRN3NPLfcc7OmcR/P4z0hrC+h1ZCiDwkvZCGT2
         eanOlarvyLc+gGwdUzSeZns0Gg6fRRfiqZaflrPCftX66MRzTi7t08lN3AJ+MIlhqUbN
         RU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVdXSHSh7EwA/4nqmLTvK4Lay7sxQolbudvBwlJyLB8=;
        b=cwVv1Gf7H8LeTLA2IC5EUqnb57a0SQ2FSM5E4QgPtMc+0YLLAUyOT6puBtJnU1BFt8
         HROMiQhcSzkpjEvD74W6O3aX/rzO/3q6uT+NbWYAxoT+1mw1vNsKMwSLERzEI/Fz0mo+
         pZpg+s8QB1n0y/2x+DRXC5EvngAqi6BrESlodBPB5W8Y4oPdGWpB9koKDBAD66+fHNog
         1PKSP/IOwsqX+qT4A4JMfy1iiJGFHHI6WL8mV4al0XOyzlf+3KXZtOz66+c1veVpg0W1
         1sZ4iZ8aamd4MNM+EOPq6yuh35vjaqpCG+dM6WDtVuFeIIU7gxlZjvcriY5QHRo2Jido
         ZWkg==
X-Gm-Message-State: AOAM533DpA10jPDREK03sz0EsoKQnszfMKGY6rfAQlcAVjUJZ3/1JCcK
        dHmHZFH9AiUpTeTiigABX6kfgg==
X-Google-Smtp-Source: ABdhPJx9AFEol2KkE4AyRlTaUgsGtUiyykZiEpX6D8UZc2S0zDAJ2YF4sSjK1LMV90bxH51xflHx7Q==
X-Received: by 2002:a17:906:a0ce:b0:6d1:cb30:3b3b with SMTP id bh14-20020a170906a0ce00b006d1cb303b3bmr34598141ejb.582.1651212805367;
        Thu, 28 Apr 2022 23:13:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg51-20020a05640228b300b0042617ba63casm2469039edb.84.2022.04.28.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 23:13:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] pinctrl: nuvoton: Fix irq_of_parse_and_map() return value
Date:   Fri, 29 Apr 2022 08:13:20 +0200
Message-Id: <20220429061320.25032-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Changes since v2:
1. Rebase on Linus' devel branch.
   Will later conflict with: "pinctrl: npcm7xx: Switch to use
   for_each_gpiochip_node() helper"

Changes since v1:
1. Correct the return value passed further.
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 9557fac5d11c..44b77dd06d90 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1879,11 +1879,10 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 				ioremap(res.start, resource_size(&res));
 
 			irq = irq_of_parse_and_map(np, 0);
-			if (irq < 0) {
+			if (!irq) {
 				dev_err(pctrl->dev,
 					"No IRQ for GPIO bank %u\n", id);
-				ret = irq;
-				return ret;
+				return -EINVAL;
 			}
 
 			ret = bgpio_init(&pctrl->gpio_bank[id].gc,
-- 
2.32.0

