Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3252BD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiEROJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbiEROJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E11C0F1C;
        Wed, 18 May 2022 07:09:35 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IDoSqi018333;
        Wed, 18 May 2022 14:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TbjLMltCc9j5YWXif11yStRM+Fb8y2Ty00RE+6G+EqM=;
 b=phKljML8a3ItTPzoXbetez/50TXvy/sTNHqbgNZf7leNyu8N0Yti/Oeoz5wmMfngAI9e
 c/QzD3YZu48+TqEhdy38yu2JhZeJsWw11x9Mj827/tLmDvJvj3UfzcrSeB7hhNXKs0ld
 Q5OEaqsVeavIGb3a2Okx6btWYnXLKbyrUCpPNlNkQQ7j1G99bN2IfeDNGdFT/LDBj+CO
 BNC9L9B8cuDdsORNGmzWX+WYh9nW6IqU3YT+HACoJcjbSydeH4iljeBEj4A23DcnrnKW
 iUj6/tIKWEKXMHR+zmke+ggb57/CPnuvlr42TqNO78kz3+0UWDFNGzJPLjgyRNHsWgjO bA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g521egjd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:09:20 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IE2aJ5018846;
        Wed, 18 May 2022 14:09:19 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3g242bc3b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 14:09:19 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IE9IFK26214842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 14:09:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5316CAC05B;
        Wed, 18 May 2022 14:09:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B38DDAC060;
        Wed, 18 May 2022 14:09:17 +0000 (GMT)
Received: from [9.163.6.139] (unknown [9.163.6.139])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 14:09:17 +0000 (GMT)
Message-ID: <75aa9c31-380d-c6f6-8cb3-9dd50bacabda@linux.ibm.com>
Date:   Wed, 18 May 2022 09:07:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, joel@jms.id.au
References: <20220511192724.51845-1-eajames@linux.ibm.com>
 <20220514160200.091d40ca@jic23-huawei>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220514160200.091d40ca@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l7lBp-xK3zO0i1se2RS4g0-BAvnWIavD
X-Proofpoint-ORIG-GUID: l7lBp-xK3zO0i1se2RS4g0-BAvnWIavD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180083
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/22 10:02, Jonathan Cameron wrote:
> On Wed, 11 May 2022 14:27:24 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> Corruption of the MEAS_CFG register has been observed soon after
>> system boot. In order to recover this scenario, check MEAS_CFG if
>> measurement isn't ready, and if it's incorrect, reset the DPS310
>> and write all the necessary registers.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> It's a large patch, so not an ideal 'fix' to backport, but
> if we need to for platforms to work we should do so.
>
> Hence, please add a Fixes tag (which I'm guessing will be the driver
> being added in the first place).
>
> Whilst tidying up might be nice, we shouldn't do refactoring that's not
> strictly necessary in a fix patch.  Hence I'd prefer this as a two patch
> series. Refactor with no functional changes, then the actual change.


Sure thing.


