Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF12359ADF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbiHTMfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiHTMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:35:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010266556;
        Sat, 20 Aug 2022 05:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2115B80B84;
        Sat, 20 Aug 2022 12:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE5C433D6;
        Sat, 20 Aug 2022 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660998938;
        bh=/kxfrBMwBdTRgx4ygvrsbAbpeVrdQeflgTjSdQfIRnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Blqgbvd8Vl/5zDP9nGwffUwFOQGmttjU7ueMP1QOCuCF9TzXLM2aud7hEX+d83/v8
         bkAvHLlOZrZVXmGNrREoz/INnuWIKM0e5so3QDZ+IzmrjuaylxoUX6ZP21+ymFZ90K
         Ys9QNHSB0xpBOsRopHY4Lu2bHTAaYikEtKqX3f7YnIKH4kwqH1AjYYL5zueuhDJLyM
         2MmpH/fMc0hKFOKkjVPh5Z/o4KYtZRTlmIRbPLLWqlF6eGPsF5nwnbuuPwnpmBnukN
         BE+yk6LOT7/wPsAwSBt/LIt42KskoW9cD/4HQQ019wOAajzwBt1hsv28LSWCOAieiP
         1QZHfhyt3PSbw==
Date:   Sat, 20 Aug 2022 13:46:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Add new event type gesture and use
 direction for single and double tap
Message-ID: <20220820134614.4a41df2f@jic23-huawei>
In-Reply-To: <CAM+2EuJu3g98NOt2tOxPzWnGO3kvFNkruuAeZBd-=VxYvw7x9Q@mail.gmail.com>
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
        <20220813071803.4692-2-jagathjog1996@gmail.com>
        <20220814180451.44a27126@jic23-huawei>
        <CAM+2EuJu3g98NOt2tOxPzWnGO3kvFNkruuAeZBd-=VxYvw7x9Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 00:03:47 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Aug 14, 2022 at 10:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 13 Aug 2022 12:48:02 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >  
> > > Add new event type for tap called gesture and the direction can be used
> > > to differentiate single and double tap. This may be used by accelerometer
> > > sensors to express single and double tap events. For directional tap,
> > > modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> > > doubletap direction.
> > >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> > Hi Jagath,
> >
> > This ABI is definitely something I want more eyes than ours on, so
> > whatever happens I'll leave it on the list for a few weeks.  
> 
> Sure, I will leave KernelVersion blank in the next series.
Please don't.  Just take a guess at 6.1. That will probably be right
and it'll save me effort when applying :) If it's not right then
no harm done as I need to edit it anyway.

> 
> >  
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
> > >  drivers/iio/industrialio-event.c        |  7 ++++-
> > >  include/linux/iio/types.h               |  2 ++
> > >  include/uapi/linux/iio/types.h          |  3 ++
> > >  tools/iio/iio_event_monitor.c           |  8 ++++-
> > >  5 files changed, 59 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index e81ba6f5e1c8..54cb925f714c 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -2038,3 +2038,44 @@ Description:
> > >               Available range for the forced calibration value, expressed as:
> > >
> > >               - a range specified as "[min step max]"
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_singletap_en
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_en
> > > +KernelVersion:       5.21
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Device generates an event on a single or double tap.
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_singletap_value
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_value
> > > +KernelVersion:       5.21
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Specifies the threshold value that the device is comparing
> > > +             against to generate the tap gesture event. Units and exact
> > > +             meaning of value are device specific.  
> >
> > I wonder if we should list a direction?  As in smaller is more sensitive?  
> 
> Yeah in most of the devices which support tap, this value represents the
> threshold, the lower the value higher the tap sensitivity. I will add it to the
> description in the next series.
> 
> > (at least to first approximation)  
> Do I need to add available attributes into ABI docs?

Yes, though no need to give much description of them.
There is a script that compares the ABI exposed on a given platform with
these files and warns if things are missing.  Right now it gives so many
warnings (outside of IIO) that it's more or less unusable but the end goal
is to get to the pointer where systems doing build and boot tests will general
warnings for undocumented ABI.

> 
> > That way a user would at least be able to consistently decide if they should
> > raise or lower the number to get the perf the want.
> >  
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_singletap_reset_timeout
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_reset_timeout
> > > +KernelVersion:       5.21
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Specifies the timeout value in seconds for the tap detector
> > > +             to not to look for another tap event after the event as
> > > +             occoured. Basically the minimum quiet time between the two  
> > spelling.  occured  
> 
> Sorry, I will correct this.
> 
> Thank you
> Jagath
> 
> >  
> > > +             single-tap's or two double-tap's.
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_doubletap_tap_2min_delay  
> >
> > I'm not sure this naming is intuitive enough. Might be a simple
> > as doubletap_tap2_min_delay?  My brain didn't parse 2min correctly.
> >
> > This one is a bit odd, so definitely want to hear more view points on whether
> > this is general enough to cover sensors and intuitive enough that people
> > have some hope of setting it right.
> >  
> > > +KernelVersion:       5.21
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Specifies the minimum quiet time in seconds between the two
> > > +             taps of a double tap.
> > > +
> > > +What:                /sys/.../events/in_accel_gesture_maxtomin_time
> > > +KernelVersion:       5.21
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Specifies the maximum time difference allowed between upper
> > > +             and lower peak of tap to consider it as the valid tap event.
> > > +             Units in seconds.  
> > Needs to be associated with 'tap' in the naming.
> > Easiest is probably only to define it as
> > singletap_maxtomin_time + doubletap_maxtomin_time and not have the
> > shared version as we'd lose the 'tap' part of the name.
> >
> >  

