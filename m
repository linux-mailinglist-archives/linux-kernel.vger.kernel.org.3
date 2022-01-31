Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2F4A3FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358105AbiAaKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358070AbiAaKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643624341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezN9srlnTogaHSQ6pDdu/S41B39M1Hq9JuNzonZ57Cg=;
        b=PHkJf5zTNsw/KZ9NsBFrE0Pxt7cRreREq1+rxQ2xWEXOIi3NslVPn/c6aN87W4mmbI1aBU
        4QrVfkacNXPbcRt3VCVTqqTgzHGz5km8e5XlKEYjBILCCCXJ76ZyUrBveNIQZlKCpv/LCG
        SFeWdTzXYLoxHKKwYyr1B9I2JsNcRVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-mJzp9DsmNqixXawQP0VSPQ-1; Mon, 31 Jan 2022 05:19:00 -0500
X-MC-Unique: mJzp9DsmNqixXawQP0VSPQ-1
Received: by mail-wm1-f71.google.com with SMTP id i133-20020a1c3b8b000000b00352cf8b74dcso71572wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ezN9srlnTogaHSQ6pDdu/S41B39M1Hq9JuNzonZ57Cg=;
        b=eZkcHviewT2KnDb4RQeGbBzuapVs2rXuiUFUF1vPuQsqlvSiDNNeA/MsJ6FdMDcSjL
         9swcfHumf12rBbrdh0dNnY4lRAaZ+UVx21qcwkzgI/uRtyU4IlWrtEmcguN0PYwDSJlX
         ioR9f3NXbzLKi4+18nAaPPWRWWatbh9Jb0z0fLCkzbdjDma4ERzd7Lrv2ao3Hg17QSLZ
         RprSqR87sgqKrEXDJTpzyM03iEA2P8pV0X8QWhugzXnP2NKuffXkpKjBmxlicxGSn4im
         7gXGPwWeai6rkbRrpKJWpnxqkWw1cPXe5em8Cd4oFEDFfNhCd7jxADoc+Dt0JlmLwQ1P
         Y91g==
X-Gm-Message-State: AOAM532rhegpaCXd2psEirno1Mgx5TzTSrIRcjXaY0c7//ErJKi73MJo
        bAwG10e7TB27X+B2EXaWzuROhFPNXEYrsYobtNyRe/0m9KbnkC+5qQkG8e+LJSME8HuVOObb82k
        Zgxz4J0GvcbaTPE2SKFIMMV0Q
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr26447553wmr.4.1643624338970;
        Mon, 31 Jan 2022 02:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6yso14y+Zswq6KcxIX1p6IfO2d1DlRdiLxdSQGf4tasukfjBg65Jy0k1OpEVR9pwdMvsjnQ==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr26447519wmr.4.1643624338693;
        Mon, 31 Jan 2022 02:18:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n18sm11302007wrm.47.2022.01.31.02.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 02:18:58 -0800 (PST)
Message-ID: <840ec74d-60c6-9480-709c-8cd597c6f5b0@redhat.com>
Date:   Mon, 31 Jan 2022 11:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com>
 <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <ddb0f354-be19-92fe-20b3-56b00c9304ab@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <ddb0f354-be19-92fe-20b3-56b00c9304ab@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 1/31/22 10:18, Thomas Zimmermann wrote:

[snip]

>> There are some hacks in the driver though. For example it exposes an XRGB8888
>> format even thought the OLED display is monochromatic and has 1 bit per pixel.
>>
>> The driver then goes and converts the XRGB8888 pixels first to grayscale and
>> then to reverse mono. I took that idea from the repaper driver but that gives
>> us the multiple copies that Geert was complaining about.
> 
> This requires to update the console code for 1-bit BW output. The fbcon 
> side already supports this AFAIK. DRM's fbdev needs a few more branches 
> and something like a DRM_FORMAT_C1 fourcc. The XRGB8888 is really a 
> userspace requirement that is imposed by modern desktops. If DRM's 
> console has been updated, you could leave it out entirely.
>
> I could imagine that some simple userspace, such as Weston, comes with 
> support for palette formats and BW. Or there could be an entirely 
> separate program that puts graphics onto these displays.
>

Yes, I understand the rationale of why the repaper driver is doing that way
but was just pointing out because Geert mentioned that is not efficient.
 
Maybe in the meantime we can add a drm_fb_gray8_to_mono_reversed() helper to
drivers/gpu/drm/drm_format_helper.c since there is more than one driver that
does the same ?

It's not a big issue for this device really since the I2C bus is slow anyways
and the multiple copies are not a bottleneck AFAICT.

I believe is worth to propose this driver as is and then try to optimize later.

Another thing that's missing is a DRM_MODE_CONNECTOR_I2C, because I used for
now a DRM_MODE_CONNECTOR_Unknown.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

