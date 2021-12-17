Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B584783E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhLQEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhLQEF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:05:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36677C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:05:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u74so1832045oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nX0nqwthhMxawiv2VKLzc/QeElJp3Cn2bdOP+1tkjes=;
        b=FDHi0y6033nCq1UC8OxRibTVkJ2F2b8ik7B8KTwPiOvG7I6vkjnLe5VmV4QIHaTzO1
         eTNHNOKs4sI5nLOSH102TagmIFKyhcVP3rufHNWostfZI5Ek5oe0bRRz/+p7z3J51X6j
         pRAb9BwK/R2bmC48+Zk7RUlP8nSi8exh7PMsz1HvTf1OhDUv4j1IDDE50sqpQoDH6Dj3
         cfx7hjAywq2/t1VAAJ3QtDQG8iDJhGz2lJDmwpXQ6DWcs8M+ze32baXuXmR3aVbpGREj
         E7t6n3eVbZvJxq8NxqznTIonHttWqHAup222Uj8gX5ipBVt/MiPtMWFtV/+tF8melwE+
         og7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nX0nqwthhMxawiv2VKLzc/QeElJp3Cn2bdOP+1tkjes=;
        b=4ghGBPrDCbzRzjplOH2hOpSVTch3GDO+yCbETbLpd7iQogOHLHGGCgsECSioydMVqb
         ZK19Sjfs1940/Et+7GtDpnx89EJICHJCXDb0rXzFVmRENBuz2yEkrGqiznPmRD63eqyW
         DDVkdLjRKJhOplnoSctpO9q8q+oW26RHq4mqb3TD7bVQLvAEDaBBdc8AH2vHh/pe11Zn
         cYcLtte+pVk7XgUswkA+szEeJ9PFFbykQ4/CLa/fvXyh7ikfx1W9+ka4Aem9gUpicphd
         piqwbTAMaMQuGMV/I9w9+4cH0rtF25PGPAECtXrVVkIlq16oiWebNYj4itoj+scjBoGS
         HEXA==
X-Gm-Message-State: AOAM531WSFYH01wvjQpvEqeuyRYeaUaLINmPzP3rcno8WZy7dEFMSJwz
        fHOuI7w39WARVCKZ+rvJJjyCtKu4gVo+BA==
X-Google-Smtp-Source: ABdhPJy8h7Mk4MQUV9yigyT8Z+XXvWAAh4Ul/5BBkl5ZGVExBKEaMzSUOlJTsqmqd+sqYulh0r7o3w==
X-Received: by 2002:aca:3a44:: with SMTP id h65mr6559170oia.17.1639713956400;
        Thu, 16 Dec 2021 20:05:56 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r5sm1382360oiw.20.2021.12.16.20.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:05:55 -0800 (PST)
Date:   Thu, 16 Dec 2021 22:05:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Nischal <anischal@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Message-ID: <YbwMoIybSUAteBzV@yoga>
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
 <20211216015136.96AD3C36AE1@smtp.kernel.org>
 <Ybqo+wUv6lNT75tJ@ripper>
 <20211216185856.27406C36AE2@smtp.kernel.org>
 <YbvMkIhdsGdCfvFV@ripper>
 <20211217014521.55CD4C36AE0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217014521.55CD4C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Dec 19:45 CST 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-12-16 15:32:32)
