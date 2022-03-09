Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5C4D2896
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiCIFvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiCIFvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:51:43 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222415C641;
        Tue,  8 Mar 2022 21:50:45 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 11so1064851qtt.9;
        Tue, 08 Mar 2022 21:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2apKR2eRflqvpMzkbaB6F984zqxoJXh8XTDKaLQ5jH4=;
        b=eDbfvbczoLsE7oCG5n1TiNxTptQHxdh2oSevaCGIPriidCG9UMXsJt1yUEvevtLDMO
         7ACazpCW+gECxx6Xp0ZalGwQJf/OK4kzjlYAghw0PJQzxgSPzxB/bkD+ud4XnuCF9tfK
         +bUJ67jXVubou+4GREA2/r6RbzNVIYczXHZQzhLwfLwRFry0VN7gsukC3UP1mchedsEF
         d9btLZg8Hf+c2+LTEFVb6dFLQlOgGhUYiojSBAHgqLwDrg5QvtqnTlRQSb2WmRvhQ3+k
         awMuP/3fOMlR1IOngdQKALFEgimH9PxDgJgPvTvK8KwyEkKVrZR43LgbyjLhjiMw4LA7
         zrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2apKR2eRflqvpMzkbaB6F984zqxoJXh8XTDKaLQ5jH4=;
        b=VWu6kMh/UvuXKISjcSXVkSMP0Ya+RC9EGj7VSPmRS7aa3JAIC78XZFtqdy6QPnuXDs
         20t8CcJtFYE8PrTZ7ipHdK9E+nz0xkH83UdAcNEawHGTtLYjdwiR6NmVooTaVC4gIglT
         LH4bWrFo0dKOi2wMwYIASi31iLGvDRts72YUo/fta8bukw1+N609Hb6kiZ3mSmDvXFVf
         HITyB1KQqDCzoqBL24mTjS7V++t1+RE/lsxs55GmDwfRScIAohH3nDN5ISSq3Gh9YwM3
         SBuhxPWGkHRZ4kiB6znh6UtTou00Mnqcmq1ZDV30qLUhO4dTdb6NW0VE/hU0qCogVlEt
         Rrmg==
X-Gm-Message-State: AOAM531ay+uU8sf5Yn0PVeUR9/SLsU5rZO2Xhu6p6XWeM+L+Rz3Za1nm
        qkizfXQLTeSuHitIVLH+wcY=
X-Google-Smtp-Source: ABdhPJyCMmvRu763XBc+7hyu8tGfSmODg0Os6GDw0xk52izH7I6BtywLBmluPBsZkxg5npK9XBkDAQ==
X-Received: by 2002:a05:622a:18a6:b0:2dd:2c5b:ca00 with SMTP id v38-20020a05622a18a600b002dd2c5bca00mr16428357qtc.549.1646805045101;
        Tue, 08 Mar 2022 21:50:45 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm522866qkk.52.2022.03.08.21.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 21:50:44 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     s.shtylyov@omp.ru
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V2] ata: pata_pxa: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 05:50:38 +0000
Message-Id: <20220309055038.2081317-1-chi.minghao@zte.com.cn>
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

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

v1->v2:
	- Use more specific in the subject: ata: pata_pxa:
	- Switch to returning 'irq'
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/ata/pata_pxa.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 41430f79663c..340b274d0cad 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *cmd_res;
 	struct resource *ctl_res;
 	struct resource *dma_res;
-	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct dma_slave_config	config;
 	int ret = 0;
+	int irq;
 
 	/*
 	 * Resource validation, three resources are needed:
@@ -205,9 +205,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * IRQ pin
 	 */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(irq_res == NULL))
-		return -EINVAL;
+	irq = platform_get_irq(pdev, 0);
+	if (unlikely(irq < 0))
+		return irq;
 
 	/*
 	 * Allocate the host
@@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * Activate the ATA host
 	 */
-	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
+	ret = ata_host_activate(host, irq, ata_sff_interrupt,
 				pdata->irq_flags, &pxa_ata_sht);
 	if (ret)
 		dma_release_channel(data->dma_chan);
-- 
2.25.1

