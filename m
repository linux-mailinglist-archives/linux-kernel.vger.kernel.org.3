Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F05B2DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIIFG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIIFGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:06:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43F125180;
        Thu,  8 Sep 2022 22:06:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bs13so493671ljb.8;
        Thu, 08 Sep 2022 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=cwuBJuMjTVi/CkTAYIXNFMchlYeTZUc9h+0hnqcgwY8=;
        b=hNa/gmW2fGECeFKNYN7A06mLghUODwkhBN/MW1TN2T0bISn5E/GEieGvilhx/RQl5j
         /drIGgF1P8fX6ZFLUmwtgyh9xURlOwT8jljdjNDk/S4Ly5S9BpAD7lYcldKVcnVkZFxu
         fQ5+r4hxWDqSk9L3O5fuQNAene5p95dU3oocR30izhZ5Iq+2hq05yq0qPXju5jFUMAmT
         l6tRBYXvIpsg808XIhac8ECkwbK1kcyjpJmdKxpamdqz4/nekcauLAlAF1K5HTLCBdvV
         MRrzpVKply0tAChYqKruTg/AP826eZMDkAbUK+6Er99YsWoulsaNOouUOtanDkrHxk7s
         7iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cwuBJuMjTVi/CkTAYIXNFMchlYeTZUc9h+0hnqcgwY8=;
        b=XhKQ/Qi6TBPdWUmJZfOprZiBzLtmaCM7sAvcMa9CqJQRLgI052sxkNJS+nj350bwBf
         1W49EFXZXNBeO1K6oJ5N4Ta0FjnACRBZ1TE+8L1JQg63FbL7ds8UwXvhsmDf0bVUZtvR
         tG6rW+1XUOnrxRqjtURmbbNS7aDRWZfcfBqvXLgw6sbJ2sywUNScwQNE+LepmJhRbRJS
         G2FJkPFTrNVgJDcmDL3t/0SBCNjyokpIzEFPW99TpY/4/wiOUWGo90Vn4bp4m+tTf/QU
         CyzLi8omN0l6yBAfDgwI7WWNs+crAwy0ho9P7UUtkFyaLstCkLB9ZRsem8BR5dxtqVqJ
         aXSg==
X-Gm-Message-State: ACgBeo3u09UBZqoFgtsc+/Fg0qV6hoAJZcEIKSBRXIMffCjtopQJk/Bo
        qZZYsobBmwEWahiG9k5Yxto=
X-Google-Smtp-Source: AA6agR5JEptILhAHOQnaAy+7BAcpCBGMG/fJYqDauqR7hQwlxtcaBP6BDcAoY0oSaXDd0Ai6o1g5vg==
X-Received: by 2002:a2e:7309:0:b0:26b:df01:9f03 with SMTP id o9-20020a2e7309000000b0026bdf019f03mr954120ljc.221.1662700010642;
        Thu, 08 Sep 2022 22:06:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512314200b004946a38be45sm123279lfi.50.2022.09.08.22.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:06:49 -0700 (PDT)
Message-ID: <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
Date:   Fri, 9 Sep 2022 08:06:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
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
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
In-Reply-To: <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps,

