Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066355848F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiFWRoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiFWRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBB848B5;
        Thu, 23 Jun 2022 10:07:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn8so6719077ljb.2;
        Thu, 23 Jun 2022 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prMZe0pej9PoxwbNkQMGNemqFNqwjkROTTXt4DxreRU=;
        b=K5O5IQezMguE8NJFjGVU9xeaJvkVQaswm76vVr7PLmDajGglB50+z7e1wwApf1GiHN
         fXuOBDtSm2RL9FdWgDDGLQ6JbI2iON+xAzYgNM/t2JvndfAoUxRIivl41R674AEhxwGL
         oXZ4lSuYJF//2xqbdyraVak9KK9NBkYJCJDxZFtRuovXINRKS5eYhn/yhd8uocQRNGSf
         dKIM7/aVfDZ9kpmsHDlUQupDtiPLtvLot5GBClvhUz+egfLvsJgvZK6QTfHhcOnfCz7O
         w2MIv+RGMwmTY4GMrHUciw4yZuqTUUfPFEDcNm9geZbElIIOGGE2TZlIT7UvhlhY0VB0
         dHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prMZe0pej9PoxwbNkQMGNemqFNqwjkROTTXt4DxreRU=;
        b=qs58SoHuGRVjSg8Y49hCJ/utWNFObHf0IY7k2fCE6oNLb/ftIj0SdDr+782bInKNo0
         1pkJ4nbYZ9PgAb1k6/GINh8Y7GwykGS+aYrXOuIDsw/k/acAVdvbBedS7Plzno36gRLm
         nzIb3NnDbpj0z9XC6XpZicAfSB8AsNyRDYwj80JFRBe01YO4N5llkBsntKqd1cRHzFq1
         YPxeBKP5eEvsadM4kRZVGChGLIpZp/09Sq+GZ+i8+skuUL13JcALW2qOoC4tjInV84LZ
         eDNO3udA74sUvxCw1s8w6ymgRpuRXstKks2GSVrpyoFy/4w/5l3S/StC8unz45AJbLwl
         EH/A==
X-Gm-Message-State: AJIora8UDz1yChUDIhaZ4RJ1eEi6Z/rX9PSKSlmXCyIYQvW1M/yHX8kY
        pnMyS6haAtK6JowRvlEv2Wo=
X-Google-Smtp-Source: AGRyM1v2WkGrqBVIfjrP/9HqHkETaVQ9w8qZ0MMdQDVuC8NHd/2ka1BBq8Qc7NlkJlkV9BZY4cE0OQ==
X-Received: by 2002:a05:651c:1310:b0:255:81f3:e627 with SMTP id u16-20020a05651c131000b0025581f3e627mr5323395lja.397.1656004023694;
        Thu, 23 Jun 2022 10:07:03 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:02 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Thu, 23 Jun 2022 19:08:35 +0200
Message-Id: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1cb4590fe412..4338552cd0ca 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -208,7 +208,7 @@ static int mcp3911_config(struct mcp3911 *adc)
 	u32 configreg;
 	int ret;
 
-	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
+	device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
-- 
2.36.1

