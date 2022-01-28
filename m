Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24D49F7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbiA1LHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiA1LHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:07:39 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26DAC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:07:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d8so5495021qvv.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULUrk69qcn5bFl97vvUutVoUrX8FjA4cU31+0l28hP8=;
        b=FkiXUUAgcFlHY/JxnQ6/MF78iwkckry2PHyEBLMTKbEjgAR9gNRMs6WAlql3SJLAhR
         tsO8a93ubTq7TVALLxtDG1z0t2tFrRycUjtjXWcIy2dfEiEp2ISTtXcH5WJor0XRxdH+
         PLtaPsSYVIDcaFRc7+vEw0czyOrYDE9etr8fN66XOStiPTpjElgdC2K5dEqG81mwJe6e
         Hnfv7cXybS7rBsYClippB7nGiXsV41fecopHNQ1M1nWKAHGhGci0mLginqXUPAzurhqY
         sOke047xjymDRXYu+VXkhypj22zDS5qFFrfXlyO1CeDBgr7SK0jqRtemmG1F7842IfQY
         9b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULUrk69qcn5bFl97vvUutVoUrX8FjA4cU31+0l28hP8=;
        b=hMe2iszgU1sWg2UvBzjRd3hDj8mvP3S8jKR4t3pi5zkkMRT8ZA0mXaLCovqqe8154J
         KAzXYQYPvnXU0eo8fCal9gm5RWkcSYTdPQNql+BgKwUerV8ENqJTrq1Svj9NGADJAjUw
         RqSldYCJEQ1ziideNv3KmX9CNhhU2MRWwo/R7sGbyhiHiGrewS6pvL5UfVbZmjOcmqgT
         Nce8JK5RaCu+6TTjax14fAu7Og75+ZWaMcGddjYSJjfEL0nlVEgpz8f4zfEguiOVWlMd
         E3YPJIIDN9QMG6K1pkc7dpjd0d5W4B7a7syWx22o0t2As0DNBlKTHoN/U1i0lP6zXI+O
         j18Q==
X-Gm-Message-State: AOAM530xzzMXPGQ7XX0ZhDQ2IAOeFdfHtsxiC3GYY7SvPS0svv67NPXz
        TNfvzPsFmw9hPiQYnuQ9LuM=
X-Google-Smtp-Source: ABdhPJzT8zpjKW5X0jkQnrOh4ThPKeSPA2ufw5DOwMIz/g4gY4oJHm92pDB35pXFm3IpkAbJ9mBZqg==
X-Received: by 2002:ad4:5ca5:: with SMTP id q5mr6334667qvh.105.1643368058049;
        Fri, 28 Jan 2022 03:07:38 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id s4sm3173608qko.113.2022.01.28.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:07:37 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [LAST RESEND PATCH] irq: in_irq() cleanup
Date:   Fri, 28 Jan 2022 19:07:27 +0800
Message-Id: <20220128110727.5110-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/irq/irqdesc.c |  4 ++--
 kernel/softirq.c     | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e6527db3..6167d32e27da 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -640,7 +640,7 @@ int handle_irq_desc(struct irq_desc *desc)
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
 		return -EPERM;
 
 	generic_handle_irq_desc(desc);
@@ -676,7 +676,7 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
-	WARN_ON_ONCE(!in_irq());
+	WARN_ON_ONCE(!in_hardirq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..fac801815554 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -222,7 +222,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	u32 pending;
 	int curcnt;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
 	local_irq_save(flags);
@@ -305,7 +305,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 
 	raw_local_irq_save(flags);
 	/*
@@ -352,14 +352,14 @@ static void __local_bh_enable(unsigned int cnt)
  */
 void _local_bh_enable(void)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
 }
 EXPORT_SYMBOL(_local_bh_enable);
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
@@ -618,7 +618,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_irq())
+		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
 #endif
-- 
2.32.0

