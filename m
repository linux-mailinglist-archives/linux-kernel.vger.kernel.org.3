Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D247E4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348972AbhLWOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348888AbhLWOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640270548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NePF0G+zaojTZZkb8QhcihnP9zNw8F/c7VrSRaTmGvo=;
        b=hWyXGxRsgXBMItJ7mtkxfLS/sDAWjpvNKjlyJ7gvo3J+gbSkZLAgHcAX789x5xhE9OdGTV
        s8BQe1+v68MDN/R0r65SIIyrqXP+xeIzpxOZr56ZZ8QcQHtqC+zh2NWTqOKjSPTIS/yERe
        tWjx09kvrZpezmLng35kQ+HbYaS8Wfs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-BH_vD0D6OJecbdy80Dc7mg-1; Thu, 23 Dec 2021 09:42:26 -0500
X-MC-Unique: BH_vD0D6OJecbdy80Dc7mg-1
Received: by mail-ed1-f72.google.com with SMTP id v18-20020a056402349200b003f8d3b7ee8dso1202058edc.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NePF0G+zaojTZZkb8QhcihnP9zNw8F/c7VrSRaTmGvo=;
        b=PAyNAEBE246bq8f5MTERxKeTFLiIBS6nc2yK4vAJrPNrBRxs/SYcfHhcxIBRQHNKsH
         FV0rZt+RgItQtPracrIeygQR1Mjhk3YO0MnSu82RDnwVdeLaIrgFpuyZJbU0czrGiqYi
         Oaf0J8wuLzDHRwdkmK9QJvOMszx9veJuWDA7HDkUcTMSZESEM5Xb4kemZ2gm6tYUhL4/
         ZUzSXvGNn5C7kr/WlE+0wHTE4OOxfTsVBjco8NgpRCZBO/vQ8vCuBU9YHvRSOYZ4qUe6
         Ln9Z/YpTBovwYbbdQ2pjmk+EYbzC3xQKVglLaKGmnRFudMamy7hoLREMAvda1yAsQdIY
         oRng==
X-Gm-Message-State: AOAM531TiZEHnips/8hOGA5FtFGjld1nVTRp87ADa5+YMdTcCdiFdTWW
        e9wMCaStMebHhYa6pCWxdjl/f0c/yjbHfvZO2AsxUA/7Tpj9LysNnCZi3rSmyAwVevww18ti6G7
        Zkr/CpnGR8ms3PXEP6g+sjKRE
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr2097127eji.233.1640270545705;
        Thu, 23 Dec 2021 06:42:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznj/kUZYc0QKrD5DjQ1PTRWFXaLSn7n4HPNSSlKozWRSH4qOJXb2ImtjK3l+B+AwybaFPhNQ==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr2097118eji.233.1640270545544;
        Thu, 23 Dec 2021 06:42:25 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c8sm2021557edu.60.2021.12.23.06.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:42:25 -0800 (PST)
Message-ID: <9b004b3d-deed-1b63-2344-a445a9e53b61@redhat.com>
Date:   Thu, 23 Dec 2021 15:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        linux-input@vger.kernel.org, dianders@chromium.org,
        "jingle.wu" <jingle.wu@emc.com.tw>
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <YcE+xrSnS7qw0G1/@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YcE+xrSnS7qw0G1/@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/21 03:41, Dmitry Torokhov wrote:
> Hi Raul,
> 
> On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
>> @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
>>  	}
>>  
>>  	/*
>> -	 * Systems using device tree should set up wakeup via DTS,
>> +	 * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
>>  	 * the rest will configure device as wakeup source by default.
>>  	 */
>> -	if (!dev->of_node)
>> +	if (!dev->of_node && !ACPI_COMPANION(dev)) {
> 
> I think this will break our Rambis that use ACPI for enumeration but
> actually lack _PRW. As far as I remember their trackpads were capable
> of waking up the system.
> 
> I think we should remove this chunk completely and instead add necessary
> code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
> have additional member in struct acpi_peripheral to indicate whether
> device needs to be configured for wakeup and then act upon it in
> chromeos_laptop_adjust_client().
> 
>>  		device_init_wakeup(dev, true);
>> +		dev_pm_set_wake_irq(dev, client->irq);
>> +	}

As I already mentioned in my other reply in this thread:

https://lore.kernel.org/linux-input/f594afab-8c1a-8821-a775-e5512e17ce8f@redhat.com/

AFAICT most x86 ACPI laptops do not use GPEs for wakeup by touchpad and
as such they do not have a _PRW method.

So for wakeup by elan_i2c touchpads to keep working this code is not
just necessary for some ChromeOS devices, but it is necessary on
most ACPI devices.

The problem of not making these calls on devices where a GPE is actually
used for touchpad wakeup (which at least for now is the exception not
the rule) should probably be fixed by no running this "chunk"
when the device has an ACPI_COMPANION (as this patch already checks)
*and* that ACPI_COMPANION has a valid _PRW method.

Simply removing this chunk, or taking this patch as is will very
likely lead to regressions on various x86 laptop models.

Regards,

Hans

