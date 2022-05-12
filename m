Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871252557D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357978AbiELTOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357953AbiELTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:13:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F54B1D4;
        Thu, 12 May 2022 12:13:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d15so10790201lfk.5;
        Thu, 12 May 2022 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=NH89gipF5eTmxoW+StfsmD2/O6lE2BaP0uBaIgqeKWkQBIoPwVXTQolZjdHRx/r6aa
         FemUPRihV8Iu+dVJECCQaSVo5ubXpWbc9rVHZl6jUSgREavQxQELiHgMlcfp0+iq/lJq
         zV045HoOEFrBlAyCC6s5cHTbP+mWYRSkjmFWX4e78mVgFLo1qttmJsY1vAZGzAWcCYb8
         T0IRxNzcqypA3QPIx2If1LZ5pSR+WaLfUlnB8KnKYU8jLQrMyhHcI3GnSmK1lfyAKyur
         Gxf+Yh3Zvwk8fpFmwWWwpsRYZDo8VgT7/x9a/9w3bLMnLlcgdH4AUknj5crqnaOmCn/R
         KrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=Afz/1c3WdPwpmuIKdc6JUU6xtgDirtltHKx4KOcdvTB6/0J3R4XsC9dUJlHQXzzoK7
         bveKUiKsZajp/INGVTI2ERrBYxvOiaATPKBFD0aWx/Xg0dZYWfsk/6B7FKNw495vn1Z4
         u5jfNCBQ03zoTSCfc1DeZuHZIEpEyBMjeZS2SdgRH+7N63cRgZ90k/d20Q65KlL8H/qJ
         Xk52tyn96x9FwIff6KUExtHiWxx6rRyCs3Ziu/y5APUXrrJ2JrUlz1ixvHQ5WJ6KDuru
         EF6pG8CegXlyVZ2ZLV0SFzcN3LoJIy7GqSQty9w7Y4TpnnrgcE57rv5MQD/wWWdlf63i
         wnMw==
X-Gm-Message-State: AOAM530Ts9h5QzWlDOOaaA5n8SWnMv9KwJi8yY0JyFdLfOfNFt1hp38K
        koD3ghZP/Mn8d+Rp2R9w3wvY8pZXHS7l3w==
X-Google-Smtp-Source: ABdhPJwmFB+UuC9r4IsHO2t8oPyUzj7SRTIVM9vbEjm4FX0nARw1s6EVNBgJTBrvrL3MgfZCM0RPcg==
X-Received: by 2002:a05:6512:169a:b0:44a:fea7:50a5 with SMTP id bu26-20020a056512169a00b0044afea750a5mr882075lfb.498.1652382829415;
        Thu, 12 May 2022 12:13:49 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:49 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/5] proximity: vl53l0x: Prefer pre-initialized interrupt flags
Date:   Thu, 12 May 2022 22:13:30 +0300
Message-Id: <20220512191334.61804-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512191334.61804-1-markuss.broks@gmail.com>
References: <20220512191334.61804-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards interrupt type might be different than falling edge,
like hardcoded in driver. Leave interrupt flags as they were pre-configured
from the device-tree. If they're not provided, default to falling edge
interrupts.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 661a79ea200d..12a3e2eff464 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -16,6 +16,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
@@ -57,11 +58,15 @@ static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
 static int vl53l0x_configure_irq(struct i2c_client *client,
 				 struct iio_dev *indio_dev)
 {
+	int irq_flags = irq_get_trigger_type(client->irq);
 	struct vl53l0x_data *data = iio_priv(indio_dev);
 	int ret;
 
+	if (!irq_flags)
+		irq_flags = IRQF_TRIGGER_FALLING;
+
 	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
-			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
+			irq_flags, indio_dev->name, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
 		return ret;
-- 
2.36.1

