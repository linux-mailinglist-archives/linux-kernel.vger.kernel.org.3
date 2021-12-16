Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8F477C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhLPS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhLPS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4282DC061574;
        Thu, 16 Dec 2021 10:58:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14C661F4A;
        Thu, 16 Dec 2021 18:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27406C36AE2;
        Thu, 16 Dec 2021 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681136;
        bh=AHj4weVPoM6cYgLcJC7t4bmvzX4JMMd+4RHBBWj5svM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dXMPR5Ka7WoznW92aowHh2uMPFUKHi8Me/eeDhy+NAsWcGcDGb3rm8ngxpqjkDV7i
         ifuKATkT1Qx0ELEkoAeci38jsCjFcwXoHPa1WydG8ozX9dWBWUZX4QHDIGHSd4lSdE
         zKHdoBtgTj2lphJqV1tVW0kYK2noJchTHCckhrl9Pq2fKOIEk9ix56zQg6HDaUVgWO
         XOCZl7xGoknBWUm0eqFUcCe377Fbbs4AzG8+8fDVyboexoryt4ojU2lAgPjHVa+zOK
         Vxit7ahCXsD2hElWT1gqTCt+YpaVpSK753NTRsvBdok/h2LyJIcyRfYEjYzOJwTANr
         BWao47hvNEHag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ybqo+wUv6lNT75tJ@ripper>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org> <20211216015136.96AD3C36AE1@smtp.kernel.org> <Ybqo+wUv6lNT75tJ@ripper>
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Nischal <anischal@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 16 Dec 2021 10:58:54 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216185856.27406C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-12-15 18:48:27)
> On Wed 15 Dec 17:51 PST 2021, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2021-12-02 19:56:01)
> > > As GDSCs are turned on and off some associated clocks are momentarily
> > > enabled for house keeping purposes. Failure to enable these clocks se=
ems
> > > to have been silently ignored in the past, but starting in SM8350 this
> > > failure will prevent the GDSC to turn on.
> > >=20
> > > At least on SM8350 this operation will enable the RCG per the
> > > configuration in CFG_REG. This means that the current model where the
> > > current configuration is written back to CF_REG immediately after
> > > parking the RCG doesn't work.
> >=20
> > Just to clarify, is the RCG off and "parked" at XO with the config
> > register dirty and set to the desired frequency and then the RCG is
> > turned on by the GDSC?
> >=20
>=20
> Correct, that's exactly what I'm observing.

Cool can you add that detail to the commit message?

>=20
> > >=20
> > > Instead, keep track of the currently requested rate of the clock and
> > > upon enabling the clock reapply the configuration per the saved rate.
> >=20
> > We already keep track of the requested rate and reapply it on enable,
> > just we're lazy and stash that information in the hardware and not the
> > software. I didn't think the gdsc would be turned on and ruin that all,
> > but it's fair.
> >=20
>=20
> Up until SM8350 I see no evidence that this has been a problem, but now
> it is. So there's likely some changes in the hardware there...
>=20
> > >=20
> > > Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source =
as needed")
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/clk/qcom/clk-rcg.h  |  2 ++
> > >  drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
> > >  2 files changed, 19 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > > index 99efcc7f8d88..6939f4e62768 100644
> > > --- a/drivers/clk/qcom/clk-rcg.h
> > > +++ b/drivers/clk/qcom/clk-rcg.h
> > > @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
> > >   * @freq_tbl: frequency table
> > >   * @clkr: regmap clock handle
> > >   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG=
_REG
> > > + * @current_rate: cached rate for parked RCGs
> > >   */
> > >  struct clk_rcg2 {
> > >         u32                     cmd_rcgr;
> > > @@ -149,6 +150,7 @@ struct clk_rcg2 {
> > >         const struct freq_tbl   *freq_tbl;
> > >         struct clk_regmap       clkr;
> > >         u8                      cfg_off;
> > > +       unsigned long           current_rate;
> > >  };
> > > =20
> > >  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk=
_rcg2, clkr)
> > > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > > index e1b1b426fae4..b574b38dcbd5 100644
> > > --- a/drivers/clk/qcom/clk-rcg2.c
> > > +++ b/drivers/clk/qcom/clk-rcg2.c
> > > @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned =
long parent_rate)
> > >  {
> > >         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> > >         u32 cfg, hid_div, m =3D 0, n =3D 0, mode =3D 0, mask;
> > > +       unsigned long rate;
> > > =20
> > >         regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> > > =20
> > > @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned=
 long parent_rate)
> > >         hid_div =3D cfg >> CFG_SRC_DIV_SHIFT;
> > >         hid_div &=3D mask;
> > > =20
> > > -       return calc_rate(parent_rate, m, n, mode, hid_div);
> > > +       rate =3D calc_rate(parent_rate, m, n, mode, hid_div);
> > > +       if (!rcg->current_rate)
> > > +               rcg->current_rate =3D rate;
> >=20
> > Instead of doing this in recalc_rate, all the time, why not make an init
> > clk op that does it once during registration? The other problem I see is
> > that the rate we calculate may be wrong if the parent is registered
> > after this clk. I think this came up originally when the patch this is
> > fixing was discussed.
> >=20
>=20
> I would need to go back and reproduce the issue I saw, but I had to add
> this because I ended up in clk_rcg2_shared_enable() with current_rate =3D
> 0, which I think would be equally bad to just committing the dirty
> configuration.

Alright.

>=20
> > So instead of saving the current_rate can we save the cfg register value
> > (or however many registers we need) to put back the frequency of the clk
> > to what we want on enable? The other thing is that we made recalc_rate()
> > work "seamlessly" here by stashing the frequency into the register but
> > leaving it uncommitted until enable. We may need to now look at the
> > software copy of the registers in the shared rcg recalc rate operation
> > to figure out what the frequency is.
> >=20
>=20
> I made an attempt at this, the problem I had was to come up within
> something sane for how to deal with set_rate on parked clocks; because
> we need to re-generate the register contents, without writing out the
> value - and that got messy.

Looking back on the introduction of this code[1] I see that it's not
about the rate but more about the parent. i.e. we park the clk on the XO
parent but don't care about the m/n values or pre divider because it
doesn't really matter if the clk is running slowly. So nothing needs to
be saved except for the cfg register, and we can do that in software
with a single u32 instead of using a rate and looking it up and then
reprogramming the other values. We should be able to cache the register
content with an init clk_op.

>=20
> So stashing the frequency turned out to be much cleaner. I believe that
> this is also what they do downstream...
>=20

Downstream doing something isn't a great reason.

[1] https://lore.kernel.org/r/07dbf890975c1178bc4cc2360c25526a@codeaurora.o=
rg
