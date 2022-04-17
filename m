Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9750486A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiDQQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiDQQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD82717C;
        Sun, 17 Apr 2022 09:53:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 125so12402699iov.10;
        Sun, 17 Apr 2022 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEsXWsVAFxE0Qk9j9TD45ImCnz9zFCsmdmXDW5FiVWg=;
        b=e5qDIPzNb5i/XDJETnbYTVvf7n/Tz1w05RSl1zubtU+VL7MOtOpH5HwOutaI69+iZB
         rYx8U06TVLuwCczmAQ7VGcoSfQZ0VJRMpfdXLc0BltbM74CIqcBLSdYEICIvlV0pE38B
         LzSzw3RMgR4qOp9gMOSH6rdBVJ7hWQPifTqCObYy9JEftJz1fC5K+mZH2YX9SwcLgK2K
         GQW9/xgn0dwjFxTveoQrl1AXvmT18FQUdurqzuI3/vgftrUX0XyCZjLSrXLiJSKRfNP+
         vL/c8Qk5C1iVmXXWgTWWKu1aoEyMKGEipgmcHYswfs3XGNKadPEpJwmrQCmiTl1dWvuE
         kiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEsXWsVAFxE0Qk9j9TD45ImCnz9zFCsmdmXDW5FiVWg=;
        b=WHLxQVocLVSJ01wACLj2FEPM86MqYsVheC1jD1wGYpiPcQrCdXqD5oGFjV7+iRZnXb
         UvCwcjyy5sYrgWlsBhdIhZQR+5g29bZ5lNy1Rs3s2p2lhGA0+9IhmmWU/RaeHSqpGtcv
         vePtdqx4YGZcCt9lGkep774N4u7pbvVu6dGIxAvGc37uly6tG2v/aqxsyYkZK8v0Vj8k
         5UkgsGM+j+phamaHBUmBHnsBJyiP2jKtchnUgkeGg//C4MrH2a8mcJwngHYgIvF8+Nsc
         mLfv1T6tVqpn6GskGKJn3Oqzj5BGYoSQ/MkvV2urv9RZm1NsjanwIymb4A78oAYGohv6
         XsaA==
X-Gm-Message-State: AOAM5331gNRvbwdpTrjW8+lGRhJOuJqPACqMPU8h7IkzUAmwFxnb/AYg
        cbo0qXwKzScHzXeqFStiwXQ=
X-Google-Smtp-Source: ABdhPJyh1gSqRyo717tsWNV4tEqAE7Hi4VCbdcxUrunF8BUVtyqzqiU0k2TgU5xd+dDGmmFmZvwZUQ==
X-Received: by 2002:a05:6602:2c0b:b0:63d:dfb2:9a95 with SMTP id w11-20020a0566022c0b00b0063ddfb29a95mr3120108iov.93.1650214416558;
        Sun, 17 Apr 2022 09:53:36 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id l15-20020a056e0205cf00b002cbea6a61b9sm5338147ils.25.2022.04.17.09.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:36 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 08/15] gpio: ixp4xx: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:01 +0800
Message-Id: <20220417165208.39754-8-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220417165208.39754-1-schspa@gmail.com>
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_lock is changed to raw lock, fellow the header change

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/gpio/gpio-ixp4xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index b3b050604e0b..6b184502fa3f 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -128,7 +128,7 @@ static int ixp4xx_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		int_reg = IXP4XX_REG_GPIT1;
 	}
 
-	spin_lock_irqsave(&g->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&g->gc.bgpio_lock, flags);
 
 	/* Clear the style for the appropriate pin */
 	val = __raw_readl(g->base + int_reg);
@@ -147,7 +147,7 @@ static int ixp4xx_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	val |= BIT(d->hwirq);
 	__raw_writel(val, g->base + IXP4XX_REG_GPOE);
 
-	spin_unlock_irqrestore(&g->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&g->gc.bgpio_lock, flags);
 
 	/* This parent only accept level high (asserted) */
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
-- 
2.24.3 (Apple Git-128)

