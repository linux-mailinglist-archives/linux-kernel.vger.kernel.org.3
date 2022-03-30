Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D14EC501
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbiC3M52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiC3M5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:57:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2611CD7C9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648644940; x=1680180940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+RV+8IvkgU5Zgk9R696CSA2K8PaMwfOqWUxiCbDj+2o=;
  b=NeYNyHZhBzDNH39Ga4bpt9AfAIkpvJUTv4EJoVYMk2jZnh6sU8EI9NAh
   SIL/ut1YNsxNkZkUHOGx4XURgnSknjpJ2kRUJ1ICb875hoyksxb+ANtsC
   mXkNXuavWvLFDWUmWi25FCnWNfEq8xOX5mt8/aVEKTa+ezZBLliDPozlo
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2022 05:55:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 05:55:39 -0700
Received: from [10.110.1.142] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 05:55:35 -0700
Message-ID: <f263cb55-2d6d-2d89-c868-52ac0c8f8640@quicinc.com>
Date:   Wed, 30 Mar 2022 18:25:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Possible case of Race in kobject_get_path()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <0410ceda-cbdd-43a9-7d9b-4079bcdb6237@quicinc.com>
 <YkQuFohIp2jSLCcz@kroah.com>
 <148f4e9b-0584-ccc1-1443-30d41190dfd3@quicinc.com>
 <YkQ4iz3iZ0cM+FS2@kroah.com>
 <eda6c7c9-558a-cf3f-1aa4-79988bbbac24@quicinc.com>
 <YkQ8teUQbNudfEGN@kroah.com>
 <79640fdc-688f-f545-0ec7-0988d180ba58@quicinc.com>
 <YkQ/kwQofkGTZ7fX@kroah.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <YkQ/kwQofkGTZ7fX@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2022 5:01 PM, Greg KH wrote:
