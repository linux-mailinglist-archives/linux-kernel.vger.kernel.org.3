Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96344504861
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiDQQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiDQQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD827173;
        Sun, 17 Apr 2022 09:52:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y85so2786107iof.3;
        Sun, 17 Apr 2022 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PxZRjr3wyeAKqstrnBd3HbjtR/5c3lDXuJSEUWG8pE=;
        b=oVzQU+ufinXD7bmpNBMXsPvaMURLdNBbCBjdFKox5iR8bKAeTZFeUJldZHySxCJTDq
         q3g56k5sp/hvW/OE7lPVpfQTn11LcgJ9TULWcLn8dId6542lkTGT/sHoCAJi/wdeqT6s
         lZ2cK6BQLMtCSaTSpBnqB3Yp+8al5q96vVFqy7EI9evsl519pmbNTV2bBTKwbTJ02YV/
         5td5b5sEc0BY/f0IyO4D1DZBEIEwIQwZWhFSf88UVqnoyu1Zgok01zw0OZ/0ycYkx402
         cOlNktQVGey9EHsjCMkhkfEHYUxNvk0KOK9/1+1p9TLm1Pnf/EXjIvsm1EwFUceNls+Y
         KbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PxZRjr3wyeAKqstrnBd3HbjtR/5c3lDXuJSEUWG8pE=;
        b=TyNQs4nou5+xMeBxscCcmLRJ/xzAM37K0Suz5Dkb2RUbBMAkdEm+b9L7YoQQPtHKC/
         DYQAJ12Mdn1AFhng0FiHOW/JouD4rm1xOCHB0W6WUOSy/KHT917zIZQyQHYn8FB9USfV
         ZNluCdSc1yhN1mm33DTFX2THVTwQlB8PKY0uLPxV+gDB5/UUvtyQYOk9Q1mJ+HuMbfQi
         W+4SOsoSuHuWQZAycyuiRTz+vlOU6PX4W8Tlx8sTI9hRdQ5EJpZFtjFumBNnXN6JQ1k4
         5qC3bpUSa4/ZmkCIYycED6GTdwt/0IQTG06stHzAXnKHQxzggEZWmr49vDdQDXnQxAD5
         YgRg==
X-Gm-Message-State: AOAM532N4AspgIasfDg8X0ahndWgNMWGnTRhkaTUOHHkF0m8sS61WI9g
        Pf27xfcYDoRrZ78/Lddxi50nE3z3wE3pLGyX
X-Google-Smtp-Source: ABdhPJwMz2GALH4hX73Pnz+fsCqDst9DHZ/MyfAYdr/ZRJ3LlkO38bgaRzTIe1RckOqb+1MXSWf42A==
X-Received: by 2002:a5d:8855:0:b0:651:fe8:47a8 with SMTP id t21-20020a5d8855000000b006510fe847a8mr3042681ios.84.1650214367514;
        Sun, 17 Apr 2022 09:52:47 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id c4-20020a6b4e04000000b00653e74540f0sm3130099iob.7.2022.04.17.09.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:52:47 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 02/15] pinctrl: nuvoton: npcm7xx: use raw_spin_lock_irqsave for bgpio_lock
Date:   Mon, 18 Apr 2022 00:51:55 +0800
Message-Id: <20220417165208.39754-2-schspa@gmail.com>
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

This lock is converted to raw lock, fellow the header change

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 9557fac5d11c..b2a0f11a658b 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -104,12 +104,12 @@ static void npcm_gpio_set(struct gpio_chip *gc, void __iomem *reg,
 	unsigned long flags;
 	unsigned long val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	val = ioread32(reg) | pinmask;
 	iowrite32(val, reg);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void npcm_gpio_clr(struct gpio_chip *gc, void __iomem *reg,
@@ -118,12 +118,12 @@ static void npcm_gpio_clr(struct gpio_chip *gc, void __iomem *reg,
 	unsigned long flags;
 	unsigned long val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	val = ioread32(reg) & ~pinmask;
 	iowrite32(val, reg);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void npcmgpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
-- 
2.24.3 (Apple Git-128)

