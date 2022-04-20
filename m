Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67F2508A04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbiDTOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379305AbiDTOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EEB3E0E2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 2so2047012pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWmKOaGrL4CkXTbn+/gnRNrWxLM3MTWpbfZSE/ojIP0=;
        b=HAd6plBINYnhg2F8X9HhGuothi7z1ne/yZzTMlHKYjkdaWIrDHLx4/5/Y/vxi+7SjA
         C0Y72m+k54ysFoJ5W8mXLzDwxWVre70Gz1oWyRdf7iIs+rCNOEw1m5gDG86bKnMRNCW0
         dJPzLwkQnb4Xo2NgrRoCXS9vGOkXm1qOKototZekHmh7XrYTfq5TdW7/vOeSnqUr8WbN
         HgQIy4tasBqj4hLLt7VuJ28N3AShkbL5CBmkpNkAdpZue1AZRrox3c0h2AhfUyT9yPLH
         NxFJHS04oSg4wcrfAemjxl5sUTod8b2Fi17TFdAjn+z8JjaKDo/hMz4inFdbjYc67xSi
         9OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWmKOaGrL4CkXTbn+/gnRNrWxLM3MTWpbfZSE/ojIP0=;
        b=8Pc8u3sAsxOmOtCEDRqhhUNSj1DS9qMXikpFy5CmdHjavgJ1D2TnmWkIEoWdixl9bj
         yk+agPqJiMdjijutaxeyXBt3fCMt4yNnX7mjQ0SaAW62oyzIdX2IEfszrdEOetGIuzDX
         8H+P/ApKPnHSLICSDmvRlNTbv2UCIIjWcyO75ZWpSPu2Nq2Un/nSXBpcIpoBoiZLGWkc
         UuLIZNsVnlQo9MDfR1tdNsR+6LY883PMARHpuNdhMSMxsDH0W9mrpk23Ffw/32XBxuzv
         9L8G+AG7DLQMEa8Da0UZU03/39rQlXoDGNlRRkT027xAGpAFTrLIsuJGyc+MLmq1JHb4
         JuMg==
X-Gm-Message-State: AOAM531LmnOGdSUBMDGWDmyCog4we0fkaRI8MYebOhvBuyVCCqPXRN+9
        RsNKYaPWZFkGzFUgJ9XZN496kChgOQ==
X-Google-Smtp-Source: ABdhPJzChSy8JAIY69iH9HCa51J/cbJAnLUy4snMN4xAUfj9A3B5ViECqiidkpa8jrcoVr+s+i7Nlw==
X-Received: by 2002:a17:90b:3c47:b0:1cb:8121:dcc8 with SMTP id pm7-20020a17090b3c4700b001cb8121dcc8mr4715374pjb.35.1650463550963;
        Wed, 20 Apr 2022 07:05:50 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:05:50 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        llvm@lists.linux.dev
Subject: [PATCH 3/9] irq/manage: remove some unreferenced code
Date:   Wed, 20 Apr 2022 22:05:15 +0800
Message-Id: <20220420140521.45361-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-1-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Neither remove_percpu_irq() nor for_each_irq_nr() has any users, so they
can be removed.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: llvm@lists.linux.dev
To: linux-kernel@vger.kernel.org
---
 .clang-format         |  1 -
 include/linux/irq.h   |  1 -
 include/linux/irqnr.h |  3 ---
 kernel/irq/manage.c   | 15 ---------------
 4 files changed, 20 deletions(-)

diff --git a/.clang-format b/.clang-format
index fa959436bcfd..fb161bc8ca1a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -198,7 +198,6 @@ ForEachMacros:
   - 'for_each_if'
   - 'for_each_iommu'
   - 'for_each_ip_tunnel_rcu'
-  - 'for_each_irq_nr'
   - 'for_each_link_codecs'
   - 'for_each_link_cpus'
   - 'for_each_link_platforms'
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788ccdba2..ec50007decfc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -603,7 +603,6 @@ enum {
 
 struct irqaction;
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
-extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
 #ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 extern void irq_cpu_online(void);
diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 3496baa0b07f..082fe0856e87 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -28,7 +28,4 @@ unsigned int irq_get_next_irq(unsigned int offset);
 	for (irq = irq_get_next_irq(0); irq < nr_irqs;	\
 	     irq = irq_get_next_irq(irq + 1))
 
-#define for_each_irq_nr(irq)                   \
-       for (irq = 0; irq < nr_irqs; irq++)
-
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..b7c86be68b58 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2466,21 +2466,6 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	return NULL;
 }
 
-/**
- *	remove_percpu_irq - free a per-cpu interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_percpu_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && irq_settings_is_per_cpu_devid(desc))
-	    __free_percpu_irq(irq, act->percpu_dev_id);
-}
-
 /**
  *	free_percpu_irq - free an interrupt allocated with request_percpu_irq
  *	@irq: Interrupt line to free
-- 
2.31.1

