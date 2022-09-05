Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B08A5ACA4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiIEGDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIEGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:02:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBC27B01
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:02:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so9902710edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=edmn50Vdr8CPFMgvqRUnbx91H9EF2ON8JP3AwsipmZE=;
        b=VhRi547AQiDivyZoYSm0f1tc2E7lVi6QpMeh0DuCpMB3NLse4DPapHt5Yt8AhYsNup
         wgZKSRw+mg5JnrLrHSw5X2OE9AG8yeKYy2c9aGdSknom+Hq1CKnPjTGGfqlccVmbZFlr
         iRtAxGNZPskpRHjzmckjsmcFlhCppgoDBxt8JifGftqEFP7Wpay2wXvC1AtbLytxY3Wu
         elr4R+zYFHTJXXd+psqDH/xdjijFqKJvSpTsADGjCAHNPFck4DnOqYPfoBraCMbeAjAx
         Q21P7S1FFJ4hmirNvYm55IZs4On5jZ7Yrx+8aO2UrnRUnbAkPWREhGGH7d6EtgJWYCHm
         Bg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=edmn50Vdr8CPFMgvqRUnbx91H9EF2ON8JP3AwsipmZE=;
        b=CtXxM5PqpJqHvYu7VLyP3tBei8C+def/bj6GmOLCJyT3CSWIpNGFOSzd1szcaMaVQa
         gK0i6IljPPAjOST0oTuNZKKJtC3ZVngxoZV4Eae8tVb5VwOUM/ZZ9UgEyVlT4vYOc377
         eZKORN4+wXx1UtrPm5PFj0lXJXoH6F+WFZ00RodqWqURIvYoTaiLID15aFKeANRRnBUm
         SbGntqMACK7izECc88raIA6WYOINkwNuFbBKa6CoeChvfZyoNETl8kNFh8gJxDq/V3nR
         TZJfTIAh2zaL/hFnLAsCZBqfDrgVJmmhUdUfd6D7J6QAVR5KNoST2d84nKcWFeSAra+L
         qLaw==
X-Gm-Message-State: ACgBeo1bbwnGENxwGtS8hEOLtRFZF6sMNBxfYLGK2zY2YC/N9NQI8hlk
        IhjF5YtZpK4NdNP5LV7kQW+JJA3zw4lmeieKxF6o
X-Google-Smtp-Source: AA6agR7XwBkHT3nkU8Z3vv3FZuczgAgC2/x69uVSNF3ZNafLhgJ1cPUUQE5bkUT+gWiu4bTYwoFpnl0XYODzych61WQ=
X-Received: by 2002:aa7:c61a:0:b0:44e:7d1d:7814 with SMTP id
 h26-20020aa7c61a000000b0044e7d1d7814mr3349413edq.44.1662357770273; Sun, 04
 Sep 2022 23:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com> <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
In-Reply-To: <202209022251.B14BD50B29@keescook>
From:   Bill Wendling <morbo@google.com>
Date:   Sun, 4 Sep 2022 23:02:38 -0700
Message-ID: <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Juergen Gross <jgross@suse.com>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > [...]
> >         callq   *pv_ops+536(%rip)
>
> Do you know which pv_ops function is this? I can't figure out where
> pte_offset_kernel() gets converted into a pv_ops call....
>
This one is _paravirt_ident_64, I believe. I think that the original
issue Nathan was seeing was with another seemingly innocuous function.

> > [...]
> > --- a/arch/x86/include/asm/paravirt_types.h
> > +++ b/arch/x86/include/asm/paravirt_types.h
> > @@ -414,8 +414,17 @@ int paravirt_disable_iospace(void);
> >                               "=c" (__ecx)
> >  #define PVOP_CALL_CLOBBERS   PVOP_VCALL_CLOBBERS, "=a" (__eax)
> >
> > -/* void functions are still allowed [re]ax for scratch */
> > +/*
> > + * void functions are still allowed [re]ax for scratch.
> > + *
> > + * The ZERO_CALL_USED REGS feature may end up zeroing out callee-saved
> > + * registers. Make sure we model this with the appropriate clobbers.
> > + */
> > +#ifdef CONFIG_ZERO_CALL_USED_REGS
> > +#define PVOP_VCALLEE_CLOBBERS        "=a" (__eax), PVOP_VCALL_CLOBBERS
> > +#else
> >  #define PVOP_VCALLEE_CLOBBERS        "=a" (__eax)
> > +#endif
> >  #define PVOP_CALLEE_CLOBBERS PVOP_VCALLEE_CLOBBERS
>
> I don't think this should depend on CONFIG_ZERO_CALL_USED_REGS; it should
> always be present.
>
> I've only been looking at this just now, so many I'm missing
> something. The callee clobbers are for functions with return values,
> yes?
>
Kinda. It seems that the usage here is to let the compiler know that a
register may be modified by the callee, not just that it's an "actual"
return value. So it's suitable for void functions.

> For example, 32-bit has to manually deal with doing a 64-bit value return,
> and even got it wrong originally, fixing it in commit 0eb592dbba40
> ("x86/paravirt: return full 64-bit result"), with:
>
> -#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax)
> +#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax), "=d" (__edx)
>
> But the naming is confusing, since these aren't actually clobbers,
> they're input constraints marked as clobbers (the "=" modifier).
>
Right.

> Regardless, the note in the comments ...
>
>  ...
>  * However, x86_64 also have to clobber all caller saved registers, which
>  * unfortunately, are quite a bit (r8 - r11)
>  ...
>
> ... would indicate that ALL the function argument registers need to be
> marked as clobbers (i.e. the compiler can't figure this out on its own).
>
Good point. And there are some forms of these macros that specify
those as clobbers.

> I was going to say it seems like they're missing from EXTRA_CLOBBERS,
> but it's not used with any of the macros using PVOP_VCALLEE_CLOBBERS,
> and then I saw the weird alternatives patching that encodes the clobbers
> a second time (CLBR_ANY vs CLBR_RET_REG) via:
>
> #define _paravirt_alt(insn_string, type, clobber)       \
>         "771:\n\t" insn_string "\n" "772:\n"            \
>         ".pushsection .parainstructions,\"a\"\n"        \
>         _ASM_ALIGN "\n"                                 \
>         _ASM_PTR " 771b\n"                              \
>         "  .byte " type "\n"                            \
>         "  .byte 772b-771b\n"                           \
>         "  .short " clobber "\n"                        \
>         ".popsection\n"
>
> And after reading the alternatives patching code which parses this via
> the following struct:
>
> /* These all sit in the .parainstructions section to tell us what to patch. */
> struct paravirt_patch_site {
>         u8 *instr;              /* original instructions */
>         u8 type;                /* type of this instruction */
>         u8 len;                 /* length of original instruction */
> };
>
> ... I see it _doesn't use the clobbers_ at all! *head explode* I found
> that removal in commit 27876f3882fd ("x86/paravirt: Remove clobbers from
> struct paravirt_patch_site")
>
> So, I guess the CLBR_* can all be entirely removed. But back to my other
> train of thought...
>
[switches stations]

> It seems like all the input registers need to be explicitly listed in
> the PVOP_VCALLEE_CLOBBERS list (as you have), but likely should be done
> unconditionally and for 32-bit as well.
>
Possibly, though it may cause significant code degradation when the
compiler needs to store a value that's live over the ASM statement,
but the register it's in isn't actually modified. I saw that in the
example I gave in the description. In the case where a "movq" is used,
there's a useless move of "rdi" into "r11".

> (Also, please CC linux-hardening@vger.kernel.org.)
>
Doh! Someday I'll learn email.

-bw
