Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B410355362A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350792AbiFUPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiFUPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:34:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD515A04
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:34:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso13765526pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/V/+YYZrFlvtCdfb2sUBNlJeIodua+DE/MZpzGTItj0=;
        b=EN5iNriTOwjp0S9DUzAk99diMPSRYxFc/YdvcYFmXhfaRnFbklR/2EQSSFRjZjSzI/
         wvKb1rLBI3rT7bbvdEmJffWILQJb6oCRUiGSTqAnS+lthnXJbkBtyYy15Mxy5pQP1P8X
         D7b4fUqEiIgGTxyzHUxAuyeO+Ft3E8DfMSaQlpKXXj7n2RDMnImOCowE/vCOlrBGL1kb
         qx3rZQ7eaqAuLHIjiJ8vFiPyrvIRyYsGfy3xh7D4mgmlRa+aX0n1XTxMi6p8cnUPjRTH
         2EqhTzUeYQijwJLopCODr46hf/95qJ0bVau6MgtNE7PSWt543N8Q+wXyNI3AWHabBlRk
         q9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/V/+YYZrFlvtCdfb2sUBNlJeIodua+DE/MZpzGTItj0=;
        b=mhvW82fOwarUdIMzx5zi4aK7FT2gYTG7QHsowYNecpiRxWy5zKYKnwTYjFQFdguSUE
         q4XRxGNRNFOeSlLSHEOUf02wV7N6jSc4DvbY3kG1Nh4hzjwzPMGhsFZA0MTKGCmwH6Uq
         8ooMOjJoORnpz+SK4gEgDKDgeKlv+gv5xGlkhJHGFznaUG4HKAG6tevnv9GQp9VXfDgP
         72vvW77xnqVXjP9NMCuuDJlik9XyMSwrKCe5XCh7vxSY1lZL6efqCmpMxYIsoof5il0O
         SjzHgjiHWaBqTJLh95YH8cl6PMhNOO8sQ7HVGwHdRxPF1VwZitGtTwIIRmZGADF7VbxN
         Zy7w==
X-Gm-Message-State: AJIora/LHAaD8IpP436Hn71Fn1AhKRZtjRDFE9xh62UOFlDoXtGcU617
        zhKh96+YEC5mp40057RN4QDI+w==
X-Google-Smtp-Source: AGRyM1uRAdNlEE4ncewgTKXm3tHw89Dn6NW6okZTTfjqi1GF5bAvxsdZ1dQo8KKj41BGI5sUbEDZyg==
X-Received: by 2002:a17:903:1cb:b0:16a:3a9d:4813 with SMTP id e11-20020a17090301cb00b0016a3a9d4813mr3223207plh.158.1655825683573;
        Tue, 21 Jun 2022 08:34:43 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016a38fa3f95sm1693856plb.118.2022.06.21.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:34:43 -0700 (PDT)
Date:   Tue, 21 Jun 2022 21:04:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/31] OPP: Add dev_pm_opp_set_config() and friends
Message-ID: <20220621153440.aazq7cjiq5vgkvxy@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <9c4b2bfe628bf7a583a96cee7cc3539e2e66245e.1653564321.git.viresh.kumar@linaro.org>
 <da2f1552-6896-5ae8-4837-28f31f3031a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2f1552-6896-5ae8-4837-28f31f3031a9@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 21-06-22, 18:09, Dmitry Osipenko wrote:
> 1. I started to look at the Tegra regressions caused by these OPP
> patches and this one looks wrong to me because dev_pm_opp_set_config()
> could be invoked multiple times by different drivers for the same device
> and then you're putting table not in accordance to the config that was
> used by a particular driver.
> 
> For example, if parent tegra-cpufreq driver sets supported_hw for
> cpu_dev and then cpufreq-dt also does dev_pm_opp_set_config(cpu_dev),
> then dev_pm_opp_clear_config(cpu_dev) of cpufreq-dt will put
> supported_hw(cpu_dev) of tegra-cpufreq. Hence this
> dev_pm_opp_set/clear_config() approach isn't viable, unless I'm missing
> something.

Yeah, I know that and I didn't put a lot of effort into it because of multiple
reasons:

- That is partially the existing behavior. For example, we can call the
  set-supported-hw interface right now for each CPU of a policy, which many
  drivers do right now btw, and then while putting them back we drop the
  resource on the first call itself and not on the last CPU.

- Yes, with the new patchset we will drop the resources even for an unrelated
  resource call, I will think again about it though and maybe add a flag field
  to notify which all resources to clean, but even in the current case it should
  be fine as we won't be able to use a half initialized OPP table anyway (which
  may actually be harmful). What I mean is, if you set regulators and
  supported-hw in the beginning, then on un-init, we won't want to work with
  only one of them in place. We always want all of them.

> 2. Patches aren't bisectable, please make sure that all patches compile
> individually and without warnings.

That is strange. I will try build over each and every patch (again). Also I
think the kernel bots (from LKP) test individual patches and I haven't got any
failure messages yet. Which patch broke the build for you ?

> 3. There is a new NULL dereference in the recent linux-next on Tegra in
> _set_opp() of the gpu/host1x driver. I'll take a closer look at this
> crash a bit later.

I just fixed a bug for devices which don't have the clock property, but just
level or bandwidth. Not sure if that is the one that caused trouble for you. It
is pushed to opp/linux-next.

-- 
viresh
