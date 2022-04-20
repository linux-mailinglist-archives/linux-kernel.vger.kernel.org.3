Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F458508A05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379302AbiDTOIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379267AbiDTOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4603E0E4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x80so2043047pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yUq4fAbVQuINyHJBw8+IFaXlZbWG6vvrcY9HvRvD1U=;
        b=Y88g71a/vBdigWsyyAfvaGoaM78QwhD9/hfJXlCbXLkikG8Ay5JwT94MbVQUEMiU7o
         k48Gstu0JHEZM63w1UvGytVy+9lBkkK1yTCDm3BsSsQ5/DgRhWJ5SA0f2yfJwhZbW7Tj
         lkc84fjk8CkTUFy0IXrPG65uDk3ZIrCnf/Ux7uLcUMQ13veY/jv7Xw5j4PRjcs7psSDd
         Uk1xYwMr21d17+NjmP3P6X/Dl4fwlw7TiwmoQjmzRLXReHX/Ge7nJ+N3aarnQWJ5M1Uf
         WdYG38AEX7msuBY171ZxL9/RePc4gtrGpqA1n8rqZkWgm7V48NJfRy4TmnRKP/kmCdtl
         k5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yUq4fAbVQuINyHJBw8+IFaXlZbWG6vvrcY9HvRvD1U=;
        b=It9i3uOeEIXbsYiVSOb4AE+u9HBZ/XC6tr8x2Gyt6JfQneHFgEyenhDr4BVdltxifi
         +HYsbioBaNj/IkHItQL3tILd4sS5hDwC1CfVA+3adXq6HraRQ1G4VoDGjEA3gT+thcPF
         TOrHaReabOaBDRQXQW/zGZZBTKoO/ZGDp3ULETTWMnDCuXJlGTroKIY//qmfVMPEtOd4
         8sojmzE+u0VQHbl8r80CwOQH5URbojaqYiEa64k7QdAYlfIAvvAXA2tzNITI4vptNTxB
         rk6IyLEpbkRTLPS4i0ao4CDe2CTjWruus/YlakwsXkUXGzXq6sPDBCht+/5zwTp/6WoC
         XAGA==
X-Gm-Message-State: AOAM5332yW/vYUqEGkpMDs8eF1nEQIOhFfap6VdwYO29mERy2nqwFHhc
        5oADgYvB9MTUU+GbtPmAeci+Rc4zcg==
X-Google-Smtp-Source: ABdhPJyoBKasYwdPkcRM0oXkIFbAFu8rLDbgOxLb70XfaanV3mLv9+KS1U8DoHPC1MmI3hJBGaXaXg==
X-Received: by 2002:a65:45cc:0:b0:3a1:d67a:4fb8 with SMTP id m12-20020a6545cc000000b003a1d67a4fb8mr19492764pgr.543.1650463545479;
        Wed, 20 Apr 2022 07:05:45 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:45 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/9] irq/irqdesc: change the name of delete_irq_desc() to irq_delete_desc()
Date:   Wed, 20 Apr 2022 22:05:14 +0800
Message-Id: <20220420140521.45361-3-kernelfans@gmail.com>
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

Make the naming convention consistent with irq_insert_desc(),
irq_to_desc().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 8d0982233277..9feedaa08430 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -355,7 +355,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-static void delete_irq_desc(unsigned int irq)
+static void irq_delete_desc(unsigned int irq)
 {
 	radix_tree_delete(&irq_desc_tree, irq);
 }
@@ -453,7 +453,7 @@ static void free_desc(unsigned int irq)
 	 * irq_sysfs_init() as well.
 	 */
 	irq_sysfs_del(desc);
-	delete_irq_desc(irq);
+	irq_delete_desc(irq);
 
 	/*
 	 * We free the descriptor, masks and stat fields via RCU. That
-- 
2.31.1

