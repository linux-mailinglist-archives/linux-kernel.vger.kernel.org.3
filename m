Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB705A9740
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIAMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiIAMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:48:07 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60234C630;
        Thu,  1 Sep 2022 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662036486; x=1693572486;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ehNnTGB/3yBLxo2SXEg809giGBqrupHuGcsiJDh+Mns=;
  b=PQQLP0CKbRKO4bkKttWQPVdLtVEGro3Dvp0Pz9SQ9wIVIhVTDkszozUG
   lQQ5S/R3QdyX3SerLxt65XP810hEvRdDlYOAKsK24yEofSndEyzICSn3B
   kdnct/HWV0cpNGQbtc6E/7RD2ngmgIe4llR6q14OYO2FZ8gY8OchNUOxi
   A=;
Subject: Re: [PATCH v3 12/19] hwmon: (mr75203) fix voltage equation for negative
 source input
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:47:53 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id D3918A28E5;
        Thu,  1 Sep 2022 12:47:51 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 12:47:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 1 Sep 2022 12:47:50 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 12:47:41 +0000
Message-ID: <a05adc0e-35f8-9e77-9e3e-83de851b651b@amazon.com>
Date:   Thu, 1 Sep 2022 15:47:39 +0300
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
 <20220830192212.28570-13-farbere@amazon.com>
 <Yw9OSJogapyla1Jr@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9OSJogapyla1Jr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 3:04 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:05PM +0000, Eliav Farber wrote:
>> According to Moortec Embedded Voltage Monitor (MEVM) series 3 data 
>> sheet,
>> the minimum input signal is -100mv and maximum input signal is +1000mv.
>> When n was small enough, such that PVT_N_CONST * n < PVT_R_CONST it
>> resulted in n overflowing to a very large number (since n is u32 type).
>>
>> This change fixes the problem by casting n to long and replacing shift
>> right with div operation.
>
> Fixes tag?

For v4 I modified the commit message to (hopefully) be more
understandable:

"
According to Moortec Embedded Voltage Monitor (MEVM) series 3 data
sheet, the minimum input signal is -100mv and maximum input signal
is +1000mv.

On 64 bit machines sizeof(u32) = 4 and sizeof(long) = 8.
So when measuring a negative input and n is small enough, such that
PVT_N_CONST * n < PVT_R_CONST, it results in n overflowing to a very
large number which is not negative (because 4 MSB bytes of val are 0).

This change fixes the sign problem and supports negative values by
casting n to long and replacing shift right with div operation.
"


> ...
>
>>               n &= SAMPLE_DATA_MSK;
>> +
>
> Unrelated change.

Removed.

--
Thanks, Eliav
