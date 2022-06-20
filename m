Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56E55257C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbiFTUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiFTUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5138F201BB;
        Mon, 20 Jun 2022 13:06:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c21so16101137wrb.1;
        Mon, 20 Jun 2022 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFyu5esk/Zb2lNQzmvPRJ9QuwxnaeJqoP/Ih9wxKaVE=;
        b=Hx66dBMoypw3HFQ6ZlYKo/eR568ezNz8W5y6iElQBkDHOOhjdkd2OOUeXyuM4IJATJ
         nOWdw0iuhlEmOX8vNXfnAWlMC147l0U4mfE3S2gNMusmdyP2zWZJyHYTvmwCppX/Iskv
         vwfm6snjUXGKxpT/jRbYfj6RIQgagfupLw7jvBu/UAvy5tQBhPO9eQAGfcl+0IEp9k+M
         wAT+eo4bwJp8EjwTVNo5vMEs/MgiikrzJ6fDgsNBPx0jramgLds5jhx1zxPNI3c4MG3Q
         IGQX9FrRR/YfkFCB3wF6UfpCKRFn8rTPevafX0DQ9EPElddTBsBLn3qw+l3BZXYk9GKI
         5nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFyu5esk/Zb2lNQzmvPRJ9QuwxnaeJqoP/Ih9wxKaVE=;
        b=lPH4BUV7yDD2elo5qJ1dTeVjPZVDTYv+IdLqSK1NmK1aXdT+8OqWqTQHiwQwQ5hCPn
         s/3FdVIv5GNxcbMMflwLZIWI7L9bfuXJdFBsO53yG3Js/tK4iLcexXMfxBblKt3gkVC9
         YYRDQ+tcPXTCA6L5+0OSwwGpUnLf5zYlOFXgCMGk17APWujxTWan6EaQAT7iXY6reBhF
         cin552d+3yYO6TssGC45bnH+rBP6eIaOH1e23BdE0gUfzkjN9NFOGEUy348vpmA6k8b1
         ycs+AjFPjm0bDoom4+H5zfMtzfcvwIBpWb1OfITUBfW16Ll5jvIOYaFFl/LoMGh48ph/
         umhA==
X-Gm-Message-State: AJIora+caxppXCZVXOgWxKx1vZJD6m0yFYSZa8NSqvH4u2UhepFXDJRD
        JjVtTKkGNR6olKBB7NXXkZk=
X-Google-Smtp-Source: AGRyM1tHw8LdpOYQ4ocdkg/wb7xbdY+ptC8YBcgzkEw+K1EEKq9i385MNLM8p7QV0MNlJKBoINhp9g==
X-Received: by 2002:a5d:5847:0:b0:218:5319:f4e3 with SMTP id i7-20020a5d5847000000b002185319f4e3mr25586723wrf.500.1655755615568;
        Mon, 20 Jun 2022 13:06:55 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id w5-20020a7bc105000000b003976fbfbf00sm15528084wmi.30.2022.06.20.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:54 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 26/49] mfd: rn5t618: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:21 +0100
Message-Id: <20220620200644.1961936-27-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
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

An inverted mask register can be described more directly
as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/rn5t618.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 384acb459427..7ed002d090bd 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -80,8 +80,7 @@ static const struct regmap_irq_chip rc5t619_irq_chip = {
 	.num_irqs = ARRAY_SIZE(rc5t619_irqs),
 	.num_regs = 1,
 	.status_base = RN5T618_INTMON,
-	.mask_base = RN5T618_INTEN,
-	.mask_invert = true,
+	.unmask_base = RN5T618_INTEN,
 };
 
 static struct i2c_client *rn5t618_pm_power_off;
-- 
2.35.1

