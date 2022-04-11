Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C64FBAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345921AbiDKLYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiDKLX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:23:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8445510
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:21:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 32so11784147pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ct0KPIwIFBFQvI2RK89Mz30dFbD3GIANQnxanM+V5Hk=;
        b=pIsrbL6usz31jkne7q1tPeu0ne1pxxjoT9uAJd0h3YObyCn1tzb/VLB/xZdUVld6lS
         nNppWDpT6aGeR9pBBW8TIQgIbbS61uE0mv5TMr3iN7jRsITnU0mkdH9BIz8Ty+wjFg6y
         x8syGq/uRIQ4F/KNpRE4sOwmu7HvaNg+Jb/ZEJNCQTiRc1a6IVDotCUiutJnP2kiVnuc
         7VFRyA862wDCxEU5N21FTg3TwaeC6Oynh/oJrndTiubYW/l0WIizvOYjqtZQTblopDU9
         do18EQGK8mjffeEdwBfZX/W8l0g4aE9zgrQ8LSTs9qN2BjDBsYSC3nzqBb7HrbnB46NE
         I04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ct0KPIwIFBFQvI2RK89Mz30dFbD3GIANQnxanM+V5Hk=;
        b=Kg9mEK/O7/dBFXqXxeXHRyIyrgee/rSGHndUBdpbhaE+0vjnqxmWO2PxN4U5dn1YEE
         yL1mzHl0i93lHI8UPIPogj80eO6oSFRCjPXtw0b/JrOvDVBmHmnuLQgbiqAG5g4dywfz
         bTQz2Z1OOYO6pBV6TYPTg6XZqdmJP6sHIHNgeRzIwffSFWs+6uG+vrBeUVH98sIjW+W9
         ZZfIqmttMPQjFTKf2Mfw4wCjvxoaD2MSwuToneuKtCQIwE24FCB+qnihg4COeb5rrOqR
         JZHzHVmW4REmqAprGclmRQ0qY4f2y2Bhx63MlPYN0N8es8+MZIDaH+oWh7p0EWw/yFoY
         WW6A==
X-Gm-Message-State: AOAM530pENxlkq9DhsRfL7cLnV5z9609elN2jVj0/gvHQ74RuBu73JX2
        a1QmFvV4vECYTj1QoKu9ww==
X-Google-Smtp-Source: ABdhPJzBOeLgMjpOYtSe2jCq3H+Z3APHHfpZ1ubpgpgwVcb/nNz6K1twzSPaimOwZoj9jFdHzg7vNg==
X-Received: by 2002:a63:5f42:0:b0:39d:4f86:2f59 with SMTP id t63-20020a635f42000000b0039d4f862f59mr4132369pgb.181.1649676102588;
        Mon, 11 Apr 2022 04:21:42 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id y3-20020a63de43000000b0039d1172b90fsm7365844pgi.76.2022.04.11.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:21:42 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] mtd: rawnand: Use managed device resources
Date:   Mon, 11 Apr 2022 19:21:24 +0800
Message-Id: <20220411112124.3700126-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

All of the resources used by this driver has managed interfaces, so use
them. Otherwise we will get the following splat:

[    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for irq 0x1000
[    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
[    4.473538] nand: No NAND device found
[    4.474068] BUG: unable to handle page fault for address: ffffc90005000410
[    4.475169] #PF: supervisor write access in kernel mode
[    4.475579] #PF: error_code(0x0002) - not-present page
[    4.478362] RIP: 0010:iowrite32+0x9/0x50
[    4.486068] Call Trace:
[    4.486269]  <IRQ>
[    4.486443]  denali_isr+0x15b/0x300 [denali]
[    4.486788]  ? denali_direct_write+0x50/0x50 [denali]
[    4.487189]  __handle_irq_event_percpu+0x161/0x3b0
[    4.487571]  handle_irq_event+0x7d/0x1b0
[    4.487884]  handle_fasteoi_irq+0x2b0/0x770
[    4.488219]  __common_interrupt+0xc8/0x1b0
[    4.488549]  common_interrupt+0x9a/0xc0

Fixes: 93db446a424c ("mtd: nand: move raw NAND related code to the raw/ subdir")

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/mtd/nand/raw/denali_pci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index 20c085a30adc..de7e722d3826 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -74,22 +74,21 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	denali->reg = ioremap(csr_base, csr_len);
+	denali->reg = devm_ioremap(denali->dev, csr_base, csr_len);
 	if (!denali->reg) {
 		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
 		return -ENOMEM;
 	}
 
-	denali->host = ioremap(mem_base, mem_len);
+	denali->host = devm_ioremap(denali->dev, mem_base, mem_len);
 	if (!denali->host) {
 		dev_err(&dev->dev, "Spectra: ioremap failed!");
-		ret = -ENOMEM;
-		goto out_unmap_reg;
+		return -ENOMEM;
 	}
 
 	ret = denali_init(denali);
 	if (ret)
-		goto out_unmap_host;
+		return ret;
 
 	nsels = denali->nbanks;
 
@@ -117,10 +116,6 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 out_remove_denali:
 	denali_remove(denali);
-out_unmap_host:
-	iounmap(denali->host);
-out_unmap_reg:
-	iounmap(denali->reg);
 	return ret;
 }
 
@@ -129,8 +124,6 @@ static void denali_pci_remove(struct pci_dev *dev)
 	struct denali_controller *denali = pci_get_drvdata(dev);
 
 	denali_remove(denali);
-	iounmap(denali->reg);
-	iounmap(denali->host);
 }
 
 static struct pci_driver denali_pci_driver = {
-- 
2.25.1

