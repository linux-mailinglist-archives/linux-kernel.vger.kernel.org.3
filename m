Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68764EEE05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiDANZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244750AbiDANZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:25:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110127382B;
        Fri,  1 Apr 2022 06:23:58 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231Bgmc7012980;
        Fri, 1 Apr 2022 15:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=UaAHcRSFG0XlRh7PRn1uelLYtvz2ZgoPmp0BpWrkxH8=;
 b=HzNLaN/nmCUVazB5rbJ/4ZoS+ltX5A+3XL2gnwo88RItDp+8AXd4QBgs8dipMHBAmLUy
 lTz9ssun7P3JgPKh2uXq1I6tV5MAad346Q1KH4rPT8MnPo9cGdUCXS8XtJaLtjNox/rm
 +9dX8oaOm1+o5searQbSvNSNXBLuiQF1NYH+6eEfgUZSrMr9YMtBWTmUTErXFryEH/UJ
 UP1GFjDm6RTqoFSMrtr8VzFFIgresbhVfTQhRmpHHwgDKOpEZo5RaHeDKmNxdQmaFOGo
 uRphPRSOE3ZFD51IOVYeSjAUyN3jQHCOup63QOlxtrGdbVxCWIf6+LgAmZBEsglRcG4X 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f1s4pvj82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 15:23:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D774A10002A;
        Fri,  1 Apr 2022 15:23:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CED2222ECC8;
        Fri,  1 Apr 2022 15:23:46 +0200 (CEST)
Received: from [10.211.9.74] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 1 Apr
 2022 15:23:45 +0200
Message-ID: <2468c46f-331c-588b-cb10-e8d2d7f2d6ba@foss.st.com>
Date:   Fri, 1 Apr 2022 15:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
 <Yiu7DPHDY3uwcnLK@builder.lan>
 <9be3d491-4fdc-4aa6-8176-23a2cf3773ca@foss.st.com>
 <9d95e516-409e-16d1-e1ea-72365efeee59@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <9d95e516-409e-16d1-e1ea-72365efeee59@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Deepak,

