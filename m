Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212750F2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiDZHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbiDZHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:42:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655F135662
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:39:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f7b815ac06so96884607b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBtZaDgTc4PWoj0jX0RnMZyF5zFPU90KB5kgXu8bHUU=;
        b=VRg+sD5IYPYBVc5tZb6uvrIba7/O9kxO6qgc8tzplMaGIxF6HEHsxCQ6hurGTCrqQM
         GSaBjTPURi5BuCm4WoHtAumLf491qLy301fjJ5CQMDv1QJRqI7g0Fs6n9B7B4qQdxFPe
         I/pGevQU2XGnwuGF1Qi89s8JvbkFcTUX3PWXP/m5nxaNDxZzwSRnSEnKSG5wl4AWHWQh
         yJl5Ubipd293MY0+XEAAz+DgfjCM//8slu69uAYSjIcsHopA0ZKwKxPOM//QqZcUcxYf
         lbPE4Mt8O4ctDCBct+sZYplQVlq3DwNsCaoAb4/F0yoJnLz3i6dEvGxBXIsYVp/M6Lwl
         xzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBtZaDgTc4PWoj0jX0RnMZyF5zFPU90KB5kgXu8bHUU=;
        b=qnHxsiv5I6IDS7PgNcStJn1RWcRiU5WYRMsB1WLgVceDkh6xBdAtUbjtoxIq1VqIH8
         nFLERXPo1HY1/HlDa2ZYQ083meh3Fp2pdP7yHE5Z4Xl12Idla9immNW2VCmxL6ho5cIo
         mIkCX1T6MqUPLRHXFz3Gl3+f+ORKOypDsaufwTKQvAq+Ow1p1dVgMcUfb2n1DDlfWoBl
         1E+5sU2ytzAPK2HCenKyO0LWwwZdZXwgnnEk8BpdCu/plUIQWCp748dxxdWgOUOoYc7W
         HHNE2tW3FwWs66/EH9Pu43tkugl3qBuGxGSbHGpIEwEgpV+01l+cYbz/iq+XifbYGGk0
         +lOw==
X-Gm-Message-State: AOAM5310AYx3QCTesf+3T+CkJfoF0qO280s2zeA1gDJA9TxB3fHIA5+H
        bfnvIT6dC9rLcsgHJTfix71YL5olZVtV143GeXp+XMk5dFGL2A==
X-Google-Smtp-Source: ABdhPJxrwmJGLF73kVocBYp2l/avxbC7QpHVZXNeD2Gf45pAAIZ6QgLY7jfctgJXdXguXZeHn/mysWITsmIREFIywvY=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr20679198ywf.86.1650958783756; Tue, 26
 Apr 2022 00:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
 <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
 <9bb00bcb-f984-1cf6-39aa-c11dcf7f07cb@arm.com> <f100bd49-7a1d-5265-29ce-1092195bb2dd@arm.com>
 <CAB8ipk8v1-jyU0Q0k-EXCArsS6Sh=U+fW6NutW+6m+kQ=LKrJA@mail.gmail.com>
 <CAKfTPtDsNSW0JH4phAtZB7ackJFKuJfAGkhQ7JjWG_C2tzQYSw@mail.gmail.com>
 <24631a27-42d9-229f-d9b0-040ac993b749@arm.com> <CAKfTPtAnHmm0T+FKF251YcjM3Nw66Wqs2a16yU9Ptiip+jyNLA@mail.gmail.com>
 <e536ef07-4dd3-affd-0e27-6ff89a7f647f@arm.com> <CAKfTPtBfjnWoiTbhRBj4Ve65ukRdm90ri84dNivKuLDBMWhUAQ@mail.gmail.com>
 <ae98a861-8945-e630-8d4c-8112723d1007@arm.com>
