Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879ED47665F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhLOXQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:16:20 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46829 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLOXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:16:19 -0500
Received: by mail-ot1-f53.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so26723155oto.13;
        Wed, 15 Dec 2021 15:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tz9+B80iOJ/5SEIo/3X+KGjAczW/DyI87s+/a132hNo=;
        b=o+A1l1G4dSxnAB99kVqsqMiPRri8zlUa/YQZX3YEispKiDt2TVy5pAGYIOBXwd23Mu
         wz9uMFIzcelMkobtVryVYAtEtG4CG5dhAFLwstsFHZn2e3GzFsvN1onRGuC8nPmmq6Qk
         sKWNQOuBcpbw7mPhNQpsGX5S2HSUTi5kl6JGu9rrQXTvFCSyow3DTkYx/VO3PX6yu7bN
         NXfrYD1dJFxsSvbsimFeojT9GW+ePSb6ayUZf9NL54XfNSuxpUoHf5qsHRSITJ4dspLc
         luLeASPcA8IK2V00CUF5amgWzwHZdDwu5q5pMyTg8PfIsczdBd90tCkHppwtPDhTy6d6
         nusA==
X-Gm-Message-State: AOAM5335JaP/nIeSUghDTgs63ehJe0MLLigkxn4z9irWeM0F+oBUVQou
        WvtCJKdHIf03zt4e3m24Eg==
X-Google-Smtp-Source: ABdhPJyeuLnb0kevinHDK2T33pvZ/O/pvdFFuXTAR+7gZIcqsqM1MJh1TcdtGlPtGrSzj4DAop6kQQ==
X-Received: by 2002:a05:6830:449e:: with SMTP id r30mr10991173otv.120.1639610178939;
        Wed, 15 Dec 2021 15:16:18 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g7sm740166oon.27.2021.12.15.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:16:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 1/2] usb: musb: Drop unneeded resource copying
Date:   Wed, 15 Dec 2021 17:07:56 -0600
Message-Id: <20211215230756.2009115-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215230756.2009115-1-robh@kernel.org>
References: <20211215230756.2009115-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device resources are copied by the driver core, so there is
no need for the caller to do it when creating a platform device. Just pass
the parent resources to the child device directly.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/musb/da8xx.c    | 18 ++----------------
 drivers/usb/musb/omap2430.c | 22 +---------------------
 drivers/usb/musb/ux500.c    | 17 +----------------
 3 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 1c023c0091c4..e4e0195131da 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -505,7 +505,6 @@ static struct of_dev_auxdata da8xx_auxdata_lookup[] = {
 
 static int da8xx_probe(struct platform_device *pdev)
 {
-	struct resource musb_resources[2];
 	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
 	struct da8xx_glue		*glue;
 	struct platform_device_info	pinfo;
@@ -558,23 +557,10 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	memset(musb_resources, 0x00, sizeof(*musb_resources) *
-			ARRAY_SIZE(musb_resources));
-
-	musb_resources[0].name = pdev->resource[0].name;
-	musb_resources[0].start = pdev->resource[0].start;
-	musb_resources[0].end = pdev->resource[0].end;
-	musb_resources[0].flags = pdev->resource[0].flags;
-
-	musb_resources[1].name = pdev->resource[1].name;
-	musb_resources[1].start = pdev->resource[1].start;
-	musb_resources[1].end = pdev->resource[1].end;
-	musb_resources[1].flags = pdev->resource[1].flags;
-
 	pinfo = da8xx_dev_info;
 	pinfo.parent = &pdev->dev;
-	pinfo.res = musb_resources;
-	pinfo.num_res = ARRAY_SIZE(musb_resources);
+	pinfo.res = pdev->resource;
+	pinfo.num_res = pdev->num_resources;
 	pinfo.data = pdata;
 	pinfo.size_data = sizeof(*pdata);
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index f086960fe2b5..d2b7e613eb34 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -301,7 +301,6 @@ static u64 omap2430_dmamask = DMA_BIT_MASK(32);
 
 static int omap2430_probe(struct platform_device *pdev)
 {
-	struct resource			musb_resources[3];
 	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
 	struct omap_musb_board_data	*data;
 	struct platform_device		*musb;
@@ -383,26 +382,7 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	INIT_WORK(&glue->omap_musb_mailbox_work, omap_musb_mailbox_work);
 
-	memset(musb_resources, 0x00, sizeof(*musb_resources) *
-			ARRAY_SIZE(musb_resources));
-
-	musb_resources[0].name = pdev->resource[0].name;
-	musb_resources[0].start = pdev->resource[0].start;
-	musb_resources[0].end = pdev->resource[0].end;
-	musb_resources[0].flags = pdev->resource[0].flags;
-
-	musb_resources[1].name = pdev->resource[1].name;
-	musb_resources[1].start = pdev->resource[1].start;
-	musb_resources[1].end = pdev->resource[1].end;
-	musb_resources[1].flags = pdev->resource[1].flags;
-
-	musb_resources[2].name = pdev->resource[2].name;
-	musb_resources[2].start = pdev->resource[2].start;
-	musb_resources[2].end = pdev->resource[2].end;
-	musb_resources[2].flags = pdev->resource[2].flags;
-
-	ret = platform_device_add_resources(musb, musb_resources,
-			ARRAY_SIZE(musb_resources));
+	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
 		goto err2;
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 73538d1d0524..9bce19b5ffd7 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -216,7 +216,6 @@ ux500_of_probe(struct platform_device *pdev, struct device_node *np)
 
 static int ux500_probe(struct platform_device *pdev)
 {
-	struct resource musb_resources[2];
 	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
 	struct device_node		*np = pdev->dev.of_node;
 	struct platform_device		*musb;
@@ -273,21 +272,7 @@ static int ux500_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, glue);
 
-	memset(musb_resources, 0x00, sizeof(*musb_resources) *
-			ARRAY_SIZE(musb_resources));
-
-	musb_resources[0].name = pdev->resource[0].name;
-	musb_resources[0].start = pdev->resource[0].start;
-	musb_resources[0].end = pdev->resource[0].end;
-	musb_resources[0].flags = pdev->resource[0].flags;
-
-	musb_resources[1].name = pdev->resource[1].name;
-	musb_resources[1].start = pdev->resource[1].start;
-	musb_resources[1].end = pdev->resource[1].end;
-	musb_resources[1].flags = pdev->resource[1].flags;
-
-	ret = platform_device_add_resources(musb, musb_resources,
-			ARRAY_SIZE(musb_resources));
+	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
 		goto err2;
-- 
2.32.0

