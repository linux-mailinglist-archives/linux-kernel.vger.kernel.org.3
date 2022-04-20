Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA12508A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379345AbiDTOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379326AbiDTOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:09:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14443AC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so2032441pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kekJI/xbhVTaB0kWCa/VXYzAzzmU1o9FoYB/mXUI7s=;
        b=oYwbEOQe3RG3YD7tEJ1vNhordyA4jyaj/hIJyCJXfkscClBDkhAXoZoRX3OE99jkZe
         FXNJKnEfJnNhV9NTJLLrtERwb3ZnZ+hRb/wqE/nj1wLZu4nMVn/8swXpSvjjN3Jrw5P5
         57khmj4petaztDIt1vvOYdk7XDOJKbRNJIH3KXdOFCsq6vnF8bWZL2pjJvti1FBAJglF
         fRBa1MY9kVlsfrUrWrdDnr/j3CZSKITATHWub2ShsXclVUubtEEf/QZxsSQ2rCE0CcFv
         0rkk38WAvR+kGTLonyzHgSi1Svzn8PVnrSVZgl2cqXag1V0lbS6Qt8Ny+Uap5YIuQJ/L
         ir8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kekJI/xbhVTaB0kWCa/VXYzAzzmU1o9FoYB/mXUI7s=;
        b=L5lPqq2d6w2Cbdm0edmnQOQBZjJvk2URdu7LJqf1IpPyq2Q7Vh0FJHa+1Em7GVCE6d
         qSe5HPCfOcHxzOW8BxKEzB1RMdlL6aFmO0yzyhKS3LtdBiBKFKSNpbHrXWrls4THUCel
         IR64epNUzObiyO1ul4LzcH/LZ2M+fP41KSSkQIrj2Cpla1JdMHkmf0uzh77d8gA8eM0X
         1MOQh8Tx1i7YVocw9h7VvhjjDmSJAryj86PeVEjAW9KnFjxW5o7odcDrAGN5GpYwXhSD
         bPPyAbLDAQmi8pAVHuU0vWskzUxg5c+iWi30qhbnlUfWAA2RDLDBe70ZVYmRzJLc3xvV
         X2gg==
X-Gm-Message-State: AOAM531UnLUqM9aWPEeh0laIZu5dnoCmxQeCSW90tBWgKyU3FCeEWI0D
        e/Aa4WHp94IknUqSPuhgGDw/iqzWhA==
X-Google-Smtp-Source: ABdhPJzDeaoK+nUWkm2wsgxu8+uqir0BvHca0X3kMC/cLo9ATnXiu06q4nx0CSdeyWcy2X7HYpAnsw==
X-Received: by 2002:a05:6a00:14cb:b0:50a:7e08:e1fc with SMTP id w11-20020a056a0014cb00b0050a7e08e1fcmr14317925pfu.12.1650463577110;
        Wed, 20 Apr 2022 07:06:17 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:06:16 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 9/9] irq/irqdesc: rename sparse_irq_lock to bitmap_lock
Date:   Wed, 20 Apr 2022 22:05:21 +0800
Message-Id: <20220420140521.45361-10-kernelfans@gmail.com>
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

Now that sparse_irq_lock serves for both sparse and non-sparse purpose,
it is better to rename it as bitmap_lock. Corresponding, rename
irq_lock_sparse() as irq_lock_bitmap().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Steven Price <steven.price@arm.com>
To: linux-kernel@vger.kernel.org
---
 include/linux/irqdesc.h |  4 ++--
 kernel/cpu.c            |  4 ++--
 kernel/irq/cpuhotplug.c |  4 ++--
 kernel/irq/debugfs.c    |  4 ++--
 kernel/irq/irqdesc.c    | 26 +++++++++++++-------------
 kernel/irq/pm.c         |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 6c01231fec00..8301653fc2b2 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -104,8 +104,8 @@ struct irq_desc {
 	const char		*name;
 } ____cacheline_internodealigned_in_smp;
 
-extern void irq_lock_sparse(void);
-extern void irq_unlock_sparse(void);
+extern void irq_lock_bitmap(void);
+extern void irq_unlock_bitmap(void);
 
 #ifndef CONFIG_SPARSE_IRQ
 extern struct irq_desc irq_desc[NR_IRQS];
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 94a6b512c26d..8874f0242893 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -601,11 +601,11 @@ static int bringup_cpu(unsigned int cpu)
 	 * setup the vector space for the cpu which comes online.
 	 * Prevent irq alloc/free across the bringup.
 	 */
