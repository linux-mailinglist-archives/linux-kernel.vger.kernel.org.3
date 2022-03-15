Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD594D9E48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349539AbiCOPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiCOPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:00:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E53123C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:59:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y22so24586617eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6rTSVU1/3AbRjY15AsbPBs2HFvZP70FLbPlPV618gI=;
        b=bK/gByB3xQBLF+F8Wcj07Avb2+VNj7934Px9Rzx3egIwaZN8N4j3RSb3T5ff2tEg3y
         ekfTKaN9VKq2YU9izk0jsBax6oFHjAI+x7ZUtvqUNQTXKFDSAkmNhxHr2JJG7Y1Sl3Vy
         Q2XfYe/86q4ha2MBOIHSgZ1e7B6nc5zvE2nSDwSehsdi2BdE9COXBZh719z/NwWoj94+
         ueYZ2NUMbJ88B3xuKuxP/t9IBssyQEtw0/31n8V+SCzQLTVSCkppgJNU+AM9+Bnjee+N
         akREYK3+LdobdAaz8WnCcKcPomCDsAw8hpusNtfQfTTWcqZjwNVWBTVFIkk6aj6FG9g2
         /veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6rTSVU1/3AbRjY15AsbPBs2HFvZP70FLbPlPV618gI=;
        b=IWex9DNvni28fEUxxsqAyBFDib8DAmSaSBlpXdb4a7pNqvx4pf41AS6dMn1x1cyXKT
         hR+1xop7RLtqNoqqOHw6fQfcvD6Awc0znQVG3532Yv/DdKne6lODlz+nv+YDKTtwVngP
         AvdZcGzlvjt5TNGeaq6VWRI64BPwzAzdUz2Y3gbC+/37yCS7hFmZmYSl1aM76Dok00od
         o09eD4cs5IyCdTClvKvmy+bjaEfBjOAcmRzBcYIDyLGcvyUGgEp2GHOeSrPQ87a4rquE
         5XV9Q+OhMAgMlss5vuKYa4ZzszPxf0inEkSIsIrVqRS5DsFeUFW+I5A7mg+K1cjfUamf
         FXyg==
X-Gm-Message-State: AOAM530L0V2pxSKJlCAvvUNP47ELrWkYZuNDdUSZKhYaY2TglgPe9Gbr
        ACthx5C7e9N9PVgwIjKZTvpklg==
X-Google-Smtp-Source: ABdhPJya/ViotW2aLhgJRm34MN9moeQCMci09wOx51mUSR6gqvjSidOnHOuS1rMgtDEReDytv6sz6g==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr25669840eds.100.1647356380931;
        Tue, 15 Mar 2022 07:59:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm8197418ejy.165.2022.03.15.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:59:40 -0700 (PDT)
Date:   Tue, 15 Mar 2022 22:59:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Message-ID: <20220315145935.GA168726@leoy-ThinkPad-X240s>
References: <20220313055512.248571-1-leo.yan@linaro.org>
 <Yi+FMrG9NyBnMX0i@arm.com>
 <20220315032919.GA217475@leoy-ThinkPad-X240s>
 <YjBlnMvcagdbKnEz@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjBlnMvcagdbKnEz@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Mar 15, 2022 at 10:08:28AM +0000, Sudeep Holla wrote:

[...]

