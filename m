Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184359302B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiHONn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiHONnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:43:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7B2251C;
        Mon, 15 Aug 2022 06:43:19 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FDcklU009953;
        Mon, 15 Aug 2022 13:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/QejwWSv25AbtQ5g+A1KD9oPSOPx4OGfAYj3D1lM1fU=;
 b=XdBM1iijIgnU7DcQ2Hi0mvNSGnOebWBuy7TWXkRvGCcIHD1c7X3fgM9ExXcwaGU8br5t
 2sow4tJPiH3svWgqdEG7WqnH4+1Mqj0ZkVeNSTnPwT2La7CgDBBwBFrR7eFV/Up9zbAF
 Ysg4AM6oFevM5lF2cPkrqsuQTU9gHR9QxkgjID4ztFSbltyC/PPT3r0jI+lqSBo+E9Zk
 b3KFViQWf3OtbobkVPItuVvG+ZyzAXVzQvfhcexWaChmXHTr8xCUqigC4wAl/xTILFR1
 lFPuK+DgqJl9Igcfqhl3xopHFHwQ1k5oDXY+hIIM42KwOha/nL35KjUDEMa4Nc0Ryouo QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyny39w1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:42:59 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FDdnKh013865;
        Mon, 15 Aug 2022 13:42:59 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyny39w1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:42:59 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FDgXnG004229;
        Mon, 15 Aug 2022 13:42:58 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3hx3k9qa2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:42:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FDgvAn29884696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 13:42:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 869BFB2064;
        Mon, 15 Aug 2022 13:42:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09B28B205F;
        Mon, 15 Aug 2022 13:42:57 +0000 (GMT)
Received: from [9.77.146.160] (unknown [9.77.146.160])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 13:42:56 +0000 (GMT)
Message-ID: <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
Date:   Mon, 15 Aug 2022 08:42:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup procedure
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
 <20220809211246.251006-2-eajames@linux.ibm.com>
 <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _eQzC3Z0Yc7g2W_YwIW1yZYJV6yMex0F
