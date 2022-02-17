Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B14BA624
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiBQQiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:38:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiBQQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:38:15 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1402B3191
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:38:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q17so10715844edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UONcOwfoMw9pDe0rAm3joCYRBAlJSecwdegwEBnOH94=;
        b=BtDO6RRgSUv6ucKn+TGhcqPblYqbEYF7TwKvQNAFwkl2M7GjGv8hef8O/yBTGEHQPq
         P/sbxxp3UcCm26QbSnlduFWQh7o0rjHbP6Y3novYM+F8S6LDHRWACDrnYUcNJfsOAFQa
         KqvWJsy8MTLOwCtpGXPEDjeAQUGhIaQqPHS2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UONcOwfoMw9pDe0rAm3joCYRBAlJSecwdegwEBnOH94=;
        b=kpSbz/aJ0MMIjChbc1HgJc60Sc+C8yTU/63fU30IEEUh7kbAFQNTbZhfhA4Jh32ktB
         squgh4+GjEKVJFsbUDLIFM6xVB9bJFB7Ugp7sAzqNr5YHJdqzLEuY5me4wt0yRVdV/LL
         AokyOaVYUGIUO1ghT+YWZj3ZRrMItX2/8iKfAKDpU++M/OKEcc816DhaqRvfywcK+Q/q
         sUSvi9TA6XYc/8I4NYure+0Th5lc5ZAXbhC6htHq6rF9/LPIfpLkV8m0YAJA9eX1xqIp
         RxNj8y3Mny322psCSiWa6GAeMulrQH9y92ntyuClHII3dvqPheTnDZkR9gzHjn6iH7av
         sC/A==
X-Gm-Message-State: AOAM533r7/hR2KrwidGUDtfVr9c3nCf7nNnSRXOYpWWHUgamynBA3K80
        bmMz7mD1dOWrgtJrai60ZFN87zAoyI/x9eBD2Mc=
X-Google-Smtp-Source: ABdhPJwuLbin9B5YUBaqDf7f2+n8dqbSHTNQeP21b6HVA6hyQyZjp76AwlwUNJl0/dgf2qJ6pBQCJg==
X-Received: by 2002:a05:6402:1d49:b0:412:8cf5:73fa with SMTP id dz9-20020a0564021d4900b004128cf573famr3563338edb.334.1645115878720;
        Thu, 17 Feb 2022 08:37:58 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id f22sm1361112ejl.46.2022.02.17.08.37.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:37:56 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id w11so10049815wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:37:55 -0800 (PST)
X-Received: by 2002:a5d:4c48:0:b0:1e4:aeab:c77e with SMTP id
 n8-20020a5d4c48000000b001e4aeabc77emr2927222wrt.342.1645115875087; Thu, 17
 Feb 2022 08:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20220207073036.14901-1-lukasz.luba@arm.com> <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com> <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <YgKnnFl7Gp8AS30X@google.com> <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
 <YgQ9XLcto9v0fyTf@google.com> <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
 <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org> <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