>
> A couple of minor queries inline,
>
> Thanks,
>
> Jonathan
>
>
>
>> ---
>>   drivers/iio/pressure/dps310.c | 280 +++++++++++++++++++++-------------
>>   1 file changed, 173 insertions(+), 107 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
>> index 36fb7ae0d0a9..39f84614f44e 100644
>> --- a/drivers/iio/pressure/dps310.c
>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -159,6 +159,106 @@ static int dps310_get_coefs(struct dps310_data *data)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Some verions of chip will read temperatures in the ~60C range when
>> + * its actually ~20C. This is the manufacturer recommended workaround
>> + * to correct the issue. The registers used below are undocumented.
>> + */
>> +static int dps310_temp_workaround(struct dps310_data *data)
>> +{
>> +	int rc;
>> +	int reg;
>> +
>> +	rc = regmap_read(data->regmap, 0x32, &reg);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/*
>> +	 * If bit 1 is set then the device is okay, and the workaround does not
>> +	 * need to be applied
>> +	 */
>> +	if (reg & BIT(1))
>> +		return 0;
>> +
>> +	rc = regmap_write(data->regmap, 0x0e, 0xA5);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = regmap_write(data->regmap, 0x0f, 0x96);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = regmap_write(data->regmap, 0x62, 0x02);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = regmap_write(data->regmap, 0x0e, 0x00);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return regmap_write(data->regmap, 0x0f, 0x00);
>> +}
>> +
>> +static int dps310_startup(struct dps310_data *data)
>> +{
>> +	int rc;
>> +	int ready;
>> +
>> +	/*
>> +	 * Set up pressure sensor in single sample, one measurement per second
>> +	 * mode
>> +	 */
>> +	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/*
>> +	 * Set up external (MEMS) temperature sensor in single sample, one
>> +	 * measurement per second mode
>> +	 */
>> +	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* Temp and pressure shifts are disabled when PRC <= 8 */
>> +	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
>> +			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* MEAS_CFG doesn't update correctly unless first written with 0 */
>> +	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> +			       DPS310_MEAS_CTRL_BITS, 0);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* Turn on temperature and pressure measurement in the background */
>> +	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> +			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
>> +			       DPS310_TEMP_EN | DPS310_BACKGROUND);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/*
>> +	 * Calibration coefficients required for reporting temperature.
>> +	 * They are available 40ms after the device has started
>> +	 */
>> +	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> +				      ready & DPS310_COEF_RDY, 10000, 40000);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = dps310_get_coefs(data);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = dps310_temp_workaround(data);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return 0;
>> +}
>> +
>>   static int dps310_get_pres_precision(struct dps310_data *data)
>>   {
>>   	int rc;
>> @@ -297,6 +397,38 @@ static int dps310_get_temp_k(struct dps310_data *data)
>>   	return scale_factors[ilog2(rc)];
>>   }
>>   
>> +/* Called with lock held */
>> +static int dps310_verify_meas_cfg(struct dps310_data *data, int ready_bit)
> Hmm. I'm not immediately coming up with a better name, but it does
> seem odd that a verify function would do a reset.


Sure, I'll try and think of a better name.


