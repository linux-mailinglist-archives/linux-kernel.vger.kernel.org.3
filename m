Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F404468774
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhLDUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:30:59 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46792 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhLDUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:30:58 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so8161266oto.13;
        Sat, 04 Dec 2021 12:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj9MDQSbqV6i4mMnhwh+WmM/WeOdP1QKhWD3Q5AgA3o=;
        b=owTMYA26uqRShDC72+3HhxkARuVCORm22UkQQ2NiN9pL6OiCdUindnWuo3HtvUy9lb
         hHNPpXABcKnxr97IN4LiiXoJlGPuTZ6Raed+BVGOzURRVUsoCr1v2GPifXlhpjxRmOHx
         TXgA1XzCEmIaU8IYanu+fq/W0eclgAEXmVSUUOWihIzJGNbE5EHEnHIAqWdlhWybJ2Mq
         tQUDjHX/cpVc6WHl/hA7M053Xhpp+Ml4WMxgoMkNOOyTRH22oYCO1/wbS3iHnql8TOl1
         A471hTS0OHHAAKfjJ2DukzeAvDOB+cKuKpwg4s2pL175mv4jkuGmhWZBj/R2cqUroAM6
         K8lw==
X-Gm-Message-State: AOAM530W8bTJNl506gyAKba0HqFJvTpMQDOzRxSe9huhuBI1E6jMCACq
        XfEE2NxZukAfhjZSdihgoTcKUU4mfLC7VPD2Whk=
X-Google-Smtp-Source: ABdhPJzgpSXpiAmecZIGTvFAIueOoHEETRH5QSK5agkuQovxsQaKAEpkNLMP1ObHB3pk4HlzObTpNxLW/irvALQ3nZg=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr22911693otu.254.1638649652497;
 Sat, 04 Dec 2021 12:27:32 -0800 (PST)
MIME-Version: 1.0
References: <YZPbQVwWOJCrAH78@zn.tnic> <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx> <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
 <87lf126010.ffs@tglx> <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
In-Reply-To: <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 4 Dec 2021 21:27:20 +0100
Message-ID: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 12:49 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Dec 03, 2021 at 12:48:43AM +0100, Thomas Gleixner wrote:
> > Kirill,
> >
> > On Fri, Dec 03 2021 at 01:21, Kirill A. Shutemov wrote:
> > > On Thu, Nov 25, 2021 at 01:40:24AM +0100, Thomas Gleixner wrote:
> > >> Kuppuswamy,
> > >> Either that or you provide patches with arguments which are based on
> > >> proper analysis and not on 'appears to' observations.
> > >
> > > I think the right solution to the WBINVD would be to add a #VE handler
> > > that does nothing. We don't have a reasonable way to handle it from within
> > > the guest. We can call the VMM in hope that it would handle it, but VMM is
> > > untrusted and it can ignore the request.
> > >
> > > Dave suggested that we need to do code audit to make sure that there's no
> > > user inside TDX guest environment that relies on WBINVD to work correctly.
> > >
> > > Below is full call tree of WBINVD. It is substantially larger than I
> > > anticipated from initial grep.
> > >
> > > Conclusions:
> > >
> > >   - Most of callers are in ACPI code on changing S-states. Ignoring cache
> > >     flush for S-state change on virtual machine should be safe.
> > >
> > >   - The only WBINVD I was able to trigger is on poweroff from ACPI code.
> > >     Reboot also should trigger it, but for some reason I don't see it.
> > >
> > >   - Few caller in CPU offline code. TDX does not allowed to offline CPU as
> > >     we cannot bring it back -- we don't have SIPI. And even if offline
> > >     works for vCPU it should be safe to ignore WBINVD there.
> > >
> > >   - NVDIMMs are not supported inside TDX. If it will change we would need
> > >     to deal with cache flushing for this case. Hopefully, we would be able
> > >     to avoid WBINVD.
> > >
> > >   - Cache QoS and MTRR use WBINVD. They are disabled in TDX, but it is
> > >     controlled by VMM if the feature is advertised. We would need to
> > >     filter CPUID/MSRs to make sure VMM would not mess with them.
> > >
> > > Is it good enough justification for do-nothing #VE WBINVD handler?
> >
> > first of all thank you very much for this very profound analysis.
> >
> > This is really what I was asking for and you probably went even a step
> > deeper than that. Very appreciated.
> >
> > What we should do instead of doing a wholesale let's ignore WBINVD is to
> > have a separate function/macro:
> >
> >  ACPI_FLUSH_CPU_CACHE_PHYS()
> >
> > and invoke that from the functions which are considered to be safe.
> >
> > That would default to ACPI_FLUSH_CPU_CACHE() for other architecures
> > obviously.
> >
> > Then you can rightfully do:
> >
> > #define ACPI_FLUSH_CPU_CACHE_PHYS()     \
> >         if (!cpu_feature_enabled(XXX))        \
> >               wbinvd();               \
> >
> > where $XXX might be FEATURE_TDX_GUEST for paranoia sake and then
> > extended to X86_FEATURE_HYPERVISOR if everyone agrees.
> >
> > Then you have the #VE handler which just acts on any other wbinvd
> > invocation via warn, panic, whatever, no?
>
> I found another angle at the problem. According to the ACPI spec v6.4
> section 16.2 cache flushing is required on the way to S1, S2 and S3.
> And according to 8.2 it also is required on the way to C3.
>
> TDX doesn't support these S- and C-states. TDX is only supports S0 and S5.
>
> Adjusting code to match the spec would make TDX work automagically.
>
> Any opinions on the patch below?
>
> I didn't touch ACPI_FLUSH_CPU_CACHE() users in cpufreq/longhaul.c because
> it might be outside of ACPI spec, I donno.
>
> diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
> index 808fdf54aeeb..b004a72a426e 100644
> --- a/drivers/acpi/acpica/hwesleep.c
> +++ b/drivers/acpi/acpica/hwesleep.c
> @@ -104,7 +104,8 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
>
>         /* Flush caches, as per ACPI specification */
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (sleep_state >= ACPI_STATE_S1 && sleep_state <= ACPI_STATE_S3)
> +               ACPI_FLUSH_CPU_CACHE();

