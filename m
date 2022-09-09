Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742C5B2C29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIICfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIICfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:35:14 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF86BD45;
        Thu,  8 Sep 2022 19:35:10 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 77E8984A5B;
        Fri,  9 Sep 2022 04:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1662690908;
        bh=KZUxrLB9w3Y4O3+rbswXA7Hu2cCIB7pHxP9oYGvuKoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tjTYyVa6jqfR3iUW9w+Lo3UY6twwuQte/MOC9MvZ421VURsZ9rFJXJqM8xsg9Oj/G
         oqc3LE9YH5/iFkXUaNgS4UJcbmtl6HviqogiIOzzlFIneyfS4eyU0JKL8Ovd+HDrHN
         VP77qkEaPCITRI6S168OlwiqTennd5ibc2biPFsrFVBkm3zjwYXdYBA8/i/O9quw9v
         y0L5gBLMxQU7oc+mmZXClR0QPTiSF8ydtADBdRCxH9hSP3+KCdKqGniZ7nK8v3iLWo
         iU4kNmd3OkEhM5TH35ipZ6NETo3fKsmbttE0Tm73sYxPB3TV0QJn0JZFaT//Y2o+RR
         jdam9fKwk1trg==
Message-ID: <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
Date:   Fri, 9 Sep 2022 04:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 04:06, Peng Fan wrote:
>> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
>>
>> On 9/8/22 21:25, Tim Harvey wrote:
>>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 9/8/22 18:00, Tim Harvey wrote:
>>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
>> <mazziesaccount@gmail.com> wrote:
>>>>>>
>>>>>> Hi Tim,
>>>>>>
>>>>>> On 9/2/22 01:23, Tim Harvey wrote:
>>>>>>> Greetings,
>>>>>>>
>>>>>>> I've found that the bd71847 clk driver
>> (CONFIG_COMMON_CLK_BD718XX
>>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
>>>>>>> C32K_OUT
>>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
>>>>>>> the IMX RTC as well as the IMX WDOG functionality.
>>>>>>
>>>>>> //snip
>>>>>>
>>>>>>> This happens via clk_unprepare_unused() as nothing is flagging the
>>>>>>> clk-32k-out as being used. What should be added to the device-tree
>>>>>>> to signify that this clk is indeed necessary and should not be disabled?
>>>>>>
>>>>>> I have seen following proposal from Marek Vasut:
>>>>>>
>>>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
>> marex%40denx.de%2FT%
>>>>>>
>> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=05%7C0
>> 1%7Cp
>>>>>>
>> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
>> 3bc2b
>>>>>>
>> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
>> 7CTWFpb
>>>>>>
>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>> 6
>>>>>>
>> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uF26u9g4onuqCWzPRAvD%2F%
>> 2FLByaEhh5
>>>>>> Dtah9K8CcAOAM%3D&amp;reserved=0
>>>>>>
>>>>>> I am not sure if the discussion is completed though. I guess it was
>>>>>> agreed this was needed/usefull and maybe the remaining thing to
>>>>>> decide was just the property naming.
>>>>>>
>>>>>> Best Regards
>>>>>>            -- Matti
>>>>>>
>>>>>
>>>>> Thanks Matti,
>>>>>
>>>>> Marek - has there been any progress on determining how best to keep
>>>>> certain clocks from being disabled?
>>>>
>>>> No. You can read the discussion above.
>>>
>>> Marek,
>>>
>>> I wasn't on the linux-clk list at that time so can't respond to the
>>> thread but the discussion seems to have died out a couple of months
>>> ago with no agreement between you or Stephen on how to deal with it.
>>>
>>> So where do we take this from here? It looks like there are about 18
>>> boards with dt's using "rohm,bd718*" which would all have non working
>>> RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
>>> arch/arm64/configs/defconfig) right?
> 
> Is there any requirement that the bd718xx clk needs to be runtime on/off?

Yes, the 32kHz clock on BD71xxx should behave like any other clock, 
unless specified otherwise, see below.

> I suppose the clk should always be never be off, if yes, why not have something:

What is needed in this specific case of BD718xx is I think clock 
consumer on the MX8M clock driver side which would claim the 32kHz input 
from the PMIC and up the clock enable count to keep the 32 kHz clock 
always on. The PMIC is most likely supplying 32 kHz clock to the MX8M, 
which if the 32 kHz clock are turned off would hang (I observed that 
before too).

What I tried to address in this thread is a generic problem which 
commonly appears on various embedded systems, except every time anyone 
tried to solve it in a generic manner, it was rejected or they gave up.

The problem is this -- you have an arbitrary clock, and you need to keep 
it running always otherwise the system fails, and you do not have a 
clock consumer in the DT for whatever reason e.g. because the SoC is 
only used as a clock source for some unrelated clock net. There must be 
a way to mark the clock as "never disable these", i.e. critical-clock. 
(I feel like I keep repeating this over and over in this thread, so 
please read the whole thread backlog)
