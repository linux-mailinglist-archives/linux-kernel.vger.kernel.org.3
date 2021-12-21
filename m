Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4447C06D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhLUNFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:05:38 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C6C061574;
        Tue, 21 Dec 2021 05:05:38 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i63so21290954lji.3;
        Tue, 21 Dec 2021 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=mkY+dq8pAMD5bwPjWG+1bTxgsgAtHVCA9GmAQlytHYM=;
        b=jaoJczIjcH0/6Vj/Jz33CR9VE9bGRC8ivi1F8EmgzBrIYU/avGMtPePI6f8S6E3DeX
         M3Hru6os5bwAvJxrzIaRZpOe+KZbs4+HIAQnZflMjLNuOBzeaCn9wv1RQPWHB/x8hUp8
         SMZdxDsm+K3OwIWb1U0XddS030NVgA+olHOVGOVpidknUVfvd84KjLBuMv8OW5Var2KE
         DDBKQLDyR/JUg5ZO8H/+QuUHBp1+hQnBrk5g/IWqrdEZ3ugKmoT0gfpaoTF/QKn/0fKs
         cbQldJrUnYxCAXacTNiDYoZlXZiQR6Vn1uX9qLEs7iglTGv3yO9dsePoBlq9CcaNAgWl
         rr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mkY+dq8pAMD5bwPjWG+1bTxgsgAtHVCA9GmAQlytHYM=;
        b=EbdQAHk6eueFXlTlPLY5hS3sglmiNaPINBJJBoO9AsSQ2EGmj9fQIuRCEvooprwHCS
         7HiLsBTTpVK9WiWCbIpJg89jsQP4HAhSnUFIuK6vC9ZdkKhNizc+UE0QK499hbz5oEmi
         Gmj0G7DOO3/XhgvNbYz5cEIQpBzESPQJokjOrFfw/l+AokXXLgRg1EGoKh6cGUy4K6U1
         qQsaFiAodDH832KNfdoekF35k+ozSHXVunp18SOwfdDh2ZdylhiixzcuoOmz7qwR5HYK
         WBTPtOgeeT5RvsIXQA7nJVMBSS6c9lhdVWn/tjdVN9q9PNa4trz5CC4wMW/8t7SU0IMr
         3YXA==
X-Gm-Message-State: AOAM531IppxCn6zYJe9GnKumuS4VUl+rNNXY+pyWgT2G1Iw49rigXMfU
        PlHWa/1fT0uq13uh3WMSUkU=
X-Google-Smtp-Source: ABdhPJwiKtDnlqTAhoBFk1jKcZs80WmN9yW4ZinyhYmELbjinDnxiXQlO4+dUT+V7K54lGfLgGaN7Q==
X-Received: by 2002:a05:651c:1791:: with SMTP id bn17mr2471547ljb.181.1640091936260;
        Tue, 21 Dec 2021 05:05:36 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id v2sm2729097ljg.46.2021.12.21.05.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:05:36 -0800 (PST)
Message-ID: <ab52292c-3065-789b-d5ae-ef24bab5fc90@gmail.com>
Date:   Tue, 21 Dec 2021 14:05:34 +0100
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
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com> <YcF+g0ra5tttXOQF@kroah.com>
 <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com> <YcHPGQ0FH0kTzpbq@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcHPGQ0FH0kTzpbq@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 13:56, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 01:24:00PM +0100, Rafał Miłecki wrote:
