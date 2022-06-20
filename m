Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8087F55259E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344472AbiFTULq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiFTUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:09:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778621E2A;
        Mon, 20 Jun 2022 13:07:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g27so9434454wrb.10;
        Mon, 20 Jun 2022 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rE0XsHvuQMGHkh+DWN4I0u4Mry72SZTz94U/AwkKe64=;
        b=R2nM9gpViD7RpxZufBEYDf0sqKPJn+Vqc0jUeZDkwV0e+SnITT7LfK/9yzWVU5IQhu
         aA8WUpzc6J0Qf7iIoRilFZEWo0nV5HsEN4NblRAipOFGBlQ/fSulqH247JQGB+Vbnmz6
         u+j2et5Rf+Emw9sgGoIp8Ua1g6/wgIJuStK0XWLJu64d2gAGwoDQCdtaVYypYAWvkfQX
         jXux0apgjHCpI8qq2XpRhrhdyFsE0YxHMLP8R6wnnvs9dQt5nl7aqrNMv0hrLaXmrugZ
         kyh9aob6sQAuWXwqPokSAhhl/C8pUOash7nUyLmMzRyTrdLb7ZhEwWLRjTGZ/E7DshAW
         tGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rE0XsHvuQMGHkh+DWN4I0u4Mry72SZTz94U/AwkKe64=;
        b=q/bEHTx3Op31ZBRV/k+Dwc3qGgd/xit2ItPgI42C880l/Dt88ZQLPkTTRQt9wF3VoB
         OeWe1CLg1CudSqxmXle/rq0ueoDAoA9B7k2TY4EZdE/4ng1VR3TGDN5aEhZqVoZRV4LB
         CkQVYMKWchkg31TegEkUl0BZsRbO5NFzkCLWhi08EGaRAHDyNMVSj+FEDJf/Bxgq5cWd
         rbiC78udmTNxJ4AYLgtU+NJWNMznonSJBPOJQ7qNGgor0QXAV+7rzA4AMu38Yahjd7U5
         yHH363qHRwvGVppAGXm7S0iCuHfFtcynXFMNheUGnS1tEBlcJ+OcJNrJEYZUCiuP1QO3
         Vg6A==
X-Gm-Message-State: AJIora/jm0SvaIAdrXIEkfNbzN0Jxq7i4oIdOaITPFeIbEkThtvoO/Ej
        3MsWzSfX13m+ZqQSy0fX160=
X-Google-Smtp-Source: AGRyM1utPBE8XYxoB7U0xnTciGPQVtQTgTqRZ99c6POU/yfZ+JPXfl21N1f7SnJeHKblgblpcXVNWQ==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id h1-20020a5d5481000000b0021a3573def0mr23413256wrv.28.1655755646148;
        Mon, 20 Jun 2022 13:07:26 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b0021020517639sm14095785wrs.102.2022.06.20.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:25 -0700 (PDT)
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
Subject: [PATCH 44/49] regmap-irq: Remove broken_mask_unmask flag
Date:   Mon, 20 Jun 2022 21:06:39 +0100
Message-Id: <20220620200644.1961936-45-aidanmacdonald.0x0@gmail.com>
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

Drop broken_mask_unmask flag; no drivers are relying on it anymore.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 9 +--------
 include/linux/regmap.h           | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 082a2981120c..8a718615fd09 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -723,15 +723,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 	/*
 	 * Swap role of mask_base and unmask_base if mask bits are inverted.
-	 *
-	 * Historically, chips that specify both mask_base and unmask_base
-	 * got inverted mask behavior; this was arguably a bug in regmap-irq
-	 * and there was no way to get the normal, non-inverted behavior.
-	 * Those chips will set the broken_mask_unmask flag. They don't set
-	 * mask_invert so there is no need to worry about interactions with
-	 * that flag.
 	 */
-	if (chip->mask_invert || chip->broken_mask_unmask) {
+	if (chip->mask_invert) {
 		d->mask_base = chip->unmask_base;
 		d->unmask_base = chip->mask_base;
 	} else {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 0cf3c4a66946..a3103c88e936 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1524,7 +1524,6 @@ struct regmap_irq_chip {
 	bool clear_on_unmask:1;
 	bool not_fixed_stride:1;
 	bool status_invert:1;
-	bool broken_mask_unmask:1;
 
 	int num_regs;
 
-- 
2.35.1

