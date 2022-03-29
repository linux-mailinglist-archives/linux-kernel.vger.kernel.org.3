Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D84EAEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiC2N6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbiC2N6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:48 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804022B6CA;
        Tue, 29 Mar 2022 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648562216; x=1680098216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7xeQcaoji/YSojsXaqUeYJIOSLS1Sxci4GiEXNMiWCg=;
  b=o2VZ7aUj2vvhIbu2Gh3Orc9ClAjlYw1/sPxLhmtdrt2lG6mj2Pb4//R0
   8HKxVhj3IlWo4rZoTjuVMWd4t90H/qKu+BojSZYDWstfQ/In1CwUyvGbo
   2Gg/tUh/xyG4DVpSDUxUf+OYNck+0wOb4T28gQu519DbS3UnTs7sjWJNR
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Mar 2022 06:56:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:56:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 06:56:51 -0700
Received: from [10.253.79.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 06:56:47 -0700
Message-ID: <8698dc76-613e-a00d-340b-220c752d9449@quicinc.com>
Date:   Tue, 29 Mar 2022 21:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
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
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <7d571b9d-2066-8217-5485-da0e6ace65eb@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Suzuki,

On 3/28/2022 4:33 PM, Suzuki K Poulose wrote:
> On 24/03/2022 14:23, Jinlong Mao wrote:
>> Hi Greg,
>>
>> Thanks for your review.
>>
>> On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
>>>> Use hash length of the source's device name to map to the pointer
>>>> of the enabled path. Using IDR will be more efficient than using
>>>> the list. And there could be other sources except STM and CPU etms
>>>> in the new HWs. It is better to maintain all the paths together.
>>>>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-core.c | 75 
>>>> +++++++-------------
>>>>   1 file changed, 26 insertions(+), 49 deletions(-)
>>> Your subject line is odd.  Please put back the driver subsystem in the
>>> subject line so that it makes more sense.
>> I will update the subject in next version.
>>>
>>> And how have you measured "more efficient"?
>>
>> Using IDR would be better than doing a sequential search as there 
>> will be much more device  in future.
>
> Where do we use sequential search now ? For non-CPU bound sources, yes
> we may need something. But CPU case is straight forward, and could be
> retained as it is. i.e., per-cpu list of paths.
>
We use list to store the paths for both ETM and non-CPU bound sources in 
patch below.

“[PATCH 01/10] coresight: add support to enable more coresight paths”

According to Mathieu's comments, IDR is used now.  So i added "Using IDR 
will be more efficient than using
the list" this message in my commit message. I think we need to use one 
mechanism to store ETM and
non-CPU bound sources.


Mathieu's comments:

So many TPDM and many ETMs...  That is definitely a reason to do better than a
sequential search.

If an IDR (or some other kind of mechanism) is used then we can use that to
store paths associated with ETMs as well.  That way everything works the same
way and access time is constant for any kind of source.

Thanks

Jinlong Mao

> Cheers
> Suzuki
>
>
>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Thanks
>>
>> Jinlong Mao
>>
>
