Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBC546547
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiFJLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbiFJLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:14:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3214915C;
        Fri, 10 Jun 2022 04:14:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j6so23563723pfe.13;
        Fri, 10 Jun 2022 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvPtBJlHjffDNQx8lPTiOlFv8Yml0X3QqZ5RFqKFOM=;
        b=Ck0Q29cZZuM/Kh2xhbfXUt+BhMt9IcSGn615Yl6vJacDxaA8lIZEXPvkqrGnXquu7v
         KdSyN5BDhsueBwizGiuCJ132pXWz2C/jkofBT7tUzu14Y4ZTy3QvbJBVleaVK5G6YI16
         RiUyJQ1c9U+T/im7q2d8oN9uQuYy8SyivKExVFT2vqBQ4Z13ul0ujKl+PRyjPaaYYOaq
         TY7Q5oQemfJR8PMRAKj4QF4COhGPi32as6lDCXc7zzNUx6FFb8Z7TWv1WAMyytAg9gMA
         xvxQSKnzcaUeA5oJxtfBuhO8krjkPlTZYD3FWnEes5vTljA0X4BK7uW15yxRuNX+tBQy
         4SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvPtBJlHjffDNQx8lPTiOlFv8Yml0X3QqZ5RFqKFOM=;
        b=bAnaZAOi0V/kMNPs8LANFWOO9xHP/Q2pTyN87CqNtzQN8/jvR32z19QsFjczlul0NH
         vCLk/6UcDGOQWfDpGesU03XRBNZY8M/L7qE3MqeNW5fuWj+LvS1iLHF7Deyv9e6/AOkY
         4Fke1f23eWDiqBwOpE3LBgZAlR1Do3xahr2ZQWPGitaoxnJK5X4uhccRVxY/oGG0OaRh
         VjWtLSeLWKah44m7DhXD6mjZU14WFOOcljt08aieHr10wrRJrnpaUe+cnuT5IEVhauib
         a31Sw3ygJd85X7sB4fYjtSWlGWLUhN7bmm7g5/fQQ+kn4wUAgfg+QbCJrQbk5mCnn8gL
         hFtw==
X-Gm-Message-State: AOAM5332pHnF7dZ9kHLQ468K161BF33Sl3bF9GzHpOtliGwjKU5jzUXS
        A44TEAh7kNuRAGPQ3mb/P2g=
X-Google-Smtp-Source: ABdhPJzBtL3PAEY3N/qiHUGqDpGAp+B0oH8SxkTt89cp2LNCw8a9iUYpnbFmz1kHBGKLl4F/nVPuEg==
X-Received: by 2002:a63:1b53:0:b0:3fd:168e:d9a with SMTP id b19-20020a631b53000000b003fd168e0d9amr34794019pgm.617.1654859690303;
        Fri, 10 Jun 2022 04:14:50 -0700 (PDT)
Received: from localhost.localdomain ([209.146.108.140])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709028c8600b001636c0b98a7sm18497487plo.226.2022.06.10.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:14:49 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, linus.walleij@linaro.org, brgl@bgdev.pl,
        f.fainelli@gmail.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, huhai <huhai@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>,
        Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH v4] MIPS: Remove repetitive increase irq_err_count
Date:   Fri, 10 Jun 2022 19:14:20 +0800
Message-Id: <20220610111420.1520410-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
References: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
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

From: huhai <huhai@kylinos.cn>

commit 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx") added
a function irq_dispatch, and it'll increase irq_err_count when the get_irq
callback returns a negative value, but increase irq_err_count in get_irq
was not removed.

And also, modpost complains once gpio-vr41xx drivers become modules.
  ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!

So it would be a good idea to remove repetitive increase irq_err_count in
get_irq callback.

Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
Fixes: 979934da9e7a ("[PATCH] mips: update IRQ handling for vr41xx")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: huhai <huhai@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/vr41xx/common/icu.c | 2 --
 drivers/gpio/gpio-vr41xx.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 7b7f25b4b057..9240bcdbe74e 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -640,8 +640,6 @@ static int icu_get_irq(unsigned int irq)
 
 	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
 
-	atomic_inc(&irq_err_count);
-
 	return -1;
 }
 
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 98cd715ccc33..8d09b619c166 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -217,8 +217,6 @@ static int giu_get_irq(unsigned int irq)
 	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
 	       maskl, pendl, maskh, pendh);
 
-	atomic_inc(&irq_err_count);
-
 	return -EINVAL;
 }
 
-- 
2.25.1

