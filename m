Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316E059C13B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiHVOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiHVOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:00:22 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4B2DA9F;
        Mon, 22 Aug 2022 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661176822; x=1692712822;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=23Pw7AtYUTUUxaVyavtOrUwHZ9/LNGw1p2Y9Jhcb9RA=;
  b=a4Y2bPLBrzyLCljjwj57hmTK/AONPeX+jYYUXIJwuzy1o3YTwVOu19ac
   Qi19rfkoZOh7HJO2vNbGhvMSMTk3ED37sYygaufuwtr4NLrKk8Zuc0HO5
   4e2LZ3sW4/pkNpzsNzTLBjFBo2iuZ7Q1XfPZOZHJQErngvZosQcd9cf2u
   I=;
X-IronPort-AV: E=Sophos;i="5.93,255,1654560000"; 
   d="scan'208";a="251617938"
Subject: Re: [PATCH v2 16/16] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:59:51 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id C1DBF3C008F;
        Mon, 22 Aug 2022 13:59:48 +0000 (UTC)
Received: from EX13D08UEB002.ant.amazon.com (10.43.60.107) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:59:47 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB002.ant.amazon.com (10.43.60.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:59:47 +0000
Received: from [10.220.236.67] (10.220.236.67) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 22 Aug 2022 13:59:43 +0000
Message-ID: <75165e58-8601-1fe5-7bdb-98761a73701f@amazon.com>
Date:   Mon, 22 Aug 2022 16:59:43 +0300
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
 <20220817054321.6519-17-farbere@amazon.com>
 <20220818231106.GA3505191@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220818231106.GA3505191@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/19/2022 2:11 AM, Guenter Roeck wrote:
> On Wed, Aug 17, 2022 at 05:43:21AM +0000, Eliav Farber wrote:
>> This change adds debugfs to read and write TS coefficients - g, h, j and
>> cal5.
>>
>> The coefficients can vary between product and product, so to calibrate
>> them it can be very useful to to be able to modify them on the fly.
>>
>> e.g.
>>
>> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
>> 4096
>>
>> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
>>
>
> What happens if you write 0 into all those attributes, or 0xffffffff ?
The driver equation is:
T = G + H * (n / cal5 - 0.5) + J * F
So I added protection for cal5 not being 0.
Besides that there is no limitation on what these values can be.
I can't really think of any other logical limitation I can apply.

--
Regards, Eliav
