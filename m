Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB04149E4ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiA0OpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:45:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238029AbiA0OpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:45:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20REfrxL014725;
        Thu, 27 Jan 2022 14:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S4PHFsStqs6jc1R1kLaWoB62THZhh461DM7p5mOZGAk=;
 b=UtG7d7MigI5iqxSfvlxGi6DsUN81OR/c5cWtisbECdmtK2QgNccx61DptKZs0VbgkHKv
 pqCwaKCThRrJ1tDK39u/LUvxwDilp9K2QJYWokoyy2vDbAa9CfjmlkM008JelRJ0LYpK
 keSCqITGky8JaTqGHuUDyQ5rHSVqdSn+J0XOtac+S58QuLTrkKy1/JuEjt1cWBRDc1yH
 v/BdC2kWvjMQCEglFCVbiFGWPze5eioPftYH+GXRLr/p760kSXlSKBDW9GJwtm6XNyfs
 4F/Sd7FUehkQwDem9gbEspUtPo248j54NTwcSZ9Wd5dIwFFUMJETZJbid3pFoGeT9Vdd 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dupsusex6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:45:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REg6YT015753;
        Thu, 27 Jan 2022 14:45:07 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dupsusewm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:45:07 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20REhwIn019005;
        Thu, 27 Jan 2022 14:45:05 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3dr9jbccn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:45:05 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20REj3Vt31523270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:45:03 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C22C52805E;
        Thu, 27 Jan 2022 14:45:03 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA4928067;
        Thu, 27 Jan 2022 14:45:02 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:45:02 +0000 (GMT)
Message-ID: <6daa5b6f-889c-d4aa-2b85-d598a41078c0@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:45:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t54SqcES_eX9PGP6qrdNy-OiHvGDJ25_
X-Proofpoint-ORIG-GUID: V8XPk_t3TJnhAOi6Oz4oTX29tEMYHw_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/21 10:44, Harald Freudenberger wrote:
> On 01.12.21 15:11, Thomas Huth wrote:
>> The crypto devices that we can use with the vfio_ap module are sitting
>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>> itself. With this change, the vfio_ap module now gets automatically
>> loaded if a supported crypto adapter is available in the host.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>         please review carefully!
>>
>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 4d2556bc7fe5..5580e40608a4 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>   	{ /* end of sibling */ },
>>   };
>>   
>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>   
>>   /**
>>    * vfio_ap_queue_dev_probe:
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

Since the vfio_ccw module also needs the kvm module and is automatically 
loaded,
I see no problem with automatically loading the vfio_ap module. I tested 
this patch by
running all of my regression tests successfully.

>
>

