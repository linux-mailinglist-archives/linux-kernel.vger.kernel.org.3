Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9B4955B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377687AbiATU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:59:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19DC061574;
        Thu, 20 Jan 2022 12:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B731AB81E56;
        Thu, 20 Jan 2022 20:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E365C340E0;
        Thu, 20 Jan 2022 20:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712347;
        bh=AXnm+3K3zDwYn92rKnkPLA0D2Ce/nV/QIzKpRqu+jsY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZIL3wvPghrImgw2nHgfxH/wu0YlBX6OouWGe/CZczepfVPVnCqnB+Q/MZDWoFxkYF
         6g+0i7pLkHGurxX9bGx3OErHL8y9fKKQHdVow1/vOsGOQIMHa8eiZvNcjIERV5EXkG
         T3z5evnrZoZJ8xGmFEwhMSbGzUJPmJ38Oe7p/DwlZfig2WgRDGE/g2n0VuwFQlwzh1
         7OObWyc7b6Ny+9PJSz0OTKsHO+k6Sg+BJZ//vOlAmvb2fctYsq2APSLH7KYFsY81Fj
         QwItlWsP8DVNQdthE5bMaEvtkL9ov9PM/Rjw4EkDYK0DmgEbtQ0TvLIc77QK0WlFH9
         NNk7a5H8rTwOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ED361B6C-0BE2-4FDD-AF29-497E14A183A6@protonmail.com>
References: <20220118191839.64086-1-povik+lin@protonmail.com> <20220118191839.64086-3-povik+lin@protonmail.com> <20220120053810.71C17C340E0@smtp.kernel.org> <ED361B6C-0BE2-4FDD-AF29-497E14A183A6@protonmail.com>
Subject: Re: [PATCH v2 2/3] clk: clk-apple-nco: Add driver for Apple NCO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Martin =?utf-8?q?Povi=C5=A1er?= <povik+lin@protonmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, alyssa@rosenzweig.io,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
To:     Martin =?utf-8?q?Povi=C5=A1er?= <povik@protonmail.com>
Date:   Thu, 20 Jan 2022 12:59:05 -0800
User-Agent: alot/0.10
Message-Id: <20220120205907.4E365C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Povi=C5=A1er (2022-01-20 04:11:34)
>=20
> > On 20. 1. 2022, at 6:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Martin Povi=C5=A1er (2022-01-18 11:21:10)
> >> +
> >> +static int nco_set_rate(struct clk_hw *hw, unsigned long rate,
> >> +                               unsigned long parent_rate)
> >> +{
> >> +       struct nco_channel *chan =3D to_nco_channel(hw);
> >> +       unsigned long flags;
> >> +       u32 div;
> >> +       s32 inc1, inc2;
> >> +       bool was_enabled;
> >> +
> >> +       div =3D 2 * parent_rate / rate;
> >> +       inc1 =3D 2 * parent_rate - div * rate;
> >> +       inc2 =3D -((s32) (rate - inc1));
> >
> > Is the cast necessary?
>=20
> Answering that prompted me to get back to reading some C specification an=
d now
> I am confident in moving away from signed types here and in nco_recalc_ra=
te
> altogether.

Great! Operating with only unsigned types makes this easier to
understand.

> >> +       struct nco_tables *tbl;
> >> +       unsigned int nchannels;
> >> +       int ret, i;
> >> +
> >> +       regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &regs=
_res);
> >> +       if (IS_ERR(regs))
> >> +               return PTR_ERR(regs);
> >> +
> >> +       if (resource_size(regs_res) < NCO_CHANNEL_REGSIZE)
> >> +               return -EINVAL;
> >> +       nchannels =3D (resource_size(regs_res) - NCO_CHANNEL_REGSIZE)
> >> +                       / NCO_CHANNEL_STRIDE + 1;
> >
> > Is this some sort of DIV_ROUND_UP()?
>=20
> Almost. I will shop around for a macro replacement.

Alright.
