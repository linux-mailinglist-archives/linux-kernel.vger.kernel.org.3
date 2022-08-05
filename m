Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EE58AB25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiHEM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbiHEM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:56:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804C42A731
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:56:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x21so3301156edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=C+xtJFCKeOrxrre7b6wa6oFvhCH7Ew8BO4QEpFZOuQA=;
        b=foKoYMmsuoFqVs01Q7k7d9Wdsis1+rjLhJxhFHKLLlLWmm2QJ0JZ5WAO3ZBdbYu57H
         9UPJWHCvfMrpyVv1yPyXx7m2hpZ8UTSS1dKLjVp5OVT93hqPEEumtW1VtHIjwTXsfVqr
         SYsVS6/cDe4QT18Gn7ffyKON/iGnyOUoouzaG0a87lxk1BgrfntRl4cyT0vnCr76ZWfZ
         v8k/+Zgqx/kfU0E5RBIKchWh9xVqjAbDHwLxyjYncEaIEcHzkUdRwvzJPqmTyL4kDIlr
         zBGXJxkT1rV80WwntkG4bHT90rnf1iYdE8dv/3W1QSjCbPfAC2Vz0xQFn6Bzp3jzMB0H
         EVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C+xtJFCKeOrxrre7b6wa6oFvhCH7Ew8BO4QEpFZOuQA=;
        b=kPHCtizjdHD+xrva8RIh/TW+yg3hBNpflY5UVLOfQeTeceWWtUpTfC9Cz16t+wsj3+
         BMMDUOX6dvIm9BIp3BHPUERYqeEF5j6e+QlUNhd94ZVnbBEWS8Z94qrNpi2wWUBm/nb9
         VMfY3zzIjViqL3J7NpGZ9mvcxK6GJdArwdk8gtjh1Y3MbgJQpC/WWB7I3Mj930XmyKcu
         VYR33YgEsN+xl69OLCSerC8SxKUDYGXoJeBbOujdi7DIq4t/6Mxpeiz4Dw0VA21Nw1zc
         Pkik8KKyfW1MEtZTxfAaB9x6hYutI6r95az4gEx/ckLLtl5BntMerooPI5fi05m1RP0t
         8Mug==
X-Gm-Message-State: ACgBeo2CbjP0erlcDWB0juviTVi37PQOiCSukEz3e+E+cz/srJCdo4f6
        cLstPMlViFxJ5Ea3jv+LAF5jrtmkb0pY99QhVfI=
X-Google-Smtp-Source: AA6agR6wcsOTfmgKfrtOnlgLaY7A+ZrEi0SEwJhxSibXdxszDuKQ3WuF7n6GE9AqosulORJeX1gZKq+9IpgjqCvXgQg=
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id
 f40-20020a05640232a800b0043e5490295fmr6525907eda.193.1659704182519; Fri, 05
 Aug 2022 05:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJy6X5733m3zwcFMuWM9oGHJEmKrs2KUNhzMzNVggRx0g@mail.gmail.com>
 <20220802080820.jyf3tfpgcj3pvbtp@pengutronix.de> <CAHCN7xL-7wGnEhY9+zDXYjigZfnfsnY_NsRf+enYt_BPsFxgnQ@mail.gmail.com>
 <CAHCN7xLpCbOY+Ma6gKJievw6aUZ5-Qs4S=zxjTgRu=Be7zvhoQ@mail.gmail.com>
 <CAHCN7xKzYcCPL0ddTENGw6xdCMNdYw-m5u4NSBHb96Vb_tByGg@mail.gmail.com>
 <20220803062024.vn7awasmifkp5xow@pengutronix.de> <CAHCN7xL3maPyX8eUiT6mKYei==6pkEvVTwX3vY+1uLTSNDGQ3Q@mail.gmail.com>
 <CAPY8ntBBz56Es=pK+KpqhyYLUET95DT_zE6gorOWx4WkCSxJAg@mail.gmail.com>
 <20220804093829.42kdelp7u4r743nv@pengutronix.de> <CAPY8ntBovVq1HVt_UneDF8OB9KBdEBv52o=4BCTmf9VpiODxVg@mail.gmail.com>
 <20220804125152.idyzetjqkjzgbbm2@pengutronix.de> <CAPY8ntAatYvbf5ehfsj4qcSDC=sODeN1Cj0vDjn6p0M=k320NA@mail.gmail.com>
 <CAHCN7x+DkJgGvMLnYBXscSMDmTCeaHeJKK6T9eLUm+rXSx=NQA@mail.gmail.com>
 <OS0PR01MB592206843B43BC93F4F699FC869E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHCN7x+UAk1wPTOj7EFUXkRY3b3BPXTT6SqD4A7sJO87ZpHgFg@mail.gmail.com>
