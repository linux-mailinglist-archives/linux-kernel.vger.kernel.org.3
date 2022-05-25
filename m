Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75525533639
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiEYEji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiEYEjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:39:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76853712CC;
        Tue, 24 May 2022 21:39:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j6so18192176pfe.13;
        Tue, 24 May 2022 21:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vXVsgwKtUaw0V1Fq8RPakUDJoY8CKRW6exHiFO/kwrw=;
        b=b8ZoSoY0cFYBBNVV/ipucUF8jBRRVwoPbyIqsvpc0aK+WODaTZ/3T69ykEbQ/QLfkA
         VDhtES8tX5h0Wv6wwItTOaCSjslpygebN5KtW5ER6VZEUpgxaAZ7hGW241ehVRRT45Kb
         2nCUwVjoDObAbnfLDARe3/FvdV92joWc4/CbXs5uIoMXgZDzOcI6tLAWWeeHqn2Bco7T
         zxl49fRXknez25IgXFQW0A5Mp6+fSTRIOHGjJnZ45QPezU/8RS+6qPvvUwhOcAdrQk0X
         8Ogir3ZDNyovdIbENR6xyD3TkAXZGxDFb7ejnLIqzRM/fGNNyTXevA4ckzDgwpwnG1Jh
         HJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vXVsgwKtUaw0V1Fq8RPakUDJoY8CKRW6exHiFO/kwrw=;
        b=hR6OGxRG0h7+EnoAJ3cwvVDqT9R8iVCYEPiIiZMMZFGOVyXSDscM7Rs9IRmVQaY1DB
         dv5PvRlHB8Eq6T3AdarUaCP4/b4aZ8XK5s23FxAQErYGWsKju/ICL9uT7pcc4oEcVtyS
         PW8b3QFCvuX43laMgObVFLFm/oUrE562nxu3F3R/XDzAqbcXcXHvMLrvuloJYYLG7YCb
         LaOKuWFDV/UTMuCS3FIvXZzLWU7xVnEhgumsLP01uoonS5XQfGkP0yIpSu7EvjtlCbkN
         ZN6VQxep7CUzRnEacTgyvuwZzLOd6NSqU+L1DAaychaK0DC7gnlyiP5z58a+XpMmsOUO
         rBMA==
X-Gm-Message-State: AOAM5311buuLQqnF0fy3vp35zhp2HV9IDNfoKOj7y0+3iw++RvKj63qk
        ylQT3BBlgXQgKGWV4RkWA6E=
X-Google-Smtp-Source: ABdhPJx8lwQ9uN/LNAY2iJ1MkCggmIDKWQLR9CEv1QEfh8C/kwTWZfvTX43dAzCJ2a9dNEVOfvVL2Q==
X-Received: by 2002:a05:6a00:174d:b0:518:3f5d:eecc with SMTP id j13-20020a056a00174d00b005183f5deeccmr30048410pfc.22.1653453571801;
        Tue, 24 May 2022 21:39:31 -0700 (PDT)
Received: from localhost.localdomain ([103.167.134.51])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b0015e8d4eb287sm8158701pla.209.2022.05.24.21.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 21:39:31 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, linus.walleij@linaro.org, brgl@bgdev.pl,
        f.fainelli@gmail.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, huhai@kylinos.cn,
        zhanggenjian123@gmail.com, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v3] MIPS: Remove repetitive increase irq_err_count
Date:   Wed, 25 May 2022 12:39:16 +0800
Message-Id: <20220525043916.584850-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
2.27.0

