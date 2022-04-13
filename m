Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9904FF59F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiDMLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDMLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:23:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471440932
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649848888; x=1681384888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+zJAD1HKa77om0AhT1FzlltJbJCVIeuCwXk//SW2wqk=;
  b=oQ0HkKu7/5TWTcV06N982jV7odDoBLzmkrn3nEtBa6BvqM0xvE9N2wIk
   37+ytwBePwO/PLkzEKfW68di5STXU3OuVpPHutRZov6YdlOvo5qkRWN1B
   80kK2u6Ky7N82KozWXWeUKVZkV6/V5mpwlNk2hYWPXr4qvOVAg4zSXqNE
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 04:21:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:21:28 -0700
Received: from [10.110.69.201] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 04:21:24 -0700
Message-ID: <57a04278-0a60-cc7d-7ce8-a75c2befd568@quicinc.com>
Date:   Wed, 13 Apr 2022 16:51:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <johannes@sipsolutions.net>,
        <rafael@kernel.org>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
 <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
 <Ylas6F75Y7O6R87U@kroah.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <Ylas6F75Y7O6R87U@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 4:28 PM, Greg KH wrote:
> On Wed, Apr 13, 2022 at 03:46:39PM +0530, Mukesh Ojha wrote:
>> On Wed, Apr 13, 2022 at 07:34:24AM +0200, Greg KH wrote:
>>> On Wed, Apr 13, 2022 at 10:59:22AM +0530, Mukesh Ojha wrote:
>>>> Hi All,
>>>>
>>>> We are hitting one race due to which try_to_grab_pending() is stuck .
>>>
>>> What kernel version are you using?
>>
>> 5.10
> 
> 5.10.0 was released a very long time ago.  Please use a more modern
> kernel release :)
> 
>> Sorry, for the formatting mess.
>>
>>>> In following scenario, while running (p1)dev_coredumpm() devcd device is
>>>> added to
>>>> the framework and uevent notification sent to userspace that result in the
>>>> call to (p2) devcd_data_write()
>>>> which eventually try to delete the queued timer which in the racy scenario
>>>> timer is not queued yet.
>>>> So, debug object report some warning and in the meantime timer is
>>>> initialized and queued from p1 path.
>>>> and from p2 path it gets overriden again timer->entry.pprev=NULL and
>>>> try_to_grab_pending() stuck
>> 	p1 					p2(X)
>>
>>     dev_coredump() uevent sent to userspace
>>     device_add()  =========================> userspace process X reads the uevents
>>                                              writes to devcd fd which
>>                                              results into writes to
>>
>>                                              devcd_data_write()
>> 					      mod_delayed_work()
>>                                                  try_to_grab_pending()
>> 						  del_timer()
>> 						   debug_assert_init()
>>    INIT_DELAYED_WORK
>>    schedule_delayed_work
>> 						    debug_object_fixup()
> 
> Why do you have object debugging enabled?  That's going to take a LONG
> time, and will find bugs in your code.  Perhaps like this one?
> There is no issue if we disable debug object.
Here, some client module try to collect dump
via dev_coredumpm() which creates devcdX device and
expects userspace to read this data. Here, it might be
exposing a synchronization issue between dev_coredumpm()
and  devcd_data_write() perhaps, a mutex ??

================o<===============================

  11
  12 diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
  13 index 9243468..a620dcb 100644
  14 --- a/drivers/base/devcoredump.c
  15 +++ b/drivers/base/devcoredump.c
  16 @@ -29,6 +29,7 @@ struct devcd_entry {
  17         struct device devcd_dev;
  18         void *data;
  19         size_t datalen;
  20 +       struct mutex mutex;
  21         struct module *owner;
  22         ssize_t (*read)(char *buffer, loff_t offset, size_t count,
  23                         void *data, size_t datalen);
  24 @@ -88,7 +89,9 @@ static ssize_t devcd_data_write(struct file 
*filp, struct kobject *kobj,
  25         struct device *dev = kobj_to_dev(kobj);
  26         struct devcd_entry *devcd = dev_to_devcd(dev);
  27
  28 +       mutex_lock(&devcd->mutex);
  29         mod_delayed_work(system_wq, &devcd->del_wk, 0);
  30 +       mutex_unlock(&devcd->mutex);
  31
  32         return count;
  33  }
  34 @@ -282,13 +285,14 @@ void dev_coredumpm(struct device *dev, struct 
module *owner,
  35         devcd->read = read;
  36         devcd->free = free;
  37         devcd->failing_dev = get_device(dev);
  38 -
  39 +       mutex_init(&devcd->mutex);
  40         device_initialize(&devcd->devcd_dev);
  41
  42         dev_set_name(&devcd->devcd_dev, "devcd%d",
  43                      atomic_inc_return(&devcd_count));
  44         devcd->devcd_dev.class = &devcd_class;
  45
  46 +       mutex_lock(&devcd->mutex);
  47         if (device_add(&devcd->devcd_dev))
  48                 goto put_device;
  49
  50 @@ -302,10 +306,11 @@ void dev_coredumpm(struct device *dev, struct 
module *owner,
  51
  52         INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
  53         schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
  54 -
  55 +       mutex_unlock(&devcd->mutex);


Thanks,
-Mukesh

> What type of device is this?  What bus?  What driver?
> 
> And if you turn object debugging off, what happens?
> 
> thanks,
> 
> greg k-h
