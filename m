Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08139544962
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiFIKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbiFIKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:41:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C198B26CE7A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:41:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so5564179wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s7yDuLsDiBHVsfnrsYNovXy2Bt1H7fS8uyn7ZkgnngU=;
        b=eDFIq80gPXAMihgJnguV6SYMpluR4TOt/h8hslaOGZ2Q67BrpP7JDYL3w0pqImv5hK
         ZG15Wt+i//lwZOh2a0wx9h6DZNyfSGFWutabFLjjYnBgD6VkzzrSbo7G/gfin92KSJdb
         iX/CT3fqT7bd4fgyo3wq0R/vNgsBYxmq8DIOFCm/knmAAf9mwwjnELbf2Kn30/U+zQHk
         GrB3FDhpdgUv+b5/3IG/HSkwtw3jqrKU44sTSQxTkDV2N8snhF6lPUHIwEfGIixPW7sH
         1qptmVeN+NxPeIuW8yTQVSaCx3yW8tnDFt9+hmArzooYmyRhgT3ZCxzNiKdZFPYgSTQH
         wgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=s7yDuLsDiBHVsfnrsYNovXy2Bt1H7fS8uyn7ZkgnngU=;
        b=B/AvX2rHcdZSBh9crB7QQNr4cIOmQ7ibFxyhtlEpjsjB+XuW4a09nGKYjtF5B0umD3
         RLADflDJe4/VmxVT0Fs47mLcjF/YWRk3eaCwSBy8Fw2AIDx2tC/mgGcSRiS+RelA7yI/
         BPq0RMJphJy9I6QNtpiZq+mlHykHTE1FURs3JA4XQS01ZhiPghjX6tZL4e9Nw8h9TkPu
         krzGK4U3eoY0AuJ4Zpzkynz94iWom6SKDXz9JfOQK1e1ERac5puCwiX1L5JZPcuy4mPR
         TMcY0aIm7UjwldYAeo1/oxHy7H6HoXSuLxBiAWQQhzOfOvul/G7xdR6cKGiWjCwMgy/s
         q1ng==
X-Gm-Message-State: AOAM532LsACHYH7D6XOBsbOMMvL6XJFH/1hLAQskZs78E48FYAp5yOvz
        jRjKjowwazv1pX57pUUOdh8eR1s8Yi8LSPnD
X-Google-Smtp-Source: ABdhPJySkP/Gcqw9Ot76PpqONFdVm06caK34GcJ5EwjfLC4LyV5eeFx3jelqsuqWhs4HRuUa75mquA==
X-Received: by 2002:adf:f5d0:0:b0:216:5680:b41e with SMTP id k16-20020adff5d0000000b002165680b41emr26289690wrp.216.1654771275138;
        Thu, 09 Jun 2022 03:41:15 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0039c15861001sm25820904wmb.21.2022.06.09.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:41:14 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, Riwen Lu <luriwen@kylinos.com>
Subject: Re: [PATCH v1] ACPI: Split out processor thermal register from ACPI
 PSS
References: <TYWP286MB26019A5110491AC2C0157082B1A39@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 09 Jun 2022 11:41:13 +0100
In-Reply-To: <TYWP286MB26019A5110491AC2C0157082B1A39@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
        (Riwen Lu's message of "Sun, 5 Jun 2022 15:58:14 +0800")
Message-ID: <87h74ui0fq.fsf@stealth>
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

Hi Riwen,

Riwen Lu <luriwen@hotmail.com> writes:

> From: Riwen Lu <luriwen@kylinos.com>
>
> In prior commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
> driver"), move processor thermal register to acpi_pss_perf_init(), and it
> won't excute if ACPI_CPU_FREQ_PSS not enabled.
>
> Since ARM64 support P states by CPPC, it should also support processor
> passive cooling. So split out the processor thermal cooling register from
> ACPI PSS.

The commit log is a bit difficult to understand - maybe reword as -

    Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
    driver"), moves processor thermal registration to acpi_pss_perf_init(),
    which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.

    As ARM64 supports P-states using CPPC, it should be possible to also
    support processor passive cooling even if PSS is not enabled. Split
    out the processor thermal cooling register from ACPI PSS to support
    this.

> Signed-off-by: Riwen Lu <luriwen@kylinos.com>
> ---

[...]

> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 368a9edefd0c..c84738a24eca 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -142,8 +142,6 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
>  static int acpi_pss_perf_init(struct acpi_processor *pr,
>  		struct acpi_device *device)
>  {
> -	int result = 0;
> -
>  	acpi_processor_ppc_has_changed(pr, 0);
>  
>  	acpi_processor_get_throttling_info(pr);
> @@ -151,53 +149,7 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
>  	if (pr->flags.throttling)
>  		pr->flags.limit = 1;
>  
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
>  	return 0;
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
>  static inline int acpi_pss_perf_init(struct acpi_processor *pr,
> @@ -205,9 +157,6 @@ static inline int acpi_pss_perf_init(struct acpi_processor *pr,
>  {
>  	return 0;
>  }
> -
> -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
> -		struct acpi_device *device) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>  
>  static int __acpi_processor_start(struct acpi_device *device)
> @@ -229,9 +178,35 @@ static int __acpi_processor_start(struct acpi_device *device)
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>  		acpi_processor_power_init(pr);
>  
> -	result = acpi_pss_perf_init(pr, device);
> -	if (result)
> +	acpi_pss_perf_init(pr, device);

The return value of acpi_pss_perf_init() isn't used anymore. Please also
update the function signature to void and drop the redundant return.

> +
> +	pr->cdev = thermal_cooling_device_register("Processor", device,
> +						   &processor_cooling_ops);
> +	if (IS_ERR(pr->cdev)) {
> +		result = PTR_ERR(pr->cdev);
>  		goto err_power_exit;
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
>> +				   &device->dev.kobj,
> +				   "device");
> +	if (result) {
> +		dev_err(&pr->cdev->device,
> +			"Failed to create sysfs link 'device'\n");
> +		goto err_remove_sysfs_thermal;
> +	}

Instead of copying the block back here, it would be better to move it
into a separate function in processor_thermal.c that can be called
here.

>  
>  	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
>  					     acpi_processor_notify, device);
> @@ -239,8 +214,11 @@ static int __acpi_processor_start(struct acpi_device *device)
>  		return 0;
>  
>  	result = -ENODEV;
> -	acpi_pss_perf_exit(pr, device);
> -
> +	sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +err_remove_sysfs_thermal:
> +	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +err_thermal_unregister:
> +	thermal_cooling_device_unregister(pr->cdev);
>  err_power_exit:
>  	acpi_processor_power_exit(pr);
>  	return result;
> @@ -277,10 +255,15 @@ static int acpi_processor_stop(struct device *dev)
>  		return 0;
>  	acpi_processor_power_exit(pr);
>  
> -	acpi_pss_perf_exit(pr, device);
> -
>  	acpi_cppc_processor_exit(pr);
>  
> +	if (pr->cdev) {
> +		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +		thermal_cooling_device_unregister(pr->cdev);
> +		pr->cdev = NULL;
> +	}
> +

Similarly, the removal can also be moved to a function in processor_thermal.c.

Thoughts?

[...]
