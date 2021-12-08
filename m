Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3F46D66C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhLHPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:10:53 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41782 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhLHPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:10:51 -0500
Received: by mail-ot1-f41.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so3000081otl.8;
        Wed, 08 Dec 2021 07:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJJCNpefWZ9v5/O8y5C489j9lW1KhN7Cz4lEj5RJNIA=;
        b=Ge4TaZV27YeCTUhokyaxGjI+PGFSq98Ob3acz3hn2z8lx8bZiRVM34p10T2/PRJZQ8
         XzhN8g6JHMSXjp5QgzPhijCEpxIEhBaVMSllOMi4hrecSrq8TAbutogHLxfJz8HwefwY
         yDaHLl66y9VaRJW42QHx/TJ965eoEXdBVgVMEtYRiXI3am4xUxGPujmjx0TOJHJT4LNd
         RiKfeFoVKy2KH3VHtg7bNc5GRWahSqAVfXSJtu+bywPiBtGmG/Vsn5mu1IXh7XXqo9j+
         ZR2cJnO6JK0+qNdoyuWFeXMfudwlq8jNpQLFk5RYXn4fq+uaBYQpfFnmI971m/3/HYzh
         aw5w==
X-Gm-Message-State: AOAM5300LpLe26hJIMBW33q1KbK4EiJkdbFWPB1fc/QhopaCd93hw1Fa
        No0WINe8d0Z8l4bPwKNq02kK+sIcjUbASbo3G80=
X-Google-Smtp-Source: ABdhPJxZkseiHQvO9jQwE/fBO7h382IQN8MDsFHQqrdWvOA7psJNg+7Hc6qSdY6PquxgulgWRkdblblIEmx3EGGJ+ZA=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr62222otu.254.1638976038821;
 Wed, 08 Dec 2021 07:07:18 -0800 (PST)
MIME-Version: 1.0
References: <26decf155bffc021a97846c0a0ed09c2b5e0bef1.camel@infradead.org>
In-Reply-To: <26decf155bffc021a97846c0a0ed09c2b5e0bef1.camel@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 16:07:07 +0100
Message-ID: <CAJZ5v0gAkOqh1LVpdXKLxpswBSG-3LUaXoZgw0Op+3V69BjhZQ@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Allow ACPI hardware signature to be honoured
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        benh <benh@kernel.crashing.org>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        Amit Shah <aams@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 5:09 PM David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Theoretically, when the hardware signature in FACS changes, the OS
> is supposed to gracefully decline to attempt to resume from S4:
>
>  "If the signature has changed, OSPM will not restore the system
>   context and can boot from scratch"
>
> In practice, Windows doesn't do this and many laptop vendors do allow
> the signature to change especially when docking/undocking, so it would
> be a bad idea to simply comply with the specification by default in the
> general case.
>
> However, there are use cases where we do want the compliant behaviour
> and we know it's safe. Specifically, when resuming virtual machines where
> we know the hypervisor has changed sufficiently that resume will fail.
> We really want to be able to *tell* the guest kernel not to try, so it
> boots cleanly and doesn't just crash. This patch provides a way to opt
> in to the spec-compliant behaviour on the command line.
>
> A follow-up patch may do this automatically for certain "known good"
> machines based on a DMI match, or perhaps just for all hypervisor
> guests since there's no good reason a hypervisor would change the
> hardware_signature that it exposes to guests *unless* it wants them
> to obey the ACPI specification.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Applied as 5.17 material, sorry for the delay.

Thanks!

> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++++++---
>  arch/x86/kernel/acpi/sleep.c                  |  4 ++-
>  drivers/acpi/sleep.c                          | 26 +++++++++++++++----
>  include/linux/acpi.h                          |  2 +-
>  include/linux/suspend.h                       |  1 +
>  kernel/power/power.h                          |  1 +
>  kernel/power/swap.c                           | 16 ++++++++++--
>  7 files changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 43dc35fe5bc0..209402f4f11d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -225,14 +225,23 @@
>                         For broken nForce2 BIOS resulting in XT-PIC timer.
>
>         acpi_sleep=     [HW,ACPI] Sleep options
> -                       Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
> -                                 old_ordering, nonvs, sci_force_enable, nobl }
> +                       Format: { s3_bios, s3_mode, s3_beep, s4_hwsig,
> +                                 s4_nohwsig, old_ordering, nonvs,
> +                                 sci_force_enable, nobl }
>                         See Documentation/power/video.rst for information on
>                         s3_bios and s3_mode.
>                         s3_beep is for debugging; it makes the PC's speaker beep
>                         as soon as the kernel's real-mode entry point is called.
> +                       s4_hwsig causes the kernel to check the ACPI hardware
> +                       signature during resume from hibernation, and gracefully
> +                       refuse to resume if it has changed. This complies with
> +                       the ACPI specification but not with reality, since
> +                       Windows does not do this and many laptops do change it
> +                       on docking. So the default behaviour is to allow resume
> +                       and simply warn when the signature changes, unless the
> +                       s4_hwsig option is enabled.
>                         s4_nohwsig prevents ACPI hardware signature from being
> -                       used during resume from hibernation.
> +                       used (or even warned about) during resume.
>                         old_ordering causes the ACPI 1.0 ordering of the _PTS
>                         control method, with respect to putting devices into
>                         low power states, to be enforced (the ACPI 2.0 ordering
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 3f85fcae450c..1e97f944b47d 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -139,8 +139,10 @@ static int __init acpi_sleep_setup(char *str)
>                 if (strncmp(str, "s3_beep", 7) == 0)
>                         acpi_realmode_flags |= 4;
>  #ifdef CONFIG_HIBERNATION
> +               if (strncmp(str, "s4_hwsig", 8) == 0)
> +                       acpi_check_s4_hw_signature(1);
>                 if (strncmp(str, "s4_nohwsig", 10) == 0)
> -                       acpi_no_s4_hw_signature();
> +                       acpi_check_s4_hw_signature(0);
>  #endif
>                 if (strncmp(str, "nonvs", 5) == 0)
>                         acpi_nvs_nosave();
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 3023224515ab..fa27319e5324 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -873,11 +873,11 @@ static inline void acpi_sleep_syscore_init(void) {}
>  #ifdef CONFIG_HIBERNATION
>  static unsigned long s4_hardware_signature;
>  static struct acpi_table_facs *facs;
> -static bool nosigcheck;
> +static int sigcheck = -1; /* Default behaviour is just to warn */
>
> -void __init acpi_no_s4_hw_signature(void)
> +void __init acpi_check_s4_hw_signature(int check)
>  {
> -       nosigcheck = true;
> +       sigcheck = check;
>  }
>
>  static int acpi_hibernation_begin(pm_message_t stage)
> @@ -1005,12 +1005,28 @@ static void acpi_sleep_hibernate_setup(void)
>         hibernation_set_ops(old_suspend_ordering ?
>                         &acpi_hibernation_ops_old : &acpi_hibernation_ops);
>         sleep_states[ACPI_STATE_S4] = 1;
> -       if (nosigcheck)
> +       if (!sigcheck)
>                 return;
>
>         acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
> -       if (facs)
> +       if (facs) {
> +               /*
> +                * s4_hardware_signature is the local variable which is just
> +                * used to warn about mismatch after we're attempting to
> +                * resume (in violation of the ACPI specification.)
> +                */
>                 s4_hardware_signature = facs->hardware_signature;
> +
> +               if (sigcheck > 0) {
> +                       /*
> +                        * If we're actually obeying the ACPI specification
> +                        * then the signature is written out as part of the
> +                        * swsusp header, in order to allow the boot kernel
> +                        * to gracefully decline to resume.
> +                        */
> +                       swsusp_hardware_signature = facs->hardware_signature;
> +               }
> +       }
>  }
>  #else /* !CONFIG_HIBERNATION */
>  static inline void acpi_sleep_hibernate_setup(void) {}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 974d497a897d..5b6953189912 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -506,7 +506,7 @@ acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
>  int acpi_resources_are_enforced(void);
>
>  #ifdef CONFIG_HIBERNATION
> -void __init acpi_no_s4_hw_signature(void);
> +void __init acpi_check_s4_hw_signature(int check);
>  #endif
>
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 8af13ba60c7e..5785d909c321 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -446,6 +446,7 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
>  extern asmlinkage int swsusp_arch_suspend(void);
>  extern asmlinkage int swsusp_arch_resume(void);
>
> +extern u32 swsusp_hardware_signature;
>  extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
>  extern int hibernate(void);
>  extern bool system_entering_hibernation(void);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 778bf431ec02..bb41a1a1c0d3 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -168,6 +168,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_PLATFORM_MODE       1
>  #define SF_NOCOMPRESS_MODE     2
>  #define SF_CRC32_MODE          4
> +#define SF_HW_SIG              8
>
>  /* kernel/power/hibernate.c */
>  extern int swsusp_check(void);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 3cb89baebc79..58e9641682e8 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -36,6 +36,8 @@
>
>  #define HIBERNATE_SIG  "S1SUSPEND"
>
> +u32 swsusp_hardware_signature;
> +
>  /*
>   * When reading an {un,}compressed image, we may restore pages in place,
>   * in which case some architectures need these pages cleaning before they
> @@ -104,7 +106,8 @@ struct swap_map_handle {
>
>  struct swsusp_header {
>         char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
> -                     sizeof(u32)];
> +                     sizeof(u32) - sizeof(u32)];
> +       u32     hw_sig;
>         u32     crc32;
>         sector_t image;
>         unsigned int flags;     /* Flags to pass to the "boot" kernel */
> @@ -312,7 +315,6 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
>  /*
>   * Saving part
>   */
> -
>  static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>  {
>         int error;
> @@ -324,6 +326,10 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>                 memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
>                 memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);
>                 swsusp_header->image = handle->first_sector;
> +               if (swsusp_hardware_signature) {
> +                       swsusp_header->hw_sig = swsusp_hardware_signature;
> +                       flags |= SF_HW_SIG;
> +               }
>                 swsusp_header->flags = flags;
>                 if (flags & SF_CRC32_MODE)
>                         swsusp_header->crc32 = handle->crc32;
> @@ -1542,6 +1548,12 @@ int swsusp_check(void)
>                 } else {
>                         error = -EINVAL;
>                 }
> +               if (!error && swsusp_header->flags & SF_HW_SIG &&
> +                   swsusp_header->hw_sig != swsusp_hardware_signature) {
> +                       pr_info("Suspend image hardware signature mismatch (%08x now %08x); aborting resume.\n",
> +                               swsusp_header->hw_sig, swsusp_hardware_signature);
> +                       error = -EINVAL;
> +               }
>
>  put:
>                 if (error)
> --
> 2.25.1
>
