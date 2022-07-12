Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949C7572007
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiGLPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiGLPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:55:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283F1B8EAA;
        Tue, 12 Jul 2022 08:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72D6B819AC;
        Tue, 12 Jul 2022 15:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E875C3411C;
        Tue, 12 Jul 2022 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657641300;
        bh=8tOgJxPDTATRCSBvm6zjfU2BJpjyIA7W/clNTO70iqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqtUWrYcGEt3nT6wv8aAHmLUeR9RH/RuZJKpdUTTNZrwRUyf+Zrk8rbfUV2yv51Dc
         4Ff4yqIYcb0iPi1whl2XwD9bS9VT+P6NmZjg42xCtlpuJl3tqUt3vGe6r7cmWGzkU6
         s7VHxLFrOQtrAQfavCuVStaZNKDmTaw4QQee4UBAbPD0fIhy77URhFT++/CJ4ISvQH
         n5ELoM4Mz1AN7B7YTMoBgBXQ3klFhQrKBOJeO+tC+r9boJq5EOFmBR1+EvgcHCrQpN
         HhPPdEewFEGtR002rK40owGK5if/46AncBLHga7vQcb8y1U/E/Y5+1Y1TmLZ4I+4Qw
         HCJQGDkivRriw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBIE1-0003ol-SG; Tue, 12 Jul 2022 17:55:02 +0200
Date:   Tue, 12 Jul 2022 17:55:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <Ys2ZVeBHyhrUBC4m@hovoldconsulting.com>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
 <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
 <Ys2FZa6YDwt7d/Zc@hovoldconsulting.com>
 <20220712151045.vn4tpat4c4cplndo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712151045.vn4tpat4c4cplndo@vireshk-i7>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:40:45PM +0530, Viresh Kumar wrote:
> On 12-07-22, 16:29, Johan Hovold wrote:
> > On Tue, Jul 12, 2022 at 01:22:40PM +0530, Viresh Kumar wrote:
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index 666e1ebf91d1..4f4a285886fa 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1384,6 +1384,20 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
> > >         }
> > > 
> > >         if (ret == -ENOENT) {
> > > +               /*
> > > +                * There are few platforms which don't want the OPP core to
> > > +                * manage device's clock settings. In such cases neither the
> > > +                * platform provides the clks explicitly to us, nor the DT
> > > +                * contains a valid clk entry. The OPP nodes in DT may still
> > > +                * contain "opp-hz" property though, which we need to parse and
> > > +                * allow the platform to find an OPP based on freq later on.
> > > +                *
> > > +                * This is a simple solution to take care of such corner cases,
> > > +                * i.e. make the clk_count 1, which lets us allocate space for
> > > +                * frequency in opp->rates and also parse the entries in DT.
> > > +                */
> > > +               opp_table->clk_count = 1;
> > > +
> > >                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
> > >                 return opp_table;
> > >         }
> > 
> > This looks like a hack.
> 
> Yeah, a bit. Initially I wanted to solve it in a cleaner way, like it
> is done for Tegra, where you will pass the right clock name to the OPP
> core, so it can verify that the clk is there and parse the table. And
> then tell the OPP core not to configure the clk from
> dev_pm_opp_set_opp(), which is possible now. This would have done the
> things in the right way.
> 
> The problem with Qcom's DT is that the CPU node have the OPP table but
> doesn't contain the clocks, which are available with the
> qcom,cpufreq-hw node instead. Because of this, I couldn't pass the
> real clocks name to the OPP core, "xo", for the CPU device.
> 
> I really tried to avoid adding the above code for Tegra and found a
> better and cleaner way out. But I couldn't do the same here and
> figured it may be more generic of a problem, which is fine as well.
> 
> The OPP core does two things currently:
> 
> 1) Parse the DT and provide helpers to find the right OPP, etc.
> 
> 2) Provide generic helper to configure all resources related to the
>    OPP.
> 
> It is fine if some platforms only want to have the first and not the
> second. To have the second though, you need to have the first as well.
> 
> The clk is required only for the second case, and the OPP core should
> parse the DT anyways, irrespective of the availability of the clock.
> Because of this reason, making the above change looked reasonable
> (this is what was happening before my new patches came in anyway). The
> clock isn't there, but there is "opp-hz" present in the DT, which
> needs to be parsed.

Ok, thanks for the details. I'd still look into if there's some way to
avoid setting clk_count when there are no clocks as it sounds like an
anti-pattern that will just make the code harder to understand and
maintain.

> > And it also triggers a bunch of new warning when
> > opp is trying to create debugfs entries for an entirely different table
> > which now gets clk_count set to 1:
> > 
> > [  +0.000979]  cx: _update_opp_table_clk: Couldn't find clock: -2
> > [  +0.000022] debugfs: Directory 'opp:0' with parent 'cx' already present!

> > This is for the rpmhpd whose opp table does not have either opp-hz or
> > clocks (just opp-level).
> 
> Ahh, I missed switching back to the earlier code here. i.e. not use
> the frequency for OPP directory's name, when it is 0.
> 
> This will fix it.
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 402c507edac7..96a30a032c5f 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -138,7 +138,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>          * - For some devices rate isn't available or there are multiple, use
>          *   index instead for them.
>          */
> -       if (likely(opp_table->clk_count == 1))
> +       if (likely(opp_table->clk_count == 1 && opp->rates[0]))
>                 id = opp->rates[0];
>         else
>                 id = _get_opp_count(opp_table);

Indeed it does, thanks.

> I have merged this into:
> 
> commit 341df9889277 ("OPP: Allow multiple clocks for a device")
> 
> and pushed out for linux-next.

Thanks for addressing this quickly. With the two patches above applied,
the issues I noticed are gone.

Johan
