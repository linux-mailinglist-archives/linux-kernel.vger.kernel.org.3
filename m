Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25F757EA48
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 01:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiGVXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiGVXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 19:36:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE78C5B3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 16:36:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l23so11053408ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFcz4tDacWhTd6kvrtBPoWWnqzr4MBqjFZiHtLfkUJ8=;
        b=bzn91xuSqNlcsX4wD4ZTubf89z9zYzkyeXLgGbEEflgOQp+L4AkOLYtG8ZCTOKmOVD
         GAmJNTQKEJHoSuGGNFMwJqXLIqbR6nMNj7K4fBXabKZIG5Jt4y6xVPHRoQNFUblC/tCR
         BFxrI7Bhl7T0Onn9iLzTll2jxDW/08AvikZ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFcz4tDacWhTd6kvrtBPoWWnqzr4MBqjFZiHtLfkUJ8=;
        b=NX+ufdwW7xmeOm6EadJR7oBM+wmJ3izEC8y1unHMQSFl4whoQlJ2MNEnJSa4ejMHl5
         EK1KssCfPETixWxSoQj6gqsXPMpf7cVIB3TqxvcWq56zacVRHkamINPCEyRXr4b2IgFw
         fgi+PGkcgOWrjF5E4X3ZTbhT2MD05OTx48F3brIIsAQ2csJK7p9e0IC5JQjeQSFUH8F4
         jA50y8h3gM26W0+rGf0VJ1wRJXYusQCfYr9Xeqqn6Hw1VVjt+/tNCAMkFllQRrwJ/6Vt
         Prkh8JOaQ7Tgrl56I1H5XqQQ6m4UCbRa+AX2WvLA5Ku1VTmKt3TlUygnrkAF3cE8kczI
         BGzA==
X-Gm-Message-State: AJIora/yVVSV7bngy8cPA2yfyPMzeV+roAOMgjsuRIIwBE2l0ROfqT1E
        muqNjU3o9uTGCh6B57MrmvBxXgQ86wO9IGwr
X-Google-Smtp-Source: AGRyM1sOTdlX6IerswpKxc2n2ReF8Wy5SEODdfB/YJBRJhXxgzdv9iE+z1luGOcU8YT6RzTZzfDQmg==
X-Received: by 2002:a17:907:2e01:b0:72b:764f:ea1a with SMTP id ig1-20020a1709072e0100b0072b764fea1amr1702871ejc.666.1658532964048;
        Fri, 22 Jul 2022 16:36:04 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709060e0c00b00706242d297fsm2451353eji.212.2022.07.22.16.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 16:36:01 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so6023111wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 16:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3a3:3f7f:27ec with SMTP id
 o20-20020a05600c511400b003a33f7f27ecmr1190742wms.93.1658532960761; Fri, 22
 Jul 2022 16:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
 <Ytrq2rVMHqedv4+3@sirena.org.uk>
In-Reply-To: <Ytrq2rVMHqedv4+3@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 16:35:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
Message-ID: <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 11:22 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 06:26:44PM -0700, Douglas Anderson wrote:
>
> > Looking through the current users of regulator_set_load(), all but one
> > or two basically follow the pattern:
>
> > 1. Get all the regulators.
> > 2. Go through each regulator and call regulator_set_load() on it with
> >    some value that's sufficient to get the regulator to run in "HPM"
> >    mode.
> > 3. Enable / disable the regulator as needed.
>
> Sure...  I guess these devices are just hoping that their idle currents
> are near enough to zero to be safe.  Having refreshed my mind about how
> all this works that's basically the assumption that Linux is making
> here, that any idle currents will be low enough to be satisified by the
> lowest power state of any practical regulator and we don't need to keep
> track of them.
>
> > Specifically it should be noted that many devices don't really have a
> > need for the low power mode of regulators. Unfortunately the current
>
> What exactly do you mean by "a need for the low power mode of
> regulators"?

Let me try to come up with some examples. I'll assume a regulator that
can go up to 10mA in LPM (low power mode) and 100mA in HPM (high power
mode). Software needs to switch between LPM and HPM manually. I don't
have great numbers, but I'll assume that the LDO is 90% power
efficient in LPM and 40% power efficient in HPM.


Example 1: Trackpad that powers up on its own when it detects activity

Let's imagine a driver for a trackpad that talks over i2c. We power up
the trackpad's main supplies and the trackpad's firmware boots up. The
trackpad goes idle and starts drawing only a little power (1 mA?) When
someone gets near the trackpad (triggering the capacitive detectors)
then the firmware on the trackpad will kick into action and start
drawing a bunch of power (20mA?) to analyze the signals. If the
trackpad decides it got a real touch then it will send an interrupt to
the SoC.

This trackpad _cannot_ use software managed LPM/HPM because it doesn't
tell the main apps processor (AP) before it starts drawing more power
and the AP is in charge of selecting HPM/LPM. If we want to use this
trackpad with this regulator we just need to force it to HPM.

