Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15B75A6CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiH3TPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3TPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A94D258
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2933E61703
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8518FC43141
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886935;
        bh=w9radkabqhUd3OLgPbRfZ1Y/HtR3pNtqCwH5lVVybGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jqDb9X19r1DBjmxizgBgeXSCNu8ZXgeS1ETCOeh7MOmH0MKzuKe+8HbI/93Wgez9A
         vyxaW0pTV9p3gtUPdS5kiuzu4O9zgKaQs1hud3hNL+QoCVzO2jL0UNWl567wJCGSiB
         YQfztV43FGYbrBI8u521VJYTHMB/mnvjN9UqJa1sZ4Zv3hTu0nTC3OcEEJVHR8iz9W
         VBfWaTzyoqnBfvjNhYoeApkMp8bGia6J+WG2K/eFudtPvohghyOg25t7qFbC8xu21F
         QEAMTbgWu98xJF0+bhkX3fyCa3KNTzHauPw5FEZCDSHmcUz8bANvByoRxuDik47U/G
         VNjHgpuoemTFg==
Received: by mail-yb1-f169.google.com with SMTP id p204so984929yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:15:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo07jPSgcOyY3AreYJO8G/084wXCHTLDmVHVn5HfUad6b7UIon+i
        OgFphaoRWJvIviJmCJY/1BMGCZgpORZJSIcHxfS6FA==
X-Google-Smtp-Source: AA6agR4nr8gQWk8wkFn8CdjuUEFMGuYaTE2Yh76MuRk2+40FGCqF0qO7udWXRNgylJaFQTObIrWkZ7nhfwOOcLL7Yzs=
X-Received: by 2002:a25:103:0:b0:695:8b6b:308d with SMTP id
 3-20020a250103000000b006958b6b308dmr12602675ybb.572.1661886934504; Tue, 30
 Aug 2022 12:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220817051127.3323755-1-ashok.raj@intel.com> <20220817051127.3323755-6-ashok.raj@intel.com>
In-Reply-To: <20220817051127.3323755-6-ashok.raj@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Aug 2022 12:15:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUBzP1YPob3JhOZZepBPbyFXuTG2pb8Sq_o+c_WpioGTw@mail.gmail.com>
Message-ID: <CALCETrUBzP1YPob3JhOZZepBPbyFXuTG2pb8Sq_o+c_WpioGTw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] x86/microcode: Place siblings in NMI loop while
 update in progress
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:12 PM Ashok Raj <ashok.raj@intel.com> wrote:
>
> Microcode updates need a guarantee that the thread sibling that is waiting
> for the update to finish on the primary core will not execute any
> instructions until the update is complete. This is required to guarantee
> any MSR or instruction that's being patched will be executed before the
> update is complete.
>
> After the stop_machine() rendezvous, an NMI handler is registered. If an
> NMI were to happen while the microcode update is not complete, the
> secondary thread will spin until the ucode update state is cleared.
>
> Couple of choices discussed are:
>
> 1. Rendezvous inside the NMI handler, and also perform the update from
>    within the handler. This seemed too risky and might cause instability
>    with the races that we would need to solve. This would be a difficult
>    choice.
>         1.a Since the primary thread of every core is performing a wrmsr
>         for the update, once the wrmsr has started, it can't be
>         interrupted. Hence its not required to NMI the primary thread of
>         the core. Only the secondary thread needs to be parked in NMI
>         before the update begins.
>         Suggested by From Andy Cooper
> 2. Thomas (tglx) suggested that we could look into masking all the LVT
>    originating NMI's. Such as LINT1, Perf control LVT entries and such.
>    Since we are in the rendezvous loop, we don't need to worry about any
>    NMI IPI's generated by the OS.
>
>    The one we didn't have any control over is the ACPI mechanism of sending
>    notifications to kernel for Firmware First Processing (FFM). Apparently
>    it seems there is a PCH register that BIOS in SMI would write to
>    generate such an interrupt (ACPI GHES).
> 3. This is a simpler option. OS registers an NMI handler and doesn't do any
>    NMI rendezvous dance. But if an NMI were to happen, we check if any of
>    the CPUs thread siblings have an update in progress. Only those CPUs
>    would take an NMI. The thread performing the wrmsr() will only take an
>    NMI after the completion of the wrmsr 0x79 flow.
>
>    [ Lutomirsky thinks this is weak, and what happens from taking the
>    interrupt and the path to the registered callback handler might be
>    exposed.]
>
>    Seems like 1.a is the best candidate.
>
> The algorithm is something like this:
>
> After stop_machine() all threads are executing __reload_late()
>
> nmi_callback()
> {
>         if (!in_ucode_update)
>                 return NMI_DONE;
>         if (cpu not in sibling_mask)
>                 return NMI_DONE;
>         update sibling reached NMI for primary to continue
>
>         while (cpu in sibling_mask)
>                 wait;
>         return NMI_HANDLED;
> }
>
> __reload_late()
> {
>
>         entry_rendezvous(&late_cpus_in);
>         set_mcip()
>         if (this_cpu is first_cpu in the core)
>                 wait for siblings to drop in NMI
>                 apply_microcode()
>         else {
>                 send self_ipi(NMI_VECTOR);
>                 goto wait_for_siblings;
>         }
>
> wait_for_siblings:
>         exit_rendezvous(&late_cpus_out);
>         clear_mcip
> }
>
> reload_late()
> {
>         register_nmi_handler()
>         prepare_mask of all sibling cpus()
>         update state = ucode in progress;
>         stop_machine();
>         unregister_nmi_handler();
> }
>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 218 ++++++++++++++++++++++++++-
>  1 file changed, 211 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index d24e1c754c27..fd3b8ce2c82a 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -39,7 +39,9 @@
>  #include <asm/processor.h>
>  #include <asm/cmdline.h>
>  #include <asm/setup.h>
> +#include <asm/apic.h>
>  #include <asm/mce.h>
> +#include <asm/nmi.h>
>
>  #define DRIVER_VERSION "2.2"
>
> @@ -411,6 +413,13 @@ static int check_online_cpus(void)
>
>  static atomic_t late_cpus_in;
>  static atomic_t late_cpus_out;
> +static atomic_t nmi_cpus;      // number of CPUs that enter NMI
> +static atomic_t nmi_timeouts;   // number of siblings that timeout
> +static atomic_t nmi_siblings;   // Nmber of siblings that enter NMI
> +static atomic_t in_ucode_update;// Are we in microcode update?
> +static atomic_t nmi_exit;       // Siblings that exit NMI

