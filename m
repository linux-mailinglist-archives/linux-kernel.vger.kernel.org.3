Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6F48BD86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiALDGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347731AbiALDGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:06:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B2C06173F;
        Tue, 11 Jan 2022 19:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D821B81DA5;
        Wed, 12 Jan 2022 03:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17569C36AEB;
        Wed, 12 Jan 2022 03:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641956764;
        bh=zki247rmLODdkQj3pLKnVdNIAgFXqIuIAfHlqbqgraM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WhMoy39pDXaQ2/HKJSbTsmar8xEUWNNUr5gUrnczMg84ByrkAPnV9RpgNHvDS2qQt
         WKeDSj5FGrPUPFMdUavpB3gUTpyn53U0gKwTDmjm8UwzAiXxnaXs8OQRh7xxQ20EVh
         A6odeRn4fjcr1pMuiq8qhbrlt3EyAM4pvB4Gu9ZPla/QsBiAdnTylq/Agv4X1ylhls
         WPnj+kC7759Sba5XOnAxIkoSG0cYlTvKes8wDdl3/dFMdwPiG3fbQ2ciJfsiYiqzRb
         MnAlnqlqLtvrDaKgnQIFY6FEkdN54aJ9retauZATrHkUGJHPLpUc+Umt1BLfNDIrVp
         B+C5LFm0vhJlg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbwMoIybSUAteBzV@yoga>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org> <20211216015136.96AD3C36AE1@smtp.kernel.org> <Ybqo+wUv6lNT75tJ@ripper> <20211216185856.27406C36AE2@smtp.kernel.org> <YbvMkIhdsGdCfvFV@ripper> <20211217014521.55CD4C36AE0@smtp.kernel.org> <YbwMoIybSUAteBzV@yoga>
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Nischal <anischal@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 11 Jan 2022 19:06:02 -0800
User-Agent: alot/0.9.1
Message-Id: <20220112030604.17569C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-16 20:05:52)
> On Thu 16 Dec 19:45 CST 2021, Stephen Boyd wrote:
> > > >=20
> > > > >=20
> > > > > > So instead of saving the current_rate can we save the cfg regis=
ter value
> > > > > > (or however many registers we need) to put back the frequency o=
f the clk
> > > > > > to what we want on enable? The other thing is that we made reca=
lc_rate()
> > > > > > work "seamlessly" here by stashing the frequency into the regis=
ter but
> > > > > > leaving it uncommitted until enable. We may need to now look at=
 the
> > > > > > software copy of the registers in the shared rcg recalc rate op=
eration
> > > > > > to figure out what the frequency is.
> > > > > >=20
> > > > >=20
> > > > > I made an attempt at this, the problem I had was to come up within
> > > > > something sane for how to deal with set_rate on parked clocks; be=
cause
> > > > > we need to re-generate the register contents, without writing out=
 the
> > > > > value - and that got messy.
> > > >=20
> > > > Looking back on the introduction of this code[1] I see that it's not
> > > > about the rate but more about the parent. i.e. we park the clk on t=
he XO
> > > > parent but don't care about the m/n values or pre divider because it
> > > > doesn't really matter if the clk is running slowly. So nothing need=
s to
> > > > be saved except for the cfg register, and we can do that in software
> > > > with a single u32 instead of using a rate and looking it up and then
> > > > reprogramming the other values. We should be able to cache the regi=
ster
> > > > content with an init clk_op.
> > > >=20
> > >=20
> > > So you're suggesting that, in clk_rcg2_shared_set_rate(), when the RCG
> > > is found to be disabled, I should write out M, N, D and calculate a n=
ew
> > > cfg value which I stash until the next enable?
> > >=20
> > > Looks a little bit messy, but I will give it a try.
> >=20
> > No. I don't see where clk_rcg2_shared_set_rate() needs to change.
> >=20
> > I'm suggesting we cache the config register on disable so it can be
> > restored on enable. Basically everything is the same except now we don't
> > write the cfg register and leave it dirty in the hardware. We need a
> > shared rcg version of recalc rate that looks at the shadow cfg register
> > instead of reading the hardware because we've changed the parent behind
> > the back of the framework and we want to make it look like nothing has
> > changed.=20
> >=20
>=20
> I see, that was my first attempt of an implementation as well.
>=20
> The problem I ran into right away was that i had something that did
> disable(), set_rate(), enable() and I would restore the wrong settings.
>=20
> So clk_rcg2_shared_set_rate() needs to update the stashed cfg value -
> and it needs to write out M, N and D if we're not caching those.
>=20
> > This is all based on my understanding that the problem is the RCG is
> > changing rate due to the gdsc turning on the clk for us. So we can't
> > leave anything dirty in the hardware and have to keep it in software.
> > I hope the change is minimal.
>=20
> That's my understanding as well.
>=20
>=20
> Looking more at the code I think it's possible that we get disable(),
> set_parent(), enable() as well; which if that's the case would result
> in the same problem, so I assume I need to tend to that as well.

Hopefully we can write the M, N, D and pre-divier values all the time
and avoid writing the parent selection register (the cfg one) when the
clk is off. It would mean that the "safe parent" of XO is getting
divided pretty heavily sometimes but I suspect it doesn't matter in
practice. When the clk is enabled in the kernel, we'll move the parent
over by making the cfg register have the right parent selectoin and then
the mnd and divider would already be what they're supposed to be in the
hardware. Does that work?
