Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5114671A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350521AbhLCFco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhLCFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:32:42 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808D5C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:29:19 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id n26so1837279pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 21:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=mWKjniVMdrBCu2ZfTvf1C9srZRA1gRSqS5jHnRsRf/I=;
        b=oDeRah12WrxLDM4zQEvjtSRB/BTJ2RmSNBPPbdB1K88F06sZA8vwEoIPFIeO0tJusb
         toe8ay5qxQfQZwGjUs/jfSEnUgYiU6hTWycQbdlntl1epkt2eTu5V+RycuNgGgLBsKfP
         c9VU32AjZAs5fqNsomzJEepOzF2qQPRdd6I8d1gwCoYYZyf01QLbqAXNBCo80QZd2R2Z
         TJCtXo3gtu1CBTca1rKqb/oXDlMnBWfHCMz+z2yb5Z0KwW4iRGbaIbqmIKha3aqoSZCU
         VmmMTiaFBv5cYfF/z64omCz+1wTrdfpXXZkz3QA9pEXngK5X8uT4BWdvAvAUhj0ocmTG
         pKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mWKjniVMdrBCu2ZfTvf1C9srZRA1gRSqS5jHnRsRf/I=;
        b=A19OD4Rb6uilf6PALfLxdDNPATkkE4vNGd1APV2VIHVIJmjk7m8xe1+LTtJNWCUZLR
         GFO2G0n1N965Br+R9zGScVqCvF/t4Zg22HaJF3q/gUET19WT9l/6eBSDn4htSj4K0EXP
         RusZt0gf0STIVB5OiVbOdqCV5O4q0/9Oke2OtlE13L8tZsG1kujSIEHEXLfLDfjkg/Oa
         xL+DUbT1VFl+j+8bE5lugT/+USeDlDf+j1mw9tEHctHYjLdpl1NVCkU6Gr4zldFPPLkz
         +5h0+Xeg/TvZ8nzWEy1HyjE9jI/dNaEK/xCVagp/oqtpkY8ZuWDpDNtSVzg4DY0YxBz/
         aquA==
X-Gm-Message-State: AOAM530bAr/oHTWIpocLAjeL7QQgzhQO6nlUz1tsblFF80HdMAyDduln
        qII8xRysl58Ow28t1EQ1J1THPjz0K8zE338PHgU=
X-Google-Smtp-Source: ABdhPJy3k4hFRYrM0cYmYs+BpbIkjVNWWs4Yqn0gl0JQyrdZ1VfOjaEz7zd+TiGL8HfndvmOR7r1Ng==
X-Received: by 2002:a63:f008:: with SMTP id k8mr2966109pgh.189.1638509358915;
        Thu, 02 Dec 2021 21:29:18 -0800 (PST)
Received: from local.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d2sm1563797pfu.203.2021.12.02.21.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 21:29:18 -0800 (PST)
From:   Ben Dai <ben.dai9703@gmail.com>
X-Google-Original-From: Ben Dai <ben.dai@unisoc.com>
To:     samitolvanen@google.com, ndesaulniers@google.com,
        rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ben Dai <ben.dai@unisoc.com>
Subject: [PATCH] arm64: fix the address of syscall in arch_syscall_addr if CFI is enabled
Date:   Fri,  3 Dec 2021 13:29:08 +0800
Message-Id: <20211203052908.7467-1-ben.dai@unisoc.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the addresses in sys_call_table[] actually point to
jump instructions like "b __arm64_sys_*", and if CONFIG_LTO_CLANG_FULL is
enabled, the compiler will not generate a symbol for each jump. It causes
syscall tracer can't get symbol name in find_syscall_meta() and fail to
initialize.

To fix this problem, implement an strong definition of arch_syscall_addr()
to get the actual addresses of system calls.

Signed-off-by: Ben Dai <ben.dai@unisoc.com>
---
 arch/arm64/kernel/syscall.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a38e84..2b911603966b 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -12,6 +12,8 @@
 #include <asm/debug-monitors.h>
 #include <asm/exception.h>
 #include <asm/fpsimd.h>
+#include <asm/insn.h>
+#include <asm/patching.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
@@ -19,6 +21,25 @@
 long compat_arm_syscall(struct pt_regs *regs, int scno);
 long sys_ni_syscall(void);
 
+#ifdef CONFIG_CFI_CLANG
+unsigned long __init arch_syscall_addr(int nr)
+{
+	u32 insn;
+	unsigned long addr = (unsigned long)sys_call_table[nr];
+
+	/*
+	 * Clang's CFI will replace the address of each system call function
+	 * with the address of a jump table entry. In this case, the jump
+	 * target address is the actual address of the system call.
+	 */
+	aarch64_insn_read((void *)addr, &insn);
+	if (likely(aarch64_insn_is_b(insn)))
+		addr += aarch64_get_branch_offset(insn);
+
+	return addr;
+}
+#endif
+
 static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
 #ifdef CONFIG_COMPAT
-- 
2.17.0

