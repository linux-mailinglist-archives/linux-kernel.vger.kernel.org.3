Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F39528379
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiEPLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiEPLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:45:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080ACDF4C;
        Mon, 16 May 2022 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MjT6Lh2fWnIRqcyu9+fU8ljp/f9ciDwE1jZdLagfUro=; b=DIyr6/C/OlBvy/oySvPFldi/21
        rOpTYtej3bizi+u7/K16YCrPzqB2hqe+RX9d6p7xbu3sp6GMJhzpq0v/JLqUod/xTtmlAv35QLUEj
        /wInc/XEfEZq+E70DWAPyASnQmaV5dqmdCGSjZ2qhGSgY/85J8I/gN1+hIvaHSDg5ST8in3v8iDwj
        jcMnpAa6C+r98QB7QvCCIFBAR5G2Vs/dsvb5tzsnEPYZosIs6GhIodV1v/BQ8U2audosn96Y/k164
        gWZ+2yLr1TKifY4KPI4zoecKJmS+RdcxtOvj2eV1CHP8EH1qgoKQ3Wn8fSSV/h9Can4XPg/um6NB+
        cXl0RWjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqZA8-000w7T-0G; Mon, 16 May 2022 11:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53103300268;
        Mon, 16 May 2022 13:45:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12EC620225E64; Mon, 16 May 2022 13:45:17 +0200 (CEST)
Date:   Mon, 16 May 2022 13:45:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <YoI5TbDfw/88vf1f@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:54:33AM +0200, Peter Zijlstra wrote:
> On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler injects a type preamble
> > immediately before each function and a check to validate the target
> > function type before indirect calls:
> > 
> >   ; type preamble
> >   __cfi_function:
> >     int3
> >     int3
> >     mov <id>, %eax
> >     int3
> >     int3
> >   function:
> >     ...
> 
> When I enable CFI_CLANG and X86_KERNEL_IBT I get:
> 
> 0000000000000c80 <__cfi_io_schedule_timeout>:
> c80:   cc                      int3
> c81:   cc                      int3
> c82:   b8 b5 b1 39 b3          mov    $0xb339b1b5,%eax
> c87:   cc                      int3
> c88:   cc                      int3
> 
> 0000000000000c89 <io_schedule_timeout>:
> c89:   f3 0f 1e fa             endbr64
> 
> 
> That seems unfortunate. Would it be possible to get an additional
> compiler option to suppress the endbr for all symbols that get a __cfi_
> preaamble?
> 
> Also, perhaps s/CFI_CLANG/KERNEL_CFI/ or somesuch, so that GCC might
> also implement this same scheme (in time)?
> 
> >   ; indirect call check
> >     cmpl    <id>, -6(%r11)
> >     je      .Ltmp1
> >     ud2
> >   .Ltmp1:
> >     call    __x86_indirect_thunk_r11
> 
> The first one I try and find looks like:
> 
> 26:       41 81 7b fa a6 96 9e 38         cmpl   $0x389e96a6,-0x6(%r11)
> 2e:       74 02                   je     32 <__traceiter_sched_kthread_stop+0x29>
> 30:       0f 0b                   ud2
> 32:       4c 89 f6                mov    %r14,%rsi
> 35:       e8 00 00 00 00          call   3a <__traceiter_sched_kthread_stop+0x31> 36: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4
> 
> This must not be. If I'm to rewrite that lot to:
> 
>   movl	$\hash, %r10d
>   sub	$9, %r11
>   call	*%r11
>   .nop  4
> 
> Then there must not be spurious instruction in between the ud2 and the
> indirect call/retpoline thing.

Hmmm.. when I replace it with:

   movl	$\hash, %r10d
   sub	$9, %r11
   .nops 2

That would work, that has the added benefit of nicely co-existing with
the current retpoline patching.

The only remaining problem is how to find this; the .retpoline_sites is
fairly concenient, but if the compiler can put arbitrary amounts of code
in between this is going to be somewhat tedious.

