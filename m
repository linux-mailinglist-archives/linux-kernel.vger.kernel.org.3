Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AD9576F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGPOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E48193E1;
        Sat, 16 Jul 2022 07:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57026114B;
        Sat, 16 Jul 2022 14:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D40C34114;
        Sat, 16 Jul 2022 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657982800;
        bh=4QvxNZ2FXer/MBSeMYgiz4DE9IC/aVS4+NEw/i4U0Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rQ+/yDpHD//TaP3shmZ7TDgyJPkg7FsWk6bTFHqWFhOJgdT2hRbYVbB4Snk03n+ye
         Mj11rhvoPsjsYwpoEAf0uy2WYHGFWMBsLJO4UXrwSqIqDKopN4DgW983sW1TwUVpGf
         d4tziTHjvSDKCxFvzkx3CS31hCrNxoWEJVBfON1xDTUpteEQes6dZb2gaa/w6wj06d
         +Lm/bJPyP3/fDYYcOh8gMivy2qhRh7p9xtwjSkdHkTuRcJu+XCNRMd1Bya5WRUVlUN
         0lAxaKV6uRW7Zxrbd9mDm7oAMVik8/wQsCSpdAEFfmJalwSk+UEKDyTaIALbm8x4UA
         Nv60f5440OTlQ==
Date:   Sat, 16 Jul 2022 15:56:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] iio: Add new event type gesture and use
 direction for single and double tap
Message-ID: <20220716155633.244b9243@jic23-huawei>
In-Reply-To: <CAM+2EuJWEOn-Vtaox=G3zXcd+zpx=mAhY1YHuNJx2XpAyPB1xg@mail.gmail.com>
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
        <20220613191706.31239-2-jagathjog1996@gmail.com>
        <20220619135427.4ffc2d3d@jic23-huawei>
        <CAM+2EuJWEOn-Vtaox=G3zXcd+zpx=mAhY1YHuNJx2XpAyPB1xg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 26 Jun 2022 18:51:54 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan,
> 
> Sorry for the delay in replying.
> 
> On Sun, Jun 19, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 14 Jun 2022 00:47:05 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >  
> > > Add new event type for tap called gesture and the direction can be used
> > > to differentiate single and double tap. This may be used by accelerometer
> > > sensors to express single and double tap events. For directional tap,
> > > modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> > > doubletap direction.
> > >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> >
> > Hi,
> >
> > With fresh eyes I think we need to rethink the use of _period to make sure
> > we have 'space' for another very like ABI element which is the maximum
> > time between events for them to be considered a double tap.
> >
> > Jonathan
> >  
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
> > >  drivers/iio/industrialio-event.c        |  5 ++++-
> > >  include/uapi/linux/iio/types.h          |  3 +++
> > >  tools/iio/iio_event_monitor.c           |  8 +++++++-
> > >  4 files changed, 38 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 3e00d7f7ee22..4eaf85e01911 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -2035,3 +2035,27 @@ Description:
> > >               Available range for the forced calibration value, expressed as:
> > >
> > >               - a range specified as "[min step max]"
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_singletap_en
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_en
> > > +KernelVersion:       5.19
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Device generates an event on a single or double tap.
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_singletap_value
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_value
> > > +KernelVersion:       5.19
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Specifies the threshold value that the device is comparing
> > > +             against to generate the tap gesture event. Units and exact
> > > +             meaning of value are device specific.  
> >
> > I'm fine with this one being device specific, as likely a complex alg
> > involved.
> >  
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_period
> > > +KernelVersion:       5.19
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Minimum time period between before and after the double tap
> > > +             event. Units and exact meaning of period value are device
> > > +             specific.  
> >
> > I think the units need to be standard.  Also would this work better
> > as a description?
> >
> >         Minimum time in seconds between the two taps making up a double
> >         tap event.  
> 
> The values for the time between the two taps are not in terms of seconds,
> here period value is in terms of data samples which depends on
> the data rate.

These time based controls in IIO are always defined in seconds. You'll have
to correct for the data rate in the driver.

Either just make the available options change with data rate, or have the
driver do a 'nearest possible' choice based on what was requested and what
is possible at the current data rate.

It's more complex but it gives a consistent ABI across devices that work
in many different ways.

Jonathan

> 
> >
> > Raises a question though. How would we specify the maximum time? I.e.
> > if taps are further apart than Xseconds, they are reported as two single
> > taps.
> >
> > Maybe reusing period here isn't a good idea and we need to have new ABI for
> > this?
> >
> >
> >
> >  