> On Wed, Mar 30, 2022 at 04:53:41PM +0530, Mukesh Ojha wrote:
>> On 3/30/2022 4:49 PM, Greg KH wrote:
>>> On Wed, Mar 30, 2022 at 04:44:26PM +0530, Mukesh Ojha wrote:
>>>> On 3/30/2022 4:31 PM, Greg KH wrote:
>>>>> On Wed, Mar 30, 2022 at 04:14:11PM +0530, Mukesh Ojha wrote:
>>>>>> On 3/30/2022 3:46 PM, Greg KH wrote:
>>>>>>> On Wed, Mar 30, 2022 at 03:41:04PM +0530, Mukesh Ojha wrote:
>>>>>>>> Hi All,
>>>>>>>>
>>>>>>>> We are facing one issue where one driver (p1) is trying to register its
>>>>>>>> device from driver probe
>>>>>>>> and from another path (p2) dev_set_name(new name) done from driver probe of
>>>>>>>> the added device whose
>>>>>>>> new name length can be more than earlier done in (p1 path) which could
>>>>>>>> result in redzone overwritten issue.
>>>>>>> I do not understand, what specific driver is doing this so that we can
>>>>>>> see an example of this problem?
>>>>>> trying to paste some logs of the race.
>>>>>>
>>>>>> [ 14.235820][ T503] BUG kmalloc-128 (Tainted: G S O ): Left Redzone
>>>>>> overwritten
>>>>> What kernel version is this?
>>>> 5.10
>>> That is very old, is this an issue in 5.17?
>>>
>>>>>> [ 14.244189][ T503]
>>>>>> -----------------------------------------------------------------------------
>>>>>> [ 14.255241][ T503] INFO: 0xffffff87caae0f7d-0xffffff87caae0f7f
>>>>>> @offset=3965. First byte 0x2f instead of 0xcc
>>>>>> [ 14.265176][ T503] INFO: Allocated in kobject_get_path+0x58/0x100 age=1
>>>>>> cpu=0 pid=503
>>>>>> [ 14.273111][ T503] kobject_get_path+0x58/0x100
>>>>>> [ 14.277747][ T503] kobject_uevent_env+0x120/0x744
>>>>>> [ 14.282639][ T503] device_add+0x98c/0x1028
>>>>>> [ 14.286925][ T503] *device_register+0x24/0x38*
>>>>>> [ 14.291395][ T503] slim_alloc_device+0xdc/0x108 [slimbus]
>>>>>> [ 14.296992][ T503] slim_register_controller+0x210/0x2ac [slimbus]
>>>>>> [ 14.303291][ T503] qcom_slim_ngd_probe+0x3c/0x348 [slim_qcom_ngd_ctrl]
>>>>>> [ 14.310007][ T503] platform_drv_probe+0x60/0x180
>>>>>> [ 14.314812][ T503] really_probe+0x208/0xb64
>>>>>> [ 14.319184][ T503] driver_probe_device+0x130/0x254
>>>>>> [ 14.324159][ T503] __device_attach_driver+0x1e8/0x324
>>>>>> [ 14.329399][ T503] __device_attach+0x170/0x364
>>>>>> [ 14.334035][ T503] bus_probe_device+0x4c/0x164
>>>>>> [ 14.338671][ T503] device_add+0xa60/0x1028
>>>>>> [ 14.342957][ T503] platform_device_add+0x260/0x2c8
>>>>>> [ 14.347941][ T503] qcom_slim_ngd_ctrl_probe+0x71c/0x804
>>>>>> [slim_qcom_ngd_ctrl]
>>>>>> [ 14.355177][ T503] INFO: Freed in kobject_uevent_env+0x210/0x744 age=1
>>>>>> cpu=4 pid=518
>>>>>> [ 14.363018][ T503] do_init_module+0xac/0x494
>>>>>> [ 14.367475][ T503] load_module+0x35c0/0x3e54
>>>>>> [ 14.371930][ T503] __se_sys_finit_module+0x188/0x1c8
>>>>>> [ 14.377086][ T503] __arm64_sys_finit_module+0x20/0x30
>>>>>> [ 14.382328][ T503] el0_svc_common+0xdc/0x294
>>>>>> [ 14.386786][ T503] el0_svc+0x38/0x9c
>>>>>> [ 14.390552][ T503] el0_sync_handler+0x8c/0xf0
>>>>>>
>>>>>>
>>>>>> [ 14.490994*][ T503] Redzone ffffff87caae0f7**0*: cc cc cc cc cc cc cc cc cc
>>>>>> cc cc cc cc 2f 64 65 .............*/de*
>>>>>> [ 14.501185][ T503] Object ffffff87caae0f80: 76 69 63 65 73 2f 70 6c 61 74
>>>>>> 66 6f 72 6d 2f 73 vices/platform/s
>>>>>> [ 14.511376][ T503] Object ffffff87caae0f90: 6f 63 2f 33 33 34 30 30 30 30
>>>>>> 2e 73 6c 69 6d 2f oc/3340000.slim/
>>>>>> [ 14.521566][ T503] Object ffffff87caae0fa0: 71 63 6f 6d 2c 73 6c 69 6d 2d
>>>>>> 6e 67 64 2e 31 2f qcom,slim-ngd.1/
>>>>>> [ 14.531757][ T503] Object ffffff87caae0fb0: 62 74 66 6d 73 6c 69 6d 5f 73
>>>>>> 6c 61 76 65 00 00 *btfmslim_slave*..
>>>>>>
>>>>>>
>>>>>>
>>>>>> 499 static int btfm_slim_probe(struct slim_device *slim)
>>>>> I do not see that function in Linus's tree right now.  Where does it
>>>>> come from?
>>>> Don't you think, it can be caused by any kernel module.
>>> Kernel code do not protect themselves against other kernel code doing
>>> abusive things.
>>>
>>> Perhaps fix your out-of-tree code to not do this if no in-kernel code is
>>> doing this?  Nothing we can do at all about out-of-tree code that we
>>> have never seen.
>>
>> Thanks for the comment, Greg.
>> Why do we make dev_set_name() make it available to module apart from the
>> core ?
> Because busses can be in a module, just like you should be doing :)
>
> Please submit your code upstream for review.

I still did not get why one should not do device name change if 
dev_set_name() is available for anyone to do name change while 
kobject_get_path() is running?
This is possible race, if we know this is the limitation/issue and would 
be difficult to address , that is fine and should be documented.

Thanks,
Mukesh

>
> thanks,
>
> greg k-h
