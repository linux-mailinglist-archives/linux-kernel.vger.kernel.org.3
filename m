Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20E47BA52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhLUGxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhLUGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:53:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8941C061574;
        Mon, 20 Dec 2021 22:53:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i31so11876201lfv.10;
        Mon, 20 Dec 2021 22:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=cO0AZX2AEbC41+edQsP4DX2F8uJPdb36kh+HVoQalZE=;
        b=B3KHBherlNOq/A8c7BdmSANYuvQHvEZ/rVrJLdVtJQF/2PemkEijvp7hIZLg5lz4s1
         uVW+Z127CSvN41CDNktbHzj9WesU0vPzdvFMzgq9ewcF4Cp9UWBC3vHeJihvP2hraCNh
         ElxygrZdovUoH5xId6wzs8TKr5s/LVIsA8IK+jZqmSRj0H4ewS+RxttrrTq1cntjxYGb
         21Hy6USiB28ZaBj4q2gmXqlQvGJcEUNaj8jmuNJ3ssP8jMWxKC1Lk2jxHWMI/ArCpOdP
         hoFMHH887tXxUNYMJDVCDW/Iyr91ouxTS61JTtnoD6tSAPvHdXGGHnPC8ZrzG97TPrIA
         h3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cO0AZX2AEbC41+edQsP4DX2F8uJPdb36kh+HVoQalZE=;
        b=31/teKIgDvRDQfsxOPxvSll3OrQaFz8r+8aYVjcEsX688C62GDQtehR0C4yMN4IsPP
         06l6LeGglY76KFb/BHLXA7P4onoD9EEmv8wZJZCc+M00byD38rkZ+FDGMRbGVG1LbBFG
         mdpvZWaO/9vPqvie1p/Pji1ZJAhms8w+zpRV4ysxFK34Zwl86+pr/q3+2yg+1uQ2doch
         7omh5kutgD1NGHvyqMRQnqQTsLqFb2eZaZCMTFCeYKtv15JpA+WNjW7sLqlER0c8ABLd
         +YEVHNfLGQ9fpR6+Uo2K136bXkr/CGszz7TBiqBzKNC91uelz53ZaGfsI5Ptgq1KyRvv
         zdig==
X-Gm-Message-State: AOAM53047/e/65V4b7ODeTybpgOsdJsJxbOm2eX6OC7BaRhCf6KZeFeL
        jyJQ08Agz5nlw4ZV5unlvz0=
X-Google-Smtp-Source: ABdhPJxc1OG1bhSK+QmgLyelQDIXejld1MHXT7hCZK1AO2ZX/zL0dpRRhBmZ+DmW62seSjbgzmVlOw==
X-Received: by 2002:a19:380e:: with SMTP id f14mr1940987lfa.612.1640069614230;
        Mon, 20 Dec 2021 22:53:34 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id d3sm2661444ljl.93.2021.12.20.22.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 22:53:34 -0800 (PST)
Message-ID: <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com>
Date:   Tue, 21 Dec 2021 07:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211220064730.28806-1-zajec5@gmail.com>
 <20211220064730.28806-2-zajec5@gmail.com> <YcA4ArALDTjUedrb@kroah.com>
 <c49f2d6d-7974-5bc7-9bc1-ac265a23c2c0@gmail.com> <YcF1Kizcvgqa9ZT4@kroah.com>
 <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com> <YcF4E82M89huIbSD@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcF4E82M89huIbSD@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 07:45, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 07:39:24AM +0100, Rafał Miłecki wrote:
>> On 21.12.2021 07:33, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 20, 2021 at 09:39:43PM +0100, Rafał Miłecki wrote:
>>>> Hi Greg,
>>>>
>>>> On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
>>>>> On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
>>>>>>     static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>>>>>>     {
>>>>>> +	struct device *dev = &cell->nvmem->dev;
>>>>>> +	int err;
>>>>>> +
>>>>>>     	mutex_lock(&nvmem_mutex);
>>>>>>     	list_add_tail(&cell->node, &cell->nvmem->cells);
>>>>>>     	mutex_unlock(&nvmem_mutex);
>>>>>> +
>>>>>> +	sysfs_attr_init(&cell->battr.attr);
>>>>>> +	cell->battr.attr.name = cell->name;
>>>>>> +	cell->battr.attr.mode = 0400;
>>>>>> +	cell->battr.read = nvmem_cell_attr_read;
>>>>>> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
>>>>>> +					  nvmem_cells_group.name);
>>>>>
>>>>> Why not just use the is_bin_visible attribute instead to determine if
>>>>> the attribute should be shown or not instead of having to add it
>>>>> after-the-fact which will race with userspace and loose?
>>>>
>>>> I'm sorry I really don't see how you suggest to get it done.
>>>>
>>>> I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
>>>
>>> Great.
>>>
>>>> I don't understand addig-after-the-fact part. How is .is_bin_visible()
>>>> related to adding attributes for newly created cells?
>>>
>>> You are adding a sysfs attribute to a device that is already registered
>>> in the driver core, and so the creation of that attribute is never seen
>>> by userspace.  The attribute needs to be attached to the device _BEFORE_
>>> it is registered.
>>>
>>> Also, huge hint, if a driver has to call as sysfs_*() call, something is
>>> wrong.
>>>
>>>> Do you mean I can
>>>> avoid calling sysfs_add_bin_file_to_group()?
>>>
>>> Yes.
>>>
>>>> Do you recall any existing example of such solution?
>>>
>>> Loads.
>>>
>>> Just add this attribute group to your driver as a default attribute
>>> group and the driver core will create it for you if needed.
>>>
>>> Or if you always need it, no need to mess sith is_bin_visible() at all,
>>> I can't really understand what you are trying to do here at all.
>>
>> Thanks a lot! In nvmem_register() first there is a call to the
>> device_register() and only later cells get added. I suppose I just have
>> to rework nvmem_register() order so that:
>> 1. Cells are collected earlier. For each cell I allocate group attribute
> 
> No, add all of the attributes to the device at the beginning before you
> register it, there's no need to allocate anything.

If you mean static structures I can't do that, because cells almost
never are static. They are not known in advance. nvmem allows cells to
be:
1. Specified in OF
2. Submitted as list while registering a NVMEM device

So every cells gets its own structure allocated dynamically. My plan is
to put bin_attribute in that struct and then create a group collecting
all those cells.


>> 2. device_register() gets called
> 
> Yes.