> > On Thu 16 Dec 10:58 PST 2021, Stephen Boyd wrote:
> > 
> > > Quoting Bjorn Andersson (2021-12-15 18:48:27)
> > > > On Wed 15 Dec 17:51 PST 2021, Stephen Boyd wrote:
> > > > 
> > > > > Quoting Bjorn Andersson (2021-12-02 19:56:01)
> > > > > > As GDSCs are turned on and off some associated clocks are momentarily
> > > > > > enabled for house keeping purposes. Failure to enable these clocks seems
> > > > > > to have been silently ignored in the past, but starting in SM8350 this
> > > > > > failure will prevent the GDSC to turn on.
> > > > > > 
> > > > > > At least on SM8350 this operation will enable the RCG per the
> > > > > > configuration in CFG_REG. This means that the current model where the
> > > > > > current configuration is written back to CF_REG immediately after
> > > > > > parking the RCG doesn't work.
> > > > > 
> > > > > Just to clarify, is the RCG off and "parked" at XO with the config
> > > > > register dirty and set to the desired frequency and then the RCG is
> > > > > turned on by the GDSC?
> > > > > 
> > > > 
> > > > Correct, that's exactly what I'm observing.
> > > 
> > > Cool can you add that detail to the commit message?
> > > 
> > 
> > Sure.
> > 
> > > > 
> > > > > > 
> > > > > > Instead, keep track of the currently requested rate of the clock and
> > > > > > upon enabling the clock reapply the configuration per the saved rate.
> > > > > 
> > > > > We already keep track of the requested rate and reapply it on enable,
> > > > > just we're lazy and stash that information in the hardware and not the
> > > > > software. I didn't think the gdsc would be turned on and ruin that all,
> > > > > but it's fair.
> > > > > 
> > > > 
> > > > Up until SM8350 I see no evidence that this has been a problem, but now
> > > > it is. So there's likely some changes in the hardware there...
> > > > 
> > > > > > 
> > > > > > Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
> > > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > > ---
> > > > > >  drivers/clk/qcom/clk-rcg.h  |  2 ++
> > > > > >  drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
> > > > > >  2 files changed, 19 insertions(+), 15 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > > > > > index 99efcc7f8d88..6939f4e62768 100644
> > > > > > --- a/drivers/clk/qcom/clk-rcg.h
> > > > > > +++ b/drivers/clk/qcom/clk-rcg.h
> > > > > > @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
> > > > > >   * @freq_tbl: frequency table
> > > > > >   * @clkr: regmap clock handle
> > > > > >   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> > > > > > + * @current_rate: cached rate for parked RCGs
> > > > > >   */
> > > > > >  struct clk_rcg2 {
> > > > > >         u32                     cmd_rcgr;
> > > > > > @@ -149,6 +150,7 @@ struct clk_rcg2 {
> > > > > >         const struct freq_tbl   *freq_tbl;
> > > > > >         struct clk_regmap       clkr;
> > > > > >         u8                      cfg_off;
> > > > > > +       unsigned long           current_rate;
> > > > > >  };
> > > > > >  
> > > > > >  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
> > > > > > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > > > > > index e1b1b426fae4..b574b38dcbd5 100644
> > > > > > --- a/drivers/clk/qcom/clk-rcg2.c
> > > > > > +++ b/drivers/clk/qcom/clk-rcg2.c
> > > > > > @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > > > >  {
> > > > > >         struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > > > > >         u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
> > > > > > +       unsigned long rate;
> > > > > >  
> > > > > >         regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> > > > > >  
> > > > > > @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > > > >         hid_div = cfg >> CFG_SRC_DIV_SHIFT;
> > > > > >         hid_div &= mask;
> > > > > >  
> > > > > > -       return calc_rate(parent_rate, m, n, mode, hid_div);
> > > > > > +       rate = calc_rate(parent_rate, m, n, mode, hid_div);
> > > > > > +       if (!rcg->current_rate)
> > > > > > +               rcg->current_rate = rate;
> > > > > 
> > > > > Instead of doing this in recalc_rate, all the time, why not make an init
> > > > > clk op that does it once during registration? The other problem I see is
> > > > > that the rate we calculate may be wrong if the parent is registered
> > > > > after this clk. I think this came up originally when the patch this is
> > > > > fixing was discussed.
> > > > > 
> > > > 
> > > > I would need to go back and reproduce the issue I saw, but I had to add
> > > > this because I ended up in clk_rcg2_shared_enable() with current_rate =
> > > > 0, which I think would be equally bad to just committing the dirty
> > > > configuration.
> > > 
> > > Alright.
> > > 
> > > > 
> > > > > So instead of saving the current_rate can we save the cfg register value
> > > > > (or however many registers we need) to put back the frequency of the clk
> > > > > to what we want on enable? The other thing is that we made recalc_rate()
> > > > > work "seamlessly" here by stashing the frequency into the register but
> > > > > leaving it uncommitted until enable. We may need to now look at the
> > > > > software copy of the registers in the shared rcg recalc rate operation
> > > > > to figure out what the frequency is.
> > > > > 
> > > > 
> > > > I made an attempt at this, the problem I had was to come up within
> > > > something sane for how to deal with set_rate on parked clocks; because
> > > > we need to re-generate the register contents, without writing out the
> > > > value - and that got messy.
> > > 
> > > Looking back on the introduction of this code[1] I see that it's not
> > > about the rate but more about the parent. i.e. we park the clk on the XO
> > > parent but don't care about the m/n values or pre divider because it
> > > doesn't really matter if the clk is running slowly. So nothing needs to
> > > be saved except for the cfg register, and we can do that in software
> > > with a single u32 instead of using a rate and looking it up and then
> > > reprogramming the other values. We should be able to cache the register
> > > content with an init clk_op.
> > > 
> > 
> > So you're suggesting that, in clk_rcg2_shared_set_rate(), when the RCG
> > is found to be disabled, I should write out M, N, D and calculate a new
> > cfg value which I stash until the next enable?
> > 
> > Looks a little bit messy, but I will give it a try.
> 
> No. I don't see where clk_rcg2_shared_set_rate() needs to change.
> 
> I'm suggesting we cache the config register on disable so it can be
> restored on enable. Basically everything is the same except now we don't
> write the cfg register and leave it dirty in the hardware. We need a
> shared rcg version of recalc rate that looks at the shadow cfg register
> instead of reading the hardware because we've changed the parent behind
> the back of the framework and we want to make it look like nothing has
> changed. 
> 

I see, that was my first attempt of an implementation as well.

The problem I ran into right away was that i had something that did
disable(), set_rate(), enable() and I would restore the wrong settings.

So clk_rcg2_shared_set_rate() needs to update the stashed cfg value -
and it needs to write out M, N and D if we're not caching those.

> This is all based on my understanding that the problem is the RCG is
> changing rate due to the gdsc turning on the clk for us. So we can't
> leave anything dirty in the hardware and have to keep it in software.
> I hope the change is minimal.

That's my understanding as well.


Looking more at the code I think it's possible that we get disable(),
set_parent(), enable() as well; which if that's the case would result
in the same problem, so I assume I need to tend to that as well.

Regards,
Bjorn
