Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20308552501
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbiFTUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245116AbiFTUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A077193CE;
        Mon, 20 Jun 2022 13:06:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n1so15841978wrg.12;
        Mon, 20 Jun 2022 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcQuE9oGehOZto3hA/rTLb2fToN8VqZpboB1wSvVLeU=;
        b=e6An1+k7URA0wQXNcY2/BdRAilnccZF6A/hAv9jWNU7eSpvfOtHDfFPlFA9Tmj9tdP
         Q3jbhTK1VDeXWFItQMxcv0vZ7RCc5cmoO02hqrWFt1bNQVvSZ9vWPfkxDdj301roqukK
         VxcyBZNW8QGynfO8JWI+WWahEFDrUvnJXyIxMEVYx3RByt41ka89CAhjte2WBrFW5mhM
         TCXItN7+bBmjpnPbHtb5ce5F5Rk9ZgfpC/oo8VuyT8lEVZBE0Oo1B0D7mW2UL08mlg2l
         JQb9VPre/3jtmwZhYCFcXMZ3dZ9tQ6hqqgn0BUdmCk0DnRF2pxNugG3O1NbKVirJLc3k
         3CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcQuE9oGehOZto3hA/rTLb2fToN8VqZpboB1wSvVLeU=;
        b=7J+dUBpQAPG2i2YPUBVh6P22lmxmrqGoptNz/TELMW+lZ2z9AiQIwPoTJ38Cceen4t
         hm4ciT5WXKIFPe50KlMnaKsVLqv6AZay21d0UU+T3JdELVILdX08Eg8D3veJgFvQZ2UZ
         wFuvvLnOkqw3nTZ6TUYm+gNaWNTrakWwzNBx1fq72zZLlIxwXcQ0f3+yjLhTuKc8Fa6P
         YTNT/LFr81Hqwq9cyzb4ZZlUAjyJUjIPckspz/6IXyrxg/IufdIgWwaGEsi/1SxbAcKD
         XF3lXHQ5/97N0Ubnk7xypURNzaN/CYQzuEN+3CmZgydIolI3AQoldVmwJw8rWMGTJ3+t
         /2jw==
X-Gm-Message-State: AJIora9LgFQ0pPwK0/wsM3PdybInIIz9w9E+q0gU8c7+Xom8CquDYoYw
        8zsE1SYdZctcj3HJq/rbmqA=
X-Google-Smtp-Source: AGRyM1toV/6s8wRgMxmabtCAeVPKyocBr9a+nW1Hds3EtsXXFabw7Q99ucUCOTs0Oy4tAKumPVl4nQ==
X-Received: by 2002:a5d:64c7:0:b0:21b:9661:6aac with SMTP id f7-20020a5d64c7000000b0021b96616aacmr665641wri.496.1655755579596;
        Mon, 20 Jun 2022 13:06:19 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id c5-20020adffb45000000b0021b91d1ddbfsm2917554wrs.21.2022.06.20.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:19 -0700 (PDT)
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
Subject: [PATCH 03/49] regmap-irq: Remove an unnecessary restriction on type_in_mask
Date:   Mon, 20 Jun 2022 21:05:58 +0100
Message-Id: <20220620200644.1961936-4-aidanmacdonald.0x0@gmail.com>
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

Check types_supported instead of checking type_rising/falling_val
when using type_in_mask interrupts. This makes the intent clearer
and allows a type_in_mask irq to support level or edge triggers,
rather than only edge triggers. Update the comment to reflect the
new behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a6db605707b0..59cfd4000e63 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -253,22 +253,19 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
 	unsigned int reg = irq_data->reg_offset / map->reg_stride;
-	unsigned int mask, type;
-
-	type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
+	unsigned int mask;
 
 	/*
 	 * The type_in_mask flag means that the underlying hardware uses
-	 * separate mask bits for rising and falling edge interrupts, but
-	 * we want to make them into a single virtual interrupt with
-	 * configurable edge.
+	 * separate mask bits for each interrupt trigger type, but we want
+	 * to have a single logical interrupt with a configurable type.
 	 *
-	 * If the interrupt we're enabling defines the falling or rising
-	 * masks then instead of using the regular mask bits for this
-	 * interrupt, use the value previously written to the type buffer
-	 * at the corresponding offset in regmap_irq_set_type().
+	 * If the interrupt we're enabling defines any supported types
+	 * then instead of using the regular mask bits for this interrupt,
+	 * use the value previously written to the type buffer at the
+	 * corresponding offset in regmap_irq_set_type().
 	 */
-	if (d->chip->type_in_mask && type)
+	if (d->chip->type_in_mask && irq_data->type.types_supported)
 		mask = d->type_buf[reg] & irq_data->mask;
 	else
 		mask = irq_data->mask;
-- 
2.35.1

