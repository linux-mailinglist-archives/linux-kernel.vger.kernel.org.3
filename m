Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724D4476E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhLPJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:50:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233262AbhLPJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:50:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG86P7J013806;
        Thu, 16 Dec 2021 09:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JbPsXl54FXdyg4smfHiBixXjHZE7k5011xnqD7ZZaVU=;
 b=HoYCLG/yMvY4SYSuIzQXjvsgeMZUuPI643PMfTk9BNhC0+TJ0aSVX/598UBe9BcRo6Ag
 xkcTE5iREA4CfyOlOl+lPYvOLcuTbvzzbUncIddafmGu5W/aXEzrW9vbt+cq4YTR6Sbw
 ZEzzWt/2fBdeh1ZryCH93XCFK8PJsgECfkxmFvVcUyCwWaFOt+e04gOo/IazCdv01q0z
 X2aE03AiOotnvkMsNB0sd1LXuRI5mlqzHPNG2I/nkc1OfQSFsSmRduvu0UDNdtOSABws
 vEHsF0RExlwp3eLInSyAhRAJt6qM46natefoNp7tWXzv73BUmD/UNGKYo/XX07tTt//T IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cype2xv7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:50:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG9S4tZ020622;
        Thu, 16 Dec 2021 09:50:19 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cype2xv6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:50:19 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG9fuYh007588;
        Thu, 16 Dec 2021 09:50:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3cy7sjmqy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:50:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG9oD5J42402122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 09:50:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DEEFAE055;
        Thu, 16 Dec 2021 09:50:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F25DFAE05F;
        Thu, 16 Dec 2021 09:50:12 +0000 (GMT)
Received: from funtu.home (unknown [9.145.34.221])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 09:50:12 +0000 (GMT)
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Message-ID: <80cf2be3-9b7e-896d-afc6-376b8f7f9414@linux.ibm.com>
Date:   Thu, 16 Dec 2021 10:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XSEp80BjZYp2Zlzv613zwkoZez_C5YnQ
X-Proofpoint-ORIG-GUID: XYoOi14riDT7cGOsPpAhn91Z5MjWT7ns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_03,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.21 16:44, Harald Freudenberger wrote:
> On 01.12.21 15:11, Thomas Huth wrote:
>> The crypto devices that we can use with the vfio_ap module are sitting
>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>> itself. With this change, the vfio_ap module now gets automatically
>> loaded if a supported crypto adapter is available in the host.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Note: Marked as "RFC" since I'm not 100% sure about it ...
>>        please review carefully!
>>
>>  drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 4d2556bc7fe5..5580e40608a4 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>  	{ /* end of sibling */ },
>>  };
>>  
>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>  
>>  /**
>>   * vfio_ap_queue_dev_probe:
> I had a chance to check this now.
> First I have to apologize about the dispute with vfio devices appearing on the ap bus.
> That's not the case with this patch. As Connie states the MODULE_DEVICE_TABLE() does not
> change the parent of a device and vfio_ap_drv is a driver for ap devices and thus
> belongs to the ap bus anyway.
> So what's left is that with this change the vfio_ap kernel module is automatically loaded
> when an ap device type 10-13 is recognized by the ap bus. So the intention of the patch
> is fulfilled.
> Yet another kernel module which may occupy memory but will never get used by most customers.
> This may not be a problem but I had a glance at the list of kernel modules loaded on my
> LPAR with and without the patch and the difference is:
> ...
> kvm                   512000  1 vfio_ap
> vfio_ap                28672  0
> ...
> So the vfio_ap module has a dependency to the biggest kernel module ever - kvm.
> Do I need to say something more?
>
> If this dependency is removed then I would not hesitate to accept this patch. However
> this is up to Tony as he is the maintainer of the vfio ap device driver.
>
>
I need to throw in another point: with building initrd with dracut the kernel module
dependencies are evaluated. As of now this means that the zcrypt device driver
zoo is required in case you need to have crypto support for an encrypted root or
data disk at boot time. With vfio ap driver dependency enforced as requirement
from the AP bus there also comes the dependency to the kvm kernel module.
So the kvm kernel module needs to be part of the initrd now. I am not sure if this
is desired.
