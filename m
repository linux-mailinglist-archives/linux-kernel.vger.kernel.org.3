Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC76F5524FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiFTUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiFTUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB32AF8;
        Mon, 20 Jun 2022 13:06:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c21so16099365wrb.1;
        Mon, 20 Jun 2022 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMBZF982Sgxs/kqKw98NXLNKJY18JDApVwptU4z2w/4=;
        b=G6wwdsUb0o0KkrQXWK3doZef7L8BgtwmGkyRy70p/dnnUdSeIm80U4/sQB+DU/UyBu
         lq+G3r2iFyKxiw8S2yrwvMIXSzdaqaSlzGS4cckrZH7OKT1FjnzDeBIuWam1Ix15Gcur
         CfuLb/IeNTNq7XCpjpezZA1RortUasUbT6SbqO7vsRpKBd8y8QVrNVDKk8S2BlgA83Qo
         sumJyldJr7QMcNLyzlmXUF+xt5g+wsclm5yeaMm9sxF+W/l0sViSgbIphnns4qWzmkfQ
         TOnbQAZGAYQPI0jnJ4I4pX8zAZqQjOgq7SNmFg/7Q/XM7k1OPTgUVNx0dMxnLUJdn+hU
         Ziwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMBZF982Sgxs/kqKw98NXLNKJY18JDApVwptU4z2w/4=;
        b=3AS8wc+BOr2M/QcpX/i3BK1t7cM5DGh13lAtd9MCaOIdGI6ISgXIPQkJh/ukz5BLGM
         vSRnxMhgOR1DMGjWJEZ14CUVljnM/t9YO03eiOhmtckfTsjXnbeNIHTQVGPUQ1/fmNzT
         RR7frBZdSWes5kqByw0JJ/rc5jxbp7VjUmwmkS1LEf5IYlRASL5LN7czHUzTOiZM7z3a
         Z5BGpmQ6P3fnrEnl/gdD6GfhsX7ULNeeuMZEtVKVnsR1spyX8RNQvDlSA2j3Ft4zJzm8
         xLsJDiPinSEW0hQXOYFPXAUvZ4h2Hhn8SfJJYXTKULO5ypb8+MoxKuK9hGWScTW5GW6y
         wlzQ==
X-Gm-Message-State: AJIora/FJfUXMIFH6VWPCJ9WGy4zcIDsOvW8IoMgoftZxr2Dpw6EXEn/
        ssz+bAvogddIC7+Fs27Xv1w=
X-Google-Smtp-Source: AGRyM1t4d4cjIVC7sSPWoVSQarvyp90HMRRx6FeW4tX3bvpi8rs+MlYEB74yzJdHRG+/yBrQgYJfeg==
X-Received: by 2002:a05:6000:1e1c:b0:21b:8a12:acba with SMTP id bj28-20020a0560001e1c00b0021b8a12acbamr10398783wrb.710.1655755578056;
        Mon, 20 Jun 2022 13:06:18 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b003971fc23185sm20679416wmq.20.2022.06.20.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:17 -0700 (PDT)
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
Subject: [PATCH 02/49] regmap-irq: Fix offset/index mismatch in read_sub_irq_data()
Date:   Mon, 20 Jun 2022 21:05:57 +0100
Message-Id: <20220620200644.1961936-3-aidanmacdonald.0x0@gmail.com>
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

We need to divide the sub-irq status register offset by register
stride to get an index for the status buffer to avoid an out of
bounds write when the register stride is greater than 1.

Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4f785bc7981c..a6db605707b0 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -387,6 +387,7 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 		subreg = &chip->sub_reg_offsets[b];
 		for (i = 0; i < subreg->num_regs; i++) {
 			unsigned int offset = subreg->offset[i];
+			unsigned int index = offset / map->reg_stride;
 
 			if (chip->not_fixed_stride)
 				ret = regmap_read(map,
@@ -395,7 +396,7 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 			else
 				ret = regmap_read(map,
 						chip->status_base + offset,
-						&data->status_buf[offset]);
+						&data->status_buf[index]);
 
 			if (ret)
 				break;
-- 
2.35.1

