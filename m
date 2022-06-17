Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CAE54F43B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381386AbiFQJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381481AbiFQJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:26:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F067D11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:26:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c21so5001560wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7QgWyOrwcdZfhxMsEv0D/HOdyQQAtGE5lUhJFK9WI34=;
        b=baDqnxH9AoRr/GTSO8bWcwcoD7EbsPtCklwLM1feiSe89PBitkesjSsy1xWf70qySW
         ufACQ1c7JEOACwZUozuJF7t/L14ahN2ldYJJfG4JdH/m34CDHe8dzjlny0UMwvuKylTn
         Jsa1WUY6n1v3htfxzUl9oOWYSS82lL4j7MBOtbJidFi09Qi2fbKAbYrlV7nzbIoLEvxQ
         zyBrUKvXWbhJhZM6yRtynPwbScrwTAPmb7rn3p0Ng8zvpR9sDrizkoojAsv/2bFJXmVu
         8UKh1WJZUWN6OWmHlmHpTDKvR2DIrSsdsfKLTo52J1IVZnXdCojrTc89sruhMR6Ndwe2
         Igtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7QgWyOrwcdZfhxMsEv0D/HOdyQQAtGE5lUhJFK9WI34=;
        b=nCfIJkVS7K0QxmzNsT1+iQ4QHxtB/YlbHn9u2rrSUCxCyIklifac6JyL83or+QoPXz
         VNDyfVDgGEhMF/tRX2Ncqq7Dm1Zc8rrVuMrM6wEFQSMtBxlKTIBAd3bxluS8gD1MQ/DX
         bF2CSNIGKqnfsbo3SYT1LmQR6uKB0r/kGHLW4zvh18b5jLRI+yJjnd4Y1dIua2c9Roak
         V4GREaWw2fX0Syv21rk3JAjcVfqLt9ijzdELLIciDJO8mrcGzF6UjLOBxPlaGB1MGHYT
         QDnrxwI8uXjHghGh1pdsfWijo0FAQDIHYsfoq9nYUPetVZsq8QDPGf1I+u4RO3/pbUoX
         yPtw==
X-Gm-Message-State: AJIora9OTSP9y47h3cZYad3pyI4/sUXGkvruqS/axA1SliE0RRkPcMO4
        ypY71semsYbcM3kR0sBqp2/srQ==
