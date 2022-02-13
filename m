Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D04B3C07
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiBMPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:25:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiBMPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:25:50 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B555D1B9;
        Sun, 13 Feb 2022 07:25:42 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso16493306oop.9;
        Sun, 13 Feb 2022 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=adMLYytTCKC3gqDM6D8p4KEVfO3ISmY1G9RhS8Y69iQ=;
        b=daAL2ANc88CpmbW5sUgvtX5T2+7fvq59RDG4KnZySasi5YzGURtgORy6A0t/6af/VM
         GIijk3tHQ9ZEnAvxcJ/NoRWCPpvOppb5grLJaoSvBkZO2Q4QglI4RcoNydq37g9GZjeL
         6c4B25d3RNpuZmlnAkEHQjUIAwZYJJtnvJJR5ITnMrzkx9jtMC2NrcJ6JAHTUTLMvDvD
         hCMmwHSRjfwYgJuu2l5l/8nYXmXffoiHyvzG8Ek4JFY6KlocyCROlzXv9mbn+3asIhYg
         9vM0Xy8Eplg+2TadryBapqjAUR2G7VlQqYE3Ah5x6W+7W2vBOYoO8w50UcWfa1LOjBtW
         885w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=adMLYytTCKC3gqDM6D8p4KEVfO3ISmY1G9RhS8Y69iQ=;
        b=JhYh+0uZ5G1XoD/yON0ke0tO3oikXEO1zDqcrPH38LsmEeasLTIT75+2lNJZr3xa5q
         ydYhn7lenjZXj988otoLAzMRyQsr7bLK0Ys4+tvVtPnE2ZwMvWnvBL955OdktDVsPMdN
         BrpfjDaVf9Z2/F3uJJ3Gl4C+MJjGwsTgD29Xey1RYGfYRUkBdIJVwAAPv1j2do870qJS
         oUGPgaVOT5+2w1nfuqq7D5YnA4PpLFeLFHiWkh71mnHzb4vXst6u8uRPRsMOXVRA8Ko7
         mM2ZAdKickz7t1hRXe+A3TE5njCXa8YBq4lnz8eV03qrGcjfpU8V2Q5G255lGYpa1usB
         nfRw==
X-Gm-Message-State: AOAM530sp51xNsVCQUMxh7LH+VWhU/8BbMPyuvJOD/i1ib/q0deaa5e1
        sRvowS3EhTrjhb5fMfpbUXLJfhf9MfQJQA==
X-Google-Smtp-Source: ABdhPJweZfHH4NZqZqzYGaeCrsI+94F2UKdAxxdYiTf+tNgiOFZ24QAdV46zeWxdBi1mi+271cRu2g==
X-Received: by 2002:a05:6870:479e:: with SMTP id c30mr505499oaq.113.1644765942204;
        Sun, 13 Feb 2022 07:25:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm11802326ook.33.2022.02.13.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 07:25:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 13 Feb 2022 07:25:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Message-ID: <20220213152539.GA4073589@roeck-us.net>
References: <20220212125654.357408-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220212125654.357408-1-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:56:53PM +0100, Mateusz Jończyk wrote:
> In Kconfig, inside the "Processor type and features" menu, there is
> the CONFIG_I8K option: "Dell i8k legacy laptop support". This is
> very confusing - enabling CONFIG_I8K is not required for the kernel to
> support old Dell laptops. This option is specific to the dell-smm-hwmon
> driver, which mostly exports some hardware monitoring information and
> allows the user to change fan speed.
> 
> This option is misplaced, so move CONFIG_I8K to drivers/hwmon/Kconfig,
> where it belongs.
> 
> Also, modify the dependency order - change
>         select SENSORS_DELL_SMM
> to
>         depends on SENSORS_DELL_SMM
> as it is just a configuration option of dell-smm-hwmon. This includes
> changing the option type from tristate to bool. It was tristate because
> it could select CONFIG_SENSORS_DELL_SMM=m .
> 
> When running "make oldconfig" on configurations with
> CONFIG_SENSORS_DELL_SMM enabled , this change will result in an
> additional question (which could be printed several times during
> bisecting). I think that tidying up the configuration is worth it,
> though.
> 
> Next patch tweaks the description of CONFIG_I8K.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Gross <markgross@kernel.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Borislav Petkov <bp@suse.de>

Applied  to hwmon-next.

Thanks,
Guenter

> ---
> 
> v2:
>   - do not drop "depends on PROC_FS" from CONFIG_I8K
> 
> Thanks to all for reviewing.
> Mr Randy Dunlap: The first patch just moves CONFIG_I8K, without modifying
> the help text.
> 
>  arch/x86/Kconfig      | 17 -----------------
>  drivers/hwmon/Kconfig | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 17 deletions(-)
> 
> 
> base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..71d4ddd48c02 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1275,23 +1275,6 @@ config TOSHIBA
>  	  Say Y if you intend to run this kernel on a Toshiba portable.
>  	  Say N otherwise.
>  
> -config I8K
> -	tristate "Dell i8k legacy laptop support"
> -	depends on HWMON
> -	depends on PROC_FS
> -	select SENSORS_DELL_SMM
> -	help
> -	  This option enables legacy /proc/i8k userspace interface in hwmon
> -	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> -	  temperature and allows controlling fan speeds of Dell laptops via
> -	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> -	  it reports also power and hotkey status. For fan speed control is
> -	  needed userspace package i8kutils.
> -
> -	  Say Y if you intend to run this kernel on old Dell laptops or want to
> -	  use userspace package i8kutils.
> -	  Say N otherwise.
> -
>  config X86_REBOOTFIXUPS
>  	bool "Enable X86 board specific fixups for reboot"
>  	depends on X86_32
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8df25f1079ba..1ee4e5eff567 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -505,6 +505,22 @@ config SENSORS_DELL_SMM
>  	  When option I8K is also enabled this driver provides legacy /proc/i8k
>  	  userspace interface for i8kutils package.
>  
> +config I8K
> +	bool "Dell i8k legacy laptop support"
> +	depends on SENSORS_DELL_SMM
> +	depends on PROC_FS
> +	help
> +	  This option enables legacy /proc/i8k userspace interface in hwmon
> +	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> +	  temperature and allows controlling fan speeds of Dell laptops via
> +	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> +	  it reports also power and hotkey status. For fan speed control is
> +	  needed userspace package i8kutils.
> +
> +	  Say Y if you intend to run this kernel on old Dell laptops or want to
> +	  use userspace package i8kutils.
> +	  Say N otherwise.
> +
>  config SENSORS_DA9052_ADC
>  	tristate "Dialog DA9052/DA9053 ADC"
>  	depends on PMIC_DA9052
