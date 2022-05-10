Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B588520EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiEJHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiEJHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:01:19 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFC7485B;
        Mon,  9 May 2022 23:57:17 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24A6v5AW020352;
        Tue, 10 May 2022 15:57:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24A6v5AW020352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652165826;
        bh=PV2VZBmSw1vDAIYTzEMhuv3Dcr29T/TFTi8FpUXKvKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TUwfcbJvXyEvqS8U11pqWqNmRgJzRZaBOGmPCphF+IP2bpDlMx0L9NSHPo3LizD+b
         ELmgfisgYc9Dkdfvq4jo1FzJ1HT3wtSW1w2WlGbqLoHqey20jM14N6UUlxyj/mqBYA
         AX/7/fcgrEQKWf4o2Zv+TXLqUdtc6CF5huKQGAPLIQ13xqP42a7sMHmvWBHcUd/52y
         JT8vHBu7Mujdb7nuqsZriXtv80/x/2pyM6DL4/oZWrEoTN/1Q96Wh7GOpeZL/rATQL
         5wBCqpzWAUMi+noWjumXUHN2+1tdLCI8yrM0t16SPITEcCss048Fs238DeWc/mEgKv
         dRLJIW9zg0/lQ==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id d17so15983766plg.0;
        Mon, 09 May 2022 23:57:05 -0700 (PDT)
X-Gm-Message-State: AOAM532+bBKE4On1YzhYdFxIOjgwVyBIsN1qCcdz5QyhzROXdItt9Ugc
        5cv7j7RqgQ9VTPjBqmYZA0XcfXG2VqFG3NBmv8E=
X-Google-Smtp-Source: ABdhPJyUsO6qgOPcuwMWkhoVbg96fdtrT2KcjbMF4Q1DKsxKckAJcwFdS+O5hh4okyU+VxKrQY62LHgpgdtJmiFstPc=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr21441512pjy.77.1652165824961; Mon, 09
 May 2022 23:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <20220508190631.2386038-4-masahiroy@kernel.org> <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
In-Reply-To: <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 May 2022 15:55:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARGNEDzPPUsPjDXsXUUUPSFK2erQRuyPocR_v5hTYRihg@mail.gmail.com>
Message-ID: <CAK7LNARGNEDzPPUsPjDXsXUUUPSFK2erQRuyPocR_v5hTYRihg@mail.gmail.com>
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

On Tue, May 10, 2022 at 2:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > modpost.c is too big, and the half of the code is for section checks.
> > Split it.
> >
> > I fixed some style issues in the moved code.
>
> It would be helpful for review if the split and restyle were distinct
> patches.  Otherwise I can't tell what has changed.
>
> This does lose the ability to use git blame to get more context on
> some of the oddities in modpost (which I have found useful in the
> past).  I don't feel strongly though.


OK, I will just move the code in v5.





> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index a78b75f0eeb0..e7e2c70a98f5 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -31,7 +31,7 @@ static bool external_module;
> >  /* Only warn about unresolved symbols */
> >  static bool warn_unresolved;
> >
> > -static int sec_mismatch_count;
> > +int sec_mismatch_count;
>
> ^ this should go in modpost.h if it is to be used in two translation
> units, rather than forward declaring it in section-check.c.  You did
> this for the functions.


Sorry, I do not understand.


In modpost.h, I put the declaration:

  extern int sec_mismatch_count;

If I moved it to the header without 'extern'
I would get multiple definitions.







--
Best Regards
Masahiro Yamada
