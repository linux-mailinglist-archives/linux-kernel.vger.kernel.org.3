Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690A58D49C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiHIHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiHIHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4821EED4;
        Tue,  9 Aug 2022 00:32:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f20so15815737lfc.10;
        Tue, 09 Aug 2022 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KE7Doo8+PSeMnrmOEri8h44PeWIbSZ8XCkY/na8+SzA=;
        b=RKoQ4gneA2KRJSaw1sRwwm17vkbyM2oLjdPe6pleykMyfMwjEjR6EoW/h13hUAtEay
         WZQZDDsAMjsqzm5+2MaLeWjpGYbl4hBzWtaO0cUGHkwxFH7ZBdAcbwQf7AwIuKhOx2RD
         i0H5qDDqx0yrSo4Q4pSXCjExDBDhYsvnQ/5ikOTSAtnnKHuSypGcF6psAmJFHrGJgeUN
         ZKvmX066e8XT3Mmg78XRoC5NzQZhWu2XcWIhA8evoLEsW0jkEWEREEW0SShfJAFDv6ai
         V+uIx7938FP4NzxKISUE1vDnO8mmZxf66mU3C5HMX+yTS39a6VIybrDu14PuUfBhhG8E
         LOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KE7Doo8+PSeMnrmOEri8h44PeWIbSZ8XCkY/na8+SzA=;
        b=BTVlA8in/EqWdjhjx6RIeFt4aejyO3OSvsARtdMIcKc1I7f16iyY+xNM7kPOynqkg2
         2wnn4yRY+xkoQEAudI0r2phftjTIMqnHvgxxLN+tFBU5I2X+4xLeEDsNuOtZmMhgnzKL
         0oLfdG0mqVOJoLO4oF5Jqd4woTnN6aLB4CQJpm5dy85VB+5bJ5EJUBVKcpq20c0dEH5H
         /Ma8vMVmCdECC2X1mwyJAmUtCZlHG/nm//FNuvHQluWf1xIQVfOK5VhRlILMwp+hDSWA
         I4ALU9VEp+MFjY0Jv40mPejWOqq3n9319g78aeW+tixQPxBYRQxU3c39SFu1F9qYUhFd
         +MXA==
X-Gm-Message-State: ACgBeo3qWhfmJlBCFt26gQLjt5E3t9QyDsKjkyU3MCXhaXnPrWqF53gz
        KQG/8GAlXwmyIX2c42rOoSRol+hO9SR/4w==
X-Google-Smtp-Source: AA6agR46o9npt9wZ0dLDI2CWbEDJcbyQu26SxvCraiUyCtbozsaYXGLpxLMXs5Yf3N6kCOJcso+M1Q==
X-Received: by 2002:a05:6512:e82:b0:48b:23f5:d153 with SMTP id bi2-20020a0565120e8200b0048b23f5d153mr8553992lfb.291.1660030348828;
        Tue, 09 Aug 2022 00:32:28 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:28 -0700 (PDT)
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
Subject: [PATCH v5 2/9] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Tue,  9 Aug 2022 09:36:41 +0200
Message-Id: <20220809073648.167821-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
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
2.37.1

