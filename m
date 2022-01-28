Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2949FD78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiA1QBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:01:54 -0500
Received: from foss.arm.com ([217.140.110.172]:51310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242668AbiA1QBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB214113E;
        Fri, 28 Jan 2022 08:01:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36E003F793;
        Fri, 28 Jan 2022 08:01:50 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:01:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
References: <YfP0osb45uJldtM9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfP0osb45uJldtM9@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:50:26PM +0100, Krzysztof Adamski wrote:
> On EFI enabled arm64 systems, efi_reboot was called before
> do_kernel_restart, completely omitting the reset_handlers functionality.

As I pointed out before, per the EFI spec we *need* to do this before any other
restart mechanism so that anything which EFI ties to the restart actually
occurs as expected -- e.g. UpdateCapsule(), as the comment says.
AFAICT, either:

* The other restart handlers have lower priority, in which case they'll be
  called after this anyway, and in such cases this patch is not necessary.

* At least one other restart handler has higher priority, and the EFI restart
  isn't actually used, and so any functionaltiy tied to the EFI restart will
  not work on that machine.

> By registering efi_reboot as part of the chain with slightly elevated
> priority, we make it run before the default handler but still allow
> plugging in other handlers.
> Thanks to that, things like gpio_restart, restart handlers in
> watchdog_core, mmc or mtds are working on those platforms.

On which platforms is it necessary that these are used in preference to the EFI
restart? Can you please give a specific example?

If there's a specific platform that needs this, then we should call that out
and explain why the EFI restart isn't actually required on that (or if it is,
and functionality is broken, why that's acceptable).

Otherwise this patch is making this logic more complicated *and* making it
possible to have problems which we avoid by construction today, without any
actual benefit.

Thanks,
Mark.

> The priority 130 is one higher than PSCI, to overrule that but still
> allow to easily register higher prio handlers, if needed.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> ---
> 
> Changes in v2:
>   - Register the handler in EFI code, instead of arm64 setup.c
>   - Remove the contdition from the handler - it should be run in all
>     cases when it is registered
>   - Bump the priority to 130 to make it completly obious this should be
>     run before PSCI (which has priority of 129)
> 
>  arch/arm64/kernel/process.c        |  7 -------
>  drivers/firmware/efi/arm-runtime.c | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79..b86ef77bb0c8 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -130,13 +130,6 @@ void machine_restart(char *cmd)
>  	local_irq_disable();
>  	smp_send_stop();
>  
> -	/*
> -	 * UpdateCapsule() depends on the system being reset via
> -	 * ResetSystem().
> -	 */
> -	if (efi_enabled(EFI_RUNTIME_SERVICES))
> -		efi_reboot(reboot_mode, NULL);
> -
>  	/* Now call the architecture specific reboot code. */
>  	do_kernel_restart(cmd);
>  
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 3359ae2adf24..b9a2cdbe80b4 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -80,6 +80,24 @@ static bool __init efi_virtmap_init(void)
>  	return true;
>  }
>  
> +static int efi_restart(struct notifier_block *nb, unsigned long action,
> +		       void *data)
> +{
> +	/*
> +	 * UpdateCapsule() depends on the system being reset via
> +	 * ResetSystem().
> +	 */
> +	efi_reboot(reboot_mode, NULL);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block efi_restart_nb = {
> +	.notifier_call = efi_restart,
> +	/* We want this to take priority over PSCI which has priority of 129. */
> +	.priority = 130,
> +};
> +
>  /*
>   * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
>   * non-early mapping of the UEFI system table and virtual mappings for all
> @@ -148,6 +166,9 @@ static int __init arm_enable_runtime_services(void)
>  	efi_native_runtime_setup();
>  	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		register_restart_handler(&efi_restart_nb);
> +
>  	return 0;
>  }
>  early_initcall(arm_enable_runtime_services);
> -- 
> 2.34.1
> 
