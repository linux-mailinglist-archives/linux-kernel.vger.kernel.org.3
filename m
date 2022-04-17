Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96550487C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiDQQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiDQQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:56 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ED2369D6;
        Sun, 17 Apr 2022 09:54:21 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k12so455020ilv.3;
        Sun, 17 Apr 2022 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52T4ey2PAbrZ4woSDAdfzc4UGJubZTXGCe7mp+PSSTY=;
        b=dsVqKrGYg7rYsBJvl0PxSGFLitm+Wgs65VY0cWMxGp1+oCiyljTNjOqHFmnKovHZZu
         8SqUB0JoIMn6539HglLoQWw1KDUY/oIWL5AF+4XT9ptiYbJ9LaPohHwNfBQJoDEwYEff
         RfgPlBEf7he92/yDn+CBKkQcTHTBpY3YbjRnCYKRKMI9BOnrzZOCRqYbgdp2QdSqrEJz
         czorHrphAxArbQDpfMCW9C9+YDoAffCmX4GUgxanpzYh6CVK2sNtVUNPb5fz6y9HQx6o
         ScZIr9LX6y+WvG3dCDV0RPgYamutLiRM9wigPhgxNLWWHe/ZESxb90JD2pbjUhu2og1z
         7WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52T4ey2PAbrZ4woSDAdfzc4UGJubZTXGCe7mp+PSSTY=;
        b=LK5FZKmn4hKfkqAON9UuCR2Prrdi11fq8f0r4vt33OZBwIp9N3RgfRp04KtlKnLIah
         JnRuIfRiHtK6rQsxHzJ6mVhstsYoMGzUekXtNJOcvNkdvhFF18hdZKJmaVq58FbzSxLy
         zqHmw/rkp8DDCYyRy4FIU7mrit15k//hk303xBpZM4zDAJfb/Hz8fwQe0mLOrNyHtcR0
         gV5XMa3Pb/ySfTmGffVmnvXqAjWW1kT5dzPGmaH5GApJoGd433Cksdn0CWa8Z48a9U61
         heHnrxbR1htQoEtEbjHVM26wIJc8CCgpwPlrAPD8zF060raTTZQguFM9soMWH/6ihPVB
         ciJg==
X-Gm-Message-State: AOAM5317Pr3PWSdxU0N/isiNQqtyekUvf/7VQzcZ8zm3oT6MCv96sbpZ
        76Jn/aEU3QDp8/2IkF3yM2E=
X-Google-Smtp-Source: ABdhPJyHETgZLwVB/532u/+Od1IHuL7PgKnaZ4fBFtKdxboN2h7V5+dmOoChDkiJ8dVzyCAgu0ZzRQ==
X-Received: by 2002:a92:c54e:0:b0:2c9:aa07:71b2 with SMTP id a14-20020a92c54e000000b002c9aa0771b2mr3079086ilj.257.1650214460469;
        Sun, 17 Apr 2022 09:54:20 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id r9-20020a6b6009000000b006412abddbbbsm6554619iog.24.2022.04.17.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:54:20 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 14/15] gpio: brcmstb: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:07 +0800
Message-Id: <20220417165208.39754-14-schspa@gmail.com>
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
 drivers/gpio/gpio-brcmstb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 74ef89248867..6b7439b44690 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -92,9 +92,9 @@ brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
 	unsigned long status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
 	status = __brcmstb_gpio_get_active_irqs(bank);
-	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
 
 	return status;
 }
@@ -114,14 +114,14 @@ static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
 	u32 imask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	imask = gc->read_reg(priv->reg_base + GIO_MASK(bank->id));
 	if (enable)
 		imask |= mask;
 	else
 		imask &= ~mask;
 	gc->write_reg(priv->reg_base + GIO_MASK(bank->id), imask);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
@@ -204,7 +204,7 @@ static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&bank->gc.bgpio_lock, flags);
 
 	iedge_config = bank->gc.read_reg(priv->reg_base +
 			GIO_EC(bank->id)) & ~mask;
@@ -220,7 +220,7 @@ static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	bank->gc.write_reg(priv->reg_base + GIO_LEVEL(bank->id),
 			ilevel | level);
 
-	spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&bank->gc.bgpio_lock, flags);
 	return 0;
 }
 
-- 
2.24.3 (Apple Git-128)

