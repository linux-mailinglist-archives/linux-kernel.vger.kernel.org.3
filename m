Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B6524381
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiELDgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbiELDge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:36:34 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A871193F4;
        Wed, 11 May 2022 20:36:29 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24C3aGkF002223;
        Thu, 12 May 2022 12:36:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24C3aGkF002223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652326576;
        bh=VfPskzDmMntcl9mOqDJFkJyKAm5vxKV4Z3wLx5ippe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wczmTP5mRu9Q317XJvLADN30/rapQ66Vfla6MIyrp18RHxIaKFeAT4+xr4zeIISQq
         oGFMJr+2+heyZtd3YgKLMEbPMOBkiN6nQptq+2B3WvQQdXRhulos+pFiuVp2N5HV0E
         R/sGhpELffEpxbJfvkejvFoaD/raChJoWGo0ojHfZai5Tsx0alQMNhUZCLI9vkuxhk
         bydVjwohwSrac2NzoG9lrJDJvopGWUxlLRNkQXkvddB2aMgya3T0WlRKIWXa4wDEI7
         HZLJQi923Fv3P0XSIH3QQXAQURvpmPmIcLeK26RbFEIANAizUGnltOaGFZMtREQYCV
         tvc17ZeCQB7zw==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id l11so3438485pgt.13;
        Wed, 11 May 2022 20:36:16 -0700 (PDT)
X-Gm-Message-State: AOAM530ISyFLKiEC4x4j6zxlON80FgQvaIoNg56GGSx1q+KP084kHdRJ
        69Vyscq3u/hIYCqdtq7u0jqNx+QutkNtKehwf18=
X-Google-Smtp-Source: ABdhPJwUO93A4rM+aSh1Xly4NyDaW5KDkFVzu77d9cJuQFpEQOKPBQtyfzCWZaOT5taGjU3JP75XcJ9pj9AegKGofJA=
X-Received: by 2002:a63:6989:0:b0:3c2:3c19:d661 with SMTP id
 e131-20020a636989000000b003c23c19d661mr23420542pgc.352.1652326575675; Wed, 11
 May 2022 20:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org>
 <20220511164514.2741934-2-masahiroy@kernel.org> <CAKwvOdkMqyssbZ9imYM8Re+NL4U1K2tYj37_1XUtmjj8LSt5GQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkMqyssbZ9imYM8Re+NL4U1K2tYj37_1XUtmjj8LSt5GQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 May 2022 12:35:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASToQxJsySjvpdkr_aHKBh1ZrECwswWpgCezDHcpRHVgQ@mail.gmail.com>
Message-ID: <CAK7LNASToQxJsySjvpdkr_aHKBh1ZrECwswWpgCezDHcpRHVgQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] modpost: split the section mismatch checks into section-check.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 7:31 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 11, 2022 at 9:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > -/* sections that we do not want to do full section mismatch check on */
> > -static const char *const section_white_list[] =
> > -{
> > -       ".comment*",
> > -       ".debug*",
> > -       ".cranges",             /* sh64 */
> > -       ".zdebug*",             /* Compressed debug sections. */
> > -       ".GCC.command.line",    /* record-gcc-switches */
> > -       ".mdebug*",        /* alpha, score, mips etc. */
> > -       ".pdr",            /* alpha, score, mips etc. */
> > -       ".stab*",
> > -       ".note*",
> > -       ".got*",
> > -       ".toc*",
> > -       ".xt.prop",                              /* xtensa */
> > -       ".xt.lit",         /* xtensa */
> > -       ".arcextmap*",                  /* arc */
> > -       ".gnu.linkonce.arcext*",        /* arc : modules */
> > -       ".cmem*",                       /* EZchip */
> > -       ".fmt_slot*",                   /* EZchip */
> > -       ".gnu.lto*",
> > -       ".discard.*",
> > -       NULL
> > -};
>
>
> > -/**
> > - * Whitelist to allow certain references to pass with no warning.
> > - *
> > - * Pattern 1:
> > - *   If a module parameter is declared __initdata and permissions=0
> > - *   then this is legal despite the warning generated.
> > - *   We cannot see value of permissions here, so just ignore
> > - *   this pattern.
> > - *   The pattern is identified by:
> > - *   tosec   = .init.data
> > - *   fromsec = .data*
> > - *   atsym   =__param*
> > - *
> > - * Pattern 1a:
> > - *   module_param_call() ops can refer to __init set function if permissions=0
> > - *   The pattern is identified by:
> > - *   tosec   = .init.text
> > - *   fromsec = .data*
> > - *   atsym   = __param_ops_*
> > - *
> > - * Pattern 2:
> > - *   Many drivers utilise a *driver container with references to
> > - *   add, remove, probe functions etc.
> > - *   the pattern is identified by:
> > - *   tosec   = init or exit section
> > - *   fromsec = data section
> > - *   atsym = *driver, *_template, *_sht, *_ops, *_probe,
> > - *           *probe_one, *_console, *_timer
> > - *
> > - * Pattern 3:
> > - *   Whitelist all references from .head.text to any init section
> > - *
> > - * Pattern 4:
> > - *   Some symbols belong to init section but still it is ok to reference
> > - *   these from non-init sections as these symbols don't have any memory
> > - *   allocated for them and symbol address and value are same. So even
> > - *   if init section is freed, its ok to reference those symbols.
> > - *   For ex. symbols marking the init section boundaries.
> > - *   This pattern is identified by
> > - *   refsymname = __init_begin, _sinittext, _einittext
> > - *
> > - * Pattern 5:
> > - *   GCC may optimize static inlines when fed constant arg(s) resulting
> > - *   in functions like cpumask_empty() -- generating an associated symbol
> > - *   cpumask_empty.constprop.3 that appears in the audit.  If the const that
> > - *   is passed in comes from __init, like say nmi_ipi_mask, we get a
> > - *   meaningless section warning.  May need to add isra symbols too...
> > - *   This pattern is identified by
> > - *   tosec   = init section
> > - *   fromsec = text section
> > - *   refsymname = *.constprop.*
> > - *
> > - * Pattern 6:
> > - *   Hide section mismatch warnings for ELF local symbols.  The goal
> > - *   is to eliminate false positive modpost warnings caused by
> > - *   compiler-generated ELF local symbol names such as ".LANCHOR1".
> > - *   Autogenerated symbol names bypass modpost's "Pattern 2"
> > - *   whitelisting, which relies on pattern-matching against symbol
> > - *   names to work.  (One situation where gcc can autogenerate ELF
> > - *   local symbols is when "-fsection-anchors" is used.)
> > - **/
>
> Losing the ability to git blame (from the top level) the above lines
> does cause me grief and mental anguish though. It's not gone, just
> buried a bit deeper.


According to 'man git-blame', -C option is needed
to follow the code move between files.

git blame -C  scripts/mod/section-check.c

showed me the origin commit of each line.





> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
