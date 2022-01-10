Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C490848A1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiAJVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:22:21 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:45838
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241317AbiAJVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:22:20 -0500
Received: from integral2.. (unknown [180.242.102.163])
        by gnuweeb.org (Postfix) with ESMTPSA id BF346C165A;
        Mon, 10 Jan 2022 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1641849738;
        bh=VioQWJKP0JFibgNf6r3ecMTUwAMykd+0w2zRW0DEPbc=;
        h=From:To:Cc:Subject:Date:From;
        b=ATm98TvbFeLr1a5Zj1upVadR3qwhFUobqKdQ75Wm8GGNOdDAN57Jb7WzVSReNac/Q
         y4y5Cf/Pj8kJUS27lEVl7I3CbxbjdAAahCvo/LKQeMnS3QkS0yFUjSogZc488yiHkY
         HIKKRvBAkSCa00eXhTcQKKNcxAVmuKFcQUZ3yvRdS4GediKDWg+aW+1KW2wRENGW9H
         sfGh8964Ctl2JgoEv8JNUuz5Qi6kiY+vfdcLCtvBTU4aXGeFWqQFfOCIRMC6M/qtxP
         LqYxY3WrWucUee38HKjm0/m8uKPqAW/bkXGc/5MZpdhKDL2xClXiptm4uw6lQfNrKb
         tlhwF9jIwvcAQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, x86ml <x86@kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>
Subject: [PATCH v1] x86/delay: Fix the wrong asm constraint in `delay_loop()`
Date:   Tue, 11 Jan 2022 04:21:59 +0700
Message-Id: <20220110212159.1567280-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm constraint does not reflect that the asm statement can modify
the value of @loops. But the asm statement in delay_loop() does change
the @loops.

If by any chance the compiler inlines this function, it may clobber
random stuff (e.g. local variable, important temporary value in reg,
etc.).

Fortunately, delay_loop() is only called indirectly (so it can't
inline), and then the register it clobbers is %rax (which is by the
nature of the calling convention, it's a caller saved register), so it
didn't yield any bug.

^ That shouldn't be an excuse for using the wrong constraint anyway.

This changes "a" (as an input) to "+a" (as an input and output).

Fixes: e01b70ef3eb3080fecc35e15f68cd274c0a48163 ("x86: fix bug in arch/i386/lib/delay.c file, delay_loop function")
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Cc: x86ml <x86@kernel.org>
Cc: GNU/Weeb Mailing List <gwml@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/lib/delay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 65d15df6212d..0e65d00e2339 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -54,8 +54,8 @@ static void delay_loop(u64 __loops)
 		"	jnz 2b		\n"
 		"3:	dec %0		\n"
 
-		: /* we don't need output */
-		:"a" (loops)
+		: "+a" (loops)
+		:
 	);
 }
 

base-commit: bf4eebf8cfa2cd50e20b7321dfb3effdcdc6e909
-- 
2.32.0