On 9/9/22 05:35, Marek Vasut wrote:
> On 9/9/22 04:06, Peng Fan wrote:
>>> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT 
>>> failure
>>>
>>> On 9/8/22 21:25, Tim Harvey wrote:
>>>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
>>>>>
>>>>> On 9/8/22 18:00, Tim Harvey wrote:
>>>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Tim,
>>>>>>>
>>>>>>> On 9/2/22 01:23, Tim Harvey wrote:
>>>>>>>> Greetings,
>>>>>>>>
>>>>>>>> I've found that the bd71847 clk driver
>>> (CONFIG_COMMON_CLK_BD718XX
>>>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
>>>>>>>> C32K_OUT
>>>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
>>>>>>>> the IMX RTC as well as the IMX WDOG functionality.
>>>>>>>
>>>>>>> //snip
>>>>>>>
>>>>>>>> This happens via clk_unprepare_unused() as nothing is flagging the
>>>>>>>> clk-32k-out as being used. What should be added to the device-tree
>>>>>>>> to signify that this clk is indeed necessary and should not be 
>>>>>>>> disabled?
>>>>>>>
>>>>>>> I have seen following proposal from Marek Vasut:
>>>>>>>
>>>>>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
>>> marex%40denx.de%2FT%
>>>>>>>
>>> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=05%7C0
>>> 1%7Cp
>>>>>>>
>>> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
>>> 3bc2b
>>>>>>>
>>> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
>>> 7CTWFpb
>>>>>>>
>>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>>> 6
>>>>>>>
>>> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uF26u9g4onuqCWzPRAvD%2F%
>>> 2FLByaEhh5
>>>>>>> Dtah9K8CcAOAM%3D&amp;reserved=0
>>>>>>>
>>>>>>> I am not sure if the discussion is completed though. I guess it was
>>>>>>> agreed this was needed/usefull and maybe the remaining thing to
>>>>>>> decide was just the property naming.
>>>>>>>
>>>>>>> Best Regards
>>>>>>>            -- Matti
>>>>>>>
>>>>>>
>>>>>> Thanks Matti,
>>>>>>
>>>>>> Marek - has there been any progress on determining how best to keep
>>>>>> certain clocks from being disabled?
>>>>>
>>>>> No. You can read the discussion above.
>>>>
>>>> Marek,
>>>>
>>>> I wasn't on the linux-clk list at that time so can't respond to the
>>>> thread but the discussion seems to have died out a couple of months
>>>> ago with no agreement between you or Stephen on how to deal with it.
>>>>
>>>> So where do we take this from here? It looks like there are about 18
>>>> boards with dt's using "rohm,bd718*" which would all have non working
>>>> RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
>>>> arch/arm64/configs/defconfig) right?

Yeah. The ROHM BD71837 and BD71847 (and BD71850 - which is one of the 
variants) are used quite a lot. I am pretty sure not fixing this in 
upstream is increasing downstream solutions. I don't think that should 
be preferred.

>>
>> Is there any requirement that the bd718xx clk needs to be runtime on/off?
> 
> Yes, the 32kHz clock on BD71xxx should behave like any other clock, 
> unless specified otherwise, see below.
> 
>> I suppose the clk should always be never be off, if yes, why not have 
>> something:
> 
> What is needed in this specific case of BD718xx is I think clock 
> consumer on the MX8M clock driver side which would claim the 32kHz input 
> from the PMIC and up the clock enable count to keep the 32 kHz clock 
> always on.

This sounds like a solution that would describe the actual HW setup. I 
don't know the CCF of the i.MX8 well enough to tell whether this can 
ensure the clk is not disabled before the consumer is found or when the 
consumer is going down though. Simplest thing to me would really be to 
just mark the clk as "do-not-touch" one on the boards where it must not 
be touched.

  The PMIC is most likely supplying 32 kHz clock to the MX8M,
> which if the 32 kHz clock are turned off would hang (I observed that 
> before too).
> 
> What I tried to address in this thread is a generic problem which 
> commonly appears on various embedded systems, except every time anyone 
> tried to solve it in a generic manner, it was rejected or they gave up.

I agree with Marek - generic solution would be nice. I don't think this 
is something specific to this PMIC.

> The problem is this -- you have an arbitrary clock, and you need to keep 
> it running always otherwise the system fails, and you do not have a 
> clock consumer in the DT for whatever reason e.g. because the SoC is 
> only used as a clock source for some unrelated clock net. There must be 
> a way to mark the clock as "never disable these", i.e. critical-clock. 
> (I feel like I keep repeating this over and over in this thread, so 
> please read the whole thread backlog)

Thanks for the explanation and effor you did Marek.

My take on this is that from a (generic) component vendor perspective it 
is a bad idea to hard-code the clock status (enable/disable) in the PMIC 
driver. A vendor wants to provide a driver which allows use of the 
component in wide variety of systems/boards. When the PMIC contains a 
clock gate, the PMIC driver should provide the means of controlling it. 
Some setups may want it enabled, other disabled and some want runtime 
control. This "use-policy" must not be hard coded in the driver - it 
needs to come from HW description which explains how the clk line is 
wired and potentially also from the consumer drivers. This enables the 
same PMIC driver to support all different setups with their own needs, 
right?

I am not sure if some non email discussions have been ongoing around 
this topic but just by reading the emails it seemed to me that Marek's 
suggestion was acked by the DT folks - and I don't think that Stephen 
was (at the end of the day) against that either(?). Maybe I missed 
something.

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
