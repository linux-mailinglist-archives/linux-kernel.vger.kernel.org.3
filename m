Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6874E50C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbiCWK7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiCWK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:59:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5378925;
        Wed, 23 Mar 2022 03:57:44 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22N9Gq6c029260;
        Wed, 23 Mar 2022 11:57:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WCVSJNz4FKwo1y85lq01vI5ZuAMhAuljc4SWrnPI9fU=;
 b=4vXcp4Jcv59ZKnUoy7vYxvgbeoMbRanec7ebfN2fVbeFNRECJKgVN3Z3SlsJ8YwYkCl7
 AUOyVo2Y1GXdqcNnZaUYbI1h3lCruHjsx7xQAtUAtFCr/DheSSj0EV1ibbpQsNMnl2yw
 PZ5FQXk5cewQvW6l2wAS2mTdmoZrxq2xXi+H7r4L4tC+j92QpqlGgKVEXcSBkJgjR7j/
 Xepn/x2o3ewK0l8LQevOC7/60KxjKd0ww6zr9PKBBZh0w99vEj/wEp90yV3HFWYHhlbk
 AON5bc8tXOm6v/OZROOdpaLj05r2AvsI9bsVzeuVLBHzmHAaWG1sZrwe9JvygZXRqhf3 8A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ew7d4fgfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:57:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C287310002A;
        Wed, 23 Mar 2022 11:57:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA5ED2248D6;
        Wed, 23 Mar 2022 11:57:34 +0100 (CET)
Received: from [10.201.20.246] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Mar
 2022 11:57:34 +0100
Message-ID: <9be3d491-4fdc-4aa6-8176-23a2cf3773ca@foss.st.com>
Date:   Wed, 23 Mar 2022 11:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH V2 1/3] rpmsg: core: Add signal API support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
CC:     <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
 <Yiu7DPHDY3uwcnLK@builder.lan>
Content-Language: en-US
In-Reply-To: <Yiu7DPHDY3uwcnLK@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_06,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/22 22:11, Bjorn Andersson wrote:
> On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:
> 
>> Some transports like Glink support the state notifications between
>> clients using signals similar to serial protocol signals.
>> Local glink client drivers can send and receive signals to glink
>> clients running on remote processors.
>>
>> Add APIs to support sending and receiving of signals by rpmsg clients.
>>
>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>> ---
>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>  include/linux/rpmsg.h          | 14 ++++++++++++++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index d3eb600..6712418 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -328,6 +328,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>  
>>  /**
>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>> + * @ept:	the rpmsg endpoint
>> + * @enable:	enable or disable serial flow control
>> + *
>> + * Return: 0 on success and an appropriate error value on failure.
>> + */
>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> 
> This API looks nice and clean and deals with flow control.

seems to me ambiguous API... what does it means flow control enable? Does it means that the flow control is enable or that the the local
endpoint is ready to receive?

Could we consider here that it is more a bind/unbind of the endpoint?

> 
>> +{
>> +	if (WARN_ON(!ept))
>> +		return -EINVAL;
>> +	if (!ept->ops->set_flow_control)
>> +		return -ENXIO;
>> +
>> +	return ept->ops->set_flow_control(ept, enable);
>> +}
>> +EXPORT_SYMBOL(rpmsg_set_flow_control);
>> +
>> +/**
>>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>>   * @ept: the rpmsg endpoint
>>   *
>> @@ -535,6 +553,9 @@ static int rpmsg_dev_probe(struct device *dev)
>>  
>>  		rpdev->ept = ept;
>>  		rpdev->src = ept->addr;
>> +
>> +		if (rpdrv->signals)

seems an useless check

>> +			ept->sig_cb = rpdrv->signals;
>>  	}
>>  
>>  	err = rpdrv->probe(rpdev);
>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>> index b1245d3..35c2197 100644
>> --- a/drivers/rpmsg/rpmsg_internal.h
>> +++ b/drivers/rpmsg/rpmsg_internal.h
>> @@ -53,6 +53,7 @@ struct rpmsg_device_ops {
>>   * @trysendto:		see @rpmsg_trysendto(), optional
>>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>>   * @poll:		see @rpmsg_poll(), optional
>> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>>   *
>>   * Indirection table for the operations that a rpmsg backend should implement.
>> @@ -73,6 +74,7 @@ struct rpmsg_endpoint_ops {
>>  			     void *data, int len);
>>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>  			     poll_table *wait);
>> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>>  };
>>  
>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>> index 02fa911..06d090c 100644
>> --- a/include/linux/rpmsg.h
>> +++ b/include/linux/rpmsg.h
>> @@ -62,12 +62,14 @@ struct rpmsg_device {
>>  };
>>  
>>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>> +typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32);
> 
> This callback however, is still using the original low level tty
> signals.
> 
> Is there any reason why this can't be "rpmsg_flowcontrol_cb_t" and take
> a boolean, so we get a clean interface in both directions?
> 
> Regards,
> Bjorn
> 
>>  
>>  /**
>>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>>   * @rpdev: rpmsg channel device
>>   * @refcount: when this drops to zero, the ept is deallocated
>>   * @cb: rx callback handler
>> + * @sig_cb: rx serial signal handler

Is it signaling for reception or transmission?

Regards,
Arnaud

>>   * @cb_lock: must be taken before accessing/changing @cb
>>   * @addr: local rpmsg address
>>   * @priv: private data for the driver's use
>> @@ -90,6 +92,7 @@ struct rpmsg_endpoint {
>>  	struct rpmsg_device *rpdev;
>>  	struct kref refcount;
>>  	rpmsg_rx_cb_t cb;
>> +	rpmsg_rx_sig_t sig_cb;
>>  	struct mutex cb_lock;
>>  	u32 addr;
>>  	void *priv;
>> @@ -111,6 +114,7 @@ struct rpmsg_driver {
>>  	int (*probe)(struct rpmsg_device *dev);
>>  	void (*remove)(struct rpmsg_device *dev);
>>  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
>> +	int (*signals)(struct rpmsg_device *rpdev, void *priv, u32);
>>  };
>>  
>>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
>> @@ -188,6 +192,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>  
>>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>  
>> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
>> +
>>  #else
>>  
>>  static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
>> @@ -306,6 +312,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>  	return -ENXIO;
>>  }
>>  
>> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return -ENXIO;
>> +}
>> +
>>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>  
>>  /* use a macro to avoid include chaining to get THIS_MODULE */
>> -- 
>> 2.7.4
>>
