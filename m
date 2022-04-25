Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F950E8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiDYS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiDYS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:59:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E31229C4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:56:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k12so3458166lfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jyx9VAg/T+a6pNMMHSmxlNhkA8BQhETmaaAMOL1rXa4=;
        b=tMZZ4zxj/dpWyU3rAZ+bHBaebx7EadCioxFOZg3u5Qd1IYmurkN6KMIasZpgF+4q1U
         sEQrPMz2QE88U9mUTYSZMfkE4M1jbkZaSsQYjBlhRflcU4+02VligPLY/L4k16twt00q
         0nTEO0hLBY6CwhOoYNngs4tckWqXE8mt0UEepcOJonLUo4hmrPT0OcQnYUVN0tGbcKoN
         j4r9JAOEEmStoAOjEw8TjyKStjfoPjm8mT44GSDSfzj8C861Iqyqx8KmM+/dLFxQ1WUV
         tmwR8a2SUscwFpNZnFjuuCASZW7m3DrSvYl2mQrNqiDIqLBOfmUBvOqjBODYpfVUj7jm
         1I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jyx9VAg/T+a6pNMMHSmxlNhkA8BQhETmaaAMOL1rXa4=;
        b=DtDa3W4xOLo2B/rv3p8UM8/Uq5qtl0anAGmfotHQ5dZJ0wJ56TulpJc87YM0vhgJSj
         FuB0tHGW2Qxik4rxvCCa/cOI/BdZpsOY/QVz+Tm165tlFN2HIEWRSg0K0rhU0D3GpyVv
         sqqtkfFpwv3hhFXa8+0Q2RI8EbKNkyuup1D8cmWx85LDggZhOfgm4+/5OpCdjARLasBi
         C5A5BP/dK2RGsMfnBsup4LqAS+6Czrf2bF8hc8tO588fnJ4y5xo4oQUqj6mWfaohJNUE
         ugb+dhRo4AFCGba1cllku8fCkW6PJ5QljsyWeASPwPGRqw+6qABdLnnm2dV8Y3Z/sE1u
         4sMQ==
X-Gm-Message-State: AOAM532H0M1OR4DHD5aSJ1hQW++vtNhrBXlbdnQpMylMAkThSq3zZF5W
        B17TvCXSFEur1/u3dw76Xtge4bP4w+tMWt38pQBUh38Wuhw=
X-Google-Smtp-Source: ABdhPJwkk9WfalacarRaRB/KsFrIqj7GGz2BZSMlaebEITrcDACJMvRtAXqr5dD4RghjVmzivFfFVQPqB6LoZOyJS7g=
X-Received: by 2002:ac2:4646:0:b0:472:108e:51af with SMTP id
 s6-20020ac24646000000b00472108e51afmr1773669lfo.184.1650912988676; Mon, 25
 Apr 2022 11:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-7-masahiroy@kernel.org> <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
In-Reply-To: <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:56:17 -0700
Message-ID: <CAKwvOdmeOYsBGSZrprdtoxcUmpy1oscnBfLUaSARPNKsH4Aeug@mail.gmail.com>
Subject: Re: [PATCH 06/27] modpost: use bool type where appropriate
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Mon, Apr 25, 2022 at 11:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> /On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 60 +++++++++++++++++++++----------------------
> >  scripts/mod/modpost.h | 10 ++++----
> >  2 files changed, 35 insertions(+), 35 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index f9cbb6b6b7a5..52dd07a36379 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -203,10 +203,10 @@ struct symbol {
> >         struct symbol *next;
> >         struct module *module;
> >         unsigned int crc;
> > -       int crc_valid;
> > +       bool crc_valid;
> >         char *namespace;
> > -       unsigned int weak:1;
> > -       unsigned int is_static:1;  /* 1 if symbol is not global */
> > +       bool weak;
> > +       bool is_static;         /* true if symbol is not global */
> >         enum export  export;       /* Type of export */
> >         char name[];
> >  };

This will change the sizeof(struct symbol).  I'm guessing we have lots
of symbols to process? If we have many live at once, perhaps it would
be better to keep these as bitfields, but additionally move them to
the end of the struct definition so as to save space?
-- 
Thanks,
~Nick Desaulniers
