Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EDB4874B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346434AbiAGJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:30:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37500 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236635AbiAGJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:30:50 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2073QS4Z006682;
        Fri, 7 Jan 2022 10:30:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=njjTQT5IQ5eB7fKzfPlds5Is3OPkOU/De7uRH4puqME=;
 b=zamRNdL+VKaV/8briNcysd3xmDIPiLBvYQACoJ6ct9vLGaFTr27uVwzN+uTzr4CE6Uav
 SkjrTVrN/5se36tM832Ur7ib9AF/V6p0Po1LPZzUQG1L7EHAXTEyrehGpZRslTsz58PI
 +LpuOQ5ov5zMJPNjMkkNS1lgYc+6vxaXkNLDBoJ3+selUpbzT29/QdTM3+HRxZ7m6+tC
 geZQY5TWpo9O7OKUSBX0VfBK+IXdQamhXi1ARip4H6eVEaCAA4DsGU4MRVpczwPm1q1/
 B0u2Rtc8vAuOJDEVbYESXAGp98B8FFJZsFsggg+VOGkVKX4imHcLyjWcEQZAVkp+od8M mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3de4usayn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 10:30:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 266E5100042;
        Fri,  7 Jan 2022 10:30:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C76722DB62;
        Fri,  7 Jan 2022 10:30:46 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 7 Jan
 2022 10:30:45 +0100
Subject: Re: [RFC PATCH v2 4/6] remoteproc: virtio: Create platform device for
 the remoteproc_virtio
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
 <20211222082349.30378-5-arnaud.pouliquen@foss.st.com>
 <20220106185309.GC642186@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <676aa4c6-d317-a447-ddc1-9dd9fcc92c8f@foss.st.com>
Date:   Fri, 7 Jan 2022 10:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106185309.GC642186@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_03,2022-01-06_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 1/6/22 7:53 PM, Mathieu Poirier wrote:
> On Wed, Dec 22, 2021 at 09:23:47AM +0100, Arnaud Pouliquen wrote:
>> Define a platform driver to prepare for the management of
>> remoteproc virtio devices as platform devices.
>>
>> The platform device allows to pass rproc_vdev_data platform data to
>> specify properties that are stored in the rproc_vdev structure.
>>
>> Such approach will allow to preserve legacy remoteproc virtio device
>> creation but also to probe the device using device tree mechanism.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Update vs previous revision:
>>    - Fix commit and rename rproc_vdev_data to rproc_vdev_pdata
>> ---
>>   drivers/remoteproc/remoteproc_internal.h |  6 +++
>>   drivers/remoteproc/remoteproc_virtio.c   | 65 ++++++++++++++++++++++++
>>   include/linux/remoteproc.h               |  2 +
>>   3 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>> index e9e9a551a8c2..6f511c50a15d 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -24,6 +24,12 @@ struct rproc_debug_trace {
>>   	struct rproc_mem_entry trace_mem;
>>   };
>>   
>> +struct rproc_vdev_pdata {
>> +	u32 rsc_offset;
>> +	unsigned int id;
>> +	unsigned int index;
>> +};
>> +
>>   /* from remoteproc_core.c */
>>   void rproc_release(struct kref *kref);
>>   int rproc_of_parse_firmware(struct device *dev, int index,
>> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
>> index 51d415744fc6..5f8005caeb6e 100644
>> --- a/drivers/remoteproc/remoteproc_virtio.c
>> +++ b/drivers/remoteproc/remoteproc_virtio.c
>> @@ -4,6 +4,7 @@
>>    *
>>    * Copyright (C) 2011 Texas Instruments, Inc.
>>    * Copyright (C) 2011 Google, Inc.
>> + * Copyright (C) 2021 STMicroelectronics
>>    *
>>    * Ohad Ben-Cohen <ohad@wizery.com>
>>    * Brian Swetland <swetland@google.com>
>> @@ -13,6 +14,7 @@
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/export.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/of_reserved_mem.h>
>>   #include <linux/remoteproc.h>
>>   #include <linux/virtio.h>
>> @@ -575,3 +577,66 @@ void rproc_vdev_release(struct kref *ref)
>>   
>>   	rproc_rvdev_remove_device(rvdev);
>>   }
>> +
>> +static int rproc_virtio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rproc_vdev_pdata *vdev_data = dev->platform_data;
>> +	struct rproc_vdev *rvdev;
>> +	struct rproc *rproc;
>> +
>> +	if (!vdev_data)
>> +		return -EINVAL;
>> +
>> +	rvdev = devm_kzalloc(dev, sizeof(*rvdev), GFP_KERNEL);
>> +	if (!rvdev)
>> +		return -ENOMEM;
>> +
>> +	rproc = container_of(dev->parent, struct rproc, dev);
>> +
>> +	rvdev->rsc_offset = vdev_data->rsc_offset;
>> +	rvdev->id = vdev_data->id;
>> +	rvdev->index = vdev_data->index;
>> +
>> +	rvdev->pdev = pdev;
>> +	rvdev->rproc = rproc;
>> +
>> +	platform_set_drvdata(pdev, rvdev);
>> +
>> +	return rproc_rvdev_add_device(rvdev);
>> +}
>> +
>> +static int rproc_virtio_remove(struct platform_device *pdev)
>> +{
>> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
>> +	struct rproc *rproc = rvdev->rproc;
>> +	struct rproc_vring *rvring;
>> +	int id;
>> +
>> +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
>> +		rvring = &rvdev->vring[id];
>> +		rproc_free_vring(rvring);
>> +	}
>> +
>> +	rproc_remove_subdev(rproc, &rvdev->subdev);
>> +	rproc_unregister_rvdev(rvdev);
>> +	dev_dbg(&pdev->dev, "virtio dev %d removed\n",  rvdev->index);
>> +
> 
> Function rproc_virtio_remove() doesn't do the opposite of rproc_virtio_probe(),
> making it hard for people to wrap their head around what is happening.  This may
> get cleaned up as part of the error path problem we already talked about...  If not
> this is something to improve one.
> 
> I am done reviewing this set.

Thanks for the review. I will address all your points in next version.

Regards,
Arnaud

> 
> Thanks,
> Mathieu
> 
>> +	return 0;
>> +}
>> +
>> +/* Platform driver */
>> +static const struct of_device_id rproc_virtio_match[] = {
>> +	{ .compatible = "rproc-virtio", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver rproc_virtio_driver = {
>> +	.probe		= rproc_virtio_probe,
>> +	.remove		= rproc_virtio_remove,
>> +	.driver		= {
>> +		.name	= "rproc-virtio",
>> +		.of_match_table	= rproc_virtio_match,
>> +	},
>> +};
>> +builtin_platform_driver(rproc_virtio_driver);
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index e0600e1e5c17..542a3d4664f2 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -616,6 +616,7 @@ struct rproc_vring {
>>    * struct rproc_vdev - remoteproc state for a supported virtio device
>>    * @refcount: reference counter for the vdev and vring allocations
>>    * @subdev: handle for registering the vdev as a rproc subdevice
>> + * @pdev: remoteproc virtio platform device
>>    * @dev: device struct used for reference count semantics
>>    * @id: virtio device id (as in virtio_ids.h)
>>    * @node: list node
>> @@ -628,6 +629,7 @@ struct rproc_vdev {
>>   	struct kref refcount;
>>   
>>   	struct rproc_subdev subdev;
>> +	struct platform_device *pdev;
>>   	struct device dev;
>>   
>>   	unsigned int id;
>> -- 
>> 2.17.1
>>
