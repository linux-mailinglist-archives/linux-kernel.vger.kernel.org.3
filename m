Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31895A5BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH3GVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3GVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EB73323;
        Mon, 29 Aug 2022 23:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C6761407;
        Tue, 30 Aug 2022 06:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93272C433D7;
        Tue, 30 Aug 2022 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661840464;
        bh=4pblfYpA63CrE4rMWyeeR7WMMlRkZGVcfIrjeRiiXz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0lVDNWwDs0piYuKSZk4VHLRFseVcxbpP6HucMF7+eCB2612CLy1kIWMwmnBeIs+c
         T7ibHa1Qym3Ik7wZocYQ9/Cfz//5yURLwjqVPrKFdEpjnib54SOGZb385BPqwLkloO
         p8CwTCO/wu1uGyVYhP8/IpHlPzNDo/3IdtlscjGpKhPMk1EpOOVSgMRWHbDbbQeicK
         1ndJU+IIYlJ3giv8NHI/IIaKKK5JluMNfgJCZOHHf3cM2ntiRdc78d5eZ0dSbSEuKN
         s2iFapYfReXT0fu07fzYUgfe58nQLzXfRbeTn2mxzkBc4CV5TcS2Vp8UdPpFwgBLQ+
         NkEEediBSO2Rg==
Date:   Tue, 30 Aug 2022 11:50:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20220830062050.GA7066@workstation>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <20220715160933.GD12197@workstation>
 <20220718015742.uwskqo55qd67jx2w@vireshk-i7>
 <20220801023756.76jswkbwivuntqof@vireshk-i7>
 <20220830032456.z4olnogsyg32vhiz@builder.lan>
 <20220830054042.akj7pf366inelvpo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830054042.akj7pf366inelvpo@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:10:42AM +0530, Viresh Kumar wrote:
> On 29-08-22, 22:24, Bjorn Andersson wrote:
> > Conceptually, it sounds like a good idea to express the clock feeding
> > the CPU clusters, which is controlled by the OSM/EPSS.  But do you
> > expect the OPP framework to actually do something with the clock, or
> > just to ensure that the relationship is properly described?
> 
> No, the OPP core will never try to set the clock rate in your case,
> though it will do clk_get().
> 

Okay. Then I think it is a fair argument to make qcom-cpufreq-hw as the
clock provider for CPUs.

I will send the RFC soon.

Thanks,
Mani

> > FWIW, the possible discrepancy between the requested frequency and the
> > actual frequency comes from the fact that OSM/EPSS throttles the cluster
> > frequency based on a number of different factors (thermal, voltages
> > ...).
> > This is reported back to the kernel using the thermal pressure
> > interface. It would be quite interesting to see some investigation in
> > how efficient the kernel is at making use of this feedback.
> 
> -- 
> viresh
