Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022205A75F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiHaFuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiHaFuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:50:19 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AB92B252;
        Tue, 30 Aug 2022 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661925011; x=1693461011;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=v5WLtmiA60uElHbO672afU0nI01xUx6e43HFm3MS3kQ=;
  b=Y9VGXSuze1+KKlpZYKZpMFs81jTrekku52yblCttb7md9hmyAR2RRWo/
   ES21hDdv2gir+ZM5xL7oEyszHeTwC400zrKsmyZBc2dcHOsx3sE5Q4uWZ
   a5ugSpX6HUjXGinAJKj7FstLqlrah6f9MkTH4YaYxbhlKDYIfOJhNpkAZ
   s=;
X-IronPort-AV: E=Sophos;i="5.93,277,1654560000"; 
   d="scan'208";a="239361161"
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when "intel,
 vm-map" not defined
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:49:58 +0000
Received: from EX13D16EUB004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com (Postfix) with ESMTPS id 551E2120073;
        Wed, 31 Aug 2022 05:49:55 +0000 (UTC)
Received: from EX19D001EUB002.ant.amazon.com (10.252.51.40) by
 EX13D16EUB004.ant.amazon.com (10.43.166.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 05:49:54 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D001EUB002.ant.amazon.com (10.252.51.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 31 Aug 2022 05:49:54 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 05:49:49 +0000
Message-ID: <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
Date:   Wed, 31 Aug 2022 08:49:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
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
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
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

On 8/31/2022 8:36 AM, Guenter Roeck wrote:
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
>
> So all vm_idx values from 0x00 to 0xfe would be acceptable ?
> Does the chip really have that many registers (0x200 + 0x40 + 0x200 * 
> 0xfe) ?
> Is that documented somewhere ? 
According to the code vm_num is limited to 32 because the mask is
only 5 bits:

#define VM_NUM_MSK    GENMASK(20, 16)
#define VM_NUM_SFT    16
vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;

In practice according to the data sheet I have:
0 <= VM instances <= 8

--
Regards, Eliav
