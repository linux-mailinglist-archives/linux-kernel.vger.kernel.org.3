Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90F4A41FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359400AbiAaLHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:07:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359079AbiAaLET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:04:19 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VA61OG002323;
        Mon, 31 Jan 2022 11:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eFFMc5DjiuwaV9gYIC6UK8uxvUC7vTZdT1G0rrIY8pM=;
 b=HoLI8NFsKWagS/01QZtDViFQZ00SEXVleeH8EwlfDKzLpktHYPyqSe3Jj7s2iFXc3Q/n
 PtQs0HXM1GEOl9jbBvAL2DkWUNNFML7e0e3T4ZZdMwvkVV5WJK+VPakpOLYhUJ35oVED
 1Z0yFmLGab/OoJFvSZB8yCjV4Xnz1jm2/p/RXKEbUigRLmxzuCJzytXvpwDq63LSDAuT
 1KiHJv5qL6W7Okyr2/luyj7iK6b/r1nehZ9CYvQQ9ojmbsoe1fc1i0iSUtGC1i6oyrD7
 FYR3bdFcAZ4+4MgfAMofgRW2x2EvzEkybliiVzDgIGSF8K1BKut9qXd9ksZX4WFESflZ cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dx5a6rxkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 11:04:18 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VB1phO018943;
        Mon, 31 Jan 2022 11:04:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dx5a6rxjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 11:04:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VB2JWd004607;
        Mon, 31 Jan 2022 11:04:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvuj2jsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 11:04:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VB4B6v40042892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 11:04:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7157A405F;
        Mon, 31 Jan 2022 11:04:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67633A4055;
        Mon, 31 Jan 2022 11:04:11 +0000 (GMT)
Received: from funtu.home (unknown [9.145.167.91])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 11:04:11 +0000 (GMT)
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
 <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
 <08458083-5716-0a3b-a4bc-36fc6c136836@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <41ff1149-5fa8-93f5-8c84-a68d9559d7dc@linux.ibm.com>
Date:   Mon, 31 Jan 2022 12:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <08458083-5716-0a3b-a4bc-36fc6c136836@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EGCbYsmYVBiSFykD6HKCLKPhLzUwKZHo
X-Proofpoint-GUID: nRU8l4in2XrJbPpFUjh5kZcJRhKQK5LM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_04,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 15:23, Tony Krowiak wrote:
>
>
> On 12/2/21 03:33, Harald Freudenberger wrote:
>> On 02.12.21 08:13, Thomas Huth wrote:
>>> On 01/12/2021 18.10, Harald Freudenberger wrote:
>>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>>> itself. With this change, the vfio_ap module now gets automatically
>>>>> loaded if a supported crypto adapter is available in the host.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>>          please review carefully!
>>>>>
>>>>>    drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>>        { /* end of sibling */ },
>>>>>    };
>>>>>    -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>>      /**
>>>>>     * vfio_ap_queue_dev_probe:
>>>> Hello Thomas, interesting.
>>>> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
>>> Yes, I've tested it. Without the patch, the vfio_ap module does not get loaded automatically if a crypto card is available. With the patch applied, the vfio_ap module correctly gets loaded automatically on my system (similar to the vfio_ccw module).
>>>
>>>> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
>>>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>>> This is only about getting the module loaded automatically once such a device is available ... AFAIK it does not grab any of the devices automatically, so there shouldn't be any problems?
>>>
>>>   Thomas
>>>
>> Yes, of course for the automatic module load works this way. But you understand that now
>> the vfio devices are childs of the ap bus and thus are siblings of the ap queue and ap card
>> devices. As I wrote the ap bus code is not prepared to deal with a 3th type of devices
>> dangling on the ap bus. So you should test what happens when there are real vfio ap devices
>> in use together with 'regular' ap card and queue devices.
>>
>> However, I am still not sure if it is preferable to have the vfio ap module loaded automatically. The majority
>> of customers will never use vfio ap devices - this is specific to kvm hosts only. I think this has to be
>> decided by Tony and maybe some kvm architect. If there is an agreement, I will try to rework the
>> ap code to be able to deal with foreign devices attached to the ap bus.
>
> Can you please explain how foreign devices can get attached to the bus if the vfio_ap device
> driver is automatically loaded because the MODULE_DEVICE_TABLE specification is changed?
Hello Tony,
I think this is not a question to me ? Of course you are right that when the vfio_ap is
automatically loaded there is no change for other 'alternative' device drivers. However, as of now
there exist only two parties here - the 'default' device driver(s) and the vfio_ap dd and as we do
not officially support out-of-tree builds there is nothing to see in the kernel about a third party dd.
>
> Regards,
> Tony Krowiak
>
>>
>> So thanks for your investigations. Let's wait for Tony and see how we proceed.
>>
>> Harald
>> Harald
>
