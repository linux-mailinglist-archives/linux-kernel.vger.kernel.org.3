Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A665A93A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiIAJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiIAJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:54:57 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607DF133;
        Thu,  1 Sep 2022 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662026094; x=1693562094;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=NX3N/paYyQqUhforgxYacBUvwbAZreQsVJx7Uym+9Mc=;
  b=AlEW7beam5cKi6q9nIgO9MzwfSNljBYHImX3bgbC5BVDwmDs03s2ujpK
   zdYHdgGZCIysDlKjhOGcrNS/auEAfvBwxB/Zy4Kid0Ee4Gpuj1R7ilson
   vHXu0vZN+de77RUNPV7zPxYB09z6fffek82wxpRZzSaSZL4iEpmVquE98
   4=;
X-IronPort-AV: E=Sophos;i="5.93,280,1654560000"; 
   d="scan'208";a="255127260"
Subject: Re: [PATCH v3 17/19] hwmon: (mr75203) parse temperature coefficients from
 device-tree
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 09:54:35 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com (Postfix) with ESMTPS id 00471121491;
        Thu,  1 Sep 2022 09:54:34 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 09:54:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 1 Sep 2022 09:54:32 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 09:54:27 +0000
Message-ID: <edb52cfe-27c6-547f-962d-cde3a2ef4294@amazon.com>
Date:   Thu, 1 Sep 2022 12:54:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
 <20220830192212.28570-18-farbere@amazon.com>
 <Yw9QAxIn10AKaV74@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9QAxIn10AKaV74@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 3:11 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:10PM +0000, Eliav Farber wrote:
>> Use thermal coefficients from the device tree if they exist.
>> Otherwise, use default values according to the series (5 or 6).
>> All coefficients can be used or only part of them.
>>
>> The coefficients shall be used for fine tuning the default values since
>> coefficients can vary between product and product.
>
> ...
>
>> +     ret = of_property_read_u32(np, "moortec,ts-coeff-h", &coeff_h);
>
> of_ ?! Ditto for the rest.


Fixed for v4.
I replaced it with device_property_read_u32().

>> +     if (!ret)
>> +             ts_coeff->h = coeff_h;
>
> ...
>
>> +     ret = of_property_read_s32(np, "moortec,ts-coeff-j", &coeff_j);
>> +     if (!ret)
>> +             ts_coeff->j = coeff_j;
>
> You may avoid conditional:
>
>        _property_read_s32(..., "moortec,ts-coeff-j", &ts_coeff->j);


Fixed for v4.
I removed the condition.

> ...
>
>> +     ret = of_property_read_u32(np, "moortec,ts-coeff-cal5", 
>> &coeff_cal5);
>> +     if (!ret) {
>
>> +             if (coeff_cal5 == 0) {
>> +                     dev_err(dev, "moortec,ts-coeff-cal5 can't be 
>> 0\n");
>> +                     return -EINVAL;
>> +             }
>
> Code shouldn't be a YAML validator. Drop this and make sure you have 
> correct
> DT schema.


Fixed for v4.
I dropped the validation check.
The YAML already mentions that it can't be 0.

>> +             ts_coeff->cal5 = coeff_cal5;
>> +     }

--
Thanks, Eliav
