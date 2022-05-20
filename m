Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8F52E74B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiETI1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiETI1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:27:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8F1CFC6;
        Fri, 20 May 2022 01:27:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BEEBD1F460E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653035268;
        bh=dz33bLK81tDx68GO0e3Igt9ot4jToawO0qhzv26u9x0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SiCuENmyBtMOhZ3WnQCd6TbHHwr8v9Ghet/cZgL5zzy61AwNFg3q46Vd3fFb3Hoj7
         uQHrClCDeaOtd9ESeItb/40eROqK/lHExkxX77EVHiIiBT+Q9JrH+aCN3zPx+pIhWO
         mh6rFUfpf2VXr31vLHGwWErD6IVlUbj2OPFHpjF6BVBT0OggTbqDE72LGox3PlC/Hl
         8S0QsZQOffulnBZdLznibQWK6TEyLm5OZNJ/GsGMoMfNTkMC3bNIn3QTel5OM5qrZQ
         D3BJuv5JtL4CUY4DRytIhD+7opF48qkm+CP7nizwIFM7/z/UOO1v3+O3STbU3RdzK9
         Z6jWXwoin7vrQ==
Message-ID: <c2f347cb-b887-d67f-d7be-569fbd2660d8@collabora.com>
Date:   Fri, 20 May 2022 10:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: mediatek: Fix unused 'ops' field in mtk_pll_data
Content-Language: en-US
To:     Boris Lysov <arz65xx@gmail.com>
Cc:     arzamas-16@mail.ee, mturquette@baylibre.com, sboyd@kernel.org,
        matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220515122409.13423-1-arzamas-16@mail.ee>
 <ead37cb0-c841-df1a-ca10-a396b5e9951c@collabora.com>
 <20220519222755.127ebbb8@pc>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519222755.127ebbb8@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 21:27, Boris Lysov ha scritto:
> Hello, Angelo!
> 
> On Wed, 18 May 2022 14:15:13 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Il 15/05/22 14:24, Boris Lysov ha scritto:
>>> From: Boris Lysov <arzamas-16@mail.ee>
>>>
>>> Allow to specify optional clk_ops in mtk_pll_data which will be picked up in
>>> mtk_clk_register_pll. So far no already supported Mediatek SoC needs
>>> non-default clk_ops for PLLs but instead of removing this field it will be
>>> actually used in the future for supporting older SoCs (see [1] for details)
>>> with quirky PLLs.
>>>
>>
>> Hello Boris,
>>
>> I disagree about this change and would rather see the ops pointer removed
>> with fire.
>>
>> I got that you're trying to do something about "quirky PLLs", but is it
>> really about the PLLs that you're mentioning being "quirky", or are they
>> simply a different IP?
> 
> To be honest I don't know exactly. mt6577 seems to share some common IP
> patterns such as splitting the entire clock system into few smaller subsystems
> such as apmixed (PLLs), topckgen (mux control), infra- and pericfg (internal
> and peripheral gate control). On the other hand, mt6577 is quite an old SoC
> (more on that in the end) and there are some differences about its operation
> compared to modern SoCs and their drivers.
> 
>> Also, if it's just about a bit inversion and a bigger delay:
>> 1. Bigger delay: Depending on how bigger, we may simply delay more by default
>>      for all PLLs, even the ones that aren't requiring us to wait for longer...
>>      ...after all, if it's about waiting for 10/20 *microseconds* more
>> { snip }
> 
> According to the mt6577 datasheet the largest settling time is 10
> *milli*seconds for AUDPLL [1]. In my opinion this is way too much to be set as
> default for all mediatek devices.
> 

Wow. 10ms is a huge wait! That doesn't *feel* right, but if that's what it is...
Perhaps we should look into that AUDPLL matter later, as audio is one kind of
functionality that you want to enable in the immediate term - I agree it's a
nice to have, but bringing up the platform comes first, and this means the top
clock controllers and eventually multimedia (to get a display up!).

>> 2. Bit inversion: that can be solved simply with a flag in the
>> prepare/unprepare ops for this driver... and if you want something that
>> performs even better, sparing you a nanosecond or two, you can always assign
>> an "inverted" callback for managing that single bit;
> 
> Not all mt6577 PLLs need bit inversion. 2 PLLs follow the common flow (set a
> CON0_PWR_ON bit to start). 6 PLLs set this bit to 0 to start. And 1 PLL (which
> is actually a DDS) needs to write a magic value to specific register (in
> apmixed region) to start.

That's interesting.

> Is very unfortunate that I can't directly link the vomit-inducing downstream
> code to prove the PLL situation due to its licensing but it's publicly
> available on the internet [2] as a part of device manufacturers' obligations to
> publish source code.
> 
>> 3. Different IP: mtk_clk_register_(name-of-the-new-ip)_pll() - I don't think
>> that there's anything to explain to that one.
> In my opinion this would introduce more duplicate code than just letting a
> developer set custom clk_ops for a specific platform.
> 
> Huge thanks for your feedback!
> 
> P.S As I said above, mt6577 is old and in its current state [3] it's closer to
> being a personal project than a serious mainlining attempt. I share and agree
> with your opinion [4] on e-waste and is why I'm trying to put an effort into it.
> What I don't have enough of is time and, sadly, expertise. Maybe it'd be better
> for me to stay on github.
> 

Your contribution is definitely welcome and you shouldn't worry about having
a relatively low amount of time to spend on these things - that's a very common
(non)issue among contributors.

A community works like a community: it's not everything on your shoulders!
That's why the maintainers are here, that's why I'm here and that's also why
other people are here. Everyone of us gives some little bit and, at the end of
the day, all these little bits come together to form an entire kernel :-)

Therefore, I encourage you (and anyone else reading this) to keep sharing your
valuable contributions to the mailing lists as much as you want to.


That said, let's get back in topic, shall we?
I feel the various concerns that you've raised relative to this PLL matter, I
know that older MediaTek SoCs look a bit strange in regard to some clocks and
other things, but that obviously doesn't mean that there's no way to do things
properly or anyway in a way better manner.

Here's my proposal:
Try upstreaming the top, very necessary, clocks to achieve a full console boot,
as this gives you a good chance to start landing some solid and critical base
for your platform.

The top clocks should have most of the PLLs, but you can avoid adding some that
are a bit problematic, such as that AUDPLL that you were talking about... in my
opinion, at least, it's not a big deal if we add these PLLs later when enabling
more functionality: that will give you the chance to add the PLLs that are in
need of that "enable bit inversion" logic which, from what I understand from
your words, covers 6 to 8 PLLs. That's a lot, because that makes you able to
add all of the clocks that are in infra, top, mfg, apmixed: like that, you're
also getting most of the IP up (timers, i2c, spi, mtk-sd for your eMMC/uSD).

Do it step by step - me and other developers will give you reviews and probably
make you go through some iterations of your driver, and that's to make sure that
your contribution will be valuable for a long time (and will not get broken, and
will not be useless after few months).


Cheers,
Angelo

