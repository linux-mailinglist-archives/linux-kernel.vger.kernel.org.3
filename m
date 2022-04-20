Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C80508A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379336AbiDTOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379344AbiDTOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:09:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62325434A8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so2031424pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYIjb5ot+DXDq9R/lT/ZSWg8BN/TKlauVlu3GfZ3FtU=;
        b=JhHDW8jR8pb/E7zcpG1BJ2se2nBWyC7Vs20lwwcBreD3VwgOeCufaHmaRAejXrBW5J
         Vzd76qLCSqwltDscmS0OgjQRq2pwTtI5B/tKldbPuF8gDOuTQkt2z428uDqjxJQlSLEt
         SytP5+2cgL4JsQLr4j0d5upl1Z5hZQXVHzMxixlBVp5OtiMRegc5bzGEuyKHjW3FkbHM
         SCgfXr3qizY4OCvAyZG2kMXzI5TdKyP00exqWkvzfhl2Ho5x7/JmAaN9tHLfZWGzpLZz
         7ZSK5m7HyUHxcvzT6fmeIbJYKNhUhkyPGbAEjRH9+vy0oD0OIP381CWcH9vDHav0F5MM
         azlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYIjb5ot+DXDq9R/lT/ZSWg8BN/TKlauVlu3GfZ3FtU=;
        b=EKXxXl8cEg8Zc5mPTgYTqA/T3f0+rL1NgRbI0RKopnm3HYkxOjsfieg9rb58Ki2qrH
         FuDuxjcTrVBU1SdnYmm1ea+hJvUOUgpcTRATlP0q7aNahXllAN5eVaB+m8YObORohzJY
         fwLrHCTay+7mauHZXgTElhap/29FKzdYbVMDuho1ObVCtGNcbyPzzfs4GrMjsESWONRG
         ayV30NtazMk4HITLuyJXNSNkxamK6GBt70FvfS/Pa96sitJ+OGdf0P8BbxFP14WGLaeC
         wzuMC8SflrcgUB7isEJ/Bw5zu0qDe5x2Me1s2hPcSNWkl/48+qnoQCm4nwSG+Ex2/Qe4
         Si2A==
X-Gm-Message-State: AOAM531bGLANForhLZrJojjmRSPvwmpXOf5Q7tQoK0ADQCGoPN6NbsOE
        zPI3RkSKnL65N6HVqAJ17EqcwKQ8HQ==
X-Google-Smtp-Source: ABdhPJydWnvw9m8G76gSA2HdRV81U86tAJT4NmiNua8Scd1Geyi2peAIuvgVJ80DGKPw78JlWXxXjg==
X-Received: by 2002:a17:902:ca04:b0:158:eab9:2676 with SMTP id w4-20020a170902ca0400b00158eab92676mr19594831pld.1.1650463571694;
        Wed, 20 Apr 2022 07:06:11 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:06:11 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 8/9] irq: make irq_lock_sparse() independent of CONFIG_SPARSE_IRQ
Date:   Wed, 20 Apr 2022 22:05:20 +0800
Message-Id: <20220420140521.45361-9-kernelfans@gmail.com>
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

Even in the case of non-sparse irq, the callsite of
for_each_active_irq() in irq_debugfs_init() still cares about the sync
of allocated_irqs bitmap. Otherwise irq_debugfs_init() may show some
disappeared irq if the irq is disactived by other driver in parallel.

As there are only a few callsites of irq_lock_sparse() in the cold path,
which means the slight performance drops can be ignored.  Hence moving
irq_lock_sparse() out of CONFIG_SPARSE_IRQ to protect both irq_desc and
allocated_irqs bitmap, instead of making irq_lock_sparse() dependent on
GENERIC_IRQ_DEBUGFS.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/irqdesc.h |  6 ++----
 kernel/irq/irqdesc.c    | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a77584593f7d..6c01231fec00 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -104,12 +104,10 @@ struct irq_desc {
 	const char		*name;
 } ____cacheline_internodealigned_in_smp;
 
-#ifdef CONFIG_SPARSE_IRQ
 extern void irq_lock_sparse(void);
 extern void irq_unlock_sparse(void);
-#else
-static inline void irq_lock_sparse(void) { }
-static inline void irq_unlock_sparse(void) { }
+
+#ifndef CONFIG_SPARSE_IRQ
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 9feedaa08430..a5cefd7c9ef7 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -375,16 +375,6 @@ static void free_masks(struct irq_desc *desc)
 static inline void free_masks(struct irq_desc *desc) { }
 #endif
 
-void irq_lock_sparse(void)
-{
-	mutex_lock(&sparse_irq_lock);
-}
-
-void irq_unlock_sparse(void)
-{
-	mutex_unlock(&sparse_irq_lock);
-}
-
 static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 				   const struct cpumask *affinity,
 				   struct module *owner)
@@ -721,6 +711,16 @@ int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
 }
 #endif
 
+void irq_lock_sparse(void)
+{
+	mutex_lock(&sparse_irq_lock);
+}
+
+void irq_unlock_sparse(void)
+{
+	mutex_unlock(&sparse_irq_lock);
+}
+
 /* Dynamic interrupt handling */
 
 /**
-- 
2.31.1

