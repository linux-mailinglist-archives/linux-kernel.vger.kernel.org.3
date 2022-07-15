Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD9576521
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGOQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGOQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:09:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C613ED47;
        Fri, 15 Jul 2022 09:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A8B7B82D2C;
        Fri, 15 Jul 2022 16:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331FFC34115;
        Fri, 15 Jul 2022 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657901387;
        bh=BjSbIr+2Nq9y04Bvcith1dzZyRMQ2BPB5HQmV40tK+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IONll5Bl8RuRVB5WgFNBRujgBOHSRrA7LH+JNiXzk27U+8RZEzQpKokOWinstWW1U
         kC+iHFPIkI3Us1AjnpHNh2bIfNPm6dhg6ICGUoWjMirxoTBA1fBwjHUZXPezlEj9AA
         78+KT0xlfJgzgwOPWVGoyY1R/5rPpuSQ1/Fc803Ac9eKPUMAUUjl0m4I6qCLq+AVmc
         GC6SuM1/9uGb3b3w0HYulz5Xw8J8meMUAZl/PWKNNEKMP0rY9N1MP5vcFRgnaOdBfg
         5QM1gLHlIpVTsI2IZ+6TM4Kp3qoOv7F1k6u/j6EvWc60jebWqP2bHVUwowxwmAinxr
         e4M1JPNZnzt/Q==
Date:   Fri, 15 Jul 2022 21:39:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] cpufreq: qcom-hw: Move clocks to CPU node
Message-ID: <20220715160933.GD12197@workstation>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657695140.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:22:55PM +0530, Viresh Kumar wrote:
> Hi,
> 
> A recent patch series, targeting enhancements in the OPP core, ended up breaking
> cpufreq on some of the Qualcomm platforms [1]. Necessary adjustments are made in
> the OPP core, a bit hacky though, to get it working for now but it would be
> better to solve the problem at hand in a cleaner way. And this patchset is an
> attempt towards the same.
> 
> cpufreq-hw is a hardware engine, which takes care of frequency
> management for CPUs. The engine manages the clocks for CPU devices, but
> it isn't the end consumer of the clocks, which are the CPUs in this
> case.
> 
> For this reason, it looks incorrect to keep the clock related properties
> in the cpufreq-hw node. They should really be present at the end user,
> i.e. the CPUs.
> 
> The case was simple currently as all the devices, i.e. the CPUs, that
> the engine manages share the same clock names. What if the clock names
> are different for different CPUs or clusters ? How will keeping the
> clock properties in the cpufreq-hw node work in that case ?
> 
> This design creates further problems for frameworks like OPP, which
> expects all such details (clocks) to be present in the end device node
> itself, instead of another related node.
> 
> This patchset moves the clock properties to the node that uses them instead,
> i.e. the CPU nodes and makes necessary adjustments at other places.
> 
> After this is applied, I can drop the unnecessary change from the OPP core, but
> I wanted to discuss if this is a step in the right direction or not first and so
> the RFC.
> 

The clocks defined in the devicetree currently (CXO, GPLL) are the source
clocks of the EPSS block (cpufreq-hw). And EPSS will supply clock and
voltage through other blocks to the CPU domains. Even though the end
consumer of the source clocks are the CPUs, those clocks are not
directly reachign the CPUs but instead through some other blocks in EPSS.

Initially I was temped to add cpufreq-hw as the clock provider and have
it source clocks to the individual CPUs. This somehow models the clock
topology also, but after having a discussion with Bjorn we concluded that
it is best to leave it as it is.

The main issue that Bjorn pointed out was the fact that the clocks coming
out of EPSS are not exactly of the same frequency that was requested.
EPSS will do its own logic to generate the clocks to the CPUs based on
the input frequency vote and limits.

Thanks,
Mani

> --
> Viresh
> 
> [1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/
> 
> Viresh Kumar (4):
>   dt-bindings: cpufreq-qcom-hw: Move clocks to CPU nodes
>   arm64: dts: qcom: Move clocks to CPU nodes
>   cpufreq: qcom-cpufreq-hw: Clocks are moved to CPU nodes
>   cpufreq: qcom-cpufreq-hw: Register config_clks helper
> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 31 ++++----
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 19 ++++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 18 ++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 19 ++++-
>  arch/arm64/boot/dts/qcom/sm6350.dtsi          | 18 ++++-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          | 19 ++++-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          | 18 ++++-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          | 19 ++++-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          | 18 ++++-
>  drivers/cpufreq/qcom-cpufreq-hw.c             | 75 ++++++++++++++-----
>  10 files changed, 199 insertions(+), 55 deletions(-)
> 
> -- 
> 2.31.1.272.g89b43f80a514
> 
