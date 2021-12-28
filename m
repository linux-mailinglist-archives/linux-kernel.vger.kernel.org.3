Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC35480D57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhL1VVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhL1VVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:21:36 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1491C061574;
        Tue, 28 Dec 2021 13:21:35 -0800 (PST)
Received: from [81.101.6.87] (port=39594 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2JuX-0008Il-6v; Tue, 28 Dec 2021 21:21:33 +0000
Date:   Tue, 28 Dec 2021 21:27:18 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Frank Zago <frank@zago.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: position: Add support for ams AS5600 angle sensor
Message-ID: <20211228212709.3c039cca@jic23-huawei>
In-Reply-To: <d949f737-7cb8-e466-06c7-b3fd7efadfd7@zago.net>
References: <20211216202651.120172-1-frank@zago.net>
        <20211223132800.682a56d2@jic23-huawei>
        <d949f737-7cb8-e466-06c7-b3fd7efadfd7@zago.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 12:04:55 -0600
Frank Zago <frank@zago.net> wrote:

> Hi Jonaathan,
Hi Frank,

> 

See below. I've taken a closer look at how we might map these to standard
interfaces.

> >> +What:		sys/bus/iio/devices/iio:deviceX/agc
magn_hardwaregain
  We have similar hardwaregain for things like time of flight sensors where
  we are changing the gain on a light sensor so as to measure a pulse timing.
  Hence it is gain on a signal needed to measure what we are interested in rather
  than the type of the channel etc.  This seems very similar.

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_fth
Hmm. This filter is unusual, but we should still be looking to map it
to an extension of our existing filtering ABI.

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_hyst
We have hystersis defined for events. I'm fine with defining it also for
the raw signal which what I think this is.
in_magn_hysteresis  For now do it using extended_info as we are running
short on bits in the info_mask bitmaps and I don't know how common this will
be...


> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_outs
This is about analog output which will depend on board circuitry (what it
is wired up to). Hence belongs in firmware e.g. Device tree bindings
No userspace control (other than via debugfs)

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_pm

So this trades off polling time against supply current.  A simple mapping for
this would be to use SAMP_FREQ as 1/polling_time.  Provide available
as well so we know what can be selected.

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_pwmf
Another thing related to external circuitry.  So should be in DT not
userspce control.

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_sf
More filter control.

> >> +What:		sys/bus/iio/devices/iio:deviceX/conf_wd
This is a kind of hardware equivalent of autosuspend in runtime pm.
I'd ignore it for now as hard to control in a generic way so reality
is little userspace code will use it.

> >> +What:		sys/bus/iio/devices/iio:deviceX/magnitude
You could possibly output this as in_voltage0_raw if it's useful to be
able to read it.

> >> +What:		sys/bus/iio/devices/iio:deviceX/mang
> >> +What:		sys/bus/iio/devices/iio:deviceX/mpos
These map to offset and scale values though as you mention mang is tricky
to test.

> >> +What:		sys/bus/iio/devices/iio:deviceX/status_md
> >> +What:		sys/bus/iio/devices/iio:deviceX/status_mh
> >> +What:		sys/bus/iio/devices/iio:deviceX/status_ml
These 3 need some thought but whatever we chose needs to at least
be generic enough that other sensors that use an external magnet
(I have one around here somewhere that is similar to this device)
can use the same interface.

> >> +What:		sys/bus/iio/devices/iio:deviceX/zmco
This one I'd print at boot - it's useful for people to be able to
check but I'm not sure it's much use at runtime.

> >> +What:		sys/bus/iio/devices/iio:deviceX/zpos
> >> +KernelVersion:	TBD
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +	Read and write the ams AS5600 internal registers and their
> >> +	fields. zpos/mpos can be used to create a subset of the 0-360
> >> +	degree range. status_md will tell whether the magnet is
> >> +	detected. Check the datasheet
> >> +	(https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf)
> >> +	for more information.  
> > 
> > No to this lot.  If you need raw register access it needs to be debugfs
> > not sysfs.  IIO provides a standard way of doing that.
> > (just grep debugfs and you will find lots of examples).  
> 
> I've moved them all to debugfs, but I think this is abusing what debugfs
> is for. It may not be mounted on a system after all.

Absolutely and these controls should not generally be available like this.
If you have a reason to expose them to userspace for general usage then 
we need to come up with a way to map them to an interface that is generic.

> 
> Why not have a namespace in sysfs for things specific to a device that
> can't be abstracted to other devices?

If we go that way we basically end up loosing all the advantage of having
a subsystem.  It is more effort to figure out how to map things but it can
almost always be done. Driver specific interfaces sometimes exist for
a few things that we don't expect to see on other devices, but they still
have to fit within the general framework of the ABI so that, if we are wrong
and they do turn up on multiple devices, we have the right ABI to make
generic when it is needed (this happens quite often).

One corner case that is hard to define generic interfaces for is error status
conditions as those are often a feature of the implementation rather than anything
generic (wire fell out or as you have it here magnet too weak /strong / missing).
Even there we need to think about how to name them so they could be reused by
similar devices.

anyhow, I've added some mappings above.

> 
> >> + * The rotating magnet is installed from 0.5mm to 3mm parallel to and
> >> + * above the chip.
> >> + *
> >> + * The raw angle value returned by the chip is [0..4095]. The channel
> >> + * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
> >> + * covering the 360 degrees. The channel 1 returns the chip adjusted
> >> + * angle, covering from 18 to 360 degrees, as modified by its
> >> + * ZPOS/MPOS/MANG values,  
> > 
> > So, the raw case is simple, the other one more complex.
> > 
> > I think zpos maps well to offset in iio terms. Mpos is harder because
> > we don't typically define a maximum value for a channel. I'm also not
> > sure what the point is in either of these unless MANG is used and
> > as you observer that is not exposed (good thing too given limited write cycles).
> > Without MANG you might as well just do it in userspace - unless the DAC or PWM
> > outputs are of interest...  
> 
> zpos/mpos define an arc in the circle. Physically that could reflect a
> rotating button that can't do full circles. I've documented that a bit in v2.

If it can't do full circles, then you won't get values beyond the limits.  So
what this is doing is clamping the value to enforce that - maybe the button gets
a bit squishy and can go a little beyond the limit?
That's easily done in userspace as well.

> 
> I'm unclear how MANG works, as I haven't been able to set it. My only option 
> would be to flash it (OTP) it to a value to my only device.

Understood.  Those features are always a pain because we don't want to expose
them to userspace in general.  Often the best plan is to only read them anyway
and rely on factory calibration for the device that is making use of them having
set them appropriately.

> 
> 
> >> +	ret = i2c_smbus_read_byte_data(client, REG_STATUS);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	/* No magnet present could be a problem. */  
> > 
> > :) Good understatement.  Why not just fail the probe if this occurs?  
> 
> I left that in place, since I think it could be possible for the magnet to
> not be present when the driver loads, for instance some sort of door could be
> opened. Also it doesn't break anything besides not returning an valid angle.

Fair enough.

> 
> Frank

