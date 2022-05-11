Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DDC523D69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiEKT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiEKT3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:29:12 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319DF1367;
        Wed, 11 May 2022 12:29:08 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24BJSoZ9018134;
        Thu, 12 May 2022 04:28:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24BJSoZ9018134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652297330;
        bh=EaTId7H8QGxZ4wR/UutapdHBioVSBlwASrI8kZas40s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S17erul53RNIeBjJYir+J8mpHUWqK7sXKHJMWRa/l2xSCxZgrdV1dU3+5hX9DFRPB
         CxgugLFeqTZ4qkrOp/w8aAs9LC1q5WTQ18lo39qoonMr7iIjV8mWFGdEhV4ZCcs80q
         2791ONW4kWbmvpu0bg8Ie6WMg2pBrWyRDmAD0TVba9wY0wF1xKvLuuao/XsCXNDByB
         38FzgA8r7So3M8VePGduejUpewfBieSKGIXseq+GW7ZP4YbOEsCZ9Y+Cm76syaoNJ6
         t7jCNxWrBvLyml46hUxkvSFtyWpcS1C/UwFi4wohFk8Ysn7VrS2i2PxIpRBTLc+/r3
         YjPePFoJdPHHA==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso2975792pjg.0;
        Wed, 11 May 2022 12:28:50 -0700 (PDT)
X-Gm-Message-State: AOAM530Sk2S5gpR8eoR0AEnHcHmWIS8+HImf5ur29pRT6pczkG3LLJcl
        +WzvlT0pUi+j8EBsjQ41t0G7SEzyQ1Br31/6EfI=
X-Google-Smtp-Source: ABdhPJxpFvdEXgne/7yspfTVFpO5mJeb/64Ugd7xcTnf7hLoDN02lbCll4CkYvhtMmE1NpBHpwbzLRyJwjcVkvMYkaw=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr26952485plh.99.1652297329721; Wed, 11
 May 2022 12:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <20220508190631.2386038-4-masahiroy@kernel.org> <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
 <CAK7LNARGNEDzPPUsPjDXsXUUUPSFK2erQRuyPocR_v5hTYRihg@mail.gmail.com> <CAKwvOdmK4oH0t8Q6F19sWKX1fT=AgS=kfvn05FT01HffLJwgMQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmK4oH0t8Q6F19sWKX1fT=AgS=kfvn05FT01HffLJwgMQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 May 2022 04:27:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5preB59HJH1-F_ZfEmoF3N8b9z4eRhYzsEVwu_XUH4Q@mail.gmail.com>
Message-ID: <CAK7LNAR5preB59HJH1-F_ZfEmoF3N8b9z4eRhYzsEVwu_XUH4Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] modpost: split the section mismatch checks into section-check.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 3:48 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, May 9, 2022 at 11:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > > index a78b75f0eeb0..e7e2c70a98f5 100644
> > > > --- a/scripts/mod/modpost.c
> > > > +++ b/scripts/mod/modpost.c
> > > > @@ -31,7 +31,7 @@ static bool external_module;
> > > >  /* Only warn about unresolved symbols */
> > > >  static bool warn_unresolved;
> > > >
> > > > -static int sec_mismatch_count;
> > > > +int sec_mismatch_count;
> > >
> > > ^ this should go in modpost.h if it is to be used in two translation
> > > units, rather than forward declaring it in section-check.c.  You did
> > > this for the functions.
> >
> >
> > Sorry, I do not understand.
> >
> >
> > In modpost.h, I put the declaration:
> >
> >   extern int sec_mismatch_count;
> >
> > If I moved it to the header without 'extern'
> > I would get multiple definitions.
>
> Yeah, you need to _declare_ it w/ extern in the header, then _define_
> it in one source file.
>
> That way, if the type ever changes, the sources will agree on type in
> all source files. You will get a redefinition error if the definition
> changes the type of the variable since the last declaration.
>
> What you're doing is forward declaring, which works, and is a common
> pattern for (bloated) C++, but is less type safe than sharing a single
> common declaration between multiple source files via a single common
> shared header. (Sorry I didn't respond before you sent v5)

Sorry, I still do not understand your suggestion.


Could you provide me with a code diff
showing how to do this better?



-- 
Best Regards
Masahiro Yamada
