Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0343E4A6926
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiBBATX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiBBATW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:19:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381EC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:19:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso4311019pjt.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adv2KJHKXKF0pCI42qqNs6o33zDoPHhHxu1KpEJ8ABg=;
        b=BJfOfpc6IQs9vnwLauxhA3RgYyW78x34uxVU4I23OOsQe18xWzWYBfP3U5BcWLQgLu
         2OVl/Bq+W2aTppzMrcEnyhRWHjbS03Mu7yLO5k9yH4v8TXNooTjJ5fN7an5W5xPcMttN
         ds46MzFkJ6X0qajZwIFIlD2N+nb6CQkxgiyL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adv2KJHKXKF0pCI42qqNs6o33zDoPHhHxu1KpEJ8ABg=;
        b=tkfbDRneOiYJkApg8IQ6UNAFHCtSyT3g8S/FNk5NOzbNa39AYtrSgaBWEfy/4xHH7s
         acTk4AdfjGfewiwm/R5uZDmibaw6yhT1ju+kkjFl7K5zeLWiRFYinK56pIFDcKL721IR
         TIdwGcqhvnwEnKphZPQtgwuXyCs3jZJhOB2zgal9zuqoN48Qsb2CyxwzgGsgoCFmujBA
         ZBQQpC6VjVDDqcHj4ldVUYdNQPUUv1NbfJ1H2qXV2gngLiS1B/1y/eJwClhPhvlzxQk1
         NmJHJB8k+7cgypdJ7c6VvrHkvHUrEYrgSQRNcuO4Gwcu8B5nvmEQ+LlxDf+ulNM3EloH
         ubow==
X-Gm-Message-State: AOAM532si+Mcv+y1QKs/va3y5NUI5JYf4SYvtnch8a7uaKLvwZmJl0X0
        GMsXccYOpRE375SPy48P69mXXa+IOwSybA==
X-Google-Smtp-Source: ABdhPJyzsMJX3rUcUxnPAaWep692nU2AR0CfMD1Ga0hKxgsh3aDFongY5BDrHPFUGrEvVoxCR4lG7Q==
X-Received: by 2002:a17:902:c209:: with SMTP id 9mr27799550pll.119.1643761161175;
        Tue, 01 Feb 2022 16:19:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt14sm3877667pjb.21.2022.02.01.16.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:19:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Date:   Tue,  1 Feb 2022 16:19:18 -0800
Message-Id: <20220202001918.4104428-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; h=from:subject; bh=8WRomHZfMBr1H5lYh4nOyABVQUWFYNGQRyJxLbsvl8Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+c4FlOsqRN5C/fUJlmyBW+OjNG5eMHb7efxL+f70 VEd610aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfnOBQAKCRCJcvTf3G3AJt7WD/ 0UmTeuH1xP2mbaVO+hEmeJAB+/IP4pkd0DHq+tjl7Vnpe1Pqcge6ccMVL4WYg78CbYUng/KNQ1s35x Jkr8RICmgPyRU+/3eSDVf0kkqNDx5wSw0olB8ZdWk8NsmMUlOC+wFOwMy49Dr7uhyrJDxg1XuYjX53 VbeveAjKskvn6Crz4qNpU+9Rzg9so/KeGJ3ClyzSWJXZJIJ9OQJwdkTmO1zdaLWMReEAq0vY27/bbd EianvOHESUGtASEWYCUcHneznCg7AUzOrQ9YPA6F0iRdjdz0ZH5pjOC4nrB24L56l4gFC3oLZaXBmu Inpml+lnUauqH933MGam2CqkRDCs3sqIHdvJE+6ZPNrRb0Wl/NnMuffQaK9r5MIlqmFA83WC2UIUSc 05b5TtgBjZYrwud5uDmr6ZKV0/ltBMGhZpjFS7c51pYN3ksJF6VVS5xjmWUJmnBCPCv1aKABEhDhMv AnDCPof1nCkDg4EzkoU2bKyARlGgQCS9agYLMVnS04Y5ef4q558Yq6zYmTb57cf2wtsHX77wcOJtSf A6N6pX3/+9Rk2RduKOdU41lCKrKYJxsBOV3Vt7JNh3WjZd511J04OEHzVOli9VJmiaAocl4DiJNUVj f0s5GV4pXvYIyZKy9fLU5KT4rGsA5Xk6YKJyFCcHQ8ueoPmto+dsSQzmlB/w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the stackleak plugin was already using notrace, objtool is now a
bit more picky. Update the notrace uses to noinstr. Silences these
warnings:

vmlinux.o: warning: objtool: do_syscall_64()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_int80_syscall_32()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_general_protection()+0x22: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: fixup_bad_iret()+0x20: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x27: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: .text+0x5346e: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x143: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x10eb: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x17f9: call to stackleak_erase() leaves .noinstr.text section

Cc: Alexander Popov <alex.popov@linux.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Is it correct to exclude .noinstr.text here? That means any functions called in
there will have their stack utilization untracked. This doesn't seem right to me,
though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
---
 kernel/stackleak.c                     | 3 +--
 scripts/gcc-plugins/stackleak_plugin.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 66b8af394e58..72d4ebf49480 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
-asmlinkage void notrace stackleak_erase(void)
+asmlinkage void noinstr stackleak_erase(void)
 {
 	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
 	unsigned long kstack_ptr = current->lowest_stack;
@@ -124,7 +124,6 @@ asmlinkage void notrace stackleak_erase(void)
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
-NOKPROBE_SYMBOL(stackleak_erase);
 
 void __used __no_caller_saved_registers notrace stackleak_track_stack(void)
 {
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index e9db7dcb3e5f..e7e51f0eb597 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -429,6 +429,7 @@ static unsigned int stackleak_cleanup_execute(void)
 	return 0;
 }
 
+/* Do not instrument anything found in special sections. */
 static bool stackleak_gate(void)
 {
 	tree section;
@@ -446,6 +447,8 @@ static bool stackleak_gate(void)
 			return false;
 		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
 			return false;
+		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
+			return false;
 	}
 
 	return track_frame_size >= 0;
-- 
2.30.2

