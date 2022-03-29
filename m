Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B94EAD18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiC2M1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiC2M1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:27:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9834D9C1;
        Tue, 29 Mar 2022 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648556747; x=1680092747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WVHkWJgk24fHhQG2ByXpzHy7k84pUFobXcMicFqNaFQ=;
  b=im9zYr9JrquBb/544c3KVZplUnAJsHX+lk0tzQX9e2NvwdEnwIQI3fC9
   u9PY1FwUo1hWCwdEg3MnyriCgK1IwmseQi3uf5kVEJR8zRWh11LwGvMyP
   MKo0bLmmZy5Ck6pRp8bhIvzb9vhZ482hFJnSQHfpG0nuPpI4boicUXJ/c
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 29 Mar 2022 05:25:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 05:25:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 05:25:46 -0700
Received: from [10.216.50.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 05:25:41 -0700
Message-ID: <33334ab5-1dff-b637-17c1-2a92f209b6d6@quicinc.com>
Date:   Tue, 29 Mar 2022 17:55:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-4-git-send-email-quic_deesin@quicinc.com>
 <e04ac97e-51bf-7470-5265-ce55119e1ba9@foss.st.com>
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <e04ac97e-51bf-7470-5265-ce55119e1ba9@foss.st.com>
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


On 3/23/2022 7:08 PM, Arnaud POULIQUEN wrote:
>
> On 1/18/22 20:43, Deepak Kumar Singh wrote:
>> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
>> to get/set the low level transport signals.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>> ---
>>   drivers/rpmsg/rpmsg_char.c | 47 ++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 43 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>> index b5907b8..c03a118 100644
>> --- a/drivers/rpmsg/rpmsg_char.c
>> +++ b/drivers/rpmsg/rpmsg_char.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/rpmsg.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/slab.h>
>> +#include <linux/termios.h>
>>   #include <linux/uaccess.h>
>>   #include <uapi/linux/rpmsg.h>
>>   
>> @@ -74,6 +75,9 @@ struct rpmsg_eptdev {
>>   	spinlock_t queue_lock;
>>   	struct sk_buff_head queue;
>>   	wait_queue_head_t readq;
>> +
>> +	u32 rsigs;
>> +	bool sig_pending;
>>   };
>>   
>>   static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>> @@ -112,7 +116,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>>   	skb_queue_tail(&eptdev->queue, skb);
>>   	spin_unlock(&eptdev->queue_lock);
>>   
>> -	/* wake up any blocking processes, waiting for new data */
>> +	wake_up_interruptible(&eptdev->readq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv, u32 sigs)
>> +{
>> +	struct rpmsg_eptdev *eptdev = priv;
>> +
>> +	eptdev->rsigs = sigs;
>> +	eptdev->sig_pending = true;
>> +
>>   	wake_up_interruptible(&eptdev->readq);
> Regarding the Glink code, the callback is used to be informed that the remote
> is ready to send (DSR) and to receive (CTS or DSR)
> So I suppose that the transmission should also be conditioned by the sig_pending

I think client need to get signal value before starting transmission, so 
that it knows that

it good to transmit data. Also it is not be enforced for every client. 
Some clients may not require

to use signalling/flow control.

>
> That said tell me if I'm wrong but look to me that what is implemented here is the
>   hardware flow control already managed by the TTY interface. What about using the
> TTY interface in this case?

Correct. But some clients are using rpmsg char driver directly and don't 
go through tty interface.

So we are incorporating tty like interface here(flow control).

> And What about using the "software flow control" instead? [1]
>
> [1] https://en.wikipedia.org/wiki/Software_flow_control
>
>>   
>>   	return 0;
>> @@ -137,6 +152,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>>   		return -EINVAL;
>>   	}
>>   
>> +	ept->sig_cb = rpmsg_sigs_cb;
>>   	eptdev->ept = ept;
>>   	filp->private_data = eptdev;
>>   
>> @@ -155,6 +171,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>>   		eptdev->ept = NULL;
>>   	}
>>   	mutex_unlock(&eptdev->ept_lock);
>> +	eptdev->sig_pending = false;
>>   
>>   	/* Discard all SKBs */
>>   	skb_queue_purge(&eptdev->queue);
>> @@ -265,6 +282,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>>   	if (!skb_queue_empty(&eptdev->queue))
>>   		mask |= EPOLLIN | EPOLLRDNORM;
>>   
>> +	if (eptdev->sig_pending)
>> +		mask |= EPOLLPRI;
>> +
>>   	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>>   
>>   	return mask;
>> @@ -274,11 +294,30 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>>   			       unsigned long arg)
>>   {
>>   	struct rpmsg_eptdev *eptdev = fp->private_data;
>> +	bool set;
>> +	u32 val;
>> +	int ret;
>>   
>> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
>> -		return -EINVAL;
>> +	switch (cmd) {
>> +	case TIOCMGET:
>> +		eptdev->sig_pending = false;
>> +		ret = put_user(eptdev->rsigs, (int __user *)arg);
>> +		break;
>> +	case TIOCMSET:
>> +		ret = get_user(val, (int __user *)arg);
>> +		if (ret)
>> +			break;
>> +		set = (val & TIOCM_DTR) ? true : false;
>> +		ret = rpmsg_set_flow_control(eptdev->ept, set);
>> +		break;
> Could this directly be handled by the driver on open close?
> If application wants to suspend the link it could just close de /dev/rpmsgX.
All clients may not require setting flow control.
>   
> Regards,
> Arnaud
>
>> +	case RPMSG_DESTROY_EPT_IOCTL:
>> +		ret = rpmsg_eptdev_destroy(&eptdev->dev, NULL);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>>   
>> -	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
>> +	return ret;
>>   }
>>   
>>   static const struct file_operations rpmsg_eptdev_fops = {
