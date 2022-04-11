Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBA4FBC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346228AbiDKNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbiDKNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:00:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD1B0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:58:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so4166273plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvUy3wIA8cnoCdKDgRF9Rlg0AmSDmCIJ2fGS8gSJyKQ=;
        b=I8y5+JbyW76cCP6O8qlJOLg03kSxK+3z369dcJgu9adPP48NC7SmFG6tQjO5xp4YVB
         Jr1wvb+gjTco969BZGPZXf1WDRAvBRUsPoHruBZ7wmfSKBC1ensacAw67p7Q3FWEnpRY
         8/otECbNyY6cnknmopXTi7Prd4bGFv8JSjjAxvKHAYcoqI9imWDSeyyfjpPOVWpIRwmH
         bUYCThkS7Es0rw0kqXKUIhaMysho6Wdo6MWxN6zrBLOmjhN10xQCxBENpN/BfkkaUlKZ
         jEZHE2p1C/zTVt8UQorHTkKfBuavz5M/a7XzIX7HcRkix74Pt6vn8caDLKkKmiO82VEb
         H7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvUy3wIA8cnoCdKDgRF9Rlg0AmSDmCIJ2fGS8gSJyKQ=;
        b=LzOSg03Vh37pM9V/L66ubUdhgQBUDIxcwQgMbYPejnbpc4zh3Poum/U+1wClWa7QKR
         6riQEprhkCyaW/FXHPtCbj2nFARNdCnj/H/1B3FkqvnDD6MOYqPnrKFcbnE5cqzbBXUH
         RbwxrjW80bT5mtR0Yr+dZ5EndRDbdhnLHKlt5ojLo/fi1tGepfLrfml1CL42KmJnG9Pp
         RF2EQbuuoDPUTbfI4Ot8JUJuWEHd2pb8rbc42GZIj3XX3pInGuWQLNTd4d6746HHxaEx
         T9SW26lPZmTrr63LLGgJyK9hYlXsb1gwmJ4ojTwb9jacAXuw1WJf4PS0sWsVhDu8ueSe
         cQ5w==
X-Gm-Message-State: AOAM533dXogEYLLsWwf/U4QTLoSW5Q2/tP/oDrTXBBcvIqK5tVmuh6X+
        n5BYK69BeHA/2Zq5vS/iUA==
X-Google-Smtp-Source: ABdhPJxlriaAILwrx11gZma2WuB92Mcj2z3Z++NBQ6RIWaRXbMxrHv4+XQQTW6MZ4MBxx4n1vGU81Q==
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id m17-20020a17090a859100b001b9da102127mr36488496pjn.13.1649681903018;
        Mon, 11 Apr 2022 05:58:23 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm29314668pgf.46.2022.04.11.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:58:22 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] mtd: rawnand: denali: Use managed device resources
Date:   Mon, 11 Apr 2022 20:58:08 +0800
Message-Id: <20220411125808.958276-1-zheyuma97@gmail.com>
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
Changes in v2:
    - Change the prefix
    - Delete the extra space
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

