Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C847C243
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhLUPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhLUPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:09:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59444C061574;
        Tue, 21 Dec 2021 07:09:17 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g26so14208362lfv.11;
        Tue, 21 Dec 2021 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=aBuPIcMMKvPfTIzWMUVVL77O1DubHld9ssFyCw5jYu8=;
        b=HysCNNw0maS7sus33dEpNieOcLYxoFOKfwJoHjCYQ6QuD+fd9A6EpfoCR9mu7EybZg
         xd/uNZBBYxTVHIdC4FkSutPAw9JF0f7fCA1+scoNeiMT4YRum8qYMbCnK+mczp0Qjvvj
         cG5ZBqBW5iMb7YkCB3jdVP5/wK7/yOFXzLdtnzL3EyDDHMq0Pj+6RsWCDDKwgsRLXtby
         Cm6Sp91oKcxiH9dQfg0o7kwfXe/KPQzbDGBV9xY6gpbMTBfErGpCZ5rJAuMkJWiSbhMM
         i4a+9cMO+NP6HD2OSLd3Debbf5IhjwyGrOflntp4e0/S7p6uoEspnDksbB5Uihiriwum
         xgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aBuPIcMMKvPfTIzWMUVVL77O1DubHld9ssFyCw5jYu8=;
        b=4WzEX7swGgNQj36lZtxYI3agNvymk2YUjvBT5FfmDxK1GnI5HTBwuTQHwwp/Zy264y
         Ej3DlbYcMk/mmvBjpNGyXEM6vUDhCya9vCUWt4yC51jFI/XWf6pVvrH/pXuxsq8P2kWd
         mERulGPTFngMwThvIvzNKLKTN8C+Cq9QE7tmgeiSdgR2QfIIXDM3aQhVaRBwzWjvzpxp
         d8Sh1UuYOjdu1IQnKrm/9SX+h2BMqYGq3lYp+S+7KpOLWjqo/dTVZ8iv/XR96WF/Ecr8
         FyeTfbO8UBW1hl3YSRQgsNLcn8U+KK/6YqYdZmnFA0arYrlZJdW1zk/frf2M7pwSDFqE
         Un2A==
X-Gm-Message-State: AOAM5305t93qM/xcXBLF20g1TwhO8vMYbLoA4jBGYE5Lknn0zglgJEsy
        1xkjREUAmMYlR1GxGZxEjas=
X-Google-Smtp-Source: ABdhPJyq7bKyiF4efDc1Q7+vc8t93DDuvJT69u3ckx9R1pde3AcI3pOk/f1GkEMfAZXzQ2LTj9W7pQ==
X-Received: by 2002:a05:6512:c16:: with SMTP id z22mr3417182lfu.329.1640099355583;
        Tue, 21 Dec 2021 07:09:15 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id b29sm465106lfv.187.2021.12.21.07.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:09:15 -0800 (PST)
Message-ID: <76fae18d-f4aa-450d-b8ba-19fda137fe25@gmail.com>
Date:   Tue, 21 Dec 2021 16:09:13 +0100
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
References: <YcF1Kizcvgqa9ZT4@kroah.com>
 <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com> <YcF4E82M89huIbSD@kroah.com>
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com> <YcF+g0ra5tttXOQF@kroah.com>
 <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com> <YcHPGQ0FH0kTzpbq@kroah.com>
 <ab52292c-3065-789b-d5ae-ef24bab5fc90@gmail.com> <YcHWVMa6vjz3Gp51@kroah.com>
 <d626c2c2-5071-522f-330f-688254087d74@gmail.com> <YcHkS0iDUhplbqUc@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcHkS0iDUhplbqUc@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 15:27, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 02:52:05PM +0100, Rafał Miłecki wrote:
>>> How are nvmem devices named?
>>
>> $ ls /sys/bus/nvmem/devices/
>> brcm-nvram0
>> mtd0
>> mtd1
>> u-boot-envvar0
> 
> So no naming scheme at all.
> 
> {sigh}
> 
>>>> Example:
>>>> $ cat /sys/bus/nvmem/devices/foo/cells/bootcmd
>>>> tftp
>>>> $ cat /sys/bus/nvmem/devices/foo/cells/bootdelay
>>>> 5
>>>>
>>>> As you can see above NVMEM cells are not known at compilation time.
>>>
>>> Why do you want to expose these in a way that forces the kernel to parse
>>> these key/value pairs?  Why not just do it all in userspace like you can
>>> today?  What forces the kernel to do it and not a perl script?
>>>
>>>> So I believe the question is: how can I expose cells in sysfs?
>>>
>>> You can do this by dynamically creating the attributes on the fly, but
>>> your show function is going to be rough and it's not going to be simple
>>> to do so.  One example will be the code that creates the
>>> /sys/devices/system/machinecheck/machinecheckXX/bank* files.
>>>
>>> But I will push back again, why not just do it all in userspace?  What
>>> userspace tool is requiring the kernel to do this work for it?
>>
>> Environment data contains info that may be required by kernel.
>>
>> For example some home routers store two firmwares on flash. Kernel needs
>> to read index of currently booted firmware to make sure MTD subsystem
>> creates partitions correctly.
> 
> You are talking about a kernel<->kernel api here, that's not what sysfs
> is for at all.
> 
>> Another example: MAC address. Ethernet subsystem supports reading MAC
>> from NVMEM cell.
> 
> Again, internal kernel api, nothing sysfs is ever involved in.
> 
>> One could argue those tasks could be handled from userspace but that
>> would get tricky. Sure - we have API for setting MAC address. However
>> other cases (like setting active firmware partition and asking MTD to
>> parse it into subpartitions) would require new user <-> kernel
>> interfaces.
> 
> Ok, but again, sysfs is for userspace to get access to these values.
> That's what I'm concerned about.  If you want to make an in-kernel api
> for other subsystems to get these key/value pairs, wonderful, that has
> nothing to do with sysfs.
> 
> So I ask again, why do you want to expose these to userspace through
> sysfs in a new format from what you have today.  Who is going to use
> that information and what is it going to be used for.

Sorry, you asked why I need parsing in kernel and I focused on that part
only.

For user space there are also some relevant U-Boot environment entries
(NVMEM cells). Examples: serial number, country code (e.g. WiFi
purposes), default passwords (as printed on labels).

So both: kernel and user space need to access U-Boot environment
variables (NVMEM cells). Each for its own purposes.

Kernel goes first so it needs its own parser of NVMEM content (data).

User space can either: get NVMEM cells exposed by kernel OR parse NVMEM
content on its own. I thought it'd be nice to avoid parsing code
duplication in user space and let kernel expose NVMEM cells.
