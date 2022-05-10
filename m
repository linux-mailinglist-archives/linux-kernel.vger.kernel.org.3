Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC65225AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiEJUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiEJUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB52992C4;
        Tue, 10 May 2022 13:43:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m23so145051ljc.0;
        Tue, 10 May 2022 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXCPt/BCWQaVDD9rbV4hb7V0FE0WUZ7GvSMXBVR120c=;
        b=pxzgFvp6acwOvgNddOLFZRG1lxSrrLCe99/hYdEaFl1c8+6qLdaza+X0MIAlK3BIwf
         gfIYx3vDyqctNQwMr7/tmZ8U/Mb2G0YcXVD0PWvSszaM5YZ5HgtvaHGm4Nhhn6SmOS8v
         h70U7st6uusAPkAbkwpan5yOiJcvy9+f1iz2hV1PPJiK6i6k8wEzXgkELqK19WFI0SnO
         Yc3S5YrK8OKqJqWAsOGbIF+JgR611y54OR96Qzxnhtml/nFgQSG/aPwNCpVmGCejkLCu
         k7p7i+tUboOkmWWqR3xyw53AdQLBW4AEdOTFXBF5PN813ChnUfmQ1GtjnjM/uJCMKa8y
         4JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXCPt/BCWQaVDD9rbV4hb7V0FE0WUZ7GvSMXBVR120c=;
        b=ibPROZt/TUQ/CvEj5KLXGZNFzIHuzRa/6ij+20ARUCzkKhNO1xd7uzzpyA184AxD6Q
         FxnZ+6XNA7HinFCOLVVUvoWsDsIjunVd06PhEdD++FMXU9DOLTyy5cIM0NkdxmiCyYk2
         UIWa+kS4Clbo/gqs/jIkMNSFUJM16Z3CXm0pArNvdyTvIQikpichhzDBlmE+yOs8YLtg
         uoo2uTUB7ZknJEFft2xzRImQL9tBjBUYg+e3C1f1fBb47GvWf4YDtyPUf9+g6li58rW1
         pa8EY7gIhwLpRV7/Cy52/ae3mW2YlalgSY9Ki7ZYJyAtCKVxxqcwPeTzRDUHtt0ghgK/
         fROw==
X-Gm-Message-State: AOAM533QT7Q2b5IpCHjzCNFRGtfUUsXAXqEDzPNIsrBUGGC2TMmojBUP
        KvGN2zlTa+A5w1gQGtoloerBhvM/M6M=
X-Google-Smtp-Source: ABdhPJx9V6wKlWDNYvW6dRNPYyeqSRxTsXBfCqNQ5UddIxk/sEEaqrHlndS1k/gqRBnjTrBhL2Bo6w==
X-Received: by 2002:a2e:9943:0:b0:24f:fe4:4326 with SMTP id r3-20020a2e9943000000b0024f0fe44326mr15043420ljj.18.1652215410026;
        Tue, 10 May 2022 13:43:30 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:29 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
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
Subject: [PATCH 2/5] proximity: vl53l0x: Get interrupt type from DT
Date:   Tue, 10 May 2022 23:42:53 +0300
Message-Id: <20220510204256.8874-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510204256.8874-1-markuss.broks@gmail.com>
References: <20220510204256.8874-1-markuss.broks@gmail.com>
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

On some boards interrupt type might be different than TRIGGER_FALLING,
like hardcoded in driver. Leave interrupt flags as they were pre-configured
from the device-tree.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 661a79ea200d..16f809c479cb 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -61,7 +61,7 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	int ret;
 
 	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
-			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
+			0, indio_dev->name, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
 		return ret;
-- 
2.35.1