In-Reply-To: <ae98a861-8945-e630-8d4c-8112723d1007@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 26 Apr 2022 09:39:32 +0200
Message-ID: <CAKfTPtCu4zYchv1d4g-ztw=qR639BS2ncapQxfcwZqkSSQPY0w@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com, Xuewen Yan <xuewen.yan94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 12:57, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 4/21/22 09:29, Vincent Guittot wrote:
> > On Tue, 19 Apr 2022 at 16:13, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 4/19/22 13:51, Vincent Guittot wrote:
> >>> On Tue, 19 Apr 2022 at 14:01, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/19/22 08:14, Vincent Guittot wrote:
> >>>>> On Sat, 16 Apr 2022 at 04:47, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Luba  / Dietmar
> >>>>>>
> >>>>>> On Wed, Apr 13, 2022 at 9:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>

[...]

> >>>> To be precised and maybe fix some potential design issues. We are
> >>>> talking here about utilization and set max capacity in function:
> >>>> sugov_get_util()
> >>>> so fields:
> >>>>
> >>>> sugov_cpu::util
> >>>> sugov_cpu::max /* max capacity */
> >>>
> >>> Yes. With this patch ,util will be lower than current thermal
> >>> mitigation whereas util normally reflects what we need  not what can
> >>> be provided
> >>
> >> This is a different requirements: util has to be max capacity and
> >> max capacity has to be original max CPU capacity - for the SchedUtil.
> >> OK, why? What this requirement adds in the design and final values?
> >
> > Because the calculation you are proposing is wrong and doesn't make
> > sense. Util is the average utilization of the cpu that has to be
> > compared with its original capacity max in order to get the freq that
> > matches with this utilization.
> >
> > We have freq = util / max * max_freq and cpufreq will then capp freq
> > if mitigation is applied. Once the mitigation disappear, the request
> > will be back to targeted freq.
> >
> > If you replace max by max' = max - arch_scale_thermal_pressure then :
> >
> > - by the time you do the calculation, arch_scale_thermal_pressure can
> > have changed and the result is meaningless. This is true whatever the
> > pace of updating arch_scale_thermal_pressure
>
> The sudden change of the value taken from arch_scale_thermal_pressure
> I can understand, but there are similar and we live with it. Look at
> the whole EAS estimations done in a one CPU waku-up event or the uclamp
> stuff. As far this is not too frequently occurring - we live wit it.
>
> I can see your concern here, since you mentioned below that you expect
> some platforms to hit it in 'khz' rate. This is probably not good, to
> trigger the kernel so often from HW/FW.
>
> That's why I have been struggling to find a 'good' design on this
> glue layer for Arm FW+kernel. Our FW would probably won't cause such
> huge notification traffic. A rate e.g. 50-100ms would be enough,
> especially if we have the per-CPU cpufreq policy. So we might have
> this 'PELT-like filter or signal' in FW, and just update kernel

In this case arch_scale_thermal_pressure() doesn't reflect the actual
thermal pressure but an average which is what thermal_load_avg() is
also doing.

> less often. But then there is an issue with the rising/decaying
> penalty of the kernel thermal pressure signal.
>
> We cannot assume that some SoCs don't do this already.
>
> Let's meet in the middle:
> 1) use the thermal PELT signal in RT:
> capacity = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))

This is what Dietmar and I have been suggested

> 2) introduce a more configurable thermal_pressure shifter instead
> 'sched_thermal_decay_shift', which would allow not only to make the
> decaying longer, but also shorter when the platform already might do
> that, to not cause too much traffic.
>
> >
> > - you change the range of capacity to max'= max -
> > arch_scale_thermal_pressure and you scale it to max_freq. if util >
> > max', then you will ask for max_freq whatever the util being really
> > close to max or not. Also you will ask for max freq even if util is
> > close but below max' whereas the mitigation doesn't impact utilization
>
> It's already there, even w/o patch. That's why I gave you the examples.

Not sure how to understand this above.

utilization can already goes above but this reflects a reality that
the task could need more capacity than the current cpu capacity