Some of these variables seem oddly managed and just for debugging.

> +
> +static struct cpumask all_sibling_mask;
>
>  static int __wait_for_cpus(atomic_t *t, long long timeout)
>  {
> @@ -433,6 +442,104 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
>         return 0;
>  }
>
> +struct core_rendez {
> +       int num_core_cpus;
> +       atomic_t callin;
> +       atomic_t core_done;
> +};
> +
> +static DEFINE_PER_CPU(struct core_rendez, core_sync);
> +
> +static int __wait_for_update(atomic_t *t, long long timeout)
> +{
> +       while (!atomic_read(t)) {
> +               if (timeout < SPINUNIT)
> +                       return 1;

Since you're using signed arithmetic, timeout < 0 would be a less
error-prone condition.

Anyway, this patch is full of debugging stuff, so I won't do a
line-for-line review, but I do have a suggestion.  Instead of all this
bookkeeping, maybe just track the number of cores to park in NMI, kind
of like this (hand-wavy pseudocode):

static struct cpumask cpus_to_park_in_nmi;

/* fill out the cpumask */
static atomic_t nmi_parked_cpus;
static bool park_enabled;

Then, after __wait_for_cpus (once everything is stopped), one cpu sets
up the nmi handler, sets park_enabled, and sends the NMI IPI to all
the CPUs parked in there.  The handler does:

if (this cpu is in cpus_to_mark_in_nmi) {
  WARN_ON_ONCE(!park_enabled);
  atomic_inc(&nmi_parked_cpus);
  while (READ_ONCE(park_enabled))
    ;  /* because Intel won't promise that cpu_relax() is okay */
  atomic_dec(&nmi_parked_cpus);
}

and the CPUs that aren't supposed to park wait for nmi_parked_cpus to
have the right value.  After the update, park_enabled gets cleared and
everything resumes.

Does this seem reasonable?

I was thinking it would be straightforward to have __wait_for_cpus
handle this, but that would only really be easy in a language with
closures or continuation passing.

--Andy