X-Google-Smtp-Source: AGRyM1uoBpVEA1m4d75Zjba7gCaZE4/6upu+1FTbDBF4sdXro65+m+P7bb+8Qb353obeZcJfP5XJ8w==
X-Received: by 2002:a05:6000:18a9:b0:218:891d:815c with SMTP id b9-20020a05600018a900b00218891d815cmr8391962wri.311.1655457968081;
        Fri, 17 Jun 2022 02:26:08 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b0021a38089e99sm3817103wrf.57.2022.06.17.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:26:06 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        punit.agrawal@bytedance.com, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] ACPI: Split out processor thermal register from ACPI
 PSS
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 17 Jun 2022 10:26:04 +0100
In-Reply-To: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
        (Riwen Lu's message of "Fri, 17 Jun 2022 10:51:51 +0800")
Message-ID: <871qvnpro3.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Riwen Lu <luriwen@hotmail.com> writes:

> From: Riwen Lu <luriwen@kylinos.cn>
>
> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> driver"), moves processor thermal registration to acpi_pss_perf_init(),
> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
>
> As ARM64 supports P-states using CPPC, it should be possible to also
> support processor passive cooling even if PSS is not enabled. Split
> out the processor thermal cooling register from ACPI PSS to support
> this, and move it into a separate function in processor_thermal.c.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>
> ---
> v1 -> v2:
>  - Reword the commit message.
>  - Update the signature of acpi_pss_perf_init() to void, and remove the
>    acpi_device parameter.
>  - Move the processor thermal register/remove into a separate function in
>    processor_thermal.c.
>
> v2 -> v3:
>  - Remove the "pr" NULL check in processor thermal init/exit fuction.
>  - Pass the acpi_device into processor thermal init/exit, and remove the
>    convert in it.
> ---
>  drivers/acpi/Kconfig             |  2 +-
>  drivers/acpi/Makefile            |  5 +--
>  drivers/acpi/processor_driver.c  | 72 ++++----------------------------
>  drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
>  include/acpi/processor.h         |  8 +++-
>  5 files changed, 71 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1e34f846508f..2457ade3f82d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -255,7 +255,6 @@ config ACPI_DOCK
>  
>  config ACPI_CPU_FREQ_PSS
>  	bool
> -	select THERMAL
>  
>  config ACPI_PROCESSOR_CSTATE
>  	def_bool y
> @@ -287,6 +286,7 @@ config ACPI_PROCESSOR
>  	depends on X86 || IA64 || ARM64 || LOONGARCH
>  	select ACPI_PROCESSOR_IDLE
>  	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> +	select THERMAL
>  	default y
>  	help
>  	  This driver adds support for the ACPI Processor package. It is required
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index b5a8d3e00a52..0002eecbf870 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -109,10 +109,9 @@ obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
>  
>  # processor has its own "processor." module_param namespace
> -processor-y			:= processor_driver.o
> +processor-y			:= processor_driver.o processor_thermal.o
>  processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
> -processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o	\
> -	processor_thermal.o
> +processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o
>  processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
>  
>  obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 368a9edefd0c..1278969eec1f 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
>  }
>  
>  #ifdef CONFIG_ACPI_CPU_FREQ_PSS
> -static int acpi_pss_perf_init(struct acpi_processor *pr,
> -		struct acpi_device *device)
> +static void acpi_pss_perf_init(struct acpi_processor *pr)
>  {
> -	int result = 0;
> -
>  	acpi_processor_ppc_has_changed(pr, 0);
>  
>  	acpi_processor_get_throttling_info(pr);
>  
>  	if (pr->flags.throttling)
>  		pr->flags.limit = 1;
> -
> -	pr->cdev = thermal_cooling_device_register("Processor", device,
> -						   &processor_cooling_ops);
> -	if (IS_ERR(pr->cdev)) {
> -		result = PTR_ERR(pr->cdev);
> -		return result;
> -	}
> -
> -	dev_dbg(&device->dev, "registered as cooling_device%d\n",
> -		pr->cdev->id);
> -
> -	result = sysfs_create_link(&device->dev.kobj,
> -				   &pr->cdev->device.kobj,
> -				   "thermal_cooling");
> -	if (result) {
> -		dev_err(&device->dev,
> -			"Failed to create sysfs link 'thermal_cooling'\n");
> -		goto err_thermal_unregister;
> -	}
> -
> -	result = sysfs_create_link(&pr->cdev->device.kobj,
> -				   &device->dev.kobj,
> -				   "device");
> -	if (result) {
> -		dev_err(&pr->cdev->device,
> -			"Failed to create sysfs link 'device'\n");
> -		goto err_remove_sysfs_thermal;
> -	}
> -
> -	return 0;
> -
> - err_remove_sysfs_thermal:
> -	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> - err_thermal_unregister:
> -	thermal_cooling_device_unregister(pr->cdev);
> -
> -	return result;
> -}
> -
> -static void acpi_pss_perf_exit(struct acpi_processor *pr,
> -		struct acpi_device *device)
> -{
> -	if (pr->cdev) {
> -		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> -		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> -		thermal_cooling_device_unregister(pr->cdev);
> -		pr->cdev = NULL;
> -	}
>  }
>  #else
> -static inline int acpi_pss_perf_init(struct acpi_processor *pr,
> -		struct acpi_device *device)
> -{
> -	return 0;
> -}
> -
> -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
> -		struct acpi_device *device) {}
> +static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>  
>  static int __acpi_processor_start(struct acpi_device *device)
> @@ -229,7 +171,9 @@ static int __acpi_processor_start(struct acpi_device *device)
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>  		acpi_processor_power_init(pr);
>  
> -	result = acpi_pss_perf_init(pr, device);
> +	acpi_pss_perf_init(pr);
> +
> +	result = acpi_processor_thermal_init(pr, device);
>  	if (result)
>  		goto err_power_exit;
>  
> @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>  		return 0;
>  
>  	result = -ENODEV;
> -	acpi_pss_perf_exit(pr, device);
> +	acpi_processor_thermal_exit(pr, device);
>  
>  err_power_exit:
>  	acpi_processor_power_exit(pr);
> @@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
>  		return 0;
>  	acpi_processor_power_exit(pr);
>  
> -	acpi_pss_perf_exit(pr, device);
> -
>  	acpi_cppc_processor_exit(pr);
>  
> +	acpi_processor_thermal_exit(pr, device);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index d8b2dfcd59b5..db6ac540e924 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
>  	.get_cur_state = processor_get_cur_state,
>  	.set_cur_state = processor_set_cur_state,
>  };
> +
> +int acpi_processor_thermal_init(struct acpi_processor *pr,
> +				struct acpi_device *device)
> +{
> +	int result = 0;
> +
> +	pr->cdev = thermal_cooling_device_register("Processor", device,
> +						   &processor_cooling_ops);
> +	if (IS_ERR(pr->cdev)) {
> +		result = PTR_ERR(pr->cdev);
> +		return result;
> +	}
> +
> +	dev_dbg(&device->dev, "registered as cooling_device%d\n",
> +		pr->cdev->id);
> +
> +	result = sysfs_create_link(&device->dev.kobj,
> +				   &pr->cdev->device.kobj,
> +				   "thermal_cooling");
> +	if (result) {
> +		dev_err(&device->dev,
> +			"Failed to create sysfs link 'thermal_cooling'\n");
> +		goto err_thermal_unregister;
> +	}
> +
> +	result = sysfs_create_link(&pr->cdev->device.kobj,
> +				   &device->dev.kobj,
> +				   "device");
> +	if (result) {
> +		dev_err(&pr->cdev->device,
> +			"Failed to create sysfs link 'device'\n");
> +		goto err_remove_sysfs_thermal;
> +	}
> +
> +	return 0;
> +
> +err_remove_sysfs_thermal:
> +	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +err_thermal_unregister:
> +	thermal_cooling_device_unregister(pr->cdev);
> +
> +	return result;
> +}
> +
> +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> +				 struct acpi_device *device)
> +{
> +	if (pr->cdev) {
> +		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +		thermal_cooling_device_unregister(pr->cdev);
> +		pr->cdev = NULL;
> +	}
> +}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 194027371928..ba1e3ed98d3d 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -442,8 +442,12 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>  
>  /* in processor_thermal.c */
>  int acpi_processor_get_limit_info(struct acpi_processor *pr);
> +int acpi_processor_thermal_init(struct acpi_processor *pr,
> +				struct acpi_device *device);
> +void acpi_processor_thermal_exit(struct acpi_processor *pr,
> +				 struct acpi_device *device);
>  extern const struct thermal_cooling_device_ops processor_cooling_ops;
> -#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
> +#ifdef CONFIG_CPU_FREQ
>  void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
>  void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
>  #else
> @@ -455,6 +459,6 @@ static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	return;
>  }
> -#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
> +#endif	/* CONFIG_CPU_FREQ */
>  
>  #endif

Thanks for updating the patch.

FWIW,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
