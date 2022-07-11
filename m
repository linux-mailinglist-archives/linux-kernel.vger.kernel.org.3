Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3D56D6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiGKHYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiGKHY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:24:28 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE013FB6;
        Mon, 11 Jul 2022 00:24:26 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BADC24015A;
        Mon, 11 Jul 2022 12:24:21 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1657524262; bh=TM9PHjFhwqnCKFfKFeJ/O4AXSs6yiSWKFZdtW4tUdSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HleYzFOM5qHYA1KyvH8h3iXhrHKMkIrWWvwkKOj5EJ1hYE49Oq2CFe8t0FhtdT0ve
         IzblL86zDpzuKrVnynCiidcH+PwpwlzNuHaDB7j1Xdjl+y0KEwTgwT/mZdRl512nyb
         PTXhcShdrHOn85yBKqgX0mFAjrk7ztJ3dJsBmfRAfzlH3fIMwQeW3HTU8Ln/WCMbbL
         8J1opkiS289BTmOB0uxZjj8q29mPyAh/x2rdT+yrHZ8CLpr88VWYnnF3baiq/H6xha
         Uk2C5lvbycdnDU4YhCPBexo2yBrNCOCmhLcE0fzoUFSGMZVXBJTSyCpOXafJjTXHhJ
         TWluiD7W6VuRg==
MIME-Version: 1.0
Date:   Mon, 11 Jul 2022 12:24:19 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v7 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20220711070349.udyej2qxj2hqyowz@pengutronix.de>
References: <20220612132203.290726-1-nikita@trvn.ru>
 <20220612132203.290726-3-nikita@trvn.ru>
 <20220701075012.xpkcd5xk42frevyq@pengutronix.de>
 <ef73636abfc6df26c249863e0288dc48@trvn.ru>
 <20220711070349.udyej2qxj2hqyowz@pengutronix.de>
Message-ID: <5b2c8ae074ede3263c67381758311398@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-König писал(а) 11.07.2022 12:03:
> On Mon, Jul 11, 2022 at 10:55:09AM +0500, Nikita Travkin wrote:
>> Uwe Kleine-König писал(а) 01.07.2022 12:50:
>> > On Sun, Jun 12, 2022 at 06:22:03PM +0500, Nikita Travkin wrote:
>> >> Some systems have clocks exposed to external devices. If the clock
>> >> controller supports duty-cycle configuration, such clocks can be used as
>> >> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
>> >> similar way and an "opposite" driver already exists (clk-pwm). Add a
>> >> driver that would enable pwm devices to be used via clk subsystem.
>> >>
>> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> >> --
>> >>
>> >> Changes in v2:
>> >>  - Address Uwe's review comments:
>> >>    - Round set clk rate up
>> >>    - Add a description with limitations of the driver
>> >>    - Disable and unprepare clock before removing pwmchip
>> >> Changes in v3:
>> >>  - Use 64bit version of div round up
>> >>  - Address Uwe's review comments:
>> >>    - Reword the limitations to avoid incorrect claims
>> >>    - Move the clk_enabled flag assignment
>> >>    - Drop unnecessary statements
>> >> Changes in v5:
>> >>  - add missed returns
>> >> Changes in v6:
>> >>  - Unprepare the clock on error
>> >>  - Drop redundant limitations points
>> >> Changes in v7:
>> >>  - Rename some variables to be in line with common naming
>> >>
>> >> --
>> >> It seems like my mailserver wasn't able to send the last review
>> >> response to Uwe's so I'll repeat here that afaict clk.h has all the
>> >> methods stubbed out so compiling without HAVE_CLK is possible.
>> >> Sorry for a long delay with sending this since v6.
> 
> FTR: The only problems I have with mail sending in this thread is to
> "devicetree@vger.kernel.or", I added a 'g' for this mail to that address
> :-) Otherwise if you diagnose to have problems with the pengutronix
> server accepting your mail, I'd like to hear about that.

I think the problem for me was that my server, for some reason,
insisted on using ipv6 which it has no access to. I think it might
just be some (very) temporary problem on my end as now the mails go
fine again.

And the missing "g" is just the artifact of me preferring to manually
build the git send-email command every time, then forgetting I made
this typo when replying...

> 
>> >> +	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
>> >> +	if (!pcchip)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	pcchip->clk = devm_clk_get(&pdev->dev, NULL);
>> >
>> > You can use devm_clk_get_prepared() here and drop the clk_prepare()
>> > below and the clk_unprepare in .remove().
>>
>> Here I spent a bit of time trying to remember why I thought
>> I've already looked at this, but after figuring out that this
>> devm helper didn't even exist earlier (I only see it in clk-next)
>> I remembered considering a totally different thing (being
>> clk_disable_unprepare in the _remove, which doesn't play well)
>>
>> Given that this seems to be absent from 5.19-rc6, I'm afraid adding
>> it here will upset the 0day as well as possibly cause issues in case
>> both are taken for the same merge window...
> 
> Pass --base with a sensible parameter to git-format-patch (or
> git-send-email) to make the 0day bots happy.

Thanks for the suggestion!

> 
>> On the other hand it takes me quite a while to provide replies for
>> this series (the trend I'm not happy with) so maybe 3-4 weeks
>> will indeed pass for 5.20-rc1 to have it...
> 
> It's not me who merges PWM patches but Thierry. I don't know his plans
> and if he would be willing to pick up a new driver for the next cycle.
> You might still get lucky with a fast next iteration.
> 
> If you want ignore the devm_clk_get_prepared() suggestion, we can still
> convert to that once both patches hit Linus Torvald's tree.

Yes, I decided to immediately send a v8 instead of giving a bit
of time for the discussion to settle (which seem to often end up
too long) as there was no functional change otherwise.

Thanks,
Nikita

> 
>> I think I will try to send a new version with just the comment
>> added shortly in case it's still not too late for the next merge
>> window and you can feel free to nack it if you think it already is :)
> 
> I think the driver looks good otherwise, so I don't expect to have more
> feedback in the next round.
> 
> Best regards
> Uwe
