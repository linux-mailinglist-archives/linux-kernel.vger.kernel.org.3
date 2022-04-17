Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D6504870
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiDQQ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiDQQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16845366BC;
        Sun, 17 Apr 2022 09:53:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o127so7122981iof.12;
        Sun, 17 Apr 2022 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNgNnKpVM/3g6n+FIhL3S2OP5y+05NtGKKDcg+5q1u4=;
        b=FR2Tengc6fUBl1WwUs+gRAE88YNYT+YTpNcVHeEQU8006VgNrH2pLKvHpkBYhdZjeq
         oP8DsID5H5XgZxdAkD947yESy2zIrREixuYE0PpUwcXytL6XMLSzJuB2Cg63pPZQTxy5
         CBbEKIZFWFBu6sgevDrMqFcNL1FJZLwqKt6opZTzriZOopR8pT9oQsfinW35tUvWDCC4
         mLujb9pCErVva2ZgyhNOx5Cz63sbdSGuJLqw04sD0v42iCAlgJxZNITBoHKVY1ptTS35
         A66LAHvym0Z7GDUl06LkXQqjbuo24421nOqDyUvjcQrxxhcmsO6U4LCJgeH1QlCXX0pb
         bCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNgNnKpVM/3g6n+FIhL3S2OP5y+05NtGKKDcg+5q1u4=;
        b=ZeQzWM4HwR3ITQvGJZgYDo63uxTK5wB2GQhC6j0yQ9zcuPsiiLdwJxLB7uiUVLMOAZ
         UDpt0KK1XbYSDTGpG8SNcLDLr3BB2Xu7fVmiZMExUa/kCq5lsBebK8lUh9WQPY+eIs7E
         kZpmhDHTB43ojOaHLy2KVi5N+VQDp8b73QKYVAyU8yyPBOZrtwjLEu+7xSeZOjarzsoN
         73hnYqBdjJ+xFGTSoKQ8ofUy2lsufm0FVmkJK2DlzmC1GpM3q6aSvPKruFfIIRYl8EEE
         AwSz7IE/nWbAgd7Sr5y35e3O5YTmNQ7UwQl9AK141wLH5P9py7wdPfKB6xaMCifZucgv
         yR5Q==
X-Gm-Message-State: AOAM531nnVxWtNI3Esmoe/LrWRLx4JoTl05i5+SDmNQ4se4JEQGK2BrZ
        SV8WlwM+YDj74O3spzvQXxg=
X-Google-Smtp-Source: ABdhPJz/F1XQREAAKtmdV7Mj2isUbnW72M6pJnGg1VOd+eboG43/AlseoNS2StjbuaMXQb3XlOfQmQ==
X-Received: by 2002:a05:6638:2182:b0:323:a610:3eaf with SMTP id s2-20020a056638218200b00323a6103eafmr3480486jaj.204.1650214431527;
        Sun, 17 Apr 2022 09:53:51 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id r14-20020a92ac0e000000b002ca8eb05174sm6034445ilh.57.2022.04.17.09.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:51 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 10/15] gpio: hlwd: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:03 +0800
Message-Id: <20220417165208.39754-10-schspa@gmail.com>
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
 drivers/gpio/gpio-hlwd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 641719a96a1a..4e13e937f832 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -65,7 +65,7 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
 	int hwirq;
 	u32 emulated_pending;
 
-	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	pending = ioread32be(hlwd->regs + HW_GPIOB_INTFLAG);
 	pending &= ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
 
@@ -93,7 +93,7 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
 		/* Mark emulated interrupts as pending */
 		pending |= rising | falling;
 	}
-	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 
 	chained_irq_enter(chip, desc);
 
@@ -118,11 +118,11 @@ static void hlwd_gpio_irq_mask(struct irq_data *data)
 	unsigned long flags;
 	u32 mask;
 
-	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
 	mask &= ~BIT(data->hwirq);
 	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
-	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 }
 
 static void hlwd_gpio_irq_unmask(struct irq_data *data)
@@ -132,11 +132,11 @@ static void hlwd_gpio_irq_unmask(struct irq_data *data)
 	unsigned long flags;
 	u32 mask;
 
-	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
 	mask |= BIT(data->hwirq);
 	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
-	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 }
 
 static void hlwd_gpio_irq_enable(struct irq_data *data)
@@ -173,7 +173,7 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	unsigned long flags;
 	u32 level;
 
-	spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 
 	hlwd->edge_emulation &= ~BIT(data->hwirq);
 
@@ -194,11 +194,11 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		hlwd_gpio_irq_setup_emulation(hlwd, data->hwirq, flow_type);
 		break;
 	default:
-		spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+		raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 		return -EINVAL;
 	}
 
-	spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
 	return 0;
 }
 
-- 
2.24.3 (Apple Git-128)

