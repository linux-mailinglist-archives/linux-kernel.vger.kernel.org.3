Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315074AFFFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiBIWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:17:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBIWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:17:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3AC0045D0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:17:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso3670452pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZpHy7NFzc6I5AYN1nAZFZJcd/w7v2r3d8w4j/LB1fQU=;
        b=CIxIzFcc6hF3+u6EF0NlZaCg27NvGxJj5+ZLhbj/2/rfUalPsatjOPifGFVaye6I8F
         WAsrKZlJRKIeSZtCnoam7nR8t2pVXo237g5J0ic3NsAemxazV0TjoMhrPsbNd/SbomKf
         rqJ/ZzlYFGCwo+O6SCWcAEzvmjRiRd65XrL7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpHy7NFzc6I5AYN1nAZFZJcd/w7v2r3d8w4j/LB1fQU=;
        b=IrzPW5BEmYtkGp/oDVP/i0obE52KxInqtWkqKpVQ8cM1d3YKvZCtmn96cQgsg53P79
         StNSIxGr02C0NaDvkEiGMACyFoYqcAtTc56IdipbMbNATWmJqfILfq3ZuiZhVL2VRNjd
         W0myKVnza1dB68kRyIn8Y2X2p2YfdqqP0i6cLfapkFirFC1wU3708gt2xSHEXLoLuyHO
         0xbP6A3vcjNFW4iYjc5p1tcEZlZQal0DBJSD5lva88AFKaojxvtLyF7+TUsDsQYGPDnI
         bnWEwbrEKuZerMwAqPRnrb9xLQJ4GIAoWTMSxqJhsjlK/B72nnS4RFfwSCXLLmjq6Z5t
         0Nyw==
X-Gm-Message-State: AOAM5307147gEiLvKrWm8upZlSo2FvH8hwETcetg36lgKneva9uBa9bG
        2rB/FJOx28640Y7/QcXq49AVV1efKVdEQA==
X-Google-Smtp-Source: ABdhPJziH9GmwZnHk78uUQtkOvDrptkApFHkf4J/JQsHINiGZsSnEai7aa3TIHg9TKyZjhyYUSUC5Q==
X-Received: by 2002:a17:90a:e557:: with SMTP id ei23mr5029645pjb.149.1644445023613;
        Wed, 09 Feb 2022 14:17:03 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76d3:cb1:9cf9:95c0])
        by smtp.gmail.com with UTF8SMTPSA id j8sm22134103pfc.48.2022.02.09.14.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:17:03 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:17:00 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Message-ID: <YgQ9XLcto9v0fyTf@google.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
