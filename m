Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC04FD41D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiDLJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389357AbiDLJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4513FBB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:34:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so2090663pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+WheqzFQw/mKqTJlEa8kndueE2loy7UspcQexqwzXmw=;
        b=Vqv4gi/uGPp5SLs2obfxsCHDo21INQQAbLQkR1wMBQyr93jRnWSO26Ur20TltdF68V
         ZzhOBDdCs9FqY5FxFfaOlcZO2fM9F3v1eaYdCSvQAfJ5Jx6qKd8VxUX3eelLdzwldHpz
         B99PeOCux6eWQTI8eEwdA2tJLNlPGUf+8wN0WUmEoJKRZYPPRefVklFRFaOFJco4wUWO
         zWDAJyfA9PiB9ot/WrZGFRt5mKR9CBI5FOmZwKnCXe/tognhuUU1bJkqOVO5vNowFhFR
         M/tNgS7fKpYPTTW4c8v3qWPZMIwYdZGNr+KT/MywRtUzyLYdIh3W9Rsp3Ej8X45fzxzv
         kEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+WheqzFQw/mKqTJlEa8kndueE2loy7UspcQexqwzXmw=;
        b=L/Tsd4aYpjmxrQL7020gMb4bWv7l4PVocnL7NObK2cOolmy/d/IvYCVA3K3nl280f5
         ztKzaWyoGMK9ntM44zmfTSlohP8s10b0YR6O4l4xVQ+HzA5m9tecSMGGSIZmRZ9NrAPT
         KSIVi4+fKSajqSwaDtC9J+Ee8Vm5FFda4G5MszWJF/+KA18AchbiRcAKnPGEkqCvl4Fq
         K0mejrRfTb6iYVKGK2PbFFqacpiAdU2sFNUlal+pTqdm6AE4gdWJJ4ppEyxonmuVMMeM
         IBCurJo4L0v9WIGqxzJUZTBR0Akwp/C8EoZSlsGtFWs3GosOsj5G29wi2UW9shJ2cssq
         rWqw==
X-Gm-Message-State: AOAM530gSgLRO7/OYg+RHfM3lExG0JhbyuGIgMDZLvXpjLOO4BXAJU1e
        f7y8QdGYZcQDuidEJXKLj7E=
X-Google-Smtp-Source: ABdhPJzndHO6DEKejPo2dn5FN/qzpFSvwLx/XYVSbZrrJOqWrWYZUJ1iBg56pQ+CvENlgjGfwn3hwA==
X-Received: by 2002:a17:902:8c96:b0:158:9135:98d3 with SMTP id t22-20020a1709028c9600b00158913598d3mr586986plo.171.1649752484531;
        Tue, 12 Apr 2022 01:34:44 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm2174289pjb.25.2022.04.12.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:34:44 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: rawnand: Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 08:34:31 +0000
Message-Id: <20220412083435.29254-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220412102832.09957c35@xps13>
References: <20220412102832.09957c35@xps13>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- initialize ret to 1.
---
changes in v3:
- initialize ret to 0, now ret==0 means success.
- update condition check in caller.
---
 drivers/mtd/nand/raw/sh_flctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index b85b9c6fcc42..a278829469d6 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 	dma_addr_t dma_addr;
 	dma_cookie_t cookie;
 	uint32_t reg;
-	int ret;
+	int ret = 0;
+	unsigned long time_left;
 
 	if (dir == DMA_FROM_DEVICE) {
 		chan = flctl->chan_fifo0_rx;
@@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 		goto out;
 	}
 
-	ret =
+	time_left =
 	wait_for_completion_timeout(&flctl->dma_complete,
 				msecs_to_jiffies(3000));
 
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_all(chan);
 		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+		ret = -ETIMEDOUT;
 	}
 
 out:
@@ -441,7 +443,7 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 
 	dma_unmap_single(chan->device->dev, dma_addr, len, dir);
 
-	/* ret > 0 is success */
+	/* ret == 0 is success */
 	return ret;
 }
 
@@ -465,7 +467,7 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_rx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE) > 0)
+		!flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_FROM_DEVICE))
 			goto convert;	/* DMA success */
 
 	/* do polling transfer */
@@ -524,7 +526,7 @@ static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
 
 	/* initiate DMA transfer */
 	if (flctl->chan_fifo0_tx && rlen >= 32 &&
-		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE) > 0)
+		!flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_TO_DEVICE))
 			return;	/* DMA success */
 
 	/* do polling transfer */
-- 
2.17.1

