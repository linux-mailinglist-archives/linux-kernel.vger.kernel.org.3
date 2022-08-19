Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AA599681
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiHSHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbiHSHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:44:27 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B206CE49F;
        Fri, 19 Aug 2022 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660895065; x=1692431065;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=d6POj7xk4cTUM5maaIYL0lltQRs3YIiqOu1HB6fBHwA=;
  b=rPk5xxschdGTpwooa7mS9mgVIAiGDjr0NjN3xAw+d5wtrikE5G83bNaW
   XMX2l/2BsZ92clbBfMJ+Xqo/QMk12AptaUfbpBKH3pFQWYfM04o3lwbfk
   ncqiR9X+6P/oYT2T7YLWEnNqgmfThONZVKf5nCn6M2FdU0rbN9MUP7Ve1
   E=;
X-IronPort-AV: E=Sophos;i="5.93,247,1654560000"; 
   d="scan'208";a="231469330"
Subject: Re: [PATCH v2 12/16] hwmon: (mr75203) modify the temperature equation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 07:44:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 0246745143;
        Fri, 19 Aug 2022 07:44:13 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 19 Aug 2022 07:44:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Fri, 19 Aug 2022 07:44:12 +0000
Received: from [192.168.95.21] (10.85.143.173) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Fri, 19 Aug 2022 07:44:07 +0000
Message-ID: <2cc79934-2280-79e6-6e63-0e3eb7107e1c@amazon.com>
Date:   Fri, 19 Aug 2022 10:44:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dwmw@amazon.co.uk>, <rtanwar@maxlinear.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-13-farbere@amazon.com>
 <20220818202324.GA3431316@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220818202324.GA3431316@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/18/2022 11:23 PM, Guenter Roeck wrote:
> On Wed, Aug 17, 2022 at 05:43:17AM +0000, Eliav Farber wrote:
>> Modify the equation and coefficients to convert the digital output to
>> temperature according to series 5 of the Moortec Embedded Temperature
>> Sensor (METS) datasheet:
>> T = G + H * (n / cal5 - 0.5) + J * F
>>
>> The G, H and J coefficients are multiplied by 1000 to get the 
>> temperature
>> in milli-Celsius.
>>
>
> This is, at the very least, confusing. It doesn't explain the discrepancy
> to the old code nor the change in constant values. I have no idea if this
> change would result in erroneous readings on some other system where
> the existing calculation may be the correct one.

When I tested the driver it was also not clear to me why the equation
and coefficients in the code don't match the specifications in the data
sheet.
I reached out to Maxlinear engineers (@rtanwar) and they also couldn't
explain the discrepancy.
After further correspondence I aligned both the equation and coefficients
in the driver code to the equation and coefficients defined in series 5
of the Moortec Embedded Temperature Sensor (METS) datasheet which they
provided.

> On top of that, it seems overflow-prune in 32 bit systems.

I'll check if it can overflow, and if it can I'll fix in next version.

--
Regards, Eliav

