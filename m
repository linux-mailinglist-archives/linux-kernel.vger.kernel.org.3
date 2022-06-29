Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01855F378
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiF2CqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiF2CqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:46:12 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FD22BD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 19:46:11 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 25T2jrox026729
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:45:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 25T2jrox026729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656470754;
        bh=XuRRlV6DEIohD5LwyniED6YKhD1PNvGzty9vC0eaPEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VYAeGbpN0CHJ3SntlK30JJguH7UZgMetFseKlwixXVAtSheRMEWSXpvDkL8IelisQ
         LdwoNEp/cFLNJgaf4gQkv8iky9sJ5ys8hxmwgHk8P1QCsvKjjGnDmIWWGZOsuXf/tG
         0wcuFLlP1inhBeS9khIDdraktlpREvr1aK51UPcpZicgCh5oZLN4FOW7pMy0Vd92cl
         c0fviKw44cIAL8FZklxksUC57eV9sj3AOVj1wq3RqwtN48pIqLgN2AfrGBGz3unn4g
         FfSZD6sauc6zbW1V/m5pkYgy+YdDqlPTybETtea2cLazk9ALfc9GJaj5/KSF/MLQzX
         icyZn4KrxmsFg==
X-Nifty-SrcIP: [209.85.128.42]
Received: by mail-wm1-f42.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso5140169wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 19:45:53 -0700 (PDT)
X-Gm-Message-State: AJIora/BjfMSbLB+T/GdlyLsMQ8fMbBNM2x+D6LWuX5PPHZGInOeVamS
        v7NHXq9jTWk7a2jOOqwDmkkwCCGRraG+5nLKJ10=
X-Google-Smtp-Source: AGRyM1ut30owDvv4LD+D7QwQ8t9dPthCnosocOkLOBSLKfdzxyW9Jyt0o7WQIGA8+R3aSMTrPRKuJ+0eutSDqouMbyo=
X-Received: by 2002:a1c:6a06:0:b0:3a0:5099:f849 with SMTP id
 f6-20020a1c6a06000000b003a05099f849mr2804764wmc.14.1656470752486; Tue, 28 Jun
 2022 19:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220628012353.13995-1-jhubbard@nvidia.com> <CAKwvOd=FmKYse9NEvMt5MHev5wRzeZH6AcBd1uQEL5k0GLP+Zw@mail.gmail.com>
In-Reply-To: <CAKwvOd=FmKYse9NEvMt5MHev5wRzeZH6AcBd1uQEL5k0GLP+Zw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 29 Jun 2022 11:45:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5cmfAvZWy-QrrrBZcOoHwcuRO=JY9SUgBGbOxv=Kt5A@mail.gmail.com>
Message-ID: <CAK7LNAT5cmfAvZWy-QrrrBZcOoHwcuRO=JY9SUgBGbOxv=Kt5A@mail.gmail.com>
Subject: Re: [PATCH v3] gen_compile_commands: handle multiple lines per .mod file
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 3:45 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 6:24 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
> > each .mod file only contains one line. That assumption was correct when
> > the script was originally created, but commit 9413e7640564 ("kbuild:
> > split the second line of *.mod into *.usyms") changed the .mod file
> > format so that there is one entry per line, and potentially many lines.
> >
> > The problem can be reproduced by using Kbuild to generate
> > compile_commands.json, like this:
> >
> >     make CC=clang compile_commands.json
> >
> > In many cases, the problem might be overlooked because many subsystems
> > only have one line anyway. However, in some subsystems (Nouveau, with
> > 762 entries, is a notable example) it results in skipping most of the
> > subsystem.
> >
> > Fix this by fully processing each .mod file.
> >
> > Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the fix, John!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>



Applied to linux-kbuild/fixes with Nick's reviewed-by.
Thanks.


-- 
Best Regards
Masahiro Yamada
