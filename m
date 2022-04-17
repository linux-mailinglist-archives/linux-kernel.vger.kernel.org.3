Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57872504863
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiDQQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiDQQze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3B27146;
        Sun, 17 Apr 2022 09:52:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id c125so5142171iof.9;
        Sun, 17 Apr 2022 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OwOsVwj0AcxMEF/6BJstkFWn8hxakPI1KDKnUQ4Lzg=;
        b=UunGbPJEiLCLNU919rHI7QhLrHG38Xr/bpbs4lj+86720GzjEZ/FTVpKjuiaulXL9O
         E2U9cXnDy817oQ5k6PYSEe0+uf/7Y8zQnfoH18lZ4EWB/0V7eszyJqHP9zL9dRS0a291
         r1mzJfDJvHlK6WL0SHCzcBcWCYpod9PIolFJ5eCTFH8EUcWOkNVVOrKqc5TR+BRzxw2r
         l//TVmwvqeOtK84BUaf9oZGnv2/HtNasgBU4Nu/Cp7tGT4APo8SlMgFmEV3FMfFyiJDd
         vxGVdldaYz+FjlowKPrXgJgOZR/YXQUVscJ1DOSi1//WXJojKmdaXwfS93nXizQjkhLn
         JpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OwOsVwj0AcxMEF/6BJstkFWn8hxakPI1KDKnUQ4Lzg=;
        b=mc6XMGvvLRsp6woMS2OodWcKqWw7ew6bjk3kVzhFPZHnZDU09Hl4TT8cxwIrFB69PA
         8Q/g7UoOSsc4YS8vjAB5icgmGUJ/sqEuH0At/GMstoDsoY78d5vZg1SIxwMD+qB8vgz6
         5ufoqlmluWHY7NNg7A45cI3HsaCIuweD0i2UuaWol7FIV9BovpSbRXcS7OGISffRfJlL
         YPMlDDRZoVLJpXRzqoiTk/q9s0ag2fqKoxUWvpqwUMnbP81PH3te9ssMK0utTMYyyOt8
         7s1RhGvonP5I7gSnSoI7iUUSYUrMyt41Nrt+3jsdDEEZWxg+IJ5lCjTkxueHc7P3nfNX
         YZYg==
X-Gm-Message-State: AOAM532VTWNVBeQlQ/SLw8mPl6OvjX4vuEdijDk/CF6NdZ6Qyg0awsa0
        HDmgvSiRtdJZ6L5ibYaiqLye8xI7JojOI1pb
X-Google-Smtp-Source: ABdhPJxA4BLCU17xbWVxEJOu67pQzjppsMUw4X3TWe1gpZ6YQNY50y4bIGv9DZFUmEI4lCBaHGZ3/w==
X-Received: by 2002:a02:970c:0:b0:326:f9ba:e6b1 with SMTP id x12-20020a02970c000000b00326f9bae6b1mr3187984jai.25.1650214377881;
        Sun, 17 Apr 2022 09:52:57 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id l13-20020a92700d000000b002caa6f61ed4sm5978555ilc.5.2022.04.17.09.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:52:57 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 03/15] gpio: tb10x: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:51:56 +0800
Message-Id: <20220417165208.39754-3-schspa@gmail.com>
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
 drivers/gpio/gpio-tb10x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 718a508d3b2f..de6afa3f9716 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -62,14 +62,14 @@ static inline void tb10x_set_bits(struct tb10x_gpio *gpio, unsigned int offs,
 	u32 r;
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpio->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gpio->gc.bgpio_lock, flags);
 
 	r = tb10x_reg_read(gpio, offs);
 	r = (r & ~mask) | (val & mask);
 
 	tb10x_reg_write(gpio, offs, r);
 
-	spin_unlock_irqrestore(&gpio->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gpio->gc.bgpio_lock, flags);
 }
 
 static int tb10x_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-- 
2.24.3 (Apple Git-128)

