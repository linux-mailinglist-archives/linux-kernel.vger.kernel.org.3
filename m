Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922185A9678
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiIAMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiIAMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:14:26 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68B1157E3;
        Thu,  1 Sep 2022 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662034466; x=1693570466;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/vA7gC+PVHNkG1R/rakP0JdQCUqSGd0Sd7RAHPh/RrE=;
  b=HmjLhhBDR3/a5jcsZF7TtG6yLsGJZ3ioJRFZadVyogu/NUPMaLG5yqDU
   sMxvVeULMB97CFobbVruyjkWWC6sOcIDNa9Aurz7Eh3DcBAtXpjHHRmG0
   EQRPbwqy1KdXJEgRdG/iwTXohQMmJgtbz6Rx1sfvKsnVkfgbJt7ysOXXx
   I=;
X-IronPort-AV: E=Sophos;i="5.93,280,1654560000"; 
   d="scan'208";a="1050300137"
Subject: Re: [PATCH v3 15/19] hwmon: (mr75203) add support for series 6 temperature
 equation
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:14:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id C5D72A25C2;
        Thu,  1 Sep 2022 12:14:09 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 12:14:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 1 Sep 2022 12:14:09 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 12:14:03 +0000
Message-ID: <7b4baf42-eb8e-ad83-a259-a4a0e4e4ac01@amazon.com>
Date:   Thu, 1 Sep 2022 15:14:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-16-farbere@amazon.com>
 <Yw9PTobSRlkh/0i4@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9PTobSRlkh/0i4@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 3:08 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:08PM +0000, Eliav Farber wrote:
>> The current equation used in code is aligned to series 5:
>> T = G + H * (n / cal5 - 0.5) + J * F
>> Where:
>> G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
>>
>> Series 6 has a slightly different equation:
>> T = G + H * (n / cal5 - 0.5)
>> and a different set of coefficients:
>> G = 57.4, H = 249.4, cal5 = 4096
>>
>> This change supports equation and coefficients for both series.
>> (for series 6, J is set to 0).
>>
>> The series is determined according to “ts-series” property in device
>> tree.
>> If absent, series 5 is assumed to be the default.
>
> ...
>
>> -#define PVT_H_CONST          200000
>> -#define PVT_G_CONST          60000
>> -#define PVT_J_CONST          -100
>> -#define PVT_CAL5_CONST               4094
>
> You just introduced them patch before. Please, avoid ping-pong style in
> the same series.


Fixed for v4.
I now introduce these defines in patch 13 to avoid modifying the above
ones and then remove them:
/* Temperature coefficients for series 5 */
#define PVT_SERIES5_H_CONST    200000
#define PVT_SERIES5_G_CONST    60000
#define PVT_SERIES5_J_CONST    -100
#define PVT_SERIES5_CAL5_CONST    4094

> ...
>
>> +     ret = of_property_read_u32(np, "moortec,ts-series", &series);
>
> of_ ?!
>
> Be consistent. Either you use OF everywhere, or device property APIs.
>

Fixed for v4.
Using device_property_read_u32() instead.

> ...
>
>> +     if (ret)
>> +             series = TEMPERATURE_SENSOR_SERIES_5;
>> +
>> +     if (series == TEMPERATURE_SENSOR_SERIES_5) {
>> +             ts_coeff->h = PVT_SERIES5_H_CONST;
>> +             ts_coeff->g = PVT_SERIES5_G_CONST;
>> +             ts_coeff->j = PVT_SERIES5_J_CONST;
>> +             ts_coeff->cal5 = PVT_SERIES5_CAL5_CONST;
>> +     } else if (series == TEMPERATURE_SENSOR_SERIES_6) {
>> +             ts_coeff->h = PVT_SERIES6_H_CONST;
>> +             ts_coeff->g = PVT_SERIES6_G_CONST;
>> +             ts_coeff->j = PVT_SERIES6_J_CONST;
>> +             ts_coeff->cal5 = PVT_SERIES6_CAL5_CONST;
>> +     } else {
>> +             dev_err(dev, "invalid temperature sensor series (%u)\n",
>> +                     series);
>> +             return -EINVAL;
>> +     }
>
> switch-case? 

Changed to switch-case (will be part of v4).

--
Thanks, Eliav
