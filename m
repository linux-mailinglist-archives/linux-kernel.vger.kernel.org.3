Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7683552549
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbiFTUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbiFTUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB791EADE;
        Mon, 20 Jun 2022 13:06:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i10so12332819wrc.0;
        Mon, 20 Jun 2022 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpYblgk0QSEipNVW12nK1FeMQGvN8soBnfpEkcmUf1I=;
        b=iAVKi4f8I7CLeg4ffvFzsvKkDzx2DfoiAbr47iYacvEU+s3bdgepP+twUMbdjqFjZN
         HP9GhewZ0kBzZGLj0hMJgiO7cc3Vd6E/UF8i8c0andQvvQgzYryRgJ2xWzPE8ISGsHKU
         3jAsd30KJ0Vgc2BjN5czd14edV+jCCHuBh/c8p0HdAHMup5HduI34U/Ox+duIKPJ+3ag
         kMTEimL4vWw+NINiHeamf6NkIE0VHr/u3/NsESG0RHXMSG5UD9ZPmUG7ASDj10MCe43O
         AkDOSBGlCU7xbJuDGODEpXltkmTY8pHt9UDDKC8kna2c/yvWdCAx6ck4c/uz1z2HYYQ6
         wUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpYblgk0QSEipNVW12nK1FeMQGvN8soBnfpEkcmUf1I=;
        b=rl7jbRR1xJuFkPhFDrBQriG9/qYU9CZGTJ/sNl8NULdH9bNVTgQfS014JSSQJyUR2t
         T7BrGfEELzqBkn5WdjOGS9dxmyn/M+hSX0YrKdojXi08isQb8tejmHvVPnQ+mj5Lsphr
         gK3HsuXWH8giaDvFLKuBnSpDLd5W+Sw8gVcthj0L/Ktc/X5svJSkFb8XMdD4htDBdOGe
         CtoUqrJkAWawPbyRt83U2Rd2b99KIowvJTH3LCeFQXMKLAa0fxb3qbbYLx5BlOwGt+pd
         FZCj8ssbMOxIHZQ/pbACwwcbVQjCCMaZZ9lTeJOiWXvvc+jH9irDCdeznGMV/V0C8VHJ
         4c+A==
X-Gm-Message-State: AJIora8eaJr2mUNxYW5izGXLaEgFP4sxSWksXBeRQsh8Td37D7N135TU
        u9qv5vhiU2Jfnt3pFejOfwY=
X-Google-Smtp-Source: AGRyM1uneR86manlptXeALcQUO9hJesML7Bpy1KKOUEomIro61DKoiDecYWOPz8k3Wd1mtwzsz07yA==
X-Received: by 2002:a05:6000:1052:b0:21b:927c:1559 with SMTP id c18-20020a056000105200b0021b927c1559mr4204605wrx.303.1655755595143;
        Mon, 20 Jun 2022 13:06:35 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id e16-20020adfdbd0000000b0021b91ec8f6esm2936708wrj.67.2022.06.20.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:34 -0700 (PDT)
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
Subject: [PATCH 13/49] regmap-irq: Remove unused type_invert flag
Date:   Mon, 20 Jun 2022 21:06:08 +0100
Message-Id: <20220620200644.1961936-14-aidanmacdonald.0x0@gmail.com>
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

No chip has ever required this flag except for the max77650 where
it didn't have any effect. Drop it. The code that checked for it
has already been removed.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/linux/regmap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1966ad4d0fa5..ee2567a0465c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1466,7 +1466,6 @@ struct regmap_irq_sub_irq_map {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
- * @type_invert: Invert the type flags.
  * @type_in_mask: Use the mask registers for controlling irq type. For
  *                interrupts defining type_rising/falling_mask use mask_base
  *                for edge configuration and never update bits in type_base.
@@ -1520,7 +1519,6 @@ struct regmap_irq_chip {
 	bool clear_ack:1;
 	bool wake_invert:1;
 	bool runtime_pm:1;
-	bool type_invert:1;
 	bool type_in_mask:1;
 	bool clear_on_unmask:1;
 	bool not_fixed_stride:1;
-- 
2.35.1

