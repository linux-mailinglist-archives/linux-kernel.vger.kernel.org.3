Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0996757E1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiGVNEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiGVNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE0AF957;
        Fri, 22 Jul 2022 06:04:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p11so2683531lfu.5;
        Fri, 22 Jul 2022 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veEx5EC4oEDmljEEGVPcw1pQuw+XxKgBNvnHwBCodyk=;
        b=qdI1a0MUGooN6d+KUEfkNEo/m4cXU2Oz6fgknlIpummykQfj6JSx8sng1m0Iuy3VjD
         acwW8b+6RO3zLEtLXCOeP6QOt832OgIYNxSEIpyQGPVMuAh9wikPIGh4gvSJ4e3EFs5z
         xpx0m9tViKFeYFuRFlV67aGoEhKogokcpn5OERzwQT8ynV8oMSu5LvefsQs3ZLmjWSb4
         yNuyltRnY4WhF40GuWAVpkXI679DrKJFjdqx4KzjW9+3NdeCjOgOKHQ9NqPvdIgyDlf2
         HYpFQ2XXM9T75SOVt7M4LgqZuf5UGQueHOBbeAanYIa03om/yIdE4SCnFlQz2GjLI+nk
         W0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veEx5EC4oEDmljEEGVPcw1pQuw+XxKgBNvnHwBCodyk=;
        b=1lYqyWlLzOJnUzzNwJU7qQhYp2TGz3y3F5tPdo7+8d9Bk3xLLvN6xbs0xc9vkWNMUu
         LKVm8JfknDvj038qmQtREpcb6nZgUgH4B18VdlrQN1cfewpToaJHsBqI+VCDOxcWMwK5
         8FconSj11IRQ7/gox95eBaBfT/2P8ePRnbDMib0rygd9ZLlPwOYICy4uZ2Hcll+tJ/Nk
         BZodhdyi7AFYEet4NNDFhMvQIaSSWkn6s83gZ6EZlbuS+4BLcA3Za/lS6ArgMKHYzPhA
         8aDTOZhjar3C5ratbWKa8SJ9UiMjPN60uEr2sydd4b/bTIF+k74ELcf+M5yW9NzflFI6
         FrvQ==
X-Gm-Message-State: AJIora8lL5VHEPKJmNBdE1dDT7zZaR433Z3HbGYcRXmN+jQ/Jexvb8Cp
        OqMJFDT/bfugFNgN5u8gVhvYUPJZovbo8A==
X-Google-Smtp-Source: AGRyM1uch/IbjVpyG6HaJnj5UaMVtRawNaoBvTFrlBjxuTFDO/lWGxznqiSqZ79bdUbjZ/n7llj0yQ==
X-Received: by 2002:a05:6512:b09:b0:481:5b19:3ae4 with SMTP id w9-20020a0565120b0900b004815b193ae4mr177286lfu.293.1658495041706;
        Fri, 22 Jul 2022 06:04:01 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:00 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Fri, 22 Jul 2022 15:07:19 +0200
Message-Id: <20220722130726.7627-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Go for the right property name that is documented in the bindings.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f581cefb6719..f8875076ae80 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -210,7 +210,14 @@ static int mcp3911_config(struct mcp3911 *adc)
 	u32 configreg;
 	int ret;
 
-	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
+	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
+
+	/*
+	 * Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation
+	 */
+	if (ret)
+		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
-- 
2.36.1

