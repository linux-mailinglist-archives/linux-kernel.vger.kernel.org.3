Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9390950EF66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiDZDvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDZDvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:51:39 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A13DA4F;
        Mon, 25 Apr 2022 20:48:32 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 23Q3mB6i015155;
        Tue, 26 Apr 2022 12:48:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 23Q3mB6i015155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650944892;
        bh=y6/rvmkM95vGYJ9fBgVGtZQNaJV+rI6jfwWP2zG3AQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dvCa4QabLdmsYvdBlQJp1QZ0WmCtYqWWPuyZcaQVdD6vPvKpK2MblYRUGJ4Kcky4K
         o/UBqLfxSOnYf5q/p7T9ejT0kACXucHEJ5f3BWPfeIqTK5gG8OLKqM728SSI53il3y
         gLt17rYu+LiNCclS/HtZjewEn+kc9AkfCSqhiLDoJm/nrP8M8yCfagn+2N1WRQzJ3j
         LZbUvI3gjLt53OsQmNtOT/TC2H2qHcyGgpFqBTRdveesIEZDoXJfgFQv8chLBpZEnD
         ayJlDDe49Wl9eedL3A/ERTcWSrnk/mlpY/wMnNMx5/TRffRbyeO3FKk+Y/1PhjBy00
         zbGxF3j+vTicg==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id c12so29027966plr.6;
        Mon, 25 Apr 2022 20:48:11 -0700 (PDT)
X-Gm-Message-State: AOAM531NMJlRNRI4fjSMik3QbUnYmlQwvrlo0R30XqG6UCAZpvwXdnjy
        3FxKCZ4+A8DdvPJm3G5DYmMmaUpCoNDTYVK62hE=
X-Google-Smtp-Source: ABdhPJy+gy3JQQWnTPpG6wyiDemg8TpW9KI6gdaqQkwfyFCtTwij5EjAnI/+/FnHZbzNa3BgZaUSMrbSINIXhscDRQA=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr24272106pjy.77.1650944890951; Mon, 25
 Apr 2022 20:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-3-masahiroy@kernel.org> <CAKwvOdnTh+qVRHsQ3YRrZ8b22wmfVUQ3eLd7R8VHJgNw7WA=MQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnTh+qVRHsQ3YRrZ8b22wmfVUQ3eLd7R8VHJgNw7WA=MQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Apr 2022 12:47:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATu9sRTCvJj2yWu874WrFCOsH0d=em3oHy-Y0WyAS5Z4g@mail.gmail.com>
Message-ID: <CAK7LNATu9sRTCvJj2yWu874WrFCOsH0d=em3oHy-Y0WyAS5Z4g@mail.gmail.com>
Subject: Re: [PATCH 02/27] modpost: do not write out any file when error occurred
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:15 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > If an error occurs, modpost will fail anyway. Do not write out
> > any content (, which might be invalid).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> The callers could probably do less work before calling write_buf, too,
> but this is ok.

There are two call-sites for write_buf().

I thought it is better to add this if-conditional
in the callee instead of the callers.





> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> >  scripts/mod/modpost.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 141370ebbfd3..f0d48f65fb33 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2333,6 +2333,9 @@ static void write_buf(struct buffer *b, const char *fname)
> >  {
> >         FILE *file;
> >
> > +       if (error_occurred)
> > +               return;
> > +
> >         file = fopen(fname, "w");
> >         if (!file) {
> >                 perror(fname);
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