In-Reply-To: <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Feb 2022 08:37:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WMaMP84YLZxBZbj4DJSgcDLVkSHf4QdDwtFfp8UbyE7A@mail.gmail.com>
Message-ID: <CAD=FV=WMaMP84YLZxBZbj4DJSgcDLVkSHf4QdDwtFfp8UbyE7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        jorcrous@amazon.com, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 17, 2022 at 2:47 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Daniel,
>
> On 2/17/22 10:10 AM, Daniel Lezcano wrote:
> > On 16/02/2022 18:33, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>
> >>> Hi Matthias,
> >>>
> >>> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
> >>>> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
> >>>>>
> >>>>>
> >>>>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
> >>>>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
> >>>>>>>
> >>>>>>>
> >>>
> >>> [snip]
> >>>
> >>>>>>> Could you point me to those devices please?
> >>>>>>
> >>>>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
> >>>>>>
> >>>>>> Though as per above they shouldn't be impacted by your change,
> >>>>>> since the
> >>>>>> CPUs always pretend to use milli-Watts.
> >>>>>>
> >>>>>> [skipped some questions/answers since sc7180 isn't actually
> >>>>>> impacted by
> >>>>>>     the change]
> >>>>>
> >>>>> Thank you Matthias. I will investigate your setup to get better
> >>>>> understanding.
> >>>>
> >>>> Thanks!
> >>>>
> >>>
> >>> I've checked those DT files and related code.
> >>> As you already said, this patch is safe for them.
> >>> So we can apply it IMO.
> >>>
> >>>
> >>> -------------Off-topic------------------
> >>> Not in $subject comments:
> >>>
> >>> AFAICS based on two files which define thermal zones:
> >>> sc7180-trogdor-homestar.dtsi
> >>> sc7180-trogdor-coachz.dtsi
> >>>
> >>> only the 'big' cores are used as cooling devices in the
> >>> 'skin_temp_thermal' - the CPU6 and CPU7.
> >>>
> >>> I assume you don't want to model at all the power usage
> >>> from the Little cluster (which is quite big: 6 CPUs), do you?
> >>> I can see that the Little CPUs have small dyn-power-coeff
> >>> ~30% of the big and lower max freq, but still might be worth
> >>> to add them to IPA. You might give them more 'weight', to
> >>> make sure they receive more power during power split.
> >>>
> >>> You also don't have GPU cooling device in that thermal zone.
> >>> Based on my experience if your GPU is a power hungry one,
> >>> e.g. 2-4Watts, you might get better results when you model
> >>> this 'hot' device (which impacts your temp sensor reported value).
> >>
> >> I think the two boards you point at (homestar and coachz) are just the
> >> two that override the default defined in the SoC dtsi file. If you
> >> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
> >> map. You can also see the cooling maps for the littles.
> >>
> >> I guess we don't have a `dynamic-power-coefficient` for the GPU,
> >> though? Seems like we should, but I haven't dug through all the code
> >> here...
> >
> > The dynamic-power-coefficient is available for OPPs which includes
> > CPUfreq and devfreq. As the GPU is managed by devfreq, setting the
> > dynamic-power-coefficient makes the energy model available for it.
> >
> > However, the OPPs must define the frequency and the voltage. That is the
> > case for most platforms except on QCom platform.
> >
> > That may not be specified as it uses a frequency index and the hardware
> > does the voltage change in our back. The QCom cpufreq backend get the
> > voltage table from a register (or whatever) and completes the voltage
> > values for the OPPs, thus adding the information which is missing in the
> > device tree. The energy model can then initializes itself and allows the
> > usage of the Energy Aware Scheduler.
> >
> > However this piece of code is missing for the GPU part.
> >
>
> Thank you for joining the discussion. I don't know about that Qcom
> GPU voltage information is missing.
>
> If the voltage is not available (only the frequencies), there is
> another way. There is an 'advanced' EM which uses registration function:
> em_dev_register_perf_domain(). It uses a local driver callback to get
> power for each found frequency. It has benefit because there is no
> restriction to 'fit' into the math formula, instead just avg power
> values can be feed into EM. It's called 'advanced' EM [1].

It seems like there _should_ be a way to get the voltage out for GPU
operating points, like is done with cpufreq in
qcom_cpufreq_hw_read_lut(), but it might need someone with Qualcomm
documentation to help with it. Maybe Rajendra would be able to help?
Adding Jordon and Rob to this conversation in case they're aware of
anything.

As you said, we could just list a power for each frequency, though.

I'm actually not sure which one would be more accurate across a range
of devices with different "corners": specifying a dynamic power
coefficient used for all "corners" and then using the actual voltage
and doing the math, or specifying a power number for each frequency
and ignoring the actual voltage used. In any case we're trying to get
ballpark numbers and not every device will be exactly the same, so
probably it doesn't matter that much.


> Now we hit (again) the DT & EM issue (it's an old one, IIRC Morten
> was proposing from ~2014 this upstream, but EAS wasn't merged back
> then):
> where to store these power-freq values, which are then used by the
> callback. We have the 'dynamic-power-coefficient' in DT, but
> it has limitations. It would be good to have this simple array
> attached to the GPU/CPU node. IMHO it meet the requirement of DT,
> it describes the HW (it would have HZ and Watts values).
>
> Doug, Matthias could you have a look at that function and its
> usage, please [1]?
> If you guys would support me in this, I would start, with an RFC
> proposal, a discussion on LKML.
>
> [1]
> https://elixir.bootlin.com/linux/v5.17-rc4/source/Documentation/power/energy-model.rst#L87

Matthias: I think you've spent more time on the thermal stuff than me
so I'll assume you'll follow-up here. If not then please yell!

Ideally, though, someone from Qualcomm would jump in an own this.
Basically it allows more intelligently throttling the GPU and CPU
together in tandem instead of treating them separately IIUC, right?

-Doug
