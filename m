Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A9479361
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhLQR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:51 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34777 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbhLQR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:35 -0500
Received: by mail-oi1-f172.google.com with SMTP id t19so4785611oij.1;
        Fri, 17 Dec 2021 09:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ju8OzVEWeqn38Sxf5W5cqeLG9DtSTl3egiQMpAHM4i8=;
        b=CsraecoNhjbXeJ6828TcHiyeg7eZ9u5HmStLTXiDw9Uitq2GM0PaMGUhy+tEVH5PcZ
         FeQOBvIEmGCRnKjgR1t2GGHrS2+H3iiENKZJ3+PnpxzZtejKqyCGUbtNRj4MY7mX55TF
         zzRwz5qpQrFaOvQkx9TaZfeT6DjDjk2o6SCxrIxeBXSybuoEmZvUsc6tIZd+TL1soQuk
         0pQbe3PRLANfyGKQ5Ulq8Si0uChZY3CpkAQxsZYElW7FAv1RWLGn6WXk5NioF76Pgc+/
         l1lz8CmQZU1ga8z/NxuMfi0eJIS4RcQDW3wd4bn4o/b5pc/sOoEnP4W9pl9Ssiq7eZUm
         1isg==
X-Gm-Message-State: AOAM532M8KtY6W8ZsgaVcoTD9+bDz8hOENDZZSQdb7SpDB+VrwrGnVOa
        PwigGDsJUocACtJN3VL4ZxTReeCYHTkbxdnxU9cKq4pe
X-Google-Smtp-Source: ABdhPJzS1nTc55coW+SAnqOI8mx8RMuP/8ef94L5FdLgyqetV9XmNddl8qfFPkc2VOHITxa05DYcOqbfuLm5tT+1eMU=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr3035678oiv.166.1639763914916;
 Fri, 17 Dec 2021 09:58:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-4-kirill.shutemov@linux.intel.com>
 <Ya4mTij+eQPq8dnu@hirez.programming.kicks-ass.net> <CAJZ5v0hjcKn0g=Tc90aK_EchOG+sWi8na1HVb0GdtQsYn7sAKQ@mail.gmail.com>
 <20211209133335.u4suzd2u5sjly67l@black.fi.intel.com>
In-Reply-To: <20211209133335.u4suzd2u5sjly67l@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 18:58:23 +0100
Message-ID: <CAJZ5v0hsqzT1e8QuaYYC=q+vEmFurruUcLoRH0ng8EZ98LccSQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: processor idle: Only flush cache on entering C3
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 2:33 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Dec 08, 2021 at 05:26:12PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 6, 2021 at 4:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Dec 06, 2021 at 03:29:51PM +0300, Kirill A. Shutemov wrote:
> > > > According to the ACPI spec v6.4, section 8.2, cache flushing required
> > > > on entering C3 power state.
> > > >
> > > > Avoid flushing cache on entering other power states.
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >  drivers/acpi/processor_idle.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > > > index 76ef1bcc8848..01495aca850e 100644
> > > > --- a/drivers/acpi/processor_idle.c
> > > > +++ b/drivers/acpi/processor_idle.c
> > > > @@ -567,7 +567,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> > > >  {
> > > >       struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
> > > >
> > > > -     ACPI_FLUSH_CPU_CACHE();
> > > > +     if (cx->type == ACPI_STATE_C3)
> > > > +             ACPI_FLUSH_CPU_CACHE();
> > > >
> > >
> > > acpi_idle_enter() already does this, acpi_idle_enter_s2idle() has it
> > > confused again,
> >
> > No, they do the same thing: acpi_idle_enter_bm() if flags.bm_check is set.
> >
> > > Also, I think acpi_idle_enter() does it too late; consider
> > > acpi_idle_enter_mb(). Either that or the BM crud needs more comments.
> >
> > I think the latter.
> >
> > Evidently, acpi_idle_play_dead(() doesn't support FFH and the BM
> > thing, so it is only necessary to flush the cache when using
> > ACPI_CSTATE_SYSTEMIO and when cx->type is C3.
>
> I'm new to this and not completely follow what I need to change.
>
> Does it look correct?

It does, but I liked the original one more and so that one has been
applied as 5.17 material (with some edits in the changelog).

Thanks!

> From 3c544bc95a16d6a23dcb0aa50ee905d5e97c9ce5 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Thu, 9 Dec 2021 16:24:44 +0300
> Subject: [PATCH] ACPI: processor idle: Only flush cache on entering C3
>
> According to the ACPI spec v6.4, section 8.2, cache flushing required
> on entering C3 power state.
>
> Avoid flushing cache on entering other power states.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/processor_idle.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 76ef1bcc8848..d2a4d4446eff 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -567,7 +567,9 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (cx->entry_method == ACPI_CSTATE_SYSTEMIO &&
> +           cx->type == ACPI_STATE_C3)
> +               ACPI_FLUSH_CPU_CACHE();
>
>         while (1) {
>
> --
>  Kirill A. Shutemov
