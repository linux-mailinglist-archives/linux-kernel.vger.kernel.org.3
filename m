Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BC4DA5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiCOWxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiCOWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:53:47 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A456C21;
        Tue, 15 Mar 2022 15:52:34 -0700 (PDT)
Received: from [77.244.183.192] (port=63206 helo=[192.168.178.39])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nUG1o-0007pT-2P; Tue, 15 Mar 2022 23:52:32 +0100
Message-ID: <59ee78c2-7d05-6d97-1ff2-36ea326be188@lucaceresoli.net>
Date:   Tue, 15 Mar 2022 23:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on
 5p49v6965
Content-Language: en-US
To:     "Fillion, Claude" <Claude.Fillion@mksinst.com>,
        Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Cc:     "aford@beaconembedded.com" <aford@beaconembedded.com>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
References: <20220313115704.301718-1-aford173@gmail.com>
 <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
 <MN2PR03MB5008F8DDC6DD934074EBBC0E93109@MN2PR03MB5008.namprd03.prod.outlook.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <MN2PR03MB5008F8DDC6DD934074EBBC0E93109@MN2PR03MB5008.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claude,

[adding Marek in Cc:, the original author of the driver and also of the
frequency doubler]

On 15/03/22 20:34, Fillion, Claude wrote:
> Hello Luca,
> 
> I will defer to Adam, but a few comments:
> 
>> -----Original Message-----
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>> Sent: Tuesday, March 15, 2022 4:55 AM
>> To: Adam Ford <aford173@gmail.com>; linux-clk@vger.kernel.org
>> Cc: aford@beaconembedded.com; cstevens@beaconembedded.com;
>> Fillion, Claude <Claude.Fillion@mksinst.com>; Michael Turquette
>> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; linux-
>> kernel@vger.kernel.org
>> Subject: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL
>> on 5p49v6965
>>
>> This email originated outside of MKS.  Use caution when sharing information
>> or opening attachments and links.
>>
>> ----------------------------------------------------------------------------------------------
>> ----------------------------------------------
>> Hi Adam, Claude,
>>
>> thanks for your patch.
>>
>> On 13/03/22 12:57, Adam Ford wrote:
>>> The 5p49v6965 has a reference clock frequency doubler.
>>> Enabling it adds versaclock_som.dbl to the clock tree, but the output
>>> frequency remains correct.
>>>
>>> Suggested-by: Claude Fillion <Claude.Fillion@mksinst.com>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>
>>> diff --git a/drivers/clk/clk-versaclock5.c
>>> b/drivers/clk/clk-versaclock5.c index e7be3e54b9be..4d190579e874
>>> 100644
>>> --- a/drivers/clk/clk-versaclock5.c
>>> +++ b/drivers/clk/clk-versaclock5.c
>>> @@ -1211,7 +1211,7 @@ static const struct vc5_chip_info
>> idt_5p49v6965_info = {
>>>  	.model = IDT_VC6_5P49V6965,
>>>  	.clk_fod_cnt = 4,
>>>  	.clk_out_cnt = 5,
>>> -	.flags = VC5_HAS_BYPASS_SYNC_BIT,
>>> +	.flags = VC5_HAS_BYPASS_SYNC_BIT | VC5_HAS_PFD_FREQ_DBL,
>>
>>
>> If my understanding is correct, the doubler is not mentioned by the
>> datasheet, but it exists. Maybe it's worth a line of comment to help future
>> readers not waste their time in finding out:
>>   /* Frequency doubler not mentioned on datasheet */
>>
> 
> I see the doubler bit mentioned in Table 25 of both v6 and v6e specs.  It is named differently, but appears to have the same purpose. 

Well, literally speaking what I wrote is correct: the _datasheet_ does
not mention the doubler. Table 25 you mention is on the "Register
Description and Programming Guide".

Practically speaking I would expect the datasheet to mention the
hardware blocks including the doubler, but apparently Renesas has a
different opinion and perhaps they are not alone.

So I think you can forget about my proposal to add a comment.

>> Can you confirm that:
>>  - the en_ref_doubler bit value defaults to zero when reading it, as the
>>    register guide says?
>>  - if set to 1 the frequencies double?
>>
>> With that confirmed, the patch looks good.
>>
>> Thanks,
>> --
>> Luca
> 
> I played around a bit with the programming board today and did not see what I expected to see.
> 
> Using i2cget I see that the register in question (0x10) has a default value of 0xA0 for both 6901 and 6965.  Thus it seems disabled by default for both parts.

Coherently with the Register guide. OK.

> Starting at my base frequency of 46.8MHz, setting the bit to 1 (i2cset)  changes the output  frequency to 59.04MHz for the 6901 part, and to 47.7MHz for the 6965 part.  So setting the 'doubler' bit changes output frequency for both parts, but not the same amount.
> 
> Not sure of the meaning, just want to pass the information along.

Me neither.

I have no clever idea, only this one that I consider unlikely: by
enabling the doubler you may have increased some internal frequency
above its allowed range and thus the chip is not working properly
anymore. Can you use a lower base frequency or check the PLL settings to
ensure you are not exceeding some range?

What output frequency are you measuring? OUT0 or another one? What
frequency do you measure with en_ref_doubler = 0?

-- 
Luca
