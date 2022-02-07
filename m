Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB14AC8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiBGSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiBGSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:51:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FABC0401DA;
        Mon,  7 Feb 2022 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YjnxRU9OsPHWFPB45I1omyCSwPagOekaYsZVmBqtP5Y=; b=Bmva/cOPXrRluFmWOKioi5vMqp
        DGjVCFFUfrcyOKSesEGKFY4bzyTtp+0K6F9jUhsCUgP7gzNOYDIysro5PeAcq30EsEl7tyC6l7FpE
        HVrhcsBDkXyoWaJV5aD+fodgQ67U/bRDwGI9gXVtl2KwB1LFxoGPntTK5IJkS0G3vWM2kVC/y1gQE
        T0qofu2kIQ5G+hLsQh0whyWK9MF+IZHCpWU4fw5tawKYtmctPczvOpmT0qD/xhhWNWnWj4RjZVvzr
        uyFNfivxVVAlxvJZLzph92Ekss0THyo2svpr5S+4UWTbxB8caXw9hzN6CMzy1T1vI4eAdcjzmMJaw
        7fDRj2Tw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH96l-001nqs-SX; Mon, 07 Feb 2022 18:51:28 +0000
Message-ID: <d38afc1a-331f-ff0e-be81-71bec617d85c@infradead.org>
Date:   Mon, 7 Feb 2022 10:51:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220207182940.242838-1-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

I like it. (I had a note to myself to do this also.)


On 2/7/22 10:29, Mateusz Jończyk wrote:
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
> +	help
> +	  This option enables legacy /proc/i8k userspace interface in hwmon
> +	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,

	                                                          BIOS

> +	  temperature and allows controlling fan speeds of Dell laptops via
> +	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> +	  it reports also power and hotkey status. For fan speed control is
> +	  needed userspace package i8kutils.

Last sentence above is awkward. How about:

	  it also reports power and hotkey status. For fan speed control, the
	  i8kutils userspace package is needed.

> +
> +	  Say Y if you intend to run this kernel on old Dell laptops or want to
> +	  use userspace package i8kutils.
> +	  Say N otherwise.
> +
>  config SENSORS_DA9052_ADC
>  	tristate "Dialog DA9052/DA9053 ADC"
>  	depends on PMIC_DA9052


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
