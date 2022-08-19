Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7055996F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiHSIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347457AbiHSIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:10:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF6E5899;
        Fri, 19 Aug 2022 01:10:18 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8Dnn0Ntsz67kgW;
        Fri, 19 Aug 2022 16:05:17 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 10:10:03 +0200
Received: from [10.195.34.98] (10.195.34.98) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 09:10:03 +0100
Message-ID: <dd41c5c3-ee16-821c-afd4-ddda4443bc78@huawei.com>
Date:   Fri, 19 Aug 2022 09:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH PoC 2/3] ACPI: platform: Refactor
 acpi_create_platform_device()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-3-git-send-email-john.garry@huawei.com>
 <CAHp75VdhCovo1uT3oxQAymEO9X+29oDet7LjYkLvpmj+r15Tfg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAHp75VdhCovo1uT3oxQAymEO9X+29oDet7LjYkLvpmj+r15Tfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.98]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 20:41, Andy Shevchenko wrote:
> On Tue, Aug 16, 2022 at 2:33 PM John Garry <john.garry@huawei.com> wrote:
>>
>> There is commonality between acpi_create_platform_device() and
>> hisi_lpc_acpi_add_child(), in that it covers 2x main steps:
>> - Read resources for the acpi_device
>> - Create platform device
>>
>> Refactor acpi_create_platform_device() so that it may be reused by
>> hisi_lpc_acpi_add_child() to reduce duplication.
> 
> ...
> 
>> + * acpi_create_platform_device_ops - Create platform device for ACPI device node
> 
> Not sure I understand why _ops is a suffix for the function. I would
> expect _ops to be a data struct where the ->xlate() and perhaps other
> callbacks may be collected. It may be that I have missed that portion
> in the previous discussion.

ok, maybe I can put all the members into a struct, but I don't think 
that it improves the overall code too much.

> 
> ...
> 
>> +       if (name)
>> +               pdevinfo.name = name;
>> +       else
>> +               pdevinfo.name = dev_name(&adev->dev);
> 
>> +       pdevinfo.data = data;
>> +       pdevinfo.size_data = size_data;
> 
> It rather reminds me of platform device registration full with this
> device info. May be what you need is
> struct acpi_platfrom_device_info {
>    properties;
>    name;
>    id;
>    ->xlate();
>    ...
> };
> 
> ?
> 
> ...
> 
>> +struct platform_device *acpi_create_platform_device_ops(
>> +                               struct acpi_device *adev,
>> +                               const char *name,
>> +                               const struct property_entry *properties,
>> +                               void *data, size_t size_data,
>> +                               int (*xlat)(struct acpi_device *adev,
>> +                                           struct resource *res,
>> +                                           void *data, size_t size_data),
>> +                               int id);
> 
> ...because this looks  a bit too much from the amount of parameters
> point of view.
> 

ok, agreed.

But even if we improve this code, the hisi_lpc changes are quite large 
and unwieldly.

Thanks,
John
