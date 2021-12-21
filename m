Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E747C70C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbhLUSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237214AbhLUSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640112830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5bwn3O7653maqUOsQ2orunU+e+HhtWjbrBZih1l38M=;
        b=iGvwmE7poNHhFQCYcD3vk/eRU1i8IYwp/Kqh5dyQNV6JonUD+jTIGBMeRcM7wi1/VSW7lD
        XwqWQHYRZqEhd0MU6yzAUS75LZG1UiNuAuziOdR0BKSHnBA4riK2Jp366+1ASUyD9eowjF
        hITdCypKR9/iHJ0/ugJDaywA+/ME758=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-IcV_SE47N92ndpW6Ah0bKw-1; Tue, 21 Dec 2021 13:53:49 -0500
X-MC-Unique: IcV_SE47N92ndpW6Ah0bKw-1
Received: by mail-ed1-f69.google.com with SMTP id l11-20020a056402254b00b003f6a9bd7e81so11052885edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W5bwn3O7653maqUOsQ2orunU+e+HhtWjbrBZih1l38M=;
        b=I7umqhte/3M4lX3OcP9zzCxtp2xqBYTDuRDFwIi+9wncJyKOgI7Huce+8fgNA+ZP7T
         SpMVFSGR8D9Re0SCIGbolZ1V1U32Ssq3p5QNgLbSBfXf50i9RGfVcolEADJzrS5Vgr+V
         nrlVHdUkDiLw3TyS5qxyvHuhNOU0aZA1XwIEyfLqRLtfB+Geh2Ej/bWSTgMtUNCDbosD
         YzeBnvCARcPKBDRn9MlGn7kCrMlgs4OpxliiHSJfIDIVCfnYHI9xyyloRhibP652JfVS
         bytgmwGKYUKREEgu2e86LzizQu0ZObMQDdy6zlZfd8oJcUmXiD2bPn+/QPSPG/XLuguL
         rC7A==
X-Gm-Message-State: AOAM533Gc4GepbQdcZ4zgj66PBTb3PavfnfUYfKDWMMSIm4M1kuA/AjI
        QfywissyXV2zZDjfJw8L86XOREMt6AtCaKYwAdJtdnXemYWuXshKf1rfdelJrlvkjbNCTeEayMM
        DGfIwo4heCzvGOLvKIiatryGd
X-Received: by 2002:a17:907:76a1:: with SMTP id jw1mr3866654ejc.688.1640112827675;
        Tue, 21 Dec 2021 10:53:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjwkqohLOc5TdyN9DabY2Tkk4s0dGx7aC1JkuKscorsxTYtCIRjM/aCM2mH0sM8SQTTtt4YQ==
X-Received: by 2002:a17:907:76a1:: with SMTP id jw1mr3866641ejc.688.1640112827515;
        Tue, 21 Dec 2021 10:53:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ds1sm3378975ejc.97.2021.12.21.10.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:53:47 -0800 (PST)
Message-ID: <3a81d0b0-2dd6-7245-3eef-9fbbf864cbb5@redhat.com>
Date:   Tue, 21 Dec 2021 19:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/3] platform/x86: asus-wmi: Join string literals back
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
References: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/10/21 17:30, Andy Shevchenko wrote:
> For easy grepping on debug purposes join string literals back in
> the messages.
> 
> No functional change.
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
>  drivers/platform/x86/asus-wmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6fa4b0be8e76..30e0de9e0d81 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1154,12 +1154,10 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
>  		absent = (l == 0xffffffff);
>  
>  		if (blocked != absent) {
> -			pr_warn("BIOS says wireless lan is %s, "
> -				"but the pci device is %s\n",
> +			pr_warn("BIOS says wireless lan is %s, but the pci device is %s\n",
>  				blocked ? "blocked" : "unblocked",
>  				absent ? "absent" : "present");
> -			pr_warn("skipped wireless hotplug as probably "
> -				"inappropriate for this model\n");
> +			pr_warn("skipped wireless hotplug as probably inappropriate for this model\n");
>  			goto out_unlock;
>  		}
>  
> 