In my above terminology, this driver doesn't "need" the low power mode
of the regulators since it can't take advantage of it.


Example 2: Trackpad that warns the AP before it draws power

Let's imagine changing the firmware on the trackpad in the first
example. Now if the trackpad detects activity and wants to power up it
sends an interrupt to the AP. When the AP says "OK" it starts its high
power work. The AP can keep the trackpad in LPM most of the time and
switch to HPM only when there's activity. This saves power, but was it
a good design? It really depends. If this happens very very
infrequently then it might save power. If my math is right:

Idle trackpad in HPM (1mA @ 40% efficiency): 1 / .4 = 2.5mA
Idle trackpad in LPM (1mA @ 90% efficiency): 1 / .9 1.1mA

So we save 1.4mA of idle power but at the cost of complexity and
response time for the trackpad. We also may need to spin up the CPU
more often which could blow through our power savings.

The answer here is much less clear cut. Maybe this is totally not
worth it, but for a device that's very idle, that 1.4 mA might be
worth it. If the idle power was 8mA (8 / .4 = 20mA) it could really be
worth it.


Example 3: A SPI controller

Let's imagine a SPI controller that takes 5 mA when actively
transfering data and .1mA when idle (register retention). We have
several controllers powered by the same rail that may or may not be
transferring at the same time, so we might end up needing HPM. The
controller never powers up on its own--only when we tell it to
transfer.

We could design our driver in two ways:

3a) Turn on the regulators at driver probe time and init our
registers. Turn them off at system suspend and on at system resume
(and restore our registers). When actively doing a transfer we request
our 5mA load and when we're doing with our transfer we request our
.1mA load.

3b) Right before an active transfer, turn on our regulator and program
all registers (there aren't that many since SPI is a fairly simple
protocol). After the transfer is done, turn the regulator off.

Both 3a) and 3b) work. If reprogramming the registers was a chore or
slow we might choose 3a). If we choose 3b), the driver doesn't really
need to be HPM/LPM aware. Something needs to specify its load once but
it doesn't need to actively manage the load, which I guess is what I
meant by a driver not "needing" the low power mode of the regulator. I
meant that the driver doesn't need the API to actively manage its
load.


> > state of the world means that all drivers are cluttered with tables of
> > loads and extra cruft at init time to tell the regulator framework
> > about said loads.
>
> We're only talking about a few lines of code here, and we could make a
> bulk helper to set loads if this is a serious issue.  You could even
> just add some more values in the bulk struct and have it be pure data
> for the drivers, regulator_bulk_get() could see a load and set it.  I
> think this may actually be the bulk of what's concerning you here?

Extending the bulk API would definitely be a good thing to do if we
reject my proposal. It would be easy to eliminate a lot of code across
a lot of drivers this way.

I guess the thing I don't love, though, is that to get to Dmitry's
dream of all regulators having their load specified the we have to add
regulator_set_load() calls to all sorts of drivers across the system.
Right now, at least in mainline, the regulator_set_load() calls are
almost entirely relegated to Qualcomm-related drivers and for
peripherals which are on the SoC itself.

Let's go back to the trackpad example, maybe looking specifically at
"hid-over-i2c". The driver here is fairly hardware agnostic and the
current used may not be very easy for the i2c-hid driver to specify in
code. I suppose one answer here is: use board constraints to force
this regulator to always use HPM (high power mode). That's fine, but
then if we have a way to turn this device "off" and it's on a shared
rail? Maybe then we'd want to be able to put the regulator in LPM
mode?

I guess this is really the place where being able to specify loads in
the device tree really seems like the right fit. We've got generic
(non-Qualcomm) components that perhaps are probable and handled by a
generic driver, but they're powered by these regulators where software
needs to change between HPM and LPM. It feels clean to specify the
load of the i2c-hid trackpad in a given board's device tree.


> > There are lots of ways we could combine this "base load" with a load
> > that the driver requests. We could:
> > - Add them.
> > - Take the maximum (assume that the "base" is the min).
> > - Only use the "base" load if the driver didn't request one.
>
> This feels a bit mangled, I think largely because you're using the term
> "base load" to refer to something which I *think* you want to be the
> peak load the device might cause when it's actively doing stuff which is
> just very confusing.  If this were being specified per device I'd expect
> that to be the idle rather than active current with a name like that.
> That's just naming, but it does suggest that if we were to put this in
> DT it should be more like the pinctrl equivalents and done as an array
> of currents with matching array of names.