In-Reply-To: <CAHCN7x+UAk1wPTOj7EFUXkRY3b3BPXTT6SqD4A7sJO87ZpHgFg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 5 Aug 2022 07:56:11 -0500
Message-ID: <CAHCN7xJ4TWpLmD_WRrEXoHWy52MEfUL-_R5x=kF-1JC0_C8Q1Q@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        "robert.chiras@nxp.com" <robert.chiras@nxp.com>,
        "laurentiu.palcu@nxp.com" <laurentiu.palcu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 5:55 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Aug 5, 2022 at 3:44 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Adam and all,
> >
> > > Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
> > >
> > > On Thu, Aug 4, 2022 at 9:52 AM Dave Stevenson
> > > <dave.stevenson@raspberrypi.com> wrote:
> > > >
> > > > On Thu, 4 Aug 2022 at 13:51, Marco Felsch <m.felsch@pengutronix.de>
> > > wrote:
> > > > >
> > > > > Hi Dave,
> > > > >
> > > > > On 22-08-04, Dave Stevenson wrote:
> > > > > > Hi Marco
> > > > > >
> > > > > > On Thu, 4 Aug 2022 at 10:38, Marco Felsch
> > > <m.felsch@pengutronix.de> wrote:
> > > > > > >
> > > > > > > Hi Dave, Adam,
> > > > > > >
> > > > > > > On 22-08-03, Dave Stevenson wrote:
> > > > > > > > Hi Adam
> > > > > > > >
> > > > > > > > On Wed, 3 Aug 2022 at 12:03, Adam Ford <aford173@gmail.com>
> > > wrote:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > Did managed to get access to the ADV7535 programming
> > > > > > > > > > guide? This is the black box here. Let me check if I can
> > > > > > > > > > provide you a link with our repo so you can test our
> > > current DSIM state if you want.
> > > > > > > > >
> > > > > > > > > I do have access to the programming guide, but it's under
> > > > > > > > > NDA, but I'll try to answer questions if I can.
> > > > > > > >
> > > > > > > > Not meaning to butt in, but I have datasheets for ADV7533 and
> > > > > > > > 7535 from previously looking at these chips.
> > > > > > >
> > > > > > > Thanks for stepping into :)
> > > > > > >
> > > > > > > > Mine fairly plainly states:
> > > > > > > > "The DSI receiver input supports DSI video mode operation
> > > > > > > > only, and specifically, only supports nonburst mode with sync
> > > pulses".
> > > > > > >
> > > > > > > I've read this also, and we are working in nonburst mode with
> > > > > > > sync pulses. I have no access to an MIPI-DSI analyzer therefore
> > > > > > > I can't verify it.
> > > > > > >
> > > > > > > > Non-burst mode meaning that the DSI pixel rate MUST be the
> > > > > > > > same as the HDMI pixel rate.
> > > > > > >
> > > > > > > On DSI side you don't have a pixel-clock instead there is bit-
> > > clock.
> > > > > >
> > > > > > You have an effective pixel clock, with a fixed conversion for the
> > > > > > configuration.
> > > > > >
> > > > > > DSI bit-clock * number of lanes / bits_per_pixel = pixel rate.
> > > > > > 891Mbit/s * 4 lanes / 24bpp = 148.5 Mpixels/s
> > > > >
> > > > > Okay, I just checked the bandwidth which must equal.
> > > > >
> > > > > > As noted elsewhere, the DSI is DDR, so the clock lane itself is
> > > > > > only running at 891 / 2 = 445.5MHz.
> > > > > >
> > > > > > > > Section 6.1.1 "DSI Input Modes" of
> > > > > > > > adv7533_hardware_user_s_guide is even more explicit about the
> > > > > > > > requirement of DSI timing matching
> > > > > > >
> > > > > > > Is it possible to share the key points of the requirements?
> > > > > >
> > > > > > "Specifically the ADV7533 supports the Non-Burst Mode with syncs.
> > > > > > This mode requires real time data generation as a pulse packet
> > > > > > received becomes a pulse generated. Therefore this mode requires a
> > > > > > continuous stream of data with correct video timing to avoid any
> > > > > > visual artifacts."
> > > > > >
> > > > > > LP mode is supported on data lanes. Clock lane must remain in HS
> > > mode.
> > > > > >
> > > > > > "... the goal is to accurately convey DPI-type timing over DSI.
> > > > > > This includes matching DPI pixel-transmission rates, and widths of
> > > > > > timing events."
> > > > >
> > > > > Thanks for sharing.
> > > > >
> > > > > > > > The NXP kernel switching down to an hs_clk of 445.5MHz would
> > > > > > > > therefore be correct for 720p operation.
> > > > > > >
> > > > > > > It should be absolute no difference if you work on 891MHz with 2
> > > > > > > lanes or on 445.5 MHz with 4 lanes. What must be ensured is that
> > > > > > > you need the minimum required bandwidth which is roughly:
> > > > > > > 1280*720*24*60 = 1.327 GBps.
> > > > > >
> > > > > > Has someone changed the number of lanes in use? I'd missed that if
> > > > > > so, but I'll agree that 891MHz over 2 lanes should work for
> > > 720p60.
> > > > >
> > > > > The ADV driver is changing it autom. but this logic is somehow odd
> > > > > and there was already a approach to stop the driver doing this.
> > > >
> > > > I'd missed that bit in the driver where it appears to drop to 3 lanes
> > > > for pixel clock < 80000 via a mipi_dsi_detach and _attach. Quirky, but
> > > > probably the only way it can be achieved in the current framework.
> > > >
> > > > > To sync up: we have two problems:
> > > > >   1) The 720P mode with static DSI host configuration isn't working
> > > > >      without hacks.
> > > > >   2) The DSI link frequency should changed as soon as required
> > > > >      automatically. So we can provide all modes.
> > > > >
> > > > > I would concentrate on problem 1 first before moving on to the 2nd.
> > > >
> > > > If you change your link frequency, it may be worth trying a lower
> > > > resolution again such as 720x480 @ 60fps on 2 lanes. (720480@60 on 4
> > > > lanes is again listed as mandatory for using the timing generator).

