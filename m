Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3D49E0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiA0L0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:26:49 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48852 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiA0L0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:26:48 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20RBQU8V021491;
        Thu, 27 Jan 2022 20:26:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20RBQU8V021491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1643282791;
        bh=RkEfetbAwyaUhGDT+EAfXqGsSOduHgaH5G5FwAahVv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2yqGvMFVnZnm5EncvLDkncnwfLXuX/lQhe94ikeoTObRS08+sRpzyNhcJE5C7GZsF
         8vwzgG1N/XWaEgJgZrKb7Bm7wNbW3asmraCHzOPPDetsLu7Fe1BuITnHaRfXk2RuB4
         U1NavlE/YPa2paEtlIBf6gxXJm1ynMmFod0gS2qFrvSWbzRNEjAuq+6nU961NoBCtJ
         4pWxIzaPX0bWnTtOeitStFbpW/MuCNfsn4pn65CVYfnbm3kJujSZmKe4S4xkXfFYbb
         OmeEO4wndG85iDBayWcB4aW+v0RNO2ja/zKy0g4orvDZzm3S02phfV0byE90sgeKBN
         5J2Sljzs07T7g==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id g2so2003426pgo.9;
        Thu, 27 Jan 2022 03:26:31 -0800 (PST)
X-Gm-Message-State: AOAM532iInOYajZLlficeeR0d065ANhtpGIPleWvR/r5VeCV1jLvmtGz
        g6PxmCBJrcIFTAkdKcu+WkGe5IzeGwN65QC6Yxo=
X-Google-Smtp-Source: ABdhPJxylLzS7QiwRjU95VnYBhK6t0BqF1mUWAON9YxU6ylmqVuezv2muXVgvl9NwL8CyMo7NifaCtd0QaHlfL3IfXA=
X-Received: by 2002:a65:58cc:: with SMTP id e12mr2486659pgu.126.1643282790440;
 Thu, 27 Jan 2022 03:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com> <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Jan 2022 20:25:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQ3oW0rQz0M5xvWGqYmFZPeB2bgrdLUBobCRVNvoWZyA@mail.gmail.com>
Message-ID: <CAK7LNATQ3oW0rQz0M5xvWGqYmFZPeB2bgrdLUBobCRVNvoWZyA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Matthias Maennich <maennich@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:21 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:

>
> >
> >  config CC_HAS_ASM_GOTO
> >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > index 1c2ae1368079..6a8c7dd9ccaf 100644
> > --- a/usr/include/Makefile
> > +++ b/usr/include/Makefile
> > @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
> >  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> >  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> >
> > +# USERCFLAGS might contain sysroot location for CC
> > +UAPI_CFLAGS += $(USERCFLAGS)
> > +
> Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)


I do not think so.

usr/include/Makefile does not link the objects.

(  $(CC) -S   stops after the compilation stage)




--
Best Regards
Masahiro Yamada
