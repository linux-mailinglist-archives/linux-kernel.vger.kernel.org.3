Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1E55A8DB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiFYKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiFYKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AA2A255;
        Sat, 25 Jun 2022 03:37:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r9so193514ljp.9;
        Sat, 25 Jun 2022 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p74EiAOrPkTvHsU80Gm6F1ejn2Q2dF5pBSqgM8W6O8g=;
        b=Kvo0fglBTj0/ELNAGvVtCWnzgWVkDUGRwavsjI+Z1C2J8G1iiPUBQrUDtjDFfnS6DI
         WXhW3+jl5RGEzCsWPistAArfqXHjaBztUMA75lJoTJS2DThF7aoJltWZGG2swjlG9zUU
         b6Jx7BjRgfH9BetMqutckV+TLzqQ5qgp30iCctoGnnoYJ3PInwXmG89faMBRCFDkKTqb
         d+vvXNVUpHMnWPjhae43agN6WjUjMaRt6aRT7Xk5FuK3aH/cNeLJYRPKaSNS6y6GR6Og
         rlCN26rO4hHoJRMnfM52TCKADZv2xVPWzut6jOwkUKGVv3gebpTrxE9ReABorpyXtzSP
         RQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p74EiAOrPkTvHsU80Gm6F1ejn2Q2dF5pBSqgM8W6O8g=;
        b=YJdXVv4swG4Rbm3Ty4D8lLTfKhnir2ksbtlSb1mchWlmaLTlI/SOWNkn3ySf5Wt+pa
         XLvwiXPFOtGqWbZS6vZNsq4n1vaX8LQUE0CkJ3nayzT8eCQPpgPcberEZzN702pjr3xE
         rMfJGNjZntRaJ4J+eEsvQjOQXE8YF7V2W1jzDRbEEh1ym43/fC1wQlYoAWKFvnZCczcC
         JJiCM/1rNjEhlpcr76kcwt2L20j+8FdD8TuAxArqFI+1uXqKHTvEgH8rFqo/BMRU6kMQ
         EjVd0ioGFQnNtOMWC8qZH+DBEUaCAlTOyCihlWuauAFNTlAKN91uubbKzHhk5RgYmugD
         xDzQ==
X-Gm-Message-State: AJIora9y5bedwOZaS4ul+ym1El57bDpXP1iYfb1hl2BydLoQpbJW2FoR
        NbSCH14m4yod6WWEqEczluYiv9gvACZC5QTU
X-Google-Smtp-Source: AGRyM1uXChu1I/cl858gf+d6K/L0j/uYWpeDmUCmU93MP0j1pfBCh4E4Y9vvCAk368dg1dxykRCRQg==
X-Received: by 2002:a05:651c:1202:b0:25a:6096:bd7e with SMTP id i2-20020a05651c120200b0025a6096bd7emr1617796lja.304.1656153437330;
        Sat, 25 Jun 2022 03:37:17 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:16 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] iio: adc: mcp3911: correct "microchip,device-addr" property
Date:   Sat, 25 Jun 2022 12:38:44 +0200
Message-Id: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
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

Notes:
    v2:
        - Fallback to "device-addr" due to compatibility (Andy Shevchenko)

 drivers/iio/adc/mcp3911.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1cb4590fe412..c5a0f19d7834 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -208,7 +208,13 @@ static int mcp3911_config(struct mcp3911 *adc)
 	u32 configreg;
 	int ret;
 
-	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
+	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
+
+	/* Fallback to "device-addr" due to historical mismatch between
+	 * dt-bindings and implementation
+	 */
+	if (ret)
+		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
 		dev_err(&adc->spi->dev,
 			"invalid device address (%i). Must be in range 0-3.\n",
-- 
2.36.1