Marco,

Looking through the DSIM driver that NXP uses, it appears that they
have a few special cases where they intentionally manipulate the DSIM
under certain conditions:

/* '1280x720@60Hz' mode with 2 data lanes
* requires special fine tuning for DPHY
* TIMING config according to the tests.
*/

There is also a separate one for the 4-lane mode:

/* workaround for CEA standard mode "1280x720@60" "1920x1080p24"
* display on 4 data lanes with Non-burst with sync
* pulse DSI mode, since use the standard horizontal
* timings cannot display correctly. And this code
* cannot be put into the dsim Bridge's mode_fixup,
* since the DSI device lane number change always
* happens after that.
*/

And lastly, they address issues with 3-lane mode:

/* TODO: DSIM 3 lanes has some display issue, so
* avoid 3 lanes enable, and force data lanes to
* be 2.
*/

Since the ADV is trying to adjust the lanes to 3 when running at 720p,
it could be part of the reason you need to jump to 2-lane mode.

> > > >
> > > > > > I have just noted that 720p59.94 at 24bpp on 4 lanes is listed as
> > > > > > one of the modes that is mandatory to use the timing generator
> > > > > > (reg 0x27 bit 7 = 1). On 2 lanes it is not required.
> > > > > > I don't know why it's referencing the 1000/1001 pixel clock rates
> > > > > > and not the base one, as it's only a base clock change with the
> > > > > > same timing (74.176MHz clock instead of 74.25MHz).
> > > > >
> > > > > Interesting! I would like to know how the HDMI block gets fetched by
> > > > > the DSI block and how the timing-generator can influence this in
> > > > > good/bad way. So that we know what DSI settings (freq, lanes) are
> > > sufficient.
> > > > >
> > > > > > > > If you do program the manual DSI divider register to allow a
> > > > > > > > DSI pixel rate of 148.5MHz vs HDMI pixel rate of 74.25MHz,
> > > > > > > > you'd be relying on
> > > > > > >
> > > > > > > There is no such DSI pixel rate to be precise, we only have a
> > > > > > > DSI bit clock/rate.
> > > > > > >
> > > > > > > > the ADV753x having at least a half-line FIFO between DSI rx
> > > > > > > > and HDMI tx to compensate for the differing data rates. I see
> > > > > > > > no reference to such, and I'd be surprised if it was more than
> > > > > > > > a half dozen pixels to compensate for the jitter in the cases
> > > > > > > > where the internal timing generator is mandatory due to
> > > fractional bytes.
> > > > > > >
> > > > > > > This is interesting and would proofs our assumption that the
> > > > > > > device don't have a FIFO :)
> > > > > > >
> > > > > > > Our assumptions (we don't have the datasheet/programming
> > > manual):
> > > > > > >   - HDMI part is fetching 3 bytes per HDMI pixclk
> > > > > > >   - Ratio between dsi-clk and hdmi-pixelclk must be 3 so the DSI
> > > and
> > > > > > >     HDMI are in sync. So from bandwidth pov there are no
> > > differences
> > > > > > >     between:
> > > > > > >       - HDMI: 74.25 MHz * 24 Bit  = 1782.0 MBit/s
> > > > > > >       - DSI:    891 MHz * 2 lanes = 1782.0 MBit/s (dsi-clock:
> > > 445.5 )
> > > > > > >       - DSI:  445.5 MHz * 4 lanes = 1782.0 MBit/s (dsi-clock:
> > > > > > > 222.75)
> > > > > > >
> > > > > > >     But the ratio is different and therefore the faster clocking
> > > option
> > > > > > >     let something 'overflow'.
> > > > > >
> > > > > > I'll agree that all looks consistent.
> > > > > >
> > > > > > > Anyway, but all this means that Adam should configure the
> > > > > > > burst-clock-rate to 445.5 and set the lanes to 4. But this
> > > > > > > doesn't work either and now we are back on my initial statement
> > > > > > > -> the driver needs some attention.
> > > > > >
> > > > > > Things always need attention :-)
> > > > >
> > > > > ^^
> > > > >
> > > > > > I suspect that it's the use of the timing generator that is the
> > > issue.
> > > > > > The programming guide does recommend using it for all modes, so
> > > > > > that would be a sensible first step.
> > > > >
> > > > > But I tested it without the timing-generator too. Can you or Adam
> > > > > verify the timing-generator diable logic?
> > > >
> > > > Sorry, running without the use of the timing generator is the issue.
> > > > It is mandatory in some modes, but supported in all modes. Always
> > > > using it should therefore avoid not using it in one of the mandatory
> > > > modes (the list looks a little arbitrary).
> > > >
> > > > > > I will say that we had a number of issues getting this chip to do
> > > > > > anything, and it generally seemed happier on 2 or 3 lanes instead
> > > > > > of 4. Suffice to say that we abandoned trying to use it, despite
> > > > > > some assistance from ADI.
> > > > >
> > > > > Even more interessting, what is your alternative to this chip?
> > > >
> > > > BCM2711 which supported dual HDMI natively.
> > > > Our investigation of ADV7535 was when trying to build what became
> > > > Pi400 using BCM2710/BCM2837 (only has a single HDMI output). Whilst I
> > > > do have the prototype, the ADV was wired up weirdly with I2C so I
> > > > never really got it running with Linux.
> > >
> > > I think I have convinced myself that the DSIM is working good enough to
> > > match that of the NXP.
> > >
> > > I've gone through and made a list of the register differences between a
> > > working display using NXP's kernel and the non-working display.  I've
> > > identified a small handful of registers on both the CEC bank of
> > > registers and main set of registers.
> > >
> > > I noticed that the working NXP version doesn't rescale the number of
> > > lanes based on the clock rate, and it stays fixed at 4 lanes.
> >
> > Does it mean theoretically rescale of lanes is not required??
>
> On the custom kernel from NXP, I can sync at 720p at 4-lanes.
> Unfortunately, I haven't yet been able to replicate all the register
> settings between my working version at 720p and my non-working
> version, and I still have yet to sync at 720p using the mainline
> adv7535 driver.  I am still wrokong on it.
>
> > At least 2 platforms can work with fixed 4 lanes@720p.

Based on what I'm seeing for this NXP platform, it almost seems like
the DSI transmitter should make the determination on whether or not to
scale the number of lanes instead of having the ADV7373 do it.  Since
their custom kernel is able to do 720p in 4-lane mode with this part,
it doesn't seem unreasonable to me.

> >
> > and looks like few platforms have display stability issue working with 4 lanes@720p,
> > so, as a workaround they changed to 3 lanes based on clock rate to make it work.
> >
> > Can you please confirm, is my understanding correct?
>
> That is my understanding.
>
> >
> > Note:
> >  On Renesas RZ/G2L platform, 720p with 3 lanes will work, but it needs
> >  different pll parameters to generate the dot clock to work.
>
> The NXP platform I am using also needs to regenerate the clock.  From
> what I can tell, it looks like the clock calculation on my board
> appears correct for both
> >
> > Cheers,
> > Biju
