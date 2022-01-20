Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26A5494932
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359097AbiATIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358941AbiATIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:15:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA96C061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:15:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h26so3830535lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sib8izoQ9eM4SRQulajhHuimJ4bCOoY1cAsE3mXLijw=;
        b=cVi5tRo5LKxaE/draeqa23ThRc1zLD/EOl6OpV9w8ozAxf67/DF0nGKqjFnZsnDexb
         1LKikEEweQcsCflg0Grc8QWMmuvvVaoGQr02rFJu5XMWTHoYHxs3Xe2PNUHAHfth+B/r
         H+wgpoa9pNEgY6H2mMx9hXCPsoKRM/2yeHkr/uytMw7X9E4uYF+frspvRvyqLw4eI1fa
         RZq5iXy4MoXo4qPBtZBFcH59C1Cjzt8rKWUcFY5Y/VtKOwagmuF64s5I/2hRP9adRcvs
         qdMLTme3U1xpZoc2HYF1xwb5enuPGO8wVFoVvR+d9JDDya6spVTVKDQO3dj+BV/5To6P
         Zt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sib8izoQ9eM4SRQulajhHuimJ4bCOoY1cAsE3mXLijw=;
        b=hnCT5KkPJtAyl+mxXwkSKzA/jMcNtIV9q6yyskYZTaTAnWNuV6Ovm8y0k07iZcspw7
         UPz8Cwm1UPCFKRECL7ldWzkeT9RByXSg3BOuSgVKlBePlcmi+iMVHINbFGsvxKlc20oM
         v/FjAUwezKQ++XglC56xgfanfhlRb64yZI3zaVyoUoPlaYD4sadI/JR5sl1ccbcsXX6G
         ffpoCNRMMUKKuIuWLV1dr543YbyWZaNaq3oRZ1o9TBHQrG1G8cbTko0avEFAdQt3nZ7u
         ms4Hz6vLqgY9vgnN4OwFDFPRy/fmsQZchCT34UJMUG48IVfkPAWASPh+Uo1WbBPBdXVt
         mMsg==
X-Gm-Message-State: AOAM532MeTVqWmREYJOoG+lw/n1LIJbN40GwheIxrHISRiCI1tfyoGGU
        +Kk1FEo4e79YDnhA2bjT/XTcYQ==
X-Google-Smtp-Source: ABdhPJz8BthKaQA4pVNnRkvyJXRmB13KbgzAbkPDhbFQYvav/zKSvQu+oPPe37XrqBuQIIp2d8N8oQ==
X-Received: by 2002:a2e:a7ca:: with SMTP id x10mr13034714ljp.259.1642666539292;
        Thu, 20 Jan 2022 00:15:39 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id k3sm208951lji.96.2022.01.20.00.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 00:15:38 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] media: vsp1: mask interrupts before enabling
Date:   Thu, 20 Jan 2022 11:15:30 +0300
Message-Id: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VSP hardware could be used (e.g. by the bootloader) before driver load,
and some interrupts could be left in enabled and pending state. In this
case, setting up VSP interrupt handler without masking interrupts before
causes interrupt handler to be immediately called (and crash due to null
vsp->info dereference).

Fix that by explicitly masking all interrupts before setting the interrupt
handler. To do so, have to set the interrupt handler later, after hw
revision is already detected and number of interrupts to mask gets
known.

Based on patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com> included
in the Renesas BSP kernel.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
v1: https://lore.kernel.org/all/20210926155356.23861-1-nikita.yoush@cogentembedded.com/
Changes since v1:
- move interrupt masking to a dedicated routine
- update comments and patch description

> I think I would rather see the code to reset them done in
> vsp1_reset_wpf(), rather than in probe directly as that is what we are
> doing, and is I believe already in the call path.

First, vsp1_reset_wpf() does not get called on driver early init.

It is normally called from within vsp1_device_get() when device is powered
on, but vsp1_probe() calls vsp1_device_get() when vsp1->info is not yet set,
and in this case call from vsp1_pm_runtime_resume() to vsp1_device_init() 
is skipped.

I've tried to add extra vsp1_device_put() / vsp1_device_get() calls to the
probe path, and dumped related registers in vsp1_pm_runtime_resume() after
return from vsp1_device_init(), and got

[    2.477315][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_ENB(0) = 0x00000100
[    2.483933][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_STA(0) = 0x00000121
[    2.490556][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(0) = 0x00010002
[    2.497088][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(0) = 0x00010003
[    2.503618][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(1) = 0x00000000
[    2.510148][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(1) = 0x00000000

which shows that
(1) WPF interrupt is not cleared by WPF reset,
(2) also DISP interrupt is enabled and pending, and driver does not seem
to control it at all.

Given that, I think it is safer to explicitly mask all interrupts before
setting the handler. I've moved interrupt masking to a separate routine.

> (But I'm reallly ... reallly concerned that the hardware is not really
> getting reset when it should, and that might merit some further
> investigation).

The documentation for WFP reset bit has notes that under some situations,
reset is postponed for a long time, and reported via interrupt. I'm not
sure what exactly goes on there, but I'd assume that such logic implies
that interrupt subsystem is not reset.

I agree that not having exact understand of hardware state is not good.
But, given that no signs of misfunction have been detected for a long time
(the patch was in vendor BSP for years), I think we can assume it is
"safe enough".

 drivers/media/platform/vsp1/vsp1_drv.c | 34 ++++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index c9044785b903..92a95e2c21c7 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -550,6 +550,16 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
 	return 0;
 }
 
+static void vsp1_mask_all_interrupts(struct vsp1_device *vsp1)
+{
+	int i;
+
+	for (i = 0; i < vsp1->info->lif_count; ++i)
+		vsp1_write(vsp1, VI6_DISP_IRQ_ENB(i), 0);
+	for (i = 0; i < vsp1->info->wpf_count; ++i)
+		vsp1_write(vsp1, VI6_WPF_IRQ_ENB(i), 0);
+}
+
 /*
  * vsp1_device_get - Acquire the VSP1 device
  *
@@ -819,13 +829,6 @@ static int vsp1_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
-			      IRQF_SHARED, dev_name(&pdev->dev), vsp1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
-		return ret;
-	}
-
 	/* FCP (optional). */
 	fcp_node = of_parse_phandle(pdev->dev.of_node, "renesas,fcp", 0);
 	if (fcp_node) {
@@ -855,7 +858,6 @@ static int vsp1_probe(struct platform_device *pdev)
 		goto done;
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
-	vsp1_device_put(vsp1);
 
 	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
 		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) ==
@@ -868,12 +870,28 @@ static int vsp1_probe(struct platform_device *pdev)
 	if (!vsp1->info) {
 		dev_err(&pdev->dev, "unsupported IP version 0x%08x\n",
 			vsp1->version);
+		vsp1_device_put(vsp1);
 		ret = -ENXIO;
 		goto done;
 	}
 
 	dev_dbg(&pdev->dev, "IP version 0x%08x\n", vsp1->version);
 
+	/*
+	 * Previous use of the hardware (e.g. by the bootloader) could leave
+	 * some interrupts enabled and pending.
+	 */
+	vsp1_mask_all_interrupts(vsp1);
+
+	vsp1_device_put(vsp1);
+
+	ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto done;
+	}
+
 	/* Instantiate entities. */
 	ret = vsp1_create_entities(vsp1);
 	if (ret < 0) {
-- 
2.30.2

