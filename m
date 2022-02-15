Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896E4B7894
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbiBOUDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:03:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiBOUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:03:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310775C02
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c10so155531pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYpYOt247YYcQkSbIW220dgIYhgVR6WY6sT8wWi/ZtE=;
        b=EJvqgsGqpY5ntsB8smDSnvlbX6MMh2tLmKHk2kpn+WLLX26Qg46icNudHQswUgDvDG
         2XCYZgLfLV3ryQ7MFgZo/SptowPM72fkx86+kCCAcd0DDtlbTkL6uvbqPIJNRGFPanJ5
         4xh874w3o9d/Mal+b4CGcSbfDAxCP1FsuU+TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYpYOt247YYcQkSbIW220dgIYhgVR6WY6sT8wWi/ZtE=;
        b=RnoSsOTjH0T0Uql+fkF2xCPVnu4PCOsR3sF5cNO9WN9iRETmRMwhixTa0DXCkA4s1n
         SdooJQ0NhWIDMI+mkO395Xgg4fCJj5frZsKGGdfbYDIpstLmDngrLa2J2vF/zVnLBVdB
         n8yiYoWJBPnHCPXS11h5Z1XxH9v9oHLTIZqk6NjfMmKqmH6Q0dLuUd+RgBsgYiMro86T
         iQfy2UdLnrF3b7OTCSAaMmMQ2vUr49WT/33ELe0CBJjsdr9Jx2XwzvYPy+MrinZZnmNe
         3cen4QSZi1lPTx/8gC8B7zC14NRGYRuVM339dJ7LrQrJelHNZW0d4TDUjmc+P7gA9sD2
         RNBw==
X-Gm-Message-State: AOAM5312+y8QWyFobVmEuPWDvM8Y/PweGb+wSkIUvz+L/opA/KpqwqWi
        6PhdXHpD6zggenel5MdcLslXhg==
X-Google-Smtp-Source: ABdhPJymds6XPIxfBbmKquoj/dCf0PdF93RyQzyKRSTKGOGU+jlmGBmvXoixB2ASM9RaOeug7YSqcA==
X-Received: by 2002:a63:4854:: with SMTP id x20mr449831pgk.178.1644955393489;
        Tue, 15 Feb 2022 12:03:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm42222151pfu.194.2022.02.15.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:03:13 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:03:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        X86 ML <x86@kernel.org>, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <202202151129.1A5C5FE42@keescook>
References: <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:56:03AM -0800, Sami Tolvanen wrote:
> On Mon, Feb 14, 2022 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> > > I'm fine with adding a trap mode that's used by default, but having
> > > more helpful diagnostics when something fails is useful even in
> > > production systems in my experience. This change results in a vmlinux
> > > that's another 0.92% smaller.
> >
> > You can easily have the exception generate a nice warning, you can even
> > have it continue. You really don't need a call for that.
> 
> Sure, but wouldn't that require us to generate something like
> __bug_table, so we know where the CFI specific traps are?

It also means the trap handler needs to do a bunch of instruction
decoding to find the address that was going to be jumped to, etc.

> > > In this case the function has two indirect calls and Clang seems to
> > > prefer to emit just one ud2.
> >
> > That will not allow you to recover from the exception. UD2 is not an
> > unconditional fail. It should have an out-going edge in this case too.
> 
> Yes, CFI failures are not recoverable in that code. In fact, LLVM
> assumes that the llvm.trap intrinsic (i.e. ud2) never returns, but I
> suppose we could just use an int3 instead. I assume that's sufficient
> to stop speculation?

Peter, is there a reason you want things in the specific order of:

cmp, je-to-call, trap, call

Isn't it more run-time efficient to have an out-of-line failure of
the form:

cmp, jne-to-trap, call, ...code..., trap, jmp-to-call

I thought the static label stuff allowed the "default out of line"
option, as far as pessimizing certain states, etc? The former is certainly
code-size smaller, though, yes, but doesn't it waste space in the cache
line for the unlikely case, etc?

> > Also, you really should add a CS prefix to the retpoline thunk call if
> > you insist on using r11 (or any of the higher regs).
> 
> I actually didn't touch the retpoline thunk call, that's exactly the
> code Clang normally generates.
> 
> > > How would you like to deal with the 4-byte hashes in objtool? We
> > > either need to annotate all function symbols in the kernel, or we need
> > > a way to distinguish the hashes from random instructions, so we can
> > > also have functions that don't have a type hash.
> >
> > Easiest would be to create a special section with all the hash offsets
> > in I suppose. A bit like -mfentry-section=name.
> 
> OK, I'll take a look. With 64-bit hashes I was planning to use a known
> prefix, but that's not really an option with a 32-bit hash.

32-bit hashes would have both code size and runtime benefits: fewer
instructions for the compare therefore a smaller set of instructions
added.

-- 
Kees Cook
