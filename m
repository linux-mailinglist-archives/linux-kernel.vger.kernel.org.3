Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E44D1C73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348202AbiCHP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbiCHP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB04F9CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fi2mYqVok9UIH1rjKmE/J2SISTNpvPn2VkBxzhXYZBE=; b=UA/AvmdQsmA4lieuJe4gdJUWk6
        xU80Kfuy5GsRZPYfIm6hRa65Q6GoTVK3h5GxrkJcAP3v3MMJuNZsd9DCRTFsfVS8r4XbPEdDvTSEK
        wv1mG3xtQ3xDgRWKq6aYZ4rYouXFmXMRaekFHFfflwJzQ6+4czSmHo8iR7ALoYjhERqqbQLf4gKfn
        jC5wvwPlScLLM0X73DWJiGAe6ajkqjpgwPzL1ij/RbSHixrrZbIbxHK5xoVoz1a/B5z05RrBuxo+r
        HaoiyYOsIlr6r/5FW3CobBi9CIDGEPlci6A1r7wd8nwj8B8kHwzkCIzZCWpoLKNC2Rk6In9z2WSqY
        xxiaIVJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAd-00GIvS-DL; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5143A302DDA;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DCA122B5649D8; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.468805622@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 39/45] x86: Annotate call_on_stack()
References: <20220308153011.021123062@infradead.org>
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

vmlinux.o: warning: objtool: page_fault_oops()+0x13c: unreachable instruction

0000 000000000005b460 <page_fault_oops>:
...
0128    5b588:  49 89 23                mov    %rsp,(%r11)
012b    5b58b:  4c 89 dc                mov    %r11,%rsp
012e    5b58e:  4c 89 f2                mov    %r14,%rdx
0131    5b591:  48 89 ee                mov    %rbp,%rsi
0134    5b594:  4c 89 e7                mov    %r12,%rdi
0137    5b597:  e8 00 00 00 00          call   5b59c <page_fault_oops+0x13c>    5b598: R_X86_64_PLT32   handle_stack_overflow-0x4
013c    5b59c:  5c                      pop    %rsp

vmlinux.o: warning: objtool: sysvec_reboot()+0x6d: unreachable instruction

0000 00000000000033f0 <sysvec_reboot>:
...
005d     344d:  4c 89 dc                mov    %r11,%rsp
0060     3450:  e8 00 00 00 00          call   3455 <sysvec_reboot+0x65>        3451: R_X86_64_PLT32    irq_enter_rcu-0x4
0065     3455:  48 89 ef                mov    %rbp,%rdi
0068     3458:  e8 00 00 00 00          call   345d <sysvec_reboot+0x6d>        3459: R_X86_64_PC32     .text+0x47d0c
006d     345d:  e8 00 00 00 00          call   3462 <sysvec_reboot+0x72>        345e: R_X86_64_PLT32    irq_exit_rcu-0x4
0072     3462:  5c                      pop    %rsp

Both cases are due to a call_on_stack() calling a __noreturn function.
Since that's an inline asm, GCC can't do anything about the
instructions after the CALL. Therefore put in an explicit
ASM_REACHABLE annotation to make sure objtool and gcc are consistently
confused about control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irq_stack.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -99,7 +99,8 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %P[__func]				\n"
+	"call %P[__func]				\n"		\
+	ASM_REACHABLE
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\


