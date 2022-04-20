Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C90508DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380854AbiDTRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbiDTRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:06:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF245ACA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:03:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w19so4084461lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7zb1xdIGcft5KjuxIXD0kd0kTQrpdi1VZ2GPgmEzCU=;
        b=AHchmSeXuHzXFDUaDgShvRCai8mLpYZHd/Imhy9PfmG7BoVBOFGjipRXP1uF0PSBu6
         +54jbccrghzcIdzQMoEUsausJaWugrfKGRAgqmHVK77pgSOXgRFd8rl87rCOJMHNUYvp
         weMtyfTg9hhExJqY3sS5LVAibtl2kSY1IVE9mwZctXAwtwgD24INRV8g/jlbv+uV9EOp
         u0mYeOprHb5d4xEtf7XTaZnpfnH/1cz/5szBV8GyfTh5I+eCd8Fpop1l5bEwhBfNidWS
         HTJvmKlKPbh33QUS075nUcrTqtb8fV4c6JtOmswU+v2IrbPGHiaomec5GkeHp4S5gPaB
         eBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7zb1xdIGcft5KjuxIXD0kd0kTQrpdi1VZ2GPgmEzCU=;
        b=5og/TWNfh46pSek03LwAj7trdeujDpAKEjNll+ztjAmBZ6I38Z5OSQ8AyG5wJxywD2
         CDbR3MB1OY0MtVdagL89iMuurUKiXuTHo2FjpK7X9evteF1e/paqGufuN/6yNcydweHs
         E2JY0XNhuZpzIIQISP79hY0o73W0YcQwTeS9VsYDMkx0h11oUQV9yWmtQbZTY0/STS5r
         gjZ9/TVW76AhWRiXj2NV9cxExY+zngNwP1Im8F9SjmAvfmxjVIDZ6XIjZdO7M/S4UgxH
         x50NGohMNJSyVIezoFFd6m11k6kuZp+30fFlDNa3eS7vAJOnA3f8dygnPMFl1g5d8jRQ
         iVkw==
X-Gm-Message-State: AOAM531YRM3yTiZVSNOhCszXeMBzwsfEYQcfy/+Ku///xPvZCP29Vq1M
        CPA4x6HfXLbl/hgTdNJ2faOPFTLJoKIPchG/2DD/oQ==
X-Google-Smtp-Source: ABdhPJwlL+rR/JdeNcR55WjSnzsYjxZvuzSa6/v0HYURltBvwerT1CbZDnju2U8/G0YnGAawsSrS4iJrm5RlpNhKR+A=
X-Received: by 2002:a05:6512:1293:b0:471:a1bb:d55d with SMTP id
 u19-20020a056512129300b00471a1bbd55dmr8469599lfs.190.1650474209797; Wed, 20
 Apr 2022 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com> <20220409004821.tcztejr2cgsieqaq@treble>
In-Reply-To: <20220409004821.tcztejr2cgsieqaq@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Apr 2022 10:03:18 -0700
Message-ID: <CAKwvOdmfUDZPyhtF5fvdKy7i-qRKB7Bmq80DhP0F=yarG+rnpw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 5:48 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Apr 09, 2022 at 03:29:21AM +0900, Masahiro Yamada wrote:
> > > But with -O2, once-called static functions are almost always inlined, so
> >
> > "always inlined" per GCC manual.
> >  -O2, -O3, -O3 enables  -finline-functions-called-once
>
> Not necessarily.  The manual also says:
>
>        -finline-functions-called-once
>            Consider all "static" functions called once for inlining into
>            their caller even if they are not marked "inline".  If a call
>            to a given function is integrated, then the function is not
>            output as assembler code in its own right.
>
> So it "considers" inlining them, but it doesn't guarantee it.  And when
> I looked at the GCC code some months ago I remember seeing a few edge
> cases where it would inline.
>
> > > its usefulness for rooting out mismatch warnings on other configs is
> > > somewhere between extremely limited and non-existent.  And nowadays we
> > > have build bots everywhere doing randconfigs continuously, which are
> > > great for rooting out such edge cases.
> > >
> > > Somewhat ironically, the existence of those build bots means we get a
> > > lot of unrealistic objtool warnings being reported, due to unrealistic
> > > inlines caused by CONFIG_DEBUG_SECTION_MISMATCH, where the only way to
> > > silence the warnings is to force a single-called function to be inlined
> > > with '__always_inline'.
> > >
> > > So the limited, hypothetical benefit of "rooting out configs with
> > > section mismatches" is outweighed by the very real downside of "adding
> > > lots of unnecessary '__always_inline' annotations".
> >
> >
> > I am confused with the description because
> > you are talking about two different warnings.
> >
> > [1]  modpost warning  (section mismatch)
> > [2]  objtool warnings
>
> It's all a bit confusing.
>
> To clarify: in theory, the point of CONFIG_DEBUG_SECTION_MISMATCH was to
> trigger more *modpost* warnings.  (It may do that, but the extra
> warnings are probably not realistic.  And even if they were realistic on
> some configs, they would be found by modpost warnings on those configs
> found by build bots.)
>
> But CONFIG_DEBUG_SECTION_MISMATCH is also triggering more *objtool*
> warnings, which is a problem because the warnings are not realistic...
>
> > For [1], you can add __init marker to the callers,
> > and that is the right thing to do.
>
> Yes, either add __init to the caller or remove __init from the callee.
>
> But even if such "inlined single caller" modpost warnings correspond to
> real world configs (which is very questionable) then we'd expect them to
> show up in real-world randconfig bot testing, without having the need
> for CONFIG_DEBUG_SECTION_MISMATCH to root out the rare edge cases.
>
> > Is [2] caused by dead code that was not optimized out
> > due to the unusual inlining decisions by the compiler ?
>
> As Peter mentioned it was due to validation of SMAP uaccess rules.
>
> > If the issues are all about objtool,
> > "depends on !STACK_VALIDATION" might be
> > an alternative approach?
> >
> > config DEBUG_SECTION_MISMATCH
> >            bool "Enable full Section mismatch analysis"
> >            depends on CC_IS_GCC
> >            depends on !STACK_VALIDATION        # do not confuse objtool
>
> Yes, that would be another way to handle it.  Though that means the
> option would effectively be dead on x86-64.

Does this series help (or is it related to this thread)?
https://lore.kernel.org/lkml/cover.1650300597.git.jpoimboe@redhat.com/
Patch 17/25 seems to make STACK_VALIDATION unwinder-dependent (on
CONFIG_UNWINDER_FRAME_POINTER)?

>
> > Now that -Og was already rejected, the possible flag for building the kernel is
> > -O2, O3, -Os.
> > All of them enable -finline-functions-called-once.
> >
> > So, there is no practical case for -fno-inline-functions-called-once
> > unless we explicitly enable it.
>
> Agreed.
>
> > I am OK with this patch, I am still wondering if this could be useful
> > to detect missing __init markers.
>
> So there's two ways to look at this question: at a source level and at a
> binary level.
>
> At a source level, if there's a non-init function which inlines a
> single-called __init function, and modpost doesn't notice it (because
> the __init function doesn't access any __init symbols), then the __init
> function wrongly has the __init annotation.  But calling that a bug is
> very questionable, because it's not a real bug in the binary.  IMO it's
> not worth worrying about, when we have real bugs to fix.
>
> At a binary level, if there's a real section mismatch bug with a given
> config, modpost will warn about it.  This option doesn't affect that.
>
> --
> Josh
>


-- 
Thanks,
~Nick Desaulniers