> > > In my opinion it's difficult to handle absent "capacity-dmips-mhz"
> > > properties, as they can be a result of 3 scenarios: potential..
> > >  1. bug in DT
> > >  2. unwillingness to fill this information in DT
> > >  3. suggestion that we're dealing with CPUs with same u-arch
> > >     (same capacity-dmips-mhz)
> > 
> > For absent "capacity-dmips-mhz" properties, I think we could divide into
> > two sub classes:
> > 
> > For all CPU nodes are absent "capacity-dmips-mhz" properties, it's
> > likely all CPUs have the same micro architecture, thus developers are
> > not necessarily to explictly set the property.
> >
> 
> I completely disagree and NACK to deal with absence of the property in DT.
> The binding clearly states:
> 
> "CPU capacity is a number that provides the scheduler information about CPUs
> heterogeneity. Such heterogeneity can come from micro-architectural differences
> (e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> (e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> context is about differing performance characteristics; this binding tries to
> capture a first-order approximation of the relative performance of CPUs."
> 
> So it is clear that using same uarch can't be an excuse to miss this property.
> So if you need the scheduler to be aware of this heterogeneity, better update
> the DT with property. Absence will always means scheduler need not be aware
> of this heterogeneity.

Okay, understood your point and I am respect that.

> > For partial CPUs absent "capacity-dmips-mhz" properties, this is an
> > usage issue in DT and kernel should handle this as an error and report
> > it.
> >
> 
> That makes sense. As I mentioned in my earlier email, we can always flag
> up error in the kernel, but it would be good to catch these much earlier
> in DT via schema if possible.
> 
> > > I'm not sure it's up to us to interpret suggestions in the code so I
> > > believe treating missing information as error is the right choice, which
> > > is how we're handling this now.
> > 
> > Yes, current kernel means to treat missing info as error, whatever if
> > all CPUs or partial CPUs are absent "capacity-dmips-mhz" properties.
> >
> 
> OK, so no change needed ? I am confused as what is missing today.

The different understanding between us is for the case when all CPUs
absent "capacity-dmips-mhz" properties, seems to me we can take it as
the same thing as all CPUs with binding "capacity-dmips-mhz" = 1024.

Maybe I am is bit obsessive on this :)

> > > For 3. (and patch 03), isn't it easier to populate capacity-dmips-mhz to
> > > the same value (say 1024) in DT? That is a clear message that we're
> > > dealing with CPUs with the same u-arch.
> >
> > "capacity-dmips-mhz" is defined as a _optional_ property in the DT
> > document (see devicetree/bindings/arm/cpu-capacity.txt).
> 
> That means that the kernel can operate without the info and nothing more
> than that. We are not providing guarantee that the same performance is
> possible with or without this optional property.
> 
> > Current kernel rolls back every CPU raw capacity to 1024 if DT doesn't
> > bind "capacity-dmips-mhz" properties, given many SoCs with same CPU
> > u-arch this is right thing to do; here I think kernel should proceed to
> > scale CPU capacity with its maximum frequency.
> 
> As stated above, I completely disagree and once again NACK.
> 
> > When I worked on a platform with a fast and a slow clusters (two clusters
> > have different max frequencies and with the same CPU u-arch), it's a bit
> > puzzle when I saw all CPU's capacities are always 1024.  In this case,
> > since a platform have no CPU capacity modeling, and "capacity-dmips-mhz"
> > property is not needed to populate in DT, but at the end the kernel
> > should can reflect the scaled CPU capacity correctly.
> >
> 
> Fix the broken DT with respect to this feature. I mean DT is not broken, but
> if once needs this feature then they should teach the kernel the hardware
> difference with this property.
> 
> Another possible issue I can see if this is dealt within the kernel is if
> on some platform for thermal or any valid hardware errata reasons, one set
> of CPUs can run at max one frequency while the other is restricted at a
> suitable lower frequency, it may not be good idea to mark that as difference
> in cpu capacity as they are SMP CPUs just in different perf domains with
> different limits. I assume the scale invariance must deal with that.
> I may be wrong here but that's my understanding, happy to be corrected.

After looked a bit for the code, the short answer is we don't need to
adjust "capacity-dmips-mhz" for any thermal capping or CPU frequency
limit.

Since "capacity-dmips-mhz"'s unit is DMIPS/MHz, it's a modeling value
(e.g. generated by using Dhrystone, sysbench, etc).  This is why for
the same micro architecture CPUs, we don't need to do any profiling
and would be fine to directly set as 1024 for all CPUs (no matter the
maximum frequency).

In the kernel, there have two scale invariants: one is CPU capacity
invariant, my understanding is it can allow us to compare capacity
across CPUs; another is CPU frequency invariant, it's used to scale
capacity for different OPPs on a CPU.

So "capacity-dmips-mhz" is used to calculate CPU capacity invariant,
the formual is:

  cpu_scale(cpu) = capacity-dmips-mhz(cpu) * policy(cpu)->cpuinfo.max_freq

policy(cpu)->cpuinfo.max_freq is the maximum frequency when register OPP
table, it's no matter with thermal capping or CPU frequency limit.

Thanks,
Leo