Sorry for the bad naming. Originally I was thinking that the dts would
specify the minimum current but as I thought about it more it felt
like it made more sense to specify the current that should be used for
a dumb driver (one that doesn't know anything about loads).

Doing an array would make sense. Like:

vdda-phy-load-names = "default", "off", "..."
vdda-phy-loads = <21800>, <500>, <...>;

Where "default" would be the load by default when enabled, "off" when
disabled off (if it's a shared rail it could conceivably draw power
even after regulator_disable()). Others states could be selected
manually.

If we did something like that, we'd have to figure out how those
meshed with existing driver calls. Happy for any thoughts.


> > I have chosen the third option here. If the driver knows better then
> > it can override. Note that the driver can't override to "0". To do
> > that it would just disable the regulator.
>
> I don't like the idea of having platform constraints which we ignore,
> this goes against the general safety principal of the regulator API
> which is that we won't touch the device state unless given explicit
> permission to do so by the platform description.  The general idea is
> to ensure that we can't do anything that might damage the platform
> without approval from the system integrator.
>
> > NOTE: if we want to keep old binary dtb files working with new kernels
> > then we'd still have to keep existing crufty regulator_set_load() in
> > drivers, but hopefully we can stop adding new instances of this, and
> > perhaps eventually people will agree to deprecate old binary dtb files
> > and we can get rid of all the extra code.
>
> To be perfectly honest I'm not sure I see any great advantage here.
> It's moving the performance numbers from the driver into DT which makes
> them ABI which makes them harder to update, and the peak load is going
> to be vulnerable to changes due to driver changes - if we do some
> performance work and manage to start driving a device harder the numbers
> specified in the DT may become wrong.  In general it seems safer to not
> put things into ABI if we don't have to, and a substantial proportion of
> things that might use regulators are off-SoC devices which don't
> generally want or need DT fragments to describe them so we end up having
> to duplicate things in multiple DTs which isn't ideal.

Yeah, I know. Putting things in dts certainly has its downsides. The
argument you make can be taken to the extreme, of course. We can take
everything out of dts files and just specify a top-level board
compatible and everything else could be a table in source code (or,
here's an idea with extra flexibility, a board.c file). Now you never
worry about breaking ABI at all. ;-)

All snarkiness aside, though, I'm just trying to point out that
there's no definitive line to cross. No black and white. Anything we
put in dts from "assigned-clock-rates" to voltage ranges to whatever
could need to be updated as we discover more data. It is why I've also
said that for modern SoCs, I'll believe it's safe to ship device trees
separate from the kernel when I see someone add the "device tree fixup
stage" to the kernel boot flow.


> What's big push to put this in DT rather than just make the code pattern
> easier to use?  I'm not totally against it but I'm having a hard time
> getting enthusiastic about it.

It's nothing make or break and mostly it's just been kicking around in
the back of my head for the last few years. Mostly I gave a shot at
implementing something in response to your comment [1] where you said:
"You could add a way to specify constant base loads in DT on either a
per regulator or per consumer basis." ;-)

[1] https://lore.kernel.org/r/Ytk2dxEC2n/ffNpD@sirena.org.uk


> I think the underlying thing here (and the reason you're seeing this a
> lot with Qualcomm device specifically) is that Qualcomm have a firmware
> interface to specify loads and wanted to implement selection of a low
> power mode when things are idle in the way that Linux does with the
> get_optimum_mode() interface.  Either they actually have some systems
> where they were able to select different modes when things are running
> or they don't have the thing we have where they discount loads from
> consumers that have removed their enable vote, either way for those
> platforms what's going on currently does seem like a sensible way of
> setting things up.

I guess I'm a tad less charitable than you are. From what I've seen of
Qualcomm, there seems to be an in-house checklist that they have to go
through before landing code. Drivers have to pass the checklist. I
think it contains things like:

* All memory reads and writes must be the "relaxed" variant unless you
can strongly justify the non-relaxed one. It doesn't matter if it's in
performance critical code. The relaxed version is better, even if it
is more likely to cause bugs.

* Thou shalt always set a pin's drive strength to exactly 2 if it
doesn't have a reason to be otherwise. It doesn't matter if the pin is
an input and the drive strength has no effect. Someone said that 2 is
safest so always set it to 2.

* All regulators should be configured to be able to run in high power
mode and low power mode. You should always configure a load on them.
It doesn't matter if you never use low power mode in practice.


> Other platforms don't bother, I think that's likely to be some
> combination of not caring about anything finer grained than system
> suspend (which especially for Android is totally fair) and modern
> regulators being much more able to to dynamically adapt to load than
> those the code was written for.

Yeah. I think this comes up more in practice with Qualcomm because
they do their own PMICs and every one of their LDOs has this setting
for LPM / HPM. Since the setting is there I guess they decided they
should write software to use it. I agree that it can save some power
when used well, but I personally don't think the complexity is
justified except in a small number of cases.

I would hazard a guess that perhaps Qualcomm's LDOs all have this
feature because it's probably super critical for LTE modems and they
might as well add the feature for all the LDOs if they're adding it
for some of them.

-Doug
