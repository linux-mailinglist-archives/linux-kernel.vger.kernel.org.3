Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA56E567D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiGFE6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGFE6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:58:37 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227391571D;
        Tue,  5 Jul 2022 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657083516; x=1688619516;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WXjdQsds+XZxZZX7SRcqQV+eu4pHZKuRykJohRSEZyc=;
  b=uVd9oFokqqfnlikGBJHDfJWPra9NR9Cp7I3hz8ug144eRRSptSZ4dius
   voA2sbdfR2sYWU5vUzepStVM74X21JmX2fty8Dhcq+rgImsrLeQpXDyWh
   J3Rr/Ze84XkEf83IEiuWFhGE0uTLE46fWJPiLMT66+LrvuH5XfU4k1E1x
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 21:58:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:58:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 21:58:35 -0700
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 21:58:34 -0700
Subject: Re: [PATCH 1/2] remoteproc: core: Introduce rproc_del_carveout
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654888985-3846-1-git-send-email-quic_clew@quicinc.com>
 <1654888985-3846-2-git-send-email-quic_clew@quicinc.com>
 <7881ee36-89f6-3ba9-f4ac-7c4e614728dd@foss.st.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <42e27ed9-1e31-9943-4e82-84c3b3090383@quicinc.com>
Date:   Tue, 5 Jul 2022 21:57:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7881ee36-89f6-3ba9-f4ac-7c4e614728dd@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 6/30/2022 9:36 AM, Arnaud POULIQUEN wrote:
> Hi,
> 
> On 6/10/22 21:23, Chris Lew wrote:
>> To mirror the exported rproc_add_carveout(), add a rproc_del_carveout()
>> so memory carveout resources added by devices outside of remoteproc can
>> manage the resource lifetime more accurately.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 20 ++++++++++++++++++++
>>   include/linux/remoteproc.h           |  1 +
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 02a04ab34a23..ee71fccae970 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1001,6 +1001,26 @@ void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
>>   EXPORT_SYMBOL(rproc_add_carveout);
>>   
>>   /**
>> + * rproc_del_carveout() - remove an allocated carveout region
>> + * @rproc: rproc handle
>> + * @mem: memory entry to register
>> + *
>> + * This function removes specified memory entry in @rproc carveouts list.
>> + */
>> +void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
>> +{
>> +	struct rproc_mem_entry *entry, *tmp;
>> +
>> +	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
>> +		if (entry == mem) {
>> +			list_del(&mem->node);
>> +			return;
>> +		}
>> +	}
>> +}
>> +EXPORT_SYMBOL(rproc_del_carveout);
> 
> This API seems to me quite dangerous because it can be called while carveouts are in use.
> At least some checks should be added...
> 
> What about using rproc_resource_cleanup instead?
> 
> Regards,
> Arnaud
> 

The intended users of this API would be devices who negotiate with the 
device and know when the carveouts it has added are in use or can be 
reclaimed. I had looked at rproc_resource_cleanup() and that seemed more 
like a blanket cleanup rather than being able to cleanup a specific 
carveout.

I agree the API seems dangerous, but I wasn't quite sure what kind of 
checks could be put here since remoteproc itself doesn't have any 
mechanisms to monitor the carveout state itself. We're relying on the 
fact that the device who added the carveout shouldn't make any mistakes 
which is fairly fragile.

Thanks!
Chris

>> +
>> +/**
>>    * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
>>    * @dev: pointer on device struct
>>    * @va: virtual address
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 7c943f0a2fc4..43112aa78ffe 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -658,6 +658,7 @@ struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
>>   int devm_rproc_add(struct device *dev, struct rproc *rproc);
>>   
>>   void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
>> +void rproc_del_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
>>   
>>   struct rproc_mem_entry *
>>   rproc_mem_entry_init(struct device *dev,
