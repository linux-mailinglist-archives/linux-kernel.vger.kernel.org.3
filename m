Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0454D30FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiCIO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiCIO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:29:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B814996F;
        Wed,  9 Mar 2022 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646836108; x=1678372108;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rt00vMWntWBfgYxxJTwI8GO3gq5s97qk3a8l4ALwdsM=;
  b=Jl7ykdeUmW4BKEnT8bnEMb4Z4gGHNyNQmya3kcUtombUA6CJ1LDLg9KP
   b/gZA8l4+oJWPPkfc4NFHgZbNtagpLIYvklXrm+63y0k0JqPb8m5EbfRa
   ZRY0HZdXuHxy7/wrjBRrvaER+ZqPk5pWh4a6SkLggcCFbXFpPSyiAb3ja
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Mar 2022 06:28:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:27:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:27:42 -0800
Received: from [10.253.38.26] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 9 Mar 2022
 06:27:38 -0800
Message-ID: <64bdcca3-b54f-37de-0bee-2f79c1511da1@quicinc.com>
Date:   Wed, 9 Mar 2022 22:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] coresight: core: Fix coresight device probe failure
 issue
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Tingwei Zhang" <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>, <quic_jinlmao@quicinc.com>
References: <20220304082350.30069-1-quic_jinlmao@quicinc.com>
 <c77c93bb-f863-47c8-0ba0-3fc63530a9e1@arm.com>
 <ea6219df-0a10-8e8d-4848-a28704a9f98e@arm.com>
 <7db54684-2637-ba82-7146-c8a559337933@quicinc.com>
In-Reply-To: <7db54684-2637-ba82-7146-c8a559337933@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Suzuki,