So this basically means

if (sleep_state < ACPI_STATE_S14)
        ACPI_FLUSH_CPU_CACHE();

and analogously below.

This is fine with me, but it is an ACPICA patch, so it needs to be
submitted to the upstream project.  I think I can take care of this,
but not urgently.

>
>         status = acpi_os_enter_sleep(sleep_state, sleep_control, 0);
>         if (status == AE_CTRL_TERMINATE) {
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index 34a3825f25d3..bfcd66efeb48 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -110,7 +110,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>
>         /* Flush caches, as per ACPI specification */
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (sleep_state >= ACPI_STATE_S1 && sleep_state <= ACPI_STATE_S3)
> +               ACPI_FLUSH_CPU_CACHE();
>
>         status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
>         if (status == AE_CTRL_TERMINATE) {
> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> index e4cde23a2906..ba77598ee43e 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -162,8 +162,6 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
>                 return_ACPI_STATUS(status);
>         }
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
>                                     (u32)acpi_gbl_FADT.s4_bios_request, 8);
>         if (ACPI_FAILURE(status)) {
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 76ef1bcc8848..01495aca850e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -567,7 +567,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (cx->type == ACPI_STATE_C3)
> +               ACPI_FLUSH_CPU_CACHE();

And this is independent of the ACPICA changes above, so it can be made
in a separate patch.

This one is somewhat risky, though, because there is no guarantee that
all of the platforms in the field follow the spec.

>
>         while (1) {
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index eaa47753b758..a81d08b762c2 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -73,7 +73,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
>                 acpi_set_waking_vector(acpi_wakeup_address);
>
>         }
> -       ACPI_FLUSH_CPU_CACHE();
> +
> +       if (acpi_state >= ACPI_STATE_S1 && acpi_state <= ACPI_STATE_S3)
> +               ACPI_FLUSH_CPU_CACHE();

This flushing and the one below looks like it may be redundant,
because the cache will be flushed again in the ACPICA code above
anyway.

However, this needs to be double-checked.

>  #endif
>         pr_info("Preparing to enter system sleep state S%d\n", acpi_state);
>         acpi_enable_wakeup_devices(acpi_state);
> @@ -566,7 +568,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>         u32 acpi_state = acpi_target_sleep_state;
>         int error;
>
> -       ACPI_FLUSH_CPU_CACHE();
> +       if (acpi_state >= ACPI_STATE_S1 && acpi_state <= ACPI_STATE_S3)
> +               ACPI_FLUSH_CPU_CACHE();
>
>         trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
>         switch (acpi_state) {
> @@ -903,8 +906,6 @@ static int acpi_hibernation_enter(void)
>  {
>         acpi_status status = AE_OK;
>
> -       ACPI_FLUSH_CPU_CACHE();
> -
>         /* This shouldn't return.  If it returns, we have a problem */
>         status = acpi_enter_sleep_state(ACPI_STATE_S4);
>         /* Reprogram control registers */

This one is OK and can be done in a separate patch.
