Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0141552577
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbiFTUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiFTUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58921E05;
        Mon, 20 Jun 2022 13:07:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so16099470wra.5;
        Mon, 20 Jun 2022 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqZEE7XdviwRWITP3iO6UBVL417kMvPw/5cpdhOCnY0=;
        b=TIaLYM+7aLuuRlXrQlapwog96FVtU0ooWGOQ047CVxq6/eBhXYieIqxwCcMXfW3g6t
         f+HGuhXPfSxIelrPnYEN7OU7peoZLJxZnRXDaJcr5fL+fEf69btKbTF4tAUZNYQyHScv
         iwtpLeRs+BLtCQHpOHV5HTtcb+smm2n5XiEw9va+rWEPvmpRhr9uihWsn8c3AWaKo2tu
         ixhGNtLy3TSWF+J6E4waInzEuxA2ck3ipVwp4MrV2tbNe0NS3OQkYDrzOC8k9atTsxJT
         71CeVTVSDdBpYrNOzHBu5VTgwxnGKG7OS+jOMILWiKTmwhHwDvjmfpRNJ4UZ4pzCshkj
         2pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqZEE7XdviwRWITP3iO6UBVL417kMvPw/5cpdhOCnY0=;
        b=hbvN7P/TkiJh54n0ndNJPWNP70ONEq2WGN4vtIDDenuMUmrSFmq+uJETdloTobBw+x
         a5+zM8huJwbRh2eptO/V1nqvqiCarv+htn/x+eHuVIRB7+Es1reKiqMivF/xWpjTyQZ9
         kB7ARB/ZARNMKVpQ6bJBoB2rBRZhDjRl9RT/fAKTmC18FYbWrsPdIJ47TUhdwnoUapn0
         K/qk+lSj18mvdUu1GwsCxZGSUX3/pL2VJe1/ZMCaw09kQKiO9/aNi5n/OJmX1dIHeTar
         w+ZSbjuW1gI6pAixeMnyVvGV72aP56le1EiqgSCLpQv3MFoXNXX/QkaTZkLmbbpx162A
         W1jA==
X-Gm-Message-State: AJIora8clNhyjBraSHh1OV15ZDrjojPsvhZRkZvtvzLFzbaeBth0LwWK
        MKiSB73zrO0UejVxtqKbnFI=
X-Google-Smtp-Source: AGRyM1t7fF9oWyoFMD4Gd1xha3GDwq5quNlzvF+7I8uqpwdkfaVZSf+y3kr/8cPcMtmBqNLfvwIwNg==
X-Received: by 2002:a5d:5885:0:b0:218:3d12:e0eb with SMTP id n5-20020a5d5885000000b002183d12e0ebmr24861338wrf.510.1655755642796;
        Mon, 20 Jun 2022 13:07:22 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c014a00b0039ee51fda45sm12789702wmm.2.2022.06.20.13.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:22 -0700 (PDT)
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
Subject: [PATCH 42/49] mfd: qcom-pm8008: Fix broken mask/unmask in irq chip
Date:   Mon, 20 Jun 2022 21:06:37 +0100
Message-Id: <20220620200644.1961936-43-aidanmacdonald.0x0@gmail.com>
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

Swap mask_base and unmask_base, and drop the broken_mask_unmask
flag since we're now expecting the registers to have their usual
behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 18095e72714e..7bc6becfe7f4 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -45,8 +45,8 @@ enum {
 #define PM8008_GPIO2_ADDR	PM8008_PERIPH_3_BASE
 
 #define PM8008_STATUS_BASE	(PM8008_PERIPH_0_BASE | INT_LATCHED_STS_OFFSET)
-#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
-#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
+#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
+#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
 #define PM8008_TYPE_BASE	(PM8008_PERIPH_0_BASE | INT_SET_TYPE_OFFSET)
 #define PM8008_ACK_BASE		(PM8008_PERIPH_0_BASE | INT_LATCHED_CLR_OFFSET)
 #define PM8008_POLARITY_HI_BASE	(PM8008_PERIPH_0_BASE | INT_POL_HIGH_OFFSET)
@@ -141,7 +141,6 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
-	.broken_mask_unmask	= true,
 	.ack_base		= PM8008_ACK_BASE,
 	.config_base		= pm8008_config_regs,
 	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
-- 
2.35.1

