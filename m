Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA64846C0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhLGQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:39:26 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42999 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhLGQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:39:20 -0500
Received: by mail-oi1-f169.google.com with SMTP id n66so28623255oia.9;
        Tue, 07 Dec 2021 08:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31mjd/csqFEQKru4ee4D/rvYNR1wxLp+wwKZbiHux2g=;
        b=QvxLCriqtH6BSPLrSwkDPp2nwdNgYGtUTi+2/g2FjvYo8VfllzKuR9YsLgQFEzkeDg
         TND7Np0u8l+xIpT5fHefwDeF+7sx2WQziHd+NX5iyQeX9DZ5rPzMjlrH7L6shNX/DXei
         uuYRyoNAirI3gXDF5Pdgtz/iX80UhzXRBOsf4h3MREBeNcrMpuxnNVHE68GTvt86XbU1
         dJ//xps/8T9ScrBQA/QF1PPmRVYuHZUwVZCxKoIfvOO7RQe/tikXtOZoB/HnK1YKcx69
         fY0dHlg4u14AvQzREMh3N7ijGFXka7xs3Vl688EdNLiBTlLdiC8+c9YqO0zXT3Zq0Cd2
         O5ig==
X-Gm-Message-State: AOAM530Tf/wmuXxiuEJL+yhN5SrP9Rj3R1uz3p02j7focRMglmdGQtGx
        zU3TYGZ1ck084nAn1oTcmYKVyrKeTB43E+fCr8E=
X-Google-Smtp-Source: ABdhPJzbBKOhECxZ5Fu3Bq2Y18qzwDOUfSloASSqP8c4P625s7x/rH/HOywYNNoMhCTzUVtD6pKCl5rKiys9YNoF4nc=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr6067044oil.166.1638894949491;
 Tue, 07 Dec 2021 08:35:49 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com> <20211206122952.74139-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20211206122952.74139-3-kirill.shutemov@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Dec 2021 17:35:38 +0100
Message-ID: <CAJZ5v0hGnvX2a1bsoUSqV4Vf0LE6P6wTjk4ZPT7JTLvSAL7z_g@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 1:30 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> ACPICA code takes care about cache flushing on S1/S2/S3 in
> acpi_hw_extended_sleep() and acpi_hw_legacy_sleep().
>
> acpi_suspend_enter() calls into ACPICA code via acpi_enter_sleep_state()
> for S1 or x86_acpi_suspend_lowlevel() for S3. It only need to flush
> cache for S2 (not sure if this call path is ever used for S2).
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
>  drivers/acpi/sleep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index eaa47753b758..14e8df0ac762 100644
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
> @@ -566,15 +565,15 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>         u32 acpi_state = acpi_target_sleep_state;
>         int error;
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
>         switch (acpi_state) {
>         case ACPI_STATE_S1:
>                 barrier();
>                 status = acpi_enter_sleep_state(acpi_state);
>                 break;
> -
> +       case ACPI_STATE_S2:
> +               ACPI_FLUSH_CPU_CACHE();
> +               break;

I don't think this is needed for S2, because the function doesn't do
anything low-level in that case and simply returns (IOW, S2 isn't
really supported).

>         case ACPI_STATE_S3:
>                 if (!acpi_suspend_lowlevel)
>                         return -ENOSYS;
> --
> 2.32.0
>
