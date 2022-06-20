Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D2552529
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiFTUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbiFTUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8841CB34;
        Mon, 20 Jun 2022 13:06:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e25so12215512wrc.13;
        Mon, 20 Jun 2022 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygggAhOijcuCf3qt1rizt96GNeoo90FsvWvR8LV1nyI=;
        b=T/UvuXuobHYQjUmOyYbANq63UlOF39LoQ9F0gifyzekhcyCOQUypCEyXG/OKpb2La8
         Q6xZerE2gogPQTVjnWE4wmzodDreHkzH5Hob1Yofhw+6nVU3v+x19k/F+1fzWd07Nhyx
         t3dlqulqzXj03B/a7eof6RPLvdFSbbKgQ0qPPyyfUc0DvtgH5rSWtXFv/QKk3GFNsmgf
         ba5ere/Jpb7EyG3rOfQF0QhkkW/aBY4cYS4Nq+Vs12xBWeLC+F11zEPyoGk+7XAQtopt
         0onYAtqYMepxk8EG5VyJd6DPsfXoBs96h/qfy/t4bsS9pyheZRo3qyXWG31pXvk7VX4q
         +KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygggAhOijcuCf3qt1rizt96GNeoo90FsvWvR8LV1nyI=;
        b=w2T+aWxjx6v3xximQzIXNjApU8RxRVb8aLcnU0lCxR2hSrYBoDuoJn1ugbnYt5uUvi
         QuZglYsg7Yu5UIafaYTb+R/8/Ux3Z7qN5XKvwef9fWKcJBl0VE3RMtdQxOAS2CzSRnPU
         EA7bsLcjgZd1aXQ75ru6r0SuDXBY3E/VzTVAHJ2CWCpUQrZ9eSubyF/h2ucmS8EFL1G5
         As5Bb2eiypl/BYVnzt7i7Q0626fC8qjYEUN4StSj3LcVQrv3f8aKOqUf5lBHtdHVcMEH
         gm+MPLZW7n+4syllERXEcq1Fl7t/2Tq2Eb18U+gfZahdx9WsaI/KYzpFyHAkq0jiCug7
         DX6w==
X-Gm-Message-State: AJIora8ak51DZVUUunTpQNpK7j6hFl+sICbigqmw3rSiOH8lEpz+NY/U
        GGyAdXyW3Z0S6oHcIW0yUbM=
X-Google-Smtp-Source: AGRyM1solEebsJ8aWFaYBBFyec3sD94nnN3uwK9ZwQuWOqy8ZNWOPbTCC9XYFknZ9HYg3JgppifEhQ==
X-Received: by 2002:adf:ef42:0:b0:21b:8e58:f24b with SMTP id c2-20020adfef42000000b0021b8e58f24bmr7538227wrp.257.1655755593841;
        Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0021b8749728dsm8178248wrs.73.2022.06.20.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 12/49] regmap-irq: Remove unused type_reg_stride field
Date:   Mon, 20 Jun 2022 21:06:07 +0100
Message-Id: <20220620200644.1961936-13-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
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

It appears that no chip ever required a nonzero type_reg_stride
and commit 1066cfbdfa3f ("regmap-irq: Extend sub-irq to support
non-fixed reg strides") broke support. Just remove the field.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 6 ------
 include/linux/regmap.h           | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 85d7fd4e07d7..b24818ad36e6 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -40,7 +40,6 @@ struct regmap_irq_chip_data {
 	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
-	unsigned int type_reg_stride;
 
 	bool clear_status:1;
 };
@@ -738,11 +737,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
-	if (chip->type_reg_stride)
-		d->type_reg_stride = chip->type_reg_stride;
-	else
-		d->type_reg_stride = 1;
-
 	if (!map->use_single_read && map->reg_stride == 1 &&
 	    d->irq_reg_stride == 1) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 879afdc81526..1966ad4d0fa5 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1483,8 +1483,6 @@ struct regmap_irq_sub_irq_map {
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
- * @type_reg_stride: Stride to use for chips where type registers are not
- *			contiguous.
  * @num_config_bases:	Number of config base registers.
  * @num_config_regs:	Number of config registers for each config base register.
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
@@ -1535,7 +1533,6 @@ struct regmap_irq_chip {
 
 	int num_config_bases;
 	int num_config_regs;
-	unsigned int type_reg_stride;
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-- 
2.35.1

