Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F75A7544
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiHaEu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:50:54 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CA44564;
        Tue, 30 Aug 2022 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661921455; x=1693457455;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=v+3gZ3Y+JTHxUSRZI/v4P8At0b05KUmx7oTX8iC8QUQ=;
  b=AjEIihWNu9Aln9Qy5uBDLiEAqQgWzfXWpoMpmRMaFTk+N6Qjp5XEG7G4
   bcO9a6xPJC2/w+9zBU2KUnKKj37CS1CTMEjY+V4Zx+lB6qo5opo3+KQ7S
   6S64A4xBQ6qY9AeKCRO+ufC5qCRSvaXpziCIzvgi4nlyYZmVVT7Ne+m0+
   4=;
X-IronPort-AV: E=Sophos;i="5.93,276,1654560000"; 
   d="scan'208";a="222241247"
Subject: Re: [PATCH v3 03/19] hwmon: (mr75203) update pvt->v_num to the actual number
 of used sensors
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 04:50:53 +0000
Received: from EX13D34EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com (Postfix) with ESMTPS id CBC3B451A6;
        Wed, 31 Aug 2022 04:50:50 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D34EUA003.ant.amazon.com (10.43.165.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 04:50:49 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 04:50:44 +0000
Message-ID: <6413740a-aeed-8696-b5bf-1d96df15d2cc@amazon.com>
Date:   Wed, 31 Aug 2022 07:50:44 +0300
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
 <20220830192212.28570-4-farbere@amazon.com>
 <3a059f0d-708a-91b9-16a0-722c8227d311@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <3a059f0d-708a-91b9-16a0-722c8227d311@roeck-us.net>
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

On 8/31/2022 5:41 AM, Guenter Roeck wrote:
> On 8/30/22 12:21, Eliav Farber wrote:
>> This issue is relevant when "intel,vm-map" is set in device-tree, and
>> defines a lower number of VMs than actually supported.
>>
>> This change is needed for all places that use pvt->v_num later on in the
>> code.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>>   drivers/hwmon/mr75203.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>> index 0e29877a1a9c..f89f7bb5d698 100644
>> --- a/drivers/hwmon/mr75203.c
>> +++ b/drivers/hwmon/mr75203.c
>> @@ -605,6 +605,7 @@ static int mr75203_probe(struct platform_device 
>> *pdev)
>>                                       break;
>>
>>                       vm_num = i;
>> +                     pvt->v_num = i;
>
> How about the existing assignment in the probe function ? 
The probe function uses a local variable vm_num which is also updated
(just one line earlier in code) in the previous patch.

--
Thanks, Eliav
