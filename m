Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D579F47BA15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhLUGj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhLUGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:39:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04BC061574;
        Mon, 20 Dec 2021 22:39:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k2so19798248lji.4;
        Mon, 20 Dec 2021 22:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=SUQwpbEDG4wooG3TH+qMYo2cWZdsgJDH2qErzH0dtmY=;
        b=WOMvlrDPKMyZMTKlg2iIfE4X3yrfotNQdxzqoMjg2TboVWBAZPoWshDAhNfgqiWjJI
         iWOdNuG+Z8oRVdg9yRMOMn0O9N0NlOa7sYUkeXXtpq2uCGlrGHYmJlGkbICjOXiHzW7Y
         ca388RbWLDss60zyHTJP361FPJzGVU5N4XjMHJnyH545NsD0w3V3EidTKqEs0cFfBu/S
         SVN4AywYFot8+ZE3L9iZ5+a9KRvnymICbAYGeP+FdniWpkcr6yB33/C+29EUNlD4oVRo
         RZ6+CtmEoF1Nbw5N6OwVh+fzk6GiSI/m83jDm9phs4r0lyZlZMP0PWGJm1vgI717KElI
         kwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SUQwpbEDG4wooG3TH+qMYo2cWZdsgJDH2qErzH0dtmY=;
        b=Il1plcZPZuU8HCLbPyCflLX1fBM7PXCxikuzARlfbDhTNFTcdrE0fQc+SYqjcFTOJZ
         XhNjgxMsWm1m+UQVjWw2ISipk4JO1dkzQNk/pHkNpgrw7VC3PJr3xz+1CVeahV9Of0vK
         vursY+I8R939WcuE4Z47bLLspf+GxPwLf2T1+4XRrMtpCE0243B7nqQrxlh2pOoslc8b
         /Z93p2uliYo3q40IXzdJSNGBJbotk2iBcYUd/vyGRtl67cgOAS8rD042hkNPXUyxKLNM
         Mv4C1RKdM5weKZcsvPrWVk423NI2dtDMETonAIWCKq1P2MlxPotG2SuR6kZFbocoTfdH
         hIRA==
X-Gm-Message-State: AOAM530ReVdUctVB+1TNme2gKR0PBLxBxY0kJBBn4pgahSlh8Cg/pOKz
        MT3clDvlUJhPJ9co4PN3Qxg=
X-Google-Smtp-Source: ABdhPJwk4W7p4zSce4OzLtvntoM/tPru8YfRKkWa9nVkDbHqjyakqERf9ueHEXUaoZxM4UcxwXMFvA==
X-Received: by 2002:a2e:8558:: with SMTP id u24mr431468ljj.309.1640068766400;
        Mon, 20 Dec 2021 22:39:26 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w10sm1742603lfu.173.2021.12.20.22.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 22:39:26 -0800 (PST)
Message-ID: <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com>
Date:   Tue, 21 Dec 2021 07:39:24 +0100
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcF1Kizcvgqa9ZT4@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 07:33, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 09:39:43PM +0100, Rafał Miłecki wrote:
>> Hi Greg,
>>
>> On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
>>>>    static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>>>>    {
>>>> +	struct device *dev = &cell->nvmem->dev;
>>>> +	int err;
>>>> +
>>>>    	mutex_lock(&nvmem_mutex);
>>>>    	list_add_tail(&cell->node, &cell->nvmem->cells);
>>>>    	mutex_unlock(&nvmem_mutex);
>>>> +
>>>> +	sysfs_attr_init(&cell->battr.attr);
>>>> +	cell->battr.attr.name = cell->name;
>>>> +	cell->battr.attr.mode = 0400;
>>>> +	cell->battr.read = nvmem_cell_attr_read;
>>>> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
>>>> +					  nvmem_cells_group.name);
>>>
>>> Why not just use the is_bin_visible attribute instead to determine if
>>> the attribute should be shown or not instead of having to add it
>>> after-the-fact which will race with userspace and loose?
>>
>> I'm sorry I really don't see how you suggest to get it done.
>>
>> I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
> 
> Great.
> 
>> I don't understand addig-after-the-fact part. How is .is_bin_visible()
>> related to adding attributes for newly created cells?
> 
> You are adding a sysfs attribute to a device that is already registered
> in the driver core, and so the creation of that attribute is never seen
> by userspace.  The attribute needs to be attached to the device _BEFORE_
> it is registered.
> 
> Also, huge hint, if a driver has to call as sysfs_*() call, something is
> wrong.
> 
>> Do you mean I can
>> avoid calling sysfs_add_bin_file_to_group()?
> 
> Yes.
> 
>> Do you recall any existing example of such solution?
> 
> Loads.
> 
> Just add this attribute group to your driver as a default attribute
> group and the driver core will create it for you if needed.
> 
> Or if you always need it, no need to mess sith is_bin_visible() at all,
> I can't really understand what you are trying to do here at all.

Thanks a lot! In nvmem_register() first there is a call to the
device_register() and only later cells get added. I suppose I just have
to rework nvmem_register() order so that:
1. Cells are collected earlier. For each cell I allocate group attribute
2. device_register() gets called

Thank you for explaining that with patience.
