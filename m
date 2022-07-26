Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF55808BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiGZAb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:31:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23C20BCF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:31:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so23498170ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+Fe1jNL0Up1elTO9eo4OglKDhzz3Q/EuOCnPEmviNM=;
        b=CCG+3SZFjDRiLIJaBu+Ukuz/Fn/GoeLFavL1YPzQUj7PrONy8kzDJplHBKEi+eL43L
         Ph2a0QzwikY6w8oY1aaIwOlnZMROr+1Mcd2tDmjlvzSVQsHzjmZJkRVzxK9rwyurLuJU
         50KzI4IUG5z9yawtUTFnOmnFgdHtXNIMOTV/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+Fe1jNL0Up1elTO9eo4OglKDhzz3Q/EuOCnPEmviNM=;
        b=iI7KfNH0wAZ9GinPI/0ZnjYP91GQ74Y+ltN37Ay//uQ2NwW563naYUWoFa4s1OpElY
         n58J+NZ7JNk7JDsMQgoHJziFig2uGv2iEHnY9ATcmOgp2h8it3ud6KCfMffV3razU1tM
         SncJCWRRBruIzfl0V2Aux1WQ+4JcHadjvMyWp4jxs+tjCR3HWqCU/W6XY1i1A8PiOCMJ
         B9VAZownPLAtTkND6CzE8xA1pra7mk076aJhuXXwD8tGFiCjtcH4Q3y7YwTxgF2q4u33
         +I71lrZy7wnknyrCEWpsG01jGOWrSabf7zpbBlsK2kwOCo8VB/nkZCO9ASWu1mfwCnAw
         oZUA==
X-Gm-Message-State: AJIora9bF1/1xXamCHy9RWp9HAkUdsganCNJbdzO4ojAgi/N4+967AV5
        7prL7b5NQHM0/hcbFcycrk2IP9fQ0XBj3BFP
X-Google-Smtp-Source: AGRyM1s9uWG8EaeYtLrFJ1z3CW4yEHGXC/Tffw5GSLP/YgWuD/V/qlNO7oPz+evq7dhhGt3Pp24pVg==
X-Received: by 2002:a17:907:7f9f:b0:72f:11fc:86bc with SMTP id qk31-20020a1709077f9f00b0072f11fc86bcmr11871347ejc.770.1658795512304;
        Mon, 25 Jul 2022 17:31:52 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906318500b0072b2ffc662esm5733449ejy.156.2022.07.25.17.31.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 17:31:48 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h8so18087939wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:31:47 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr8745119wrf.659.1658795507332; Mon, 25
 Jul 2022 17:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
 <Ytrq2rVMHqedv4+3@sirena.org.uk> <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
 <YtxHwUe4W7+u3Lk3@sirena.org.uk>
In-Reply-To: <YtxHwUe4W7+u3Lk3@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Jul 2022 17:31:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VhPHFB1T_+r1mmtP=r73ggmcWvwPqw3E-_foVTvtTkyw@mail.gmail.com>
Message-ID: <CAD=FV=VhPHFB1T_+r1mmtP=r73ggmcWvwPqw3E-_foVTvtTkyw@mail.gmail.com>
Subject: Re: [RFC PATCH] regulator: core: Allow for a base-load per client to
 come from dts
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 23, 2022 at 12:11 PM Mark Brown <broonie@kernel.org> wrote:
>
> I'm familiar with the broad concept of regulators having the
> ability to operate in more efficient (but typically lower
> quality) modes, we do have the whole infrastructure for selecting
> mode based on load after all.  I'm not sure what you mean by
> devices having a *need* for it though?

All I meant by *need* was just whether it was practical for a device
to actively take advantage of the low power mode. A driver that
"needs" to know about loads is one that purposely puts the device into
a low power state so that it can re-configure the regulator. I was
arguing that most drivers don't need to do this.


> Does this need actually exist or is this just a we built it so we
> must use it thing?  There's a lot of power microoptimisation that
> goes on and sometimes it's hard to tell how much power is saved
> relative to the power consumed managing the feature.

It has always felt like a microoptimizatoin to me. I would love to see
evidence to the contrary, though.

Specifically we don't seem to use low power mode (LPM) anywhere on the
sc7180 trogdor laptops today. Maybe it would be possible to use it in
some cases, but nobody ever did the analysis. I haven't spent much
time analyzing downstream Qualcomm solutions, though.

I guess the answer is that if it's a micro-optimization then we should
be ripping more of this code out. ;-) That would go contrary to
Dmitry's request that all regulators have a load set on them...


