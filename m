Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2570478088
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhLPXbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhLPXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:20 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:31:19 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso747146otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NXP5aZIeipXTUi98du3BOF/PkToplyAfCgzX8CANNdQ=;
        b=zFKdJmuecI72DotbzBckf7qeXzkcTKD+nGjYIEKibmNcyUgZxg+6KuEFFZcd+do1MC
         44PNU6KqyaSlhEL7ew/u3e91AJFyCaBBnZeToKl4PrD0reR/1dCnRpTDQlAoRdpfN1Z+
         LiSXhmO24W1NyyNSHQWI8lU5LnhkEqTaVI1woRGfzG6OOV9rKc+cwGR7EF8Z0wBf3Lc/
         hFOgtUxWcfJnuY1kM/vbo+/yx1V7ikqFdQ1YPhUrHluDgJ9S2eIffby7X0Wc5v/dgvfX
         BjTrWikZ59iRC8yX2nJ+LYR4WvJg76RE0qLI4u82mKoF8kRkysN5HhPnnW5Akn79gFLI
         evug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXP5aZIeipXTUi98du3BOF/PkToplyAfCgzX8CANNdQ=;
        b=xW13C1pHr8W/DM2CHozBb9Xuhx0D4U+ygexhS/DydqRl/ZSZ6YTpQkUWNRPzbGGBkk
         u2lSDIEz7NOByu7679jdgSfs0etSPvKL3H19JAiKy/ecY1WhxOWChz4GegOAWPvgqNGC
         wgsNUbJDLlnIBDS+jl9umL2cAWhfp4QVuTvApVd84Vsh12aVN1rxbnqCaNZDDiQgRSy+
         a7MF6Cgm6xBHXEHpRFrB80sPPat9PGmJhuCoSqbX8CLm7f17aQprGOUQtkv17Sj6xUHt
         dQ8xqQtbI25yu2xRggg3e/8NuHpIiLkTtqUsGMywZ+kjAMW2WymDtXHIsBORmVeESwWM
         bLuQ==
X-Gm-Message-State: AOAM530laUAfIxyYWPwai0gZNFPkJlknnAV5cwa/24CoeBoLAr/+Dkp2
        1gfTx/CIKx+Po7nT71eO5caeoA==
X-Google-Smtp-Source: ABdhPJx/NpkKAmabEITTnvIJ5WsOnzArrDjDEsBnlWblCgVJ+Hxk8mVhpGbmPRyJrNWtK6Oodd0Xrg==
X-Received: by 2002:a9d:7548:: with SMTP id b8mr338973otl.92.1639697479143;
        Thu, 16 Dec 2021 15:31:19 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g17sm1266613oiy.14.2021.12.16.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:18 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:32:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Nischal <anischal@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Message-ID: <YbvMkIhdsGdCfvFV@ripper>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
 <20211216015136.96AD3C36AE1@smtp.kernel.org>
 <Ybqo+wUv6lNT75tJ@ripper>
 <20211216185856.27406C36AE2@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216185856.27406C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Dec 10:58 PST 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-12-15 18:48:27)
> > On Wed 15 Dec 17:51 PST 2021, Stephen Boyd wrote:
> > 
> > > Quoting Bjorn Andersson (2021-12-02 19:56:01)
> > > > As GDSCs are turned on and off some associated clocks are momentarily
> > > > enabled for house keeping purposes. Failure to enable these clocks seems
> > > > to have been silently ignored in the past, but starting in SM8350 this
> > > > failure will prevent the GDSC to turn on.
> > > > 
> > > > At least on SM8350 this operation will enable the RCG per the
> > > > configuration in CFG_REG. This means that the current model where the
> > > > current configuration is written back to CF_REG immediately after
> > > > parking the RCG doesn't work.
> > > 
> > > Just to clarify, is the RCG off and "parked" at XO with the config
> > > register dirty and set to the desired frequency and then the RCG is
> > > turned on by the GDSC?
> > > 
> > 
> > Correct, that's exactly what I'm observing.
> 
> Cool can you add that detail to the commit message?
> 

Sure.

