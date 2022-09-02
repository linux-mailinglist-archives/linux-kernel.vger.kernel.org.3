Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708DE5AB378
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiIBO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiIBO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D8145C70
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7BSAeKLrm7gxwtIhgZeIusnS5RkuLU2DoTkgdYtznEo=; b=sN5bJJTrDllOzx0dNSRWQNV/dJ
        Qo2dgkQd586esW/wXN/Bf7mHrv5xzgo5Z+8JtqK8/CZ9pnt0bYL1nZdWA9K44XLVu24M6o26QGOGZ
        Wl/lApotklkM033Q1HkvprM9bJ7aKeovRuPXpgLQsoX71zGkF4jVQEo2r9x9AVank2G41uQe0O//1
        vUlKcewrjWkviEgqaEF+NSoAq2l5G2yqNjMahffWrKVKocgSidFeGJf1ZbFE7gZ3jnqhbhgLqsxAp
        eEAdQReNsqgIYD9kIDzQ9y26yMyTZsuXJHjNCE7pWz/WMcUzd22OZXpfVB+o7BSKbV4aiGIu1jvll
        eCovXtxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77L-0074Su-I0; Fri, 02 Sep 2022 13:53:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5231C3002A3;
        Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1732725E26380; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130946.457567054@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 01/59] x86/paravirt: Ensure proper alignment
References: <20220902130625.217071627@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The entries in the .parainstr sections are 8 byte aligned and the
corresponding C struct makes the array offset 16 bytes.

Though the pushed entries are only using 12 bytes. .parainstr_end is
therefore 4 bytes short.

That works by chance because it's only used in a loop:

     for (p = start; p < end; p++)

But this falls flat when calculating the number of elements:

    n = end - start

That's obviously off by one.

Ensure that the gap is filled and the last entry is occupying 16 bytes.

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h       |    1 +
 arch/x86/include/asm/paravirt_types.h |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -743,6 +743,7 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
+	 _ASM_ALIGN;				\
 	.popsection
 
 
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -294,6 +294,7 @@ extern struct paravirt_patch_template pv
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
 	"  .short " clobber "\n"			\
+	_ASM_ALIGN "\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */


