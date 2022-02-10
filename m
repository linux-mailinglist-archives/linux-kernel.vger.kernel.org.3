Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64C4B06F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiBJH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:28:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiBJH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:28:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458C6262;
        Wed,  9 Feb 2022 23:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F8761D09;
        Thu, 10 Feb 2022 07:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E796C004E1;
        Thu, 10 Feb 2022 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644478122;
        bh=ivUZB2W0DolffJ9dSW0NWla+NxBAr6g2ORvL3qtg/Uc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZQQi3Cy+znWu/QxZ3iDItHJX+lK8ilYoBBmwWfX7+DHw2sYzbBxknSWaJsMD2c0E+
         xrJCa7E5fz6/QixIwB7CJ/0MmaD7lmqrSc8mGaDGgCR3OZDs6n96+mG+gTHLqOMSWn
         DqkUzpodMpL/wy6kxOP7vYa9H14Q5m1bTKVTXSIgNy3R9ER+x+La44p2PHt86hb28f
         1pUO5p5ffIIDZfeVNEqiibXZm4RFKge6btH836qneXKc1y13PeMJAY3YQI0mxl4Qvw
         AwuH5PCxHM/fYQzJ657yEhYZtNFOQRIBW3S1QYc1l9zTNzVbKCC00Vl0sJ9cSBzI0T
         De925PYktf8AA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YgRBnExwlzI+lPlR@builder.lan>
References: <20220209172513.17873-1-tdas@codeaurora.org> <YgRBnExwlzI+lPlR@builder.lan>
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 09 Feb 2022 23:28:40 -0800
User-Agent: alot/0.10
Message-Id: <20220210072842.3E796C004E1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-02-09 14:35:08)
> On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:
>=20
> > Do not update the transition delay and use the default reset values.
> >=20
> > Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  drivers/clk/qcom/gdsc.c | 6 +++++-
> >  drivers/clk/qcom/gdsc.h | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 7e1dd8ccfa38..e7b213450640 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
> >        */
> >       mask =3D HW_CONTROL_MASK | SW_OVERRIDE_MASK |
> >              EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> > -     val =3D EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> > +
> > +     regmap_read(sc->regmap, sc->gdscr, &val);
> > +
> > +     if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
>=20
> I dug a little bit more into this and noticed that on various platforms
> CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
> hw default and CLK_DIS_WAIT_VAL is 2).
>=20
> I'm not able to find anything helpful in the git log describing what the
> value does, but it seems that a "just use hw default" flag won't cut it
> for this scenario.
>=20

I'd prefer we invert the logic so that we don't need to litter this flag
all over the place. I recall that the wait values were incorrect a long
time ago on early gdsc using designs but hopefully they've been fixed
now and we can simply use the default power on reset (POR) values.
