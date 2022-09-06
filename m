Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A4B5AE981
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiIFN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIFN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:27:37 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C174344;
        Tue,  6 Sep 2022 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662470857; x=1694006857;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=sF3J0DvAFmf+1chUjcEM/OKumVw8TQqkjuzmkV8fGV4=;
  b=f/Y9ViGb+sYCHbDO10/2hYyLlbq9NAMMZ0R/UjVO3WYGXNLqOy0JYGX6
   m7jMrRgqssWgNWgKcktGCSd6uXmRr1xl9g2wqaXkChptnDCN2dR7Uz5XY
   emKB9YMrsEJ/+GdLzLyWqwNVcRWEiwa8zK8IWJjVjCadRe3pe3avu+wxa
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,294,1654560000"; 
   d="scan'208";a="223732076"
Subject: Re: [PATCH v4 05/21] hwmon: (mr75203) fix voltage equation for negative
 source input
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:27:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com (Postfix) with ESMTPS id 963E144F98;
        Tue,  6 Sep 2022 13:27:19 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 6 Sep 2022 13:27:18 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 6 Sep 2022 13:27:18 +0000
Received: from [192.168.154.114] (10.85.143.177) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Tue, 6 Sep 2022 13:27:14 +0000
Message-ID: <29fa5c01-aad0-04ff-e1a9-1510858eff7e@amazon.com>
Date:   Tue, 6 Sep 2022 16:27:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-6-farbere@amazon.com>
 <Yxc3GeFc5gDKrYyP@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yxc3GeFc5gDKrYyP@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2022 3:03 PM, Andy Shevchenko wrote:
> On Tue, Sep 06, 2022 at 08:33:40AM +0000, Eliav Farber wrote:
>> According to Moortec Embedded Voltage Monitor (MEVM) series 3 data
>> sheet, the minimum input signal is -100mv and maximum input signal
>> is +1000mv.
>>
>> The equation used to convert the digital word to voltage uses mixed
>> types (*val signed and n unsigned), and on 64 bit machines also has
>> different size, since sizeof(u32) = 4 and sizeof(long) = 8.
>>
>> So when measuring a negative input, n will be small enough, such that
>> PVT_N_CONST * n < PVT_R_CONST, and the result of
>> (PVT_N_CONST * n - PVT_R_CONST) will overflow to a very big positive
>> 32 bit number. Then when storing the result in *val it will be the same
>> value just in 64 bit (instead of it representing a negative number which
>> will what happen when sizeof(long) = 4).
>>
>> When -1023 <= (PVT_N_CONST * n - PVT_R_CONST) <= -1
>> dividing the number by 1024 should result of in 0, but because ">> 10"
>> is used it results in -1 (0xf...fffff).
>>
>> This change fixes the sign problem and supports negative values by
>> casting n to long and replacing the shift right with div operation.
>
> This is really downside of C...
>
> ...
>
>> -             *val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
>> +             *val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << 
>> PVT_CONV_BITS);
>
> Wondering if we can use BIT(PVT_CONV_BITS) for two (quite unlikely to 
> happen,
> I hope) purposes:
>
> 1) Somebody copies such code where PVT_CONV_BITS analogue can be 31,
>   which is according to C standard is UB (undefined behaviour).
>
> 2) It makes shorter the line and also drops the pattern where some
>   dumb robot may propose a patch to basically revert the division
>   change. 
I originally tried to use BIT(PVT_CONV_BITS) but it gave a different
result.
e.g.
If n = 2720
*val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << PVT_CONV_BITS) = 0
*val = (PVT_N_CONST * (long)n - PVT_R_CONST) / BIT(PVT_CONV_BITS) = 
18014398509481983

I can try fitting it in one line, either by adding a define for
(1 << PVT_CONV_BITS) or exceeding 80 characters, but keep in mind that
in a later patch (#15) it gets even longer (and I must use more than
one line) since it is multiplied by a pre-scaler factor.

--
Regards, Eliav
