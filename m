Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8ED5B1036
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIGXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGXKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:10:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C69C121B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:10:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 65so5865275pfx.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
        b=fHmNShdgI4dnC6hErvVoYwXgDNbgsvnYw6M/vzNGlywwNb8ieN/SlRLVWwpWKkoSu1
         vq0hcEhlT+GKynnWf9AqlWHeUPpZL08URJGii/8YbtzlfJ0IfDSoFsIU4KgaZEj4R4uU
         m+2r1/Ucjkq3qLNSD1SgrXHQXWlvKtbJxGq1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
        b=WaCyJofOBsXjrqjeIyFLj00C6lAYX+SqzgjlIsxlBc8HLMsu2LIxk850uOES/wpGrL
         pDzSDOXwOhoBmQo7oDSncEbymLtL41F67UBoOX6O0mzcADGaJE4WHPSHIInx89D1k8ml
         QXStgRwQs+DuG5E+oKqZPRFafsJ5WtJcvpA8Db7OFMPZXr+Otwy/4+rlzDNpErwCQrZj
         BeVJLgM1Zn1J9j0o395yleIsZ7KRYJrbDphaffYfjR6Ng9jezL6kXl9yVFACc1IVT44h
         B5NmBc7m1Wjdg+b8UysTb5fEQ+CnxpWWyiZWB3kguTRxERJwbeTsRloCnNCqwMl6rUXC
         095A==
X-Gm-Message-State: ACgBeo0tcw3Zpe1OlS6txtZX/ctK1miWdLM51JNup5Y1UM9WsFQOLT/J
        mkPVnobTVTo4RWuDm+xSxcuOWA==
X-Google-Smtp-Source: AA6agR5mOZptHzyKX2MhRGXlipNiPACZtnxxJGgxQ8tn93t85KvuvocH+td73K+d6+k4fFh4O61YPw==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id p33-20020a631e61000000b0041c045d7d50mr5135945pgm.507.1662592245677;
        Wed, 07 Sep 2022 16:10:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b00537ab89c66csm13683408pfi.143.2022.09.07.16.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:10:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:10:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <202209071609.BE5BF18D6@keescook>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > [...]
> > > > >         callq   *pv_ops+536(%rip)
> > > >
> > > > Do you know which pv_ops function is this? I can't figure out where
> > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > >
> > > This one is _paravirt_ident_64, I believe. I think that the original
> > > issue Nathan was seeing was with another seemingly innocuous function.
> > 
> > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > really needs to not be touched at all by the compiler for
> > these...special features.
> 
> My source tree sayeth:
> 
>   u64 notrace _paravirt_ident_64(u64 x)

I don't see noinstr either. But it seems a reasonable thing to do?

Bill, does fixing up the noinstr macro and adding it here fix the
problem?

-- 
Kees Cook
