Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E56524D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353898AbiELMsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353937AbiELMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:48:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459324D609;
        Thu, 12 May 2022 05:48:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 204so4711956pfx.3;
        Thu, 12 May 2022 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hejKbvafgIWM4+Tz9llDB32X+Fj+04OcDt3du1TfHhs=;
        b=Dsp8UHbqj+7LnuCGME5/kif33ZIAXqzO9+0iQt/c6EeECcF7LZcsDN2dZGAP8mkGVV
         5iRh8TN87Er7tfdujPOXQb0hanqPbhhqlVM7VltblbXj4oefo0BQo1PJvGrcNanjFfIe
         UUyamT+ALOkLvyc7sUifYXnkC+dE3JI6Jq9g+zWPFsttvBgTOoVN/Ul128uumHiOf+yQ
         5f1jKYrJ3qp/e1aP7yJQZsf4f5J2cncoaEDt1N8K3/1E8arO8Mdd4MrpcqPITQxAAfta
         0ZnCd+mMYtkXoh8vIE8ulorKEWdJUXV5nmm6TAuI6BVLTdQUMJWJfbG2nHQYx4sFMiPI
         QtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hejKbvafgIWM4+Tz9llDB32X+Fj+04OcDt3du1TfHhs=;
        b=xnH6LGOwehUYckwwWL314r2pRPsi+VA6uj+r7yfMYPgna1Sa68GysBQkGoQ97dJcex
         nyxFhWQNIIloRXQcq+hs52ieF6ZTbHWyd+0CNRTZQI3O4FHiGI12X/TSzC8HQHEk8pNY
         px+NXDWgbIiytCr1EAAmRGn4YjwV1viZgRxSl2DfoS5ojcVt0JH1cwUBeX6hNpVYNM+w
         4F4ncYwGYt4YdKUHc669JeR15vm9UqSN6/VMUkw4lcrDvtpB5Zy8gAd6B38U8TUdhVfK
         W0K/KXKn899ogDLDlC4kF4X6UtDG2UEuFb/lRY0c4H4Qm11sqOl1tIzlzjQBUGb4mMD1
         HiIA==
X-Gm-Message-State: AOAM532fvcPlM/ZbiSXrIXRPNzFPNUGPhEZ6dyQV+YcMlkc54vKqenA7
        YtDqgiNeHBczb02glibxJw==
X-Google-Smtp-Source: ABdhPJzqGHVIBtqtlTHSL6+V5ZTCLy3+Ra3zvKE+1i4M4kajE8A7vF41uQ+o29dw+LTpn5FbJ6wL8Q==
X-Received: by 2002:a63:84c7:0:b0:3da:ec43:1b with SMTP id k190-20020a6384c7000000b003daec43001bmr10618967pgd.443.1652359702715;
        Thu, 12 May 2022 05:48:22 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b0015e8d4eb1c0sm4016796plg.10.2022.05.12.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:48:22 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     andy@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] gpio: ml-ioh: Add devm_free_irq() call to remove flow
Date:   Thu, 12 May 2022 20:47:55 +0800
Message-Id: <20220512124755.2360648-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
References: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
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
[   14.218264]  unregister_irq_proc+0x14c/0x170
[   14.220206]  pci_disable_device+0x1ad/0x380
[   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]

Fix this bug by adding devm_free_irq() call to remove flow.

Fixes: e971ac9a564a ("gpio: ml-ioh: use resource management for irqs")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Remove unimportant lines from the call trace.
    - Add the fixes tag.
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

