Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E656A0DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiGGLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:06:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410A2F00D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:06:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z14so17898006pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+H04G+1sbEsT1Vwo2PzH8D8ql+BkczGA26aIjD53FM=;
        b=wKcGv2/iE3mQ3uPvTHSfbHT86kJLoiIOovbMVqqzibgJxuFd8xFcR+AfkN178EY2+6
         gmPO2Mcfp6YwjWvXzXuawAZ5q8BjVIPtn3nBAzg6qpn+c9Jsl4IbYnyTpRU9pzvJpdAu
         MWrxjt0LJa865lMD/Hw7x1DJLQdynnAJEuTHEYerCtJoIcHLFylDUNFUKHxQGdnNl5eW
         bgPoha6k0VIxHBIel2cCWSDy5rrlNrIk7FEbAe/6egFQUwjiEn8F41WxokvJ2miTZQeR
         5JkUAECOm/ReMHrRd9I0QsadMzvTwwyiZsFcj3t8d85+8B/tPO1Jj871YBKca12AbRYz
         Yhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+H04G+1sbEsT1Vwo2PzH8D8ql+BkczGA26aIjD53FM=;
        b=D2tGUa4/R5eJF5Vkca4xYrkvyW+7LpgytnaQd7ABKyS8RSzgVKy5Fu4g8Sg+2AC3w8
         AQDWCMIlvVF4I6Fqxu+7rPA6ATjf4YYpMYsqWKS3Yh9rsFIheOBCHbBSEl1RjkvGVQXd
         CssaS+PA4cvoouAnnMHew2Pt7190vkmd2TLrgkkkZgeXLKzTrf7DiB5RXa1l4WRMtnok
         84x/KbDl0eB0LJdjgZtIcT5ojYiGbNNV9t5MLxOjcojTC+GbwCc164Q7kaheYekEHVNM
         yQGmdbCHHR2fPBFSznku31LXZ3ArmrSVq4LxWJXjmR5klHKz2FCzlCpkOJUJu0O0Y7A4
         F3bg==
X-Gm-Message-State: AJIora9f0jE3oJbDAPMOQfYE5UTuchuJdqMjttHa3cYM17FslfNaGth+
        MBN794XD5bhdvF6oSBLdUZ8u3g==
X-Google-Smtp-Source: AGRyM1sIs8s4JT9g0SLi5t7N5/jxpFkC9Z8kSZSVHpD9q8G3jgH3az1rsxc2BtZf69utGx2dmcj5MA==
X-Received: by 2002:a17:90b:4b41:b0:1ec:cb06:2fa3 with SMTP id mi1-20020a17090b4b4100b001eccb062fa3mr4369801pjb.55.1657191960365;
        Thu, 07 Jul 2022 04:06:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b005289a50e4c2sm1046403pfx.23.2022.07.07.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:05:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 1/2] arm64: run softirqs on the per-CPU IRQ stack
Date:   Thu,  7 Jul 2022 19:05:10 +0800
Message-Id: <20220707110511.52129-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently arm64 supports per-CPU IRQ stack, but softirqs
are still handled in the task context.

Since any call to local_bh_enable() at any level in the task's
call stack may trigger a softirq processing run, which could
potentially cause a task stack overflow if the combined stack
footprints exceed the stack's size, let's run these softirqs
on the IRQ stack as well.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/irq.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3491d0d99891..402e16fec02a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -230,6 +230,7 @@ config ARM64
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..e6aa37672fd4 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
+#include <asm/exception.h>
 
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
@@ -71,6 +72,16 @@ static void init_irq_stacks(void)
 }
 #endif
 
+static void ____do_softirq(struct pt_regs *regs)
+{
+	__do_softirq();
+}
+
+void do_softirq_own_stack(void)
+{
+	call_on_irq_stack(NULL, ____do_softirq);
+}
+
 static void default_handle_irq(struct pt_regs *regs)
 {
 	panic("IRQ taken without a root IRQ handler\n");
-- 
2.20.1

