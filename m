Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A696C52F915
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbiEUFze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiEUFza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:55:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF551195EB4;
        Fri, 20 May 2022 22:55:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x143so9334416pfc.11;
        Fri, 20 May 2022 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9K5jYakLsitCG3aeCoI3LC43G255mEcSCnND1aMnvE=;
        b=HL6eA1yFsYmhhwBOMTcGVvfgJMcAN6Li3zYgH4JRb/UQMdkU5MdKLURgI/4AYpC4xq
         KEOf/+Y72k6XqXWKfSecDt9ynqI/MD6AEPSCF8ugdKERDsz57OWrqgTMcQ3OApbNy4et
         lW5U/ygWmaMkwVEF+0wPNJAEtyL3FTMmu5Kw0Mo2JuvufyejJ3FWfSbC7zNFZ6BPz+wf
         giWLoCh/z7r+NBlq5T5v4yplIX9/Km6Hfgxk95uD034RYQQGcewHJn/KtUqlx3HjF7Q/
         UVSGOzeodmxkYuoBFmY9AY+1BZulTyaCBx84iwPRQsM0UzO3U2RJyx4WUVCS6svLn6eJ
         ZDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9K5jYakLsitCG3aeCoI3LC43G255mEcSCnND1aMnvE=;
        b=E2cQ434OnskwMAn6qOHT9D64lAUArJsM7rtZl0moTaxWWFVUiKXKRaD4zRsfJgoDQG
         WZ71td5gvNl8RQLL7STdWYrvCSq5q45Zy2YUYkUNt4XX9wIal5EcLNN0njevhcE5gB+r
         pPv03ijyvMUQv/emYIesHXj1C/a5HkHFmuhqtvu+JuEl/4OMOVL8VPexl/C96BukOIYy
         PEtTda/pmiHYVcV7kMqJVEdC9aIeH27slS94/P8SaF3DDdW3VZAIqfIbXgmEB+n7gB45
         1DdSwIv2r0GzjWJLxHiIPNq9CFAP9Zu4aPdbXFZr7olxJlxW846BJKSJMAImzIyNXU9l
         UU7A==
X-Gm-Message-State: AOAM531V4IoZw3C8cAamWANa27ECf3ZSFmgbLrhJlAvbq9dofUc7ZiW7
        SOf8Y2oMjrtGQKiXAt5O7w==
X-Google-Smtp-Source: ABdhPJzrcNGHH5doaI82Wr3eE19tL3mtNl4XKxa7gv6HxfWFzKm+dAVVmkJl5H8+3IDkoPbEiUISuw==
X-Received: by 2002:a63:e513:0:b0:3ab:a3fb:f100 with SMTP id r19-20020a63e513000000b003aba3fbf100mr11276173pgh.70.1653112528379;
        Fri, 20 May 2022 22:55:28 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b0015e8d4eb284sm685971ply.206.2022.05.20.22.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 22:55:27 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     maintainers@bluecherrydvr.com, anton@corp.bluecherry.net,
        andrey.utkin@corp.bluecherry.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: tw5864: Convert to use managed functions pcim* and devm*
Date:   Sat, 21 May 2022 13:55:17 +0800
Message-Id: <20220521055517.3099142-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the module, we will get the follow flaw:

[   69.323999] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'tw5864'
[   69.324449] WARNING: CPU: 0 PID: 395 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
[   69.326909] RIP: 0010:remove_proc_entry+0x389/0x3f0
[   69.331089] Call Trace:
[   69.331215]  <TASK>
[   69.331327]  unregister_irq_proc+0x14c/0x170
[   69.332579]  tw5864_finidev+0x12a/0x190 [tw5864]
[   69.332811]  pci_device_remove+0x92/0x240

Fix this by using managed functions, this makes the error handling more
simpler.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/pci/tw5864/tw5864-core.c | 30 ++++++--------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/media/pci/tw5864/tw5864-core.c b/drivers/media/pci/tw5864/tw5864-core.c
index 5cae73e6fb9c..560ff1ddcc83 100644
--- a/drivers/media/pci/tw5864/tw5864-core.c
+++ b/drivers/media/pci/tw5864/tw5864-core.c
@@ -254,9 +254,9 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 
 	/* pci init */
 	dev->pci = pci_dev;
-	err = pci_enable_device(pci_dev);
+	err = pcim_enable_device(pci_dev);
 	if (err) {
-		dev_err(&dev->pci->dev, "pci_enable_device() failed\n");
+		dev_err(&dev->pci->dev, "pcim_enable_device() failed\n");
 		goto unreg_v4l2;
 	}
 
@@ -265,21 +265,16 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 	err = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&dev->pci->dev, "32 bit PCI DMA is not supported\n");
-		goto disable_pci;
+		goto unreg_v4l2;
 	}
 
 	/* get mmio */
-	err = pci_request_regions(pci_dev, dev->name);
+	err = pcim_iomap_regions(pci_dev, BIT(0), dev->name);
 	if (err) {
 		dev_err(&dev->pci->dev, "Cannot request regions for MMIO\n");
-		goto disable_pci;
-	}
-	dev->mmio = pci_ioremap_bar(pci_dev, 0);
-	if (!dev->mmio) {
-		err = -EIO;
-		dev_err(&dev->pci->dev, "can't ioremap() MMIO memory\n");
-		goto release_mmio;
+		goto unreg_v4l2;
 	}
+	dev->mmio = pcim_iomap_table(pci_dev)[0];
 
 	spin_lock_init(&dev->slock);
 
@@ -291,7 +286,7 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 
 	err = tw5864_video_init(dev, video_nr);
 	if (err)
-		goto unmap_mmio;
+		goto unreg_v4l2;
 
 	/* get irq */
 	err = devm_request_irq(&pci_dev->dev, pci_dev->irq, tw5864_isr,
@@ -308,12 +303,6 @@ static int tw5864_initdev(struct pci_dev *pci_dev,
 
 fini_video:
 	tw5864_video_fini(dev);
-unmap_mmio:
-	iounmap(dev->mmio);
-release_mmio:
-	pci_release_regions(pci_dev);
-disable_pci:
-	pci_disable_device(pci_dev);
 unreg_v4l2:
 	v4l2_device_unregister(&dev->v4l2_dev);
 	return err;
@@ -331,11 +320,6 @@ static void tw5864_finidev(struct pci_dev *pci_dev)
 	/* unregister */
 	tw5864_video_fini(dev);
 
-	/* release resources */
-	iounmap(dev->mmio);
-	pci_release_regions(pci_dev);
-	pci_disable_device(pci_dev);
-
 	v4l2_device_unregister(&dev->v4l2_dev);
 }
 
-- 
2.36.1

