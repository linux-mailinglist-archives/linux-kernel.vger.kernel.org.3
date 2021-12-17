Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51947937E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhLQSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:04:43 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44931 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLQSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:04:41 -0500
Received: by mail-oi1-f173.google.com with SMTP id be32so4747313oib.11;
        Fri, 17 Dec 2021 10:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH97IwBNJIJm9oc3jMyoL+svzU4PCiOwNagYFbvofyA=;
        b=2Et8OwygE1L10RBck00k7sVUQaWiFSYSRYFVhd3b2x/tp2yV+WlFQgKpLYIgaX0v+2
         i85c035HAWmK7EeTCgeQ+AqNPBWpOiXiyuEffZEfXm35htnHbe1hqTm1ARKtYMXMZ8LS
         qtcDMqKU16EIUAW3nnyBkeg6xrpUURbriuT0f1mF+LplX8GMfz1uE8Sy0UHBDTC6MZ6h
         fTUJfvphaiWftPLlDOVgLiQrfy3eL/ENPzTMl0sAkZL8u6edMBsezmQpKZs+Rl268bhr
         gDhIAifNw9Fvs53yUF2EIAIgs2i/eMLYOkn6nRGBLLUhUHD4hTdocsKqZPRpqVd726w1
         VxeA==
X-Gm-Message-State: AOAM530G1p1lDh9/z+9gSvXZGlVHQhFQFPHwlig0NtXymJqvCn6D/tuT
        febMlys02jzcCLZ+IU6VrViorXGr9/8qcKkpp0gX4OtF
X-Google-Smtp-Source: ABdhPJwRHo+5sgFP4kB/Ch4fx9oQJANf8NwGSAyEUculPGz+k7dGdG/jGUuGpxoQUvCwgT1+eQSVEJdX9fu9fhUPSHg=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr3061880oiv.166.1639764281033;
 Fri, 17 Dec 2021 10:04:41 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-3-kirill.shutemov@linux.intel.com>
 <CAJZ5v0hGnvX2a1bsoUSqV4Vf0LE6P6wTjk4ZPT7JTLvSAL7z_g@mail.gmail.com> <20211209133217.omm3mzchsfippwjc@black.fi.intel.com>
In-Reply-To: <20211209133217.omm3mzchsfippwjc@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 19:04:30 +0100
Message-ID: <CAJZ5v0i2Le1id20qeMk6ENyBLU2FwOQJKXLLr_jOsPaaBrrAvg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: PM: Remove redundant cache flushing
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

On Thu, Dec 9, 2021 at 2:32 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Dec 07, 2021 at 05:35:38PM +0100, Rafael J. Wysocki wrote:
> > I don't think this is needed for S2, because the function doesn't do
> > anything low-level in that case and simply returns (IOW, S2 isn't
> > really supported).
>
> Updated patch is below. Does it look good?

It does, and so applied as 5.17 material with some minor edits in the changelog.

Thanks!

> From 5eb4ec7d8dd463ba186b779dcef2a802d999c59c Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Thu, 9 Dec 2021 16:08:02 +0300
> Subject: [PATCH 1/2] ACPI: PM: Remove redundant cache flushing
>
> ACPICA code takes care about cache flushing on S1/S2/S3 in
> acpi_hw_extended_sleep() and acpi_hw_legacy_sleep().
>
> acpi_suspend_enter() calls into ACPICA code via acpi_enter_sleep_state()
> for S1 or x86_acpi_suspend_lowlevel() for S3.
>
> acpi_sleep_prepare() call tree:
>   __acpi_pm_prepare()
>     acpi_pm_prepare()
>       acpi_suspend_ops::prepare_late()
>       acpi_hibernation_ops::pre_snapshot()
>       acpi_hibernation_ops::prepare()
>     acpi_suspend_begin_old()
>       acpi_suspend_begin_old::begin()
>   acpi_hibernation_begin_old()
>     acpi_hibernation_ops_old::acpi_hibernation_begin_old()
>   acpi_power_off_prepare()
>     pm_power_off_prepare()
>
> Hibernation (S4) and Power Off (S5) don't require cache flushing. So,
> the only interesting callsites are acpi_suspend_ops::prepare_late() and
> acpi_suspend_begin_old::begin(). Both of them have cache flush on
> ->enter() operation in acpi_suspend_enter().
>
> Remove redundant ACPI_FLUSH_CPU_CACHE() in acpi_sleep_prepare() and
> acpi_suspend_enter().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index eaa47753b758..5ca6c223ba3d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -73,7 +73,6 @@ static int acpi_sleep_prepare(u32 acpi_state)
>                 acpi_set_waking_vector(acpi_wakeup_address);
>
>         }
> -       ACPI_FLUSH_CPU_CACHE();
>  #endif
>         pr_info("Preparing to enter system sleep state S%d\n", acpi_state);
>         acpi_enable_wakeup_devices(acpi_state);
> @@ -566,8 +565,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>         u32 acpi_state = acpi_target_sleep_state;
>         int error;
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
>         switch (acpi_state) {
>         case ACPI_STATE_S1:
> --
>  Kirill A. Shutemov
