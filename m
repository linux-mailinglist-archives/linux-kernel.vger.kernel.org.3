Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97275552579
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiFTUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbiFTUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6E1EC4E;
        Mon, 20 Jun 2022 13:07:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w17so16065859wrg.7;
        Mon, 20 Jun 2022 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO+iuOKogLq1gEhCZXsb9WMdWtj7M6TVjC1w+kM7coQ=;
        b=YUDmW8ZJsJxu9mf+AG0DiMhcJc31kRVZ4ADkdSPk8W6VHXXqo4OhpTn+ltak91umjD
         t2+KAswtChyR/y4NqqTx+RmQR/8HLN00XtsNQ0e4xwfKxuZBByicexl2a5x5LBn3I0pk
         x8JO5FxRZt/KDQOCVtNQIKgDYlK/FvLijeVz2EHn2mzjXxfDjOvMwunXb8JB3OkGfefD
         6GNtm5l9fhoIdmSS9kdw/3MIBC2aqx27mxgbqN6E4qbJINN1Ul/S8xgw8SLML3o/B/QQ
         Kk8/5xYVjIsLkrwsviBZMNweB6p+q9qY5xoEECUP5iygiuGIb6cd2pLwlh4Zo+v28+Ho
         aKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO+iuOKogLq1gEhCZXsb9WMdWtj7M6TVjC1w+kM7coQ=;
        b=b5efWzYIvgmKxnk4lgReOX3+iov96eloTlWfUcR5E6clj98+vRh7i+/ogWakqO4qmF
         0DD1BUC2DiHaFpgkF4XsN6Om8N4YFu573++4ikNJa4vN9yeTauOHqtd+whPlQaDcpQIn
         E9V1HjD/hdg4//mDWtwFcCc03SWgBt6zreQNg3Sel5Nj/1ykhgrsXcr30vdUIgTTgNmi
         I0VLh0QLRn6yGeKOLTtVr2FUtEoOkMwA3QO90XZ9z9GMHVIY703BHn6Xv3TBrmUnfdSi
         fQuDPOifwx0R1XHS9rxfl4Y3MWxlnNqCJ4xJf5chzPgVEXmh8fOPstpLh5+F1vhtQZel
         wFDA==
X-Gm-Message-State: AJIora/zNVuXG9ljtiIsOl1N6Q7jdRX1xIkEv/w2vivFMLB0D5MB0gNy
        /qAdd9rewE+XSw+CpJA0Krs=
X-Google-Smtp-Source: AGRyM1uQnJZI6JTSn/IXnIpbA1+48K9Xd0eSzXtkoL8kKSucoVse7cEUTXPmpKK2qI8vGS5EmgHfHA==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr23039009wru.631.1655755631108;
        Mon, 20 Jun 2022 13:07:11 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b00397402ae674sm20063059wms.11.2022.06.20.13.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:10 -0700 (PDT)
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
Subject: [PATCH 35/49] extcon: max77843: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:30 +0100
Message-Id: <20220620200644.1961936-36-aidanmacdonald.0x0@gmail.com>
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

An inverted mask register can be described more directly
as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/extcon/extcon-max77843.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 8e6e97ec65a8..1bc0426ce3f1 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -189,8 +189,7 @@ static const struct regmap_irq max77843_muic_irq[] = {
 static const struct regmap_irq_chip max77843_muic_irq_chip = {
 	.name           = "max77843-muic",
 	.status_base    = MAX77843_MUIC_REG_INT1,
-	.mask_base      = MAX77843_MUIC_REG_INTMASK1,
-	.mask_invert    = true,
+	.unmask_base    = MAX77843_MUIC_REG_INTMASK1,
 	.num_regs       = 3,
 	.irqs           = max77843_muic_irq,
 	.num_irqs       = ARRAY_SIZE(max77843_muic_irq),
-- 
2.35.1

