Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B34C9EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbiCBIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiCBIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:05:57 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB91B8229;
        Wed,  2 Mar 2022 00:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646208313; x=1677744313;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=71XMdPVU2yBDfDqLpqTCHOIjuJPFPV+U0HPpCk5VUlw=;
  b=HYPh8CRBsLurTeiyZGGvYME8lJB+ldLH5QjYdLjVeosV1CszJnr3E+AB
   mmkphZgaqx8rjnJxFHV6blwsP+C2cGSRpEQAxS6luqT4Z4iZv+dmQP/D9
   Cr+tTmKLibJcVBq7Kz9AVVoROfaqyKcznKvInJ9u3I7sWyMjPcBqtECSe
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 00:05:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:05:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 00:05:11 -0800
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 2 Mar 2022
 00:05:08 -0800
Message-ID: <c2c45bed-0be1-1942-1267-16f4169c4f67@quicinc.com>
Date:   Wed, 2 Mar 2022 16:05:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: Defer probe when the child dev is not probed
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mao Jinlong <jinlmao@qti.qualcomm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Tingwei Zhang" <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220228133112.3987-1-quic_jinlmao@quicinc.com>
 <861dd6e1-30dc-626e-3449-72d3b6822e7b@arm.com>
 <a63abe13-793e-323f-e214-1dd9826c8a9a@quicinc.com>
 <CAJ9a7VjShWLeSh0gyna-AUEB+jXO7u8JGLTXm_henn_cJ+E6Zw@mail.gmail.com>
 <edf83cee-d2af-867b-50e4-b065e7fb4b73@quicinc.com>
 <2fd9c96a-fc86-7247-d13a-a5283bb82494@arm.com>
 <a1ee270d-8869-2ad2-106c-9d699f457dcd@quicinc.com>
In-Reply-To: <a1ee270d-8869-2ad2-106c-9d699f457dcd@quicinc.com>
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


On 3/2/2022 10:29 AM, Jinlong Mao wrote:
>
> On 3/1/2022 11:03 PM, Suzuki K Poulose wrote:
>> Hi
>>
>> On 01/03/2022 13:30, Jinlong Mao wrote:
>>> Hi Mike,
>>>
>>> On 3/1/2022 9:15 PM, Mike Leach wrote:
>>>> Hi,
>>>>
>>>> On Tue, 1 Mar 2022 at 11:42, Jinlong Mao <quic_jinlmao@quicinc.com> 
>>>> wrote:
>>>>> On 2/28/2022 10:51 PM, Suzuki K Poulose wrote:
>>>>>
>>
>> ...
>>
>>>>>
>>>>> Hi Suzuki,
>>>>>
>>>>> This issue happens when race condition happens.
>>>>> The condition is that the device and its child_device's probe 
>>>>> happens at the same time.
>>>>>
>>>>> For example: device0 and its child device device1.
>>>>> Both of them are calling coresight_register function. device0 is 
>>>>> calling coresight_fixup_device_conns.
>>>>> device1 is waiting for device0 to release the coresight_mutex. 
>>>>> Because device1's csdev node is allocated,
>>>>> coresight_make_links will be called for device0. Then in 
>>>>> coresight_add_sysfs_link, has_conns_grp is true
>>>>> for device0, but has_conns_grp is false for device1 as 
>>>>> has_conns_grp is set to true in coresight_create_conns_sysfs_group .
>>>>> The probe of device0 will fail for at this condition.
>>>>>
>>>>>
>>>>> struct coresight_device *coresight_register(struct coresight_desc 
>>>>> *desc)
>>>>> {
>>>>>     .........
>>>>>      mutex_lock(&coresight_mutex);
>>>>>
>>>>>      ret = coresight_create_conns_sysfs_group(csdev);
>>>>>      if (!ret)
>>>>>          ret = coresight_fixup_device_conns(csdev);
>>>>>      if (!ret)
>>>>>          ret = coresight_fixup_orphan_conns(csdev);
>>>>>      if (!ret && cti_assoc_ops && cti_assoc_ops->add)
>>>>>          cti_assoc_ops->add(csdev);
>>>>>
>>>>>      mutex_unlock(&coresight_mutex);
>>>>>
>>>>> .........
>>>>>
>>>>> }
>>>>>
>>>>> static int coresight_fixup_device_conns(struct coresight_device 
>>>>> *csdev)
>>>>> {
>>>>>     ..........
>>>>>          conn->child_dev =
>>>>> coresight_find_csdev_by_fwnode(conn->child_fwnode);
>>>> The issue appears to be a constraint hidden in the lower layers of 
>>>> the code.
>>>> Would a better solution not be to alter the code here:
>>>>
>>>> if (conn->child_dev && conn->child_dev->has_conns_grp) {
>>>>     ...
>>>> } else {
>>>>        csdev->orphan = true;
>>>> }
>>>>
>>>> which would mean that the connection attempt would drop through to
>>>> label the connection as an orphan, to be cleaned up by the child
>>>> itself when it runs coresight_fixup_orphan_conns()
>>>>
>>
>> Tnanks Mike, I think that is a good solution. Alternatively, we
>> could make sure that device_register() and the fixup following
>> that are atomic.
>>
>> i.e.
>>
>>     mutex_lock()
>>
>>     device_register()
>>     fixup_connections()
>>     create_sysfs()
>>
>>     mutex_unlock();
>>
>> The fix may be a bit invasive than Mike's proposal, but it makes
>> sure we don't end up with half baked device on the coresight-bus.
>>
>> Suzuki
>
> Thanks Mike & Suzuki.
>
> I will combine your proposals and make the changes.
>
> I will get back to you after the test.

Hi Mike & Suzuki,

Issue is fixed with your proposal.
I submit a new patch "coresight: core: Fix coresight device probe 
failure issue".
Please help to review.

Thanks
Jinlong Mao
>
>
> Thanks
> Jinlong Mao
>
