Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDF4E36C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiCVClg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCVCle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:41:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AA1FA45
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:40:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d76so2341283pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=kbDNC7nwvfxYUv1EhLiPssj97St0I3K9gZTYcVJqPsU=;
        b=7KoGB1p/MFxA65A/e014UrzGVxM4M69YHYXwQNGOF7LAH6X+Lwbw6ayXRxuO0NBEKQ
         vLbIT7WLlrov+KxZ4afuppj3/cjqfqcF2gWKfCUMKQGzn0iTvwbhHbMAR9DGUQcgSXIp
         X92rooJ6q474av6j5dmRvm1KZVCtEko80yidm7jKmNuCaNezOiTqEw9qIeHd6C2at9yC
         ayfuigPqJD4CmcMGxBBR2v36eJJj6PrSWiZspGWQ5bmOUuHPthFirftTM+EVCA7HdzWM
         ligJjynIaI3bUbZmIji5CJg9UPkVAEDVBCDrl660O0gQH+PbaY4IM/Ru/WSn/OUJGzs5
         QUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=kbDNC7nwvfxYUv1EhLiPssj97St0I3K9gZTYcVJqPsU=;
        b=iQAILkX5MsVfwVnpilYSdi8Yo72yM/4mY4Uq8vwfw1mRaz6sgoF7vm5L+pfsp0rk1U
         +cGwUJBGMTqUtgKFujGJNPRgVEZHnZe6BRlY++HI5TUXb8Tdd35PiHTvwP8PTMmeexMk
         6Dxc/7Y/9dGvJyp8BR6bYp32OQ6YKiZ3xNaMjTJPaRuxcoi7VFv/ujeizURQCCClEDFX
         6CD4HKcDJOoW8g17lXYYqRiWqfNFPAs1K8jbRY5GFQlNkRtPUpvL6giekN3q3qF4lGB4
         AxU3hrRM6FADmhe+iiGXyeqzniB7HKLJhVDcgj9E9EUdnqO0gOu3Ijkj7+OmGAn1ma6E
         JZyw==
X-Gm-Message-State: AOAM530vglm+00Nr1CsVP5Sby6e9cr2rjFYSjkoFBzMoYRwz+Qah+86A
        nwphOfui/K6mAemUizalX+0mBPgZ1FdVxQ==
X-Google-Smtp-Source: ABdhPJzqwad5fmG7gwHxbfCNhJJ8lJiKisxYu8q/ryzgwj+t/lNjQu+liFBKnPSpYvLOFRgfCwwPXw==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr27068856pfl.3.1647916807757;
        Mon, 21 Mar 2022 19:40:07 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id lj7-20020a17090b344700b001c7032eba5fsm724045pjb.4.2022.03.21.19.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:40:07 -0700 (PDT)
Subject: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Date:   Mon, 21 Mar 2022 19:23:31 -0700
Message-Id: <20220322022331.32136-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     mingo@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, changbin.du@gmail.com,
            rostedt@goodmis.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

We're currently using stop_machine() to update ftrace, which means that
the thread that takes text_mutex during ftrace_prepare() may not be the
same as the thread that eventually patches the code.  This isn't
actually a race because the lock is still held (preventing any other
concurrent accesses) and there is only one thread running during
stop_machine(), but it does trigger a lockdep failure.

This patch just elides the lockdep check during stop_machine.

Fixes: c15ac4fd60d5 ("riscv/ftrace: Add dynamic function tracer support")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

--

Changes since v1 [<20210506071041.417854-1-palmer@dabbelt.com>]:
* Use ftrace_arch_ocde_modify_{prepare,post_process}() to set the flag.
  I remember having a reason I wanted the function when I wrote the v1,
  but it's been almost a year and I forget what that was -- maybe I was
  just crazy, the patch was sent at midnight.
* Fix DYNAMIC_FTRACE=n builds.
---
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/ftrace.c      | 12 ++++++++++++
 arch/riscv/kernel/patch.c       | 10 +++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380041..3ac7609f4ee9 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -81,8 +81,15 @@ do {									\
 struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
+extern int riscv_ftrace_in_stop_machine;
 #endif
 
+#else /* CONFIG_DYNAMIC_FTRACE */
+
+#ifndef __ASSEMBLY__
+#define riscv_ftrace_in_stop_machine 0
 #endif
 
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4716f4cdc038..c5f77922d7ea 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -11,15 +11,27 @@
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
+int riscv_ftrace_in_stop_machine;
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
 	mutex_lock(&text_mutex);
+
+	/*
+	 * The code sequences we use for ftrace can't be patched while the
+	 * kernel is running, so we need to use stop_machine() to modify them
+	 * for now.  This doesn't play nice with text_mutex, we use this flag
+	 * to elide the check.
+	 */
+	riscv_ftrace_in_stop_machine = true;
+
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
 {
+	riscv_ftrace_in_stop_machine = false;
 	mutex_unlock(&text_mutex);
 	return 0;
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..7983dba477f0 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -11,6 +11,7 @@
 #include <asm/kprobes.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
+#include <asm/ftrace.h>
 #include <asm/patch.h>
 
 struct patch_insn {
@@ -59,8 +60,15 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	 * Before reaching here, it was expected to lock the text_mutex
 	 * already, so we don't need to give another lock here and could
 	 * ensure that it was safe between each cores.
+	 *
+	 * We're currently using stop_machine() for ftrace, and while that
+	 * ensures text_mutex is held before installing the mappings it does
+	 * not ensure text_mutex is held by the calling thread.  That's safe
+	 * but triggers a lockdep failure, so just elide it for that specific
+	 * case.
 	 */
-	lockdep_assert_held(&text_mutex);
+	if (!riscv_ftrace_in_stop_machine)
+		lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
-- 
2.34.1

