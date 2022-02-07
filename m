Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E74AC8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiBGS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiBGSxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:53:54 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EEC0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:53:53 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 9078 invoked from network); 7 Feb 2022 19:53:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1644260031; bh=C7fW8I2zJOoNbXcMCI53B+cZB01UmuIiKpOEwjmOTfs=;
          h=Subject:To:Cc:From;
          b=d0aTf10SHoLYHl5f1uWt9vhYjAH8ZvuwEG6b98/iqXbQPCm3xoYS8tW8zZ4PLKGnl
           eDOz+4fvms8RQrRz6xS6+ynlISSCIANA8ASHliYZhLvNczqT9pzGNvw3V4FQWgQSxA
           lQEn10mmymxtNtj+XBWZV/1K82VvpZsTojewJYRg=
Received: from aaem217.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.116.217])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 7 Feb 2022 19:53:50 +0100
Message-ID: <d5cedee5-5f1e-8a11-1f4d-82e43f0753ed@o2.pl>
Date:   Mon, 7 Feb 2022 19:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Content-Language: en-GB
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <20220207182940.242838-1-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: e0a24d67e65ad5b12b7fef12da7af879
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [8UM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 07.02.2022 o 19:29, Mateusz Jończyk pisze:
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
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> ---
>  arch/x86/Kconfig      | 17 -----------------
>  drivers/hwmon/Kconfig | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 17 deletions(-)
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
> index 8df25f1079ba..dd244aa747ad 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -505,6 +505,21 @@ config SENSORS_DELL_SMM
>  	  When option I8K is also enabled this driver provides legacy /proc/i8k
>  	  userspace interface for i8kutils package.
>  
> +config I8K
> +	bool "Dell i8k legacy laptop support"
> +	depends on SENSORS_DELL_SMM

Oops, I dropped "depends on PROC_FS". Will fix this in next revision.

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

Greetings,

Mateusz

