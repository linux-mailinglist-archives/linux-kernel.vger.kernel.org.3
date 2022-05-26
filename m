Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1572534DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbiEZLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbiEZLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C8CEBB9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y5WjWRMaXuygUCB3tJA7/SRRsya1xYS0w6rnGVnFGLU=; b=CIXsMEYq9AGcMx1A4XI3hi3Yw8
        x/puLJ9kQULe4YtHWE0IfXTr3R8eoHA+ecaa10yMZcux8Mkm127aRoWRVPuZPRnxQ/g9nRDNxv5aM
        PkuU5CJ5gCH2kZ4fsfFkts7oVmivOPwTGXHdNYN3e/gkAvPszvLrD45x/G2wDVB2XtjzbCIhuw2mu
        ajUFLa215yncBYeIQUP03bwmjfX03WaSjnMBk24MTkd4SQJgifiGHwKKkVJnF5vuw4KyHFvSMsjID
        PeClrI06RNPFmJFm4iOnEzCYbSJvsv2U65hQkzawfrIPQQ2RjWgkj27PzCDliQeg2UT+9pZbsM4Yp
        rzcXHYpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001sVm-Nj; Thu, 26 May 2022 11:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FC4F30066D;
        Thu, 26 May 2022 13:02:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7EE6A20321F81; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105958.071435483@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: [PATCH 6/7] x86: Always inline on_thread_stack() and current_top_of_stack()
References: <20220526105252.440440893@infradead.org>
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

Becaues GCC clearly lost it's marbles again...

vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section

vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -559,7 +559,7 @@ static __always_inline void native_swapg
 #endif
 }
 
-static inline unsigned long current_top_of_stack(void)
+static __always_inline unsigned long current_top_of_stack(void)
 {
 	/*
 	 *  We can't read directly from tss.sp0: sp0 on x86_32 is special in
@@ -569,7 +569,7 @@ static inline unsigned long current_top_
 	return this_cpu_read_stable(cpu_current_top_of_stack);
 }
 
-static inline bool on_thread_stack(void)
+static __always_inline bool on_thread_stack(void)
 {
 	return (unsigned long)(current_top_of_stack() -
 			       current_stack_pointer) < THREAD_SIZE;


