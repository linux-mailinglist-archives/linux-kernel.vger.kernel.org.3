Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFCB54E57B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377460AbiFPO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiFPO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:56:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE76D2BB1E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:56:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso3569800wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Etn/dQhjuQJaHbnT3OVtyS239w7heYivZbd+vYx1CP0=;
        b=bP7Ix5TGzwlg2jVGKyLnQt9uvuvmXeb5tcmtCnixtuB5rTsg3M2UFhePgzpE/lVVgl
         kqJnNN/Y0PAl61/sWvGCNcskYpZsxsdVNVgk45GmZpXMpSIx3bA+vxxTUGrgxzE2Jrnt
         wocX7UWj9XaC2H7q+P5OJJuAEcDSlhaZ6URgS8SPGVaVzY1hFyzWFfkDtBjvG0AAMcbJ
         Z/x/Z45DUbuFD/rdiC3bcR4tamtHLICgxIyiKy7ZeTY3dyxdlcRJ0Cq4nzVLEiPCrRS8
         WvbKFubGA83wF9kH9JfPLuHry3Y88Spkk2hB0AXvF6Dyxo31gVqfC6gzpOfJgI4i0IkM
         comg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Etn/dQhjuQJaHbnT3OVtyS239w7heYivZbd+vYx1CP0=;
        b=lgAVcJRwcKA2PswIFVDHKUeBIfCbBOCRmrZVwLVBkE/L9QYCTBNHv+HtOW1Hp4i+MW
         vluVkJ5f3InP2Ri1WNmEBqF9Y/HwWuDicHNr6NCXRpPAFk0rvz0L2pXjgPeCXXrYaxOd
         KLktlvF/uAK/WfGOQ7AHgdqfXvfEDNzrinTo8x29IEMoNqQEcs7kDwBXcYxmetOVLhfc
         wVgn1v0hDnIKuu6oNgwVdj0RenR7+luQxJffvGH5TbeUaFob+BcQWtK4UWJPedC5fLnU
         ZCFmSTJy0of18nQwv8T2F+4KHpESZzxZm1NxmaHfyYUC/J6ShB9pmMFj4Z4kVRpq3mdE
         5ymw==
X-Gm-Message-State: AJIora+ZchYKQfeDNIwmS7dBoe4REhcOI8J7pEd3pahfmvknumLCLDIZ
        s3AOxcC/uGQln2iC4hKf28+veg==
X-Google-Smtp-Source: AGRyM1t8rK29d8qNmLcqjZf5xT0oVNKxL8Rp+fM0+1+6P/SnZTl1+7Br+8zrIoG5oHFAi75h1tgsLg==
X-Received: by 2002:a05:600c:190d:b0:39c:8216:f53d with SMTP id j13-20020a05600c190d00b0039c8216f53dmr5591994wmq.108.1655391378431;
        Thu, 16 Jun 2022 07:56:18 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0039c5224bfcbsm6853844wms.46.2022.06.16.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:56:17 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] ACPI: Split out processor thermal register from ACPI
 PSS
References: <TYWP286MB2601DDBB0F472C876D36FBCCB1A69@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 16 Jun 2022 15:56:16 +0100
In-Reply-To: <TYWP286MB2601DDBB0F472C876D36FBCCB1A69@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
        (Riwen Lu's message of "Fri, 10 Jun 2022 17:22:05 +0800")
Message-ID: <877d5gpshb.fsf@stealth>
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

Usually it's a good practice to Cc anybody who has commented on previous
versions. It makes it easier to follow your updates.

A couple of comments below.

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
> ---
>  drivers/acpi/Kconfig             |  2 +-
>  drivers/acpi/Makefile            |  5 +--
>  drivers/acpi/processor_driver.c  | 72 ++++----------------------------
>  drivers/acpi/processor_thermal.c | 69 ++++++++++++++++++++++++++++++
>  include/acpi/processor.h         |  6 ++-
>  5 files changed, 84 insertions(+), 70 deletions(-)
>

[...]

> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c

[...]

> @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>  		return 0;
>  
>  	result = -ENODEV;
> -	acpi_pss_perf_exit(pr, device);
> +	acpi_processor_thermal_exit(pr);
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
> +	acpi_processor_thermal_exit(pr);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index d8b2dfcd59b5..93928db2ae5f 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -266,3 +266,72 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
>  	.get_cur_state = processor_get_cur_state,
>  	.set_cur_state = processor_set_cur_state,
>  };
> +
> +int acpi_processor_thermal_init(struct acpi_processor *pr)
> +{
> +	struct acpi_device *device;
> +	int result = 0;
> +
> +	if (!pr)
> +		return -ENODEV;

What's the reason for this check? When will "pr" be NULL in this code
path?

> +
> +	device = acpi_fetch_acpi_dev(pr->handle);
> +	if (!device)
> +		return -ENODEV;

Wouldn't it be better to pass the acpi_device into the function as well?
The device is already available in the caller and it'll avoid having to
convert it back.

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
> +void acpi_processor_thermal_exit(struct acpi_processor *pr)
> +{
> +	struct acpi_device *device;
> +
> +	if (!pr)
> +		return;
> +
> +	device = acpi_fetch_acpi_dev(pr->handle);
> +	if (!device)
> +		return;

The same comment about passing the acpi_device structure applies here as
well.

> +
> +	if (pr->cdev) {
> +		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +		thermal_cooling_device_unregister(pr->cdev);
> +		pr->cdev = NULL;
> +	}
> +}

[...]
