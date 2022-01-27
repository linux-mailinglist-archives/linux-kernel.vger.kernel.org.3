Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709F49D704
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiA0A4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiA0A4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:56:03 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:56:03 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso702902wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LoERNwA8xmWnMRUS58kPHL8vW8xT0FQRW2sRgtn7u0w=;
        b=Q6u2q6a4h8e+wmuP3o/7Z/SKYlZ4d9c8MTBhQBmKXwV/XS9zuDNin/uBSsf4CUn4p7
         7hwMJHczWpE2aDXrMxeLAed5AyJOE6PJub7KXPy5n9InC2QmPc6DTKBMXcFqr+VhkgQL
         N5DrnHTBGdQTkxe/9kioyybS8Y5EWT1QPKb/TW2W1MQ8bwL4AfOHs3uAaKTi5jmP2Cr+
         8Oe2jpN+pJAHHQDpZa4BuXmZeHlMow1m37Lv8B2zrgoalIyC6VVR/lCi4hhTmL/UjWHN
         k90xVtf44yBOuVtUBD/0ijvjkB9QL88oIC2YvspCbFqi2CLeq2bgR6vmvDno1subfT9+
         Ltqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LoERNwA8xmWnMRUS58kPHL8vW8xT0FQRW2sRgtn7u0w=;
        b=3G5rrV464nWVcgT/4ZjkoXZd76xJGGXgIc+tIic1MsnGQL+YQVRzWSCgFxBObHqn3b
         yYPiJUjVAKgBFIx4lNR2r2i7VKLxFXhPr8NcWFu163+Ns/xKbqW9EpDsE/80UQ33tYAn
         eBv9ERTpBl87EifeIROohj/32o65rHg70CpTGgR7d4M0o5PvuyeIkWstwkbKS0wgcvu7
         f2y9FDJWXZOtuVOuNNIg7EsUv9ZAZYleUBvb11DqHWCvxeBWSfg4MfuCb5kWCkkLZ3qV
         JrajfVY8Q+toTtdLl6FdImH4PkDm7kQDDoQD5EOKUGH7Nxnm1TnDo3c/d+JBtrunfLR7
         2xLw==
X-Gm-Message-State: AOAM533P5c/pCurOZyuWqlzjudqJywBHibbmq+G/brU43xf4bHeIrqSf
        odNdoglSj1gk7yb0fmqDgprYL5p97w==
X-Google-Smtp-Source: ABdhPJzuLcNk5JgrXPuPZqgJaZCbjNQrZ45faG5X5GxA2E4X3W1I0zBMgX9VABCPsfk/ieE9xOaCcA4lEA==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:9d:4:e695:855e:ae74:d6f])
 (user=jannh job=sendgmr) by 2002:a1c:a5d0:: with SMTP id o199mr9613780wme.65.1643244961486;
 Wed, 26 Jan 2022 16:56:01 -0800 (PST)
Date:   Thu, 27 Jan 2022 01:55:55 +0100
Message-Id: <20220127005555.2766254-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [RFC PATCH] x86/dumpstack: Fix unwind failure due to off-by-one-frame
From:   Jann Horn <jannh@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(emphasis on the "RFC", not the "PATCH"...)

I've hit a bug where __dump_stack() ends up printing a stack trace that
consists purely of guesses (all printed frames start with "? ").

Debugging the issue, I found that show_trace_log_lvl() is looking at a
stack that looks like this:

    function             stored value    pointer in show_trace_log_lvl()
    ====================================================================
            show_stack   saved RIP
            show_stack   saved RBP       <-- stack
    show_trace_log_lvl   saved RIP       <-- unwind_get_return_address_ptr(...)
    show_trace_log_lvl   ...
    show_trace_log_lvl   ...

show_trace_log_lvl() then iterates up the stack with its `stack`
variable; but because `unwind_get_return_address_ptr(&state)` is below the
starting point, the two never compile equal, and so `reliable` is never
set to 1.

Poking around a bit, I see two issues.

