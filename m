Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2CC504869
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiDQQz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiDQQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC0369C0;
        Sun, 17 Apr 2022 09:53:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so12383544iom.13;
        Sun, 17 Apr 2022 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geJH8cZ/3Pw+l+10NnZZq8zy0Rzo4tHJudLUHjx7QEw=;
        b=STgM9dLwNtoU1Fpjq/AFOWz4iRwFK3VvFy31HU/sSBH/dnlLobRdc/H5/9AQWAosqC
         rBlFbIg2BIgGLUazoOY4bKMZcNYlQokFGJIg7rC1vx1INtK0pF22BzMehgW5orVoTypy
         zUwRUlWSOEvyvnfwagPgktb67RUwtmPNLJ9VRTJqsEiwSM8/62NyEOye/Ftcdqbob/b5
         rtLY9Qw1/hpCrCldiUOLboCo1CV632Hk/wbPLL9oiziL4rWNmTulVCjLYgKarV5JdzBp
         1RzVGYg4ORf2Ou1/QTQgpvKwzMvcIU3hUwWvubTTJ9hJQmX7a8ALsMaqrx3vhAcJi//1
         pypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geJH8cZ/3Pw+l+10NnZZq8zy0Rzo4tHJudLUHjx7QEw=;
        b=ksOe0gfhM9oQUJJN6fDjB5jZq+bvRxrB7oX8gfY1mswMNDveyVQZe6VGpazFbKXzRv
         obw0PeGZtXdFlrFZunpobf1hyM//2ImXngRVSx8PR8c63CLf74FjenvsCG8pJzFRop5e
         2TzsKtro+IIdbzQiFOmjXBM2UgD8XcmQt4RxPdWc/xPepynKg76NEGOTd9QbztjH41ld
         o4yqOlK0dBT8cTi/Yw5q9WmaAKyxW0oHYzH4j8FvS0TsX2NuQM5QlDAJ+ov1Z0bxkRqZ
         j78tvA/ez3JacbEtT0SUJ7dyajKJXLX7DGNLtBOxIEOHam1KON+VO3liwAPsYlVzwBtJ
         eeRA==
X-Gm-Message-State: AOAM531x8L3R02MFjfTFL0Vs7hmORwBDIoM+5gzOCvPsVUtFt+3/OoSh
        gvF2sUFuCmg2HG+bRvQdPDo=
X-Google-Smtp-Source: ABdhPJwSBEPt6MXNZRA6Lh1xuMsCOxOXUtYFvKCMy/VTNY0PkrkCrLyMSyhz+r4vJOuXNu22vbCj0w==
X-Received: by 2002:a05:6602:194:b0:64f:caa4:f9e0 with SMTP id m20-20020a056602019400b0064fcaa4f9e0mr3128959ioo.1.1650214391377;
        Sun, 17 Apr 2022 09:53:11 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id h24-20020a6bfb18000000b006497692016bsm6656061iog.15.2022.04.17.09.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:11 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 05/15] gpio: mlxbf2: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:51:58 +0800
Message-Id: <20220417165208.39754-5-schspa@gmail.com>
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
 drivers/gpio/gpio-mlxbf2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 3d89912a05b8..64cb060d9d75 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -131,7 +131,7 @@ static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
 	u32 arm_gpio_lock_val;
 
 	mutex_lock(yu_arm_gpio_lock_param.lock);
-	spin_lock(&gs->gc.bgpio_lock);
+	raw_spin_lock(&gs->gc.bgpio_lock);
 
 	arm_gpio_lock_val = readl(yu_arm_gpio_lock_param.io);
 
@@ -139,7 +139,7 @@ static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
 	 * When lock active bit[31] is set, ModeX is write enabled
 	 */
 	if (YU_LOCK_ACTIVE_BIT(arm_gpio_lock_val)) {
-		spin_unlock(&gs->gc.bgpio_lock);
+		raw_spin_unlock(&gs->gc.bgpio_lock);
 		mutex_unlock(yu_arm_gpio_lock_param.lock);
 		return -EINVAL;
 	}
@@ -157,7 +157,7 @@ static void mlxbf2_gpio_lock_release(struct mlxbf2_gpio_context *gs)
 	__releases(yu_arm_gpio_lock_param.lock)
 {
 	writel(YU_ARM_GPIO_LOCK_RELEASE, yu_arm_gpio_lock_param.io);
-	spin_unlock(&gs->gc.bgpio_lock);
+	raw_spin_unlock(&gs->gc.bgpio_lock);
 	mutex_unlock(yu_arm_gpio_lock_param.lock);
 }
 
@@ -237,7 +237,7 @@ static void mlxbf2_gpio_irq_enable(struct irq_data *irqd)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
 	val = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
 	val |= BIT(offset);
 	writel(val, gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
@@ -245,7 +245,7 @@ static void mlxbf2_gpio_irq_enable(struct irq_data *irqd)
 	val = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_EVTEN0);
 	val |= BIT(offset);
 	writel(val, gs->gpio_io + YU_GPIO_CAUSE_OR_EVTEN0);
-	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
 }
 
 static void mlxbf2_gpio_irq_disable(struct irq_data *irqd)
@@ -256,11 +256,11 @@ static void mlxbf2_gpio_irq_disable(struct irq_data *irqd)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
 	val = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_EVTEN0);
 	val &= ~BIT(offset);
 	writel(val, gs->gpio_io + YU_GPIO_CAUSE_OR_EVTEN0);
-	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
 }
 
 static irqreturn_t mlxbf2_gpio_irq_handler(int irq, void *ptr)
@@ -307,7 +307,7 @@ mlxbf2_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
 	if (fall) {
 		val = readl(gs->gpio_io + YU_GPIO_CAUSE_FALL_EN);
 		val |= BIT(offset);
@@ -319,7 +319,7 @@ mlxbf2_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
 		val |= BIT(offset);
 		writel(val, gs->gpio_io + YU_GPIO_CAUSE_RISE_EN);
 	}
-	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
 
 	return 0;
 }
-- 
2.24.3 (Apple Git-128)

