Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E60552534
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiFTUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbiFTUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AAD1D0F7;
        Mon, 20 Jun 2022 13:06:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso6194029wmc.4;
        Mon, 20 Jun 2022 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NtcVbwET9acvq+sAYxoy+CjdvzW22WJrtUFi1dmUOo=;
        b=A+HDr9UU7+WRxYQh+og339fpLCReWCpP3YFgyupAlmxOcZBf7A6aFnN8naHelyc52s
         wQK8Fy9G6v6mTrGSQG4iRbkz5YauYi4iPPwJMQ1JvKJvozZ8vtLRWwHh4bZf1gWdX2JC
         dbwqJKti3GJ9HNo1vXGhcyksOzCb4wnGEGjB9WKXRA8144i5ltsXiu2qsbBUMRpGeiKM
         foGh+rMJtGnYFLs3jAHQB2MuzI/dNK6UnFensNutj1IivbApMFbM7lKCQeTK27rVsLY0
         i4E+b9E7gLbrO8WdSQ5sENJyJXaP1cu0PzOoAW96YwnClCEE3EdUU+uTD9Lm7PL5cykC
         bC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NtcVbwET9acvq+sAYxoy+CjdvzW22WJrtUFi1dmUOo=;
        b=tHXFgqGmPfxtLQw8oZYnncGODCQui1vPd9M9rS5JdfPmOMNVEqt45adX+kAyDCBf1I
         c0FwjNZ1dwQR5wuerYXXeU8PsR/3RnTGb0aieys/VGYqJ2AqzaK+x6c4IcRYZr4V9ajN
         mRmBgCNKzJNxLpmtlgQ2Y+pjoPOU6LmMYbfXjqohPhCmPgr0gWGBod16Y7yUaoWwC5rA
         EYJdjAGNXf052tFOTLhMhyIFuzkz1oYaB6kwbs6WIjnDIhe9rxsWZF7T3BRTLpuGuJdd
         vMLFU963cY3MD2tYAByk/EzvI+YoDbTJZSacDEkFpCx6WSGFNJx/7OpSl8vjbzb7wxDa
         wieA==
X-Gm-Message-State: AJIora+9aCqNLZ1+1Tou9Vlms7YA0r/rK4m56U9NDZQKh4rJUSS136yo
        KxGZYURYqClxVdLR97Ahf6E=
X-Google-Smtp-Source: AGRyM1uQGdQ7m3OGY9UqaMyRP6uDRepmxOPNYfAd9XL91yLtMli/B6mx4CKZxfd/noc8TeLSorNR9Q==
X-Received: by 2002:a05:600c:1547:b0:39c:804c:dc23 with SMTP id f7-20020a05600c154700b0039c804cdc23mr26538403wmg.23.1655755596798;
        Mon, 20 Jun 2022 13:06:36 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c2ccf00b003974a00697esm20182858wmc.38.2022.06.20.13.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:36 -0700 (PDT)
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
Subject: [PATCH 14/49] regmap-irq: Do not use regmap_irq_update_bits() for wake regs
Date:   Mon, 20 Jun 2022 21:06:09 +0100
Message-Id: <20220620200644.1961936-15-aidanmacdonald.0x0@gmail.com>
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

regmap_irq_update_bits() is misnamed and should only be used for
updating mask registers, since it checks the mask_writeonly flag.
As there are no users of mask_writeonly, it is safe to replace
the wake register updates with regmap_update_bits().

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index b24818ad36e6..dd22d13c54c8 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -157,11 +157,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		reg = sub_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
 			if (d->chip->wake_invert)
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 ~d->wake_buf[i]);
 			else
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 d->wake_buf[i]);
 			if (ret != 0)
@@ -823,11 +823,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			reg = sub_irq_reg(d, d->chip->wake_base, i);
 
 			if (chip->wake_invert)
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 0);
 			else
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 d->wake_buf[i]);
 			if (ret != 0) {
-- 
2.35.1