>
>> +{
>> +	int en = DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND;
>> +	int meas_cfg;
>> +	int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
>> +
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (meas_cfg & ready_bit)
>> +		return 0;
>> +
>> +	if ((meas_cfg & en) != en) {
>> +		/* DPS310 register state corrupt, better start from scratch */
>> +		rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		/* Wait for device chip access: 2.5ms in specification */
>> +		usleep_range(2500, 12000);
>> +		rc = dps310_startup(data);
>> +		if (rc)
>> +			return rc;
>> +
>> +		dev_info(&data->client->dev,
>> +			 "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>>   static int dps310_read_pres_raw(struct dps310_data *data)
>>   {
>>   	int rc;
>> @@ -309,15 +441,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>>   	if (mutex_lock_interruptible(&data->lock))
>>   		return -EINTR;
>>   
>> -	rate = dps310_get_pres_samp_freq(data);
>> -	timeout = DPS310_POLL_TIMEOUT_US(rate);
>> -
>> -	/* Poll for sensor readiness; base the timeout upon the sample rate. */
>> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -				      ready & DPS310_PRS_RDY,
>> -				      DPS310_POLL_SLEEP_US(timeout), timeout);
>> -	if (rc)
>> -		goto done;
>> +	rc = dps310_verify_meas_cfg(data, DPS310_PRS_RDY);
>> +	if (rc) {
> So at this point we potentially reset. Is there a race condition against
> the device register state corrupting again?  If so I guess we are relying
> on the timeout and userspace trying again.  Maybe worth adding a comment
> if that is the case.


Well, I don't know what causes the corruption at this point. The lock is 
held, so nothing else should touch the device, so I'm assuming it won't 
get corrupted. And assuming the reset works, then the sensor measurement 
should return valid data now, so any problem should be invisible to 
userspace (except this read will take a long time).


Thanks for the review.

Eddie


>
>> +		if (rc < 0)
>> +			goto done;
>> +
>> +		rate = dps310_get_pres_samp_freq(data);
>> +		timeout = DPS310_POLL_TIMEOUT_US(rate);
>> +
>> +		/*
>> +		 * Poll for sensor readiness; base the timeout upon the sample
>> +		 * rate.
>> +		 */
>> +		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
>> +					      ready, ready & DPS310_PRS_RDY,
>> +					      DPS310_POLL_SLEEP_US(timeout),
>> +					      timeout);
>> +		if (rc)
>> +			goto done;
>> +	}
>>   
>>   	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>>   	if (rc < 0)
>> @@ -358,15 +500,25 @@ static int dps310_read_temp_raw(struct dps310_data *data)
>>   	if (mutex_lock_interruptible(&data->lock))
>>   		return -EINTR;
>>   
>> -	rate = dps310_get_temp_samp_freq(data);
>> -	timeout = DPS310_POLL_TIMEOUT_US(rate);
>> -
>> -	/* Poll for sensor readiness; base the timeout upon the sample rate. */
>> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -				      ready & DPS310_TMP_RDY,
>> -				      DPS310_POLL_SLEEP_US(timeout), timeout);
>> -	if (rc < 0)
>> -		goto done;
>> +	rc = dps310_verify_meas_cfg(data, DPS310_TMP_RDY);
>> +	if (rc) {
>> +		if (rc < 0)
>> +			goto done;
>> +
>> +		rate = dps310_get_temp_samp_freq(data);
>> +		timeout = DPS310_POLL_TIMEOUT_US(rate);
>> +
>> +		/*
>> +		 * Poll for sensor readiness; base the timeout upon the sample
>> +		 * rate.
>> +		 */
>> +		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
>> +					      ready, ready & DPS310_TMP_RDY,
>> +					      DPS310_POLL_SLEEP_US(timeout),
>> +					      timeout);
>> +		if (rc < 0)
>> +			goto done;
>> +	}
>>   
>>   	rc = dps310_read_temp_ready(data);
>>   
>> @@ -677,52 +829,12 @@ static const struct iio_info dps310_info = {
>>   	.write_raw = dps310_write_raw,
>>   };
>>   
>> -/*
>> - * Some verions of chip will read temperatures in the ~60C range when
>> - * its actually ~20C. This is the manufacturer recommended workaround
>> - * to correct the issue. The registers used below are undocumented.
>> - */
>> -static int dps310_temp_workaround(struct dps310_data *data)
>> -{
>> -	int rc;
>> -	int reg;
>> -
>> -	rc = regmap_read(data->regmap, 0x32, &reg);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	/*
>> -	 * If bit 1 is set then the device is okay, and the workaround does not
>> -	 * need to be applied
>> -	 */
>> -	if (reg & BIT(1))
>> -		return 0;
>> -
>> -	rc = regmap_write(data->regmap, 0x0e, 0xA5);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	rc = regmap_write(data->regmap, 0x0f, 0x96);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	rc = regmap_write(data->regmap, 0x62, 0x02);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	rc = regmap_write(data->regmap, 0x0e, 0x00);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	return regmap_write(data->regmap, 0x0f, 0x00);
>> -}
>> -
>>   static int dps310_probe(struct i2c_client *client,
>>   			const struct i2c_device_id *id)
>>   {
>>   	struct dps310_data *data;
>>   	struct iio_dev *iio;
>> -	int rc, ready;
>> +	int rc;
>>   
>>   	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
>>   	if (!iio)
>> @@ -747,54 +859,8 @@ static int dps310_probe(struct i2c_client *client,
>>   	if (rc)
>>   		return rc;
>>   
>> -	/*
>> -	 * Set up pressure sensor in single sample, one measurement per second
>> -	 * mode
>> -	 */
>> -	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
> Lack of error checking in original code is odd. Deliberate or not is the
> question... (probably not deliberate as rc = is there).
>
>> -
>> -	/*
>> -	 * Set up external (MEMS) temperature sensor in single sample, one
>> -	 * measurement per second mode
>> -	 */
>> -	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	/* Temp and pressure shifts are disabled when PRC <= 8 */
>> -	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
>> -			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	/* MEAS_CFG doesn't update correctly unless first written with 0 */
>> -	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> -			       DPS310_MEAS_CTRL_BITS, 0);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	/* Turn on temperature and pressure measurement in the background */
>> -	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> -			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
>> -			       DPS310_TEMP_EN | DPS310_BACKGROUND);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	/*
>> -	 * Calibration coefficients required for reporting temperature.
>> -	 * They are available 40ms after the device has started
>> -	 */
>> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -				      ready & DPS310_COEF_RDY, 10000, 40000);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	rc = dps310_get_coefs(data);
>> -	if (rc < 0)
>> -		return rc;
>> -
>> -	rc = dps310_temp_workaround(data);
>> -	if (rc < 0)
>> +	rc = dps310_startup(data);
>> +	if (rc)
>>   		return rc;
>>   
>>   	rc = devm_iio_device_register(&client->dev, iio);
