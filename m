Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0E50487D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiDQQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiDQQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:57:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CF27146;
        Sun, 17 Apr 2022 09:54:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y85so2788086iof.3;
        Sun, 17 Apr 2022 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0+uIW7FbNHXgejqXfaEwe+NSEamiwjwIvCj5cOI+QI=;
        b=DRI/2Qyei+WVTwSLZ3vEvl6cnKMWwO54YzAbUubaClLBH6VbbDShMmkjKOlYmcXCC6
         ORxG1wU/Fi9MXw0aJXyQarrMFpRaYM+ZOrMN6asGvU2A7XCH5MRutYUKJIbzlW+mTxR7
         bHA/0xULU3dRsfOw/52etSNkTS0aTRv3r939wbjPOBdaB42Bl/Do4WkimX7LvVXRtx0S
         qK/P0e8f7tpdj9o/WrlNXa5i/JPDrhSLterxF7VoNoWnVKTDawVUNA+Pm5mXgSpq5WE9
         KDOzpOubhQXeMZ4ywkh57qPb+xt807RbCDHafY6GIh92lq2j/9pzTruM34xYagkfgi0h
         Y0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0+uIW7FbNHXgejqXfaEwe+NSEamiwjwIvCj5cOI+QI=;
        b=huHt+87U95Wnvv2T+K0tfeC25jDNzYRTrYgJX24rQqkYszalEa0q4LX8LpCtAeT5ox
         tnuRDiZEbHAn9PxGJSbUDpb/bDzNdNFDP/dQMdh8fo8BtRYRuoohKZ4btibER9/AE6RN
         qyqQb0egJO3CkpopcgY29nFFIbxWIQuqr+NxIGRLHCz1kBv9bh22fbilsjg1BjIaBqeG
         zQBPZUAQi31fQz5YrwJq21W1HiVAHbbz/FjPxOKU5juTvNzAVS/mj8em7m9TC/EC/HJG
         7g3ztakfsqXWKmN2c+uUUyY0AiR5T6/i1K3uGMNvRbDox4rgCJCq8XTSJOLKUnpdpQr6
         jn7A==
X-Gm-Message-State: AOAM532KWSRG8SMkR7wRskpKzqe47Qud+ScXQI+aiRDBWbOdtFjMp6kS
        hGe4Y0Q+Cx9H9Lpq7GSSMWF/ivR7c7cE5g==
X-Google-Smtp-Source: ABdhPJwZe1EqihYk67eZkXbIsb65BX3uCy7lLc1xnydlVvcfBAAsmB5eox1UKzdcdch9GHrc3w9rqw==
X-Received: by 2002:a05:6602:150f:b0:64c:6878:1ec8 with SMTP id g15-20020a056602150f00b0064c68781ec8mr2985277iow.143.1650214472543;
        Sun, 17 Apr 2022 09:54:32 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id i81-20020a6bb854000000b00649c1b67a6csm6732443iof.28.2022.04.17.09.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:54:32 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 15/15] gpio: amdpt: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:08 +0800
Message-Id: <20220417165208.39754-15-schspa@gmail.com>
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
 drivers/gpio/gpio-amdpt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 8cfb353c3abb..07c6d090058d 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -36,19 +36,19 @@ static int pt_gpio_request(struct gpio_chip *gc, unsigned offset)
 
 	dev_dbg(gc->parent, "pt_gpio_request offset=%x\n", offset);
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	using_pins = readl(pt_gpio->reg_base + PT_SYNC_REG);
 	if (using_pins & BIT(offset)) {
 		dev_warn(gc->parent, "PT GPIO pin %x reconfigured\n",
 			 offset);
-		spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+		raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 		return -EINVAL;
 	}
 
 	writel(using_pins | BIT(offset), pt_gpio->reg_base + PT_SYNC_REG);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -59,13 +59,13 @@ static void pt_gpio_free(struct gpio_chip *gc, unsigned offset)
 	unsigned long flags;
 	u32 using_pins;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	using_pins = readl(pt_gpio->reg_base + PT_SYNC_REG);
 	using_pins &= ~BIT(offset);
 	writel(using_pins, pt_gpio->reg_base + PT_SYNC_REG);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	dev_dbg(gc->parent, "pt_gpio_free offset=%x\n", offset);
 }
-- 
2.24.3 (Apple Git-128)

