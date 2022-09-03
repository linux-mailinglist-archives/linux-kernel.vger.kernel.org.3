Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072275AC118
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiICTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:16:27 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55F48E87;
        Sat,  3 Sep 2022 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662232587; x=1693768587;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=+mxLftl+3wE7QOs5f2hh2jMT7OsH6Op/xghcebjhX0E=;
  b=X329k6ssLqs9c7bReipWQ1dHEtEFpYa9bZsjSMXbYn6eZmYkOy9N3QlY
   vs5vbPCOhYZmMY3bOIaDyLXJktUXMq6iPdrSInqNx6tZB/zS3fkbR70ZW
   mM+HzfKgVLcz9ENaKFL2bIVrk/9VpAr/N+CTJtQYdO6cWkMtGb/b8gBm8
   4=;
X-IronPort-AV: E=Sophos;i="5.93,287,1654560000"; 
   d="scan'208";a="237325844"
Subject: Re: [PATCH v3 16/19] dt-bindings: hwmon: (mr75203) add coefficient
 properties for the thermal equation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id 1C1A0C026A;
        Sat,  3 Sep 2022 19:16:12 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sat, 3 Sep 2022 19:16:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Sat, 3 Sep 2022 19:16:12 +0000
Received: from [192.168.97.127] (10.85.143.175) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Sat, 3 Sep 2022 19:16:06 +0000
Message-ID: <1c027a2a-1572-2968-4fbe-3be6c2f966a9@amazon.com>
Date:   Sat, 3 Sep 2022 22:16:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-17-farbere@amazon.com>
 <20220902200353.GA318894-robh@kernel.org>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220902200353.GA318894-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2022 11:03 PM, Rob Herring wrote:
> On Tue, Aug 30, 2022 at 07:22:09PM +0000, Eliav Farber wrote:
>> Add optional temperature coefficient properties:
>>  *) moortec,ts-coeff-g
>>  *) moortec,ts-coeff-h
>>  *) moortec,ts-coeff-cal5
>>  *) moortec,ts-coeff-j
>> If defined they shall be used instead of defaults.
>>
>> The coefficients were added to device tree on top of the series property
>> (which can be used to select between series 5 and series 6), because
>> coefficients can vary between product and product, and code defaults 
>> might
>> not be accurate enough.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V3 -> V2:
>> - Add "moortec" prefix to property name.
>>
>>  .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index ec2dbe7da9c2..a92da6064285 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -74,6 +74,37 @@ properties:
>>      default: 5
>>      $ref: /schemas/types.yaml#definitions/uint32
>>
>> +  moortec,ts-coeff-g:
>> +    description:
>> +      G coefficient for temperature equation.
>> +      Value should be multiplied by factor 1000.
>
> If you just multiply the values here, you can specify 'multipleOf: 1000'
>
Fixed in v4.

> Either way, some constraints would be nice. Or is 0 - 2^32 valid?

g and h can't be 0, and since they must be multiple of 1000 I added:
minimum: 1000
j is negative or 0, so I added:
maximum: 0

>
>> +      Default for series 5 = 60000
>> +      Default for series 6 = 57400
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  moortec,ts-coeff-h:
>> +    description:
>> +      H coefficient for temperature equation.
>> +      Value should be multiplied by factor 1000.
>> +      Default for series 5 = 200000
>> +      Default for series 6 = 249400
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  moortec,ts-coeff-cal5:
>> +    description:
>> +      cal5 coefficient for temperature equation (can't be 0).
>
> minimum: 1 
Fixed in v4.

