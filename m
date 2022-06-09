Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40F5445F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiFIIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbiFIIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:32:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6419CB57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:31:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso8872997pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sS4MgQu//5lSEEE1q6KXTrd1V5xl/lXvZSVVghs7MXw=;
        b=A6fON0R19AwVP4siIpMfsE0jiVUbdZTxhdZgGuDcnHo5MuncqBIVRWqZEOYy8GRVLH
         jMEW/8GQXhBtMn8nhODuLfSu9cMIIB6dnqoNFXW5OpWxMKcdCjkIV1rnO4kY5Lkxvaeh
         c6+9AUkHIYE7RrSnxcSDbZ79NrmHVCajSlzPZrpRbvThDImtRXxR4EVDXRLD1DvB1mil
         A1Iq5lX4+7EX1b4I6a2gttHd6IPPCLjQ0iZJKaeq+2Q25eaZXnkvfIQCmVFug3ZypDED
         0HBgQs60DNdoL73hElE9UY+n9VzstUa3KBhTvcaaxDrPcnam1hO3uxoiuvATM734zq+0
         GWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sS4MgQu//5lSEEE1q6KXTrd1V5xl/lXvZSVVghs7MXw=;
        b=JVHzRiqkayFx3O9E2CccSPZCsSbtFBzYz2ZuzNKtxaSbYY0qib2j7ChuQGTdFALhf4
         XqOgskwCQh6G/OgpQz3B+S/aNUP5PHhoqjCEiYAc2NyNIHmx6upuAtNK7McavtvE58JA
         GRdKf+9DDyqGAaroCT4guOmRw9PRxqNsIdLffbUYgkoV+/ep3CbnYk6iVqCPmY6Huing
         gMU4FcYGow22D/6aze1ziYY50+rdzlNFYBBiHHSqbKpkXkXU1jGLWkqKtVmpBdtSz3eB
         tzBGCCrsovG5fe9RKBUY0z3yYVTS50uOxt6pnzUJjeCbXAsLTefwWqeOi+vEn0lDPWiJ
         o2aA==
X-Gm-Message-State: AOAM5323Ay/SvbQAlsyr7qMM28wMk5RB8pk6ll8sSqMAtSiZYunxCXOl
        qBq+adGyxWE3Zo0MV8lLVw==
X-Google-Smtp-Source: ABdhPJyMKPE0SMsVlrskRJxIXsELInHCqg+E38JgCSBPo303Em9YKygyvCF4vs7WaLSaQ7dn0RwOrg==
X-Received: by 2002:a17:902:ec88:b0:166:33fe:a60c with SMTP id x8-20020a170902ec8800b0016633fea60cmr38199895plg.157.1654763503831;
        Thu, 09 Jun 2022 01:31:43 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7880b000000b00518e1251197sm17074597pfo.148.2022.06.09.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:31:43 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, fseidel@suse.de
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] tty: nozomi: Return an error when failing to create the sysfs
Date:   Thu,  9 Jun 2022 16:31:33 +0800
Message-Id: <20220609083133.4120738-1-zheyuma97@gmail.com>
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

The driver does not handle the error of the creation of sysfs, resulting
in duplicate file names being created.

The following log can reveal it:

[   52.907211] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:05.0/card_type'
[   52.907224] Call Trace:
[   52.907269]  sysfs_add_file_mode_ns+0x23f/0x2b0
[   52.907281]  sysfs_create_file_ns+0xe9/0x170
[   52.907321]  nozomi_card_init+0x97f/0x12c0 [nozomi]

Fix this bug by returning an error when failing to create the sysfs.

Fixes: 20fd1e3bea55 ("nozomi driver")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/tty/nozomi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 0454c78deee6..d0ad1b9898f5 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1282,14 +1282,26 @@ static ssize_t open_ttys_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(open_ttys);
 
-static void make_sysfs_files(struct nozomi *dc)
+static int make_sysfs_files(struct nozomi *dc)
 {
-	if (device_create_file(&dc->pdev->dev, &dev_attr_card_type))
+	int err;
+
+	err = device_create_file(&dc->pdev->dev, &dev_attr_card_type);
+	if (err) {
 		dev_err(&dc->pdev->dev,
 			"Could not create sysfs file for card_type\n");
-	if (device_create_file(&dc->pdev->dev, &dev_attr_open_ttys))
+		return err;
+	}
+
+	err = device_create_file(&dc->pdev->dev, &dev_attr_open_ttys);
+	if (err) {
+		device_remove_file(&dc->pdev->dev, &dev_attr_card_type);
 		dev_err(&dc->pdev->dev,
 			"Could not create sysfs file for open_ttys\n");
+		return err;
+	}
+
+	return 0;
 }
 
 static void remove_sysfs_files(struct nozomi *dc)
@@ -1383,7 +1395,9 @@ static int nozomi_card_init(struct pci_dev *pdev,
 
 	DBG1("base_addr: %p", dc->base_addr);
 
-	make_sysfs_files(dc);
+	ret = make_sysfs_files(dc);
+	if (ret)
+		goto err_free_irq;
 
 	dc->index_start = ndev_idx * MAX_PORT;
 	ndevs[ndev_idx] = dc;
@@ -1420,6 +1434,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
 		tty_unregister_device(ntty_driver, dc->index_start + i);
 		tty_port_destroy(&dc->port[i].port);
 	}
+	remove_sysfs_files(dc);
+err_free_irq:
 	free_irq(pdev->irq, dc);
 err_free_all_kfifo:
 	i = MAX_PORT;
-- 
2.25.1

