Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA4504875
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiDQQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiDQQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:35 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87133EA0;
        Sun, 17 Apr 2022 09:53:59 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b5so7420209ile.0;
        Sun, 17 Apr 2022 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWYbhtE+mjLPNJexKnCqZt1IMsrit1m6da/niohR7jg=;
        b=jwzY2MNX+HYAV5LH+1v2heLZePU+fg4zLW2K5LhCgQRhWujNtxz2P8ltPJGtLyQ81U
         bwasm6BxbMRSEPQ6RhAVl59IWLz7p5uMyO6BR67WeVpQpmsfmjri3Gb8T2GZy4IT/MGf
         sksJ5kZ/YL8rMynIvGn4AZBxv4cl5leM+Evcb8f9tfxZk5YgQa90Gopp9osFiNhqy1en
         W7pT9wRkjapBE/kOqzS3qRhSNt2meycT0w4uwrer4jFcrIm3xEKFJehTYuDDZegZBJEv
         aT8i1Xdx+dzSiISWW9hvWp7sp/7VzNHMKnR/TPmKj0UiFbvh8yJ5hQTTuDI2nmOrjEZQ
         x5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWYbhtE+mjLPNJexKnCqZt1IMsrit1m6da/niohR7jg=;
        b=lGjhCI4DB9OnwKhhQ9dD51Rfs+z48ZgkXhLG9r0739TTccgrPfrvQLOOpDONXj1+gi
         8q/lHhtnm9XzFmSuz1+rbZYpPyN/bVEeD4Gigc9rA34OPDfdj71t44wzZhWYNXMzLv6u
         Xjdk7HcR4mH3N+WCc16Maqb+LuuICLeQss6Sz6IqAC7pbUx8SZHFZdQW/JiTcXNC8H9Y
         YFaEDo1fJBFn8dQCHhUm1YV3+nvGaipgsLHxrvcLURqk8hRoflPQEBr6MGOKb98F5qg8
         WOhjwsab276q6JJMSclb4ATQMHIWo/MVibwoDexdCDmDCYQ2YKOs1FasdRomodkEe5wG
         HraQ==
X-Gm-Message-State: AOAM530q1AbK0J/Kj4cnp3NonFj4iJjFy6Xz2JoKFB6wlXr/vLz0jDLc
        uVp+JGCboRbkyPx2rcnYI5g=
X-Google-Smtp-Source: ABdhPJyiij1CYANAcBUqdhdYy+CwFQJSrpat7DgvBsoR7BU10ao1kzewsYKMDbpRIvp9+pR3Q+XC0Q==
X-Received: by 2002:a92:ca0b:0:b0:2ca:53a1:69b0 with SMTP id j11-20020a92ca0b000000b002ca53a169b0mr3085280ils.110.1650214439018;
        Sun, 17 Apr 2022 09:53:59 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id e14-20020a92de4e000000b002cabd3731ddsm6076398ilr.7.2022.04.17.09.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:58 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 11/15] gpio: grgpio: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:04 +0800
Message-Id: <20220417165208.39754-11-schspa@gmail.com>
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
 drivers/gpio/gpio-grgpio.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 23d447e17a67..df563616f943 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -145,7 +145,7 @@ static int grgpio_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	ipol = priv->gc.read_reg(priv->regs + GRGPIO_IPOL) & ~mask;
 	iedge = priv->gc.read_reg(priv->regs + GRGPIO_IEDGE) & ~mask;
@@ -153,7 +153,7 @@ static int grgpio_irq_set_type(struct irq_data *d, unsigned int type)
 	priv->gc.write_reg(priv->regs + GRGPIO_IPOL, ipol | pol);
 	priv->gc.write_reg(priv->regs + GRGPIO_IEDGE, iedge | edge);
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 
 	return 0;
 }
@@ -164,11 +164,11 @@ static void grgpio_irq_mask(struct irq_data *d)
 	int offset = d->hwirq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	grgpio_set_imask(priv, offset, 0);
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 }
 
 static void grgpio_irq_unmask(struct irq_data *d)
@@ -177,11 +177,11 @@ static void grgpio_irq_unmask(struct irq_data *d)
 	int offset = d->hwirq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	grgpio_set_imask(priv, offset, 1);
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 }
 
 static struct irq_chip grgpio_irq_chip = {
@@ -199,7 +199,7 @@ static irqreturn_t grgpio_irq_handler(int irq, void *dev)
 	int i;
 	int match = 0;
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	/*
 	 * For each gpio line, call its interrupt handler if it its underlying
@@ -215,7 +215,7 @@ static irqreturn_t grgpio_irq_handler(int irq, void *dev)
 		}
 	}
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 
 	if (!match)
 		dev_warn(priv->dev, "No gpio line matched irq %d\n", irq);
@@ -247,13 +247,13 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
 	dev_dbg(priv->dev, "Mapping irq %d for gpio line %d\n",
 		irq, offset);
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	/* Request underlying irq if not already requested */
 	lirq->irq = irq;
 	uirq = &priv->uirqs[lirq->index];
 	if (uirq->refcnt == 0) {
-		spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+		raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 		ret = request_irq(uirq->uirq, grgpio_irq_handler, 0,
 				  dev_name(priv->dev), priv);
 		if (ret) {
@@ -262,11 +262,11 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
 				uirq->uirq);
 			return ret;
 		}
-		spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+		raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 	}
 	uirq->refcnt++;
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 
 	/* Setup irq  */
 	irq_set_chip_data(irq, priv);
@@ -290,7 +290,7 @@ static void grgpio_irq_unmap(struct irq_domain *d, unsigned int irq)
 	irq_set_chip_and_handler(irq, NULL, NULL);
 	irq_set_chip_data(irq, NULL);
 
-	spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
 
 	/* Free underlying irq if last user unmapped */
 	index = -1;
@@ -309,13 +309,13 @@ static void grgpio_irq_unmap(struct irq_domain *d, unsigned int irq)
 		uirq = &priv->uirqs[lirq->index];
 		uirq->refcnt--;
 		if (uirq->refcnt == 0) {
-			spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+			raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 			free_irq(uirq->uirq, priv);
 			return;
 		}
 	}
 
-	spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 }
 
 static const struct irq_domain_ops grgpio_irq_domain_ops = {
-- 
2.24.3 (Apple Git-128)

