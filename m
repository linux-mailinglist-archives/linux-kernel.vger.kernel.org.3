Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77446D818
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhLHQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:29:56 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39635 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhLHQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:29:55 -0500
Received: by mail-oi1-f178.google.com with SMTP id bf8so4792500oib.6;
        Wed, 08 Dec 2021 08:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QlMufJTFNT9Vlv4+AjFEwWUWEtafIKRof1v70zz+CQ=;
        b=zi0yp4MpYrYKTuLziNNrXxwj5OYTHR48Nxo4N9q9g4zDgwrhdrIqIFucjOlPSrBiPH
         tTSXosVebp3zraHBtelvB1/JFNglmO6S1sA4d0tZ56oONd5BfupByqUchoRXzYdYEa0n
         MHatpkfA9n00tMJcLVXvOCHYzKcFPRMeYXGJG8+rGelA6/9HlGmkv7BtvU9N5AskVWE5
         twMTkxqBOxRhmC0FsZrtYykAwjjjjt3F9Rxqoxc3EKnSyPrnEXamiqrJ7QgdxH6vLD1L
         tafQAuOyOwwbNH4311fzcltLUnrrBsNGKQ13m5UMAcnGYeSe+rrGblqYGi5y6uymTKT7
         D+Qw==
X-Gm-Message-State: AOAM530SO0SeY+4ejl41UwSuQyKXU8IAdHqOhTq/L04ZECPwYNQQnTUy
        l3+ilyatWLn/w7fYVRDjIwl7B2IZbiPvenycSTk=
X-Google-Smtp-Source: ABdhPJxJ3fAV2TWfgdNnVCyB2a7/UMGSRKzTH2CjKdQVUDpC8XZGb/+27um+mGrUKok9PraxdxDiW+Bd1hsbgLUSOA4=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr409139oiv.166.1638980783303;
 Wed, 08 Dec 2021 08:26:23 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-4-kirill.shutemov@linux.intel.com>
 <Ya4mTij+eQPq8dnu@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya4mTij+eQPq8dnu@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 17:26:12 +0100
Message-ID: <CAJZ5v0hjcKn0g=Tc90aK_EchOG+sWi8na1HVb0GdtQsYn7sAKQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: processor idle: Only flush cache on entering C3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, Dec 6, 2021 at 4:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 06, 2021 at 03:29:51PM +0300, Kirill A. Shutemov wrote:
> > According to the ACPI spec v6.4, section 8.2, cache flushing required
> > on entering C3 power state.
> >
> > Avoid flushing cache on entering other power states.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  drivers/acpi/processor_idle.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index 76ef1bcc8848..01495aca850e 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -567,7 +567,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> >  {
> >       struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
> >
> > -     ACPI_FLUSH_CPU_CACHE();
> > +     if (cx->type == ACPI_STATE_C3)
> > +             ACPI_FLUSH_CPU_CACHE();
> >
>
> acpi_idle_enter() already does this, acpi_idle_enter_s2idle() has it
> confused again,

No, they do the same thing: acpi_idle_enter_bm() if flags.bm_check is set.

> Also, I think acpi_idle_enter() does it too late; consider
> acpi_idle_enter_mb(). Either that or the BM crud needs more comments.

I think the latter.

Evidently, acpi_idle_play_dead(() doesn't support FFH and the BM
thing, so it is only necessary to flush the cache when using
ACPI_CSTATE_SYSTEMIO and when cx->type is C3.