>> On 21.12.2021 08:13, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 21, 2021 at 07:53:32AM +0100, Rafał Miłecki wrote:
>>>> On 21.12.2021 07:45, Greg Kroah-Hartman wrote:
>>>>> On Tue, Dec 21, 2021 at 07:39:24AM +0100, Rafał Miłecki wrote:
>>>>>> On 21.12.2021 07:33, Greg Kroah-Hartman wrote:
>>>>>>> On Mon, Dec 20, 2021 at 09:39:43PM +0100, Rafał Miłecki wrote:
>>>>>>>> Hi Greg,
>>>>>>>>
>>>>>>>> On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
>>>>>>>>> On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
>>>>>>>>>>       static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>>>>>>>>>>       {
>>>>>>>>>> +	struct device *dev = &cell->nvmem->dev;
>>>>>>>>>> +	int err;
>>>>>>>>>> +
>>>>>>>>>>       	mutex_lock(&nvmem_mutex);
>>>>>>>>>>       	list_add_tail(&cell->node, &cell->nvmem->cells);
>>>>>>>>>>       	mutex_unlock(&nvmem_mutex);
>>>>>>>>>> +
>>>>>>>>>> +	sysfs_attr_init(&cell->battr.attr);
>>>>>>>>>> +	cell->battr.attr.name = cell->name;
>>>>>>>>>> +	cell->battr.attr.mode = 0400;
>>>>>>>>>> +	cell->battr.read = nvmem_cell_attr_read;
>>>>>>>>>> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
>>>>>>>>>> +					  nvmem_cells_group.name);
>>>>>>>>>
>>>>>>>>> Why not just use the is_bin_visible attribute instead to determine if
>>>>>>>>> the attribute should be shown or not instead of having to add it
>>>>>>>>> after-the-fact which will race with userspace and loose?
>>>>>>>>
>>>>>>>> I'm sorry I really don't see how you suggest to get it done.
>>>>>>>>
>>>>>>>> I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
>>>>>>>
>>>>>>> Great.
>>>>>>>
>>>>>>>> I don't understand addig-after-the-fact part. How is .is_bin_visible()
>>>>>>>> related to adding attributes for newly created cells?
>>>>>>>
>>>>>>> You are adding a sysfs attribute to a device that is already registered
>>>>>>> in the driver core, and so the creation of that attribute is never seen
>>>>>>> by userspace.  The attribute needs to be attached to the device _BEFORE_
>>>>>>> it is registered.
>>>>>>>
>>>>>>> Also, huge hint, if a driver has to call as sysfs_*() call, something is
>>>>>>> wrong.
>>>>>>>
>>>>>>>> Do you mean I can
>>>>>>>> avoid calling sysfs_add_bin_file_to_group()?
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>> Do you recall any existing example of such solution?
>>>>>>>
>>>>>>> Loads.
>>>>>>>
>>>>>>> Just add this attribute group to your driver as a default attribute
>>>>>>> group and the driver core will create it for you if needed.
>>>>>>>
>>>>>>> Or if you always need it, no need to mess sith is_bin_visible() at all,
>>>>>>> I can't really understand what you are trying to do here at all.
>>>>>>
>>>>>> Thanks a lot! In nvmem_register() first there is a call to the
>>>>>> device_register() and only later cells get added. I suppose I just have
>>>>>> to rework nvmem_register() order so that:
>>>>>> 1. Cells are collected earlier. For each cell I allocate group attribute
>>>>>
>>>>> No, add all of the attributes to the device at the beginning before you
>>>>> register it, there's no need to allocate anything.
>>>>
>>>> If you mean static structures I can't do that, because cells almost
>>>> never are static. They are not known in advance. nvmem allows cells to
>>>> be:
>>>> 1. Specified in OF
>>>> 2. Submitted as list while registering a NVMEM device
>>>>
>>>> So every cells gets its own structure allocated dynamically. My plan is
>>>> to put bin_attribute in that struct and then create a group collecting
>>>> all those cells.
>>>
>>> A device has a driver associated with it, and that driver has default
>>> groups associated with it.  Use that, I am not saying to use static
>>> structures, that is not how the driver model works at all.
>>
>> I'm helpless on dealing with attributes.
>>
>> I tried building a list of attributes dynamically but that of course
>> fails:
>>
>> drivers/nvmem/core.c: In function ‘nvmem_register’:
>> drivers/nvmem/core.c:930:31: error: assignment of member ‘bin_attrs’ in read-only object
>>    930 |   nvmem_cells_group.bin_attrs = nvmem->cells_bin_attrs;
>>        |                               ^
>>
>>
>> What I'm trying to achieve is having
>> /sys/bus/nvmem/devices/*/cells/*
>> with each file being an attribute.
> 
> What is the full path here that you are looking to add these attributes
> to?  Where is the struct device in play?  What .c file should I look at?
> 
>> Please kindly point me to a single example of "struct attribute_group"
>> that has a variable list of attributes with each attribute having
>> runtime set name.
> 
> Why would you ever want each attribute have a runtime-set name?  That's
> not what attributes are for.  Think of them as "key/value" pairs.  The
> "key" part is the name (i.e. filename), that is well known to everyone,
> unique to that struct device type, and documented in Documentation/ABI/.
> The "value" part is the value you read from the file (or write to it.)
> 
> That's it, it's not all that complex.
> 
>> Almost all cases in kernel look like:
>> static const struct attribute_group foo_attr_group = {
>> 	.attrs = foo_attrs,
>> };
>> with "foo_attrs" being a list of attributes with *predefined* names.
> 
> Yes, because that is what you really want.
> 
> Why do you feel this device is somehow unique to deserve attributes that
> are not predefined?  And if they are not predefined, how are you going
> to define them when you create them in the code and document them?   :)
> 
>> Every example of dynamic attributes (runtime created) I see in a kernel
>> (e.g. drivers/base/node.c) uses sysfs_*().
> 
> drivers/base/* is not the best place to look at for how to implement
> bus/driver logic, look at existing busses and drivers instead please.
> We have a few hundred to choose from :)
> 
> So, let's break it down, what exactly are you wanting your device on
> your bus to look like?  What will be the attributes you want to expose,
> and what are the values of those attributes?  You have to start with
> that, as Documentation/ABI/ is going to require you to write them down.

This patch subject / body is a basic summary. It's about
drivers/nvmem/core.c .


Let me explain it with more details:

NVMEM is a data blob.
NVMEM consists of entries called cells.


Example:

U-Boot environment variables is NVMEM. Example:
00000000  c4 09 30 54 62 6f 6f 74  63 6d 64 3d 74 66 74 70  |..0Tbootcmd=tftp|
00000010  00 62 6f 6f 74 64 65 6c  61 79 3d 35 00 65 74 68  |.bootdelay=5.eth|

A single environment variable is NVMEM cell. Example:
bootcmd=tftp
bootdelay=5


Every NVMEM device is exposed in sysfs as:
/sys/bus/nvmem/devices/*/

You can read NVMEM blob doing
cat /sys/bus/nvmem/devices/*/nvmem | hexdump -C


What I'm trying to do is to expose NVMEM cells in sysfs as:
/sys/bus/nvmem/devices/cells/*

Example:
$ cat /sys/bus/nvmem/devices/foo/cells/bootcmd
tftp
$ cat /sys/bus/nvmem/devices/foo/cells/bootdelay
5

As you can see above NVMEM cells are not known at compilation time.


So I believe the question is: how can I expose cells in sysfs?
