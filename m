Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31813514042
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbiD2Bfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351487AbiD2Bfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:35:42 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73602BABB5;
        Thu, 28 Apr 2022 18:32:25 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23T1W9ZG016045;
        Fri, 29 Apr 2022 10:32:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23T1W9ZG016045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651195930;
        bh=Ujughm6WBYcOCP3I53TOnar0oX2NKjlKDBd45MpNh04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=10c3SuQy/Ub2pRoZYFp43HKwkLXn1CLCpuzFvYYJ1j21ADWYhTYXQkrfPsBwSNpTF
         iJiiapVdwOc7otybUAdqjpn0CKzLMWIrwxS18RqLFv7QXS5stgswcY88C95nD0BmQa
         VPQZ4O7rQR4GGVWilVhI1eKt4Uc6IWOd00+ahKrrd0K0WvU7NLZlpyiKG23a3PQKrL
         ejefKEEQIn5ZnvoAc+dJEXTvcRsjq5C+jKDLPLu0imnu1G5OZ/3myTfIEmIFrUUkb5
         PcS3vudQpz41uhOdpTplX4gJK7VlbhtDJgw0PthkHbcoEy6Uejb5/X5AvTAl/U1+R3
         Zm93CE04u5RYA==
X-Nifty-SrcIP: [209.85.215.178]
Received: by mail-pg1-f178.google.com with SMTP id k14so5419206pga.0;
        Thu, 28 Apr 2022 18:32:09 -0700 (PDT)
X-Gm-Message-State: AOAM531qsBCn7fhbMfLoiFNGFxcVDlW+iR18IIa1zHIgTtSNmeg69ahH
        zB3yLEftM2F6OB12AoMipE256BGvQxqV3j+GRWg=
X-Google-Smtp-Source: ABdhPJyWSxXsaQZA47SLxRqiIrVQj/xNc4xbL+oG7kW7OztbN7o+0qZy8I9k7qzl3YqxE++UsE3TiMzb9rdJGGEU13g=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr29679060pgb.616.1651195929017; Thu, 28
 Apr 2022 18:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-25-masahiroy@kernel.org> <CAKwvOdkJJnJt_jj_1n6QP31UoTqcS5aVUYAExdR8wY61EmRDFQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkJJnJt_jj_1n6QP31UoTqcS5aVUYAExdR8wY61EmRDFQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Apr 2022 10:31:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKctw8a7_OYuBnP16CrMKg=3PD4=GL4zJCYi6WZP1mpA@mail.gmail.com>
Message-ID: <CAK7LNASKctw8a7_OYuBnP16CrMKg=3PD4=GL4zJCYi6WZP1mpA@mail.gmail.com>
Subject: Re: [PATCH 24/27] modpost: generate linker script to collect symbol versions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 6:49 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Merge version CRCs per vmlinux or per module.
> >
> > These linker scripts will be fed to the final link stage.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  .gitignore            |  1 +
> >  Makefile              |  1 +
> >  scripts/mod/modpost.c | 27 +++++++++++++++++++++++++++
> >  3 files changed, 29 insertions(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 265959544978..f9dad6b917e6 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -42,6 +42,7 @@
> >  *.so.dbg
> >  *.su
> >  *.symtypes
> > +*.symver.lds
> >  *.symversions
> >  *.tab.[ch]
> >  *.tar
> > diff --git a/Makefile b/Makefile
> > index 235d68fa1470..0779db3d1c0c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1859,6 +1859,7 @@ clean: $(clean-dirs)
> >                 -o -name '*.c.[012]*.*' \
> >                 -o -name '*.ll' \
> >                 -o -name '*.gcno' \
> > +               -o -name '*.symver.lds' \
> >                 -o -name '*.*.symversions' \) -type f -print | xargs rm -f
> >
> >  # Generate tags for editors
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 43ab4f000ae3..ef779ada04c6 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2577,6 +2577,30 @@ static void write_dump(const char *fname)
> >         free(buf.p);
> >  }
> >
> > +static void write_symversions_lds(struct module *mod)
> > +{
> > +       struct buffer buf = { };
> > +       struct symbol *sym;
> > +       char lds_file[PATH_MAX];
> > +       int ret;
> > +
> > +       ret = snprintf(lds_file, sizeof(lds_file), "%s.symver.lds", mod->name);
> > +       if (ret >= sizeof(lds_file)) {
> > +               error("%s: too long path was truncated\n", lds_file);
> > +               return;
>
> If this exceptional case occurs, we should probably halt or return an
> error code to main?



Could you see the comments at the bottom of
scripts/mod/modpost.h  ?


error() functions sets 'error_occurred' variable,
so main() function will exist with 1 at the end.


If we bail out at the very first error, users would
compile the kernel again and again
to fix errors one by one.

modpost continues running as far as possible
to display as many errors as possible.

Compilers usually do similar things.








> > +       }
> > +
> > +       list_for_each_entry(sym, &mod->exported_symbols, list) {
> > +               if (!sym->crc_valid)
> > +                       continue;
> > +
> > +               buf_printf(&buf, "__crc_%s = 0x%08x;\n", sym->name, sym->crc);
> > +       }
> > +
> > +       write_if_changed(&buf, lds_file);
> > +       free(buf.p);
> > +}
> > +
> >  static void write_namespace_deps_files(const char *fname)
> >  {
> >         struct module *mod;
> > @@ -2673,6 +2697,9 @@ int main(int argc, char **argv)
> >                 char fname[PATH_MAX];
> >                 int ret;
> >
> > +               if (modversions && !mod->from_dump)
> > +                       write_symversions_lds(mod);
> > +
> >                 if (mod->is_vmlinux || mod->from_dump)
> >                         continue;
> >
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
