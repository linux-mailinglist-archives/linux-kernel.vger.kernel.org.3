Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03B4EAEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiC2Ntv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiC2Ntu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:49:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86317B8B3;
        Tue, 29 Mar 2022 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648561686; x=1680097686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G3O4xklk20yOcU6Q2jl6Oe/Zbim2TxkIAg6MIEKJXN0=;
  b=DYJLfht3vhrKXFQl21LlTZwPqh0AGJSbPm+M1FFkWJEKN7fz7TM2BASZ
   1cw7s1NFG3ryfZcsGKursPb++2CkyKXhoJkgvOqkEfWNrTX0pPaHjlshe
   G2tfeVaTlfHSedVSF/5641xicAtJBHzJGDa0OsbgCIgt2EnCqe1OezEMG
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Mar 2022 06:48:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 06:48:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 06:47:24 -0700
Received: from [10.253.79.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 06:47:21 -0700
Message-ID: <7c0bed05-a071-82f3-3162-64b88bbe7dc2@quicinc.com>
Date:   Tue, 29 Mar 2022 21:47:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
 <YjylKhBslN+5sKRx@kroah.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <YjylKhBslN+5sKRx@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3/25/2022 1:06 AM, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 10:23:19PM +0800, Jinlong Mao wrote:
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
>>>>    drivers/hwtracing/coresight/coresight-core.c | 75 +++++++-------------
>>>>    1 file changed, 26 insertions(+), 49 deletions(-)
>>> Your subject line is odd.  Please put back the driver subsystem in the
>>> subject line so that it makes more sense.
>> I will update the subject in next version.
>>> And how have you measured "more efficient"?
>> Using IDR would be better than doing a sequential search as there will be
>> much more device  in future.
> How many "more"?  Where does the trade off of speed for complexity help?
> How much faster is this really?  You can't claim performance
> improvements without any proof :)
There is about 40 trace sources in our internal device. I believe there 
will be more cpu cores, then
there will be more etm sources. IDR here is used to store the path of 
both etm
sources and other sources which aren't associated with CPU.  Use IDR is 
not more complicated
than using list. It will also save the time of searching the path when 
coresight_disable.
I tested in internal device. The test case is that enable all the 
sources, disable the source one
by one to check the search time.

Use list to store paths:

               sh-7687    [005] ....   342.113099: __coresight_disable: 
====search path start==== source_0
               sh-7687    [005] ....   342.113127: __coresight_disable: 
====search path end==== source_0
               sh-7693    [005] ....   342.542216: __coresight_disable: 
====search path start==== source_1
               sh-7693    [005] ....   342.542244: __coresight_disable: 
====search path end==== source_1
               sh-7699    [005] ....   342.929083: __coresight_disable: 
====search path start==== source_2
               sh-7699    [005] ....   342.929106: __coresight_disable: 
====search path end==== source_2
               sh-7711    [005] ....   343.760688: __coresight_disable: 
====search path start==== source_3
               sh-7711    [005] ....   343.760713: __coresight_disable: 
====search path end==== source_3
               sh-7717    [005] ....   344.172353: __coresight_disable: 
====search path start==== source_4
               sh-7717    [005] ....   344.172381: __coresight_disable: 
====search path end==== source_4


Use IDR to store paths:

              sh-7156    [006] ....    223.294228: __coresight_disable: 
====search path start==== source_0
               sh-7156    [006] ....   223.294237: __coresight_disable: 
====search path end==== source_0
               sh-7162    [006] ....   223.690153: __coresight_disable: 
====search path start==== source_1
               sh-7162    [006] ....   223.690163: __coresight_disable: 
====search path end==== source_1
               sh-7168    [006] ....   224.110670: __coresight_disable: 
====search path start==== source_2
               sh-7168    [006] ....   224.110679: __coresight_disable: 
====search path end==== source_2
            <...>-7180    [006] ....   224.929315: __coresight_disable: 
====search path start==== source_3
            <...>-7180    [006] ....   224.929324: __coresight_disable: 
====search path end==== source_3
            <...>-7186    [006] ....   225.343617: __coresight_disable: 
====search path start==== source_4
            <...>-7186    [006] ....   225.343626: __coresight_disable: 
====search path end==== source_4

 From the log, Searching the path from the IDR takes about 9us for each 
source.
Searching the path from the list takes about 23 ~ 28us for the source. 
Use IDR saves much time.

Thanks

Jinlong Mao
>
> thanks,
>
> greg k-h
