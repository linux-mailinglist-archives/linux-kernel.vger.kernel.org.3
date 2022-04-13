Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA34FF8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiDMOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiDMOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:19:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2036213C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649859433; x=1681395433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mMePPCPwRD0B6CGcAVU9zxObl60Dqj06lOAGekbmlj8=;
  b=AdKD48Jb1g0gV6CmbVq3ZT/smRIDmjeXGaUCn6a6tMPRsVNvk68oY8E0
   qOPGOsqxlM+CK5ZcmKP5ggthT60ZcwgP1XBzqbyzmMRO80WCXt9mchymd
   2xnK1xBcjVZCqBK1VfTZZwQhUuBQ/LAMMb3eaMaT33nqhWPy/T3Wjy+mR
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 07:17:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:17:13 -0700
Received: from [10.110.69.201] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 07:17:09 -0700
Message-ID: <b9c70a58-6d79-3976-c74e-91210cf162f5@quicinc.com>
Date:   Wed, 13 Apr 2022 19:47:02 +0530
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
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
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

It would not be feasible for us to switch to latest kernel and I think, 
this issue could be there in recent kernel as well.

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
> Why do you have object debugging enabled?

We have enabled object debugging to catch more issues around kernel.

>  That's going to take a LONG
> time, and will find bugs in your code.  Perhaps like this one? 
> 
> What type of device is this?  What bus?  What driver?

remoteproc client device driver would call dev_coredumpm() and devcd 
device gets added as part of the call.

> 
> And if you turn object debugging off, what happens?

We have not observed issue after disabling object debugging off.

Regards,
Mukesh

> 
> thanks,
> 
> greg k-h
