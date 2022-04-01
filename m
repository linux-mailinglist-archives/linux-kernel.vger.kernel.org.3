Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143894EEE94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiDAN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiDAN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:56:34 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6098D1DC999;
        Fri,  1 Apr 2022 06:54:44 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231Dh76F018661;
        Fri, 1 Apr 2022 15:54:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=l6RBa/DTy1sl3A0VF3fpluhGbw+QWxvtQ/lrDdRp7iI=;
 b=RN/MOb/JLWKhufn8/koOD+6i1uR8RfNhoYRpe155WUWMhYrKzo389RICGnpcFKr/jMnL
 85f7OQWb+sqvAeQJqovgM17quQRqzROYqN+kiQtmgtWbSCOUHKXJJH/XNGKEMxhprEeB
 INHU+75RwXSfpYYf8P2bOVtkC5cXLF+payHBo/hokvmTX2cykm2+/DCz0YKLEyiza6yc
 c2sXYRYbevhwefgut1a9PxJZyaEtJimS1NFjtroQ0UoODHBVqO0lr+wV7SSca73NU5nj
 DQTW2CGJDe6nkmf8kfMkCPQcJ2FrovWjoAVTRnb2N495EmiygLUcRBYWX7PxVbxry/9p Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f1s4pvqbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 15:54:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A887210002A;
        Fri,  1 Apr 2022 15:54:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E63B22FA24;
        Fri,  1 Apr 2022 15:54:35 +0200 (CEST)
Received: from [10.211.9.74] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 1 Apr
 2022 15:54:34 +0200
Message-ID: <2740dcf9-a455-c9a0-d780-e3ff62b2894c@foss.st.com>
Date:   Fri, 1 Apr 2022 15:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-4-git-send-email-quic_deesin@quicinc.com>
 <e04ac97e-51bf-7470-5265-ce55119e1ba9@foss.st.com>
 <33334ab5-1dff-b637-17c1-2a92f209b6d6@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <33334ab5-1dff-b637-17c1-2a92f209b6d6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/22 14:25, Deepak Kumar Singh wrote:
