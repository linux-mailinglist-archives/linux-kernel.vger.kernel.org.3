Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C241C4B33D4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiBLIeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:34:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiBLIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:34:00 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE91212;
        Sat, 12 Feb 2022 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644654837; x=1676190837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmiueAkY/np8phTT6QzUC4DsJH0cEhvOy4i26Lo9XNw=;
  b=oArrRJCylCh0mkM8AQdyMKXUbPL41MeiDtCCnIoMEeICaSMm+uZuL18+
   5mizBCAjcjd/w6nSmb/XmHPjpB26939GRVizO2+qhFcGR/RIeLQbGPEGs
   anMC1KMQWDf3iHBbhF9dvT0w6Qk1dTwBdK3GJaZJNa5MvkY4TMj4anKqu
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Feb 2022 00:33:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 00:33:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 12 Feb 2022 00:33:56 -0800
Received: from [10.38.246.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sat, 12 Feb
 2022 00:33:53 -0800
Message-ID: <588fbad9-6f50-5d85-9a33-c1206f5815a6@quicinc.com>
Date:   Sat, 12 Feb 2022 00:33:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <johannes@sipsolutions.net>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <nganji@codeaurora.org>,
        <aravindh@codeaurora.org>, <khsieh@codeaurora.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com>
 <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
 <Ygdb63FrorUsX/Hg@kroah.com>
 <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
 <Ygdv7wc6v90L7xSp@kroah.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <Ygdv7wc6v90L7xSp@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 2/12/2022 12:29 AM, Greg KH wrote:
> On Fri, Feb 11, 2022 at 11:52:41PM -0800, Abhinav Kumar wrote:
>> Hi Greg
>>
>> On 2/11/2022 11:04 PM, Greg KH wrote:
>>> On Fri, Feb 11, 2022 at 10:59:39AM -0800, Abhinav Kumar wrote:
>>>> Hi Greg
>>>>
>>>> Thanks for the response.
>>>>
>>>> On 2/11/2022 3:09 AM, Greg KH wrote:
>>>>> On Tue, Feb 08, 2022 at 11:44:32AM -0800, Abhinav Kumar wrote:
>>>>>> There are cases where depending on the size of the devcoredump and the speed
>>>>>> at which the usermode reads the dump, it can take longer than the current 5 mins
>>>>>> timeout.
>>>>>>
>>>>>> This can lead to incomplete dumps as the device is deleted once the timeout expires.
>>>>>>
>>>>>> One example is below where it took 6 mins for the devcoredump to be completely read.
>>>>>>
>>>>>> 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
>>>>>> 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node
>>>>>
>>>>> What makes this so slow?  Reading from the kernel shouldn't be the
>>>>> limit, is it where the data is being sent to?
>>>>
>>>> We are still checking this. We are seeing better read times when we bump up
>>>> the thread priority of the thread which was reading this.
>>>
>>> Where is the thread sending the data to?
>>
>> The thread is writing the data to a file in local storage. From our
>> profiling, the read is the one taking the time not the write.
> 
> The read is coming directly from memory, there should not be any
> slowdown at all here.  How can that be the delay?  Have a trace
> somewhere?
> 
> thanks,
> 
> greg k-h

Yes, like I mentioned in my previous comment we are still checking why 
its taking so long. We will update with our findings if we have any.
Alright, we will try to capture trace to share and will update this 
thread if we find something as well.
