Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE13449CFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiAZQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236669AbiAZQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643215272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DxxciFenyllyTJBJcdnpCFKm70eO0yRbePPZj5G/aE=;
        b=DM868+hIFsiotWppKK7im955/Dciz7Dzeq3UzXtmpPCEnXM8J2AMi6DfSuWXDutfcjGQy7
        Rivt4asI8i+bdtxGnkJ8dzJkJaW9eqjwVpvu2Qng9+AVLMsPSGniD4/FBWC74Lc+IBqQ5D
        y0bVGVG4zFXZIFE/8M3HiVytI/FPXgU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-WOSdPoyINtWkn0E_kk23Ig-1; Wed, 26 Jan 2022 11:41:11 -0500
X-MC-Unique: WOSdPoyINtWkn0E_kk23Ig-1
Received: by mail-ej1-f69.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso5141232ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0DxxciFenyllyTJBJcdnpCFKm70eO0yRbePPZj5G/aE=;
        b=fEbgO9g7udZG4KOwp9s0EsMt9jHYPoLVMYvTXtD663N4CTwKkHe+x4sXHIIjzh+Z7T
         Rqqq49Ry1+n7zPci9Mdv4VkDyaS4ybwUW799ggf8Ma8Pp8Oel0LlmmK2VXK32Zk5cEys
         u4tooAeVVxX+SgvgK+IHRt6ccGr+ymkutWVuC+6CnvjTjFgs8pUdG5g9QjDrbwBWGUSf
         QPnSUHdnPyraQsRE+FH8NFAq3+vCvtSPBU3FJkXGCs5lVZvyB47yvUdpfOASWz3D7Q+z
         OabTOVRgKJDF2bC74L3O17KcwabTkOu14SEapmhlPqmkTQtiqEMub8CQUn/SjOkQreea
         1peA==
X-Gm-Message-State: AOAM531hGF7aCdRXx6I9cwkRISxt4o6Tpmbg1TDiJnpI8yQAl79oD0jg
        tw1kdlIB9ejZ2eQ+akQJtXTPHdl+QSUfcCydiL0ea2dR5vV7qHM1RCiVFrME6Je3K7GPZA4UMjm
        0wDS9ioIo6o9lhmeNUgetessF
X-Received: by 2002:a05:6402:114e:: with SMTP id g14mr25372280edw.401.1643215270230;
        Wed, 26 Jan 2022 08:41:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLudT2x12DJguI526J9ikIwHvlqs1R6BWdUsSibS1KsV0Im0ZA7bvfbLwzSynPRwjQzuVFuA==
X-Received: by 2002:a05:6402:114e:: with SMTP id g14mr25372268edw.401.1643215270023;
        Wed, 26 Jan 2022 08:41:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id j2sm7630091ejc.223.2022.01.26.08.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 08:41:09 -0800 (PST)
Message-ID: <049ccc3a-8628-3e90-a4f4-137a286b6dce@redhat.com>
Date:   Wed, 26 Jan 2022 17:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: acpi_get_devices() crash when acpi_disabled==true (was [PATCH v2]
 drm/privacy-screen: honor acpi=off in detect_thinkpad_privacy_screen)
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <20220123091004.763775-1-ztong0001@gmail.com>
 <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
 <CAJZ5v0h51v9fFrJRuaFpSn7J2UEHndEj0f3zpmw=RvgsvAhtvw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0h51v9fFrJRuaFpSn7J2UEHndEj0f3zpmw=RvgsvAhtvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/22 16:54, Rafael J. Wysocki wrote:
> On Wed, Jan 26, 2022 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> On 1/23/22 10:10, Tong Zhang wrote:
>>> when acpi=off is provided in bootarg, kernel crash with
>>>
>>> [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
>>> [    1.258308] Call Trace:
>>> [    1.258490]  ? acpi_walk_namespace+0x147/0x147
>>> [    1.258770]  acpi_get_devices+0xe4/0x137
>>> [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
>>> [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
>>> [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
>>>
>>> The reason is that acpi_walk_namespace expects acpi related stuff
>>> initialized but in fact it wouldn't when acpi is set to off. In this case
>>> we should honor acpi=off in detect_thinkpad_privacy_screen().
>>>
>>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>>
>> Thank you for catching this and thank you for your patch. I was about to merge
>> this, but then I realized that this might not be the best way to fix this.
>>
>> A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
>> and at a first glance about half of those are missing an acpi_disabled
>> check. IMHO it would be better to simply add an acpi_disabled check to
>> acpi_get_devices() itself.
>>
>> Rafael, do you agree ?
> 
> Yes, I do.

Did you see my follow-up that that is not going to work because
acpi_get_devices() is an acpica function ?

Regards,

Hans


 
>>> ---
>>> v2: fix typo in previous commit -- my keyboard is eating letters
>>>
>>>  drivers/gpu/drm/drm_privacy_screen_x86.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
>>> index a2cafb294ca6..e7aa74ad0b24 100644
>>> --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
>>> +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
>>> @@ -33,6 +33,9 @@ static bool __init detect_thinkpad_privacy_screen(void)
>>>       unsigned long long output;
>>>       acpi_status status;
>>>
>>> +     if (acpi_disabled)
>>> +             return false;
>>> +
>>>       /* Get embedded-controller handle */
>>>       status = acpi_get_devices("PNP0C09", acpi_set_handle, NULL, &ec_handle);
>>>       if (ACPI_FAILURE(status) || !ec_handle)
>>
> 

