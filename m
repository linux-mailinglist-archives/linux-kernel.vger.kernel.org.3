Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAF465F88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhLBIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:37:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhLBIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:37:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B28NeLQ012261;
        Thu, 2 Dec 2021 08:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JSw1RpWTXChr9A9l72eFaPr8PWH28Z/hs5t07unx3RQ=;
 b=OfKIpHd4RxKWvKaJ/M/YSXU/oDejO2BV14OM9uBYdj6aulKA8sS6UoFfc8Wy6wCRcdCS
 7rymx8dHxb7XZBe3epd5MMMIgp+5+lTHEEp2xs3zb3eMa+ktFBZAag2QJ0OwAHh7vL6W
 MOW5pY82ItHNA/o3OWx7rmjRGC6tA9q0y+aoyfODet6xtSWyMvnHPT2rSHawpvcyHB3q
 CzRtv/Y06Fd8UDOSVK1NArL9xmWl4mJZr3E+ytDYaYMvajyIxsYFJ8bYdYMQ8Bz+E/Us
 hvBaigvcd44Vz7vMNm6/LwJxbupZg8nWvAqyfbE4Q7PgzenbPFbX3jMzYJIEVqBdpSSE jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cptkjg569-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 08:33:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B28TXoV032156;
        Thu, 2 Dec 2021 08:33:49 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cptkjg55r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 08:33:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B28RPwh010812;
        Thu, 2 Dec 2021 08:33:46 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3cncgmp29g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 08:33:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B28XgE630802362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 08:33:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0ED211C052;
        Thu,  2 Dec 2021 08:33:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81F3511C054;
        Thu,  2 Dec 2021 08:33:42 +0000 (GMT)
Received: from funtu.home (unknown [9.145.89.163])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 08:33:42 +0000 (GMT)
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
Date:   Thu, 2 Dec 2021 09:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lGxWWwKFIG9j_O3iduTdGwi_8D_9e_HS
X-Proofpoint-ORIG-GUID: sckVxKvW2KnOAfMucdtHtSEzDkV0lmBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_05,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.21 08:13, Thomas Huth wrote:
> On 01/12/2021 18.10, Harald Freudenberger wrote:
>> On 01.12.21 15:11, Thomas Huth wrote:
>>> The crypto devices that we can use with the vfio_ap module are sitting
>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>> itself. With this change, the vfio_ap module now gets automatically
>>> loaded if a supported crypto adapter is available in the host.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>         please review carefully!
>>>
>>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 4d2556bc7fe5..5580e40608a4 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>       { /* end of sibling */ },
>>>   };
>>>   -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>     /**
>>>    * vfio_ap_queue_dev_probe:
>> Hello Thomas, interesting.
>> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
>
> Yes, I've tested it. Without the patch, the vfio_ap module does not get loaded automatically if a crypto card is available. With the patch applied, the vfio_ap module correctly gets loaded automatically on my system (similar to the vfio_ccw module).
>
>> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>
> This is only about getting the module loaded automatically once such a device is available ... AFAIK it does not grab any of the devices automatically, so there shouldn't be any problems?
>
>  Thomas
>
Yes, of course for the automatic module load works this way. But you understand that now
the vfio devices are childs of the ap bus and thus are siblings of the ap queue and ap card
devices. As I wrote the ap bus code is not prepared to deal with a 3th type of devices
dangling on the ap bus. So you should test what happens when there are real vfio ap devices
in use together with 'regular' ap card and queue devices.

However, I am still not sure if it is preferable to have the vfio ap module loaded automatically. The majority
of customers will never use vfio ap devices - this is specific to kvm hosts only. I think this has to be
decided by Tony and maybe some kvm architect. If there is an agreement, I will try to rework the
ap code to be able to deal with foreign devices attached to the ap bus.

So thanks for your investigations. Let's wait for Tony and see how we proceed.

Harald
Harald
