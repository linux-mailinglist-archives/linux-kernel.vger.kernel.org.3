Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC24E594C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiCWTnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiCWTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:43:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F858BE00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:41:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q5so3321366ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQrBGFwucrBKBVfXucD62w2ROKP/3gosyL/mFvFuauw=;
        b=SBbwCPeyER6bdPDyzhQl8Ssg5BBoNYoxM4wuCfgnDMBpBaTxeqvdt/O+JMNniz4Myr
         AdkoKTp8pj5cEZ7B1s7i22BAAMAln1zN/s5LGOGGUaXqkEyoeXmpJZGsd41WBh8obao9
         pYKhcJps1P+IYJoqKMNmjNrvkWb20OvKGDggaxBL0ZGg9vSo1RzjWYXyLsF1PerHnr2c
         nsO8JOb+kjtiZDBdztqa00hyErV3EmCPRUTp3rN2xNNIbbqRgWpKrkDPz/uLFOdiCcjQ
         jkNlTUj3B8eSsD8dx+YpoFkZcoeocthFtBuffFjS9zUnTUK3XTXSLwCp7gYoYqVSHr4R
         5bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQrBGFwucrBKBVfXucD62w2ROKP/3gosyL/mFvFuauw=;
        b=H1/JYsq1ZKUyN1TMKOJ9uccxOfwviBAW81w3C1Q2MPPn5vFz7bA0UOLXklLzIw8CRN
         uqpYUadiwXw/gd5XD2Aw+4cXRl1xWAXJJL2zTzBF0Pw7VeVQU/SlGRbKL3C4RHJa/HWC
         IhJ9Oe09fJw4PzB3Ql7y2SCokQD1AAjdiVcwMWxlAYwVSzlubmoLZeohrRn35DEvjbTT
         SVSml5dIYdULojedlouvzBx3Uz9VdF4QhzzjPPiLhNgp8cYm4pfA44f+lm9dw237aGO0
         5w2DwcDh3a0i7skSm4+aNUIPYUaOGECpAGNC6e8WeGMdpWZHZgZX1E9Y6RkXqtg922Fi
         bzyQ==
X-Gm-Message-State: AOAM530RDr9NVM0HXk1HfXPEdCjJVXNPkWjLCvSvoP2cGMuUanhJKQnH
        dGamyO6pXKJ91c8CYB+ljR44iwC0rNFM1nXLAnjArg==
X-Google-Smtp-Source: ABdhPJyPxaAkqjgQxr5Z0ufChFc+QxnVh2jtJFdKm1AViJ4raOtJ6ZSMiIycQXnGSjwQAoCxO1pVGEbNU+SzucsBVqo=
X-Received: by 2002:a2e:904c:0:b0:23e:d7ad:3fdd with SMTP id
 n12-20020a2e904c000000b0023ed7ad3fddmr1318780ljg.239.1648064503179; Wed, 23
 Mar 2022 12:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com>
In-Reply-To: <CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 23 Mar 2022 12:41:31 -0700
Message-ID: <CAKwvOdmSV3Nse+tGMBXvN=QvnOs6-ODZRJB0OF5Pd6BVb-scFw@mail.gmail.com>
Subject: Re: [PATCH] x86: bug.h: merge annotate_reachable into _BUG_FLAGS for __WARN_FLAGS
To:     Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        jpoimboe@redhat.com
Cc:     adobriyan@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org, llvm@lists.linux.dev,
        luc.vanoostenryck@gmail.com, mingo@redhat.com, nathan@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:30 PM Charlemagne Lasse
<charlemagnelasse@gmail.com> wrote:
>
> > @@ -75,9 +77,9 @@ do {                                \
> >   */
> >  #define __WARN_FLAGS(flags)                    \
> >  do {                                \
> > +    __auto_type f = BUGFLAG_WARNING|(flags);        \
> >      instrumentation_begin();                \
> > -    _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));        \
> > -    annotate_reachable();                    \
> > +    _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);            \
> >      instrumentation_end();                    \
> >  } while (0)
>
> This causes following sparse warning on x86:
>
> make allnoconfig && touch init/version.c && make CHECK="sparse
> -Wshadow"  C=1 init/version.o
> #
> # No change to .config
> #
>  CALL    scripts/checksyscalls.sh
>  CALL    scripts/atomic/check-atomics.sh
>  CHK     include/generated/compile.h
>  CC      init/version.o
>  CHECK   init/version.c
> init/version.c: note: in included file (through
> include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h,
> include/linux/utsname.h):
> ./include/linux/rcupdate.h:1007:9: warning: symbol 'f' shadows an earlier one
> ./include/linux/rcupdate.h:1001:47: originally declared here

Thanks for the report. There was already a fix sent for this:
https://lore.kernel.org/lkml/20220317065743.8467-1-mailhol.vincent@wanadoo.fr/
but it doesn't mention that sparse is warning about this, too.

I think if Vincent sent a v3 that mentioned that sparse is warning
about this, too, and cc'ed you, you could then supply
signed-off/tested-by tags (or just do so on v2, though it doesn't
mention sparse), and maybe Josh would be so kind as to pick that up?

>
>
> Affected versions (from the ones on kernel.org):
>
> * 5.17 - bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into
> _BUG_FLAGS() asm")
> * 5.16.17 - fe0c95903a68 ("x86/bug: Merge annotate_reachable() into
> _BUG_FLAGS() asm")
>
> Cannot be seen when changing the variable name:
>
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index bab883c0b6fe..cbd11e38252a 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -77,9 +77,9 @@ do {                                \
>   */
>  #define __WARN_FLAGS(flags)                    \
>  do {                                \
> -    __auto_type f = BUGFLAG_WARNING|(flags);        \
> +    __auto_type __f = BUGFLAG_WARNING|(flags);        \
>      instrumentation_begin();                \
> -    _BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);            \
> +    _BUG_FLAGS(ASM_UD2, __f, ASM_REACHABLE);            \
>      instrumentation_end();                    \
>  } while (0)



-- 
Thanks,
~Nick Desaulniers
