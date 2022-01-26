Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43449D2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiAZUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAZUDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:03:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DAC06161C;
        Wed, 26 Jan 2022 12:03:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso2389582wms.0;
        Wed, 26 Jan 2022 12:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mY3ysCNj443GJifLQmlNddA04KgyJaSyoL9/oKRXsTM=;
        b=pDcaBROWSVIDle6By0jiJSiVP0Hu76DXRnUxeAG0T5nKk4QJ8IhhyUwIuEpEMvny9g
         3DXcsm7g+qBzy4g263s0CEH5Q0buBZTaQgrFmFy40OBybi5OJ0jWuhlyjEfidxkhyPJw
         fm08fQpPqgHgWuxiluTqkQp27i9B/6qkTfEUZ+IDc7wvuu4rY0pv0+Yw4nzYZ/pSOfRn
         oPMR0uaXGLqOXN97wTE1d6NWh/wKy9dzqPEpWQCQWSN6zUoSoag8uS4UyTSsB7pGsljy
         jfw8Hnq9IRW9Lad37EpCihHmwZAUzt3Tp3vWjoX9AmN7ysggXIrqTLyqSN8D3cQDzPLA
         XLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mY3ysCNj443GJifLQmlNddA04KgyJaSyoL9/oKRXsTM=;
        b=3mnHWfKBvGhRjbN0i2qQWZLCh/QJry/YAIOseykXZ9mghWSHFkDOi2rr/IyY2E+CdB
         qKg6flBg3OrLr78XqfBn/4gBQscLIMQZaSKQbJUdZkeKRGh5Irj+b/v8/LSZp6s7YM4D
         zu3VkQC9GhWvAMror4xnNAO+WXFjeUdWqXXg2rKa4mCQ0xerCM9PnEeeJcBnUFdyXvDy
         1n/yqky/SydrHGfBT2BKSCTy9rX2YRDlmMvO4Jy7EggWstxwDZalZ0vFmM8B57tql9BA
         9t8Sx7OltGe2HX0ORuC2YNHN4k5LRHC46lb2hLMc61flUMAtXIZY5TGA2DBMRHRtnpPC
         zgxQ==
X-Gm-Message-State: AOAM530Sicye1vdXFawMp9sDnOZgBcY2kQwnRFw0CnkRwbC+NmpL0VvV
        90BnMWSKQhP2Pf7L9jXSYX6QxFjtkHU=
X-Google-Smtp-Source: ABdhPJyBYVzNvDvnIEGTTcEu80/SNLaRvE97m/MIm3v/ho93Wi2e3320PFQnfJmwJQ2sU5po7phLYQ==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr257155wmi.185.1643227409993;
        Wed, 26 Jan 2022 12:03:29 -0800 (PST)
Received: from [10.18.0.12] ([194.126.177.12])
        by smtp.gmail.com with ESMTPSA id k25sm2266436wms.23.2022.01.26.12.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 12:03:29 -0800 (PST)
Message-ID: <0e1b25f6-d64f-a391-eca8-01b686377df0@gmail.com>
Date:   Wed, 26 Jan 2022 21:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] platform: surface: Replace acpi_bus_get_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
References: <5805278.lOV4Wx5bFT@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <5805278.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 20:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface3-wmi.c        |   12 ++++--------
>   drivers/platform/surface/surface_acpi_notify.c |    3 ++-
>   2 files changed, 6 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/drivers/platform/surface/surface3-wmi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface3-wmi.c
> +++ linux-pm/drivers/platform/surface/surface3-wmi.c
> @@ -116,15 +116,11 @@ static acpi_status s3_wmi_attach_spi_dev
>   					    void *data,
>   					    void **return_value)
>   {
> -	struct acpi_device *adev, **ts_adev;
> +	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
> +	struct acpi_device **ts_adev = data;
>   
> -	if (acpi_bus_get_device(handle, &adev))
> -		return AE_OK;
> -
> -	ts_adev = data;
> -
> -	if (strncmp(acpi_device_bid(adev), SPI_TS_OBJ_NAME,
> -	    strlen(SPI_TS_OBJ_NAME)))
> +	if (!adev || strncmp(acpi_device_bid(adev), SPI_TS_OBJ_NAME,
> +			     strlen(SPI_TS_OBJ_NAME)))
>   		return AE_OK;
>   
>   	if (*ts_adev) {
> Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
> +++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
> @@ -770,7 +770,8 @@ static acpi_status san_consumer_setup(ac
>   		return AE_OK;
>   
>   	/* Ignore ACPI devices that are not present. */
> -	if (acpi_bus_get_device(handle, &adev) != 0)
> +	adev = acpi_fetch_acpi_dev(handle);
> +	if (!adev)
>   		return AE_OK;
>   
>   	san_consumer_dbg(&pdev->dev, handle, "creating device link\n");
> 
> 
> 
