Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04E545DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbiFJHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbiFJHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:46:39 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E3F13C08B;
        Fri, 10 Jun 2022 00:46:35 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F06A62055F;
        Fri, 10 Jun 2022 09:46:33 +0200 (CEST)
Date:   Fri, 10 Jun 2022 09:46:32 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Stephen Boyd <sboyd@kernel.org>
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
Subject: Re: [PATCH v2 03/11] clk: fixed-factor: Introduce
 *clk_hw_register_fixed_factor_parent_hw()
Message-ID: <20220610074632.abtec5kulbclund4@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Jonathan Marek <jonathan@marek.ca>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20220601220747.1145095-1-marijn.suijten@somainline.org>
 <20220601220747.1145095-4-marijn.suijten@somainline.org>
 <CAA8EJpomtbN0+ocD2pRbkYriUY4D9OnjgoFzL9qNHhPm3Uz5cQ@mail.gmail.com>
 <20220609221211.684C1C34114@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609221211.684C1C34114@smtp.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-09 15:12:09, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-06-02 03:20:19)
> > On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > > index 54942d758ee6..fabb98d0cdb2 100644
> > > --- a/drivers/clk/clk-fixed-factor.c
> > > +++ b/drivers/clk/clk-fixed-factor.c
> > > @@ -78,7 +78,8 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
> > >
> > >  static struct clk_hw *
> > >  __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
> > > -               const char *name, const char *parent_name, int index,
> > > +               const char *name, const char *parent_name,
> > > +               const struct clk_hw *parent_hw, int index,
> > >                 unsigned long flags, unsigned int mult, unsigned int div,
> > >                 bool devm)
> > >  {
> > > @@ -108,7 +109,9 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
> > >         init.name = name;
> > >         init.ops = &clk_fixed_factor_ops;
> > >         init.flags = flags;
> > > -       if (parent_name)
> > > +       if (parent_hw)
> > > +               init.parent_hws = &parent_hw;
> > > +       else if (parent_name)
> > >                 init.parent_names = &parent_name;
> > 
> > If you change the order of if clauses, you won't have to introduce
> > unnecessary changes.
> 
> Indeed, please do that.

The intent here was to prefer parent_hw over parent_name, but I later
reordered the function arguments again to have parent_name before
parent_hw; in-line with __clk_hw_register_divider.  Hence makes more
sense to swap these around indeed.

Besides, we don't expect more than one of these to be set anyway per
design of this private function, that is only called by well-defined
implementations below.

> > 
> > >         else
> > >                 init.parent_data = &pdata;
> > > @@ -148,17 +151,50 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
> > >                 const char *name, unsigned int index, unsigned long flags,
> > >                 unsigned int mult, unsigned int div)
> > >  {
> > > -       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, index,
> > > -                                             flags, mult, div, true);
> > > +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL,
> > > +                                             index, flags, mult, div, true);
> > 
> > Here (and several times later) you are inserting an argument and then
> > moving arguments to the next line. My slight preference would be to
> > just insert the arg (and maybe break the line if it gets too long) w/o
> > touching the next lines.

That'll definitely look odd, as we'll end up with index floating on a
single line, all on its own.

> I'd just add the argument at the end because when it is added in the
> middle it makes the diff more difficult to read.

How strong is this feeling, against keeping argument ordering consistent
with other implementations of similar __clk_hw_register_* functions?

- Marijn
