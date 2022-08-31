Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10755A7530
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiHaEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiHaEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:36:47 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A0AA3EE;
        Tue, 30 Aug 2022 21:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661920607; x=1693456607;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=sjR3Z4/vcFYlyZ27xao2C3hh8wW4wj74snfVdsHhRx0=;
  b=iTeHqULVq1zVCrXzb2uxQuVDZBL0ocbJmOlnSYUcyzrQXqrXNOylb3Nw
   mC/N0psttuo6xd+1nM9vKXznvTqiuBCuQl+JSSdJ1m117H/V3apwbzwC6
   amPTxG0v5VCULCBl14w3YUj3v+5LV4UZ51E/akuDWoXZ82J7FElAfDK20
   w=;
X-IronPort-AV: E=Sophos;i="5.93,276,1654560000"; 
   d="scan'208";a="222238921"
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when "intel,
 vm-map" not defined
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:36:31 +0000
Received: from EX13D48EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id C84AB14109E;
        Wed, 31 Aug 2022 04:36:27 +0000 (UTC)
Received: from EX19D005EUA004.ant.amazon.com (10.252.50.241) by
 EX13D48EUA002.ant.amazon.com (10.43.165.27) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 04:36:26 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D005EUA004.ant.amazon.com (10.252.50.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 04:36:26 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 04:36:21 +0000
Message-ID: <644bd790-ce9d-822b-50a1-ad4e94ec0958@amazon.com>
Date:   Wed, 31 Aug 2022 07:36:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, <jdelvare@suse.com>,
        <robh+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <rtanwar@maxlinear.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <ronenk@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <shorer@amazon.com>, <amitlavi@amazon.com>,
        <almogbs@amazon.com>, <dkl@amazon.com>,
        <andriy.shevchenko@intel.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <bd510d56-b161-ff17-8a09-ed4a8a66ca57@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <bd510d56-b161-ff17-8a09-ed4a8a66ca57@roeck-us.net>
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

On 8/31/2022 5:39 AM, Guenter Roeck wrote:
> On 8/30/22 12:21, Eliav Farber wrote:
>> Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
>> to 0, and no voltage channel infos are allocated.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>>   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>>   1 file changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>> index 046523d47c29..0e29877a1a9c 100644
>> --- a/drivers/hwmon/mr75203.c
>> +++ b/drivers/hwmon/mr75203.c
>> @@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device 
>> *pdev)
>>       }
>>
>>       if (vm_num) {
>> -             u32 num = vm_num;
>> -
>>               ret = pvt_get_regmap(pdev, "vm", pvt);
>>               if (ret)
>>                       return ret;
>> @@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device 
>> *pdev)
>>               ret = device_property_read_u8_array(dev, "intel,vm-map",
>> pvt->vm_idx, vm_num);
>>               if (ret) {
>> -                     num = 0;
>> +                     /*
>> +                      * Incase intel,vm-map property is not defined, we
>> +                      * assume incremental channel numbers.
>> +                      */
>> +                     for (i = 0; i < vm_num; i++)
>> +                             pvt->vm_idx[i] = i;
>>               } else {
>>                       for (i = 0; i < vm_num; i++)
>>                               if (pvt->vm_idx[i] >= vm_num ||
>> -                                 pvt->vm_idx[i] == 0xff) {
>> -                                     num = i;
>> +                                 pvt->vm_idx[i] == 0xff)
>>                                       break;
>> -                             }
>> -             }
>>
>> -             /*
>> -              * Incase intel,vm-map property is not defined, we assume
>> -              * incremental channel numbers.
>> -              */
>> -             for (i = num; i < vm_num; i++)
>> -                     pvt->vm_idx[i] = i;
>> +                     vm_num = i;
>> +             }
>>
>
> So this is actually a functional change: In the old code, unspecified 
> channel
> numbers (num ... vm_num) were filled with incremental channel numbers.
> This is no longer the case.
>
The only place that uses pvt->vm_idx[] besides setting it in the probe
function is pvr_read_in().
It is quite clear from pvr_read_in() that unspecified channel numbers
(num ... vm_num) are not accessed, therefore there is also no need to
set them.

     if (channel >= pvt->v_num)
         return -EINVAL;

     vm_idx = pvt->vm_idx[channel];

Therefore I removed the setting of unspecified channels, and only if
“intel,vm-map” property is not defined, I set the specified channels
in incremental order.

>> -             in_config = devm_kcalloc(dev, num + 1,
>> +             in_config = devm_kcalloc(dev, vm_num + 1,
>>                                        sizeof(*in_config), GFP_KERNEL);
>
> The relevant difference (and maybe bug in the existing code ?) seems 
> to be
> this change. Have you considered leaving everything else in place and 
> only
> changing this code as well as the num -> vm_num changes below ?

Yes, using vm_num instead of num (which will be 0 if “intel,vm-map”
property is not defined) is the actual fix.
Both changes seemed to me to be coupled but if you think it will be
more clear to split this patch to two, first that removes unnecessary
setting of unspecified channels, and second that changes num to vm_num
for in_config, then sure I will do it.

--
Thanks, Eliav

