Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116DD552516
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiFTUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbiFTUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4985B1EACB;
        Mon, 20 Jun 2022 13:06:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g4so16059750wrh.11;
        Mon, 20 Jun 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CygB1KehYAHqhpc4bRUhgcxf+zQL9loE7cQLl/MEP/k=;
        b=VdNEnW4i4C6kZGpiqp1Jxmc+HT2MVBw6IwavlCehBQXlv5QOH8TPwVeq3H4ho5YMpx
         H8exp7Pq3R8RMqC3UBwjz4B4XNaNN5lfob6sT6+PndMQfoaU+DTqcC6wBk5rfoCSNQCJ
         /25J++hcAVbS0URhiPSxzu20PkT4vyStw3QlwmbqipEVuj0SMfiZBMh7ShX9R9n4h95O
         9crhgA7QEsaJW7A0sgHALhx1p9ncqoWinxadYQ4mbkrwCqLicK48miZo2piT71YFto5R
         e92szgit9CnwLu5DANwjGf3x1RqZ4wrj46ixAYyPN9ECBgT4l9bBF3FVNWT0DQBc63Y5
         2+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CygB1KehYAHqhpc4bRUhgcxf+zQL9loE7cQLl/MEP/k=;
        b=AR6T1ujLFIeUoycaBjYrHgappAL9D6Yo4EoJ496HGLahXY35ro1wR6o/lETqmRkVWR
         F370U5gvstSf9V3OnuymkISj3RjOHP8a48QEAQBIVnL0h4ICw3RPIdW2zMOKze3MHmsI
         m5vycXT9giNKTGB5/VlLRxeOWfU0+gmXzZV4uEX4IB6cHWUat9z0R4fcs5YnQ/NCuo8j
         Y774lLrFpGG8OP6khNNskb9IEnORnc8evbsy6JAd3aZUCH69719Ci6WSr/CMoS4cZNUl
         Py3p7mm5M5M1yE+ED/XHUa/dSxPh1EI4Z7mAUNTp6lzFwpMrVKeJcqDt/P8Oas4rr5Ye
         7X8Q==
X-Gm-Message-State: AJIora9LV86fqahHhSeT5CbXy2gJGwJTTgfY+8GG2RaoKnNdp0xUkpeb
        7mIortoUmeGIoeBJ8gVJOPE=
X-Google-Smtp-Source: AGRyM1v/XOcLvn/YOZvKeR4GgDqyzG8bAWUAUx2H4/vrgHli6exwOFqzUpGDvK4ZhP7QI3IhQMp+Sw==
X-Received: by 2002:a05:6000:1567:b0:217:abea:6a67 with SMTP id 7-20020a056000156700b00217abea6a67mr25796898wrz.305.1655755588840;
        Mon, 20 Jun 2022 13:06:28 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id a13-20020adffb8d000000b0021a3a87fda9sm12865573wrr.47.2022.06.20.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:28 -0700 (PDT)
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
Subject: [PATCH 09/49] mfd: max77650: Remove useless type_invert flag
Date:   Mon, 20 Jun 2022 21:06:04 +0100
Message-Id: <20220620200644.1961936-10-aidanmacdonald.0x0@gmail.com>
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

The type_invert flag does nothing when type_in_mask is set,
so get rid of it.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/max77650.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
index 777485a33bc0..3c07fcdd9d07 100644
--- a/drivers/mfd/max77650.c
+++ b/drivers/mfd/max77650.c
@@ -138,7 +138,6 @@ static const struct regmap_irq_chip max77650_irq_chip = {
 	.status_base		= MAX77650_REG_INT_GLBL,
 	.mask_base		= MAX77650_REG_INTM_GLBL,
 	.type_in_mask		= true,
-	.type_invert		= true,
 	.init_ack_masked	= true,
 	.clear_on_unmask	= true,
 };
-- 
2.35.1

