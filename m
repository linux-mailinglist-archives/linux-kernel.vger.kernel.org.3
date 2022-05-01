Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB1516365
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiEAJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEAJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:25:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BF2BDC;
        Sun,  1 May 2022 02:22:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so10676082pjf.0;
        Sun, 01 May 2022 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HCQ44eZH+/9QUa02232FBEw4EN7psbkVPSA396nRkSc=;
        b=a0Kh8u+k7rPN2i1vNYvbBTWNyGNGoQdHsmgHyCb7LtDPlzbguUPbB8p2x+xRGktba2
         EmoFMREwWj4bplyVm5uMdt+m2Ckihl2H9zh8wyHYBWta+/j4EjNO/QAZfjMmOHn+V+dv
         IcDpAs/fdxDYUcLzzAMQli9w/pu+qcwWs4CCzKsHUJHHRs+2OHwj68eWbO8wA9+XXRg6
         q5hgqYrEthUemxjndp+ogSSdBMJ2v8znmDswI4oDZAB5hEcC370L+xlXzp6SRZoEXFJE
         yqZZ8Bq1zqc5sXQfZIhUKZNguPt++iutgYRmj61DNq9Uf8jeS28ipQabKDTaDtO1AIRq
         MXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCQ44eZH+/9QUa02232FBEw4EN7psbkVPSA396nRkSc=;
        b=5ak3rwrRi86b7Tr1EpQaxArRbiAJcBEeMbD97U6gPSLOelL8e4YQdFN8Phgs55nHz7
         vee551e2uBZFUR3DP95CyjpeY1tN935akcrzUwXx/Cgw7cSfuMqe1k4hi+MgZNKGdhxr
         LGp7L4yu1dMv2yVckmZo/4hOuRUyxUboCd05HvbKWOBKSG5PI4Qm6tFjiX7ySahcaUuS
         pYxtfHC17fYHjIST+BimBsTPqGSFwvqUGG5wNZfvQVk2HJs3ddAOS4NqMMMaTOc4zB2Y
         kSGkpSaWgQwwH9lIy3iqXs3nFz9Mqv2bqcfCtv0Zxs/wvoYsz128XKs9dsNiBtX8t/2H
         jMOQ==
X-Gm-Message-State: AOAM532Y9C4WbmupjduhjhdYO5ndgKatjNWUbMVO5ZCjoBlkt9k8Fxu6
        RyclnqraslIfEwBSvK8y96k=
X-Google-Smtp-Source: ABdhPJxA8rCdQ6saLansGk+2Yyyjk4o4/2JYvbyO7Asa7rmssc7nJIGrlyazBr77ea2QgSSG1w2OlQ==
X-Received: by 2002:a17:90a:bc8a:b0:1db:382d:6fb5 with SMTP id x10-20020a17090abc8a00b001db382d6fb5mr12550754pjr.100.1651396937432;
        Sun, 01 May 2022 02:22:17 -0700 (PDT)
Received: from localhost.localdomain ([183.14.29.224])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79110000000b0050dc762817asm2575279pfh.84.2022.05.01.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 02:22:16 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
Cc:     puyou.lu@gmail.com, Puyou Lu <lupuyou@aifrutech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: pca953x: update irq_stat even when irq is not enabled (irq_mask not set).
Date:   Sun,  1 May 2022 17:22:01 +0800
Message-Id: <20220501092201.16411-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Puyou Lu <lupuyou@aifrutech.com>

When one port's input state get inverted (eg. from low to hight) after
pca953x_irq_setup but before setting irq_mask (by some other driver such as
"gpio-keys"), the next inversion of this port (eg. from hight to low) will not
triggered any more (because irq_stat is not updated at the first time). Issue
should be fixed after this commit.

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 drivers/gpio/gpio-pca953x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2fe76f3f34f..8726921a1129 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -762,11 +762,11 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 	bitmap_xor(cur_stat, new_stat, old_stat, gc->ngpio);
 	bitmap_and(trigger, cur_stat, chip->irq_mask, gc->ngpio);
 
+	bitmap_copy(chip->irq_stat, new_stat, gc->ngpio);
+
 	if (bitmap_empty(trigger, gc->ngpio))
 		return false;
 
-	bitmap_copy(chip->irq_stat, new_stat, gc->ngpio);
-
 	bitmap_and(cur_stat, chip->irq_trig_fall, old_stat, gc->ngpio);
 	bitmap_and(old_stat, chip->irq_trig_raise, new_stat, gc->ngpio);
 	bitmap_or(new_stat, old_stat, cur_stat, gc->ngpio);
-- 
2.17.1

