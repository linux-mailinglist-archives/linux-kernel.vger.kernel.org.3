Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2831F532C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiEXOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiEXOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:18:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9655D5E7;
        Tue, 24 May 2022 07:18:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ODnosB004612;
        Tue, 24 May 2022 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FMYJgJ9m3gzum7FhzVBNLflIKQ8aVmM5jzQGFFlrQOY=;
 b=OdGiNejTeBkhvOmCM8+GDrqbOj7CccsXm8CKmpMKF83aTxIP0LXGtaWwrAXHl+qvHU68
 35D4pj9Z9ZOK62ChtY943jLxQpyNBsrtyuFY7EK7ezlMEwqtz1PGMOkbbeBFTqA1LSg2
 WnoWItkQYc7ZUSAuVbPxRasbDJT8OEfcgpIQgzvwrsMLEYcgFFswbOEafGZAcdddRrW9
 REtDfKgjk2ReYFfiFb3fgur30la2TxcIUjluhYjkmDad2HLOqifB+z1E+u6Jg/AsXVeU
 a5L4DSQGili1OudXV4QiUOPaj7WHVq1CgPyzwhU/h4Jb/YJ7EGuJ5LOxOe6X+GBJyhK5 ug== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g905xsgbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:18:35 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OECPMO023618;
        Tue, 24 May 2022 14:18:34 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3g6qq9rhjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 14:18:33 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OEIXrR17039796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 14:18:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83323AE063;
        Tue, 24 May 2022 14:18:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F03B9AE068;
        Tue, 24 May 2022 14:18:32 +0000 (GMT)
Received: from [9.211.82.60] (unknown [9.211.82.60])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 14:18:32 +0000 (GMT)
Message-ID: <a817037e-0c8f-a890-549a-6df42e2bb26d@linux.ibm.com>
Date:   Tue, 24 May 2022 09:18:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
References: <20220518144818.12957-1-eajames@linux.ibm.com>
 <20220518144818.12957-3-eajames@linux.ibm.com>
 <CACPK8XeOT6NvEe=oBZ9dUJynHougj-mTMAC2FCwDkvpzBaTKDQ@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8XeOT6NvEe=oBZ9dUJynHougj-mTMAC2FCwDkvpzBaTKDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fh_sWRZ9_APG2YXeNIxmYj-rd19rcIVc
X-Proofpoint-ORIG-GUID: Fh_sWRZ9_APG2YXeNIxmYj-rd19rcIVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240072
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/22 21:12, Joel Stanley wrote:
> On Wed, 18 May 2022 at 14:48, Eddie James <eajames@linux.ibm.com> wrote:
>> Corruption of the MEAS_CFG register has been observed soon after
>> system boot. In order to recover this scenario, check MEAS_CFG if
>> measurement isn't ready, and if it's incorrect, reset the DPS310
>> and execute the startup procedure.
> I have some suggestions below on how to rework to make the code easier
> to understand. But before we got to that, I had some high level
> questions:
>
>
> You don't seem to be setting the en bits in the CFG register after
> doing the reset. Is that required?


It does set the enable bits in the startup procedure, called after the 
reset.


>
> Are we ok to sleep for 2.5ms in the iio_info->read_raw callback?


I believe it's safe... the code already has a mutex, so its not called 
in atomic context.


>
>
>> Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/iio/pressure/dps310.c | 89 ++++++++++++++++++++++++++++-------
>>   1 file changed, 71 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
>> index f79b274bb38d..c6d02679ef33 100644
>> --- a/drivers/iio/pressure/dps310.c
>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -397,6 +397,39 @@ static int dps310_get_temp_k(struct dps310_data *data)
>>          return scale_factors[ilog2(rc)];
>>   }
>>
>> +/* Called with lock held */
> Perhaps add this to your comment: Returns a negative value on error, a
> positive value when the device is not ready (and may have been reset
> due to corruption), and zero when the device is ready.


Good idea.


>
>> +static int dps310_check_reset_meas_cfg(struct dps310_data *data, int ready_bit)
>> +{
>> +       int en = DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND;
>> +       int meas_cfg;
>> +       int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
>> +
>> +       if (rc < 0)
>> +               return rc;
>> +
>> +       if (meas_cfg & ready_bit)
>> +               return 0;
>> +
>> +       if ((meas_cfg & en) != en) {
>> +               /* DPS310 register state corrupt, better start from scratch */
>> +               rc = regmap_write(data->regmap, DPS310_RESET,
>> +                                 DPS310_RESET_MAGIC);
>> +               if (rc < 0)
>> +                       return rc;
>> +
>> +               /* Wait for device chip access: 2.5ms in specification */
>> +               usleep_range(2500, 12000);
>> +               rc = dps310_startup(data);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               dev_info(&data->client->dev,
>> +                        "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
>> +       }
>> +
>> +       return 1;
> I'm confused about this case. We get there when the device doesn't
> have ready_bit set in meas_cfg and we've done a reset, but we also get
> here when the bit isn't set and we haven't done anything to resolve it
> (after re-reading the code I understand now, but perhaps reworking it
> as follows will make it clear):
>
> Could we write it like this:
>
> if (meas_cfg & ready_bit) {
>    /* Device ready, must be okay */
>    return 0;
> }
>
>   if (meas_cfg & en) {
>     /* Device okay (but not ready), no action required */
>     return 1;
> }
>
>    /* DPS310 register state corrupt, better start from scratch */
> ...
>   return 1;


Yea it could be clearer, I can update that.


>
>
>> +}
>> +
>>   static int dps310_read_pres_raw(struct dps310_data *data)
>>   {
>>          int rc;
>> @@ -409,15 +442,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
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
>> -               goto done;
>> +       rc = dps310_check_reset_meas_cfg(data, DPS310_PRS_RDY);
> can we do this:
>
>   if (rc < 0)
>     goto done;
>
> if (rc > 0) {
>
> }
>
> The rework I suggest makes it clearer that we've considered the '0'
> case, when the device is ready before this code runs.


Sure. Thanks for the review, I'll get a v3 up.


Thanks,

Eddie


>
>> +       if (rc) {
>> +               if (rc < 0)
>> +                       goto done;
>> +
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
>>
>>          rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>>          if (rc < 0)
>> @@ -458,15 +501,25 @@ static int dps310_read_temp_raw(struct dps310_data *data)
>>          if (mutex_lock_interruptible(&data->lock))
>>                  return -EINTR;
>>
>> -       rate = dps310_get_temp_samp_freq(data);
>> -       timeout = DPS310_POLL_TIMEOUT_US(rate);
>> -
>> -       /* Poll for sensor readiness; base the timeout upon the sample rate. */
>> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
>> -                                     ready & DPS310_TMP_RDY,
>> -                                     DPS310_POLL_SLEEP_US(timeout), timeout);
>> -       if (rc < 0)
>> -               goto done;
>> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>> +       if (rc) {
>> +               if (rc < 0)
>> +                       goto done;
>> +
>> +               rate = dps310_get_temp_samp_freq(data);
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
>> +                       goto done;
>> +       }
>>
>>          rc = dps310_read_temp_ready(data);
>>
>> --
>> 2.27.0
>>
