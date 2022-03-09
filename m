Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26A4D2975
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiCIH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiCIH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:29:43 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62422B00;
        Tue,  8 Mar 2022 23:28:42 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a14so1175096qtx.12;
        Tue, 08 Mar 2022 23:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZMQi1dTUUmaGTUhCGnhkFEO6/MDe8Ns2I3nt0C9fxY=;
        b=IcN8kfEhoFTfTkLExogeKr09YGIgSjN8GaI7E0SsYEgK/ytG2966CBacG35NrS1OEN
         6Xrw3AxLQzPBXY3g5ZgnWnyvi9hlFNGdmm7pIWjfq5KGQS3kOMqR43yfhj8WAtbRPLZq
         Ef+R19OlhhlbYXEgPcHpTaW3fjE3CZ97ia7Z7VvhHZCdM6VKbbA5MyKmqvvjE2+4x+oz
         LRH3WsnWZwuto6Xsb8UiMXaYfEkfHgyZ3F98y7XgPy5PUjzp7FYJvFt0dIyW+2aoS+mB
         3/xerNfNmZlpVjJej1mJoeKsFhFsIsl2VEqLNKzbEB3TGUD17vyZCVSEkq7KCnDpaRIS
         QLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZMQi1dTUUmaGTUhCGnhkFEO6/MDe8Ns2I3nt0C9fxY=;
        b=hjNw92nw7y0UnLzM9JcMvjuaX4k2XNYG8S3HTmN4Q6BL+7FhbCjlHFLDKpZ5DdDoST
         gbpMACx4/AeHj0+AO3ZL7oui5AMity4qbcPlu7sDbOc4SRgXy4iRRo0wyZs4dujgB3nE
         AQggEmVnFYtA/z4lk+60A8eiV68PABjE6rMlyRvqqwbKt2L5ZdN2JfRtxYreBwejon5E
         /ANy9ojciAJPPJu6zJ8A5iFzf2nEA9fycBNB1YAAeB5yFICe5d2OfaYFJ5BNaz+cBusi
         W/sNkQqJPHw/5ODAAO32vS5nO3czYJ/Zof6coehIrkcDBZ4zENNag+NxXSQ0sPA6gQ21
         PY8Q==
X-Gm-Message-State: AOAM531xwnozEMCUB9cBo9yQEAJf+CmP0yiifSHXaiTfQiTVilkBfy4S
        Zgt0zuSRY3BXCyHOxeap4Hc=
X-Google-Smtp-Source: ABdhPJx7zYn3y4TZfvvgr95+HBzkzDVg6QSLDEbbhwRqGTMpArbNHEmEi8hH+RIOhnglCdSk9XjrHA==
X-Received: by 2002:a05:622a:1b8b:b0:2dc:4f1:faf7 with SMTP id bp11-20020a05622a1b8b00b002dc04f1faf7mr16764636qtb.325.1646810921466;
        Tue, 08 Mar 2022 23:28:41 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a6-20020ae9e806000000b0067ba5a8a2a7sm581301qkg.134.2022.03.08.23.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 23:28:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        s.shtylyov@omp.ru, zealci@zte.com.cn
Subject: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 07:28:34 +0000
Message-Id: <20220309072834.2081944-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
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

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

v1->v2:
    - Use more specific in the subject: ata: pata_pxa:
    - Switch to returning 'irq'
v2->v3:
    - drop the unlikely()

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/ata/pata_pxa.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 41430f79663c..985f42c4fd70 100644
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
@@ -205,9 +205,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * IRQ pin
 	 */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(irq_res == NULL))
-		return -EINVAL;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	/*
 	 * Allocate the host
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