> > 
> > > > 
> > > > Instead, keep track of the currently requested rate of the clock and
> > > > upon enabling the clock reapply the configuration per the saved rate.
> > > 
> > > We already keep track of the requested rate and reapply it on enable,
> > > just we're lazy and stash that information in the hardware and not the
> > > software. I didn't think the gdsc would be turned on and ruin that all,
> > > but it's fair.
> > > 
> > 
> > Up until SM8350 I see no evidence that this has been a problem, but now
> > it is. So there's likely some changes in the hardware there...
> > 
> > > > 
> > > > Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  drivers/clk/qcom/clk-rcg.h  |  2 ++
> > > >  drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
> > > >  2 files changed, 19 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > > > index 99efcc7f8d88..6939f4e62768 100644
> > > > --- a/drivers/clk/qcom/clk-rcg.h
> > > > +++ b/drivers/clk/qcom/clk-rcg.h
> > > > @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
> > > >   * @freq_tbl: frequency table
> > > >   * @clkr: regmap clock handle
> > > >   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> > > > + * @current_rate: cached rate for parked RCGs
> > > >   */
> > > >  struct clk_rcg2 {
> > > >         u32                     cmd_rcgr;
> > > > @@ -149,6 +150,7 @@ struct clk_rcg2 {
> > > >         const struct freq_tbl   *freq_tbl;
> > > >         struct clk_regmap       clkr;
> > > >         u8                      cfg_off;
> > > > +       unsigned long           current_rate;
> > > >  };
> > > >  
> > > >  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
> > > > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > > > index e1b1b426fae4..b574b38dcbd5 100644
> > > > --- a/drivers/clk/qcom/clk-rcg2.c
> > > > +++ b/drivers/clk/qcom/clk-rcg2.c
> > > > @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > >  {
> > > >         struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > > >         u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
> > > > +       unsigned long rate;
> > > >  
> > > >         regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> > > >  
> > > > @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > >         hid_div = cfg >> CFG_SRC_DIV_SHIFT;
> > > >         hid_div &= mask;
> > > >  
> > > > -       return calc_rate(parent_rate, m, n, mode, hid_div);
> > > > +       rate = calc_rate(parent_rate, m, n, mode, hid_div);
> > > > +       if (!rcg->current_rate)
> > > > +               rcg->current_rate = rate;
> > > 
> > > Instead of doing this in recalc_rate, all the time, why not make an init
> > > clk op that does it once during registration? The other problem I see is
> > > that the rate we calculate may be wrong if the parent is registered
> > > after this clk. I think this came up originally when the patch this is
> > > fixing was discussed.
> > > 
> > 
> > I would need to go back and reproduce the issue I saw, but I had to add
> > this because I ended up in clk_rcg2_shared_enable() with current_rate =
> > 0, which I think would be equally bad to just committing the dirty
> > configuration.
> 
> Alright.
> 
> > 
> > > So instead of saving the current_rate can we save the cfg register value
> > > (or however many registers we need) to put back the frequency of the clk
> > > to what we want on enable? The other thing is that we made recalc_rate()
> > > work "seamlessly" here by stashing the frequency into the register but
> > > leaving it uncommitted until enable. We may need to now look at the
> > > software copy of the registers in the shared rcg recalc rate operation
> > > to figure out what the frequency is.
> > > 
> > 
> > I made an attempt at this, the problem I had was to come up within
> > something sane for how to deal with set_rate on parked clocks; because
> > we need to re-generate the register contents, without writing out the
> > value - and that got messy.
> 
> Looking back on the introduction of this code[1] I see that it's not
> about the rate but more about the parent. i.e. we park the clk on the XO
> parent but don't care about the m/n values or pre divider because it
> doesn't really matter if the clk is running slowly. So nothing needs to
> be saved except for the cfg register, and we can do that in software
> with a single u32 instead of using a rate and looking it up and then
> reprogramming the other values. We should be able to cache the register
> content with an init clk_op.
> 

So you're suggesting that, in clk_rcg2_shared_set_rate(), when the RCG
is found to be disabled, I should write out M, N, D and calculate a new
cfg value which I stash until the next enable?

Looks a little bit messy, but I will give it a try.

> > 
> > So stashing the frequency turned out to be much cleaner. I believe that
> > this is also what they do downstream...
> > 
> 
> Downstream doing something isn't a great reason.
> 

:)

> [1] https://lore.kernel.org/r/07dbf890975c1178bc4cc2360c25526a@codeaurora.org

Regards,
Bjorn
