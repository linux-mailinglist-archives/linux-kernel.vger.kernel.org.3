Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2846AAA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbhLFVrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:47:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhLFVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638827029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8x4Za6C1SKdjmI4dd+6+FORy8khSlP5uUZL1WRSnZI=;
        b=coKP5lmTeTnTHqW1QXHnDn6dMNwXrySSxSNaHEvBbBEf4aext9zEjMqmzSjlPt87AHRNQv
        Pb0cecoKiyGtlEqizmrV9IMCggye+D925+7n6XVv7LdskWDa0gowQsRHagtf4ssRE4Z05W
        7lniQuMZbJOY9S9ZsS2f9O4rmLEZVkc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-Wowb0crEMLKip6RTuH6pbg-1; Mon, 06 Dec 2021 16:43:48 -0500
X-MC-Unique: Wowb0crEMLKip6RTuH6pbg-1
Received: by mail-ed1-f72.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso9493880edq.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z8x4Za6C1SKdjmI4dd+6+FORy8khSlP5uUZL1WRSnZI=;
        b=WvB40cnF87x0f2qcffbT/qm+08YH4sZQdrClD9I36grS0AzXQJEMyKdWxNM+tbiTG6
         /VPV1lhQzg/aXyJrnZzojKJzKk9TuXKrpWPOMEnJG9McCbnhY/PhxF1lVivKbSpivPei
         y//LL14mHs5IGkisAaMHsu8XL5k8uZoVIMO4EZIAgH4cYVY1L50B6zywlaTYVYPNBKCZ
         OMF3Lv4079gSpbnl7JRP8O6+v7/Tsc/M39YttnXES9iQSGinUj5Kjmz4MQUjcEQ+nS9i
         QstGoEkQ5K0pRedSah4uOmUXhypJGNwwldHIPByONRuLFNj9z1ODXikzIElo3qglyydb
         hbbA==
X-Gm-Message-State: AOAM531xGuPQPozRrAKLfCpVzeMHo/tHAFKrhC8yaEtXftFjcf2K8q3n
        KN8H+iZDdGYhSBd+Tcp5UBvm3mgYC7Smwv1ut5jJE78iJHvgU6k7URGaNLApku2qjjWZtZ4qy9O
        74gQ0wZY/ylTA7BTJdpEeRICX
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr2560663edb.12.1638827026525;
        Mon, 06 Dec 2021 13:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4MsBIVkMvpki2o2EhIDEFsFDRxUuVK9K73jj6UOYn9igl17c+n/RVxAb0jg1mF5zcNeftbw==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr2560637edb.12.1638827026303;
        Mon, 06 Dec 2021 13:43:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x14sm7238396ejs.124.2021.12.06.13.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:43:45 -0800 (PST)
Message-ID: <8138caf0-8c4d-de5f-6643-5da3214d3563@redhat.com>
Date:   Mon, 6 Dec 2021 22:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/1] platform/x86: hp_accel: Use SIMPLE_DEV_PM_OPS()
 for PM ops
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Mark Gross <markgross@kernel.org>
References: <20211206151521.22578-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211206151521.22578-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/6/21 16:15, Andy Shevchenko wrote:
> After the commit 34570a898eef ("platform/x86: hp_accel: Remove
> _INI method call") there is no need to have separate methods for
> resume and restore, hence we may fold them together and use
> SIMPLE_DEV_PM_OPS() for PM ops.
> 
> While at it, switch to use __maybe_unused attribute.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  drivers/platform/x86/hp_accel.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index 435a91fe2568..e9f852f7c27f 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -355,39 +355,20 @@ static int lis3lv02d_remove(struct platform_device *device)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int lis3lv02d_suspend(struct device *dev)
> +static int __maybe_unused lis3lv02d_suspend(struct device *dev)
>  {
>  	/* make sure the device is off when we suspend */
>  	lis3lv02d_poweroff(&lis3_dev);
>  	return 0;
>  }
>  
> -static int lis3lv02d_resume(struct device *dev)
> +static int __maybe_unused lis3lv02d_resume(struct device *dev)
>  {
>  	lis3lv02d_poweron(&lis3_dev);
>  	return 0;
>  }
>  
> -static int lis3lv02d_restore(struct device *dev)
> -{
> -	lis3lv02d_poweron(&lis3_dev);
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops hp_accel_pm = {
> -	.suspend = lis3lv02d_suspend,
> -	.resume = lis3lv02d_resume,
> -	.freeze = lis3lv02d_suspend,
> -	.thaw = lis3lv02d_resume,
> -	.poweroff = lis3lv02d_suspend,
> -	.restore = lis3lv02d_restore,
> -};
> -
> -#define HP_ACCEL_PM (&hp_accel_pm)
> -#else
> -#define HP_ACCEL_PM NULL
> -#endif
> +static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_resume);
>  
>  /* For the HP MDPS aka 3D Driveguard */
>  static struct platform_driver lis3lv02d_driver = {
> @@ -395,7 +376,7 @@ static struct platform_driver lis3lv02d_driver = {
>  	.remove	= lis3lv02d_remove,
>  	.driver	= {
>  		.name	= "hp_accel",
> -		.pm	= HP_ACCEL_PM,
> +		.pm	= &hp_accel_pm,
>  		.acpi_match_table = lis3lv02d_device_ids,
>  	},
>  };
> 

