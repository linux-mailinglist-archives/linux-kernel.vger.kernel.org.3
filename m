Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C24D2881
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiCIFhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCIFhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:37:14 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442314CD96;
        Tue,  8 Mar 2022 21:36:17 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id eq14so1222332qvb.3;
        Tue, 08 Mar 2022 21:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9koa9rBnDtbH1Tya1nhKtAaJhzHYNwEZWYV+DyRtno=;
        b=LWTov7hCbjozRMNE1HpsMKMUdvHZu4acaQ7UBE8nTd+db2Qev4tQLOi7mb2ZUGJhsh
         9u8DwujP1FcvirolLolSvX9KW+/s/a5oCTieu6e/ssRKzLXh4OLQrdoDY8fBLLoDwlUb
         PjXbYlmjd6zxLP383enYPuFAlwox5FJYi18oWDuLfrOoRQ1eztTfQUjWvVzlamlAsVok
         LEG3TK3IUI9ri3ropVsY3lEMLofTh0XpPlMi4RulR9zKJseL/X6cNMPZIvU657krPODR
         2ES+MqOtf/q40CtZQfOGk+LH1zP+rCXgaFVVEp2uZa992O2pw+fQj1BBWCmdcNPGGBI8
         rExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9koa9rBnDtbH1Tya1nhKtAaJhzHYNwEZWYV+DyRtno=;
        b=UKrZ6HPtO5lDliZFQouNH0qfW5RwhjqNqSyKWkUzl7o9YIwX/hdX2UWzskDdCc5nPO
         uDHseVpTNCwliWZa1GvITccS/Kbrs6S7UBhgiBQUVJBb/kA4QiGqF5yw9fdL++90QEUr
         YbX503saK+VdIrADjJk38MKoXjOaF9PyFsgitYDmrYBCsMN+IEOSg2Z+cuG2Z972ag6W
         87BIfvO3YUkeaBrE8Kzn+5I6i3R3htK5jgkwRl5w7Hl4u6E8ZA8O5KL5cYMtEaRz3M0K
         sYMig5DL0wCWxuYt7r7gG+y/Z34aN6Q+IO8IcGuZ4LVsPKyeXZGw+HGWJPSNPcpWmXFg
         ThGQ==
X-Gm-Message-State: AOAM531BUREwcuzAyzbO9kDvI1aveYpfMEWE+2fFT5eZWQvcj2zvJtKW
        LRluEf7jLZXegR7j/qL+/O0=
X-Google-Smtp-Source: ABdhPJxTxtceaYzcL8fOAgpPqFO8bFye9qCbJyxiQGD2pH4h5mFlQbvsXYLR+z9J3ybWSS0p7x9JDg==
X-Received: by 2002:a05:6214:a8a:b0:430:8fbc:6be2 with SMTP id ev10-20020a0562140a8a00b004308fbc6be2mr15475069qvb.7.1646804176493;
        Tue, 08 Mar 2022 21:36:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m75-20020a37a34e000000b0067d14e5c418sm509190qke.129.2022.03.08.21.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 21:36:16 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb:oxu210hp-hcd: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 05:36:11 +0000
Message-Id: <20220309053611.2081191-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/host/oxu210hp-hcd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index e82ff2a49672..d45d3f3b0944 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -4223,13 +4223,9 @@ static int oxu_drv_probe(struct platform_device *pdev)
 	/*
 	 * Get the platform resources
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev,
-			"no IRQ! Check %s setup!\n", dev_name(&pdev->dev));
-		return -ENODEV;
-	}
-	irq = res->start;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 	dev_dbg(&pdev->dev, "IRQ resource %d\n", irq);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.25.1

