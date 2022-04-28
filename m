Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B800513BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351157AbiD1SkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1SkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A607396B8;
        Thu, 28 Apr 2022 11:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D69BB82EA7;
        Thu, 28 Apr 2022 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C2C385AA;
        Thu, 28 Apr 2022 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651171020;
        bh=IvxhraVnLcRPvvRShMco0qGmtv4y60bavIAwP7cfn8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7EZnhorLbduQ+O7KeA4nt0ENWkQmVd2tqYTR2mmCDMhwYlucIjbZUb1qzPN1SDDX
         9bE0bmG2WeskkTl4TUGofKGqXx8KpXCMV+loie7hGUNeHYoKUP7/OLmMq8R+qbTmdN
         eajwnlHYGvMIMC5EE7UiuR/UIw1a365QelrBSWIxj4U3Mn3jBHLN7Uwg4VS8BxPLjN
         +GUL9GDTszvH+8OhA8TmlLZ0XgIBW88emiLjiQQSEuKmTw4BjLMFooB5sr7XXvSTvz
         9j8ylfQyBvhStHCmvjS4UqHz1Y2wcafb4kIlMhAE5cuESAK1C0ocPiOsSNE2KKOs06
         0EmCr5cs3HUhg==
Date:   Thu, 28 Apr 2022 19:45:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20220428194511.519ddba0@jic23-huawei>
In-Reply-To: <CAN8YU5OB5A0m3gQ0J-PTiEdcSTY_KXONK4V6sjmFEyyK0bmVmw@mail.gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
        <20220415130005.85879-9-andrea.merello@gmail.com>
        <20220415184305.03805452@jic23-huawei>
        <CAN8YU5Mz--8R2oE=bgok_JdM6NNW8m2h5_V8LZSocFnaa-PADA@mail.gmail.com>
        <20220424184521.3f5a9d18@jic23-huawei>
        <CAN8YU5OB5A0m3gQ0J-PTiEdcSTY_KXONK4V6sjmFEyyK0bmVmw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 11:28:53 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno dom 24 apr 2022 alle ore 19:37 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Tue, 19 Apr 2022 09:10:54 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > Il giorno ven 15 apr 2022 alle ore 19:35 Jonathan Cameron
> > > <jic23@kernel.org> ha scritto:  
> > > >
> > > > On Fri, 15 Apr 2022 14:59:59 +0200
> > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > >  
> > > > > From: Andrea Merello <andrea.merello@iit.it>
> > > > >
> > > > > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > > > > can be connected via both serial and I2C busses; separate patches will
> > > > > add support for them.
> > > > >
> > > > > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > > > > that provides raw data from the said internal sensors, and a couple of
> > > > > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > > > > euler angles, quaternions, linear acceleration and gravity measurements).
> > > > >
> > > > > In fusion modes the AMG data is still available (with some calibration
> > > > > refinements done by the IMU), but certain settings such as low pass
> > > > > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > > > > they can be customized; this is why AMG mode can still be interesting.
> > > > >
> > > > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>  
> 
> [...]
> 
> > > >  
> > > > > +
> > > > > +     ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     if (val != BNO055_CHIP_ID_MAGIC) {  
> > > >
> > > > We've run into this a few times recently.  Traditionally IIO has been very
> > > > restrictive on allowing drivers to probe if the Who Am I type values
> > > > don't match.  That causes problems for backwards compatibility in
> > > > device tree - e.g. (with made up compatible part number 055b :)
> > > > compatible = "bosch,bno055b", "bosch,bno055"
> > > >
> > > > The viewpoint of the dt maintainers is that we should assume the
> > > > dt is correct and at most warn about missmatched IDs before trying
> > > > to carry on.  So to avoid hitting that again please relax this to a
> > > > warning and cross your fingers after this point if it doesn't match.
> > > > I'm fine on the firmware question because we know we are dealing
> > > > with buggy firmware.  Ideally we'll get some working firmware
> > > > additions at somepoint then we can just label the bad firmwares
> > > > and assume one less bug in the ones that don't match :)  
> > >
> > > To be honest my point wasn't about the correctness of the DT at all..
> > >
> > > I've hit this several times when I was switching my test board from
> > > serial to i2c and vice-versa, because I made wrong connections or I
> > > forgot to switch FPGA image (which contains the serial IP here). I got
> > > my test script failing because the IIO device didn't pop up at all,
> > > which is better than getting e.g. random data. In the real world
> > > people may have less chance to have to worry about this, but they may
> > > when e.g. they have an RPi and a hand-wired IMU.
> > >
> > > .. IOW I'm seeing this as a hardware self-test rather than a SW
> > > check.. But if the DT thing makes this a no-go, then I can live with
> > > the warning, and e.g. by making my script to check the kernel log..  
> >
> > Hmm. I  wonder if we can get the best of both worlds.  Given there
> > is a WHOAMI and these very rarely / never take the value of all 0's or all 1's
> > (what you'd see with a wiring error) maybe we can sanity check against
> > those to provide the hardware self-test element.  Then accept any
> > 'sane' value of WHOAMI, but with a warning?  
> 
> While trying to do this and testing it, I've realized that indeed when
> the BUS is broken (e.g. incorrect wiring) the probe() fails even
> earlier. When we are unable to communicate with the device, this is
> caught by the lower layer protocols (e.g. I2C sees no ACK, I suppose),
> so there is no need to fail here; the IIO device doesn't eventually
> pop up anyway.

Ah. Good point.  I was thinking we had SPI which is the one where a lack
of reply is harder to detect.  For I2C we are definitely fine and
I guess the serial protocol protects against this as well.

Great that indeed makes things simpler.

Jonathan


> 
> So, I now revert my previous request to keep a check to bail out for
> crazy IDs here :) ; I'd say we can just relax the check to just a
> warning as you said before, without the need for checking for 0x00 and
> 0xff..
> 
> > Jonathan
> >
> >  

