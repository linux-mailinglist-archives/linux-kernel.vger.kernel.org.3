Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329A14EABCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiC2LCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiC2LB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:01:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768FF4619;
        Tue, 29 Mar 2022 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648551613; x=1680087613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ng8j5U+2J+Z3oj5EDdfIP99PX9TlSsz6uPdfYN4UJJE=;
  b=NegULnVNg6mpwN/PAIKzFtJ8y93z09mc0FK5bHMs4ywDaX0sBuidHLex
   ee/NXxw1GmEjd1evsDkLV8Puhy9+1ge40dB6iji+lH9Iua41I1IRHN0fi
   OUPGDb2EnzKgkfJ3cVD8xEwWeewVhvwodv2vvm86+U9kQpYwxCxkVtb1k
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Mar 2022 04:00:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 04:00:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 04:00:10 -0700
Received: from [10.216.50.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 04:00:05 -0700
Message-ID: <9d95e516-409e-16d1-e1ea-72365efeee59@quicinc.com>
Date:   Tue, 29 Mar 2022 16:30:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Ohad Ben-Cohen" <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
 <Yiu7DPHDY3uwcnLK@builder.lan>
 <9be3d491-4fdc-4aa6-8176-23a2cf3773ca@foss.st.com>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <9be3d491-4fdc-4aa6-8176-23a2cf3773ca@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 3/23/2022 4:27 PM, Arnaud POULIQUEN wrote:
>
> On 3/11/22 22:11, Bjorn Andersson wrote:
>> On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:
>>
>>> Some transports like Glink support the state notifications between
>>> clients using signals similar to serial protocol signals.
>>> Local glink client drivers can send and receive signals to glink
>>> clients running on remote processors.
>>>
>>> Add APIs to support sending and receiving of signals by rpmsg clients.
>>>
>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>> ---
>>>   drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>   drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>   include/linux/rpmsg.h          | 14 ++++++++++++++
>>>   3 files changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>> index d3eb600..6712418 100644
>>> --- a/drivers/rpmsg/rpmsg_core.c
>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>> @@ -328,6 +328,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>   EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>   
>>>   /**
>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>> + * @ept:	the rpmsg endpoint
>>> + * @enable:	enable or disable serial flow control
>>> + *
>>> + * Return: 0 on success and an appropriate error value on failure.
>>> + */
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>> This API looks nice and clean and deals with flow control.
> seems to me ambiguous API... what does it means flow control enable? Does it means that the flow control is enable or that the the local
> endpoint is ready to receive?
This means that local endpoint is ready to receive data.
>
> Could we consider here that it is more a bind/unbind of the endpoint?

Endpoint will remain bind, only data on that endpoint is not expected if 
flow control is disabled.

If flow control is enabled remote client can send data.

>>> +{
>>> +	if (WARN_ON(!ept))
>>> +		return -EINVAL;
>>> +	if (!ept->ops->set_flow_control)
>>> +		return -ENXIO;
>>> +
>>> +	return ept->ops->set_flow_control(ept, enable);
>>> +}
>>> +EXPORT_SYMBOL(rpmsg_set_flow_control);
>>> +
>>> +/**
>>>    * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>>    * @ept: the rpmsg endpoint
>>>    *
>>> @@ -535,6 +553,9 @@ static int rpmsg_dev_probe(struct device *dev)
>>>   
>>>   		rpdev->ept = ept;
>>>   		rpdev->src = ept->addr;
>>> +
>>> +		if (rpdrv->signals)
> seems an useless check

Some rpmsg cleints may not want to deal with flow control and not 
provide signal callback.

In such case this check is needed.

>>> +			ept->sig_cb = rpdrv->signals;
>>>   	}
>>>   
>>>   	err = rpdrv->probe(rpdev);
>>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>>> index b1245d3..35c2197 100644
>>> --- a/drivers/rpmsg/rpmsg_internal.h
>>> +++ b/drivers/rpmsg/rpmsg_internal.h
>>> @@ -53,6 +53,7 @@ struct rpmsg_device_ops {
>>>    * @trysendto:		see @rpmsg_trysendto(), optional
>>>    * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>>>    * @poll:		see @rpmsg_poll(), optional
>>> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>>>    * @get_mtu:		see @rpmsg_get_mtu(), optional
>>>    *
>>>    * Indirection table for the operations that a rpmsg backend should implement.
>>> @@ -73,6 +74,7 @@ struct rpmsg_endpoint_ops {
>>>   			     void *data, int len);
>>>   	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>>   			     poll_table *wait);
>>> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>>>   	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>>   };
>>>   
>>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>> index 02fa911..06d090c 100644
>>> --- a/include/linux/rpmsg.h
>>> +++ b/include/linux/rpmsg.h
>>> @@ -62,12 +62,14 @@ struct rpmsg_device {
>>>   };
>>>   
>>>   typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>>> +typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32);
>> This callback however, is still using the original low level tty
>> signals.
>>
>> Is there any reason why this can't be "rpmsg_flowcontrol_cb_t" and take
>> a boolean, so we get a clean interface in both directions?
>>
>> Regards,
>> Bjorn
>>
>>>   
>>>   /**
>>>    * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>>    * @rpdev: rpmsg channel device
>>>    * @refcount: when this drops to zero, the ept is deallocated
>>>    * @cb: rx callback handler
>>> + * @sig_cb: rx serial signal handler
> Is it signaling for reception or transmission?
Remote is signalling for transmission.
>
> Regards,
> Arnaud
>
>>>    * @cb_lock: must be taken before accessing/changing @cb
>>>    * @addr: local rpmsg address
>>>    * @priv: private data for the driver's use
>>> @@ -90,6 +92,7 @@ struct rpmsg_endpoint {
>>>   	struct rpmsg_device *rpdev;
>>>   	struct kref refcount;
>>>   	rpmsg_rx_cb_t cb;
>>> +	rpmsg_rx_sig_t sig_cb;
>>>   	struct mutex cb_lock;
>>>   	u32 addr;
>>>   	void *priv;
>>> @@ -111,6 +114,7 @@ struct rpmsg_driver {
>>>   	int (*probe)(struct rpmsg_device *dev);
>>>   	void (*remove)(struct rpmsg_device *dev);
>>>   	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>>> +	int (*signals)(struct rpmsg_device *rpdev, void *priv, u32);
>>>   };
>>>   
>>>   static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
>>> @@ -188,6 +192,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>>   
>>>   ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>>   
>>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
>>> +
>>>   #else
>>>   
>>>   static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
>>> @@ -306,6 +312,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>>   	return -ENXIO;
>>>   }
>>>   
>>> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>>> +{
>>> +	/* This shouldn't be possible */
>>> +	WARN_ON(1);
>>> +
>>> +	return -ENXIO;
>>> +}
>>> +
>>>   #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>>   
>>>   /* use a macro to avoid include chaining to get THIS_MODULE */
>>> -- 
>>> 2.7.4
>>>
