Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD853510223
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352516AbiDZPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiDZPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:49:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA23DAA2D;
        Tue, 26 Apr 2022 08:46:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDpEwB026493;
        Tue, 26 Apr 2022 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mf3sFz1Eoz8ROJ5TCrmx8c+AoE1hMK7ARee7GbxzADQ=;
 b=melq23NvjQOkzSLE4/ZAaL7xCzVE5Gy4jejFppyI6akdNqHirYv+v3IQ/pUG4GSy6mgw
 JuKa9NKYtUpN0PWraR4sLsi0Q59ydw4o0/dBFrOxUJag7TqMlCDDazraFn046EQWAyJh
 OcibWP2OyvLi6nkZgNYhHbF2yLu153L1uIOfYssSPppTqkXTQ45z8HQoQjT7Mv8EB2zK
 X/XfFM0Y3RoIXk9Hv6G6Vcf2DfT1rM4Ojef6OOdqgZaldaGeyqc+GHT2xkrRW5aD9vfM
 rRSHsNf/xwsTKOZJeTpmU/HsqbCdHaTGqOQhrJA3AGn3Oq8FWcsRZITcX7ffVczlarIv lA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpg73wbwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:46:09 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QFgRKM011630;
        Tue, 26 Apr 2022 15:46:08 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3fm939ufgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:46:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QFk7IQ16384360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:46:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B5D4BE05D;
        Tue, 26 Apr 2022 15:46:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B5DCBE05A;
        Tue, 26 Apr 2022 15:46:07 +0000 (GMT)
Received: from [9.211.82.59] (unknown [9.211.82.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 15:46:07 +0000 (GMT)
Message-ID: <1976e57f-d9b6-a6cb-3565-bab5aa9f215d@linux.ibm.com>
Date:   Tue, 26 Apr 2022 10:46:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] hwmon (occ): Retry for checksum failure
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Guenter Roeck'" <linux@roeck-us.net>
Cc:     "linux-fsi@lists.ozlabs.org" <linux-fsi@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "jk@ozlabs.org" <jk@ozlabs.org>,
        "alistair@popple.id.au" <alistair@popple.id.au>
References: <20220321153112.12199-1-eajames@linux.ibm.com>
 <20220321153112.12199-3-eajames@linux.ibm.com>
 <20220424171816.GA749761@roeck-us.net>
 <44d4f10249064a28b6cc461e7cbdd402@AcuMS.aculab.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <44d4f10249064a28b6cc461e7cbdd402@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LMhM0W2Zm58s3oMVFD8pqNOyql1HQDun
X-Proofpoint-ORIG-GUID: LMhM0W2Zm58s3oMVFD8pqNOyql1HQDun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_04,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260099
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/25/22 04:10, David Laight wrote:
> From: Guenter Roeck
>> Sent: 24 April 2022 18:18
>>
>> On Mon, Mar 21, 2022 at 10:31:12AM -0500, Eddie James wrote:
>>> Due to the OCC communication design with a shared SRAM area,
>>> checkum errors are expected due to corrupted buffer from OCC
>>> communications with other system components. Therefore, retry
>>> the command twice in the event of a checksum failure.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> I assume this will be applied together with patch 1 of the series.
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Guenter
>>
>>> ---
>>>   drivers/hwmon/occ/p9_sbe.c | 28 ++++++++++++++++++----------
>>>   1 file changed, 18 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
>>> index 49b13cc01073..7f4c3f979c54 100644
>>> --- a/drivers/hwmon/occ/p9_sbe.c
>>> +++ b/drivers/hwmon/occ/p9_sbe.c
>>> @@ -84,17 +84,25 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>>>   	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>>>   	size_t resp_len = sizeof(*resp);
>>>   	int rc;
>>> -
>>> -	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
>>> -	if (rc < 0) {
>>> -		if (resp_len) {
>>> -			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
>>> -				sysfs_notify(&occ->bus_dev->kobj, NULL,
>>> -					     bin_attr_ffdc.attr.name);
>>> +	int tries = 0;
>>> +
>>> +	do {
> Why not use a for() loop?
>
>>> +		rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
>>> +		if (rc < 0) {
>>> +			if (resp_len) {
>>> +				if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
>>> +					sysfs_notify(&occ->bus_dev->kobj, NULL,
>>> +						     bin_attr_ffdc.attr.name);
>>> +
>>> +				return rc;
>>> +			} else if (rc != -EBADE) {
>>> +				return rc;
>>> +			}
> No need for else after return.
>
>>> +			/* retry twice for checksum failures */
>>> +		} else {
>>> +			break;
> I'd break on the success path after testing (rc >= 0).
> Saves a level of indent.
>
>>>   		}
>>> -
>>> -		return rc;
>>> -	}
>>> +	} while (++tries < 3);
>>>
>>>   	switch (resp->return_status) {
>>>   	case OCC_RESP_CMD_IN_PRG:
> Probably end up with something like:
> 	for (tries = 0; tries < 3; tries++) {
> 		rc = ...;
> 		if (rc >= 0)
> 			break;
> 		if (resp_len) {
> 			...
> 			return rc;
> 		}
> 		if (rc != -EBADE)
> 			return rc;
> 	}
>
> 	David


Thanks David, Ack.


>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
