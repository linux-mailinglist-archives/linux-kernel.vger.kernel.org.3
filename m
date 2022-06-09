Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80E5456F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiFIWMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFIWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DD1C28CD;
        Thu,  9 Jun 2022 15:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D3861F03;
        Thu,  9 Jun 2022 22:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684C1C34114;
        Thu,  9 Jun 2022 22:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654812731;
        bh=zJvO4Ob62G1vZNY0ZLTIVvosVMthN1HJt9gvNcztX2c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cTKMxbEYwLB84MUA4Do8QRyHyOLUgtD5RLQ/1RlSMk2SgHDKcBvtPUs169GiTbQdc
         G/ycUcmw7zJp/7TtERG5HYIXnsfeJaX7ZUQeA9rlGlqFKYS/7NjzLpmPkn4Q8Axkni
         zVvxj9rXGxhbO6iVr8Ckyx3opAK61KNoe40cGD+DxKlFTpajFe38Dek/7iDYjviiQ4
         r6YKe5LGP3mD+msS3+kh1X4o1HzFzY6Rf6On0xmPT/GdQ20hxxtVPCdYdEcNGQxr7Q
         ypzvPbP7fCec+RW5k558duToIGoiRzFjyWM9IT+ypjpA4eS5KUYeONFoGDwqj/o5UD
         yTar86bAUyBmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJpomtbN0+ocD2pRbkYriUY4D9OnjgoFzL9qNHhPm3Uz5cQ@mail.gmail.com>
References: <20220601220747.1145095-1-marijn.suijten@somainline.org> <20220601220747.1145095-4-marijn.suijten@somainline.org> <CAA8EJpomtbN0+ocD2pRbkYriUY4D9OnjgoFzL9qNHhPm3Uz5cQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Date:   Thu, 09 Jun 2022 15:12:09 -0700
User-Agent: alot/0.10
Message-Id: <20220609221211.684C1C34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-02 03:20:19)
> On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-fac=
tor.c
> > index 54942d758ee6..fabb98d0cdb2 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -78,7 +78,8 @@ static void devm_clk_hw_register_fixed_factor_release=
(struct device *dev, void *
> >
> >  static struct clk_hw *
> >  __clk_hw_register_fixed_factor(struct device *dev, struct device_node =
*np,
> > -               const char *name, const char *parent_name, int index,
> > +               const char *name, const char *parent_name,
> > +               const struct clk_hw *parent_hw, int index,
> >                 unsigned long flags, unsigned int mult, unsigned int di=
v,
> >                 bool devm)
> >  {
> > @@ -108,7 +109,9 @@ __clk_hw_register_fixed_factor(struct device *dev, =
struct device_node *np,
> >         init.name =3D name;
> >         init.ops =3D &clk_fixed_factor_ops;
> >         init.flags =3D flags;
> > -       if (parent_name)
> > +       if (parent_hw)
> > +               init.parent_hws =3D &parent_hw;
> > +       else if (parent_name)
> >                 init.parent_names =3D &parent_name;
>=20
> If you change the order of if clauses, you won't have to introduce
> unnecessary changes.

Indeed, please do that.

>=20
> >         else
> >                 init.parent_data =3D &pdata;
> > @@ -148,17 +151,50 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_=
index(struct device *dev,
> >                 const char *name, unsigned int index, unsigned long fla=
gs,
> >                 unsigned int mult, unsigned int div)
> >  {
> > -       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, in=
dex,
> > -                                             flags, mult, div, true);
> > +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NU=
LL,
> > +                                             index, flags, mult, div, =
true);
>=20
> Here (and several times later) you are inserting an argument and then
> moving arguments to the next line. My slight preference would be to
> just insert the arg (and maybe break the line if it gets too long) w/o
> touching the next lines.

I'd just add the argument at the end because when it is added in the
middle it makes the diff more difficult to read.
