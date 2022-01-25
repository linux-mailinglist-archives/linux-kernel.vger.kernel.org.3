Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA849BE57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiAYWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:18:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46710 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiAYWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:18:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 440BBB81B75;
        Tue, 25 Jan 2022 22:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B78C340E0;
        Tue, 25 Jan 2022 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643149106;
        bh=YVyYSfcEbGqrd42MxRnKj9Y7w9N7kkEnC3ipr7yb7eo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=okzIC0QqkLEW5Xru2kBPMD5aFVpb/Pst5GIxGVa+IpAvuivVVn8SRxa21vdEIanyu
         xkNNvrtqETC/DtFwExZBC2/gVYuwEoMxW6xgzl0KUWrymTPnCI+/Df8e1+FlHdvt/h
         kH9ObHvff0TVtjg2COUibTfCMsh6VvhoK1+awzFgxb3aSyLC7dtOj2KX5BZX8SkzP4
         0ONlKXvo00xAzSmfNJS9SvpgH0wnlrDY7id5kXOWzx9wEjoZipPUjP20puoe6yDYDj
         tg68l1+d18MhwGxcgBV5EGyF1WiqiPmvXo8rcAfFHliHyTJgy5lTxMFTFl3TIaT6/e
         ZleBZ26cTgU9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <61f065b9.1c69fb81.ed14d.b9e2@mx.google.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com> <20220121210340.32362-11-ansuelsmth@gmail.com> <20220125204555.91DB4C340E0@smtp.kernel.org> <61f065b9.1c69fb81.ed14d.b9e2@mx.google.com>
Subject: Re: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 25 Jan 2022 14:18:24 -0800
User-Agent: alot/0.10
Message-Id: <20220125221825.D9B78C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-01-25 13:03:52)
> On Tue, Jan 25, 2022 at 12:45:53PM -0800, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-01-21 13:03:35)
> > > Add additional freq supported for the sdc table.
> > >=20
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/clk/qcom/gcc-ipq806x.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ip=
q806x.c
> > > index 77bc3d94f580..dbd61e4844b0 100644
> > > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > > @@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] =3D {
> > >         {  20210000, P_PLL8,  1, 1,  19 },
> > >         {  24000000, P_PLL8,  4, 1,   4 },
> > >         {  48000000, P_PLL8,  4, 1,   2 },
> > > +       {  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
> >=20
> > Why the comment and fake rate? Can it be 51200000 instead and drop the
> > comment?
>=20
> I will add the related reason in the commit.
>=20
> We cannot achieve exact 52Mhz(jitter free) clock using PLL8.
> As per the MND calculator the closest possible jitter free clock
> using PLL8 is 51.2Mhz. This patch adds the values, which will provide
> jitter free 51.2Mhz when the requested frequency is 52mhz.

Sounds like this clk should use the round down clk_ops instead of the
round up ones. Then the actual frequency can be in the table.
