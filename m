Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D0508A09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379329AbiDTOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379314AbiDTOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F93E0E2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j8so1837438pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQPhbY+LxZLej2JSRwshiiNk4MKgpm0s/70/5SE/Spw=;
        b=BeznbCe320Iwc28CPWiQKfI6oFePospyKcwGywCHWnFSddTpMFekmYVGIUo5xODNL4
         eKIQyXaEuaMz4suKWnDAmWuAGp/TAArKty/wtGqd2RX6OJuryeh5didBpgXMjGjiC+Uo
         TWfT4omujCztsxLAIsr8bJdQemveNhF7U9fyQJZcToIxZfDDDZaVtwvT/ZlNq/sQg7cA
         6e9OTdX+gmNJJlGJY3YhhcnwwjkkzmESWdoPj0VpCCTlt1UafYTmKJ8p3h/jsIeMIHze
         g4z+l29ROVu3rl8J2LMQ0xGMlPGkv379qNbUhkpDFavtRR6NuFLgs5v+RXmsW3W7NmPe
         48qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQPhbY+LxZLej2JSRwshiiNk4MKgpm0s/70/5SE/Spw=;
        b=NGyxUxSJU/eVZJbHqe+cZZa4Yo8cOAZS/ppPlREKrnmRoYvnG/v1KKyYwPaMDtiDF5
         6wFP8ymuYjU2ZRC/ivlIr6RNgKbiY9C+4XG0q/a1r5pLmB1Tz58Byy2mxKNxF1rA0Ss7
         FgLbr21oWV8BOBvwZbZg/c+/3eyZhxpnXNDIdiE+DOj8Mgs7zqmPjGcOTNF7En0Zy7ki
         5/67Zp0/87MdAA6OgTDanY/G/7aChaRNthhR/Aya7bzSw65iL4dFvvRsSGxcDuN9odo5
         1UzRNX/fB/Yavq8wwP2phnBClAxi+CjsCVxAmDwnAFOKdWCxmS+//KpaHijUn6Fc0PbZ
         +JaA==
X-Gm-Message-State: AOAM532yJU2Q9g/0l/I0jDG5KMS4ZzjJs1A3GzYFKSndVQFWry9EN8Zc
        7ONZwHLuoUuw7D18+17hzg==
X-Google-Smtp-Source: ABdhPJzeBkW3f0H9B2QpGGlxphhGMhWdnwiBvidcfwjRhxfxPxp8jQe7B+tCT/0j6S+aAfNzeJhwsA==
X-Received: by 2002:a17:90b:1e10:b0:1ce:8478:ea09 with SMTP id pg16-20020a17090b1e1000b001ce8478ea09mr4767019pjb.134.1650463559607;
        Wed, 20 Apr 2022 07:05:59 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:59 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] x86/irq: place for_each_active_irq() in rcu read section
Date:   Wed, 20 Apr 2022 22:05:17 +0800
Message-Id: <20220420140521.45361-6-kernelfans@gmail.com>
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

Since there are access to irq_desc, and no preemption is provided at the
involved, it requires rcu read lock to protect irq_desc.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
To: x86@kernel.org
---
 arch/x86/kernel/apic/io_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c1bb384935b0..4bb16edcbe4d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1333,6 +1333,7 @@ void __init print_IO_APICs(void)
 		print_IO_APIC(ioapic_idx);
 
 	printk(KERN_DEBUG "IRQ to pin mappings:\n");
+	rcu_read_lock();
 	for_each_active_irq(irq) {
 		struct irq_pin_list *entry;
 		struct irq_chip *chip;
@@ -1352,6 +1353,7 @@ void __init print_IO_APICs(void)
 			pr_cont("-> %d:%d", entry->apic, entry->pin);
 		pr_cont("\n");
 	}
+	rcu_read_unlock();
 
 	printk(KERN_INFO ".................................... done.\n");
 }
@@ -2009,6 +2011,7 @@ static inline void init_IO_APIC_traps(void)
 	struct irq_cfg *cfg;
 	unsigned int irq;
 
+	/* The early boot stage is free of irq_desc release */
 	for_each_active_irq(irq) {
 		cfg = irq_cfg(irq);
 		if (IO_APIC_IRQ(irq) && cfg && !cfg->vector) {
-- 
2.31.1

