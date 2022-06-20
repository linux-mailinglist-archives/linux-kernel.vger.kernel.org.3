Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2597552511
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbiFTUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbiFTUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16E1E3F0;
        Mon, 20 Jun 2022 13:06:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n1so15842333wrg.12;
        Mon, 20 Jun 2022 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX/yDVwKkfC5joprzjhLTLUj2n8x64TTg4RMNQ20jNw=;
        b=EJbtvC5hJvHxpndMkFlPD86W4NZOimlOhDeQWXXsnvu8LCn08/ZUypJbCVlZT8Zuhn
         XmUdbUWQxzrNNs2DmjZS3cX9l4SmZeoOAinDDjt7qIBZ1kZbLnv/kaRvrnevyMBMjeb4
         hOXAaAWFkIccOi0rRaIQHvD9FbXJP6JG8+uUM2Yvgiq+4XMa45SLpysk/cPJy2kEz+5M
         XzYjPDhx4KLybpC23mko2FoWhrLe2DoqaS//+ApXLqEFVX/NLWz82gpyhjFvOFIuBnqD
         SrjohLlUiNBtgW5OAqfemvUQFWciS+bIq9Btr5bpWiH873KE5azsyZ1i9j1W55ltyC5w
         XtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX/yDVwKkfC5joprzjhLTLUj2n8x64TTg4RMNQ20jNw=;
        b=2uL1PmV19AMnJQ41yHrzMOiGGPA/9ff/0SFeWH/QlrnBs/O+abGSj95AVaFiOYcodd
         B1SDdOJS2mSylaxJtZwPy7Ih+P7rWZybLtorhhiXOOO3ogJrSfk32Ht3257aLd90zkgj
         0Wf5pVsljE8jHbfcvQtuQl34nS93wE6Gl09vBg/UtIs1FwIZl4TWx38oHcS3Lv7LuYpG
         eZpGhp3r/9vWriBekdpNSYBWH5VMuiwyEJrtCiV/uXH1YMzablxSqKdLN2qalu++sUF1
         Wvkc7andpX0TRXmtiSSPwWmGbtOGzg1wHrPhGFmPUsmRZGXOndJRiqOzhuPEhOXPcoNo
         O08A==
X-Gm-Message-State: AJIora8tQRR9ZG5Vas2KACJu54wnoW4Jdo/Kbh+E9tAD2UQR4JY4U5WY
        d6n0wxOqliS0SqyuL4L65G8=
X-Google-Smtp-Source: AGRyM1uZmrSpfQCxnF3FN/c4+CKx0AmJvG5Ujc+oe6FV8JjIcjgEvKjL58h/5RQFttDX69HrNrpXpw==
X-Received: by 2002:a5d:4d52:0:b0:21b:93b4:6a2a with SMTP id a18-20020a5d4d52000000b0021b93b46a2amr3588083wru.576.1655755587154;
        Mon, 20 Jun 2022 13:06:27 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0039c5224bfcbsm20984858wms.46.2022.06.20.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:26 -0700 (PDT)
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
Subject: [PATCH 08/49] sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip
Date:   Mon, 20 Jun 2022 21:06:03 +0100
Message-Id: <20220620200644.1961936-9-aidanmacdonald.0x0@gmail.com>
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

This chip does not set num_type_regs or define any supported IRQ types,
so regmap-irq can't configure its IRQ types. Including type_base in the
chip definition is therefore redundant.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/codecs/wcd938x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index c1b61b997f69..acba253b791e 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1298,7 +1298,6 @@ static struct regmap_irq_chip wcd938x_regmap_irq_chip = {
 	.num_regs = 3,
 	.status_base = WCD938X_DIGITAL_INTR_STATUS_0,
 	.mask_base = WCD938X_DIGITAL_INTR_MASK_0,
-	.type_base = WCD938X_DIGITAL_INTR_LEVEL_0,
 	.ack_base = WCD938X_DIGITAL_INTR_CLEAR_0,
 	.use_ack = 1,
 	.runtime_pm = true,
-- 
2.35.1

