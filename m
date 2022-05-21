Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265C52F939
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 08:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiEUGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiEUGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:24:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E08F17CE5A;
        Fri, 20 May 2022 23:24:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j21so9208682pga.13;
        Fri, 20 May 2022 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+035shCGayoVZnHh6P8+prZuzk5qeaJC5UNIpCMpBI=;
        b=DPMPF91IKlfD0xI4JyQCyHN9pvfG7aQ954msFUzst3pRk+TsDCxTnUJPl+G9xz35Ll
         vrGQWBz5lvdKyt4Y1XtyXtTVehO56N4L7nu03CiQPil/XzaV2G6Qs5laH4ZzElWcVleb
         k5UHlwpW7y4kWmuRtBI2KIihuQ8Cnv/wMOInRu51O1HfdzPySO92Fugc54VpjPpDbTPa
         GulYWpKo6kZVN5KU8Y64qnU46c8GN+emJ82zZoHtUBjPWXoALmJdQ1O19lyPeWT/JiUk
         QinVzT7E8wRvivtP72vJvffWYQgqTcm8IPdxzIG8akXCVg6Xm2B9yujOC/HEyHvg9CUJ
         IXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+035shCGayoVZnHh6P8+prZuzk5qeaJC5UNIpCMpBI=;
        b=a2hsOJEiAOW45fMknfsEcx9aIlkQtZnPULLwp82FyQmUDvOerA+oTufTOzdX6O7Qz+
         anpENupBXfhrLlurSQCzKuahUpt29s/MZ9MrzrQwt5eHpvU3HaYWMQP3gmCr814TsyoU
         iV2Y2huHoGqfCKjq41l7bT/Ynl2C5tCKHpjhTnOcvPekRsHh1RF9HSgcGbG4eXpsGuiu
         EYDuVeq3VeXJ1sUZBX2aTL7JbgWBLl8UD3PDvgvgctXi63OnGkbs1w95bh2PB1c42/jR
         ra0NTEM89xFgoGVkvAWkyAAJhpkdffOTJybMbRvPnsoP+FGn7Ju9mLUDnZalKLfSIJhT
         +Uhw==
X-Gm-Message-State: AOAM531UFa1vHNug1kZf8nnKnWtSV5QZwEeIhXeUat59gIK3SJRFaCpD
        ISeu0eEoZZVlj5sEXnfl2A==
X-Google-Smtp-Source: ABdhPJxMBttmUWzz887BCqKJuXt9xNs8IZXr/b4QufxVfwdedzEseaozqS8YQDEY1FDHhIkIzXxmNg==
X-Received: by 2002:a63:5959:0:b0:3f2:779d:de6c with SMTP id j25-20020a635959000000b003f2779dde6cmr11192176pgm.355.1653114251744;
        Fri, 20 May 2022 23:24:11 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b0015e8d4eb2a6sm747822plb.240.2022.05.20.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 23:24:11 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: tw686x: Register the irq at the end of probe
Date:   Sat, 21 May 2022 14:24:01 +0800
Message-Id: <20220521062401.3294686-1-zheyuma97@gmail.com>
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

We got the following warning when booting the kernel:

[    3.243674] INFO: trying to register non-static key.
[    3.243922] The code is fine but needs lockdep annotation, or maybe
[    3.244230] you didn't initialize this object before use?
[    3.245642] Call Trace:
[    3.247836]  lock_acquire+0xff/0x2d0
[    3.248727]  tw686x_audio_irq+0x1a5/0xcc0 [tw686x]
[    3.249211]  tw686x_irq+0x1f9/0x480 [tw686x]

The lock 'vc->qlock' will be initialized in tw686x_video_init(), but the
driver registers the irq before calling the tw686x_video_init(), and we
got the warning.

Fix this by registering the irq at the end of probe

Fixes: 704a84ccdbf1 ("[media] media: Support Intersil/Techwell TW686x-based video capture cards")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/pci/tw686x/tw686x-core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
index 6676e069b515..384d38754a4b 100644
--- a/drivers/media/pci/tw686x/tw686x-core.c
+++ b/drivers/media/pci/tw686x/tw686x-core.c
@@ -315,13 +315,6 @@ static int tw686x_probe(struct pci_dev *pci_dev,
 
 	spin_lock_init(&dev->lock);
 
-	err = request_irq(pci_dev->irq, tw686x_irq, IRQF_SHARED,
-			  dev->name, dev);
-	if (err < 0) {
-		dev_err(&pci_dev->dev, "unable to request interrupt\n");
-		goto iounmap;
-	}
-
 	timer_setup(&dev->dma_delay_timer, tw686x_dma_delay, 0);
 
 	/*
@@ -333,18 +326,23 @@ static int tw686x_probe(struct pci_dev *pci_dev,
 	err = tw686x_video_init(dev);
 	if (err) {
 		dev_err(&pci_dev->dev, "can't register video\n");
-		goto free_irq;
+		goto iounmap;
 	}
 
 	err = tw686x_audio_init(dev);
 	if (err)
 		dev_warn(&pci_dev->dev, "can't register audio\n");
 
+	err = request_irq(pci_dev->irq, tw686x_irq, IRQF_SHARED,
+			  dev->name, dev);
+	if (err < 0) {
+		dev_err(&pci_dev->dev, "unable to request interrupt\n");
+		goto iounmap;
+	}
+
 	pci_set_drvdata(pci_dev, dev);
 	return 0;
 
-free_irq:
-	free_irq(pci_dev->irq, dev);
 iounmap:
 	pci_iounmap(pci_dev, dev->mmio);
 free_region:
-- 
2.36.1

