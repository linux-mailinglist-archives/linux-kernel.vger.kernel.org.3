Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4914A8D16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353978AbiBCUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBCUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:17:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89143C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:17:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so4062331pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65nKEBiVcxIujg+NhRj00qIS3qDviOimeIgP6isBm4=;
        b=EkEWhFlLcn7pO/QQfdOhgUIH9G1jFjbdB85kiPHbPLZdfNWTwsJVWkA6HLzxuKcSjB
         nFg03S/GM/Vid+Zy+boSbcTYq18ZI2/2fEqmj5vWQPSHSldMInroiSTO2FmnllrEj94r
         DD1qlXVA9+0nqSMTqJ7Y5j8SH/y+4TsEMogYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65nKEBiVcxIujg+NhRj00qIS3qDviOimeIgP6isBm4=;
        b=bKP9x+MnTqc0sdO8ic4VavZs4lnBZATE3T2dkmXkcWwAJFarHzxp2RPtELdNx/VSOm
         J6ichEFDN5OeTnknlYOKrrUr2PlcRLjJw9XV5ymux35G9ujiMNMeeViqpMPxcFS7vYuJ
         f+vF0Waa67cjwnWG37awmXqq8UoXC/13YBaD/NeHJoa/gHzTS+8ewAgc84KJF5P3Y4Yd
         M1CVAyR5qE9l4ntWcZQze7HKZCYiD7FR3+X85EBd1EpX8kOpEN0cBg8r83S5XwRDTrHX
         vdKR1iwXuMTjgbpaXO9dn1Cc7ADV7uUUE8Id+4MQna7xBcwl9JdzX9+YZ9Y/BHAZmI3A
         OPLQ==
X-Gm-Message-State: AOAM531EIiprShVTZNyAGh3V78XgOhXX1Z47ECvQo+Ms9hMB2+Db/TpU
        rQasCXjlYCsbDCI6uV53iJuxSg==
X-Google-Smtp-Source: ABdhPJy648Xbn5rll4RR7qbfPIT6KZBWtFfPxme9zkRWYi24l1KorDtmwdhQFtQgrbfk6hpWfMzcMw==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr24222957plo.74.1643919479033;
        Thu, 03 Feb 2022 12:17:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm24sm10911696pjb.20.2022.02.03.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:17:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] gcc-plugins/stackleak: Use noinstr in favor of notrace
Date:   Thu,  3 Feb 2022 12:17:54 -0800
Message-Id: <20220203201754.1145358-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; h=from:subject; bh=J+F++YLvVFj2qA/cbnqLRM6GuRs8iI1oLzg+aO2Nozs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/DhxWOpPVb5L6xo6o1Ii29uv7CRbZ520IibHsMqm BeOUkASJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfw4cQAKCRCJcvTf3G3AJjQvEA CCZUJKcjDComKd8IeUIlcJkW0zyrAdliB7lSLQHz3ZDhmb8jIcZvT2AYmi9S3xOs6EsLUMGy92BAon k9/DHvMg/pt6pczpaFJhmUuErV3d6Rf2ueeEHJZn8CG0tSeR6lhelUyySAJYcFHUF4uJ156JDjwzPL ahtUwqEK/FprPCHiFSaU2XN2nBpZIf47wZpKS4r+j5XKBeUdt3meGFGohZO8FOeW7oBKhj9iTYqMdx JTJ0TjBnzIgYJ9UQ0eIWVmEsKkjBAZ/lipeSPpiOGGoJiEBbY4ljycjo7/Z+fhNjCQs/m01oZ+++1R TI7RiHBOHSkmLoofChLzr1qTJmE/piIL7i/RexiqH/913CSf8+Muu2G0qFu32Efvb3Lw2gySRXPuXG gKV0EmYfqUgJ+tqReLEtpJh+K0K8oQtuxnfd3twFBjK7YdDh90iAvSl3lAuMbFPFTstXqt8kmwGhF0 qkggauQsgsBB+opMKEE7ktHeSmBTt77UgtXATyRu6nAdS0ST6+n++ZexFAtRLmfFJ2+7MN4txNKe6n 8YjI4oXr5ltiXtx/doxMGKi9GcimxzeZdLzGRlgaD593AhzNevdHUEQUcI4gst4kkDx7NryHhl9gpU 6JpqFGBtAKysphvt22Xy4UK71NBhj28E03DGmruTjLnqBgVJW2OOIZFVH5PQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the stackleak plugin was already using notrace, objtool is now a
bit more picky. Update the notrace uses to noinstr. Silences the
following objtool warnings when building with:

CONFIG_DEBUG_ENTRY=y
CONFIG_STACK_VALIDATION=y
CONFIG_VMLINUX_VALIDATION=y
CONFIG_GCC_PLUGIN_STACKLEAK=y

vmlinux.o: warning: objtool: do_syscall_64()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_int80_syscall_32()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_general_protection()+0x22: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: fixup_bad_iret()+0x20: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x27: call to stackleak_track_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: .text+0x5346e: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x143: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x10eb: call to stackleak_erase() leaves .noinstr.text section
vmlinux.o: warning: objtool: .entry.text+0x17f9: call to stackleak_erase() leaves .noinstr.text section

Note that the plugin's addition of calls to stackleak_track_stack()
from noinstr functions is expected to be safe, as it isn't runtime
instrumentation and is self-contained.

Cc: Alexander Popov <alex.popov@linux.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 66b8af394e58..ddb5a7f48d69 100644
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
@@ -124,9 +124,8 @@ asmlinkage void notrace stackleak_erase(void)
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
-NOKPROBE_SYMBOL(stackleak_erase);
 
-void __used __no_caller_saved_registers notrace stackleak_track_stack(void)
+void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
 {
 	unsigned long sp = current_stack_pointer;
 
-- 
2.30.2

