Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88C471FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhLMEWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhLMEWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:22:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D0C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u80so13818592pfc.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 20:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hc37yVx4b3sSyB7F9HIij1MIdsw+3eTqd5pJUwPWDA=;
        b=GZ2wXTZQc6dPO7fg2/OOkUco8Uzp/P8uEegXpceqTq0MArY/U0mknOXpsXZu2qh7Ef
         NseujPsgTeGgzNTn6D3oyq8NFAk9ktZPlM89bSETFq2N0ioXKSP9TDgvs5Okf+pAvWu9
         2iQJkIkLf9q6vFpKx5Ykkx6+hwseCIM1yChJ22xPe3xsRV5ImpQR2chxNAFzKIuB1/ts
         OyYQbx8anu3+EsNaHbwcjirB5IWwpaYQ5KW9eKhqaN7CaVEAZL0D6LVa82fnlA4eHd/E
         AEK2CAFm3XnsAZQEKZlyEL5NbQgMXlA54RSusPTeQcfQefSSWYAFTPA6DW5Hg1aQnflA
         2IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hc37yVx4b3sSyB7F9HIij1MIdsw+3eTqd5pJUwPWDA=;
        b=qbr5X9ERvaqIA19PM3DrTA+ffzpjW9SoCnoPqy96AwxBMcmS2xnVXa4iZHairVkTHH
         i4B1QlSlltIhWT9iMGZa7BYblcED9bH9wEKIi+0uHqqrgOzbvfi21HU/H5ZE/TD6l3Qn
         tMlsYn5Z+dupwEndj9dySMicrugtkESL7EXBQ7GHvAGLYrZoLzwsp+XRQp6jVqjt17+u
         x5NODeklLGDd9dvtRoN+B5FtvdqU3DxRP8R5uGpzNiMNMT3DdYMB5MWlpd/liDNV1Vl4
         xBwC8BFVK3IiEQT1PIEtvaxidBV/fvkwujhRy5G7pT5WJ4VQMMUPh0PV6E23NAmg02jA
         T0Bg==
X-Gm-Message-State: AOAM530ZFuYH7NnfE3qtkXIeFTWnN9e05A6SuQ8GkbrJmdSDPMhMZymB
        bLriiPgEqQOTFUoyKIesKoBdLfyIZ3SulA==
X-Google-Smtp-Source: ABdhPJwsZi6J9kwwvIur8TGZ2I9sK60sPlQu7YwqD5snPQiaYoeX+vlyxOcdPrLp+cs0opeRBTNtjg==
X-Received: by 2002:a05:6a00:bcd:b0:4b0:62ef:c6af with SMTP id x13-20020a056a000bcd00b004b062efc6afmr21850382pfu.39.1639369354741;
        Sun, 12 Dec 2021 20:22:34 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id h1sm10387529pfi.217.2021.12.12.20.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 20:22:34 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/3] x86/sev: The code for returning to user space is also in syscall gap
Date:   Mon, 13 Dec 2021 12:22:15 +0800
Message-Id: <20211213042215.3096-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213042215.3096-1-jiangshanlai@gmail.com>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When returning to user space, the %rsp is user controlled value.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        | 2 ++
 arch/x86/entry/entry_64_compat.S | 2 ++
 arch/x86/include/asm/proto.h     | 4 ++++
 arch/x86/include/asm/ptrace.h    | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e23319ad3f42..44dadea935f7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -213,8 +213,10 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
+SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
 	swapgs
 	sysretq
+SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..98afdf92f360 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -293,6 +293,7 @@ sysret32_from_system_call:
 	 * code.  We zero R8-R10 to avoid info leaks.
          */
 	movq	RSP-ORIG_RAX(%rsp), %rsp
+SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 
 	/*
 	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
@@ -310,6 +311,7 @@ sysret32_from_system_call:
 	xorl	%r10d, %r10d
 	swapgs
 	sysretl
+SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d44d04..f042cfc9938f 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -13,6 +13,8 @@ void syscall_init(void);
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
+void entry_SYSRETQ_unsafe_stack(void);
+void entry_SYSRETQ_end(void);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
@@ -28,6 +30,8 @@ void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
 void entry_SYSCALL_compat_safe_stack(void);
+void entry_SYSRETL_compat_unsafe_stack(void);
+void entry_SYSRETL_compat_end(void);
 void entry_INT80_compat(void);
 #ifdef CONFIG_XEN_PV
 void xen_entry_INT80_compat(void);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 703663175a5a..b3d2ba13cee2 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -186,9 +186,13 @@ static __always_inline bool ip_within_syscall_gap(struct pt_regs *regs)
 	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
 		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
 
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETQ_unsafe_stack &&
+		      regs->ip <  (unsigned long)entry_SYSRETQ_end);
 #ifdef CONFIG_IA32_EMULATION
 	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_compat &&
 		      regs->ip <  (unsigned long)entry_SYSCALL_compat_safe_stack);
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSRETL_compat_unsafe_stack &&
+		      regs->ip <  (unsigned long)entry_SYSRETL_compat_end);
 #endif
 
 	return ret;
-- 
2.19.1.6.gb485710b

