Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87031524B87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353352AbiELLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353503AbiELLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156F3F890;
        Thu, 12 May 2022 04:21:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h186so1670861pgc.3;
        Thu, 12 May 2022 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIurYoCSR3CjizFhZw7cd5BmToPG+UfENh5pM88hKx4=;
        b=cHQFeyOJmgJUyNaipH35vzKs3ZXrAcdp8G9oS0nzAQMffmR8t4jZQLCzLligEXWNzs
         t/I8V58+Hkw0qK2B9464IYEvU/8WSEiifLx+fGH8eNDW3qHsYFeZLFOkF341BA9jxzOb
         wSkhJ1mX62uYyGgZ9D4Io8ckzifks8kVE5Wc0hcpA+N4jtEtFIF0FEa9M+Jwnpic/VBC
         IGYINhtVyGEpPCo4X+J96tEcuNwQhbB4MAciHxsZyW5xI0B3oqT/6g9k2PT79i9YuqXk
         xgmJ/8FCkun8IUStNEpvVA2SIDq8OxStmAsjIdO/xwa/Uq7t/Vsw73EXxVkI8Bvx2m2E
         9eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIurYoCSR3CjizFhZw7cd5BmToPG+UfENh5pM88hKx4=;
        b=15LXl7hHzOrwD6jM1zGIGBxhDgTcMqURVhm9xiIIkplftEXVbcoGB/OOk8c21XZNar
         OrTcre0pjb4z75q+uPXbUcU0nii61+w7TGjk+DLVct1c+l35s4W4Ks4+nTe1Yj6BS2dF
         f1BqfEmlBPSjI7IUBe3AhmCeQUQJUo0inequNf1YtHpG3Df7lDH7gKedIcd5ce2Kva3v
         0KxBIcIgeB+HSIdZe9nT0wGZ1FY7CUCalFKoVMXLXhZtnA2WMwsQ8wp87aHeNTuyGcA7
         LMVTLsykCPyKPJ/PsGNwwoU/skG95GRx56aKPG3C5LnJihQt3aPoJEg0iVQdsKusexYa
         qbUA==
X-Gm-Message-State: AOAM533UYf08jC5mUQxdqM5/EPaUdpmS7Qx1BU2bD03x2Gh/yM3lkukT
        t1GDl73UduUjcwbgKtG4aw==
X-Google-Smtp-Source: ABdhPJyPx3PIF4jVce7Ygw+a0b8F7p0PwMSl0VUbLINt9ExNm7fQCerC3EpMDl3xoS1d2MctiYX/5g==
X-Received: by 2002:a63:f510:0:b0:3c6:dfee:b6df with SMTP id w16-20020a63f510000000b003c6dfeeb6dfmr12556091pgh.353.1652354479511;
        Thu, 12 May 2022 04:21:19 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090270c200b0015e8e7db067sm3705983plt.4.2022.05.12.04.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:21:19 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     andy@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] gpio: ml-ioh: Add devm_free_irq() call to remove flow
Date:   Thu, 12 May 2022 19:21:06 +0800
Message-Id: <20220512112106.2356120-1-zheyuma97@gmail.com>
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

When removing the module, we will get the following flaw:

[   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
[   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
[   14.209994] RIP: 0010:remove_proc_entry+0x389/0x3f0
[   14.217820] Call Trace:
[   14.218057]  <TASK>
[   14.218264]  unregister_irq_proc+0x14c/0x170
[   14.218674]  irq_free_descs+0x94/0xe0
[   14.219019]  mp_unmap_irq+0xb6/0x100
[   14.219357]  acpi_unregister_gsi_ioapic+0x27/0x40
[   14.219796]  acpi_pci_irq_disable+0x1d3/0x320
[   14.220206]  pci_disable_device+0x1ad/0x380
[   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
[   14.221075]  pci_device_remove+0x92/0x240

Fix this bug by adding devm_free_irq() call to remove flow.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/gpio/gpio-ml-ioh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index b060c4773698..09bf317876b0 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -508,6 +508,8 @@ static void ioh_gpio_remove(struct pci_dev *pdev)
 	struct ioh_gpio *chip = pci_get_drvdata(pdev);
 	void *chip_save;
 
+	devm_free_irq(&pdev->dev, pdev->irq, chip);
+
 	chip_save = chip;
 
 	for (i = 0; i < 8; i++, chip++)
-- 
2.25.1