The first issue is that __unwind_start() tries to figure out whether
`first_frame` is inside the current frame before even having looked up
the ORC entry that determines where the current frame ends.
That can't work and results in being off-by-one-frame in some cases no
matter how we twist the comparison between `state->sp` and `first_frame`.

The second issue is that show_trace_log_lvl() asks __unwind_start() to
stop when it finds the frame containing `stack`, but then tries
comparing `unwind_get_return_address_ptr(&state)` (which has to be below
`stack`, since it is part of the lower frame) with `stack`.
That can't work if __unwind_start() is working properly - we'll have to
unwind up another frame.

This patch is an attempt to fix that, but I guess there might still be
issues with it in the interaction with show_regs_if_on_stack() in
show_trace_log_lvl(), or something like that?

Another option might be to rework even more how ORC stack walking works,
and always compute the location of the next frame in __unwind_start()
and unwind_next(), such that it becomes possible to query for the top
of the current frame?

Or a completely different approach, do more special-casing of different
unwinding scenarios in __unwind_start(), such that unwinding a remote
task doesn't go through the skip-ahead loop, and unwinding the current
task from a starting point is always guaranteed to skip the given frame
and stop at the following one? Or something along those lines?
That would also make it more obviously correct what happens if a
function specifies its own frame as the starting point wrt to changes to
that frame's contents before the call to unwind_next()... now that I'm
typing this out, I think that might be the best option?

[no signoff because I think this patch might be a terrible idea...]
---
 arch/x86/kernel/dumpstack.c  | 10 ++++++++
 arch/x86/kernel/unwind_orc.c | 46 ++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 53de044e5654..2bffe8132e7c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,16 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+
+	/* We asked unwind_start() to give us the unwind state for the frame
+	 * that contains @stack. But unwind_get_return_address_ptr() gives the
+	 * pointer to the saved RIP at the top of the previous frame.
+	 * If we want to be able to compare unwind_get_return_address_ptr()
+	 * with stack positions starting at @stack, we have to skip to the next
+	 * frame.
+	 */
+	unwind_next_frame(&state);
+
 	stack = stack ? : get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..611ffa4d3701 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -706,10 +706,48 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	}
 
 	/* Otherwise, skip ahead to the user-specified starting frame: */
-	while (!unwind_done(state) &&
-	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp < (unsigned long)first_frame))
-		unwind_next_frame(state);
+	while (!unwind_done(state)) {
+		struct unwind_state lookahead_state;
+		/* If we're not even on the right stack yet, skip. */
+		if (!on_stack(&state->stack_info, first_frame, sizeof(long))) {
+			unwind_next_frame(state);
+			continue;
+		}
+
+		/*
+		 * What the user has given us is just a pointer somewhere *into*
+		 * a frame - for example, if the caller used
+		 * __builtin_frame_address(0), that function will have a saved
+		 * RBP below the saved RIP (yes, even when compiling without
+		 * frame pointers), and first_frame will point to that saved
+		 * RBP. If we're unwinding a remote task, we might be dealing
+		 * with a first_frame pointer to the bottom of a stack frame.
+		 *
+		 * So if we want to stop at the frame *containing* first_frame,
+		 * we have to first look up the next ORC entry and check whether
+		 * first_frame is within the current frame.
+		 */
+		lookahead_state = *state;
+		unwind_next_frame(&lookahead_state);
+
+		/*
+		 * It might be that the current frame is the last frame on this
+		 * stack, and the lookahead_state points to an entirely
+		 * different stack. We already decided above that we want to
+		 * stop somewhere on the current stack, so stop here.
+		 */
+		if (lookahead_state.stack_info.type != state->stack_info.type)
+			break;
+
+		/*
+		 * Stop if the user-specified address is below where the next
+		 * frame starts (meaning it is in the current frame).
+		 */
+		if ((unsigned long)first_frame < lookahead_state.sp)
+			break;
+
+		*state = lookahead_state;
+	}
 
 	return;
 

base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
prerequisite-patch-id: c01c9b02a02ca0c6996a5fb02e68e137444a0a53
-- 
2.35.0.rc0.227.g00780c9af4-goog

