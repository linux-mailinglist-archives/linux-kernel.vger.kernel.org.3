Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC15402EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbiFGPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiFGPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D53F31E;
        Tue,  7 Jun 2022 08:52:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so28868271ejx.3;
        Tue, 07 Jun 2022 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEXLHmzZdZSQqT97E5rj9yP2oHaiAzAxc/2Qzi+U+NU=;
        b=Ou0mU4hlHmOzI6O6tqgil4PAIT4JR6Hfo9ayq5Q/9TNzgO+kII9EX9P01rYqRDz5yS
         4ZeE+pCmgvEvNkVbGYyX4xhMCw+MFEtKowZTRKWL8SAbVm+a4+BHEx1ENTRoYl+qWoQA
         ppmV5vqf1Hq7tGF7wDlXjLS2tOJ4O73JvwnOgegTPXVu667kl3DR4+U9rpFrF+6KVdUY
         BN/uWsPerqHuvWsi7vgmbADmNp8+Qmm0EDC6rLBTpqjrHsfhoY8Uo/935lw+Mc3PcqFf
         vG5i/3nNq3jtvY5shI9DoYSAdLMeXkgfHYOdUDiUjswKo3Evfc8OSeqaiHX+WiCm5DXA
         ra7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEXLHmzZdZSQqT97E5rj9yP2oHaiAzAxc/2Qzi+U+NU=;
        b=yR5ve0gCCNOoy14gs4YorywwluHdwn6/qIxCcnM2wDy5zIeFjQ8Y7AS1TYUH06ZAG6
         JgekfFaSaei7cA6n1CbSD4I7VGyb7RgGn1u9mR2LWjY6OMW/3htLLD/D/fJcwnjO4ERa
         Ue+4OpbFrhCFnyZ36Q1bxHMOuakTQqYg3GOEsZxHBboWon9kAtun1p923pdch156tJLT
         NgFdJHiElvDKLKmp8rzdX2HsI96BCOw/CyqPCDTa39wLDxSycIAEgVHmcdVsvsnpEvYn
         0RhYPHnWUtmHw+zWwJe4JgYd2cT2KtmeKjdTLosTz8Iaix1Vj5ogbMI3Xcw3ZEJXXPwo
         1rJw==
X-Gm-Message-State: AOAM532uouxib6Qnw+2DuJ+13PnbDh8uqdjTfFz1nInnhkgoX1e9iFNR
        VK1gwixxcNuDY0SckDZvGj0=
X-Google-Smtp-Source: ABdhPJwY1AxlzPTXe0cAkEfiwZmSuKj7vTaIpxrvS6OoiuV5CTmqHK5rvtI/UOxX7JKdw1uNH/eDNw==
X-Received: by 2002:a17:906:c187:b0:6fe:976a:e01c with SMTP id g7-20020a170906c18700b006fe976ae01cmr26742774ejz.527.1654617156783;
        Tue, 07 Jun 2022 08:52:36 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id cf4-20020a0564020b8400b0042fbc23bfcesm6600026edb.46.2022.06.07.08.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 07/17] dt-bindings: power: axp20x-battery: Add AXP192 compatible
Date:   Tue,  7 Jun 2022 16:53:14 +0100
Message-Id: <20220607155324.118102-8-aidanmacdonald.0x0@gmail.com>
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

The AXP192's battery charger is similar to the others supported by
the axp20x_battery driver.

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

