Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4217A4ADF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384277AbiBHR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384244AbiBHRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:25:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B9AC06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:25:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e28so20053856pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cib/chw0Mb1unxiFkWS5LEJe9zXPAE/9BcI3EX7Nnkc=;
        b=FvN6s4uPYQxdJXKi2d2cz9Lqy70gKJqtodmmOFu08JZDwJTgLQIiEkwCPP2FYjCDgE
         rRofzWcTrybALgUCJRX5dAnfZql3swZiLe63nOFDM4i8zZhaN+vyNhIL6VKpgXKhcQxk
         5Z1xRFoGYYrLsViFP56wB3J7wttAMRWmaEfJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cib/chw0Mb1unxiFkWS5LEJe9zXPAE/9BcI3EX7Nnkc=;
        b=uJ3vRBqJ+hElmXfl+ev49o4wK2Qte2Wjk7RsjTWpe5mXZCKgHdZ1zjRjo8AwBvWk1H
         yMXhbawW9M7Mngs5ae4KB5I34o4HuFnoi+ZcvuymSqxqEWxJa+3hq0ZnagEV1pk+zWI8
         PZiBnvKi9zoBjDKlmOwmFCgTltyIEcnvcZrzBISeN9FVE2Jr8PqRxY8HA70xS8ykgEC4
         jADw4K4gkn4H7styzvk/dDQm54vj7QJSGEKW8tAghbi6o7VWIN2ONxCOHRtBaGLDwhWr
         tmMHE1tntUHCN+AckQJCOQqhV+kqjETRlBwEfYtDNFIUTuVAB9Tjy/ahB+FAwwCvwj7i
         62rg==
X-Gm-Message-State: AOAM5323O2dcERsOpU1Z42uXx4f9iq9AGsgZDisBdgG3060SkmS4lgKi
        m4M1vjOmuib7t6kTS0uFY/NpxA==
X-Google-Smtp-Source: ABdhPJx49KZto+T/+N8XoEoYFIWssK5O2duMSNGvlQOF2cX43dpBYyMits2jwmbP1frpGxlAwM11bw==
X-Received: by 2002:a63:2a95:: with SMTP id q143mr4415837pgq.492.1644341150692;
        Tue, 08 Feb 2022 09:25:50 -0800 (PST)
Received: from localhost ([2620:15c:202:201:45cc:a522:8718:fc78])
        by smtp.gmail.com with UTF8SMTPSA id z7sm16719798pfe.49.2022.02.08.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:25:50 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:25:48 -0800
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
Message-ID: <YgKnnFl7Gp8AS30X@google.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
> 
> 
> On 2/8/22 12:50 AM, Matthias Kaehlcke wrote:
> > On Mon, Feb 07, 2022 at 07:30:35AM +0000, Lukasz Luba wrote:
> > > The Energy Model supports power values either in Watts or in some abstract
> > > scale. When the 2nd option is in use, the thermal governor IPA should not
> > > be allowed to operate, since the relation between cooling devices is not
> > > properly defined. Thus, it might be possible that big GPU has lower power
> > > values in abstract scale than a Little CPU. To mitigate a misbehaviour
> > > of the thermal control algorithm, simply not register a cooling device
> > > capable of working with IPA.
> > 
> > Ugh, this would break thermal throttling for existing devices that are
> > currently supported in the upstream kernel.
> 
> Could you point me to those devices? I cannot find them in the mainline
> DT. There are no GPU devices which register Energy Model (EM) in
> upstream, neither using DT (which would be power in mW) nor explicitly
> providing EM get_power() callback. The EM is needed to have IPA.
> 
> Please clarify which existing devices are going to be broken with this
> change.

I was thinking about arch/arm64/boot/dts/qcom/sc7180-trogdor-*, and
potentially other SC7180 boards that use IPA for the CPU thermal
zones.

Initially SC7180 used an abstract scale for the CPU energy model,
however I realized your change doesn't actually impact SC7180 CPUs
for two reasons:

1. The energy model of the CPUs is registered through

  cpufreq_register_em_with_opp
    dev_pm_opp_of_register_em
      em_dev_register_perf_domain

em_dev_register_perf_domain() is called with 'milliwatts = true',
regardless of the potentially abstract scale, so IPA would not be
disabled with your change.

2. There is a patch from Doug that adjusted the dynamic power
coefficients of the CPUs to be closer to reality:

commit 82ea7d411d43f60dce878252558e926f957109f0
Author: Douglas Anderson <dianders@chromium.org>
Date:   Thu Sep 2 14:51:37 2021 -0700

    arm64: dts: qcom: sc7180: Base dynamic CPU power coefficients in reality

> > Wasn't the conclusion that it is the responsability of the device tree
> > owners to ensure that cooling devices with different scales aren't used
> > in the same thermal zone?
> 
> It's based on assumption that someone has DT and control. There was also
> implicit assumption that IPA would work properly on such platform - but
> it won't.
> 
> 1. You cannot have 2 thermal zones: one with CPUs and other with GPU
> only and both working with two instances of IPA.

It's not clear to me why such a configuration wouldn't work. Is it also a
problem to have multiple CPU thermal zones (one for each core) that use
multiple instances of IPA? SC7180 has separate thermal zones for each core
(or thermal sensor), Chrome OS uses IPA for CPU thermal throttling.

> 2. The abstract power scale doesn't guaranty anything about power values
> and IPA was simply designed with milli-Watts in mind. So even working
> on CPUs only using bogoWatts, is not what we could guaranty in IPA.

That's bad news for SoCs that are configured with bogoWatt values, from
past discussions I had the impression that this is unfortunately not
uncommon.

> It's ugly to have the abstract scales in the first place, but that's
> unfortunately what we currently have for at least some cooling devices.

> A few questions:
>
> Do you use 'we' as Chrome engineers?

I was referring to the kernel, in particular QCOM SC7180.

> Could you point me to those devices please?

arch/arm64/boot/dts/qcom/sc7180-trogdor-*

Though as per above they shouldn't be impacted by your change, since the
CPUs always pretend to use milli-Watts.

[skipped some questions/answers since sc7180 isn't actually impacted by
 the change]

Thanks

Matthias
