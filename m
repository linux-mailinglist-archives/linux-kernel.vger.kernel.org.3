Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172D490941
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiAQNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:11:04 -0500
Received: from foss.arm.com ([217.140.110.172]:58158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbiAQNLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:11:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEFDA1FB;
        Mon, 17 Jan 2022 05:11:00 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356003F774;
        Mon, 17 Jan 2022 05:10:59 -0800 (PST)
Date:   Mon, 17 Jan 2022 13:10:56 +0000
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
Subject: Re: [PATCH] arm64: move efi_reboot to restart handler
Message-ID: <20220117131056.GC87485@C02TD0UTHF1T.local>
References: <YeVhtL2gCLkhTPdv@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVhtL2gCLkhTPdv@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 17, 2022 at 01:31:48PM +0100, Krzysztof Adamski wrote:
> On EFI enabled arm64 systems, efi_reboot was called before
> do_kernel_restart, completely omitting the reset_handlers functionality.
> By registering efi_reboot as part of the chain with slightly elevated
> priority, we make it run before the default handler but still allow
> plugging in other handlers.
> Thanks to that, things like gpio_restart, restart handlers in
> watchdog_core, mmc or mtds are working on those platforms.
> 
> The priority 129 should be high enough as we will likely be the first
> one to register on this prio so we will be called before others, like
> PSCI handler.

I apprecaiate that this is kinda nice for consistency, but if adds more
lines and reduces certainty down to "likely", neither of which seem
ideal.

What do we gain by changing this? e.g. does this enable some further
rework?

Do we actually need to change this?

> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> ---
>  arch/arm64/kernel/process.c |  7 -------
>  arch/arm64/kernel/setup.c   | 21 +++++++++++++++++++++
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
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f70573928f1b..5fa95980ba73 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -12,6 +12,7 @@
>  #include <linux/stddef.h>
>  #include <linux/ioport.h>
>  #include <linux/delay.h>
> +#include <linux/reboot.h>
>  #include <linux/initrd.h>
>  #include <linux/console.h>
>  #include <linux/cache.h>
> @@ -298,6 +299,24 @@ u64 cpu_logical_map(unsigned int cpu)
>  	return __cpu_logical_map[cpu];
>  }
>  
> +static int efi_restart(struct notifier_block *nb, unsigned long action,
> +		       void *data)
> +{
> +	/*
> +	 * UpdateCapsule() depends on the system being reset via
> +	 * ResetSystem().
> +	 */
> +	if (efi_enabled(EFI_RUNTIME_SERVICES))
> +		efi_reboot(reboot_mode, NULL);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block efi_restart_nb = {
> +	.notifier_call = efi_restart,
> +	.priority = 129,
> +};
> +
>  void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  {
>  	setup_initial_init_mm(_stext, _etext, _edata, _end);
> @@ -346,6 +365,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  
>  	paging_init();
>  
> +	register_restart_handler(&efi_restart_nb);

If we're going to register this, it'd be nicer to register it
conditionally in the EFI code when we probe EFI, rather than having the
arch setup code unconditionally register a notifier that conditionally
does something.

Thanks,
Mark.

> +
>  	acpi_table_upgrade();
>  
>  	/* Parse the ACPI tables for possible boot-time configuration */
> -- 
> 2.34.1
> 
