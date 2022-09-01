Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC55A9515
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiIAKwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiIAKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:52:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE198130ABB;
        Thu,  1 Sep 2022 03:52:29 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHpH5261z688nt;
        Thu,  1 Sep 2022 18:48:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:52:26 +0200
Received: from [10.48.151.166] (10.48.151.166) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 11:52:26 +0100
Message-ID: <12aedee1-9f13-266c-c398-2ec3d31212d1@huawei.com>
Date:   Thu, 1 Sep 2022 11:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH PoC 2/3] ACPI: platform: Refactor
 acpi_create_platform_device()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-3-git-send-email-john.garry@huawei.com>
 <CAHp75VdhCovo1uT3oxQAymEO9X+29oDet7LjYkLvpmj+r15Tfg@mail.gmail.com>
 <dd41c5c3-ee16-821c-afd4-ddda4443bc78@huawei.com>
 <CAJZ5v0gR0mZBGiCLR6mxdbaNGebti54M-VvV=jT0310KioPD7g@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAJZ5v0gR0mZBGiCLR6mxdbaNGebti54M-VvV=jT0310KioPD7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.151.166]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On 23/08/2022 17:42, Rafael J. Wysocki wrote:
>>>
>>>> +struct platform_device *acpi_create_platform_device_ops(
>>>> +                               struct acpi_device *adev,
>>>> +                               const char *name,
>>>> +                               const struct property_entry *properties,
>>>> +                               void *data, size_t size_data,
>>>> +                               int (*xlat)(struct acpi_device *adev,
>>>> +                                           struct resource *res,
>>>> +                                           void *data, size_t size_data),
>>>> +                               int id);
>>> ...because this looks  a bit too much from the amount of parameters
>>> point of view.
>>>
>> ok, agreed.

Hi Rafael,

 >>
 >> But even if we improve this code, the hisi_lpc changes are quite large
 >> and unwieldly.
 > Well, they allow you to drop quite a few LOC ...

Sure, but the ACPI platform device code here is growing by about the 
same amount :) However maybe we can reduce that with Andy's idea to 
create a struct of function args. But first I will go with using 
platform_device_register_full() in hisi_lpc.

And you please also check the PNP patch? I am not so keen on pushing for 
that.

thanks,
John
