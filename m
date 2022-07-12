Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81102571CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiGLOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGLO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D22871F;
        Tue, 12 Jul 2022 07:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A80618F8;
        Tue, 12 Jul 2022 14:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB807C341C8;
        Tue, 12 Jul 2022 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657636196;
        bh=eD8CW9WNiJT8VXhu8zwAPpJ2nHI6u87NDwtq5Ro4Zkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pT24m+7R6+CJHODdS4TaCZnUnta0iUdEIVJOWr7keb/BUm3h8P7woBbOS3bnGjyDG
         H3mH8VlmYAOdfSrROvE1aHkFMIrbycy6ANEXqEhrJW/Ghrz44jlSwKPyBdILAs2wA5
         dTcNFqENehXUrSK18juekpJWXSpPHviib7ngzjdlwddI71q7gznYGIbaAmWW+U2G8z
         M5f1BeBaM1PtpaPkUS7tBWvBBD/0i7SHYyhqxoiuKn0pkMhz5sQ7X+GG/6nWvkREZi
         JyK9eAkIQNR4bQKKM63DQCF2McAsV1jsJBarnKRktOrNLnYL0zGgJ7UELJG3t4trgV
         Vs7l2LXgTXxcw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBGth-0001zS-P1; Tue, 12 Jul 2022 16:29:57 +0200
Date:   Tue, 12 Jul 2022 16:29:57 +0200
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
Message-ID: <Ys2FZa6YDwt7d/Zc@hovoldconsulting.com>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
 <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:22:40PM +0530, Viresh Kumar wrote:
> On 11-07-22, 18:40, Johan Hovold wrote:
> > This break OPP parsing on SC8280XP and hence cpufreq and other things:
> > 
> > [  +0.010890] cpu cpu0: _opp_add_static_v2: opp key field not found
> > [  +0.000019] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -19
> > [  +0.000060] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 403200000, volt: 576000, enabled: 1
> > [  +0.000030] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 499200000, volt: 576000, enabled: 1
> > ...
> > 
> > I just did a rebase on next-20220708 and hit this.
> > 
> > I've narrowed it down to _read_rate() now returning -ENODEV since
> > opp_table->clk_count is zero.
> > 
> > Similar to what was reported for tegra for v1:
> > 
> > 	https://lore.kernel.org/all/58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com/
> > 
> > I don't have time to look at this any more today, but it would we nice
> > if you could unbreak linux-next.
> > 
> > Perhaps Bjorn or Mani can help with further details, but this doesn't
> > look like something that is specific to SC8280XP.
> 
> It is actually. This is yet another corner case, Tegra had one as
> well.

I literally meant that it does not appear to be SC8280XP specific. Bjorn
reported seeing similar problems on multiple Qualcomm SoCs.

> I have tried to understand the Qcom code / setup to best of my
> abilities, and the problem as per me is that qcom-cpufreq-hw doesn't
> provide a clk to the OPP core, which breaks it after the new updates
> to the OPP core. I believe following will solve it. Can someone please
> try this ? I will then merge it with the right commit.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 666e1ebf91d1..4f4a285886fa 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1384,6 +1384,20 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>         }
> 
>         if (ret == -ENOENT) {
> +               /*
> +                * There are few platforms which don't want the OPP core to
> +                * manage device's clock settings. In such cases neither the
> +                * platform provides the clks explicitly to us, nor the DT
> +                * contains a valid clk entry. The OPP nodes in DT may still
> +                * contain "opp-hz" property though, which we need to parse and
> +                * allow the platform to find an OPP based on freq later on.
> +                *
> +                * This is a simple solution to take care of such corner cases,
> +                * i.e. make the clk_count 1, which lets us allocate space for
> +                * frequency in opp->rates and also parse the entries in DT.
> +                */
> +               opp_table->clk_count = 1;
> +
>                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
>                 return opp_table;
>         }

This looks like a hack. And it also triggers a bunch of new warning when
opp is trying to create debugfs entries for an entirely different table
which now gets clk_count set to 1:

[  +0.000979]  cx: _update_opp_table_clk: Couldn't find clock: -2
[  +0.000022] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000004] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000004] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!
[  +0.000003] debugfs: Directory 'opp:0' with parent 'cx' already present!

This is for the rpmhpd whose opp table does not have either opp-hz or
clocks (just opp-level).

The above unbreaks cpufreq though.

Johan
