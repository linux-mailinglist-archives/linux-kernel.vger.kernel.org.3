Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65908475C00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhLOPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:41:24 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63712 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244051AbhLOPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639582874; x=1671118874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EgLnYdnP6Z2nNaMt3/Wonw4+7AJUa3t7EsxvQX3swxY=;
  b=zPrV+gCeG7zKbpzRvzssMgcP09h1Twg6x4IC049MV2pjkopxLLLzCI8b
   fdK56bqvRHr91LZma1TWb5ce8I2amBCB8tXFLfv+rX4PBfCashtZGHo3X
   CKf3p5MtFqSUC5+Ozv4VNWxQXqstWOLm0ex9KQ0ayb/3Iu5GzXgOAUBXa
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Dec 2021 07:41:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:41:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 07:41:00 -0800
Received: from [10.253.39.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 07:40:57 -0800
Message-ID: <764c4694-9793-3b18-5e22-14ad3bdb0a79@quicinc.com>
Date:   Wed, 15 Dec 2021 23:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/9] Use IDR to maintain all the enabled sources'
 paths.
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-2-quic_jinlmao@quicinc.com>
 <20211214183010.GA1549991@p14s>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20211214183010.GA1549991@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for the review.

On 12/15/2021 2:30 AM, Mathieu Poirier wrote:
> Hi Mao,
>
> On Thu, Dec 09, 2021 at 10:15:35PM +0800, Mao Jinlong wrote:
>> Use hash length of the source's device name to map to the pointer
>> of the enabled path. Using IDR will be more efficient than using
>> the list. And there could be other sources except STM and CPU etms
>> in the new HWs. It is better to maintain all the paths together.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 76 +++++++-------------
>>   1 file changed, 26 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 8a18c71df37a..cc6b6cabf85f 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>> +#include <linux/idr.h>
>>   #include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/export.h>
>> @@ -26,6 +27,12 @@
>>   static DEFINE_MUTEX(coresight_mutex);
>>   static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>>   
>> +/*
>> + * Use IDR to map the hash length of the source's device name
>> + * to the pointer of path for the source
>> + */
>> +static DEFINE_IDR(path_idr);
>> +
>>   /**
>>    * struct coresight_node - elements of a path, from source to sink
>>    * @csdev:	Address of an element.
>> @@ -36,20 +43,6 @@ struct coresight_node {
>>   	struct list_head link;
>>   };
>>   
>> -/*
>> - * When operating Coresight drivers from the sysFS interface, only a single
>> - * path can exist from a tracer (associated to a CPU) to a sink.
>> - */
>> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
>> -
>> -/*
>> - * As of this writing only a single STM can be found in CS topologies.  Since
>> - * there is no way to know if we'll ever see more and what kind of
>> - * configuration they will enact, for the time being only define a single path
>> - * for STM.
>> - */
>> -static struct list_head *stm_path;
>> -
>>   /*
>>    * When losing synchronisation a new barrier packet needs to be inserted at the
>>    * beginning of the data collected in a buffer.  That way the decoder knows that
>> @@ -1088,10 +1081,11 @@ static int coresight_validate_source(struct coresight_device *csdev,
>>   
>>   int coresight_enable(struct coresight_device *csdev)
>>   {
>> -	int cpu, ret = 0;
>> +	int ret = 0;
>>   	struct coresight_device *sink;
>>   	struct list_head *path;
>>   	enum coresight_dev_subtype_source subtype;
>> +	u32 hash;
>>   
>>   	subtype = csdev->subtype.source_subtype;
>>   
>> @@ -1133,26 +1127,14 @@ int coresight_enable(struct coresight_device *csdev)
>>   	if (ret)
>>   		goto err_source;
>>   
>> -	switch (subtype) {
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>> -		/*
>> -		 * When working from sysFS it is important to keep track
>> -		 * of the paths that were created so that they can be
>> -		 * undone in 'coresight_disable()'.  Since there can only
>> -		 * be a single session per tracer (when working from sysFS)
>> -		 * a per-cpu variable will do just fine.
>> -		 */
>> -		cpu = source_ops(csdev)->cpu_id(csdev);
>> -		per_cpu(tracer_path, cpu) = path;
>> -		break;
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>> -		stm_path = path;
>> -		break;
>> -	default:
>> -		/* We can't be here */
>> -		break;
>> -	}
>> -
>> +	/*
>> +	 * Use the hash length of source's device name as ID
>> +	 * and map the ID to the pointer of the path.
>> +	 */
>> +	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>> +	ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
>> +	if (ret)
>> +		goto err_source;
>>   out:
>>   	mutex_unlock(&coresight_mutex);
>>   	return ret;
>> @@ -1168,8 +1150,9 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>>   
>>   void coresight_disable(struct coresight_device *csdev)
>>   {
>> -	int cpu, ret;
>> +	int ret;
>>   	struct list_head *path = NULL;
>> +	u32 hash;
>>   
>>   	mutex_lock(&coresight_mutex);
>>   
>> @@ -1180,21 +1163,13 @@ void coresight_disable(struct coresight_device *csdev)
>>   	if (!csdev->enable || !coresight_disable_source(csdev))
>>   		goto out;
>>   
>> -	switch (csdev->subtype.source_subtype) {
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>> -		cpu = source_ops(csdev)->cpu_id(csdev);
>> -		path = per_cpu(tracer_path, cpu);
>> -		per_cpu(tracer_path, cpu) = NULL;
>> -		break;
>> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>> -		path = stm_path;
>> -		stm_path = NULL;
>> -		break;
>> -	default:
>> -		/* We can't be here */
>> -		break;
>> -	}
>> +	hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>> +	/* Find the path by the hash length. */
>> +	path = idr_find(&path_idr, hash);
>> +	if (path == NULL)
>> +		return;
> Please add a dev_err() here as this should really not be happening.

I will add the dev_err().

>
>>   
>> +	idr_remove(&path_idr, hash);
>>   	coresight_disable_path(path);
>>   	coresight_release_path(path);
>>   
>> @@ -1779,6 +1754,7 @@ static int __init coresight_init(void)
>>   
>>   static void __exit coresight_exit(void)
>>   {
>> +	idr_destroy(&path_idr);
> As far as I can tell this isn't needed.

I will remove this.

>
>>   	cscfg_exit();
>>   	etm_perf_exit();
>>   	bus_unregister(&coresight_bustype);
>> -- 
>> 2.17.1
>>
