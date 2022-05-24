Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA7532305
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiEXGSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:18:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A21262B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:18:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p26so21713103eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PpnDGwCI+qFgSb2FdzAyruHDgA1CZqfmdK/y8b4f5E=;
        b=CqwzGkiSDp5GCNiN0vAZcKQZiZZTIvKyTOLj+ejrlwnAqOz59d0HpPWQiSPlNwuM1j
         8UCnF/UGjo23DSpL1RgCyR6RLWt5tsWXDs3EeFV9EHsOTH5+t7z+2r8CROej1U4AMmS0
         nBTWk8OxxodnovRFNczcKQsVtuKn1Sh4zcnBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PpnDGwCI+qFgSb2FdzAyruHDgA1CZqfmdK/y8b4f5E=;
        b=QIxYpPCQVZA6ngDkjr3c5VE4rsb29pj02SYw+OVkjYHbucb+QQMz2TYxCu+8n5ZCqD
         KXO896DkKaI0S+auXos+TSeEdDeocbpwG3mvf1exeCT3CggOtiHEdR9WrI9g1EBbQmIn
         I3d1GYSlBL77uZoVl3XM5kKkeiXvTpfOXpUjIz9N7/pDH04W5eSsa9QDrFBFYCJXH6Jr
         duQfTldpGz14d1+qddeQlzjaEWXE6iEfwE6HIZGzEwHxkzM3RouVXHvcU2FFfAGQgmPf
         iWWO5BSqYOIjyRyQhFYnXFLonPuykLlGNr/9tjVn2uGxs2Q4RYXHhf7SEYnfAJfyUuYz
         hG/Q==
X-Gm-Message-State: AOAM530AQF/NPdKXeeRMpM+hZptC8R30stUqpzGuF1w9nbPd/KcJlS8G
        ybYZTcisQzk3ftBjcEJnlMiBcepBmT7nP2PDNvZoIA==
X-Google-Smtp-Source: ABdhPJy6t3NTGd1TuSY36MW9CMpIFtOrHImOe/3vdmmzlUYH2BZALWIyj8eGCQdt242SJBiKtCd8LhnXoa9/jTEIIFM=
X-Received: by 2002:a05:6402:d51:b0:42a:b2cc:33b2 with SMTP id
 ec17-20020a0564020d5100b0042ab2cc33b2mr27362269edb.248.1653373080312; Mon, 23
 May 2022 23:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220516004311.18358-1-roger.lu@mediatek.com> <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
 <7h4k1ndaui.fsf@baylibre.com> <7hy1yzbtb7.fsf@baylibre.com>
 <CAGXv+5GT=3m=pVPwUOWR42BR=emCpBXvvoAiRV7YKt2kEKWdAQ@mail.gmail.com>
 <CGME20220519182512epcas1p3020bd4713580c9244f759971b8bd2c3a@epcas1p3.samsung.com>
 <7hmtfdbcsc.fsf@baylibre.com> <5a1767dc-ba2d-4de5-d8fe-2f308d3318a9@samsung.com>
 <CAGXv+5EsgiXCpe-8H0cQ=qm_Nq+yfM_a4b1L=hOFP6mcwfZymw@mail.gmail.com> <eacf7a67-bc64-a764-e23d-c733a4666b8a@samsung.com>
