Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3626524AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352969AbiELLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352949AbiELLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:08:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A125A149;
        Thu, 12 May 2022 04:08:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j4so8385883lfh.8;
        Thu, 12 May 2022 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=mPqiMrXeK4HnnnYLILMVdVz6G+KLueUOtuBBRc8khXWG+VWTgokg2wmRpxEonf7fXj
         RaAO5LkIr3zSkwWZm/1NRClO29iKUaBiuPX8VqQ/nKB1rdDo3UZyBT/KUVL8OJ6SqeAO
         ctR3fT9GnBPiISnLEjEklkrOMXPGX0NgfgGC/15I18HyE0Tz6cVeeeCNRZOu+h9sqzTu
         8Nhh6Fxt8WkugIdGBr8x9EtlC6jfjRLvA9ZDYED+jMHVDnRmG3onW98keh4xWx4VAsva
         YtlonFN5CfNNg0rnjzkZ4NWZ2wT/SBtaMLmBuGxABitF1imb1IzgTEfSV5iXh+y8/v5w
         FTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHLHpItlazo+UaJMdlnAGs/zpbzJsdOOF257QRYRuhY=;
        b=kWf3Dn+C6+sFXx6PmzPdclABJ01TEupCWmVzB+qc2SaGL0bf4iYvS9+VfLPfjbHRUS
         N5vrQ9Kl7YJwyxD72/xMhDSwX3oclw3ETcPH8P51q2ukAErWm4F9Myj76VaJN/DZJvxZ
         XTSYxgGLiOvb3z+x9LQSePfY5XYJ6WUyv60L3UeroCub9jnxrltO4bu+9/ytBJsywMbH
         zLLMJJ+oHW2kMSyueaYV97+3fCF5uFe1lVnpzWrNkg5f68L05pRQaiabNI+2qh1BEpPM
         r0x//pRNEy3BmG5nVG2TTIfnipyGgqJaZWJ+u8hQUyFoBcZIDNRmxHFD5QU+buRncPhF
         TGFQ==
X-Gm-Message-State: AOAM531gD9s7gj53GzfXNUqEhYHXLO4xrG8/IEHtnKbXmv5NthaoTIcy
        KwWGuVAg4P8vz052BPWRSOtZaWZu2BkOEw==
X-Google-Smtp-Source: ABdhPJxHj4PJYumxcThltMWUtADbZwvzyluCMLfWyn7BXJRkEDqHJ2KLchQwfXmhmSkcO4+2tSOK4A==
X-Received: by 2002:a05:6512:33a7:b0:473:ea35:e1d6 with SMTP id i7-20020a05651233a700b00473ea35e1d6mr24496586lfg.369.1652353692831;
        Thu, 12 May 2022 04:08:12 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b004725b99d2fdsm734883lfo.164.2022.05.12.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:08:12 -0700 (PDT)
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
Subject: [PATCH v3 2/5] proximity: vl53l0x: Prefer pre-initialized interrupt flags
Date:   Thu, 12 May 2022 14:07:54 +0300
Message-Id: <20220512110757.5297-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512110757.5297-1-markuss.broks@gmail.com>
References: <20220512110757.5297-1-markuss.broks@gmail.com>
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

