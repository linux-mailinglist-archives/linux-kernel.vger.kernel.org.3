Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEF5B2410
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiIHQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiIHQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:56:34 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75EC6B56;
        Thu,  8 Sep 2022 09:55:49 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8984084AEF;
        Thu,  8 Sep 2022 18:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1662656147;
        bh=u3mZ+tnXgTSDTif48CXWvxQ8FMbV9gA9shuGifEl9po=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s4KWNiCWW0z83o+7CuSxFfKTJSyKlDk/WX5MhjD228A9ZVIASiVEhdua2j4cPbH1d
         /0eutYrYlNsgIzcnA4e/5GK1kTGgnjMuhJ6SxfQEBfH262qvc9pKhAdiPvx4YEfhI9
         obEovGUxPrNtOMnqnnJ9NECSBTfRT3xJJprpm7V/cG+O/UYkVQ2h2sRE4+moGUGNcW
         r7zR8eiLnhnAh+bYfurDDY+nf5KSkN/S7FtcWSGUUpLmokvhKu0FTcONx7ZUHp04sL
         imVrVIkbOcvZRtYKhCJK4rIoxIQq7G851lVFOl+NlrdenmwijYsG58PTdeIM68OoKJ
         TFmfY4ma91W3Q==
Message-ID: <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
Date:   Thu, 8 Sep 2022 18:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     Tim Harvey <tharvey@gateworks.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
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

On 9/8/22 18:00, Tim Harvey wrote:
> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> Hi Tim,
>>
>> On 9/2/22 01:23, Tim Harvey wrote:
>>> Greetings,
>>>
>>> I've found that the bd71847 clk driver (CONFIG_COMMON_CLK_BD718XX
>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847 C32K_OUT
>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling the
>>> IMX RTC as well as the IMX WDOG functionality.
>>
>> //snip
>>
>>> This happens via clk_unprepare_unused() as nothing is flagging the
>>> clk-32k-out as being used. What should be added to the device-tree to
>>> signify that this clk is indeed necessary and should not be disabled?
>>
>> I have seen following proposal from Marek Vasut:
>>
>> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
>>
>> I am not sure if the discussion is completed though. I guess it was
>> agreed this was needed/usefull and maybe the remaining thing to decide
>> was just the property naming.
>>
>> Best Regards
>>          -- Matti
>>
> 
> Thanks Matti,
> 
> Marek - has there been any progress on determining how best to keep
> certain clocks from being disabled?

No. You can read the discussion above.