In-Reply-To: <eacf7a67-bc64-a764-e23d-c733a4666b8a@samsung.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 May 2022 14:17:49 +0800
Message-ID: <CAGXv+5HEG1VJ89LDHJmMvPqafcdb2cuJj2wxv44ozPxDeHj8ig@mail.gmail.com>
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 5:53 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Kevin,
>
> On 5/20/22 11:42 AM, Chen-Yu Tsai wrote:
> > On Fri, May 20, 2022 at 9:28 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> >>
> >> Hi Kevin, Chen-Yu,
> >>
> >> On 5/20/22 3:25 AM, Kevin Hilman wrote:
> >>> Chen-Yu Tsai <wenst@chromium.org> writes:
> >>>
> >>>> n Wed, May 18, 2022 at 8:03 AM Kevin Hilman <khilman@kernel.org> wrote:
> >>>>>
> >>>>> Kevin Hilman <khilman@kernel.org> writes:
> >>>>>
> >>>>>> Chen-Yu Tsai <wenst@chromium.org> writes:
> >>>>>>
> >>>>>>> On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
> >>>>>>>>
> >>>>>>>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> >>>>>>>> which calculates suitable SVS bank voltages to OPP voltage table.
> >>>>>>>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> >>>>>>>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> >>>>>>>>
> >>>>>>>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> >>>>>>>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
> >>>>>>>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
> >>>>>>>>
> >>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
> >>>>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
> >>>>>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
> >>>>>>>>
> >>>>>>>> Change since v24:
> >>>>>>>> - Rebase to Linux 5.18-rc6
> >>>>>>>> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
> >>>>>>>> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
> >>>>>>>>
> >>>>>>>> Test in below environment:
> >>>>>>>> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
> >>>>>>>> HW: mt8183-Krane
> >>>>>>>>
> >>>>>>>> [4] https://protect2.fireeye.com/v1/url?k=847bae75-e5f0bb43-847a253a-000babff9b5d-0b6f42041b9dea1d&q=1&e=37a26c43-8564-4808-9701-dc76d1ebbb27&u=https%3A%2F%2Fgithub.com%2Fwens%2Flinux%2Fcommits%2Fmt8183-cpufreq-cci-svs-test
> >>>>>>>
> >>>>>>> I've updated my branch to include all the latest versions of the relevant
> >>>>>>> patch series:
> >>>>>>>
> >>>>>>> - anx7625 DPI bus type series v2 (so the display works)
> >>>>>>> - MT8183 thermal series v9 (this seems to have been overlooked by the
> >>>>>>> maintainer)
> >>>>>>> - MTK SVS driver series v25
> >>>>>>> - devfreq: cpu based scaling support to passive governor series v5
> >>>>>>> - MTK CCI devfreq series v4
> >>>>>>> - MT8183 cpufreq series v7
> >>>>>>> - Additional WIP patches for panfrost MTK devfreq
> >>>>>>
> >>>>>> Thanks for preparing an integration branch Chen-Yu.
> >>>>>>
> >>>>>> I'm testing this on mt8183-pumpkin with one patch to add the CCI
> >>>>>> regulator[1], and the defconfig you posted in a previous rev of this
> >>>>>> series, but the CCI driver still causes a fault on boot[2] on my
> >>>>>> platform.
> >>>>>>
> >>>>>> I mentioned in earlier reviews that I think there's potentially a race
> >>>>>> between CCI and SVS loading since they are co-dependent.  My hunch is
> >>>>>> that this is still not being handled properly.
> >>>>>
> >>>>> Ah, actually it's crashing when I try to boot the platform with
> >>>>> `maxcpus=4` on the cmdline (which I have to do because mt8183-pumpkin is
> >>>>> unstable upstream with the 2nd cluster enabled.)
> >>
> >> This warning message is printed by 'WARN_ON(cpufreq_passive_unregister_notifier(devfreq))'
> >> on devfreq passive governor.
> >>
> >> If the cpufreq drivers are not probed before of probing cci devfreq driver
> >> with passive governor, passive governor shows this warning message.
> >> Because passive governor with CPUFREQ_PARENT_DEV depends on the cpufreq driver
> >> in order to get 'struct cpufreq_policy'[2].
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n339
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/tree/drivers/devfreq/governor_passive.c?h=devfreq-testing#n282
> >>
> >> But, as I knew, this message might not stop the kernel. Just show the warning
> >> message and then return -EPROBE_DEFER error. It means that maybe try to
> >> probe the cci devfreq driver on late time of kernel booting
> >> and then will be working. But, I need the full kernel booting log
> >> and the booting sequence of between cpufreq and cci devfreq driver.
> >
> > Maybe just use a standard dev_warn() instead? WARN_ON causes all sorts
> > of panicking in developers' minds. :p
> >
> >> In order to fix your issue, could you share the full booting log?
> >> And if possible, please explain the more detailed something about this.
> >
> > The shortened version is that on an 8 core system, with maxcpus=4,
> > only the first four cores are booted and have cpufreq associated.
> > I've not actually used this mechanism, so I don't really know what
> > happens if the other cores are brought up later with hotplug. Is
> > cpufreq expected to attach to them?
> >
> > Maybe Kevin can add some more details.
> >
> >
> > ChenYu
> >
> >
> >>>>>
> >>>>> The CCI driver should be a bit more robust about detecting
> >>>>> available/online CPUs
> >>>>
> >>>> This all seems to be handled in the devfreq passive governor.
> >>>
> >>> Well, that's the initial crash.  But the SVS driver will also go through
> >>> its svs_mt8183_banks[] array (including both big & little clusters) and
> >>> try to init SVS, so presumably that will have some problems also if only
> >>> one cluster is enabled.
> >>>
> >>>> And presumably we'd like to have CCI devfreq running even if just one
> >>>> core was booted.
> >>>
> >>> Yes, I assume so also.
> >>>
> >>>> Added Chanwoo for more ideas.
> >>>
> >>> OK, thanks.
> >>>
> >>> Kevin
>
>
> I tested the passive governor with my temporary test code
> on odroid-xu3 which contains the big.LITTLE cluster (Octa-core).
>
>
> [Sequence of cpufreq/devfreq driver]
> 1. Turn on all cpus
> 2. Probed cpufreq driver
> 3. Probed devfreq driver using passive governor with CPUFREQ_PARENT_DEV
>
> In my test case, there are no warning message during kernel booting.
> Also when scaling the cpu frequency of cpus of big.LITTLE clusters,
> temporary devfreq driver receives the notfication and then
> calculate the target frequency of devfreq device by iterating online cpu.
>
> If there are any h/w constraints on your case, please let me know.

Could you run your system with maxcpus=4 added to your cmdline?
This is what Kevin was running.

The current result is that the latter four cores aren't booted, so no
cpufreq tied to them, and the passive governor will fail to get their
cpufreq_policy. As mentioned before, the code path used to have a
WARN_ON(). Now it's a dev_warn(). It will still fail initialization
though.

We're wondering if devfreq passive governor should be made to work
even if not all cpu cores are available when it probes.


Regards
ChenYu
