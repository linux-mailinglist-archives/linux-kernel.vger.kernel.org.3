Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0211528117
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbiEPJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiEPJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:54:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252816586;
        Mon, 16 May 2022 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/az5ZlpJQ8aDNMLY9MCE8GkO4AGEyZkSzsELYwgNYj4=; b=lA153z4CORR8RVuipFycT+rfic
        VYFl4X19X2lFe4YCoQJqFTuj7YCFRxXTqHr/oLOJbHFxTWSK+uXWEdITDp5bgfRotRTOaZfRRckec
        Sj+G268CI945tzUUXnEZksYhmTrG6Sy3FURbkbca+MHHJMoitg/2oU4DZEQkWfSD3i1+wCizpmJUc
        dlg2eHo4m+ztUEhgMipVS5WpYEzcnPTHeW3BBkO49KLG/FfilI+bVdxrG52y/BTmPwqePK4s2GDO3
        ZlqKClu94dUuJ8N8lzKak0iRlavTD1c72uGDJqj63oKFd7WRXFmCM5iFfxiE2e4LQUKJiXWSWQRSR
        +LLHIwbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqXQy-009mOl-1R; Mon, 16 May 2022 09:54:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 242EE30018E;
        Mon, 16 May 2022 11:54:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 041C020225E5F; Mon, 16 May 2022 11:54:32 +0200 (CEST)
Date:   Mon, 16 May 2022 11:54:32 +0200
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
Message-ID: <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513202159.1550547-21-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler injects a type preamble
> immediately before each function and a check to validate the target
> function type before indirect calls:
> 
>   ; type preamble
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...

When I enable CFI_CLANG and X86_KERNEL_IBT I get:

0000000000000c80 <__cfi_io_schedule_timeout>:
c80:   cc                      int3
c81:   cc                      int3
c82:   b8 b5 b1 39 b3          mov    $0xb339b1b5,%eax
c87:   cc                      int3
c88:   cc                      int3

0000000000000c89 <io_schedule_timeout>:
c89:   f3 0f 1e fa             endbr64


That seems unfortunate. Would it be possible to get an additional
compiler option to suppress the endbr for all symbols that get a __cfi_
preaamble?

Also, perhaps s/CFI_CLANG/KERNEL_CFI/ or somesuch, so that GCC might
also implement this same scheme (in time)?

>   ; indirect call check
>     cmpl    <id>, -6(%r11)
>     je      .Ltmp1
>     ud2
>   .Ltmp1:
>     call    __x86_indirect_thunk_r11

The first one I try and find looks like:

26:       41 81 7b fa a6 96 9e 38         cmpl   $0x389e96a6,-0x6(%r11)
2e:       74 02                   je     32 <__traceiter_sched_kthread_stop+0x29>
30:       0f 0b                   ud2
32:       4c 89 f6                mov    %r14,%rsi
35:       e8 00 00 00 00          call   3a <__traceiter_sched_kthread_stop+0x31> 36: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4

This must not be. If I'm to rewrite that lot to:

  movl	$\hash, %r10d
  sub	$9, %r11
  call	*%r11
  .nop  4

Then there must not be spurious instruction in between the ud2 and the
indirect call/retpoline thing.
