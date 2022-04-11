Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918104FB213
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiDKC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiDKC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:58:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FDD1837A;
        Sun, 10 Apr 2022 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649645758; x=1681181758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o9PyONh5kKN5lsZKeCWL128gzOV0T80G46wNVOCj6Kc=;
  b=vUtW15qM7RYYIquoAnXRe0JwIx61ktSRaOevt01lP5gGLsJ0Y0Vs0ymL
   B/OplSuXDSPXI91bxpaOcLyOGhFCU3rQwIIQHUenWO4S6C0K41YBHt7MM
   PiouepOKb3Zp5TaQGY4xRZugjo0sLAk4ROLhZIiQsrcHDEjcaFPFxQylr
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 19:55:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 19:55:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Apr 2022 19:55:56 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 10 Apr
 2022 19:55:53 -0700
Message-ID: <059d74ef-78c2-57f2-4c14-4b20526c984c@quicinc.com>
Date:   Mon, 11 Apr 2022 10:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
 <YjxjXnXAXVXfZqr/@kroah.com>
 <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
 <7d571b9d-2066-8217-5485-da0e6ace65eb@arm.com>
 <8698dc76-613e-a00d-340b-220c752d9449@quicinc.com>
 <CANLsYkwZxqYMtx-v=OZoZAYshFHW2s_7isUq1UgUV18pVvSB8w@mail.gmail.com>
 <b4d4ca6f-13ae-8050-debe-57e6c8be6254@quicinc.com>
 <ff1931d7-61b4-4362-7e3b-45c64c0211fc@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <ff1931d7-61b4-4362-7e3b-45c64c0211fc@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2022 5:05 PM, Suzuki K Poulose wrote:
> On 30/03/2022 03:10, Jinlong Mao wrote:
>>
>> On 3/29/2022 10:36 PM, Mathieu Poirier wrote:
>>> On Tue, 29 Mar 2022 at 07:56, Jinlong Mao<quic_jinlmao@quicinc.com>  
>>> wrote:
>>>> Hi Suzuki,
>>>>
>>>> On 3/28/2022 4:33 PM, Suzuki K Poulose wrote:
>>>>> On 24/03/2022 14:23, Jinlong Mao wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Thanks for your review.
>>>>>>
>>>>>> On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
>>>>>>>> Use hash length of the source's device name to map to the pointer
>>>>>>>> of the enabled path. Using IDR will be more efficient than using
>>>>>>>> the list. And there could be other sources except STM and CPU etms
>>>>>>>> in the new HWs. It is better to maintain all the paths together.
>>>>>>>>
>>>>>>>> Signed-off-by: Mao Jinlong<quic_jinlmao@quicinc.com>
>>>>>>>> ---
>>>>>>>>    drivers/hwtracing/coresight/coresight-core.c | 75
>>>>>>>> +++++++-------------
>>>>>>>>    1 file changed, 26 insertions(+), 49 deletions(-)
>>>>>>> Your subject line is odd.  Please put back the driver subsystem 
>>>>>>> in the
>>>>>>> subject line so that it makes more sense.
>>>>>> I will update the subject in next version.
>>>>>>> And how have you measured "more efficient"?
>>>>>> Using IDR would be better than doing a sequential search as there
>>>>>> will be much more device  in future.
>>>>> Where do we use sequential search now ? For non-CPU bound sources, 
>>>>> yes
>>>>> we may need something. But CPU case is straight forward, and could be
>>>>> retained as it is. i.e., per-cpu list of paths.
>>>>>
>>>> We use list to store the paths for both ETM and non-CPU bound 
>>>> sources in
>>>> patch below.
>>>>
>>>> “[PATCH 01/10] coresight: add support to enable more coresight paths”
>>>>
>>>> According to Mathieu's comments, IDR is used now.  So i added 
>>>> "Using IDR
>>>> will be more efficient than using
>>>> the list" this message in my commit message. I think we need to use 
>>>> one
>>>> mechanism to store ETM and
>>>> non-CPU bound sources.
>>>>
>>>>
>>>> Mathieu's comments:
>>>>
>>>> So many TPDM and many ETMs...  That is definitely a reason to do 
>>>> better than a
>>>> sequential search.
>>>>
>>>> If an IDR (or some other kind of mechanism) is used then we can use 
>>>> that to
>>>> store paths associated with ETMs as well.  That way everything 
>>>> works the same
>>>> way and access time is constant for any kind of source.
>>> As per my last sentence above, the goal of  my comment was to simplify
>>> things so that we don't have two different ways of managing sources.
>>> But if that ends up causing more trouble than benefit then it should
>>> be avoided.
>>
>> Hi Mathieu,
>>
>> I didn't see any disadvantage to use IDR to store both ETM source and 
>> non-CPU bound sources.
>>
>> Benefits:
>>
>>   * Only need to maintain one way of managing sources.
>>   * Less time to search the path
>
> My preference is to keep the ETM source paths per-CPU. For the reasons
> below :
>   - It is straight forward for an ETM. per_cpu(paths, cpu)
>   - It is faster than the IDR.
>   - Makes the debugging easier. Simply lookup the per_cpu variable.
>
> I agree that the IDR is required for the non ETM sources. And I am fine
> with that.
>
> Suzuki

Hi Suzuki,

I will address your comments in next version.

Could you please help to review other patches ?

Thanks

Jinlong Mao

>
>>
>> Thanks
>> Jinlong Mao
>>>> Thanks
>>>>
>>>> Jinlong Mao
>>>>
>>>>> Cheers
>>>>> Suzuki
>>>>>
>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>> Thanks
>>>>>>
>>>>>> Jinlong Mao
>>>>>>
>>> _______________________________________________
>>> CoreSight mailing list --coresight@lists.linaro.org
>>> To unsubscribe send an email tocoresight-leave@lists.linaro.org
>