>
> BTW, isn't true that the utilization of the Little CPU rq can reach
> 1024 today after your change to the PELT when there is no idle time,
> even when cpu max capacity is e.g. 300?

yes

> Before that change the utilization of a throttled CPU rq would converge
> to the current capacity of the CPU, am I right?

yes

>
> Is it this commit:
> 23127296889fe84b0762b191
>
> >
> >>
> >>>
> >>>>

[...]

> >>>
> >>>> but then in both cases are multiplied by 'max_freq' in (2)
> >>>>
> >>>> As you can see this is not the situation that you have described, is it?
> >>>> And the transient or non-transient is minor here IMO.
> >>>
> >>> If max is 512 then util = 640 which is much lower than 1024.
> >>
> >> What scenario is this?
> >> Is 1024 the utilization that we might have from the CPU rq?
> >> What is the original CPU capacity, 1024?
>
> Is this 1024 the utilization of the CPU runqueue because since
> the new PELT we can have it bigger than CPU capacity?
>
> >>
> >>>
> >>>>
> >>>> Secondly, you have mentioned the mitigation in HW and issue between
> >>>> instantaneous vs. PELT-one thermal pressure information. This is
> >>>> something that I'm stretching my head for long. I'm trying to
> >>>> develop this for new Arm FW thermal. You have mentioned:
> >>>> 'thermal mitigation is managed by HW at a much higher
> >>>> frequency than what Linux can handle' - I would be also more
> >>>> precised here: HW or FW? How often the HW can change max freq or
> >>>> how often FW can change that? If we don't have those numbers
> >>>> than statement: 'a much higher' doesn't help in solving this
> >>>
> >>> By much higher means that Linux can't react fast enough and should not
> >>> try to sync because it's a lost game
> >>
> >> As I said, 'much higher' is not a number to base a design on it.
> >
> > But that gives you the constraint that you can't expect to be always
> > synced with up to date value which is the most important here. This
> > means that  cpu_cap -= arch_scale_thermal_pressure(cpu) can be wrong
> > just after you computed it and your decision is wrong.
>
> This is hypothetical situation when the value can change in such
> noisy way on some platform. But I understand your concern.
>
> >
> >
> >> We need real numbers from real platforms. Currently we have two
> >> places where the thermal pressure is set:
> >> 1) cpufreq_cooling.c [1]
> >> 2) Qcom driver [2]
> >> (we might have 3rd soon for Arm SCMI+FW)
> >
> > I don't have details but i have khz in mind
>
> If such traffic of interrupts in khz is true for driver in 2)
> then it's a bit concerning.
>
> Although, smarter platforms shouldn't suffer due to design forced to one
> corner case platform.
>
> >
> >>
> >> For the 2nd I would like to see numbers. For the 1st one when
> >> kernel thermal is used (which supports higher number of platforms
> >> comparing to Qcom driver) as it's by design kernel tries to control
> >> thermal, so changes are not that frequent.
> >>
> >> As for now, I can see in experiments the 1st is suffering long decay
> >> delays and also corner cases with long idle CPUs.
> >>
> >>>

[...]

> >> I'm trying to help Xuewen to solve his/her issues with the RT class
> >> incrementally. I don't want to push him/her into a deep dark water
> >> of PELT signals, to what variable compare them, corner cases when they
> >> are (or not) updated or completely not implemented. I'm not even sure
> >> if those extra complexities make sense for the RT/DL (since they
> >> make some difference on big.mid.little specific platforms but not for
> >> the rest).
>
> As I said we need a way forward, this issue of capacity inversion
> on big.mid.little is there. It was for ~2-3years and is going to be
> even bigger in future. So please don't block it and prepare/share the
> numbers for the corner case platforms.

I don't want to block anything but just want a solution that is
coherent with the whole design and not just a fix for one UC

>
> I have proposed the where we can meet in the middle, consider it.
> I will prepare a patch for that shifter.