> To the extent this is needed it does smell a bit like "these
> regulators should default to setting their load to 0 when
> disabled" or something more along those lines TBH, some of your
> previous comments suggested that the per device loads being
> specified in a lot of the driver are just random values intended
> to trigger a specific behaviour in the regulator but forced to be
> done in terms of a load due to the firmware inteface that's
> available on these platforms having an interface in those terms.

It's actually _not_ the firmware interface as far as I can tell, at
least for newer Qualcomm chips (those using RPMH). The firmware
interface seems to be for modes. See, for instance,
rpmh_regulator_vrm_set_load() which translates loads into modes before
passing to the firmware. Ironically, my memory tells me that Qualcomm
actually said that this turned out to be a problem in the past for
them, though, since some rails went to both the main apps processor
(AP) and the modem processor. Each could independently decide that low
power mode was fine but the total of both usages could bump you into
needing high power mode...

As far as whether the numbers are random values or mean something: I
don't know that. I'd personally have a bit of a hard time trusting
them, though. Mostly ending up at LPM when you need HPM seems like it
could be really hard to debug.

One point of evidence of these numbers being pointless and just noise
is code that seems to have made its way upstream to set a "disable
load". This hasn't done anything since 2018 when we landed commit
5451781dadf8 ("regulator: core: Only count load for enabled
consumers") but is still instructive of Qualcomm's thinking. Taking a
sampling of the loads in the tables in the DSI driver / phy, I see:
* Many specify 100 uA.
* Some seem to pick based on throwing a dart at a dartboard. 16 uA, 2
uA, 4 uA, 32 uA, etc.

I can't imagine any of these numbers having done anything useful even
prior to the 2018 commit. From `qcom-rpmh-regulator.c` the changeover
from LPM to HPM is at 10000 uA or 30000 uA, so even a load of 100 uA
is really just a rounding error. Yet despite their uselessness,
Engineers at Qualcomm have dutifully filled in all these numbers...

Looking at the loads passed to "active" devices, I see almost nothing
at all specifying a load that's less than 10mA. That means it's gonna
be really hard to use any of that class of regulators in LPM.

If we happen to be using an LDO that changes over at 30 mA, though,
these ones _could_ use LDO. I guess this is where the whole
"specifying in uA" makes sense? If you've got a regulator that changes
at 30mA and only one ~20mA consumer is active then it can stay in LPM.
When two ~20mA consumers are active then it needs to switch to HPM?
Having lots of consumers on a given rail is really common w/ Qulaocmm
setups. On trogdor, rail "L4A" is all of these:

vdd_qlink_lv:
vdd_qlink_lv_ck:
vdd_qusb_hs0_core:
vdd_ufs1_core:
vdda_mipi_csi0_0p9:
vdda_mipi_csi1_0p9:
vdda_mipi_csi2_0p9:
vdda_mipi_csi3_0p9:
vdda_mipi_dsi0_pll:
vdda_pll_cc_ebi01:
vdda_qrefs_0p9:
vdda_usb_ss_dp_core:

...and that's a regulator that can go up to 30mA in LDO mode... Of
course "MIPI DSI", by complete chance I'm sure, says its load is
_just_ over the 30 mA threshold...


> It didn't sound like they were actual specified/measured physical
> values for the on-SoC stuff, some of the panel drivers do look
> like they have plausuble numbers from datasheets though.

I just don't know. :(


> It might even make sense to have the regulator drivers implement
> the mode interface, that's possibly more useful to work with here
> even if it's not what the interfaces say, it does feel like
> practicaly how people are working with this stuff.  There's
> obviously issues there if anyone *does* work usefully with loads
> and how that integrates, though I think in this day and age the
> need for active management outside of super idle states is
> typically minimal.  As a first pass you could just disable the
> DRMS stuff if mode setting permission is enabled, I suspect
> that'd work fine in these cases.  Or just model the modes as a
> vote for "add X to the load" if they're set.

The current RPMH driver _does_ implement the mode interface. ;-)


I guess the above doesn't really give us a lot of good answers. :(

I guess the problem is that, like a lot of Qualcomm stuff, I still
don't have a good big picture despite having been working on Qualcomm
SoCs for years now. I do know that code keeps showing up to set
regulator loads all over the tree and, I presume, most maintainers
just take the code without questioning the need to set the load at
all.

Perhaps the low hanging fruit is to just accept that the current API
of setting the load is here to stay, even if it does seem mostly
pointless in many cases. I can submit a patch that adds the load to
the "bulk" API and at least it would clean up a bunch of stuff even if
it doesn't fundamentally overhaul the system...


-Doug
