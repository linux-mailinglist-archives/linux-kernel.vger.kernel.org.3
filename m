Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB0546CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350402AbiFJTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiFJTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB312C36B9;
        Fri, 10 Jun 2022 12:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D556222E;
        Fri, 10 Jun 2022 19:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1352DC34114;
        Fri, 10 Jun 2022 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654887672;
        bh=Hnvop1nQB2a1YvXC9KrSU6WdMwLevAsVoA6EE55HKf0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j2V8JdBRB9od3csLhFaWyYbQv4LOFTb655urrswTus3Zufk/CEtBBoyna10Gf0yzw
         g2Q25Psjl8EgSp54TApA8f2BEC4zmE/5LyPX/9sWAd+T/8SbBiqlZnpRS8NJmLdfLJ
         YXccNmbOugAmc0N1Y4Y3Zqb3FiKyYm8NFPBK6NqoIj0m2eVqVFUeBXoiZHdMKm2T3t
         UlUApgeWIfxWnmUOGL1W8187VMKi/0/uYDgZMax5vUo8xdYFSmcp0F5suozphejrz8
         WDs2WSLXWc27b2R5mOv8MNt7/VTjNxoQHJIWnHepHV54LX80fhopqJX0VAsjrJGjXj
         z8wubT/wkWYcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220610074632.abtec5kulbclund4@SoMainline.org>
References: <20220601220747.1145095-1-marijn.suijten@somainline.org> <20220601220747.1145095-4-marijn.suijten@somainline.org> <CAA8EJpomtbN0+ocD2pRbkYriUY4D9OnjgoFzL9qNHhPm3Uz5cQ@mail.gmail.com> <20220609221211.684C1C34114@smtp.kernel.org> <20220610074632.abtec5kulbclund4@SoMainline.org>
Subject: Re: [PATCH v2 03/11] clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
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
To:     Marijn Suijten <marijn.suijten@somainline.org>
Date:   Fri, 10 Jun 2022 12:01:10 -0700
User-Agent: alot/0.10
Message-Id: <20220610190112.1352DC34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marijn Suijten (2022-06-10 00:46:32)
> On 2022-06-09 15:12:09, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2022-06-02 03:20:19)
> > > On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
> > > <marijn.suijten@somainline.org> wrote:
> > > > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed=
-factor.c
> > > > index 54942d758ee6..fabb98d0cdb2 100644
> > > > --- a/drivers/clk/clk-fixed-factor.c
> > > > +++ b/drivers/clk/clk-fixed-factor.c
> > > > @@ -148,17 +151,50 @@ struct clk_hw *devm_clk_hw_register_fixed_fac=
tor_index(struct device *dev,
> > > >                 const char *name, unsigned int index, unsigned long=
 flags,
> > > >                 unsigned int mult, unsigned int div)
> > > >  {
> > > > -       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL=
, index,
> > > > -                                             flags, mult, div, tru=
e);
> > > > +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL=
, NULL,
> > > > +                                             index, flags, mult, d=
iv, true);
> > >=20
> > > Here (and several times later) you are inserting an argument and then
> > > moving arguments to the next line. My slight preference would be to
> > > just insert the arg (and maybe break the line if it gets too long) w/o
> > > touching the next lines.
>=20
> That'll definitely look odd, as we'll end up with index floating on a
> single line, all on its own.

Pretty sure Dmitry is suggesting to make the line longer, not put the
index on a line by itself. Ignore the 80-column limit.

>=20
> > I'd just add the argument at the end because when it is added in the
> > middle it makes the diff more difficult to read.
>=20
> How strong is this feeling, against keeping argument ordering consistent
> with other implementations of similar __clk_hw_register_* functions?
>=20

Not super strong. Just try to minimize the diff to make the reviewer's
job easier. In this case it would be inserting NULL before 'index' and
not modifying the next line so the diff is one line instead of two.
