Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C194FD75A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiDLJvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353613AbiDLJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:43:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756360A83
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:53:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2189965pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCefrZdfoSNAmADQ4rDEGDGpMamNwlihzSsXzq1s8T8=;
        b=p53JNlmEO3AdY9Dcfd9psNc/BECz9tDHElvzGGZfzA4B1FRN0VKefh0WsP2jNk6nyC
         Bcgeekw4Pes1N003jaQiy2vWoXFlY/m0t2O7oZSx0JvKN2n21eZBGiFcnW/NIV1+5JbC
         dYL3nRA/1fGrfn2sH1XT7bv97Zu+nK6XrzaIFzOV6yboyRmscCMxs70mldh7roTkDEUD
         VekK/Jlw58pHUtrjJQ5wzU9IWIl3via84gTlJ1bv+NaqxzXhSld+rLf+j6X2Bt7lh0Z4
         ODjdzXg2b/y/YV5sRe524vcJfu9AxSFOhBF2aWs04ZN26gIxR9Q7Jc51AVTPdP46RgU6
         AAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCefrZdfoSNAmADQ4rDEGDGpMamNwlihzSsXzq1s8T8=;
        b=Hz92TnfLfjkcbjukJ8izSv/VMtwKb8jkCGFTt602i0NWCPfB0Jl0W1XXhjXXLBYjat
         2Mxe3OpaynLqIwiWUyZBMS7v4ASEesxzx/VZNPSlk52FmLRcUdc1cYD7uN2YKV/F1Kyl
         GQ/YqQzAxa0jIpQcA1eFpZ4qONwoHQGfyCVM4UBV9hDKYGti+j9g1YUz7/HLw3VmCXuf
         zJy/MAhdMnLqwVBANgWc/8bMy/t+RZA1tvjFkKCnN356YzdexgzeKOk352upgLy7oZxE
         7K/CNfwkd9qgdI+RwcExhSzNxLEkbYcZRMRtb5mAmLgaIcAV3a7he9H4zoiTPigRyhZ5
         pxIA==
X-Gm-Message-State: AOAM531oi5Pdoox8lTjG7ZgAV1VbPXJhkPOqM9/BwCebK1cy23xRkT5V
        DJPJJFitDF9Uqm5nq0D7IdDzr0J00EA=
X-Google-Smtp-Source: ABdhPJzbmsBk4kOMnyThdwbADw3SdgTf4CORQF62zG2osZ117ScN+2nEjEN00BR+93+8bZWnYXb5vQ==
X-Received: by 2002:a17:90a:e7c6:b0:1c7:443:3fdf with SMTP id kb6-20020a17090ae7c600b001c704433fdfmr3834381pjb.3.1649753590047;
        Tue, 12 Apr 2022 01:53:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm39899515pfl.135.2022.04.12.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:53:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     lee.jones@linaro.org, gremlin@gremlin.it
Cc:     gregkh@linuxfoundation.org, mad_soft@inbox.ru,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mfd: fix error check return value of platform_get_irq()
Date:   Tue, 12 Apr 2022 08:53:05 +0000
Message-Id: <20220412085305.2533030-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

platform_get_irq() return negative value on failure, so null check of
irq is incorrect. Fix it by comparing whether it is less than zero.

Fixes: dcc21cc09e3c ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/mfd/ipaq-micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index e92eeeb67a98..4cd5ecc72211 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -403,7 +403,7 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq < 0)
 		return -EINVAL;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
-- 
2.25.1

