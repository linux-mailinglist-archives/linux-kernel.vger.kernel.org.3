Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12752669F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382292AbiEMPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350196AbiEMPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520222A2C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:54:33 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEi9SN028977;
        Fri, 13 May 2022 15:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=b8RQHJW0m3s3UOCKbkvxy7uJD04emNvKnoSgR+uQPoI=;
 b=qiAnud6zJfXvzksMEJ8sb27tpti4OGwnlubzYJ6qzxfj82AJKoy3MguAf+EHepsyDj/L
 k/Dpf89UhSug+jvzu4oEyOxeVGNTs9k32zt7WC+aaXnzbwoT3HA37pHUYKMd+pqQmvE5
 tK2QMXsp1TpX4OoSF/B6Bbua8XszBFio+6RqAnEVOfRUvrhCzIcONvAH20nJkwyc2Lk3
 Z0fMC+T3iiQ0YcG0j0P6ARhvks5aqHVeNaQYeweyDfGMzN/TKs3X5KQwCw0v79gCtfeF
 7ouQrbVG+ehrELSS+VepAAu9y4ihg9IjSwdf/f+9fOUIJ65fZZzHRySVX1dCDHOZvW3I Sw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1sbu9epn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 15:54:12 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DFfuVM014678;
        Fri, 13 May 2022 15:54:11 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3fwgdabadj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 15:54:11 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DFsAKu35586330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 15:54:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA517BE056;
        Fri, 13 May 2022 15:54:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CF64BE051;
        Fri, 13 May 2022 15:54:10 +0000 (GMT)
Received: from [9.163.1.123] (unknown [9.163.1.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 15:54:10 +0000 (GMT)
Message-ID: <1ec5693f-827d-d840-3c8e-4f2ff220cd4f@linux.ibm.com>
Date:   Fri, 13 May 2022 10:54:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fsi: occ: Prevent use after free
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-fsi@lists.ozlabs.org
Cc:     alistair@popple.id.au, linux-kernel@vger.kernel.org
References: <20220512210034.59907-1-eajames@linux.ibm.com>
 <ad258449-ddc3-6bd5-0371-becac42e7d47@roeck-us.net>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <ad258449-ddc3-6bd5-0371-becac42e7d47@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s2qjJ0AFmd-Z4sGR0D5bUzlxxScv9D2S
X-Proofpoint-ORIG-GUID: s2qjJ0AFmd-Z4sGR0D5bUzlxxScv9D2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205130069
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/22 18:10, Guenter Roeck wrote:
> On 5/12/22 14:00, Eddie James wrote:
>> Use get_device and put_device in the open and close functions to
>> make sure the device doesn't get freed while a file descriptor is
>> open.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-occ.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>> index c9cc75fbdfb9..9e48dc62b1c5 100644
>> --- a/drivers/fsi/fsi-occ.c
>> +++ b/drivers/fsi/fsi-occ.c
>> @@ -82,6 +82,9 @@ static int occ_open(struct inode *inode, struct 
>> file *file)
>>       struct miscdevice *mdev = file->private_data;
>>       struct occ *occ = to_occ(mdev);
>>   +    if (!occ->buffer)
>> +        return -ENOENT;
>> +
>>       if (!client)
>>           return -ENOMEM;
>>   @@ -94,6 +97,7 @@ static int occ_open(struct inode *inode, struct 
>> file *file)
>>       client->occ = occ;
>>       mutex_init(&client->lock);
>>       file->private_data = client;
>> +    get_device(occ->dev);
>>         /* We allocate a 1-page buffer, make sure it all fits */
>>       BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
>> @@ -143,7 +147,7 @@ static ssize_t occ_write(struct file *file, const 
>> char __user *buf,
>>       ssize_t rc;
>>       u8 *cmd;
>>   -    if (!client)
>> +    if (!client || !client->occ->buffer)
>>           return -ENODEV;
>>         if (len > (OCC_CMD_DATA_BYTES + 3) || len < 3)
>> @@ -197,6 +201,7 @@ static int occ_release(struct inode *inode, 
>> struct file *file)
>>   {
>>       struct occ_client *client = file->private_data;
>>   +    put_device(client->occ->dev);
>>       free_page((unsigned long)client->buffer);
>>       kfree(client);
>>   @@ -672,6 +677,7 @@ static int occ_remove(struct platform_device 
>> *pdev)
>>       struct occ *occ = platform_get_drvdata(pdev);
>>         kvfree(occ->buffer);
>> +    occ->buffer = NULL;
>
> Isn't this slightly racy (there is no guarantee that occ->buffer is 
> updated
> by the time it is used by the write function, and there is no 
> synchronization
> across CPUs which ensures that the pointer is actually written to memory
> before it is used) ?


Yes, it is. And now that I think about it, there's nothing to prevent 
the driver remove (and freeing buffer) while a write is ongoing. 
Probably need to lock in the remove function...

Thanks

Eddie


>
> Thanks,
> Guenter
