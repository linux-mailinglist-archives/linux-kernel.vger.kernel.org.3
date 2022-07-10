Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA356D000
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGJQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11B35641B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657469668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFxyhw3hxCeITYGqSpvXClKGZ7TaZDyQ/0GKQi35CAo=;
        b=IkX+Wd2cfOOv1djN/T2iSvSgZjXtusNAQ0mkaMgsBGonic+vkIaSg4obPfpuZ84jLq90Jg
        7st4ts7nocyOT8KG/e0yl5RRosKo6ZGQo6MuJ9ANlnURp1EBg7wqSj6bPcvor2jm7V6olR
        FgdQ+ErowwVzJfJNRoG9RNyvxRRfPr4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-sE9D9AO3Ny2pvCzrQGjlJg-1; Sun, 10 Jul 2022 12:14:26 -0400
X-MC-Unique: sE9D9AO3Ny2pvCzrQGjlJg-1
Received: by mail-ed1-f70.google.com with SMTP id j6-20020a05640211c600b0043a8ea2c138so2716016edw.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AFxyhw3hxCeITYGqSpvXClKGZ7TaZDyQ/0GKQi35CAo=;
        b=e0KMKDZzlB5DstMaZt8f5AMx/6XCeJ20631W/n3kXcroAv+RP8sfplB6/iZGNyo2Ca
         fn2WB5S4NhvL5VwxJgakfGhjvZUrJ9QQz8XG+fM/mY5NGhoyVYmfUj0goxnsJrGtz0qt
         vW1zS+dVcYrveItdBwSmGk/8g3hEBgzIVz9+YTn3pJIzmklp8ZN/GvUFude8ew2lLpB8
         wkWHw3L4veYE0VCe2J3YnbTKwoQLD2Hmp/sGH5TA+ZeeaqlkfBkWVY+RivxNbVx90Eo1
         /Cv3PIsN/r1fMR9Jl07tr9xPQEgHEDVnbU7DAn/c66eEXBJfF8uHLvXPNQ16xENuuRNa
         9DNw==
X-Gm-Message-State: AJIora9UNcBwiwOPO7Z+7jMMOPlvUAPwW9SGgDej9P+O8Db5dCgpQEen
        sWPxKXldFFKBQvmu3gkDAK76M2mfBaysrzyrvgRoCUDtYhOAr2la6VXdPGTgQMiTWDpQLh2nZUg
        a5+q60pto1dF22Q+blXVkmyhj
X-Received: by 2002:aa7:d143:0:b0:43a:88f4:4ec1 with SMTP id r3-20020aa7d143000000b0043a88f44ec1mr19442267edo.141.1657469665610;
        Sun, 10 Jul 2022 09:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vhzc/cdal9a4+4hJM9ZpgcURVq2YCEddp9nP2O73BIffQ2uRNftTxYpAqo9taQcZY2/dOvDg==
X-Received: by 2002:aa7:d143:0:b0:43a:88f4:4ec1 with SMTP id r3-20020aa7d143000000b0043a88f44ec1mr19442240edo.141.1657469665413;
        Sun, 10 Jul 2022 09:14:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id sd33-20020a1709076e2100b0072afb23fb9esm1723591ejc.16.2022.07.10.09.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 09:14:25 -0700 (PDT)
Message-ID: <08d17a63-3c77-0422-b2a9-64f154358276@redhat.com>
Date:   Sun, 10 Jul 2022 18:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/6] platform/x86: serial-multi-instantiate: Improve
 autodetection
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/9/22 23:16, Andy Shevchenko wrote:
> Instead of calling specific resource counter, let just probe each
> of the type and see what it says. Return -ENOENT if no resources
> found.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> v2: squashed patch 1, restored behaviour, added comment, dropped message (Hans)
>  .../platform/x86/serial-multi-instantiate.c   | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 1e8063b7c169..366087a9fce2 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -100,7 +100,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
>  	if (ret < 0)
>  		return ret;
>  	else if (!ret)
> -		return -ENODEV;
> +		return -ENOENT;
>  
>  	count = ret;
>  
> @@ -184,7 +184,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
>  	if (ret < 0)
>  		return ret;
>  	else if (!ret)
> -		return -ENODEV;
> +		return -ENOENT;
>  
>  	count = ret;
>  
> @@ -232,6 +232,7 @@ static int smi_probe(struct platform_device *pdev)
>  	const struct smi_node *node;
>  	struct acpi_device *adev;
>  	struct smi *smi;
> +	int ret;
>  
>  	adev = ACPI_COMPANION(dev);
>  	if (!adev)
> @@ -255,15 +256,21 @@ static int smi_probe(struct platform_device *pdev)
>  	case SMI_SPI:
>  		return smi_spi_probe(pdev, adev, smi, node->instances);
>  	case SMI_AUTO_DETECT:
> -		if (i2c_acpi_client_count(adev) > 0)
> -			return smi_i2c_probe(pdev, adev, smi, node->instances);
> -		else
> -			return smi_spi_probe(pdev, adev, smi, node->instances);
> +		/*
> +		 * For backwards-compatibility with the existing nodes I2C
> +		 * is checked first and if such entries are found ONLY I2C
> +		 * devices are created. Since some existing nodes that were
> +		 * already handled by this driver could also contain unrelated
> +		 * SpiSerialBus nodes that were previously ignored, and this
> +		 * preserves that behavior.
> +		 */
> +		ret = smi_i2c_probe(pdev, adev, smi, node->instances);
> +		if (ret != -ENOENT)
> +			return ret;
> +		return smi_spi_probe(pdev, adev, smi, node->instances);
>  	default:
>  		return -EINVAL;
>  	}
> -
> -	return 0; /* never reached */
>  }
>  
>  static int smi_remove(struct platform_device *pdev)

