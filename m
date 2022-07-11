Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74257087D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGKQkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:40:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154F2F3BB;
        Mon, 11 Jul 2022 09:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5F00B810CC;
        Mon, 11 Jul 2022 16:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812E9C341CA;
        Mon, 11 Jul 2022 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657557650;
        bh=/Lw4Q9soP+EcCVd0Sy1C1VtqWV7sCe+lIMQS2/XUllM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7Zr6+hM3Unc0j6Z1ocyilCLS89BjJccdJVZp4QSrUFOdjzclrd8k1RvJkL+LUoa4
         z/ekQUcZQJFTsZUyOTz/SUXjmedvbIewglgXTVqtbUK6Ve5ucflHQBA8x2/F3X1D4x
         V3mranynsaHvXZ/VX6YYGfukLuvoZ8NKyZ2UUObC3s27jIMBJV40fYyHazTXqx/1Gh
         hCEchTC7dRnLtqaFA6SgwmAR7qLB80aYdt02GHOHghzd2LZkR8GB5f+N7cgmithXuR
         Y8IJhk5D8eXBta4lszqfqaBwnW9uFdHYenPtsjmssbpe/Skr/kqJojcOho2TDiyM13
         3pEAlKT6+06NQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oAwSo-0000sn-9N; Mon, 11 Jul 2022 18:40:51 +0200
Date:   Mon, 11 Jul 2022 18:40:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <YsxSkswzsqgMOc0l@hovoldconsulting.com>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:30:03PM +0530, Viresh Kumar wrote:
> Hello,
> 
> This patchset adds support for devices with multiple clocks. None of the clocks
> is considered primary in this case and all are handled equally.
> 
> The drivers, for multiple clock case, are expected to call dev_pm_opp_set_opp()
> to set the specific OPP. Though how they find the target OPP is left for the
> users to handle. For some, we may have another unique OPP property, like level,
> which can be used to find the OPP. While in case of others, we may want to
> implement freq-based OPP finder APIs for multiple clock rates. I have decided
> not to implement them in advance, and add them only someone wants to use them.

This break OPP parsing on SC8280XP and hence cpufreq and other things:

[  +0.010890] cpu cpu0: _opp_add_static_v2: opp key field not found
[  +0.000019] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -19
[  +0.000060] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 403200000, volt: 576000, enabled: 1
[  +0.000030] cpu cpu0: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 300000000, volt: 576000, enabled: 1. New: freq: 499200000, volt: 576000, enabled: 1
...

I just did a rebase on next-20220708 and hit this.

I've narrowed it down to _read_rate() now returning -ENODEV since
opp_table->clk_count is zero.

Similar to what was reported for tegra for v1:

	https://lore.kernel.org/all/58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com/

I don't have time to look at this any more today, but it would we nice
if you could unbreak linux-next.

Perhaps Bjorn or Mani can help with further details, but this doesn't
look like something that is specific to SC8280XP.

Johan
