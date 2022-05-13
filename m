Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428D5260DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379848AbiEMLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiEMLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:20:20 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E92A7C03;
        Fri, 13 May 2022 04:20:18 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24DBK5Mb007622;
        Fri, 13 May 2022 20:20:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24DBK5Mb007622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652440806;
        bh=YRv/xzScxOrQW/8sn4wWLVoj5v+rd5AiWdMBOiUctKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UGqfwMzgeClovZLtU/GqthVETIVynVx++gBYzA2T8pfzgoyiaL4Z7jaKRI988iWEE
         vtC85R/npyGd6jNzXc9I2Nf3U96knFJSAPuQIiZjG3HPdTLxg28yPh0pKxUSE8/GqV
         Hg8542rC0YdVOgM6zl/fshK150AlPBFErNmnnsYvv5+moql/4PYhV6KZmmfg162el6
         dQ9IipdOPTYDYdeHcG+HyPej5i20f6QHl8zp3AiUydBrVFT/TFOyclr+5hu6CU++dF
         jozcIKEhhATo4P9sZBZs/lEvWgfNWW7Rd5VZ2ovWaf4kfOyQYX0CpHzySSY8L+XaoL
         N7/IyShNio5Rw==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id n18so7635257plg.5;
        Fri, 13 May 2022 04:20:06 -0700 (PDT)
X-Gm-Message-State: AOAM533FWOrhmkXkACOSLBkQjd6DpSJAWj8U6jgHUgF8+TlT1bc3vBlP
        f7OrAWBB4WPBYhMQIHNzh9iuzilDu2nTCFtt5WI=
X-Google-Smtp-Source: ABdhPJz0V9Y2MC7wSh+kiBkNiWNxINnBG3U6cqE/jpzo7kEQOTHjV4DFzyAxYOFsREJncHCrWOgIGQ61+cGpl/V6ZVE=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr4405025plh.99.1652440805394; Fri, 13 May
 2022 04:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org> <YnwWsYdL2khCikSY@dev-arch.thelio-3990X>
In-Reply-To: <YnwWsYdL2khCikSY@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 20:18:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATs67zGL7JohD-79Nxig25XCC=T9Dih4Z8iwdhoiWai8w@mail.gmail.com>
Message-ID: <CAK7LNATs67zGL7JohD-79Nxig25XCC=T9Dih4Z8iwdhoiWai8w@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, May 12, 2022 at 5:04 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Masahiro,
>
> On Thu, May 12, 2022 at 01:45:02AM +0900, Masahiro Yamada wrote:
> >
> > This is the third batch of cleanups in this development cycle.
> >
> > Major changes in v5:
> >  - Fix build errors
> >  - More cleanups
> >
> > Major changes in v4:
> >  - Move static EXPORT_SYMBOL check to a script
> >  - Some refactoring
> >
> > Major changes in v3:
> >
> >  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> >
> > Major changes in v2:
> >
> >  - V1 did not work with CONFIG_MODULE_REL_CRCS.
> >    I fixed this for v2.
> >
> >  - Reflect some review comments in v1
> >
> >  - Refactor the code more
> >
> >  - Avoid too long argument error
> >
> >
> >
> > Masahiro Yamada (12):
> >   modpost: split the section mismatch checks into section-check.c
> >   modpost: add sym_find_with_module() helper
> >   modpost: extract symbol versions from *.cmd files
> >   kbuild: link symbol CRCs at final link, removing
> >     CONFIG_MODULE_REL_CRCS
> >   kbuild: stop merging *.symversions
> >   genksyms: adjust the output format to modpost
> >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> >   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
> >   kbuild: make built-in.a rule robust against too long argument error
> >   kbuild: make *.mod rule robust against too long argument error
> >   kbuild: add cmd_and_savecmd macro
> >   kbuild: rebuild multi-object modules when objtool is updated
>
> I applied this series to your latest kbuild branch, built an Arch
> Linux x86_64 config and Fedora aarch64 config with
> CONFIG_LTO_CLANG_FULL=y then CONFIG_LTO_CLANG_THIN=y, and boot tested
> each kernel in QEMU with a full userspace. I did not notice any new
> warnings/errors and everything appears to work fine.
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> Cheers,
> Nathan


Thanks for your testing.

I ended up with v6 due to a build issue
of CONFIG_TRIM_UNUSED_KSYMS,
but this patch set is getting in good shape.

Thanks.


-- 
Best Regards
Masahiro Yamada
