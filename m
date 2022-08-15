Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8183159305C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiHON7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiHON72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:59:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30922B23;
        Mon, 15 Aug 2022 06:59:26 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FDhZRC010502;
        Mon, 15 Aug 2022 13:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oyXLuDwoqKoBqtixFcLUxvAdEJpipLRmAoin7itaNu4=;
 b=kHdRad97OBPdppFHAtUUKwazvszb+Ed1qRuHDoWeVXFbB8H3VTeEmpyZT9de4fxpzcDH
 VS/Egyka1MzYlZmojnbxayWa2p0xrc3/zilxgejklkbVVMJXFbLl4n9LSnR1wepvVIfG
 0IpiwS17q4GFDlR5ZAAINXrUHeaLo0guvqGLE9hOUg3n3SD1q1+SXtiW9Okzdezro8bL
 QOoXCe+fS6u0Kqhk8lfaqbeUMwP5OyQRvp/KlKqzy2sS5Nnce2hz/gI9fTYGJOo4uzSA
 /1eufCnGlSJKkrbdfdydWY0FLnMDc//pDcXl219DKSr4ehjK2T2eyZMCBFJjDKIk1Phi iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyq9h0cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:59:06 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FDiK5v014684;
        Mon, 15 Aug 2022 13:59:06 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyq9h0cw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:59:06 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FDnjqM014593;
        Mon, 15 Aug 2022 13:59:04 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3hx3k9m91d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:59:04 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FDx4RK1507942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 13:59:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2B14B205F;
        Mon, 15 Aug 2022 13:59:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80DCAB2064;
        Mon, 15 Aug 2022 13:59:03 +0000 (GMT)
Received: from [9.77.146.160] (unknown [9.77.146.160])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 13:59:03 +0000 (GMT)
Message-ID: <f56c7486-2b78-48ac-3c5d-c7c20d1e78f5@linux.ibm.com>
Date:   Mon, 15 Aug 2022 08:59:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
 <20220809211246.251006-3-eajames@linux.ibm.com>
 <CAHp75VdbRiWxxbnW61SNdj+pC4skeRF3prXgPvKB+btjW3dLKw@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAHp75VdbRiWxxbnW61SNdj+pC4skeRF3prXgPvKB+btjW3dLKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eFzUiPUmn3NZt_6_sBugfKfki2IlSf4G
X-Proofpoint-GUID: vYziDs7p1oPGlA5fHTRZq0IjfzH4MXk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
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


On 8/12/22 17:13, Andy Shevchenko wrote:
> On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:
>> Corruption of the MEAS_CFG register has been observed soon after
>> system boot. In order to recover this scenario, check MEAS_CFG if
>> measurement isn't ready, and if it's incorrect, reset the DPS310
>> and execute the startup procedure.
> Looks like both patches miss the Fixes tag. Can you add them?


Well this isn't really a software fix - there's no identifiable bug in 
the driver. Just trying to recover the chip in this observed mystery 
scenario.


>
> ...
>
>> +/*
>> + * Called with lock held. Returns a negative value on error, a positive value
>> + * when the device is not ready, and zero when the device is ready.
>> + */
>> +static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
>> +{
>> +       int meas_cfg;
>> +       int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
>> +
>> +       if (rc < 0)
>> +               return rc;
> Please, split definition and assignment.


Ack.


>
>> +       /* Device is ready, proceed to measurement */
>> +       if (meas_cfg & ready_bit)
>> +               return 0;
>> +
>> +       /* Device is OK, just not ready */
>> +       if (meas_cfg & (DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND))
>> +               return 1;
>> +
>> +       /* DPS310 register state corrupt, better start from scratch */
>> +       rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
>> +       if (rc < 0)
>> +               return rc;
>> +
>> +       /* Wait for device chip access: 2.5ms in specification */
>> +       usleep_range(2500, 12000);
>> +
>> +       /* Reinitialize the chip */
>> +       rc = dps310_startup(data);
>> +       if (rc)
>> +               return rc;
>> +
>> +       dev_info(&data->client->dev,
>> +                "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
>> +       return 1;
>> +}
>> +
>>   static int dps310_read_pres_raw(struct dps310_data *data)
>>   {
>>          int rc;
>> @@ -405,16 +443,26 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>>          if (mutex_lock_interruptible(&data->lock))
>>                  return -EINTR;
>>
>> -       rate = dps310_get_pres_samp_freq(data);
>> -       timeout = DPS310_POLL_TIMEOUT_US(rate);
>> -
>> -       /* Poll for sensor readiness; base the timeout upon the sample rate. */
>> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -                                     ready & DPS310_PRS_RDY,
>> -                                     DPS310_POLL_SLEEP_US(timeout), timeout);
>> -       if (rc)
>> +       rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);
>> +       if (rc < 0)
>>                  goto done;
>>
>> +       if (rc > 0) {
>> +               rate = dps310_get_pres_samp_freq(data);
>> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
>> +
>> +               /*
>> +                * Poll for sensor readiness; base the timeout upon the sample
>> +                * rate.
>> +                */
>> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
>> +                                             ready, ready & DPS310_PRS_RDY,
>> +                                             DPS310_POLL_SLEEP_US(timeout),
>> +                                             timeout);
>> +               if (rc)
>> +                       goto done;
>> +       }
> If you split the condition body to a helper, it can be rewritten like
> (also note special definition for positive returned numbers):
>
>    rc = ..._reset_meas_cfg(...);
>    if (rc  == DPS310_MEAS_NOT_READY)
>      rc = ..._new_helper_func(...);
>    if (rc)
>      goto done;
>
> and looking at this it might be worth considering calling that
> conditional in the middle in the _reset_meas_cfg(), so the latter will
> return either 0 or negative error code.


To be honest that looks more complicated than the way it is now? And I 
don't think I can make it common between the temp and pressure without 
some complicated macro business.


>
>> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>>          if (rc < 0)
>>                  goto done;
>>
>> +       if (rc > 0) {
>> +               rate = dps310_get_temp_samp_freq(data);
> Okay, I see this function is different, but still you may realize a
> helper from below and something like above suggestion can still be
> achieved.
>
>> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
>> +
>> +               /*
>> +                * Poll for sensor readiness; base the timeout upon the sample
>> +                * rate.
>> +                */
>> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
>> +                                             ready, ready & DPS310_TMP_RDY,
>> +                                             DPS310_POLL_SLEEP_US(timeout),
>> +                                             timeout);
>> +               if (rc < 0)
> Why out of a sudden ' < 0'?


Good point, I'll fix that.


>
>> +                       goto done;
>> +       }
> As per above.
>
>>          rc = dps310_read_temp_ready(data);
>
