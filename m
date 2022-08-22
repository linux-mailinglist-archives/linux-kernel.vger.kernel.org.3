Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5750659C0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiHVNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiHVNl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:41:28 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56601835B;
        Mon, 22 Aug 2022 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661175688; x=1692711688;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=I0ZGvHTbcv2oue53quGLVQQ+Ds1q2EaIxM9IzfK2BPM=;
  b=efZKBa9mqMULv0sh33pXNQRAvXz06Lp5YWH2MfHWtwBWhU2XnkiXpVMU
   VPrtjq0B0IvJ+WPTC7Qq2cHPqUPd4v5iIXX4RBcFAMuBhgRbxknwNqvJS
   UYvPO0yPiH+XNwSTCye9TGoVJ/ELwha9gdGEw3nQEQ1Irz8jz2XanHIfe
   w=;
X-IronPort-AV: E=Sophos;i="5.93,255,1654560000"; 
   d="scan'208";a="236024413"
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients from
 device-tree
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:41:14 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com (Postfix) with ESMTPS id DEE4F9A4ED;
        Mon, 22 Aug 2022 13:41:12 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:41:12 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:41:12 +0000
Received: from [10.220.236.67] (10.220.236.67) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 22 Aug 2022 13:41:08 +0000
Message-ID: <20200e60-c4e2-d272-1417-005994766380@amazon.com>
Date:   Mon, 22 Aug 2022 16:41:07 +0300
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
 <20220817054321.6519-15-farbere@amazon.com>
 <20220818202839.GA3431511@roeck-us.net>
 <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
 <20220819113842.GD3106213@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220819113842.GD3106213@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/19/2022 2:38 PM, Guenter Roeck wrote:
> On Fri, Aug 19, 2022 at 10:57:58AM +0300, Farber, Eliav wrote:
>> On 8/18/2022 11:28 PM, Guenter Roeck wrote:
>> > The calculation was just changed to use new defaults in a previous
>> > patch. This patch makes it quite clear that the coefficients
>> > are implementation (?) dependent. So the previous patch just changes
>> > the defaults to (presumably) the coefficients used in your system.
>> > That is inappropriate. Adding non-default corefficients is ok
>> > and makes sense is supported by the chip, but changing defaults
>> > isn't.
>> The calculation was changed in previous patch to match series 5 of the
>> Moortec Embedded Temperature Sensor (METS) datasheet.
>> In our SOC we use series 6 which has a slightly different equation and
>> different coefficients.
>
> If the coefficients are different based on the series, it would probably
> make sense to create a separate devicetree compatible property for 
> series 6
> instead or requiring the user to list the actual coefficients. Those can
> still be present, but the code should be able to use the defaults for
> each series. 
There is a different set of coefficients for series 5 and for series 6,
so it would make sense to add a single property (e.g. series) instead
of adding 4 properties, one for each coefficient.
But that would not always be enough.
The Moortec datasheet explicitly says that coefficients can vary between
product and product, and be different from the default values.
That is the situation in our SOC.
The coefficients we use are slightly different from the defaults for
series 6.
So just adding a single series property would not be enough, and we would
anyway want to have the option to specifically determine the coefficient
values.
Do you suggest to add both, also series and also coefficients? (and I can
fail the probe in case both are set, to avoid conflicts).

--
Thanks, Eliav
