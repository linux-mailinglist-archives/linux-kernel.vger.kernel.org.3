Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687CF4BC8C3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbiBSNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 08:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiBSNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 08:55:08 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FA1A2774;
        Sat, 19 Feb 2022 05:54:46 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E4BF5403F2;
        Sat, 19 Feb 2022 18:54:40 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645278882; bh=FkC6NFqmywpOwa4XAmaTo8rLxho52gFHok8cO4GwSY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KaICIyvngb7glnGwaBDP4yreBTZ7ftfx5XJp96kbpNn09hgHxsT1kt4fKmTTHkJBF
         pqLzi/afSBxzlRGp/NjJNqaC1Uo0RJMHANu9g6lK1vwTbSC25r1dSzCcospOTa25EI
         QnODySW/YWJ6e8Q6fiWX51TL2+2BPe2ZDLZ3e1sIf/nfbxwpKNaP9ESnBUDKcSyufD
         rMkan0Wm6joaScvpJApWG+IF3/nBzbBsVEkTSl6wLxcvc3UBLT+212e2RsBS5WNJvH
         +2D1ivNq7SFJguxdNFVY3GmSIRQV5ZL98+PzOmmqgvAqd/+cJlBK56bBe52euq7Zaw
         3MfWrQeRksZ7g==
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 18:54:40 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20220219101049.erwzy5mpmsfgcwjy@pengutronix.de>
References: <20220212162342.72646-1-nikita@trvn.ru>
 <20220212162342.72646-3-nikita@trvn.ru>
 <20220214184320.ym36pfvozwdp5nbb@pengutronix.de>
 <425691dbe49115f04dbe89c158bf6d1c@trvn.ru>
 <20220219101049.erwzy5mpmsfgcwjy@pengutronix.de>
Message-ID: <086f021bd11b7a730445250db2af01e8@trvn.ru>
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

Uwe Kleine-König писал(а) 19.02.2022 15:10:
> Hello,
> 
> On Sat, Feb 19, 2022 at 11:46:31AM +0500, Nikita Travkin wrote:
>> Uwe Kleine-König писал(а) 14.02.2022 23:43:
>> > On Sat, Feb 12, 2022 at 09:23:42PM +0500, Nikita Travkin wrote:
>> >> + * Limitations:
>> >> + * - Glitches are possible when new pwm state is applied.
>> >> + * - Due to the fact that exact behavior depends on the underlying
>> >> + *   clock driver, various limitations are possible.
>> >> + * - Period depends on the clock and, in general, not guaranteed.
>> >
>> > This sentence is broken.
>> >
>>
>> Here what I mean is that the clock driver might e.g. have a lookup table
>> for some rates and will only set one close to the requested ones.
>> (Extreme scenario is that only one rate is allowed in the lookup table,
>> which is a real possibility for some platforms that I think this driver
>> will be used with, the lookup may need to be changed for those clocks)
>>
>> I will reword this like:
>>
>>   Some clock drivers may only pick the closest available rate
>>   and not the exact requested one. Because of this, exact period
>>   is not guaranteed.
> 
> That there is no exact match is quite normal also for dedicated PWM
> HW blocks. So I think the second item in your list is good enough to
> cover the non-existing guaranteed for period and glitches.
> 

Oh, I will just drop the 1 (glitches) and 3 (period) then.
Thanks for explaining!

Nikita

> Best regards
> Uwe
