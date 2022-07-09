Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07656C86C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGIJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06441655AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657360037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVjul2vVFMPSpvmkVCAUVdXizXpt78M3xwKxWk3zHY0=;
        b=V9tHx/L3ecaAbsW7nYGPbvKyxCYu37BxUNYyK7njXO7tJzrWVV1omMbLrVN1jch/2g94dG
        DSeNj85/wP4f7bmo/Urkz1NTfTTGwXGcZ9BtJjUC1PYfLS/nv/5WSrGMZl1sJHStCK00nn
        6GAyQwZW1JXmc0ZaI20F92MzQkALDVw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-W1T-PDzEPD2QTFnxBn6k6Q-1; Sat, 09 Jul 2022 05:47:15 -0400
X-MC-Unique: W1T-PDzEPD2QTFnxBn6k6Q-1
Received: by mail-ed1-f72.google.com with SMTP id h16-20020a05640250d000b00435bab1a7b4so827204edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oVjul2vVFMPSpvmkVCAUVdXizXpt78M3xwKxWk3zHY0=;
        b=ENGWXuz/yvJqSZq30GUUSDkTbCv8RF30LdErX1t+pGklmtrPTkcJSy0ERS/XOkeuzn
         qBXFuMVIGkusprkLcXBPFW2oiiZogGC5H4MMMsbCdIQt2kBPkpNySDy+Nsev9M5cp4HC
         hjV4WzrSPO9NNjvKeNVHNhxHCb7vx8nshOb2ibX0HCHMhQOmhwcSxnsE9DN/rPE0atWl
         y/A4a87mWm1ORAl8eVUvsc+w8v6Qt1DY3Eo2+bVLaOjYCdES27kDK1nMWt0EB6d9JsLN
         /e3h570rREuwcsLCjk7C/bkLzzZQvQgAS2lx3N8w7ZAaaMt1vj//lIV5GrVCvropagsz
         BxJQ==
X-Gm-Message-State: AJIora+VcxesPSqnLA5aFNmvMc0DfXwTlNi74Nh7yLwvscjkhCKJstGK
        Co2oKtuIN/N7Cz4ke5Z3XJualyAIUzmmZiqOsV5prab/csXwbF0fW1BQnmhULu38ohGCB5Se6u7
        XrckkFQHjJOEioR+8kI2ipRO5
X-Received: by 2002:a05:6402:26c8:b0:43a:c404:a553 with SMTP id x8-20020a05640226c800b0043ac404a553mr972156edd.53.1657360033898;
        Sat, 09 Jul 2022 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXnhUx6P1aaMUqcqU4AG0UIrUqo7LsszkPewfUUVM8I3enoWg8y6z1maxgws7Of6Id+JDpwQ==
X-Received: by 2002:a05:6402:26c8:b0:43a:c404:a553 with SMTP id x8-20020a05640226c800b0043ac404a553mr972140edd.53.1657360033730;
        Sat, 09 Jul 2022 02:47:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l1-20020aa7c301000000b0043ab5939ecbsm684940edq.59.2022.07.09.02.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 02:47:13 -0700 (PDT)
Message-ID: <9826f272-ed7d-1daa-c852-6f353258bb2b@redhat.com>
Date:   Sat, 9 Jul 2022 11:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/7] platform/x86: serial-multi-instantiate: Improve
 autodetection
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
 <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/9/22 02:06, Andy Shevchenko wrote:
> Instead of calling specific resource counter, let just probe each
> of the type and see what it says. Also add a debug message when
> none is found.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Only probing for I2C resources if some are present is deliberate:

commit 68f201f9061c000d7a4a9f359f021b1cd535d62b
Author: Stefan Binding <sbinding@opensource.cirrus.com>
Date:   Fri Jan 21 17:24:29 2022 +0000

    platform/x86: serial-multi-instantiate: Add SPI support
    
    Add support for spi bus in serial-multi-instantiate driver
    
    Some peripherals can have either a I2C or a SPI connection
    to the host (but not both) but use the same HID for both
    types. So it is not possible to use the HID to determine
    whether it is I2C or SPI. The driver must check the node
    to see if it contains I2cSerialBus or SpiSerialBus entries.
    
    For backwards-compatibility with the existing nodes I2C is
    checked first and if such entries are found ONLY I2C devices
    are created. Since some existing nodes that were already
    handled by this driver could also contain unrelated
    SpiSerialBus nodes that were previously ignored, and this
    preserves that behavior. If there is ever a need to handle
    a node where both I2C and SPI devices must be instantiated
    this can be added in future.
    
    Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
    Link: https://lore.kernel.org/r/20220121172431.6876-8-sbinding@opensource.cirrus.com
    Reviewed-by: Hans de Goede <hdegoede@redhat.com>
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>

So nack for this change.

Regards,

Hans



> ---
>  drivers/platform/x86/serial-multi-instantiate.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 97db23243018..e599058196bb 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -232,6 +232,7 @@ static int smi_probe(struct platform_device *pdev)
>  	const struct smi_node *node;
>  	struct acpi_device *adev;
>  	struct smi *smi;
> +	int ret;
>  
>  	adev = ACPI_COMPANION(dev);
>  	if (!adev)
> @@ -255,15 +256,20 @@ static int smi_probe(struct platform_device *pdev)
>  	case SMI_SPI:
>  		return smi_spi_probe(pdev, adev, smi, node->instances);
>  	case SMI_AUTO_DETECT:
> -		if (i2c_acpi_client_count(adev) > 0)
> -			return smi_i2c_probe(pdev, adev, smi, node->instances);
> -		else
> -			return smi_spi_probe(pdev, adev, smi, node->instances);
> +		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
> +		if (ret && ret != -ENOENT)
> +			return ret;
> +		ret = smi_spi_probe(pdev, adev, smi, node->instances);
> +		if (ret && ret != -ENOENT)
> +			return ret;
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Error No resources found\n");
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return 0; /* never reached */
> +	return 0;
>  }
>  
>  static int smi_remove(struct platform_device *pdev)

