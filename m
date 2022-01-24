Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDE4981DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiAXORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:17:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232833AbiAXORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:17:41 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OE920E001541;
        Mon, 24 Jan 2022 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Nw62k+FAGSdTVRnssM8mPgxjxGT4YA7v7qk+wWhXApE=;
 b=k5J11Zz/l0/V/YH0bx8kRtQf0dquMKuO+6+lxah08aUtJ3FYbB9xb2C6/U3W0ogC7Vl/
 qG4Cma++HzBb1z+7cJP1KOongBNfsAlXNYjBPLEFqOgyrFH8Z77kW/puJd3+ZmRz7ceI
 86EsWIlMMuSxJFAMT259kBFP8js5EcM8s3o7BMikU+/YC4cMMssGumAOanxbRhC3OSwb
 kNV4TaBAONBMS6bn3UDVOONKFuNS1DgTNR2ZdjUtsovE91xkaruLAMlvfYYUeNa5ZzGQ
 9PJbJWxCbafz+5W//2J8XQKFVOeP9lcBpfLn3+FsOLOJaStZQYPHdua4klShCWyMRc7G 4w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dsvdujdmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 14:17:31 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20OEEuNQ002674;
        Mon, 24 Jan 2022 14:17:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3dr9j9xev8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 14:17:30 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20OEHTG546072174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 14:17:29 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31CF52806D;
        Mon, 24 Jan 2022 14:17:29 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218B928071;
        Mon, 24 Jan 2022 14:17:28 +0000 (GMT)
Received: from [9.163.14.245] (unknown [9.163.14.245])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jan 2022 14:17:27 +0000 (GMT)
Message-ID: <4637aaa9-5a6f-dcd6-897f-d7b9de1f963a@linux.ibm.com>
Date:   Mon, 24 Jan 2022 08:17:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/2] fsi: sbefifo: Implement
 FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220121053816.82253-1-joel@jms.id.au>
 <20220121053816.82253-3-joel@jms.id.au>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220121053816.82253-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wm0HU9D8zKJrJdtRPEMZ0TknyamU0H9v
X-Proofpoint-ORIG-GUID: wm0HU9D8zKJrJdtRPEMZ0TknyamU0H9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_07,2022-01-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/22 23:38, Joel Stanley wrote:
> From: Amitay Isaacs <amitay@ozlabs.org>
>
> FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl sets the read timeout (in
> seconds) for the response received by sbefifo device from sbe.  The
> timeout affects only the read operation on current sbefifo device fd.
>
> Certain SBE operations can take long time to complete and the default
> timeout of 10 seconds might not be sufficient to start receiving
> response from SBE.  In such cases, allow the timeout to be set to the
> maximum of 120 seconds.
>
> The kernel does not contain the definition of the various SBE
> operations, so we must expose an interface to userspace to set the
> timeout for the given operation.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>    - Clarify why this is an ioctl and not hardcoded in the kernel
>    - Add seconds to the name
> ---
>   drivers/fsi/fsi-sbefifo.c | 49 +++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/fsi.h  | 14 +++++++++++
>   2 files changed, 63 insertions(+)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 1e9b326e8f67..f52a912cdf16 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -32,6 +32,8 @@
>   #include <linux/vmalloc.h>
>   #include <linux/mm.h>
>   
> +#include <uapi/linux/fsi.h>
> +
>   /*
>    * The SBEFIFO is a pipe-like FSI device for communicating with
>    * the self boot engine on POWER processors.
> @@ -134,6 +136,7 @@ struct sbefifo_user {
>   	void			*cmd_page;
>   	void			*pending_cmd;
>   	size_t			pending_len;
> +	u32			read_timeout_ms;
>   };
>   
>   static DEFINE_MUTEX(sbefifo_ffdc_mutex);
> @@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
>   		return -ENOMEM;
>   	}
>   	mutex_init(&user->file_lock);
> +	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>   
>   	return 0;
>   }
> @@ -838,7 +842,9 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>   	rc = mutex_lock_interruptible(&sbefifo->lock);
>   	if (rc)
>   		goto bail;
> +	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
>   	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
> +	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
>   	mutex_unlock(&sbefifo->lock);
>   	if (rc < 0)
>   		goto bail;
> @@ -928,12 +934,55 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
> +{
> +	struct device *dev = &user->sbefifo->dev;
> +	u32 timeout;
> +
> +	if (get_user(timeout, (__u32 __user *)argp))
> +		return -EFAULT;
> +
> +	if (timeout == 0) {
> +		user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
> +		dev_dbg(dev, "Timeout reset to %d\n", user->read_timeout_ms);
> +		return 0;
> +	}
> +
> +	if (timeout < 10 || timeout > 120)
> +		return -EINVAL;
> +
> +	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
> +
> +	dev_dbg(dev, "Timeout set to %d\n", user->read_timeout_ms);
> +
> +	return 0;
> +}
> +
> +static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct sbefifo_user *user = file->private_data;
> +	int rc = -ENOTTY;
> +
> +	if (!user)
> +		return -EINVAL;
> +
> +	mutex_lock(&user->file_lock);
> +	switch (cmd) {
> +	case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
> +		rc = sbefifo_read_timeout(user, (void __user *)arg);
> +		break;
> +	}
> +	mutex_unlock(&user->file_lock);
> +	return rc;
> +}
> +
>   static const struct file_operations sbefifo_fops = {
>   	.owner		= THIS_MODULE,
>   	.open		= sbefifo_user_open,
>   	.read		= sbefifo_user_read,
>   	.write		= sbefifo_user_write,
>   	.release	= sbefifo_user_release,
> +	.unlocked_ioctl = sbefifo_user_ioctl,
>   };
>   
>   static void sbefifo_free(struct device *dev)
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> index da577ecd90e7..b2f1977378c7 100644
> --- a/include/uapi/linux/fsi.h
> +++ b/include/uapi/linux/fsi.h
> @@ -55,4 +55,18 @@ struct scom_access {
>   #define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
>   #define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
>   
> +/*
> + * /dev/sbefifo* ioctl interface
> + */
> +
> +/**
> + * FSI_SBEFIFO_READ_TIMEOUT sets the read timeout for response from SBE.
> + *
> + * The read timeout is specified in seconds.  The minimum value of read
> + * timeout is 10 seconds (default) and the maximum value of read timeout is
> + * 120 seconds.  A read timeout of 0 will reset the value to the default of
> + * (10 seconds).
> + */
> +#define FSI_SBEFIFO_READ_TIMEOUT_SECONDS	_IOW('s', 0x00, __u32)
> +
>   #endif /* _UAPI_LINUX_FSI_H */
