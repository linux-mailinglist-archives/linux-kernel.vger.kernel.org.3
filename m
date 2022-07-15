Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE37575B58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGOGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGOGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:12:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77F73907
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31d436816e1so33745347b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+9RN60EOV8842FFgmBAy6PrpfwWqW7C+czhzeS/rR4=;
        b=YBfbYLBhEFURhCK4QKUC8bI/R6G7EXpPYpXv8EgvXFE5JI8iCfdDD/zhxXUPJ1FCj2
         HobAgwdJcz8iCJZ3Nf6qUn5/JFvFqTXwTbxs1Vp8JQ5DiIGMNOmoxWd8ZFtzh4zWdbW2
         UXXqKfjRvUH0FaeGEFgQrLpiSfFzw/8JrEAdOPLimA7QNNMLXVfCXV7aWgjExnRC71PE
         st+L76+Nt2+hlQM0Y7sQ2cwdVY2C1xVk2yx3eg9khBifSFQMmA4ZOR9Djwd7LeLopeWE
         xiMe9XRODecY4NQkbUkZ8/WtMreqsn6dA6vGRjB7aYLob2bWXnsgyxD5ML6TZoiDhcWj
         CuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+9RN60EOV8842FFgmBAy6PrpfwWqW7C+czhzeS/rR4=;
        b=bXpU0Rs/Dsi8K2EzZeD3uz0j1Yb3fJUeImAi0pXTI0wn3ID9C20e5NeaLhl2vxxMcv
         rumQK8NesuNwsmlWB1KX0U/mOyvTnVQA+lKHTEc5Bf1sgDxEIFo3H1RKv9LNF2nkDtcT
         +d/ViKdmsrOpVOaiQbd6Sc6SqatahYgAGkfBdlYwnc5lR5h3UefbkNTIyxY0OgMhv3/5
         1HruJ9aiTSQ1nupqsXP9cr4f22yHjOVaQmrI1kz2g+oizLXNvLQk+sXuPWLn7nzh4QIK
         TSpmy2Exb5dyIPW/puvxrzkPnX8ZcP9reYroAOq5dZJsLe8mUC6sutDbj57IgTDAGBQI
         ZnFA==
X-Gm-Message-State: AJIora/Nm9Ep2+h4pzSEwKgWpIZaQzamcrNGjO9JQLFXuGJ4LADr4qhV
        YsOXlYRp0ea71wcrMulPxBTRwAIedyOtjO+sVg==
X-Google-Smtp-Source: AGRyM1vmpZrg9C65GGAVW8i3cJzkzgqCICriOC0RsFfWEe5JJODK8w4KS6U/1MhBLlAvC1UTH/ak2+fLI6MXcu3Qzw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:44d:0:b0:66f:ad5a:9d0b with SMTP
 id s13-20020a5b044d000000b0066fad5a9d0bmr10986561ybp.79.1657865509675; Thu,
 14 Jul 2022 23:11:49 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:27 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-19-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 18/18] KVM: arm64: Dump nVHE hypervisor stack on panic
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hyp_panic(), unwind and dump the nVHE hypervisor stack trace.
In protected nVHE mode, hypervisor stacktraces are only produced
if CONFIG_PROTECTED_NVHE_STACKTRACE is enabled.

Example backtrace:

[  126.862960] kvm [371]: nVHE hyp panic at: [<ffff8000090a51d0>] __kvm_nvhe_recursive_death+0x10/0x34!
[  126.869920] kvm [371]: Protected nVHE HYP call trace:
[  126.870528] kvm [371]:  [<ffff8000090a5570>] __kvm_nvhe_hyp_panic+0xac/0xf8
[  126.871342] kvm [371]:  [<ffff8000090a55cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
[  126.872174] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.872971] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
. . .
[  126.927314] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.927727] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  126.928137] kvm [371]:  [<ffff8000090a4de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
[  126.928561] kvm [371]:  [<ffff8000090a7b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
[  126.928984] kvm [371]:  [<ffff8000090a78b8>] __kvm_nvhe_handle_trap+0xc4/0x128
[  126.929385] kvm [371]:  [<ffff8000090a6864>] __kvm_nvhe___host_exit+0x64/0x64
[  126.929804] kvm [371]: ---- End of Protected nVHE HYP call trace ----

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/handle_exit.c     | 4 ++++
 arch/arm64/kvm/hyp/nvhe/switch.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index f66c0142b335..ef8b57953aa2 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace/nvhe.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -353,6 +354,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 				(void *)panic_addr);
 	}
 
+	/* Dump the nVHE hypervisor backtrace */
+	kvm_nvhe_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6db801db8f27..a50cfd39dedb 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -25,6 +25,7 @@
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
+#include <asm/stacktrace/nvhe.h>
 
 #include <nvhe/fixed_config.h>
 #include <nvhe/mem_protect.h>
@@ -375,6 +376,10 @@ asmlinkage void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
 
+	/* Prepare to dump kvm nvhe hyp stacktrace */
+	kvm_nvhe_prepare_backtrace((unsigned long)__builtin_frame_address(0),
+				   _THIS_IP_);
+
 	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
-- 
2.37.0.170.g444d1eabd0-goog

