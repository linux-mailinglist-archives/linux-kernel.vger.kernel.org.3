Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB356C886
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiGIJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGIJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95B9C71BD1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657360086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlyBQAyYHr94kaXAtNbsePMNGWU7xxVjNP6Ohft23ow=;
        b=I+AleDTy2reGvQpCgJk9H+G6BlFWut+Ub2yjbvCrnv4hz9KCRIs7ZJ8CVBKprYiPcA0Udc
        7qKll8TdzeaHH6PaCsgyoWkJq1tr2ZBdGnO5ar2tvSugoMutEHIWNpiIjFUefgiML1u7rW
        zu+XLcez2z8z94p76zwn5cY7D7b4I2M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-VEbdloxNOQaQmD785OTP2g-1; Sat, 09 Jul 2022 05:48:05 -0400
X-MC-Unique: VEbdloxNOQaQmD785OTP2g-1
Received: by mail-ed1-f70.google.com with SMTP id z17-20020a05640235d100b0043762b1e1e3so815617edc.21
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=BlyBQAyYHr94kaXAtNbsePMNGWU7xxVjNP6Ohft23ow=;
        b=Sw7oouMHTFLA3hb9o1pcx7GS5YT2iDdyPg+wpr7zU4skCVz1pIak8HXi2Z79wyoMVO
         LCj/MorjiJo+KZPgm/FfM0i9hi9sumk9440ZT98RZZGtDJZNINcwqWKOSQRc3rV7XcG9
         eOcTyK1QafREIpEp5q6X51B1uuO99qmEFfk/Oxv/hL+01MDpKQgMZjiA8U3jjBfxoLZP
         XTn73TtQxKKYhg7PeJv80TJsIEKAqndJ1PYhdf4z2uB36X772tXG3TDlUezDjxPfewYG
         z/1OrKjUYQ9Pu07zfceDQsN7hySNtDzSm2DwWx9Fd4G0TRAXOMy+YaAQ/pP2hP0edMpK
         De4A==
X-Gm-Message-State: AJIora+u8n5qR4+HBMnnVmq3c/gIKc+ag1mS95aGKTBR30rIdC2OJCTd
        5KMkNCD+3EjYa+EHpTboAhO5XdfuLJodvB1q77DmKUivMOqDwwaagIkQChuBAxbYVRm+ue7KCGg
        mlrMw3vtDYlvKK53b1dgeRt+L
X-Received: by 2002:a05:6402:7da:b0:43a:6fe3:b7a9 with SMTP id u26-20020a05640207da00b0043a6fe3b7a9mr10483555edy.410.1657360084322;
        Sat, 09 Jul 2022 02:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCp3mRdrtnkzP+ynBSq50nc9ST/sufvKQLSHaXJ+i+49NH7M0ZCD5q8Pppa2o0iJgLjgnwHg==
X-Received: by 2002:a05:6402:7da:b0:43a:6fe3:b7a9 with SMTP id u26-20020a05640207da00b0043a6fe3b7a9mr10483532edy.410.1657360084113;
        Sat, 09 Jul 2022 02:48:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7cf19000000b0043a56c0ededsm680948edy.74.2022.07.09.02.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 02:48:03 -0700 (PDT)
Message-ID: <edba69a1-3404-d20f-2a9c-6359de37b6ee@redhat.com>
Date:   Sat, 9 Jul 2022 11:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/7] platform/x86: serial-multi-instantiate: Improve
 autodetection
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Gross <markgross@kernel.org>, patches@opensource.cirrus.com
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
 <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<resend with Stefan added to the To list>

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

