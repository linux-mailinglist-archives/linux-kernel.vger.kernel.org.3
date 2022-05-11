Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B61E523DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347100AbiEKTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiEKTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:44:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3F21E41D;
        Wed, 11 May 2022 12:44:27 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BJNGFO009735;
        Wed, 11 May 2022 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e2wHKn6Qn2b1bomvQygUYZFisFcHyytkamBHKvP7Rqc=;
 b=bL0prk5o5ArR7IjAEIGluprVg8pqrkGx7m9k9XrAhtfEtiFGs3agslvRAAM+AG/AUxyU
 HNHgPbHukZayAPrzC9FLPzpnZZ2GsbVbKfM2XxQ/AaV08dzzGUeYLZVP97NOuwbaQ4HZ
 I3MjByfVkR6/xDVbkwqi9j7SWqjf/uCaH94bP1/iMk5c6OwS1Xot2y8/oN99GW+TMdF+
 V2hmllgPLTNZ9VC69N9EpSYmJOG2U6YUJizRlBbrAZdhGz3ZIluZasmTM9tNwQGxzwee
 KfJF8IsB9EQA5BvZQMGtw1Hl8V3+9Hn3GHoPPtmJc3xKD1ylVRxBj05k6Mtd40hW0yrX xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0ecbf0ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:44:16 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BJOTp6012341;
        Wed, 11 May 2022 19:44:15 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0ecbf0ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:44:15 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BJY0Su030948;
        Wed, 11 May 2022 19:44:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3fwgd9xfc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:44:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BJiEkm30212436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 19:44:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8007678066;
        Wed, 11 May 2022 19:44:14 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6ACE78060;
        Wed, 11 May 2022 19:44:02 +0000 (GMT)
Received: from [9.211.61.211] (unknown [9.211.61.211])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 19:44:02 +0000 (GMT)
Message-ID: <e3562109-789d-1c69-246b-670ded1a9d38@linux.ibm.com>
Date:   Wed, 11 May 2022 14:43:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] leds: pca955x: Optimize probe led selection
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, andy.shevchenko@gmail.com,
        openbmc@lists.ozlabs.org, joel@jms.id.au
References: <20220411162033.39613-1-eajames@linux.ibm.com>
 <20220411162033.39613-4-eajames@linux.ibm.com> <20220504172429.GF1623@bug>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220504172429.GF1623@bug>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ouE1DYAT05yg0pY8Kd_9k4yWslfjXiuq
X-Proofpoint-ORIG-GUID: uNfw7jlX_b9sU4TzZJYYkaQjM8GjsBfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=384
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110085
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/22 12:24, Pavel Machek wrote:
> Hi!
>
>> Previously, the probe function might do up to 32 reads and writes
>> to the same 4 registers to program the led selection. Reduce this to
>> a maximum of 8 operations by accumulating the changes to the led
>> selection and comparing with the previous value to write the
>> selection if different.
> We have regmap APIs. You are free to use them if you really care about
> those few reads. Reimplementing them by hand is not acceptable. How big is
> the seedup here?


Hi,

To be honest this was not about speed, it's about a problem I've 
observed where many operations in quick succession caused the PCA chip 
to NAK the i2c transfer. I'm not sure of the root cause yet. So reducing 
the number of operations helped. We are also probably going to carry a 
throttling patch, unless I can prove the PCA chip itself is at fault and 
needs slower transfers.

I can try the regmap API and see if it helps though.

Thanks,

Eddie


>
> Best regards,
> 								Pavel
>
>> @@ -554,6 +556,15 @@ static int pca955x_probe(struct i2c_client *client)
>>   	init_data.devname_mandatory = false;
>>   	init_data.devicename = "pca955x";
>>   
>> +	nls = pca955x_num_led_regs(chip->bits);
>> +	for (i = 0; i < nls; ++i) {
>> +		err = pca955x_read_ls(pca955x, i, &ls1[i]);
>> +		if (err)
>> +			return err;
>> +
>> +		ls2[i] = ls1[i];
>> +	}
>> +
>>   	for (i = 0; i < chip->bits; i++) {
>>   		pca955x_led = &pca955x->leds[i];
>>   		pca955x_led->led_num = i;
>> @@ -624,6 +634,14 @@ static int pca955x_probe(struct i2c_client *client)
>>   		}
>>   	}
>>   
>> +	for (i = 0; i < nls; ++i) {
>> +		if (ls1[i] != ls2[i]) {
>> +			err = pca955x_write_ls(pca955x, i, ls2[i]);
>> +			if (err)
>> +				return err;
>> +		}
>> +	}
>> +
>>   	/* PWM0 is used for half brightness or 50% duty cycle */
>>   	err = pca955x_write_pwm(pca955x, 0, 255 - LED_HALF);
>>   	if (err)
