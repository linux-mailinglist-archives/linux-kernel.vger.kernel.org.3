Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D38552573
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbiFTUJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiFTUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E11D0F7;
        Mon, 20 Jun 2022 13:07:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z17so6380192wmi.1;
        Mon, 20 Jun 2022 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqx3v8Sb2M8GmsYA5Ky+XV9uouybbnIvgB5+4WCQaEA=;
        b=I9SWwmkbAS0twwPt8IX4E7bPDCP7aUbF2QrdWQqioO/YT8vPWDbo5jafFWHLiMIjc6
         1mw/0Uimpyz3cUcNIuL1gNMxnkzOwuSG3edxomlaxXv/3L99G0JTdAg4POHGrEyB2REH
         3lIDZKKJ3rfCVWbTQEoaG7JmB0gDKFGBeqb20JXEMuxvSMR5CHUbycRO4F8LKhZqPuhZ
         YEBHTx15YFCjU5hxF8mncOccOzTdEdvUtBMGeSXsVkIqDI9MxnDbvI8sGUw4c4kcM2YR
         yU4ZYgDnXaav8BMzDiccmgOUBiOIkEhH4tyXriDpDiHGnyleHXKRGyMCZfOTYeUkSsCw
         fC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqx3v8Sb2M8GmsYA5Ky+XV9uouybbnIvgB5+4WCQaEA=;
        b=6W1Zg7dSszVMt2Xf0Ew94307ABMRJEKd72RIYk3msRjJVOslMU0Y1dfbjXOgYzXwAX
         OnbOop6mFkDcyTa28mGcvt7IXQ0Hkbv+Y3lWNRFCgxcJ548waH4YJ4ElidONXxz55cma
         HuTWD4+6c75RjWmoQPXSnPC5TY4YX/M8cFcaXMMkun+FFhed9chgHhEgkuWk4cqe11Mg
         O43Pp7FrSO6UeHrb85UKK0sH+EzLEHA7VyUKIl12YYkct5rAsfWRKtwz78Xfr7rVsgmp
         K7PXzehVeVpdvEt1IvYAE26klxT6b4WaMqWR2zr7jak0HuOu9yUcG04fPbuCeM9vrS8n
         h0yw==
X-Gm-Message-State: AJIora8y3WV4OwbU84c5igyYaundRYZY3CdfcVtVsho8XxcfrwwSyDA2
        AcI1N9x647g+l8nh+1kDaMY=
X-Google-Smtp-Source: AGRyM1swymX/u49DBHMJPPyC7OgnYJ7zcAJGoTucjUXlwJwy4Cy1b+UW+TJYIq67rmm7OR5jau1T3g==
X-Received: by 2002:a05:600c:5112:b0:397:53f5:e15b with SMTP id o18-20020a05600c511200b0039753f5e15bmr26726456wms.93.1655755622524;
        Mon, 20 Jun 2022 13:07:02 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0021b8749728dsm8178971wrs.73.2022.06.20.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:01 -0700 (PDT)
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
Subject: [PATCH 30/49] mfd: 88pm800: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:25 +0100
Message-Id: <20220620200644.1961936-31-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/88pm800.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index eaf9845633b4..6d1192db13c1 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -398,9 +398,8 @@ static struct regmap_irq_chip pm800_irq_chip = {
 
 	.num_regs = 4,
 	.status_base = PM800_INT_STATUS1,
-	.mask_base = PM800_INT_ENA_1,
+	.unmask_base = PM800_INT_ENA_1,
 	.ack_base = PM800_INT_STATUS1,
-	.mask_invert = 1,
 };
 
 static int pm800_pages_init(struct pm80x_chip *chip)
-- 
2.35.1

