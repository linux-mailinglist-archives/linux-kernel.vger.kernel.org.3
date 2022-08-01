Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83435863CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiHAFnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiHAFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425F13DEB;
        Sun, 31 Jul 2022 22:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16D860C93;
        Mon,  1 Aug 2022 05:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91FDC433C1;
        Mon,  1 Aug 2022 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659332589;
        bh=GsGF8A4Me4IQT0F9GvKCQUBEMKLVc7qayH0CzaMRxE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uv/bntGh5sgvS9Mm030zD5YjMm0KSOsVTmJ2zCMMkP0eDlk3DDFibIkO5TgLEOWS+
         HOry+Jf1cRNvOngT2lMtgyHdm7k//Wez9OQQFk1AdAYoz475TMAZ3A4mA7uHYeafxI
         RQD5OpTuZ9YybIWaOektt0IJnta/E+ZnhB/1ESWgWblwkWvfLA1vOsRtjrwlcp7aJg
         I8Rtr5vGKxfiPhGpyMW6LUohqyVK5weFKF7QYNOeOt7vxcQ1fBv58pC8v3FoZHq1M5
         80mtBsjQe9oLTvoT5gw2ZRsLyc03R/8DoMhvAyo5HJ9v798VaaYJyN/2bnVv9YxskM
         rGzp29fXLaP5Q==
Date:   Mon, 1 Aug 2022 11:12:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <20220801054255.GA12039@thinkpad>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
 <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
 <20220801023756.76jswkbwivuntqof@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801023756.76jswkbwivuntqof@vireshk-i7>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

I'm waiting for inputs from Bjorn.

@Bjorn: What do you think of the proposal to add qcom-cpufreq-hw as the clk
provider for CPUs?

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
