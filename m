Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152947E7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbhLWSsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349879AbhLWSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640285281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yA57few3f6tSjdsufvGnJgK9V8OGmZJcp6eJoOPkJr0=;
        b=U6g/Vv53cIi6wJaAKfNkUCRucsoMMl63B11gM0rPT+i9uNcUkRLG7IpUFizYMTVJ5PMvTd
        cVlDxamOd4IqFXTYJr9zmmC7eBLamOnoQfaGkNFsP5I2hqeWrnY9hzqODskRfcVPj4+39Z
        +/TL3SflfIvf2Ff6kBo9N1jNGrpUfZc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-6aukRXdpN1qbnWXGdadm8A-1; Thu, 23 Dec 2021 13:47:59 -0500
X-MC-Unique: 6aukRXdpN1qbnWXGdadm8A-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso5094379edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yA57few3f6tSjdsufvGnJgK9V8OGmZJcp6eJoOPkJr0=;
        b=ZJaETpHQQqtaG3baH1ev6hJpS78CApCOsjz9vicMeWe50Fq0Pb2m4r3RgxIRnCOyNa
         AThAduGm+Ej19uyoAfWBn1gthPATTsxOmgOPdh0XclgDoO0FIWaws1tVWahJRUNMWxLw
         gbGnWo703N8Fwo7TQgoiezPSUHPkgBSeTXqB1WMd4Ew9b6245pw88gx9nm2p4dXX2ETL
         S5DMfFCCN36JoTLMDYs0op1fubN1He9YbIJ5SNRniXEA1wIIyfPEriTk/Pa/n+R07toU
         sV8z5rwNrDwXh2QUofdo7vyUGJen4WnBuxLQ6kgeA+Wqd3VSOEJBYHNOeHAFfBB/UdOj
         r5Ow==
X-Gm-Message-State: AOAM530bjEduuzuRKcTlXpB+HtFY/2Fa4kzu/eJ2RrqcxQA/o86aktpr
        fQ37WK6UCYpUc4CGJwhSvowqPRh9gqr4twn1OD4U8m2iXYavrdOwwF7bKAKEkHFDsb6OvmOvG6W
        vRV2QbxWpcuAA0zSBrVMIFJYB
X-Received: by 2002:a17:907:9718:: with SMTP id jg24mr2884532ejc.621.1640285278314;
        Thu, 23 Dec 2021 10:47:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLj3Q95ZXvQgGzi+c46JIGWosBY7rxtPaJg64hB/Fu20F/lDeeGqVgOJtfAqpWbB04AGr8Jw==
X-Received: by 2002:a17:907:9718:: with SMTP id jg24mr2884515ejc.621.1640285278050;
        Thu, 23 Dec 2021 10:47:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b4sm1976103ejl.206.2021.12.23.10.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 10:47:57 -0800 (PST)
Message-ID: <117383d0-6bc7-4093-53b8-e90e86c29db7@redhat.com>
Date:   Thu, 23 Dec 2021 19:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: intel_pmc_core: fix memleak on registration
 failure
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20211222105023.6205-1-johan@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211222105023.6205-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/22/21 11:50, Johan Hovold wrote:
> In case device registration fails during module initialisation, the
> platform device structure needs to be freed using platform_device_put()
> to properly free all resources (e.g. the device name).
> 
> Fixes: 938835aa903a ("platform/x86: intel_pmc_core: do not create a static struct device")
> Cc: stable@vger.kernel.org      # 5.9
> Signed-off-by: Johan Hovold <johan@kernel.org>

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
>  drivers/platform/x86/intel/pmc/pltdrv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
> index 73797680b895..15ca8afdd973 100644
> --- a/drivers/platform/x86/intel/pmc/pltdrv.c
> +++ b/drivers/platform/x86/intel/pmc/pltdrv.c
> @@ -65,7 +65,7 @@ static int __init pmc_core_platform_init(void)
>  
>  	retval = platform_device_register(pmc_core_device);
>  	if (retval)
> -		kfree(pmc_core_device);
> +		platform_device_put(pmc_core_device);
>  
>  	return retval;
>  }
> 

