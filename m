Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A634D0E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbiCHDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCHDAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:00:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2356FD0C;
        Mon,  7 Mar 2022 18:59:47 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kl20so3989254qvb.10;
        Mon, 07 Mar 2022 18:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scNswzEZv4MR4mtcF8eE5kR5X8n3XY2Kg0/OJ8AWaD4=;
        b=gzkIwK2tIdhodziZcR7DZaSsv/0AlG9pY0kCg86NC7VcmUv3kzyjDHTNQhYUY1Xpwg
         IHWZAoLGhb1uAbA4ob/E0kboymL6IFiGZhCnclTFKlWRX4XDaEzuy6FKjJvAp1Hc1xVD
         MSqe99/R9DpBLTlc5qE6H81fXoc9C688DhVgTZ+ykr5PW7r4d2UitMn+Rbb/C0jXRt+c
         7pEBLOx0MVJTkXmBcq0wfyJIczaD23aM13e4Do5lRBmRJadd6pJNORnqekS1AuvySXSg
         kdgSxlcd3CWXVX+/Ay9xjNQWfSadveJ0xr3rqAHK5nnA9hrktMr/7wmrDmJTyGXj3suz
         Kw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scNswzEZv4MR4mtcF8eE5kR5X8n3XY2Kg0/OJ8AWaD4=;
        b=j77lduyOsaEWwd+1jLfVbJ1N+MN0QEegRt1/CRBazemJGyZq1qR4No395Oqdii36om
         pBrCLjla3Tj1JMkQJn0nHZYSPP5ynYOlh52lN0DI4VWiSCcsH5rX7h7qF7jMFs9ZyzWO
         WCJ1pc8eOs8Coj/DZbEb90RIheCbwnCD5AovvNMoau3HiHeQCUKwT+GTDXdIoPAAv0ec
         OTma3qSvb2LZNePLDfMjOkd1imJUOdIs2eoqPpPHwq6AY8e10Ca3zqNzdCHAROE46tGF
         dUQ9E3B5A/AHDQlrOlqBmOTCdX38WFRwKsJ56lHJEL1caG+gDdFGloBWovGSSV5laGA1
         8Hag==
X-Gm-Message-State: AOAM5327ORDytR1yeaQZgFgHgAlHxY7hcvmH741ERvtA7TgHB1AQjFpa
        mE7E7lPYKJxKEHwIui7UT5M=
X-Google-Smtp-Source: ABdhPJzjoEvxFGjYTBMUa7xKJYsB8Zmme9r7v/iRyyFDdrusnRKfCWkh9grSZ811GL/EiWQSow9vHw==
X-Received: by 2002:a05:6214:21ef:b0:435:79f1:73a with SMTP id p15-20020a05621421ef00b0043579f1073amr7934663qvj.48.1646708386843;
        Mon, 07 Mar 2022 18:59:46 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b002dcec453e42sm8784730qtp.32.2022.03.07.18.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:59:46 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     s.shtylyov@omp.ru
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ata: Use platform_get_irq() to get the interrupt
Date:   Tue,  8 Mar 2022 02:59:40 +0000
Message-Id: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/ata/pata_pxa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 41430f79663c..6394ab4cbc1b 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *cmd_res;
 	struct resource *ctl_res;
 	struct resource *dma_res;
-	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct dma_slave_config	config;
 	int ret = 0;
+	int irq;
 
 	/*
 	 * Resource validation, three resources are needed:
@@ -205,8 +205,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * IRQ pin
 	 */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(irq_res == NULL))
+	irq = platform_get_irq(pdev, 0);
+	if (unlikely(irq < 0))
 		return -EINVAL;
 
 	/*
@@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * Activate the ATA host
 	 */
-	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
+	ret = ata_host_activate(host, irq, ata_sff_interrupt,
 				pdata->irq_flags, &pxa_ata_sht);
 	if (ret)
 		dma_release_channel(data->dma_chan);
-- 
2.25.1