X-Proofpoint-ORIG-GUID: Q-YmOmomzNIFJE4sC72vP3YTKFL-XQRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 17:03, Andy Shevchenko wrote:
> On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:
>> Move the startup procedure into a function, and correct a missing
>> check on the return code for writing the PRS_CFG register.
> Code looks good, one remark below.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   drivers/iio/pressure/dps310.c | 188 ++++++++++++++++++----------------
>>   1 file changed, 99 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
>> index 36fb7ae0d0a9..c706a8b423b5 100644
>> --- a/drivers/iio/pressure/dps310.c
>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -159,6 +159,102 @@ static int dps310_get_coefs(struct dps310_data *data)
>>          return 0;
>>   }
>>
>> +/*
>> + * Some versions of the chip will read temperatures in the ~60C range when
>> + * it's actually ~20C. This is the manufacturer recommended workaround
>> + * to correct the issue. The registers used below are undocumented.
>> + */
>> +static int dps310_temp_workaround(struct dps310_data *data)
>> +{
>> +       int rc;
>> +       int reg;
>> +
>> +       rc = regmap_read(data->regmap, 0x32, &reg);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /*
>> +        * If bit 1 is set then the device is okay, and the workaround does not
>> +        * need to be applied
>> +        */
>> +       if (reg & BIT(1))
>> +               return 0;
>> +
>> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
>> +       if (rc)
>> +               return rc;
> This code already exists, but still want to ask, is it really
> byte-registers here and not be16/le16 one? In such a case perhaps bulk
> write can be used to reflect it better?


The temperature and pressure regs are 24 bits big endian, and all the 
rest are 8 bits. I think the existing approach is best.


Thanks Andy!


>
>> +       rc = regmap_write(data->regmap, 0x62, 0x02);
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
>> +       if (rc)
>> +               return rc;
>> +
>> +       return regmap_write(data->regmap, 0x0f, 0x00);
> Ditto.
>
>> +}
>> +
>> +static int dps310_startup(struct dps310_data *data)
>> +{
>> +       int rc;
>> +       int ready;
>> +
>> +       /*
>> +        * Set up pressure sensor in single sample, one measurement per second
>> +        * mode
>> +        */
>> +       rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /*
>> +        * Set up external (MEMS) temperature sensor in single sample, one
>> +        * measurement per second mode
>> +        */
>> +       rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Temp and pressure shifts are disabled when PRC <= 8 */
>> +       rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
>> +                              DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* MEAS_CFG doesn't update correctly unless first written with 0 */
>> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> +                              DPS310_MEAS_CTRL_BITS, 0);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /* Turn on temperature and pressure measurement in the background */
>> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> +                              DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
>> +                              DPS310_TEMP_EN | DPS310_BACKGROUND);
>> +       if (rc)
>> +               return rc;
>> +
>> +       /*
>> +        * Calibration coefficients required for reporting temperature.
>> +        * They are available 40ms after the device has started
>> +        */
>> +       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> +                                     ready & DPS310_COEF_RDY, 10000, 40000);
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = dps310_get_coefs(data);
>> +       if (rc)
>> +               return rc;
>> +
>> +       return dps310_temp_workaround(data);
>> +}
>> +
>>   static int dps310_get_pres_precision(struct dps310_data *data)
>>   {
>>          int rc;
>> @@ -677,52 +773,12 @@ static const struct iio_info dps310_info = {
>>          .write_raw = dps310_write_raw,
>>   };
>>
>> -/*
>> - * Some verions of chip will read temperatures in the ~60C range when
>> - * its actually ~20C. This is the manufacturer recommended workaround
>> - * to correct the issue. The registers used below are undocumented.
>> - */
>> -static int dps310_temp_workaround(struct dps310_data *data)
>> -{
>> -       int rc;
>> -       int reg;
>> -
>> -       rc = regmap_read(data->regmap, 0x32, &reg);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       /*
>> -        * If bit 1 is set then the device is okay, and the workaround does not
>> -        * need to be applied
>> -        */
>> -       if (reg & BIT(1))
>> -               return 0;
>> -
>> -       rc = regmap_write(data->regmap, 0x0e, 0xA5);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       rc = regmap_write(data->regmap, 0x0f, 0x96);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       rc = regmap_write(data->regmap, 0x62, 0x02);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       rc = regmap_write(data->regmap, 0x0e, 0x00);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       return regmap_write(data->regmap, 0x0f, 0x00);
>> -}
>> -
>>   static int dps310_probe(struct i2c_client *client,
>>                          const struct i2c_device_id *id)
>>   {
>>          struct dps310_data *data;
>>          struct iio_dev *iio;
>> -       int rc, ready;
>> +       int rc;
>>
>>          iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
>>          if (!iio)
>> @@ -747,54 +803,8 @@ static int dps310_probe(struct i2c_client *client,
>>          if (rc)
>>                  return rc;
>>
>> -       /*
>> -        * Set up pressure sensor in single sample, one measurement per second
>> -        * mode
>> -        */
>> -       rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
>> -
>> -       /*
>> -        * Set up external (MEMS) temperature sensor in single sample, one
>> -        * measurement per second mode
>> -        */
>> -       rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       /* Temp and pressure shifts are disabled when PRC <= 8 */
>> -       rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
>> -                              DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       /* MEAS_CFG doesn't update correctly unless first written with 0 */
>> -       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> -                              DPS310_MEAS_CTRL_BITS, 0);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       /* Turn on temperature and pressure measurement in the background */
>> -       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> -                              DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
>> -                              DPS310_TEMP_EN | DPS310_BACKGROUND);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       /*
>> -        * Calibration coefficients required for reporting temperature.
>> -        * They are available 40ms after the device has started
>> -        */
>> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -                                     ready & DPS310_COEF_RDY, 10000, 40000);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       rc = dps310_get_coefs(data);
>> -       if (rc < 0)
>> -               return rc;
>> -
>> -       rc = dps310_temp_workaround(data);
>> -       if (rc < 0)
>> +       rc = dps310_startup(data);
>> +       if (rc)
>>                  return rc;
>>
>>          rc = devm_iio_device_register(&client->dev, iio);
>> --
>> 2.31.1
>>
>
