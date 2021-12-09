Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584846E694
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhLIKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhLIKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:31:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E39C061746;
        Thu,  9 Dec 2021 02:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5RLLZ0ThJGB1WBGnDY4uNAU4BDJtEfGj6LzMMLZxmrc=; b=RLbwXjyWyKw3P3bQRGWvyOZogX
        vfn3sAoDSaLGaw3rt1NTd7wQ8GyR530u10t92iSRoVAkRj230vaAl53thjMO1qICdgKGowxyKCDkb
        sBK0AAO3nL+l8XuIR4iXDSaIeuJlQrF7JuCF6iM2eUcn1CLMJ7VrOaWGpu5kne+tRimdRyLDNVM62
        O5kGlpRFCxuA/kSkHnh+GFGbPjMuZjojG/YvEBf+owVrZh15JLNjbokQJqCaNhoYPThoGt7KRg8jF
        MsUoTaGK+VmQk/O/6e97v+maCkMVolvqpQVC082Y0pfavzN/VeoK3xdDcF7ZSMRe+vp4u7zi8boAZ
        NGXofEKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvGdt-009FuS-FX; Thu, 09 Dec 2021 10:27:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 480B73002DB;
        Thu,  9 Dec 2021 11:27:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30E652BB8EE66; Thu,  9 Dec 2021 11:27:13 +0100 (CET)
Date:   Thu, 9 Dec 2021 11:27:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Subject: Re: randomize_kstack: To init or not to init?
Message-ID: <YbHaASWR07kPfabg@hirez.programming.kicks-ass.net>
References: <YbHTKUjEejZCLyhX@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbHTKUjEejZCLyhX@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> default since dcb7c0b9461c2, which is why this came on my radar. And
> Clang also performs auto-init of allocas when auto-init is on
> (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> allocas.
> 
> add_random_kstack_offset() uses __builtin_alloca() to add a stack
> offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> enabled, add_random_kstack_offset() will auto-init that unused portion
> of the stack used to add an offset.
> 
> There are several problems with this:
> 
> 	1. These offsets can be as large as 1023 bytes. Performing
> 	   memset() on them isn't exactly cheap, and this is done on
> 	   every syscall entry.
> 
> 	2. Architectures adding add_random_kstack_offset() to syscall
> 	   entry implemented in C require them to be 'noinstr' (e.g. see
> 	   x86 and s390). The potential problem here is that a call to
> 	   memset may occur, which is not noinstr.
> 
> A defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> 
>  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
>  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> 
> Switching to INIT_STACK_ALL_NONE resolves the warnings as expected.
> 
> To figure out what the right solution is, the first thing to figure out
> is, do we actually want that offset portion of the stack to be
> auto-init'd?
> 
> There are several options:
> 
> 	A. Make memset (and probably all other mem-transfer functions)
> 	   noinstr compatible, if that is even possible. This only solves
> 	   problem #2.

While we can shut up objtool real easy, the bigger problem is that
noinstr also excludes things like kprobes and breakpoints and other such
goodness from being placed in the text.

> 	B. A workaround could be using a VLA with
> 	   __attribute__((uninitialized)), but requires some restructuring
> 	   to make sure the VLA remains in scope and other trickery to
> 	   convince the compiler to not give up that stack space.
> 
> 	C. Introduce a new __builtin_alloca_uninitialized().
> 
> I think #C would be the most robust solution, but means this would
> remain as-is for a while.
> 
> Preferences?

I'm with you on C.
