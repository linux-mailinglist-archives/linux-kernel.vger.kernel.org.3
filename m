Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA5490502
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiAQJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235947AbiAQJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642412286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87TQKP21MvIUTnFRp1IlMrCnN3l9CJpODRDFyyIfhfE=;
        b=jEuVqSk2f6TE2KlcTHfpNo+kxQymExMhJR9S65a7w3TW4R44KvXbq6dBVENRm6DSIgXaXL
        uZNldEMY1vaozc/EfA3N6cXF2tDej9ntS8onqX0gGtFFlpyXxt21W4yAQeal2/+KxYwQg/
        SgNSPC20d8hOFTfAZyLyoe4qaPunnVI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-CsDmz-WPND-nQudKReXabw-1; Mon, 17 Jan 2022 04:38:03 -0500
X-MC-Unique: CsDmz-WPND-nQudKReXabw-1
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so13712566edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=87TQKP21MvIUTnFRp1IlMrCnN3l9CJpODRDFyyIfhfE=;
        b=4RzogqtIa0Al5nG2S4pIuPAZ2UoCL3rXTCmg2/KCoF3s5f5uzJd6Qse6H4hp/Ddsu+
         uLGDbdhCxZVxoV6gHUGVNJ5hr6YTFgf+ioFrzFAwtSk/HJbo5z4hNjyOUIU/4Ig316FE
         XNeDNd6mMlq2sy+SxUbVptefH8zConkE0QWummORbu1ngRgDiSEo9L/25eYf3eMYeRqJ
         1MQ0DhI/ieGozBonbwddT0C6qXnOwX5EvjAKFYk7JOFuj5KS2comkSVfNcYSFqOz4ZeE
         /rZXxk94P+RRuUY8l4NI2WbrPERq8rzgCfi93d/oES2nbFTmqwPlxRkyXl6q8R+J93Gs
         C5+A==
X-Gm-Message-State: AOAM530OvDEr/fOgrr7Q1ALRFyNQ5y/YbCU60cVL2MawMup6dRrl0FDu
        WFEmhtWblJ4iEszRXWozRbCzlkRzIzK6ZG1s4H+iaboOsH5WLAQsIGViPmvT6qbJIWRvckrOBeR
        FttuuY718eetc6yQSUUfhiB1P
X-Received: by 2002:a17:906:b286:: with SMTP id q6mr11945526ejz.496.1642412282167;
        Mon, 17 Jan 2022 01:38:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2KK/fmStojUMqn34rE0EHBYoqOqN0OB1KrIqmFJam0AvqPc5evTRU+IpJZucQ2ivN2RAQ+g==
X-Received: by 2002:a17:906:b286:: with SMTP id q6mr11945515ejz.496.1642412281936;
        Mon, 17 Jan 2022 01:38:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y2sm5686084eda.45.2022.01.17.01.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 01:38:01 -0800 (PST)
Message-ID: <a8bb5224-e77d-fc3e-4619-2ca5f46305a5@redhat.com>
Date:   Mon, 17 Jan 2022 10:38:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/surface: Reinstate platform dependency
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Jarrett Schultz <jaschultz@microsoft.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220115140849.269479-1-geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220115140849.269479-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/15/22 15:08, Geert Uytterhoeven wrote:
> Microsoft Surface platform-specific devices are only present on
> Microsoft Surface platforms, which are currently limited to arm64 and
> x86.  Hence add a dependency on ARM64 || X86, to prevent asking the user
> about drivers for these devices when configuring a kernel for an
> architecture that does not support Microsoft Surface platforms.
> 
> Fixes: 272479928172edf0 ("platform: surface: Propagate ACPI Dependency")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
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
>  drivers/platform/surface/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> index 5f0578e25f718f14..463f1ec5c14e9fa9 100644
> --- a/drivers/platform/surface/Kconfig
> +++ b/drivers/platform/surface/Kconfig
> @@ -5,6 +5,7 @@
>  
>  menuconfig SURFACE_PLATFORMS
>  	bool "Microsoft Surface Platform-Specific Device Drivers"
> +	depends on ARM64 || X86 || COMPILE_TEST
>  	default y
>  	help
>  	  Say Y here to get to see options for platform-specific device drivers
> 

