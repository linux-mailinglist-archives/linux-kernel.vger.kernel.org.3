Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759CE4A4697
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbiAaMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348589AbiAaMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643630916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHCsLAta/MrnmBGDia3vIQcCGWeVAhBjLYDNsArZji0=;
        b=hSll4ygTTE1M/cbUHdqELAGX+CVlhiATDBBf2KFZoRjlgDOc/KxHLccf3U+jaHNR2VniTc
        Rv4vUn5VjvXy2wPF96RPRdMRvnpHpHI1WaAz5uPU5V4rMBxZeNP0m7W93Yg4XR18SWAzDa
        5pymTT11JCSbJ66BOg0dKeCYQ+g92OA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-FV4CWOOxMRimWP7QkeGPcw-1; Mon, 31 Jan 2022 07:08:35 -0500
X-MC-Unique: FV4CWOOxMRimWP7QkeGPcw-1
Received: by mail-wr1-f69.google.com with SMTP id b3-20020a5d4b83000000b001d676462248so4751022wrt.17
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHCsLAta/MrnmBGDia3vIQcCGWeVAhBjLYDNsArZji0=;
        b=erCdLktQCODSvt1m74s2H5XrhLqiQEHyAxYD6AUN/0pFrf7FT8ij4tr9IvGvYfsYjz
         aBpZUfB4pTgvdwv4MTez/YV6y8y0RMFhh3f6iB6jSe+Cr6HX/UTACK2aP57c268SjrBv
         nTL+KaNKu1KBya0ktPuF/BKy3IfucXUZ3mh7J86B1sZz+/Xq+mN6o8mBWsWtYjjoko0G
         pQLyqgNHrB0e3U0aD3TdiLkr2nQL5e8T9Gv82k3O2pUuYZP9pNldbI3LHug4EYxzNJ6S
         7MEIZLUzoD0BpHidlzkX8AYlkwj5HQ8Olw6n6kppog/S9zGGrOs6qW8EEBrttmz2QBq6
         mQ0g==
X-Gm-Message-State: AOAM530MrMzOjjKD/Hbb37L9O37dtVUu1EnGrDmEmyz+ctyQpQ3qaH2k
        8Kl2ZDAX9OygkleqNSf9Zl2KdqHFvAEEew3sWWyGH71RxQJ6j4fSyrvHoOnhD8FdS01RHJg/zwL
        n/uvGn25Dm/EvNxnWpMAHxNw4
X-Received: by 2002:a5d:4888:: with SMTP id g8mr17557001wrq.555.1643630913955;
        Mon, 31 Jan 2022 04:08:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOkunZZ+NozHmO2zpg9dYPVUqcOa3zg1KoXbyOc53eC4f8o5sv32htjcm8qKyMeiwchXjSIQ==
X-Received: by 2002:a5d:4888:: with SMTP id g8mr17556980wrq.555.1643630913738;
        Mon, 31 Jan 2022 04:08:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5sm12054594wrw.92.2022.01.31.04.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 04:08:33 -0800 (PST)
Message-ID: <5a3fffc8-b2d8-6ac3-809e-e8e71b66a8ea@redhat.com>
Date:   Mon, 31 Jan 2022 13:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
 <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <YffJujbpUGUqpIk/@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YffJujbpUGUqpIk/@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks a lot for your feedback.

On 1/31/22 12:36, Andy Shevchenko wrote:

[snip]

>>
>> Another hack is that I am just hardcoding the {width, height}_mm, but I don't
>> know what DPI could be used for these panels nor how I could calculate the mm.
> 
> I think the hacks is the first what should be eliminated, also see below.
>

Yes, agreed. But as we discussed with Thomas I'll post anyways since these could
be addressed as a follow-up.
 
> ...
> 
>> +config TINYDRM_SSD130X
>> +	tristate "DRM support for Solomon SSD130X OLED displays"
>> +	depends on DRM && OF && I2C
> 
> Please, make sure that it does NOT dependent on OF.
> 

I actually added this dependency deliberative. It's true that the driver is using
the device properties API and so there isn't anything from the properties parsing
point of view that depends on OF. And the original driver didn't depend on OF.

But the original driver also only would had worked with Device Trees since the
of_device_id table is the only one that contains the device specific data info.

The i2c_device_id table only listed the devices supported to match, but then it
would only had worked with the default values that are set by the driver.

So in practice it *does* depend on OF. I'll be happy to drop that dependency if
you provide an acpi_device_id table to match.

> ...
> 
>> +obj-$(CONFIG_TINYDRM_SSD130X)		+= ssd130x.o
> 
> I would keep the original name since we have I2C (fbdev) implementation, SPI
> and platform (fbtft), and now i2c (drm). I would like to avoid more confusion
> that we already have.
> 

I see. That makes sense. Will I keep the original ssd1307 name then and not
rename it to ssd130x (even though it would be more precise since supports a
family of displays).

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

