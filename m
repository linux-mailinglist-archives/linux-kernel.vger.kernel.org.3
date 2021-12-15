Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8368476662
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhLOXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:16:29 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46832 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLOXQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:16:27 -0500
Received: by mail-ot1-f46.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so26723473oto.13;
        Wed, 15 Dec 2021 15:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NJojSfoVwMgJb/Ja90KiUetfn1vdOAgMVEPVsedxn4=;
        b=q97GoWmyAzRaPDgA42DeTcGXaAbrgaabtUfcupEFIQl8do7mvhJeuxGC1Tqii9GT1S
         RFCX5LLjhjV1hkT5PcBiwvQqnWjaQ6GD1hjwY8jRkAntpUxcdIniCmqUR7ZRCyJX05pt
         CTo8kvXmqDRKq11R+/v26483Zj1GcuNbkG7MWCIZHOwxhygOULtxkvdh70aCjq6W3lZE
         HFT4hhQuNE68qLbkFpMmVr0UaH3OfQ/ZHHLSyK6j1rk4/PoNnyw0ZSQqvygsR2sQtxAe
         l/QATmuwEI49hRfmGWqZQFJzS5V605lERUsywrCG95JAu+54Q0arDNpKRSSP+wBsP+8L
         pTlQ==
X-Gm-Message-State: AOAM533GMAneZtImqgVWpuND4V6/563k7qi2AM+j7XmT6HSwCzciUvv2
        xRe/Pm36pbdZfZ/I+UwMtw==
X-Google-Smtp-Source: ABdhPJxe1D9MH0CKZ4DycjsHFTIJBOoLIjt6AIVTztF3s4fwJK0Y3vM/K0Wz5DMCsalknmREVSwMng==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr10302445otu.354.1639610186803;
        Wed, 15 Dec 2021 15:16:26 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g7sm740166oon.27.2021.12.15.15.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:16:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 2/2] usb: musb: Set the DT node on the child device
Date:   Wed, 15 Dec 2021 17:07:57 -0600
Message-Id: <20211215230756.2009115-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215230756.2009115-1-robh@kernel.org>
References: <20211215230756.2009115-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The musb glue drivers just copy the glue resources to the musb child device.
Instead, set the musb child device's DT node pointer to the parent device's
node so that platform_get_irq_byname() can find the resources in the DT.
This removes the need for statically populating the IRQ resources from the
DT which has been deprecated for some time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/musb/am35x.c    | 2 ++
 drivers/usb/musb/da8xx.c    | 2 ++
 drivers/usb/musb/jz4740.c   | 1 +
 drivers/usb/musb/mediatek.c | 2 ++
 drivers/usb/musb/omap2430.c | 1 +
 drivers/usb/musb/ux500.c    | 1 +
 6 files changed, 9 insertions(+)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 660641ab1545..bf2c0fa6cb32 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -500,6 +500,8 @@ static int am35x_probe(struct platform_device *pdev)
 	pinfo.num_res = pdev->num_resources;
 	pinfo.data = pdata;
 	pinfo.size_data = sizeof(*pdata);
+	pinfo.fwnode = of_fwnode_handle(pdev->dev.of_node);
+	pinfo.of_node_reused = true;
 
 	glue->musb = musb = platform_device_register_full(&pinfo);
 	if (IS_ERR(musb)) {
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index e4e0195131da..fd4ae2dd24e5 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -563,6 +563,8 @@ static int da8xx_probe(struct platform_device *pdev)
 	pinfo.num_res = pdev->num_resources;
 	pinfo.data = pdata;
 	pinfo.size_data = sizeof(*pdata);
+	pinfo.fwnode = of_fwnode_handle(np);
+	pinfo.of_node_reused = true;
 
 	glue->musb = platform_device_register_full(&pinfo);
 	ret = PTR_ERR_OR_ZERO(glue->musb);
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5b7d576bf6ee..417c30bff9ca 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -231,6 +231,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
+	device_set_of_node_from_dev(&musb->dev, dev);
 
 	glue->pdev			= musb;
 	glue->clk			= clk;
diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index f5d97eb84cb5..1aeb34dbe24f 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -538,6 +538,8 @@ static int mtk_musb_probe(struct platform_device *pdev)
 	pinfo.num_res = pdev->num_resources;
 	pinfo.data = pdata;
 	pinfo.size_data = sizeof(*pdata);
+	pinfo.fwnode = of_fwnode_handle(np);
+	pinfo.of_node_reused = true;
 
 	glue->musb_pdev = platform_device_register_full(&pinfo);
 	if (IS_ERR(glue->musb_pdev)) {
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index d2b7e613eb34..7d4d0713f4f0 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -327,6 +327,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
 	musb->dev.coherent_dma_mask	= omap2430_dmamask;
+	device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 9bce19b5ffd7..8ea62c344328 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -262,6 +262,7 @@ static int ux500_probe(struct platform_device *pdev)
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &pdev->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= pdev->dev.coherent_dma_mask;
+	device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-- 
2.32.0

