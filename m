Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C652447B473
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhLTUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:39:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F4C061574;
        Mon, 20 Dec 2021 12:39:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf39so24379315lfb.8;
        Mon, 20 Dec 2021 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=bL2RPSwTev7LZ8MD6+6G/1KqhR5mqV7Zj15+Emy55dg=;
        b=EyuKTjeucihttgDx7dIgsiOz4kSkmNwhMk8PnvUZ3MTSdfnwBQ+fUnIZQcpmvn/hG0
         x+kwTJspLYDI0+IcsTXou1VN8vSopK4Yx/beWE0gAk8I92Wen1Cvto88/zibC2/A5rlu
         Egh8rVS+s1uqMdgCl8ztnLU32ZDOF+y7nyLlu6HQEi4iJw5m9MMUjQkUas7yqrQ5t3Ub
         wPS+sSF6qZKHtZ6rVUAGAjPYBTlH0ACkcsswZ24TOLpgexcdCbdia6riupW97GjkbLgF
         nQKCdKVaaiYnwO2MA0lKPV+Jz4/OXVVpptXf2VUo9j6AqsytDvWDYTq7WXyeFoiyPC//
         0J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bL2RPSwTev7LZ8MD6+6G/1KqhR5mqV7Zj15+Emy55dg=;
        b=JgaD40d9S1+UfroYvF5UZSnxikqPcwKC8omhMTY5E+cATRv3RRdYrW+gIykvHvw8Vf
         SNdpX8aIlv7tY6i1LM6bwaybrSPdKfwBvpRiwfc1t2qOQ/lFd0PwlMx6gMgTgTtmTFhw
         pxTVL9W0g1EI7cArEJxoBo4rLtQ7tG5x7NFLSJApWUBGK/xPXb6lW41prNq96XJ4qePm
         0z2plqwNYZGID8pfgGwHIGGVS9kcPAbTGB5YxwrKJixKTxOu23Z5dhE9Odv6uKDhpq7p
         H118zPu6kcf2gvY5r+BEm1UZEPbaz4NqlvwhBlgGRdU7LafQLpXw4F1u2+h3ekdQISuA
         XTjw==
X-Gm-Message-State: AOAM530CIpL8s87dMxS6QoTfi3EOLDvQ5GyxlC/bZCRsoD58LNxDhviE
        61uiTOEb0jPcKZwjOkE4LJE=
X-Google-Smtp-Source: ABdhPJwDWwkKIKbmUyP8FNkCmj3HnwG1KJWO0VAuixurmAgWnR4ZSclfaCboao+8pjd7KZQOsQCsRQ==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr17230506lfo.684.1640032788246;
        Mon, 20 Dec 2021 12:39:48 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j10sm608724lfp.286.2021.12.20.12.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:39:47 -0800 (PST)
Message-ID: <c49f2d6d-7974-5bc7-9bc1-ac265a23c2c0@gmail.com>
Date:   Mon, 20 Dec 2021 21:39:43 +0100
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcA4ArALDTjUedrb@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
>>   static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>>   {
>> +	struct device *dev = &cell->nvmem->dev;
>> +	int err;
>> +
>>   	mutex_lock(&nvmem_mutex);
>>   	list_add_tail(&cell->node, &cell->nvmem->cells);
>>   	mutex_unlock(&nvmem_mutex);
>> +
>> +	sysfs_attr_init(&cell->battr.attr);
>> +	cell->battr.attr.name = cell->name;
>> +	cell->battr.attr.mode = 0400;
>> +	cell->battr.read = nvmem_cell_attr_read;
>> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
>> +					  nvmem_cells_group.name);
> 
> Why not just use the is_bin_visible attribute instead to determine if
> the attribute should be shown or not instead of having to add it
> after-the-fact which will race with userspace and loose?

I'm sorry I really don't see how you suggest to get it done.

I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
I don't understand addig-after-the-fact part. How is .is_bin_visible()
related to adding attributes for newly created cells? Do you mean I can
avoid calling sysfs_add_bin_file_to_group()? Do you recall any existing
example of such solution?
