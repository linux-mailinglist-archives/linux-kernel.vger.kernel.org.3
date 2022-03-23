Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909DE4E534B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbiCWNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbiCWNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:40:16 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859A65E14E;
        Wed, 23 Mar 2022 06:38:46 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22NCxj3F022015;
        Wed, 23 Mar 2022 14:38:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=P7ZqFBQaQQZDZswUVGm+4mgYq4ZngDZt4zwx6qLPUs8=;
 b=wVTyWBtqdwAlPMTCprb3bpmnHUxFRq9uaDlWUGKV6FhQIMBJvBzuPG7J132KlWT3oJe8
 gWBNSeuSYZ4yTftO3xR7rUnW04akAm0OgT56OoiV8mkhZD9r8jpMXziS1VKulcLvAJt3
 vegfAiSNucFcDO3amXIvxzQc46lSamuWNL/vrw2heCi9IovOQSfmNgdAH4lMv5ZkEOfs
 dsaI7XHflf57fny4bTkb0y1jFKvPZD1j5rd/EFsZ/YSfvDh+oPN2U6ip+oohx1I8ek7Y
 9WhIvKXwIZE4jbObYunHgmJqRztNu3KfL82yhLZKNc5+BBhVPjRVDKycwOBvcF84tjix TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ewr5fyu3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 14:38:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11B7D10002A;
        Wed, 23 Mar 2022 14:38:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 091FB22FA37;
        Wed, 23 Mar 2022 14:38:38 +0100 (CET)
Received: from [10.201.20.246] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Mar
 2022 14:38:37 +0100
Message-ID: <e04ac97e-51bf-7470-5265-ce55119e1ba9@foss.st.com>
Date:   Wed, 23 Mar 2022 14:38:36 +0100
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
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1642534993-6552-4-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 20:43, Deepak Kumar Singh wrote:
> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
> to get/set the low level transport signals.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 47 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b5907b8..c03a118 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -19,6 +19,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -74,6 +75,9 @@ struct rpmsg_eptdev {
>  	spinlock_t queue_lock;
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
> +
> +	u32 rsigs;
> +	bool sig_pending;
>  };
>  
>  static int rpmsg_eptdev_destroy(struct device *dev, void *data)
> @@ -112,7 +116,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	skb_queue_tail(&eptdev->queue, skb);
>  	spin_unlock(&eptdev->queue_lock);
>  
> -	/* wake up any blocking processes, waiting for new data */
> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return 0;
> +}
> +
> +static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv, u32 sigs)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	eptdev->rsigs = sigs;
> +	eptdev->sig_pending = true;
> +
>  	wake_up_interruptible(&eptdev->readq);

Regarding the Glink code, the callback is used to be informed that the remote
is ready to send (DSR) and to receive (CTS or DSR)
So I suppose that the transmission should also be conditioned by the sig_pending

That said tell me if I'm wrong but look to me that what is implemented here is the 
 hardware flow control already managed by the TTY interface. What about using the
TTY interface in this case?

And What about using the "software flow control" instead? [1]

[1] https://en.wikipedia.org/wiki/Software_flow_control

>  
>  	return 0;
> @@ -137,6 +152,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->sig_cb = rpmsg_sigs_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  
> @@ -155,6 +171,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->sig_pending = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -265,6 +282,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->sig_pending)
> +		mask |= EPOLLPRI;
> +
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  
>  	return mask;
> @@ -274,11 +294,30 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  			       unsigned long arg)
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
> +	bool set;
> +	u32 val;
> +	int ret;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> +	switch (cmd) {
> +	case TIOCMGET:
> +		eptdev->sig_pending = false;
> +		ret = put_user(eptdev->rsigs, (int __user *)arg);
> +		break;
> +	case TIOCMSET:
> +		ret = get_user(val, (int __user *)arg);
> +		if (ret)
> +			break;
> +		set = (val & TIOCM_DTR) ? true : false;
> +		ret = rpmsg_set_flow_control(eptdev->ept, set);
> +		break;

Could this directly be handled by the driver on open close?
If application wants to suspend the link it could just close de /dev/rpmsgX.
 
Regards,
Arnaud

> +	case RPMSG_DESTROY_EPT_IOCTL:
> +		ret = rpmsg_eptdev_destroy(&eptdev->dev, NULL);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
>  
> -	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
> +	return ret;
>  }
>  
>  static const struct file_operations rpmsg_eptdev_fops = {
