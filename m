Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4849FC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiA1POi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbiA1POX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:14:23 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF2C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:14:22 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id g205so12836518oif.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rB3vRTa89ZSkSn6pM4nNsmxL1DKv4F6VVf/YhgzziM0=;
        b=kalYI+1ojLFtijCHW7+3xe1I+L0jOeGrozDpJGKUEjFzMghPHRsHON0O//RgyAKi8C
         ziT7EDmQMMZrGiWw/TP+W97XF4qIbXcl1etx9oOdQTpzGO6qowGg9gEqYrRttWuZBPFx
         D4u+9lk9W0IbnlN+l0khOkFxcVWXEWCo826hrVFqB/BLNSiErY4Z7A7zzJPpAkONXOre
         SHQ406F/59hSbFKLuSHCTDZgXU3aWHA51cceWocool1SXbX5XVG4/554soD/ESOHNJdM
         Ljwu6TA+Q7HPcBfiXXdAcPHbXFfQdanwhaoSffJ+luUWorgoFwfmCNMTI/NRav4W/Kgo
         oEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rB3vRTa89ZSkSn6pM4nNsmxL1DKv4F6VVf/YhgzziM0=;
        b=N83ouAvAsOTMqVkISmgAgpvzqwaOEXh9Ira/6yqklCZyUY4u4Utp6bSsFMbE3Yz3Av
         wOsOfGDEzqNxx5ydRg7WPBsKNYLaltELrKjXTFJylvsLlcAWIXGVVaA9X6AdF0fDZ8Io
         cQQ9HDEQU7kNIMeXzKkO57u+3jBJyrzSlLS+7JUV+vTZ63eaFq2857Tb/v4CRHgYCygT
         LC8jY7KUKCNaKc7thp6RqYM4eMRUkdxfB42hOrCp1B1LNdIPZ49oTl9WmQQBObIobchO
         FB3PkC9UBwXsIcNV+wg5ebiMhGSdchxIYkxYFqSCY0a/fx6Q6ZFEcl27OtbcUpWX1u9/
         K2YA==
X-Gm-Message-State: AOAM530ClRDkfmEU1UDR5ik2TyKJiGJVJMHhuz+yDXS1vjWMa5116DWt
        FW8Y11TfgbVpjpBPgvIRzqnXU479M3BsnA==
X-Google-Smtp-Source: ABdhPJxv5zWmPGhJ8n3u7CvfOIWZeWhGHAaLyiAyx/HQUiPq7E4wfcHErjSPmQyXHPMpSEBscdm3UQ==
X-Received: by 2002:aca:ab83:: with SMTP id u125mr5803032oie.276.1643382862290;
        Fri, 28 Jan 2022 07:14:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e20sm13090149oiw.38.2022.01.28.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:14:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <58da38d1-6a1f-ccdf-fc65-b53bf79851e1@roeck-us.net>
Date:   Fri, 28 Jan 2022 07:14:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Content-Language: en-US
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YfP0osb45uJldtM9@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 05:50, Krzysztof Adamski wrote:
> On EFI enabled arm64 systems, efi_reboot was called before
> do_kernel_restart, completely omitting the reset_handlers functionality.
> By registering efi_reboot as part of the chain with slightly elevated
> priority, we make it run before the default handler but still allow
> plugging in other handlers.
> Thanks to that, things like gpio_restart, restart handlers in
> watchdog_core, mmc or mtds are working on those platforms.
> 
> The priority 130 is one higher than PSCI, to overrule that but still
> allow to easily register higher prio handlers, if needed.
> 
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v2:
>    - Register the handler in EFI code, instead of arm64 setup.c
>    - Remove the contdition from the handler - it should be run in all
>      cases when it is registered
>    - Bump the priority to 130 to make it completly obious this should be
>      run before PSCI (which has priority of 129)
> 
>   arch/arm64/kernel/process.c        |  7 -------
>   drivers/firmware/efi/arm-runtime.c | 21 +++++++++++++++++++++
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79..b86ef77bb0c8 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -130,13 +130,6 @@ void machine_restart(char *cmd)
>   	local_irq_disable();
>   	smp_send_stop();
>   
> -	/*
> -	 * UpdateCapsule() depends on the system being reset via
> -	 * ResetSystem().
> -	 */
> -	if (efi_enabled(EFI_RUNTIME_SERVICES))
> -		efi_reboot(reboot_mode, NULL);
> -
>   	/* Now call the architecture specific reboot code. */
>   	do_kernel_restart(cmd);
>   
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 3359ae2adf24..b9a2cdbe80b4 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -80,6 +80,24 @@ static bool __init efi_virtmap_init(void)
>   	return true;
>   }
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
>   /*
>    * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
>    * non-early mapping of the UEFI system table and virtual mappings for all
> @@ -148,6 +166,9 @@ static int __init arm_enable_runtime_services(void)
>   	efi_native_runtime_setup();
>   	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>   
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		register_restart_handler(&efi_restart_nb);
> +
>   	return 0;
>   }
>   early_initcall(arm_enable_runtime_services);