> 
> 
> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
> > On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
> > > 
> > > 
> > > On 2/8/22 12:50 AM, Matthias Kaehlcke wrote:
> > > > On Mon, Feb 07, 2022 at 07:30:35AM +0000, Lukasz Luba wrote:
> > > > > The Energy Model supports power values either in Watts or in some abstract
> > > > > scale. When the 2nd option is in use, the thermal governor IPA should not
> > > > > be allowed to operate, since the relation between cooling devices is not
> > > > > properly defined. Thus, it might be possible that big GPU has lower power
> > > > > values in abstract scale than a Little CPU. To mitigate a misbehaviour
> > > > > of the thermal control algorithm, simply not register a cooling device
> > > > > capable of working with IPA.
> > > > 
> > > > Ugh, this would break thermal throttling for existing devices that are
> > > > currently supported in the upstream kernel.
> > > 
> > > Could you point me to those devices? I cannot find them in the mainline
> > > DT. There are no GPU devices which register Energy Model (EM) in
> > > upstream, neither using DT (which would be power in mW) nor explicitly
> > > providing EM get_power() callback. The EM is needed to have IPA.
> > > 
> > > Please clarify which existing devices are going to be broken with this
> > > change.
> > 
> > I was thinking about arch/arm64/boot/dts/qcom/sc7180-trogdor-*, and
> > potentially other SC7180 boards that use IPA for the CPU thermal
> > zones.
> > 
> > Initially SC7180 used an abstract scale for the CPU energy model,
> > however I realized your change doesn't actually impact SC7180 CPUs
> > for two reasons:
> > 
> > 1. The energy model of the CPUs is registered through
> > 
> >    cpufreq_register_em_with_opp
> >      dev_pm_opp_of_register_em
> >        em_dev_register_perf_domain
> > 
> > em_dev_register_perf_domain() is called with 'milliwatts = true',
> > regardless of the potentially abstract scale, so IPA would not be
> > disabled with your change.
> 
> That good registration.
> 
> > 
> > 2. There is a patch from Doug that adjusted the dynamic power
> > coefficients of the CPUs to be closer to reality:
> > 
> > commit 82ea7d411d43f60dce878252558e926f957109f0
> > Author: Douglas Anderson <dianders@chromium.org>
> > Date:   Thu Sep 2 14:51:37 2021 -0700
> > 
> >      arm64: dts: qcom: sc7180: Base dynamic CPU power coefficients in reality
> 
> Thanks for the link to the commit. I'll have a look. It's good that it
> doesn't break this board.
> 
> > 
> > > > Wasn't the conclusion that it is the responsability of the device tree
> > > > owners to ensure that cooling devices with different scales aren't used
> > > > in the same thermal zone?
> > > 
> > > It's based on assumption that someone has DT and control. There was also
> > > implicit assumption that IPA would work properly on such platform - but
> > > it won't.
> > > 
> > > 1. You cannot have 2 thermal zones: one with CPUs and other with GPU
> > > only and both working with two instances of IPA.
> > 
> > It's not clear to me why such a configuration wouldn't work. Is it also a
> > problem to have multiple CPU thermal zones (one for each core) that use
> > multiple instances of IPA? SC7180 has separate thermal zones for each core
> > (or thermal sensor), Chrome OS uses IPA for CPU thermal throttling.
> 
> Unfortunately, the control mechanism is not working best in such setup.
> Main idea of IPA is to find 'best' OPP for a cooling device, e.g.
> one in the middle of a freq table. Worst scenario is when we change
> our decision between lowest and highest OPP, in short periods.
> It's burning too much power at highest freq, then we throttle too much,
> then we unthrottle because temp is dropping by some 'good enough' value.
> This situation can happen due to a few reasons:
> 1. Power values from EM are not reflecting reality, e.g. scaled too much
> 2. We don't have proper information about CPU load and frequencies used
> 3. PID coefficients are not properly set
> 4. board has small physical thermal sink potential but silicon if 'hot'
> 5. the workload is too dynamic
> 6. there is another power hungry device (GPU, DSP, ISP) which is outside
>    of our control loop, e.g. is controlled in other thermal zone and has
>    impact on our temp sensor value

Thanks for the details!

> Proper setup and tuning of IPA could bring quite good benefit, because
> it could pick the 'best at that moment' OPPs for the devices, instead
> of throttling too hard and then unthrottling. Unfortunately, it's
> tricky and needs time (experiments, understanding the system).

On some sc7180 ChromeOS boards we observed a behavior as you describe,
we mitigated it by tuning the device 'sustainable-power' device tree
property and the trip point temperatures.

> We have been trying to easy this entry barrier for developers. Very good
> results brings the optimization of the PID coefficients. The automated
> mechanism would figure out best values for the given board based on the
> tests run. It's under review now, there are also shared results [1][2].
> It would solve a some of the issues with complex tuning.

Good to know, thanks for the pointer!

> I was going to give it a try for my old experiments with the bogoWatts
> devices, but I don't expect that this is a silver bullet. Regarding
> the 'two thermal zones with IPA issues' I'm prity sure it won't help.
> 
> > 
> > > 2. The abstract power scale doesn't guaranty anything about power values
> > > and IPA was simply designed with milli-Watts in mind. So even working
> > > on CPUs only using bogoWatts, is not what we could guaranty in IPA.
> > 
> > That's bad news for SoCs that are configured with bogoWatt values, from
> > past discussions I had the impression that this is unfortunately not
> > uncommon.
> > 
> > > It's ugly to have the abstract scales in the first place, but that's
> > > unfortunately what we currently have for at least some cooling devices.
> > 
> > > A few questions:
> > > 
> > > Do you use 'we' as Chrome engineers?
> > 
> > I was referring to the kernel, in particular QCOM SC7180.
> 
> Thanks for sharing the name.
> 
> > 
> > > Could you point me to those devices please?
> > 
> > arch/arm64/boot/dts/qcom/sc7180-trogdor-*
> > 
> > Though as per above they shouldn't be impacted by your change, since the
> > CPUs always pretend to use milli-Watts.
> > 
> > [skipped some questions/answers since sc7180 isn't actually impacted by
> >   the change]
> 
> Thank you Matthias. I will investigate your setup to get better
> understanding.

Thanks!
