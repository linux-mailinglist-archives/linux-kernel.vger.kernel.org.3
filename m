Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268448824A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiAHIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:25:08 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42905 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiAHIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:25:07 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2088OqeH012151;
        Sat, 8 Jan 2022 17:24:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2088OqeH012151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641630292;
        bh=TbdjDNO+Q/SwpeiTR3GVh3jB2vGZgy9KPGTIvbxN99c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fyOjxZPfRed4DJHlJRu+Rjn/Z/btni5wxUyKMJdRhL1So8H9qXcAMy3pvbhhyrQg0
         BUQ4IV1iXk5MmhMRb7RL2V6vQ7xTK8QsqTJ98WH+0LGVTbq7IEF4LMdT6nu0Euqhtu
         hw73iuKcmCbfoQtpdfDCe9JsEjOmPm/AZPf4VEJPab9+DHdq+ZyM6dJgRdV7r1b7+2
         9sCQa+3XTFgV9OBZjoP5sYUdzSDX8IVBfgRZz5W17vDI85TSDq1zM/KFlI79EYP0Kw
         pkPAjuaIFoHMLLS/IlK1f5S+FhXa1hhY7Flrm0I7dkeP2i+fUH/ciH38lWflwADM9x
         LY5OEDIVMOAqA==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id m13so7217562pji.3;
        Sat, 08 Jan 2022 00:24:52 -0800 (PST)
X-Gm-Message-State: AOAM531PVglc/BdBPKG5t6NHzi9KyMBDEBCDV9hMMH/LNZ0Q99q0/SaI
        In209Z12x8QWS30nenyYVtMCW/GSk/EI9q7whdg=
X-Google-Smtp-Source: ABdhPJwfTzWh9wdEopdDStQmgjQats2BwCAqc+8NIRakCNnwG6GlLMMvK+YLEg/cBUarVapOhdyIXZATo3FtM1z/xrQ=
X-Received: by 2002:a17:902:b206:b0:149:3b5d:2b8b with SMTP id
 t6-20020a170902b20600b001493b5d2b8bmr64851631plr.162.1641630291846; Sat, 08
 Jan 2022 00:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20211206023507.447574-1-masahiroy@kernel.org> <YdiLO0VstqY66LyP@archlinux-ax161>
In-Reply-To: <YdiLO0VstqY66LyP@archlinux-ax161>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Jan 2022 17:24:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVyVwp6xe6crWfVmt33Si-VMFZtD2LmgcMrBrOLDtv4A@mail.gmail.com>
Message-ID: <CAK7LNATVyVwp6xe6crWfVmt33Si-VMFZtD2LmgcMrBrOLDtv4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: move headers_check.pl to usr/include/
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 3:49 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Masahiro,
>
> On Mon, Dec 06, 2021 at 11:35:06AM +0900, Masahiro Yamada wrote:
> > This script is only used by usr/include/Makefile. Make it local to
> > the directory.
> >
> > Update the comment in include/uapi/linux/soundcard.h because
> > 'make headers_check' is no longer functional.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >  - Fix the comment in soundcard.sh to point to the new file path
> >
> >  include/uapi/linux/soundcard.h            | 2 +-
> >  usr/include/Makefile                      | 2 +-
> >  {scripts => usr/include}/headers_check.pl | 0
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >  rename {scripts => usr/include}/headers_check.pl (100%)
> >
> > diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
> > index f3b21f989872..ac1318793a86 100644
> > --- a/include/uapi/linux/soundcard.h
> > +++ b/include/uapi/linux/soundcard.h
> > @@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
> >   *   the GPL version of OSS-4.x and build against that version
> >   *   of the header.
> >   *
> > - *   We redefine the extern keyword so that make headers_check
> > + *   We redefine the extern keyword so that usr/include/headers_check.pl
> >   *   does not complain about SEQ_USE_EXTBUF.
> >   */
> >  #define SEQ_DECLAREBUF()             SEQ_USE_EXTBUF()
> > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > index 1c2ae1368079..0e9c3e72f43a 100644
> > --- a/usr/include/Makefile
> > +++ b/usr/include/Makefile
> > @@ -99,7 +99,7 @@ quiet_cmd_hdrtest = HDRTEST $<
> >        cmd_hdrtest = \
> >               $(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
> >                       $(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
> > -             $(PERL) $(srctree)/scripts/headers_check.pl $(obj) $(SRCARCH) $<; \
> > +             $(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
> >               touch $@
> >
> >  $(obj)/%.hdrtest: $(obj)/%.h FORCE
> > diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
> > similarity index 100%
> > rename from scripts/headers_check.pl
> > rename to usr/include/headers_check.pl
> > --
> > 2.32.0
> >
> >
>
> After this patch landed in -next, with a completely clean tree, I see:
>
> $ make clean
>   CLEAN   usr/include
>
> $ git status --short
>  D usr/include/headers_check.pl
>
> Is something like this needed?
>
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 0e9c3e72f43a..6e9dfd657e89 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -105,4 +105,4 @@ quiet_cmd_hdrtest = HDRTEST $<
>  $(obj)/%.hdrtest: $(obj)/%.h FORCE
>         $(call if_changed_dep,hdrtest)
>
> -clean-files += $(filter-out Makefile, $(notdir $(wildcard $(obj)/*)))
> +clean-files += $(filter-out headers_check.pl Makefile, $(notdir $(wildcard $(obj)/*)))

Ah, right.
I will squash this.
Thanks.



-- 
Best Regards
Masahiro Yamada
