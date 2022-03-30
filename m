Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB674EBD30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiC3JG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC3JGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:06:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACA87196D58;
        Wed, 30 Mar 2022 02:05:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C0023A;
        Wed, 30 Mar 2022 02:05:04 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F39F3F66F;
        Wed, 30 Mar 2022 02:05:02 -0700 (PDT)
Message-ID: <ff1931d7-61b4-4362-7e3b-45c64c0211fc@arm.com>
Date:   Wed, 30 Mar 2022 10:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
 <YjxjXnXAXVXfZqr/@kroah.com>
 <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
 <7d571b9d-2066-8217-5485-da0e6ace65eb@arm.com>
 <8698dc76-613e-a00d-340b-220c752d9449@quicinc.com>
 <CANLsYkwZxqYMtx-v=OZoZAYshFHW2s_7isUq1UgUV18pVvSB8w@mail.gmail.com>
 <b4d4ca6f-13ae-8050-debe-57e6c8be6254@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b4d4ca6f-13ae-8050-debe-57e6c8be6254@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 03:10, Jinlong Mao wrote:
> 
> On 3/29/2022 10:36 PM, Mathieu Poirier wrote:
>> On Tue, 29 Mar 2022 at 07:56, Jinlong Mao<quic_jinlmao@quicinc.com>  wrote:
>>> Hi Suzuki,
>>>
>>> On 3/28/2022 4:33 PM, Suzuki K Poulose wrote:
>>>> On 24/03/2022 14:23, Jinlong Mao wrote:
>>>>> Hi Greg,
>>>>>
>>>>> Thanks for your review.
>>>>>
>>>>> On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
>>>>>> On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
>>>>>>> Use hash length of the source's device name to map to the pointer
>>>>>>> of the enabled path. Using IDR will be more efficient than using
>>>>>>> the list. And there could be other sources except STM and CPU etms
>>>>>>> in the new HWs. It is better to maintain all the paths together.
>>>>>>>
>>>>>>> Signed-off-by: Mao Jinlong<quic_jinlmao@quicinc.com>
>>>>>>> ---
>>>>>>>    drivers/hwtracing/coresight/coresight-core.c | 75
>>>>>>> +++++++-------------
>>>>>>>    1 file changed, 26 insertions(+), 49 deletions(-)
>>>>>> Your subject line is odd.  Please put back the driver subsystem in the
>>>>>> subject line so that it makes more sense.
>>>>> I will update the subject in next version.
>>>>>> And how have you measured "more efficient"?
>>>>> Using IDR would be better than doing a sequential search as there
>>>>> will be much more device  in future.
>>>> Where do we use sequential search now ? For non-CPU bound sources, yes
>>>> we may need something. But CPU case is straight forward, and could be
>>>> retained as it is. i.e., per-cpu list of paths.
>>>>
>>> We use list to store the paths for both ETM and non-CPU bound sources in
>>> patch below.
>>>
>>> “[PATCH 01/10] coresight: add support to enable more coresight paths”
>>>
>>> According to Mathieu's comments, IDR is used now.  So i added "Using IDR
>>> will be more efficient than using
>>> the list" this message in my commit message. I think we need to use one
>>> mechanism to store ETM and
>>> non-CPU bound sources.
>>>
>>>
>>> Mathieu's comments:
>>>
>>> So many TPDM and many ETMs...  That is definitely a reason to do better than a
>>> sequential search.
>>>
>>> If an IDR (or some other kind of mechanism) is used then we can use that to
>>> store paths associated with ETMs as well.  That way everything works the same
>>> way and access time is constant for any kind of source.
>> As per my last sentence above, the goal of  my comment was to simplify
>> things so that we don't have two different ways of managing sources.
>> But if that ends up causing more trouble than benefit then it should
>> be avoided.
> 
> Hi Mathieu,
> 
> I didn't see any disadvantage to use IDR to store both ETM source and 
> non-CPU bound sources.
> 
> Benefits:
> 
>   * Only need to maintain one way of managing sources.
>   * Less time to search the path

My preference is to keep the ETM source paths per-CPU. For the reasons
below :
   - It is straight forward for an ETM. per_cpu(paths, cpu)
   - It is faster than the IDR.
   - Makes the debugging easier. Simply lookup the per_cpu variable.

I agree that the IDR is required for the non ETM sources. And I am fine
with that.

Suzuki

> 
> Thanks
> Jinlong Mao
>>> Thanks
>>>
>>> Jinlong Mao
>>>
>>>> Cheers
>>>> Suzuki
>>>>
>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>> Thanks
>>>>>
>>>>> Jinlong Mao
>>>>>
>> _______________________________________________
>> CoreSight mailing list --coresight@lists.linaro.org
>> To unsubscribe send an email tocoresight-leave@lists.linaro.org

