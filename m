Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925D349E308
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiA0NFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238381AbiA0NFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643288734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KI8O/+QE30+mvlTFMZHymj0zomSuxjP+plQZT8lKM1I=;
        b=HDe+BVFtOvYgBHqBH49bogPaLpq/aL1z9u/3zkm3d6k7g7J1QBJX1G5YDdoGXEy7CUFRiI
        V6siTEIE6LPV16IBaq6S3/dkJtlw+Dl7wY6rAIs8wVpQsfaa4dECFMI1x7B434hjsuh8Gq
        so0nw2wQDRS0vxc8ucqO3v+In3fIPZo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-7_gEyMJKPCuVVWh9R-IiEw-1; Thu, 27 Jan 2022 08:05:33 -0500
X-MC-Unique: 7_gEyMJKPCuVVWh9R-IiEw-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so1401157edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KI8O/+QE30+mvlTFMZHymj0zomSuxjP+plQZT8lKM1I=;
        b=5Hofqns050RDaDGMiPVXa3bzhNz4kcWVArGfWX1bADhQc1xWp2TDZKEqNg0tvzJVfM
         bxjlQzW8/cTz+An1SW2jF2BIVoV40OBw6rR1wKB2UDLf+O2vRSzAe3FKOy6zwfwd4Tgi
         hssqVDH3P24Mf22XTukhSXu1Fv1lJM4JGsJRRANpEWuIgCcEFRuo5ypT5M+hd0xhIx/I
         Tt7ATm1317G05bBtHCoziEAti3UN3bLBNfkH2wn5sHil0/Cimc9j1VnIDLtxATk7z+xo
         1a34UIMWMcaI+T8LKqHiEfGcQBuaqvU/WiVipVHwI9PvpQCfMsjXtattD2qJ1fKN7udw
         BgJw==
X-Gm-Message-State: AOAM533dqxJW+qt52UeR91D/lJ2HpwLoXYoAjWoXtQPFw4bAZ4Rxh+jX
        GqqcCPE/8CkNgg6K9UkOY9guYjKcu5r0p0i5gazXJ73Vq8CZpsxSCJJUk4hYeEy6XOV5aejwXuy
        P42pF0NFikYrplWA0nFLeePBJ
X-Received: by 2002:a17:907:9620:: with SMTP id gb32mr2856625ejc.436.1643288732276;
        Thu, 27 Jan 2022 05:05:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzokiZPPXfvS9vpKO6dRbaV14vyucg20GEn2I/hZqfZxydUz4hZ+WYaPj6PFTCoQt9oONcYnQ==
X-Received: by 2002:a17:907:9620:: with SMTP id gb32mr2856596ejc.436.1643288731728;
        Thu, 27 Jan 2022 05:05:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id h6sm8627763ejx.164.2022.01.27.05.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:05:31 -0800 (PST)
Message-ID: <994f94b2-61d3-1754-d733-732a0fb47d50@redhat.com>
Date:   Thu, 27 Jan 2022 14:05:30 +0100
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
 <049ccc3a-8628-3e90-a4f4-137a286b6dce@redhat.com>
 <CAJZ5v0hJWW_vZ3wwajE7xT38aWjY7cZyvqMJpXHzUL98-SiCVQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hJWW_vZ3wwajE7xT38aWjY7cZyvqMJpXHzUL98-SiCVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/22 18:11, Rafael J. Wysocki wrote:
> On Wed, Jan 26, 2022 at 5:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/26/22 16:54, Rafael J. Wysocki wrote:
>>> On Wed, Jan 26, 2022 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> On 1/23/22 10:10, Tong Zhang wrote:
>>>>> when acpi=off is provided in bootarg, kernel crash with
>>>>>
>>>>> [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
>>>>> [    1.258308] Call Trace:
>>>>> [    1.258490]  ? acpi_walk_namespace+0x147/0x147
>>>>> [    1.258770]  acpi_get_devices+0xe4/0x137
>>>>> [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
>>>>> [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
>>>>> [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
>>>>>
>>>>> The reason is that acpi_walk_namespace expects acpi related stuff
>>>>> initialized but in fact it wouldn't when acpi is set to off. In this case
>>>>> we should honor acpi=off in detect_thinkpad_privacy_screen().
>>>>>
>>>>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>>>>
>>>> Thank you for catching this and thank you for your patch. I was about to merge
>>>> this, but then I realized that this might not be the best way to fix this.
>>>>
>>>> A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
>>>> and at a first glance about half of those are missing an acpi_disabled
>>>> check. IMHO it would be better to simply add an acpi_disabled check to
>>>> acpi_get_devices() itself.
>>>>
>>>> Rafael, do you agree ?
>>>
>>> Yes, I do.
>>
>> Did you see my follow-up that that is not going to work because
>> acpi_get_devices() is an acpica function ?
> 
> No, I didn't, but it is possible to add a wrapper doing the check
> around it and convert all of the users.

Yes I did think about that. Note that I've gone ahead and pushed
the fix which started this to drm-misc-fixes, to resolve the crash
for now.

If we add such a wrapper we can remove a bunch of acpi_disabled checks
from various callers.

> Alternatively, the ACPICA function can check acpi_gbl_root_node
> against NULL, like in the attached (untested) patch.

That is probably an even better idea, as that avoids the need
for a wrapper altogether. So I believe that that is the best
solution.

Regards,

Hans