> 
> On 3/23/2022 7:08 PM, Arnaud POULIQUEN wrote:
>>
>> On 1/18/22 20:43, Deepak Kumar Singh wrote:
>>> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
>>> to get/set the low level transport signals.
>>>
>>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>> ---
>>>   drivers/rpmsg/rpmsg_char.c | 47
>>> ++++++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 43 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
>>> index b5907b8..c03a118 100644
>>> --- a/drivers/rpmsg/rpmsg_char.c
>>> +++ b/drivers/rpmsg/rpmsg_char.c
>>> @@ -19,6 +19,7 @@
>>>   #include <linux/rpmsg.h>
>>>   #include <linux/skbuff.h>
>>>   #include <linux/slab.h>
>>> +#include <linux/termios.h>
>>>   #include <linux/uaccess.h>
>>>   #include <uapi/linux/rpmsg.h>
>>>   @@ -74,6 +75,9 @@ struct rpmsg_eptdev {
>>>       spinlock_t queue_lock;
>>>       struct sk_buff_head queue;
>>>       wait_queue_head_t readq;
>>> +
>>> +    u32 rsigs;
>>> +    bool sig_pending;
>>>   };
>>>     static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>>> @@ -112,7 +116,18 @@ static int rpmsg_ept_cb(struct rpmsg_device
>>> *rpdev, void *buf, int len,
>>>       skb_queue_tail(&eptdev->queue, skb);
>>>       spin_unlock(&eptdev->queue_lock);
>>>   -    /* wake up any blocking processes, waiting for new data */
>>> +    wake_up_interruptible(&eptdev->readq);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv, u32
>>> sigs)
>>> +{
>>> +    struct rpmsg_eptdev *eptdev = priv;
>>> +
>>> +    eptdev->rsigs = sigs;
>>> +    eptdev->sig_pending = true;
>>> +
>>>       wake_up_interruptible(&eptdev->readq);
>> Regarding the Glink code, the callback is used to be informed that the
>> remote
>> is ready to send (DSR) and to receive (CTS or DSR)
>> So I suppose that the transmission should also be conditioned by the
>> sig_pending
> 
> I think client need to get signal value before starting transmission, so
> that it knows that
> 
> it good to transmit data. Also it is not be enforced for every client.
> Some clients may not require
> 
> to use signalling/flow control.
> 
>>
>> That said tell me if I'm wrong but look to me that what is implemented
>> here is the
>>   hardware flow control already managed by the TTY interface. What
>> about using the
>> TTY interface in this case?
> 
> Correct. But some clients are using rpmsg char driver directly and don't
> go through tty interface.
> 
> So we are incorporating tty like interface here(flow control).

This is the point I would like to highlight to be sure that it is the
good direction.

From my windows I would say if application wants a basic link it uses
the rpmsg_char, if it wants more complex link with TIOCMGET and 
TIOCMSET signaling it should migrate on rmsg tty as the link is now
available (so implementing signaling in rpmsg_tty instead of rpmsg char).

Anyway here I only share my opinion. It is not my role to give the direction.

> 
>> And What about using the "software flow control" instead? [1]
>>
>> [1] https://en.wikipedia.org/wiki/Software_flow_control
>>
>>>         return 0;
>>> @@ -137,6 +152,7 @@ static int rpmsg_eptdev_open(struct inode *inode,
>>> struct file *filp)
>>>           return -EINVAL;
>>>       }
>>>   +    ept->sig_cb = rpmsg_sigs_cb;
>>>       eptdev->ept = ept;
>>>       filp->private_data = eptdev;
>>>   @@ -155,6 +171,7 @@ static int rpmsg_eptdev_release(struct inode
>>> *inode, struct file *filp)
>>>           eptdev->ept = NULL;
>>>       }
>>>       mutex_unlock(&eptdev->ept_lock);
>>> +    eptdev->sig_pending = false;
>>>         /* Discard all SKBs */
>>>       skb_queue_purge(&eptdev->queue);
>>> @@ -265,6 +282,9 @@ static __poll_t rpmsg_eptdev_poll(struct file
>>> *filp, poll_table *wait)
>>>       if (!skb_queue_empty(&eptdev->queue))
>>>           mask |= EPOLLIN | EPOLLRDNORM;
>>>   +    if (eptdev->sig_pending)
>>> +        mask |= EPOLLPRI;
>>> +
>>>       mask |= rpmsg_poll(eptdev->ept, filp, wait);
>>>         return mask;
>>> @@ -274,11 +294,30 @@ static long rpmsg_eptdev_ioctl(struct file *fp,
>>> unsigned int cmd,
>>>                      unsigned long arg)
>>>   {
>>>       struct rpmsg_eptdev *eptdev = fp->private_data;
>>> +    bool set;
>>> +    u32 val;
>>> +    int ret;
>>>   -    if (cmd != RPMSG_DESTROY_EPT_IOCTL)
>>> -        return -EINVAL;
>>> +    switch (cmd) {
>>> +    case TIOCMGET:
>>> +        eptdev->sig_pending = false;
>>> +        ret = put_user(eptdev->rsigs, (int __user *)arg);
>>> +        break;
>>> +    case TIOCMSET:
>>> +        ret = get_user(val, (int __user *)arg);
>>> +        if (ret)
>>> +            break;
>>> +        set = (val & TIOCM_DTR) ? true : false;
>>> +        ret = rpmsg_set_flow_control(eptdev->ept, set);
>>> +        break;
>> Could this directly be handled by the driver on open close?
>> If application wants to suspend the link it could just close de
>> /dev/rpmsgX.
> All clients may not require setting flow control.

Agree, but this could be conditioned by rpdrv->signals, right?
And this could avoid to expose controls 
- in open/close the rpmsg_set_flow_control would be called,
- in rpmsg_eptdev_write_iter an error would be returned ( or 0)
  if remote side has suspended the transmission.

But perhaps you need more that a ON/OFF flow control?

Regards,
Arnaud

>>   Regards,
>> Arnaud
>>
>>> +    case RPMSG_DESTROY_EPT_IOCTL:
>>> +        ret = rpmsg_eptdev_destroy(&eptdev->dev, NULL);
>>> +        break;
>>> +    default:
>>> +        ret = -EINVAL;
>>> +    }
>>>   -    return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
>>> +    return ret;
>>>   }
>>>     static const struct file_operations rpmsg_eptdev_fops = {