-	irq_lock_sparse();
+	irq_lock_bitmap();
 
 	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu, idle);
-	irq_unlock_sparse();
+	irq_unlock_bitmap();
 	if (ret)
 		return ret;
 	return bringup_wait_for_ap(cpu);
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..84547b5781be 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -220,14 +220,14 @@ int irq_affinity_online_cpu(unsigned int cpu)
 	struct irq_desc *desc;
 	unsigned int irq;
 
-	irq_lock_sparse();
+	irq_lock_bitmap();
 	for_each_active_irq(irq) {
 		desc = irq_to_desc(irq);
 		raw_spin_lock_irq(&desc->lock);
 		irq_restore_affinity_of_irq(desc, cpu);
 		raw_spin_unlock_irq(&desc->lock);
 	}
-	irq_unlock_sparse();
+	irq_unlock_bitmap();
 
 	return 0;
 }
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 2b43f5f5033d..af4bd2ca2372 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -251,10 +251,10 @@ static int __init irq_debugfs_init(void)
 
 	irq_dir = debugfs_create_dir("irqs", root_dir);
 
-	irq_lock_sparse();
+	irq_lock_bitmap();
 	for_each_active_irq(irq)
 		irq_add_debugfs_entry(irq, irq_to_desc(irq));
-	irq_unlock_sparse();
+	irq_unlock_bitmap();
 
 	return 0;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a5cefd7c9ef7..acd80cb8a511 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -130,7 +130,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
-static DEFINE_MUTEX(sparse_irq_lock);
+static DEFINE_MUTEX(bitmap_lock);
 static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
 
 #ifdef CONFIG_SPARSE_IRQ
@@ -318,12 +318,12 @@ static int __init irq_sysfs_init(void)
 	}
 
 	/* Prevent concurrent irq alloc/free */
-	irq_lock_sparse();
+	irq_lock_bitmap();
 
 	/* Add the already allocated interrupts */
 	for_each_irq_desc(irq, desc)
 		irq_sysfs_add(irq, desc);
-	irq_unlock_sparse();
+	irq_unlock_bitmap();
 
 	return 0;
 }
@@ -607,9 +607,9 @@ static int irq_expand_nr_irqs(unsigned int nr)
 
 void irq_mark_irq(unsigned int irq)
 {
-	mutex_lock(&sparse_irq_lock);
+	mutex_lock(&bitmap_lock);
 	bitmap_set(allocated_irqs, irq, 1);
-	mutex_unlock(&sparse_irq_lock);
+	mutex_unlock(&bitmap_lock);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
@@ -711,14 +711,14 @@ int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
 }
 #endif
 
-void irq_lock_sparse(void)
+void irq_lock_bitmap(void)
 {
-	mutex_lock(&sparse_irq_lock);
+	mutex_lock(&bitmap_lock);
 }
 
-void irq_unlock_sparse(void)
+void irq_unlock_bitmap(void)
 {
-	mutex_unlock(&sparse_irq_lock);
+	mutex_unlock(&bitmap_lock);
 }
 
 /* Dynamic interrupt handling */
@@ -735,12 +735,12 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	if (from >= nr_irqs || (from + cnt) > nr_irqs)
 		return;
 
-	mutex_lock(&sparse_irq_lock);
+	mutex_lock(&bitmap_lock);
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
 
 	bitmap_clear(allocated_irqs, from, cnt);
-	mutex_unlock(&sparse_irq_lock);
+	mutex_unlock(&bitmap_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
 
@@ -779,7 +779,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		from = arch_dynirq_lower_bound(from);
 	}
 
-	mutex_lock(&sparse_irq_lock);
+	mutex_lock(&bitmap_lock);
 
 	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
 					   from, cnt, 0);
@@ -794,7 +794,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 	}
 	ret = alloc_descs(start, cnt, node, affinity, owner);
 unlock:
-	mutex_unlock(&sparse_irq_lock);
+	mutex_unlock(&bitmap_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 4b67a4c7de3c..9b81a738d84f 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -133,7 +133,7 @@ void suspend_device_irqs(void)
 	struct irq_desc *desc;
 	int irq;
 
-	irq_lock_sparse();
+	irq_lock_bitmap();
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool sync;
@@ -147,7 +147,7 @@ void suspend_device_irqs(void)
 		if (sync)
 			synchronize_irq(irq);
 	}
-	irq_unlock_sparse();
+	irq_unlock_bitmap();
 }
 EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
-- 
2.31.1

