Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C65632FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiGALys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiGALyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:54:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914583F06;
        Fri,  1 Jul 2022 04:54:44 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZD8G6YYHz6H6nM;
        Fri,  1 Jul 2022 19:52:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 13:54:41 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:54:40 +0100
Message-ID: <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com>
Date:   Fri, 1 Jul 2022 12:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher>
 <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
In-Reply-To: <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 12:07, Andy Shevchenko wrote:
> On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
>>> On 30/06/2022 19:13, Rafael J. Wysocki wrote:
>>
>> ...
>>
>>> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
>>> sent a fix today (coincidence?):
>>>
>>> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
>>>
>>> And they conflict. This code has been this way for years, so I just
>>> suggest Yang Yingliang resends the fix on top off Rafael's change.
>>
>> Wondering if Yang can actually switch that to use
>> platform_device_register_full().

Maybe that would work and simplify things. Let me check it.

BTW, when we originally upstreamed this driver there was some ACPI 
platform device registration code which you/we thought could be factored 
out later. I can't remember it. I was looking through lore but couldn't 
find it. I don't remember it being so important, though.

> 
> And for the record, I think the Fixes even for very rare bug hits
> should go first.
> 

ok, I have to admit that I was going to feel awkward asking Rafael to 
deal with this fix by having a v4 on top of it.

Thanks,
John
