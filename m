Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB146D7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhLHQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:19:55 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:43818 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbhLHQTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:19:54 -0500
Received: by mail-oo1-f51.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso953181oow.10;
        Wed, 08 Dec 2021 08:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwFWtoKE4vVog1yGDsJGm0AcWb/VEx+43Ax3eUNTpkU=;
        b=dNvtoHHv6IVKLTYQG5hKmurSsQA8EX7eeJGm+Gwhj+X7/42LoIxiCPixWgYBraX8EY
         ICjjHvSy4kqlfKAsvhERIYLlrCyEC+mpAwRPI/2Kc/blEFLvU5CvsAYLYokjywgsmBtL
         IGROG52hujN43BCcsz9BnqtjmzJZPgxck9/znsRHfeo/bf5NIpXHwK3mq9YIE0Tj2nQd
         pDp6AN+VJI+jifOffguCRxQt6mkK6aBnpftq58t6PlN40xAbW+mjgzxrNftGOuTJFFa2
         4MP9bqsovPeBNz+yhxNJeUA60J8R4WVntkbZCF/imzOipcN/E/uH4V/P8guJbdsJ9jh+
         cHEw==
X-Gm-Message-State: AOAM532LyHM8jsfBDDVDfx6t914uZvCk9fRLDfGq2hoUtBwrmifWvbEc
        Acmj8RHvQjXs+41cm//ZgYSCNq+DDig7xxEPWPI=
X-Google-Smtp-Source: ABdhPJxHhipy1K98dWWjyZf8/N1uXhF3mAOMhZoUsYZ30DhMHuuY8PxnGuUdDNVqs7mu/uwsJA5hDb8mwHcpACa9h7k=
X-Received: by 2002:a4a:ead8:: with SMTP id s24mr282257ooh.89.1638980182205;
 Wed, 08 Dec 2021 08:16:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-5-kirill.shutemov@linux.intel.com>
 <CAJZ5v0iH_CQC-ak_NQC5yONT-tFVC1iikSsfVWFh+z+QL5FKdg@mail.gmail.com> <20211208160450.3hplhtikjjvfrhts@black.fi.intel.com>
In-Reply-To: <20211208160450.3hplhtikjjvfrhts@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 17:16:11 +0100
Message-ID: <CAJZ5v0ghpZuDF0xpJ5ADVx-y8O_n5SM8VNP2O9OiXaUuFC2zsQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: PM: Avoid cache flush on entering S4
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Dec 8, 2021 at 5:04 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Dec 08, 2021 at 04:10:52PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 6, 2021 at 1:30 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > According to the ACPI spec v6.4, section 16.2 the cache flushing
> > > required on entering to S1, S2, and S3.
> > >
> > > No need to flush caches on hibernation (S4).
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  drivers/acpi/sleep.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index 14e8df0ac762..8166d863ed6b 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -902,8 +902,6 @@ static int acpi_hibernation_enter(void)
> > >  {
> > >         acpi_status status = AE_OK;
> > >
> > > -       ACPI_FLUSH_CPU_CACHE();
> > > -
> > >         /* This shouldn't return.  If it returns, we have a problem */
> > >         status = acpi_enter_sleep_state(ACPI_STATE_S4);
> > >         /* Reprogram control registers */
> > > --
> >
> > Applied (with some edits in the subject and changelog) as 5.17 material, thanks!
>
> Is it for the series or only 4/4?

Just for the [4/4].

> Do I need to do something for 2/4 and 3/4?

For [2/4] you do as per the comment and let me reply to the [3/4].
