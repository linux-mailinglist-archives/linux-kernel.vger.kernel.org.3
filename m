Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D7561B75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiF3NhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3NhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:37:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBD29826;
        Thu, 30 Jun 2022 06:37:15 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYfVw1j3Xz687ZT;
        Thu, 30 Jun 2022 21:36:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:37:12 +0200
Received: from [10.126.174.156] (10.126.174.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 14:37:12 +0100
Message-ID: <7aad2916-1774-76c5-339a-bbcac4655642@huawei.com>
Date:   Thu, 30 Jun 2022 14:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] hisi_lpc: Use acpi_dev_for_each_child()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <CAJZ5v0jNOsAXSuX9dw9N3w12Y_nq62Z=OL4QQTwH=OnReGpQvA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAJZ5v0jNOsAXSuX9dw9N3w12Y_nq62Z=OL4QQTwH=OnReGpQvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.156]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
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

On 30/06/2022 13:48, Rafael J. Wysocki wrote:
> On Wed, Jun 29, 2022 at 3:47 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Instead of walking the list of children of an ACPI device directly,
>> use acpi_dev_for_each_child() to carry out an action for all of
>> the given ACPI device's children.
>>
>> This will help to eliminate the children list head from struct
>> acpi_device as it is redundant and it is used in questionable ways
>> in some places (in particular, locking is needed for walking the
>> list pointed to it safely, but it is often missing).
> 
> I've overlooked another usage of the children list in hisi_lpc, in
> hisi_lpc_acpi_probe(), and eliminating that one is a bit more
> complicated.
> 
> So please scratch this one and I will send a v3 when 0-day tells me
> that it builds.

Hi Rafael,

If it makes things simpler then I can just fix the driver so that we 
can't unload it. Let me know if that suits better.

Cheers

> 
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: John Garry <john.garry@huawei.com>
>> ---
>>
>> -> v2:
>>     * Drop unused local variable (John).
>>     * Add ACK from John.
>>
>> ---
>>   drivers/bus/hisi_lpc.c |   14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> Index: linux-pm/drivers/bus/hisi_lpc.c
>> ===================================================================
>> --- linux-pm.orig/drivers/bus/hisi_lpc.c
>> +++ linux-pm/drivers/bus/hisi_lpc.c
>> @@ -471,6 +471,12 @@ static int hisi_lpc_acpi_remove_subdev(s
>>          return 0;
>>   }
>>
>> +static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_used)
>> +{
>> +       acpi_device_clear_enumerated(adev);
>> +       return 0;
>> +}
>> +
>>   struct hisi_lpc_acpi_cell {
>>          const char *hid;
>>          const char *name;
>> @@ -480,13 +486,9 @@ struct hisi_lpc_acpi_cell {
>>
>>   static void hisi_lpc_acpi_remove(struct device *hostdev)
>>   {
>> -       struct acpi_device *adev = ACPI_COMPANION(hostdev);
>> -       struct acpi_device *child;
>> -
>>          device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
>> -
>> -       list_for_each_entry(child, &adev->children, node)
>> -               acpi_device_clear_enumerated(child);
>> +       acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
>> +                               hisi_lpc_acpi_clear_enumerated, NULL);
>>   }
>>
>>   /*
>>
>>
>>
> .

