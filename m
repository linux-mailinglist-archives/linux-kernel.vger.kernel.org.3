Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC5585754
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiG2X1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2X1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3040E0E8;
        Fri, 29 Jul 2022 16:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5485C61419;
        Fri, 29 Jul 2022 23:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAADC433D6;
        Fri, 29 Jul 2022 23:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659137270;
        bh=sqRp40R6KJgFmFaL5KDeXGeFZMG+FgczZ+X7+SXM8nA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bC/DwFwxLItlATxZUIJZ/Cs/VQK374rDCareo8AI07Ef02DP8TOyK/AnHj0s4nxYv
         qUapdff6x4PkNybu399Q+Q4cbG76JO3inAz4xD9/GYuGveSAPrhZZWF57KvTekpYRg
         EwW1gyK7XbngY9A6lHI3ol8a7p+0UUFcepkbpy+LT2af0eGlF0MUo7lQf19nXV7ppu
         /Fm2U7mrGQ5ftf3TY0fHoMHjf6X0mwGvNgkJSyW/ujVXGn7g6QLbepi0+jjOW3u3g5
         vv/UqSGR6tAMA+owPR5mkcI52jFvDGhKC79T7IKj+eP0Z10lpI4DY5K+BEpDzR+Fvw
         rJCr8HYivhUBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOX2RU7NaJL5dTrjz26oiz0psvXKV8C-7HGMmJ-rfNJ3r=y2qg@mail.gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com> <20220515210048.483898-10-robimarko@gmail.com> <20220711211047.952F4C34115@smtp.kernel.org> <CAOX2RU7NaJL5dTrjz26oiz0psvXKV8C-7HGMmJ-rfNJ3r=y2qg@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] clk: qcom: ipq8074: dont disable gcc_sleep_clk_src
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, tdas@codeaurora.org
To:     Robert Marko <robimarko@gmail.com>
Date:   Fri, 29 Jul 2022 16:27:48 -0700
User-Agent: alot/0.10
Message-Id: <20220729232750.8EAADC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Marko (2022-07-11 14:14:38)
> On Mon, 11 Jul 2022 at 23:10, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Robert Marko (2022-05-15 14:00:47)
> > > diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ip=
q8074.c
> > > index 3204d550ff76..42d185fe19c8 100644
> > > --- a/drivers/clk/qcom/gcc-ipq8074.c
> > > +++ b/drivers/clk/qcom/gcc-ipq8074.c
> > > @@ -663,6 +663,7 @@ static struct clk_branch gcc_sleep_clk_src =3D {
> > >                         },
> > >                         .num_parents =3D 1,
> > >                         .ops =3D &clk_branch2_ops,
> > > +                       .flags =3D CLK_IS_CRITICAL,
> > >                 },
> >
> > Why not just remove the clk from the driver? Is anything using it?
>=20
> Hi Stephen, USB sleep clocks are derived from it so it cant be dropped.
>=20

And we can't return NULL clks to USB for the sleep clk?
