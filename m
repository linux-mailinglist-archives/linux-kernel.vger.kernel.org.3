Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F15AF4B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIFTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIFTsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:48:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9388DC8;
        Tue,  6 Sep 2022 12:48:39 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JH1v0003042;
        Tue, 6 Sep 2022 19:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OujVUnVk+XFo1lwQ6hOBY2ejWHuVgo8Nja2nbuNrs+Y=;
 b=kRGhHHWro42WmadVLpkbqMoATZrqSHZ5ERgje5t6ft+CGClR6KqLQmB/jWyr30KJayVg
 hU47Fv/xJ5kEuedBTQ5LWOvASu/fe8Hz7AVv4nmbpY51DPSpYRbysYcKSv00pvrNPYuq
 ouow9tLOfIsvmIU+CGEmolMRyAtTjiKysGpNIRdrdPCaDd0joZ11TmnRMXLUgdRLWc5i
 K4BRZlIi5jj5+ki9OkJJClEdBKqDUIc4UOLyJY5+EoBlPRVeP7fkJoQ935g6biYXvgmL
 2Ed6+e52w16AgIVylZq0q55nKyptDfeBEwyZFP7PnJbhUIoR73SeZLG1nt22WggT6fBr dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jec7t0sfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:48:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286JI49C007696;
        Tue, 6 Sep 2022 19:48:23 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jec7t0sex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:48:23 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JZOr9009557;
        Tue, 6 Sep 2022 19:48:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9tuv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:48:22 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JmLHP66257302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:48:21 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D775AC05F;
        Tue,  6 Sep 2022 19:48:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12138AC059;
        Tue,  6 Sep 2022 19:48:21 +0000 (GMT)
Received: from [9.160.74.237] (unknown [9.160.74.237])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:48:20 +0000 (GMT)
Message-ID: <85280d48-4251-2811-b66d-092f4153fbb5@linux.ibm.com>
Date:   Tue, 6 Sep 2022 14:48:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup procedure
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
 <20220809211246.251006-2-eajames@linux.ibm.com>
 <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
 <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
 <CAHp75VfU26QZ7Z1ApzRcFPudgsQc7zWF5g0kwn7Jzk1htXaWng@mail.gmail.com>
 <20220820124915.5dd5b745@jic23-huawei>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220820124915.5dd5b745@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z1R8v4d-APcFHezH-Vaw1xMjvgw7wGyQ
X-Proofpoint-GUID: akQIzJwyKuoJW_lSwCdH3dALnWcWuCo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/22 06:49, Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 12:42:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Mon, Aug 15, 2022 at 4:42 PM Eddie James <eajames@linux.ibm.com> wrote:
>>> On 8/12/22 17:03, Andy Shevchenko wrote:
>>>> On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:
>> ...
>>
>>>>> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
>>>>> +       if (rc)
>>>>> +               return rc;
>>>>> +
>>>>> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
>>>>> +       if (rc)
>>>>> +               return rc;
>>>> This code already exists, but still want to ask, is it really
>>>> byte-registers here and not be16/le16 one? In such a case perhaps bulk
>>>> write can be used to reflect it better?
>>> The temperature and pressure regs are 24 bits big endian, and all the
>>> rest are 8 bits. I think the existing approach is best.
>> It doesn't look like you got what I was meaning... Or I misunderstood
>> what you said.
>>
>> The code above writes two byte values to two sequential registers
>> which make me think that they are 16-bit registers at offset 0x0e.
> Given they are undocumented, this is guessing territory.
> Probably best to just leave them as is.
> You could do a bulk write on an array though as that implies
> nothing about what's in the registers -just that they happen
> to be next to each other.


Indeed. Is it worth it to switch to bulk write for two 2-byte writes? 
I'm inclined to say no and will leave this as-is for v6, but if you 
think it is, I can switch it.


Thanks,

Eddie


>
>> ...
>>
>>>>> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
>>>>> +       if (rc)
>>>>> +               return rc;
>>>>> +
>>>>> +       return regmap_write(data->regmap, 0x0f, 0x00);
>> Ditto.
>>
