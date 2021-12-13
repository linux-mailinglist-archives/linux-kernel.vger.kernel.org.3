Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8084730CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhLMPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:45:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231132AbhLMPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:45:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEvNn5016322;
        Mon, 13 Dec 2021 15:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=efezFGCsVmMWMI6LOoOZsb+RpJlXl7CPy4/JkrqvAbg=;
 b=VadWO/0cj7w5VxIveTqkWu7I5YfB1TSolh6gMtxcHqPppe15/zdsZzVWr7pfhFsoE4Kn
 vo/ACYZN8nuhZZLhoWJfu9g1C405LbqgCxpjjv7clbE3lqrFa/c3JM5MfjwNTC9cpq2y
 6bbqSe0do6UbHF5X3Ls0dLuVt015D8gVDD7vUCLAtxWjR0yk/v55h+k5ihNDEQcO0+YO
 IoM+n2u+QL6KmdxtjNPf5vbvRN7APzyQLGlfaMXJetpHV4Zp1/c9OFa/N012lz2Tz3/X
 RRmsp+ghTgzdCqMP0oCFjLT57CFwV+g9IhRZuKIo0t8IvQvZTHml5t7bWRdLX1JsCvYH 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx8d3s6md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:45:45 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BDEwdmQ023643;
        Mon, 13 Dec 2021 15:45:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx8d3s6kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:45:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDFiD7p011121;
        Mon, 13 Dec 2021 15:45:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cvkm96hjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 15:45:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDFidNP30671352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:44:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99390A4068;
        Mon, 13 Dec 2021 15:44:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50342A4060;
        Mon, 13 Dec 2021 15:44:39 +0000 (GMT)
Received: from funtu.home (unknown [9.145.23.43])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 15:44:39 +0000 (GMT)
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Date:   Mon, 13 Dec 2021 16:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201141110.94636-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yhx-TFfzED5kzWwwjspyfmpUH91sQ3Ps
X-Proofpoint-GUID: yQfUo_N4xiXNGeqnmOy3EFhHkuJMEoyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_07,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112130099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.21 15:11, Thomas Huth wrote:
> The crypto devices that we can use with the vfio_ap module are sitting
> on the "ap" bus, not on the "vfio_ap" bus that the module defines
> itself. With this change, the vfio_ap module now gets automatically
> loaded if a supported crypto adapter is available in the host.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Marked as "RFC" since I'm not 100% sure about it ...
>        please review carefully!
>
>  drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 4d2556bc7fe5..5580e40608a4 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>  	{ /* end of sibling */ },
>  };
>  
> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>  
>  /**
>   * vfio_ap_queue_dev_probe:
I had a chance to check this now.
First I have to apologize about the dispute with vfio devices appearing on the ap bus.
That's not the case with this patch. As Connie states the MODULE_DEVICE_TABLE() does not
change the parent of a device and vfio_ap_drv is a driver for ap devices and thus
belongs to the ap bus anyway.
So what's left is that with this change the vfio_ap kernel module is automatically loaded
when an ap device type 10-13 is recognized by the ap bus. So the intention of the patch
is fulfilled.
Yet another kernel module which may occupy memory but will never get used by most customers.
This may not be a problem but I had a glance at the list of kernel modules loaded on my
LPAR with and without the patch and the difference is:
...
kvm                   512000  1 vfio_ap
vfio_ap                28672  0
...
So the vfio_ap module has a dependency to the biggest kernel module ever - kvm.
Do I need to say something more?

If this dependency is removed then I would not hesitate to accept this patch. However
this is up to Tony as he is the maintainer of the vfio ap device driver.


