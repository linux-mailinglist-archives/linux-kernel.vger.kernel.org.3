Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554545A59DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiH3DZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiH3DZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE93186DE;
        Mon, 29 Aug 2022 20:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC911614AA;
        Tue, 30 Aug 2022 03:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C237C433D6;
        Tue, 30 Aug 2022 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829899;
        bh=9hGK2hAZcZYWulJdYIjJf7tiGycb8anU/VWbwURMWQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGoFryoJvV3w3FqyHZ1D1QDLeTfT8BvAmQegsbqpXVzxo81EqiIn7XJ1Fa5IJJRyo
         RAB1PS17eRzgQYYQjwFQzLuxdHssqG5bUzCoC5v8NMoTG14EmcJJUFRHyMZcWF1KNS
         sTm1Akuzfl5+j0ejXorLk94NBs1FIyex9ZLqovn4d0gJ/hYdj4l0p783q4B5HUZrtx
         7i4CxegndLkuH6vtXU4Y+hMXykJB2THHqLonIoWVetYMTWqglgy1HJ6MWBCMhlsNPf
         DqCaHUq+ALN7eLEjzC0Yk4Qvz8Y8Pe8Ol7YDfBcATz88f/H98LcJVCbbCvQL6UgBCt
         uhtRLNNnugBLw==
Date:   Mon, 29 Aug 2022 22:24:56 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] cpufreq: qcom-hw: Move clocks to CPU node
Message-ID: <20220830032456.z4olnogsyg32vhiz@builder.lan>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
 <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
 <20220801023756.76jswkbwivuntqof@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801023756.76jswkbwivuntqof@vireshk-i7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 08:07:56AM +0530, Viresh Kumar wrote:
> On 18-07-22, 07:27, Viresh Kumar wrote:
> > The OPP tables, which are part of the CPU nodes, mentions clock rates.
> > Are these values for the cxo/gpll clocks or the clock that reaches the
> > CPUs? I believe the latter. The DT is not really complete if the CPU
> > node mentions the frequency, but not the source clock. It works for
> > you because you don't want to do clk_set_rate() in this case, but then
> > it leaves other frameworks, like OPP, confused and rightly so.
> > 
> > Normally, there is always a difference in what the OPP table contains
> > as frequency value and what the hardware programs, mostly it is small
> > though. It shouldn't prevent us from having the hierarchy clearly
> > defined in the DT.
> > 
> > Based on your description, I think it would be better to make
> > cpufreq-hw a clock provider and CPUs the consumer of it. It would then
> > allow the OPP core to not carry the hack to make it all work.
> 
> Bjorn / Mani,
> 
> Can we please get this sorted out ? I don't want to carry an unnecessary hack in
> the OPP core for this.
> 

Conceptually, it sounds like a good idea to express the clock feeding
the CPU clusters, which is controlled by the OSM/EPSS.  But do you
expect the OPP framework to actually do something with the clock, or
just to ensure that the relationship is properly described?


FWIW, the possible discrepancy between the requested frequency and the
actual frequency comes from the fact that OSM/EPSS throttles the cluster
frequency based on a number of different factors (thermal, voltages
...).
This is reported back to the kernel using the thermal pressure
interface. It would be quite interesting to see some investigation in
how efficient the kernel is at making use of this feedback.

Regards,
Bjorn
