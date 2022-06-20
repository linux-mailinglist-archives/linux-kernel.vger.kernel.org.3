Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F36552531
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbiFTUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbiFTUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAE41EED1;
        Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so8296616wmq.0;
        Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDbkoyglFzlD/is/5GkDF5bxT9ENs1AtX/zXNAcYF8s=;
        b=gdmCZ/lBOcInOC7Vpu1bY/iCkTRvuWC70p3sTpyPTGpiGjPvbOfn3qCcOS6TYvfax1
         3L11FjZaxXZKn19jySJpcCpWV+xtFrtQQCVooDpT2B76t5Yf89SzliwlOHigso1rDVLk
         oTKVebpiS712yjcf0kpN9r3uejsVQPOSwQQwOfRTaV3WxoLZf11oL8qGCQ6IIb3JKTvH
         Gd5oqTmwdqCLXQGfP9Un8n1q4CYFfIWgJvxX8PaS4jqeICZF2WLj79nuYT2SFdtS4Hri
         hh9xIXG5EB3E4bg9SOAm4e7Z9wjbeiNwP/00cDnzR6iUmi2i9i1qZqeOzh3rmmFV/C0Q
         vMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDbkoyglFzlD/is/5GkDF5bxT9ENs1AtX/zXNAcYF8s=;
        b=vwNP5QeGZvNQP5tGjpSuHJqw6IwRzQFpMmGgXIxYQ9c08ATyJclMeaEXk0Hcq0E0Yh
         kEGJBWZrlxV6WOx6bY+mV3E5UHelJgoZkicLH9ep8xmchJrL4rOCaudwvxbt2xkVbi2+
         ri+ern06qHUcw0L7/YxbSP5obeOOPfwi4TCdDwkkxVGgdgknWsKI9cVKexvE1Ntb8UG3
         r/udmFtgZC9/1NGZ5gJg0HTmYhrYFdd4oIaSYfigHuo/2GOdCcUqLSzzw+UuvPhfGOJ3
         vaTaq+sxcT2T6frxwZeuFacXUOyXLUJVLob9uWkigLeQqUTBKzXIDQjslbh1mTwtrc+v
         SkGQ==
X-Gm-Message-State: AOAM532oWoPvGWFQJVd3YFO7DAbDa5P4Np5bCws9Xv6uKx8PfAjfWSfx
        snGOzwUbFS+zicKzKSKAFfU=
X-Google-Smtp-Source: ABdhPJynux7C1eoNMlx+vUMO5VOj8q1wBlYfPuBT+ReLmKHLRHcj/n+Q7FNGG42F1xN9EMg0dcGAng==
X-Received: by 2002:a05:600c:601f:b0:39c:416c:4069 with SMTP id az31-20020a05600c601f00b0039c416c4069mr36844654wmb.85.1655755603037;
        Mon, 20 Jun 2022 13:06:43 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b0021b966abc19sm300460wrt.19.2022.06.20.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:42 -0700 (PDT)
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
Subject: [PATCH 18/49] mfd: qcom-pm8008: Add broken_mask_unmask irq chip flag
Date:   Mon, 20 Jun 2022 21:06:13 +0100
Message-Id: <20220620200644.1961936-19-aidanmacdonald.0x0@gmail.com>
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

The qcom-pm8008 appears to use "1 to enable" convention for
enabling interrupts, with separate set and clear registers.
It's relying on masks and unmasks being inverted from their
intuitive meaning, so it needs the broken_mask_unmask flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index da16566f7883..18095e72714e 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -141,6 +141,7 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
+	.broken_mask_unmask	= true,
 	.ack_base		= PM8008_ACK_BASE,
 	.config_base		= pm8008_config_regs,
 	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
-- 
2.35.1

