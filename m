Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079F653186E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiEWSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbiEWSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCFE583A3;
        Mon, 23 May 2022 10:56:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v9so8851076lja.12;
        Mon, 23 May 2022 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=ID1ZtevMyDy5Qbuki5QKrfxdd/wuL0XRHhsoSqPjnc87EuQ5o1lyEh+3xbxqq5Pk67
         BurmVIrgtSBm+BjR7HYJv9AbSEncu8y0u49Z88Az0CpO6ypYQtN0+p+n2BQsn65jRjAE
         L5ukMgXs0Erg4gdHkYh8nTxnK4bLfU+nZ3x4erpy26qMiu9XDNu9RiRELSfvGZWzdgWr
         gs01zwXqGoXcO/tbIOvb9vXklmG9KRsgTPfWttbq8L3/oSqAxpb3pwGY5Kmaifrf17JU
         lnIJHbD2HNvb15wcfWNi17gjQl7JRLXy7zvdh/Tzk+qVgUWi2H0v3PG2w6Gmu4PPmFs3
         UN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=U8omCxwgqg9gbeSSr+UkWhA17vVPtbr6kzTpYvyVQU525TePW2nhPh3qtBXl1+hkZZ
         vkwepMD521rdkOZSdtwuuwadfHQzuPDtL3ta5kpUiCRODe0e7RxwFzE5qhEFv2tfwpEG
         gDizwmbztoyo3AlZrZpOxeb3eMzGEUS8fuDvLg5Xrs3V+mvdebVq3JUv6zPYVJFhOxhB
         rNmCEK6GKWkopSAITvprZes8zkPGL9DI7gfCy8PDZh8ffBBRm9IkMD4AmQuzvvrN7mB1
         EmiSKVJX8yZwIMZaJwF6VlZbBwMOo20c+aun6yP1dtLDWWnoH5ruHW58cfNICgE7fkc2
         oZnw==
X-Gm-Message-State: AOAM530KZB+AhszWKevlNQ24lv9wdvNJNTuhKsPVgd7O51uyl5W2Qqqa
        VQDZt/sQy1tyPuQkFgCIg7T/kqRhGoluIA==
X-Google-Smtp-Source: ABdhPJwFqL9k5b+SNLd4yXlVsMG8sMmdmedDo/XTo+YpZX0Ldnk6GS/FKixeOeQfojzsDOrCnBYrIg==
X-Received: by 2002:a05:651c:509:b0:253:e965:65c6 with SMTP id o9-20020a05651c050900b00253e96565c6mr4384049ljp.264.1653328473707;
        Mon, 23 May 2022 10:54:33 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:33 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, jic23@kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] proximity: vl53l0x: Prefer pre-initialized interrupt flags
Date:   Mon, 23 May 2022 20:53:41 +0300
Message-Id: <20220523175344.5845-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523175344.5845-1-markuss.broks@gmail.com>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
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

