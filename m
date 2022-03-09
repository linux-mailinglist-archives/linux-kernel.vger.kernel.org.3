Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D44D2888
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiCIFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiCIFii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:38:38 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D11B716E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:37:38 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id hu12so1214771qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 21:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsAdyEXRI2fprv2zVOJpXzajm9rrZywAumRIFm2mze0=;
        b=oFYFga8k/HlIBFE206iPp4pwPH8a4cgdN/hl+9ziS++S1x+V9FMC5s7OXUnVw1u0cv
         fVJRhdaN/AD9DmTHsRjXzu/9LzIAIvOEkSW58NF/EB8mdQA8K2EGu7O0eSpznARXCbn6
         1T0AboaKn45uAHtVU+jliQtLKQrD8C4I/ggzDkKX5PEYa22wPS7DVIkD4lI3as8/DXV+
         QSlZZsKzgDNWgemgE8S5Ai2CjR8bkrjnHh6cgzrZc8IRCV7V7wDNXaxuPzWiuxRd4lmm
         F147oMl1bAVrp+HRTpHJQmSN/dT2nmQYXockeXKUedfvsZgYl/933HmLZ6YxMjqNI1Wb
         N94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsAdyEXRI2fprv2zVOJpXzajm9rrZywAumRIFm2mze0=;
        b=BMTVpyjBIWLvr++2NJ++LSxnbqfhMVttwyUfzQinR8b+0Kjkm9InqgaNUGCLBKn431
         84BWEn/UO4PJiuZ/gPDjkEvItYJlZ1B1uJFaXZ9+C2wQAEr821N0RDmwCd+C2Uo9TkOt
         eiyCDsiANpg6dkNEotCfv23JsNKy2keNnjf61XoeNW4/DvZ1o3PCC2B/JRZY+x8kV2LZ
         1RJCdkVM6Lqy81rqSWHRj5m/gNq1NpB1ugm0u/pryQJjPMB/+wL8ACX7FMjm4d5bhDAe
         IUOHYYBMza63IsYKaYXKcXoF7IHRfagPqNBE1BpXppV5HJm1IkEEdCzTzfL9E9nahBUE
         JvGA==
X-Gm-Message-State: AOAM531R94naIwoExzwaE67wOoh2KJZOMmWL415M3rU1WKjja2ajK/tU
        8AO5UKcefrLETyilz73MhFw=
X-Google-Smtp-Source: ABdhPJyJr4Q0Kdl/XKudXwMVIgpmw0iTMVTpgP5Zm5uquMOUnBAjsO3HfFb9wXdMnaCunZB1cU1MXg==
X-Received: by 2002:a0c:f801:0:b0:427:47d3:3715 with SMTP id r1-20020a0cf801000000b0042747d33715mr15196166qvn.46.1646804257952;
        Tue, 08 Mar 2022 21:37:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n143-20020a37a495000000b0067b12bc1d7bsm541304qke.13.2022.03.08.21.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 21:37:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux@dominikbrodowski.net
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pcmcia: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 05:37:32 +0000
Message-Id: <20220309053732.2081252-1-chi.minghao@zte.com.cn>
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
 drivers/pcmcia/bcm63xx_pcmcia.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 16f573173471..bb06311d0b5f 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -327,10 +327,11 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 {
 	struct bcm63xx_pcmcia_socket *skt;
 	struct pcmcia_socket *sock;
-	struct resource *res, *irq_res;
+	struct resource *res;
 	unsigned int regmem_size = 0, iomem_size = 0;
 	u32 val;
 	int ret;
+	int irq;
 
 	skt = kzalloc(sizeof(*skt), GFP_KERNEL);
 	if (!skt)
@@ -342,9 +343,9 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	/* make sure we have all resources we need */
 	skt->common_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	skt->attr_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	irq = platform_get_irq(pdev, 0);
 	skt->pd = pdev->dev.platform_data;
-	if (!skt->common_res || !skt->attr_res || !irq_res || !skt->pd) {
+	if (!skt->common_res || !skt->attr_res || (irq < 0) || !skt->pd) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -380,7 +381,7 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	sock->dev.parent = &pdev->dev;
 	sock->features = SS_CAP_STATIC_MAP | SS_CAP_PCCARD;
 	sock->io_offset = (unsigned long)skt->io_base;
-	sock->pci_irq = irq_res->start;
+	sock->pci_irq = irq;
 
 #ifdef CONFIG_CARDBUS
 	sock->cb_dev = bcm63xx_cb_dev;
-- 
2.25.1

