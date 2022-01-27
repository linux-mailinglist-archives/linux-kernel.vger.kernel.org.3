Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A649E489
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiA0OYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:24:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230206AbiA0OX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:23:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RDLZh1001287;
        Thu, 27 Jan 2022 14:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tTd+bUbD8ZG1TDXENwlvFmpXV6HT9LyqDQaZcjSEKPg=;
 b=V9kW1LV5h9XEODNLrNANrc1pvnprEvm9+FnBebFKMQons3/o60adll3MoBeHIPtluACu
 2SeLTxtEzw2K+ejlu8LF0qhMHSnVnjgIGG/AfNojKLhXqtmTDditSCsOaBYzggs1vFYm
 rzEjLD5/D0Q5bGSm3MOZV3nWCTglq8rnqd3+xiPUwxKj+OtqTxO4RrHg8DEWFCZHHZWe
 z2L3KZmlMtJYHB7WZdy7IilUZtXFVKx+Y7ENmrxf9Tk5OBmlUlxin03TDo+aipi3GIeh
 5FYXOODWrGQSM01uCYbR7DqrfyA48o1sVMwGtGmDRCYExz0vOqgb1YuPvQIK5wkQD08Z gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duta8v0yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:23:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REMGt4008745;
        Thu, 27 Jan 2022 14:23:58 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duta8v0y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:23:58 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20REDL4p005628;
        Thu, 27 Jan 2022 14:23:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3dr9jc42e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:23:57 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RENt6s45285648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:23:55 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E148E2806F;
        Thu, 27 Jan 2022 14:23:54 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D59B42805E;
        Thu, 27 Jan 2022 14:23:53 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:23:53 +0000 (GMT)
Message-ID: <08458083-5716-0a3b-a4bc-36fc6c136836@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:23:53 -0500
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
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
 <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DB6V-E_6Uuz6m65WUFqy0TW4bFND9B9v
X-Proofpoint-ORIG-GUID: yMD6N5tbM0QWVcU1Ex-SZ78wg3ZESv54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/21 03:33, Harald Freudenberger wrote:
> On 02.12.21 08:13, Thomas Huth wrote:
>> On 01/12/2021 18.10, Harald Freudenberger wrote:
>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>> itself. With this change, the vfio_ap module now gets automatically
>>>> loaded if a supported crypto adapter is available in the host.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>          please review carefully!
>>>>
>>>>    drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>        { /* end of sibling */ },
>>>>    };
>>>>    -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>      /**
>>>>     * vfio_ap_queue_dev_probe:
>>> Hello Thomas, interesting.
>>> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
>> Yes, I've tested it. Without the patch, the vfio_ap module does not get loaded automatically if a crypto card is available. With the patch applied, the vfio_ap module correctly gets loaded automatically on my system (similar to the vfio_ccw module).
>>
>>> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
>>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>> This is only about getting the module loaded automatically once such a device is available ... AFAIK it does not grab any of the devices automatically, so there shouldn't be any problems?
>>
>>   Thomas
>>
> Yes, of course for the automatic module load works this way. But you understand that now
> the vfio devices are childs of the ap bus and thus are siblings of the ap queue and ap card
> devices. As I wrote the ap bus code is not prepared to deal with a 3th type of devices
> dangling on the ap bus. So you should test what happens when there are real vfio ap devices
> in use together with 'regular' ap card and queue devices.
>
> However, I am still not sure if it is preferable to have the vfio ap module loaded automatically. The majority
> of customers will never use vfio ap devices - this is specific to kvm hosts only. I think this has to be
> decided by Tony and maybe some kvm architect. If there is an agreement, I will try to rework the
> ap code to be able to deal with foreign devices attached to the ap bus.

Can you please explain how foreign devices can get attached to the bus 
if the vfio_ap device
driver is automatically loaded because the MODULE_DEVICE_TABLE 
specification is changed?

Regards,
Tony Krowiak

>
> So thanks for your investigations. Let's wait for Tony and see how we proceed.
>
> Harald
> Harald