On 3/9/2022 10:57 AM, Jinlong Mao wrote:
> Hi Suzuki,
>
> On 3/8/2022 9:36 PM, Suzuki K Poulose wrote:
>> On 08/03/2022 11:56, Suzuki K Poulose wrote:
>>> Hi Jinlong
>>>
>>> On 04/03/2022 08:23, Mao Jinlong wrote:
>>>> It is possibe that probe failure issue happens when the device
>>>> and its child_device's probe happens at the same time.
>>>> In coresight_make_links, has_conns_grp is true for parent, but
>>>> has_conns_grp is false for child device as has_conns_grp is set
>>>> to true in coresight_create_conns_sysfs_group. The probe of parent
>>>> device will fail at this condition. Add has_conns_grp check for
>>>> child device before make the links and make the process from
>>>> device_register to connection_create be atomic to avoid this
>>>> probe failure issue.
>>>>
>>>> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Suggested-by: Mike Leach <mike.leach@linaro.org>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-core.c | 12 ++++++------
>>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index 88653d1c06a4..b3e3bc59c09b 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -1382,7 +1382,7 @@ static int 
>>>> coresight_fixup_device_conns(struct coresight_device *csdev)
>>>>               continue;
>>>>           conn->child_dev =
>>>> coresight_find_csdev_by_fwnode(conn->child_fwnode);
>>>> -        if (conn->child_dev) {
>>>> +        if (conn->child_dev && conn->child_dev->has_conns_grp) {
>>>>               ret = coresight_make_links(csdev, conn,
>>>>                              conn->child_dev);
>>>>               if (ret)
>>>> @@ -1594,7 +1594,8 @@ struct coresight_device 
>>>> *coresight_register(struct coresight_desc *desc)
>>>>       refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
>>>>       if (!refcnts) {
>>>>           ret = -ENOMEM;
>>>> -        goto err_free_csdev;
>>>> +        kfree(csdev);
>>>> +        goto err_out;
>>>>       }
>>>>       csdev->refcnt = refcnts;
>>>> @@ -1619,8 +1620,10 @@ struct coresight_device 
>>>> *coresight_register(struct coresight_desc *desc)
>>>>       csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>>>>       dev_set_name(&csdev->dev, "%s", desc->name);
>>>> +    mutex_lock(&coresight_mutex);
>>>>       ret = device_register(&csdev->dev);
>>>>       if (ret) {
>>>> +        mutex_unlock(&coresight_mutex);
>>>>           put_device(&csdev->dev);
>>>>           /*
>>>>            * All resources are free'd explicitly via
>>>> @@ -1634,6 +1637,7 @@ struct coresight_device 
>>>> *coresight_register(struct coresight_desc *desc)
>>>>           ret = etm_perf_add_symlink_sink(csdev);
>>>>           if (ret) {
>>>> +            mutex_unlock(&coresight_mutex);
>>>>               device_unregister(&csdev->dev);
>>>>               /*
>>>>                * As with the above, all resources are free'd
>>>> @@ -1645,8 +1649,6 @@ struct coresight_device 
>>>> *coresight_register(struct coresight_desc *desc)
>>>>           }
>>>>       }
>>>> -    mutex_lock(&coresight_mutex);
>>>> -
>>>>       ret = coresight_create_conns_sysfs_group(csdev);
>>>>       if (!ret)
>>>>           ret = coresight_fixup_device_conns(csdev);
>>>> @@ -1663,8 +1665,6 @@ struct coresight_device 
>>>> *coresight_register(struct coresight_desc *desc)
>>>>       return csdev;
>>>> -err_free_csdev:
>>>> -    kfree(csdev);
>>>>   err_out:
>>>>       /* Cleanup the connection information */
>>>>       coresight_release_platform_data(NULL, desc->pdata);
>>>
>>> Could we consolidate the unlock sequence to a single point with 
>>> something like this (untested):
>>>
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>> b/drivers/hwtracing/coresight/coresight-core.c
>>> index af00dca8d1ac..198ee140c6e6 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1571,6 +1571,7 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>       int nr_refcnts = 1;
>>>       atomic_t *refcnts = NULL;
>>>       struct coresight_device *csdev;
>>> +    bool registered = false;
>>>
>>>       csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
>>>       if (!csdev) {
>>> @@ -1591,7 +1592,8 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>       refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
>>>       if (!refcnts) {
>>>           ret = -ENOMEM;
>>> -        goto err_free_csdev;
>>> +        kfree(csdev);
>>> +        goto err_out;
>>>       }
>>>
>>>       csdev->refcnt = refcnts;
>>> @@ -1616,6 +1618,13 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>       csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>>>       dev_set_name(&csdev->dev, "%s", desc->name);
>>>
>>> +    /*
>>> +     * Make sure the device registration and the connection fixup
>>> +     * are synchronised, so that we don't see uninitialised devices
>>> +     * on the coresight bus while trying to resolve the connections.
>>> +     */
>>> +    mutex_lock(&coresight_mutex);
>>> +
>>>       ret = device_register(&csdev->dev);
>>>       if (ret) {
>>>           put_device(&csdev->dev);
>>> @@ -1623,7 +1632,7 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>            * All resources are free'd explicitly via
>>>            * coresight_device_release(), triggered from put_device().
>>>            */
>>> -        goto err_out;
>>> +        goto out_unlock;
>>>       }
>>>
>>>       if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>>> @@ -1638,11 +1647,11 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>                * from put_device(), which is in turn called from
>>>                * function device_unregister().
>>>                */
>>> -            goto err_out;
>>> +            goto out_unlock;
>>>           }
>>>       }
>>> -
>>> -    mutex_lock(&coresight_mutex);
>>> +    /* Device is now registered */
>>> +    registered = true;
>>>
>>>       ret = coresight_create_conns_sysfs_group(csdev);
>>>       if (!ret)
>>> @@ -1652,16 +1661,15 @@ struct coresight_device 
>>> *coresight_register(struct coresight_desc *desc)
>>>       if (!ret && cti_assoc_ops && cti_assoc_ops->add)
>>>           cti_assoc_ops->add(csdev);
>>>
>>> +out_unlock:
>>>       mutex_unlock(&coresight_mutex);
>>> -    if (ret) {
>>> +    /* Success */
>>> +    if (!ret)
>>> +        return csdev;
>>> +
>>> +    /* Unregister the device if needed */
>>> +    if (registered)
>>>           coresight_unregister(csdev);
>>> -        return ERR_PTR(ret);
>>> -    }
>>
>> Apologies, this should be preserved :
>>
>> i.e,
>>     if (registered) {
>>         coresight_unregister(csdev);
>>         return ERR_PTR(ret);
>>     }

I tested with your changes.
No probe failure during reboot stress test.
I submit "[PATCH v3] coresight: core: Fix coresight device probe failure 
issue".
Please help to review.

Thanks
Jinlong Mao

> I will test with your changes and get back to you later.
>
> Thanks
> Jinlong Mao
>>
>> Thanks
>> Suzuki
