Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E315508A06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379321AbiDTOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379310AbiDTOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9F3E0E0;
        Wed, 20 Apr 2022 07:05:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 2so2047273pjw.2;
        Wed, 20 Apr 2022 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnqqSsjL9QQm+IpAcwauYSo9Io7ouReUn6ghaim9b0I=;
        b=ZjT8ZhfBExSv6n6WjkCSh9zUr2OvIPG/pBPPq4OwJ1Q/zOstz0vV4czjDMVWuZ1zCi
         Cl86wJPMqAU61fDy5XDHrb2UBdti70SAvt48orBaYyHukIxAYlf6Wfv5x0wYrAarR3w6
         SpHggtTrhwTuppiAxCb0TvpWa2GzeguT5hKPgtVca3a7iQABQrHmx9pxBsl1RrMVdGBj
         oUIwZ5wsfVGu+kIsVaDKnHfVyLcpax2buLEc38VOu3kI/gKjvwTN4fMsrwGD2WFfZUyA
         jFazxm2MuCcnPr9lluLc5lW1r8WoIpfbpg3RfspbdXflZwxJsa30hGxnEYRSFNW2UK3/
         ipAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnqqSsjL9QQm+IpAcwauYSo9Io7ouReUn6ghaim9b0I=;
        b=BLpo2OAXsSy9S5a4vViGehkyYXFVseyb4NshPCJvQAUx9W0qNZ555EDe5wmSRlwAWz
         plXMbE3df5zK7w4+RUCvaibC02jKMD30IPfWR9PStud6zw8Q/i8kjfImoRdxX60Hpira
         +KA5qfN73nk7eM0AC9CocMYRhgoEwMBRPRyhonU5lNaG3LcT+AGuhm3WOGEmI5BaS2/V
         4x+fEp1ZWQeAaiBkung0pUU8v0CRwldYLAk//9sEb+LylOYEiDh3dgPccNNny9k0PvW9
         1FIGtjq0pie8wjhdMao5xo6aqgugJkfJU9WHIMbz6is22Nq0FDiuCy78ribOwmuGiQm9
         8NRQ==
X-Gm-Message-State: AOAM531rOihHvCu0c03eQXHdgdAjqzr45+I8Azbee9MCnMgR6e6bDhCV
        7wM4DwgR3T7I/D2rk82c2vfhRY0XFQ==
X-Google-Smtp-Source: ABdhPJxxaICtnDQ2mqwa4dW4TPgE4mg0SkSYATaxZ588s8Gnwp4hJ1M0lmnnegjGU2zlxmipuW494A==
X-Received: by 2002:a17:90a:ba15:b0:1c6:7873:b192 with SMTP id s21-20020a17090aba1500b001c67873b192mr4721316pjr.76.1650463555255;
        Wed, 20 Apr 2022 07:05:55 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:54 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] s390/irq: utilize RCU instead of irq_lock_sparse() in show_msi_interrupt()
Date:   Wed, 20 Apr 2022 22:05:16 +0800
Message-Id: <20220420140521.45361-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-1-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_desc can be accessed safely in RCU read section as demonstrated by
kstat_irqs_usr(). And raw_spin_lock_irqsave() context can provide a rcu
read section, which can be utilized to get rid of irq_lock_sparse().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
To: linux-s390@vger.kernel.org
---
 arch/s390/kernel/irq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3033f616e256..6302dc7874cf 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -205,12 +205,13 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	unsigned long flags;
 	int cpu;
 
-	irq_lock_sparse();
+	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc = irq_to_desc(irq);
-	if (!desc)
-		goto out;
+	if (!desc) {
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		return;
+	}
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
 	seq_printf(p, "%3d: ", irq);
 	for_each_online_cpu(cpu)
 		seq_printf(p, "%10u ", irq_desc_kstat_cpu(desc, cpu));
@@ -223,8 +224,6 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 
 	seq_putc(p, '\n');
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
-out:
-	irq_unlock_sparse();
 }
 
 /*
-- 
2.31.1

