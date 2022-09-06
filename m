Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AC5AF4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIFTmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIFTlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:41:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816980EA2;
        Tue,  6 Sep 2022 12:41:48 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IwKUC031270;
        Tue, 6 Sep 2022 19:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oG4GzaGDllBF2eQdkf48+HYiXzAt+PB2yMf9EPmelRo=;
 b=WGI1xU05r1XOoYdijfHoEYMH2wFKeOmAyiVKqW1ZqEJpCjZlpXlCyleOoEMKgWUxRNBO
 N8BfuBlVUcl3qJL/TIrZGM7r369x8NXr4Kf0t8eo158VITuIgPB0RddIneMY+FgYy47c
 b1Y4wHMVgCFQTUv2PAKzdqpvsJgRjAEHkvZnmlCNV8Ivx7Yv+4HzWzx4QyQRJZx3wqYq
 5UuI8F59T/rR7HrO4P//edozLqtCH2zoo7d/hVb0tT1HlXbmd1zcxV4YifdefqvqJuID
 E6sYcgi5fhmbXus0+miUy/5g4OCEZJNQAAz11lhot95l334KgmJoEXnPWGNV8ZfbmSxk fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jebxqs9af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:41:33 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286JFZKx036462;
        Tue, 6 Sep 2022 19:41:33 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jebxqs99t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:41:33 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JYlT8030705;
        Tue, 6 Sep 2022 19:41:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3jbxj9dhfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:41:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JfVXr40960426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:41:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AC5AAC059;
        Tue,  6 Sep 2022 19:41:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6D0AC05B;
        Tue,  6 Sep 2022 19:41:31 +0000 (GMT)
Received: from [9.160.74.237] (unknown [9.160.74.237])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:41:30 +0000 (GMT)
Message-ID: <f68155e6-717a-8f0a-52df-e812657a81ee@linux.ibm.com>
Date:   Tue, 6 Sep 2022 14:41:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20220815145705.203017-1-eajames@linux.ibm.com>
 <20220815145705.203017-3-eajames@linux.ibm.com>
 <CAHp75VegQspJJ9YT=2E3YvKh-hp9-AGincp4z0GdQbA0Vq4Zug@mail.gmail.com>
 <20220820130248.7773a6b3@jic23-huawei>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220820130248.7773a6b3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oidZBi1EAqJ1oC2bgMRQ5vG70HnFMLor
X-Proofpoint-GUID: yrjZEWYJdKi9KvK772EJXaE2FkpfBEy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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


On 8/20/22 07:02, Jonathan Cameron wrote:
> On Thu, 18 Aug 2022 23:16:55 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Mon, Aug 15, 2022 at 5:57 PM Eddie James <eajames@linux.ibm.com> wrote:
>>> Corruption of the MEAS_CFG register has been observed soon after
>>> system boot. In order to recover this scenario, check MEAS_CFG if
>>> measurement isn't ready, and if it's incorrect, reset the DPS310
>>> and execute the startup procedure.
>> ...
>>
>>> + * Called with lock held. Returns a negative value on error, a positive value
>>> + * when the device is not ready, and zero when the device is ready.
>> Can we have
>>
>> #define DPS310_DEVICE_NOT_READY  1
>>
>> (or anonymous enum) and return it instead of abstract 1 or any other
>> positive number?
> Perhaps make it even clearer by returning the need to wait via another parameter
> rather than this being (probably) the only place in driver with a postive rc.
>
> bool reset_done;
>
> rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY, &reset_done);
>
> if (reset_done) {
> }


Thanks for the feedback.

Unfortunately our issue is still presenting itself even with a correct 
MEAS_CFG register. The sensor ready bit never gets set. So I'm going to 
rework this patch to reset the device after a timeout.


Thanks,

Eddie


>
>> ...
>>
>>> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>>>          if (rc < 0)
>>>                  goto done;
>>>
>>> +       if (rc > 0) {
>>> +               rate = dps310_get_temp_samp_freq(data);
>>> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
>>> +
>>> +               /*
>>> +                * Poll for sensor readiness; base the timeout upon the sample
>>> +                * rate.
>>> +                */
>>> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
>>> +                                             ready, ready & DPS310_TMP_RDY,
>>> +                                             DPS310_POLL_SLEEP_US(timeout),
>>> +                                             timeout);
>>> +               if (rc)
>>> +                       goto done;
>>> +       }
>> But have you tried to make a helper that takes a pointer to the
>> respective function?
>>