On 3/29/22 13:00, Deepak Kumar Singh wrote:
> 
> On 3/23/2022 4:27 PM, Arnaud POULIQUEN wrote:
>>
>> On 3/11/22 22:11, Bjorn Andersson wrote:
>>> On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:
>>>
>>>> Some transports like Glink support the state notifications between
>>>> clients using signals similar to serial protocol signals.
>>>> Local glink client drivers can send and receive signals to glink
>>>> clients running on remote processors.
>>>>
>>>> Add APIs to support sending and receiving of signals by rpmsg clients.
>>>>
>>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>>> ---
>>>>   drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>>   drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>>   include/linux/rpmsg.h          | 14 ++++++++++++++
>>>>   3 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>> index d3eb600..6712418 100644
>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>> @@ -328,6 +328,24 @@ int rpmsg_trysend_offchannel(struct
>>>> rpmsg_endpoint *ept, u32 src, u32 dst,
>>>>   EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>>     /**
>>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>>> + * @ept:    the rpmsg endpoint
>>>> + * @enable:    enable or disable serial flow control
>>>> + *
>>>> + * Return: 0 on success and an appropriate error value on failure.
>>>> + */
>>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>>> This API looks nice and clean and deals with flow control.
>> seems to me ambiguous API... what does it means flow control enable?
>> Does it means that the flow control is enable or that the the local
>> endpoint is ready to receive?
> This means that local endpoint is ready to receive data.
>>
>> Could we consider here that it is more a bind/unbind of the endpoint?
> 
> Endpoint will remain bind, only data on that endpoint is not expected if
> flow control is disabled.
> 
> If flow control is enabled remote client can send data.
> 
>>>> +{
>>>> +    if (WARN_ON(!ept))
>>>> +        return -EINVAL;
>>>> +    if (!ept->ops->set_flow_control)
>>>> +        return -ENXIO;
>>>> +
>>>> +    return ept->ops->set_flow_control(ept, enable);
>>>> +}
>>>> +EXPORT_SYMBOL(rpmsg_set_flow_control);
>>>> +
>>>> +/**
>>>>    * rpmsg_get_mtu() - get maximum transmission buffer size for
>>>> sending message.
>>>>    * @ept: the rpmsg endpoint
>>>>    *
>>>> @@ -535,6 +553,9 @@ static int rpmsg_dev_probe(struct device *dev)
>>>>             rpdev->ept = ept;
>>>>           rpdev->src = ept->addr;
>>>> +
>>>> +        if (rpdrv->signals)
>> seems an useless check
> 
> Some rpmsg cleints may not want to deal with flow control and not
> provide signal callback.
> 
> In such case this check is needed.
> 

my point here is that if rpdrv->signals is NULL,
then  ept->sig_cb will be NULL with or without the check.

>>>> +            ept->sig_cb = rpdrv->signals;
>>>>       }
>>>>         err = rpdrv->probe(rpdev);
>>>> diff --git a/drivers/rpmsg/rpmsg_internal.h
>>>> b/drivers/rpmsg/rpmsg_internal.h
>>>> index b1245d3..35c2197 100644
>>>> --- a/drivers/rpmsg/rpmsg_internal.h
>>>> +++ b/drivers/rpmsg/rpmsg_internal.h
>>>> @@ -53,6 +53,7 @@ struct rpmsg_device_ops {
>>>>    * @trysendto:        see @rpmsg_trysendto(), optional
>>>>    * @trysend_offchannel:    see @rpmsg_trysend_offchannel(), optional
>>>>    * @poll:        see @rpmsg_poll(), optional
>>>> + * @set_flow_control:    see @rpmsg_set_flow_control(), optional
>>>>    * @get_mtu:        see @rpmsg_get_mtu(), optional
>>>>    *
>>>>    * Indirection table for the operations that a rpmsg backend
>>>> should implement.
>>>> @@ -73,6 +74,7 @@ struct rpmsg_endpoint_ops {
>>>>                    void *data, int len);
>>>>       __poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>>>                    poll_table *wait);
>>>> +    int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>>>>       ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>>>   };
>>>>   diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>>> index 02fa911..06d090c 100644
>>>> --- a/include/linux/rpmsg.h
>>>> +++ b/include/linux/rpmsg.h
>>>> @@ -62,12 +62,14 @@ struct rpmsg_device {
>>>>   };
>>>>     typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int,
>>>> void *, u32);
>>>> +typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32);
>>> This callback however, is still using the original low level tty
>>> signals.
>>>
>>> Is there any reason why this can't be "rpmsg_flowcontrol_cb_t" and take
>>> a boolean, so we get a clean interface in both directions?
>>>
>>> Regards,
>>> Bjorn
>>>
>>>>     /**
>>>>    * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>>>    * @rpdev: rpmsg channel device
>>>>    * @refcount: when this drops to zero, the ept is deallocated
>>>>    * @cb: rx callback handler
>>>> + * @sig_cb: rx serial signal handler
>> Is it signaling for reception or transmission?
> Remote is signalling for transmission.

So that the remote side is ready to receive, right?

Perhaps "@sig_cb: remote signaling callback handler" would be
less ambiguous?

Regards,
Arnaud

>>
>> Regards,
>> Arnaud
>>
>>>>    * @cb_lock: must be taken before accessing/changing @cb
>>>>    * @addr: local rpmsg address
>>>>    * @priv: private data for the driver's use
>>>> @@ -90,6 +92,7 @@ struct rpmsg_endpoint {
>>>>       struct rpmsg_device *rpdev;
>>>>       struct kref refcount;
>>>>       rpmsg_rx_cb_t cb;
>>>> +    rpmsg_rx_sig_t sig_cb;
>>>>       struct mutex cb_lock;
>>>>       u32 addr;
>>>>       void *priv;
>>>> @@ -111,6 +114,7 @@ struct rpmsg_driver {
>>>>       int (*probe)(struct rpmsg_device *dev);
>>>>       void (*remove)(struct rpmsg_device *dev);
>>>>       int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>>>> +    int (*signals)(struct rpmsg_device *rpdev, void *priv, u32);
>>>>   };
>>>>     static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev,
>>>> __rpmsg16 val)
>>>> @@ -188,6 +192,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>>>> struct file *filp,
>>>>     ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>>>   +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
>>>> +
>>>>   #else
>>>>     static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
>>>> @@ -306,6 +312,14 @@ static inline ssize_t rpmsg_get_mtu(struct
>>>> rpmsg_endpoint *ept)
>>>>       return -ENXIO;
>>>>   }
>>>>   +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint
>>>> *ept, bool enable)
>>>> +{
>>>> +    /* This shouldn't be possible */
>>>> +    WARN_ON(1);
>>>> +
>>>> +    return -ENXIO;
>>>> +}
>>>> +
>>>>   #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>>>     /* use a macro to avoid include chaining to get THIS_MODULE */
>>>> -- 
>>>> 2.7.4
>>>>
