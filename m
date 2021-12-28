Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D53480D17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhL1Uwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhL1Uw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:52:29 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA7C061574;
        Tue, 28 Dec 2021 12:52:28 -0800 (PST)
Received: from [81.101.6.87] (port=39592 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2JSI-0003Tt-F6; Tue, 28 Dec 2021 20:52:23 +0000
Date:   Tue, 28 Dec 2021 20:58:05 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Message-ID: <20211228205757.7654cb66@jic23-huawei>
In-Reply-To: <edb634a17ba04f4cb5e77fa3b5c69358@analog.com>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
        <20211217114548.1659721-3-cosmin.tanislav@analog.com>
        <20211223130100.059231d6@jic23-huawei>
        <edb634a17ba04f4cb5e77fa3b5c69358@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmin,

Happy New year for a few day's time.

> > ...
> >   
> > > +
> > > +static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
> > > +{
> > > +	unsigned int ev_dir;
> > > +
> > > +	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
> > > +		ev_dir = IIO_EV_DIR_RISING;
> > > +	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
> > > +		ev_dir = IIO_EV_DIR_FALLING;
> > > +	else
> > > +		return false;
> > > +
> > > +	iio_push_event(indio_dev,
> > > +		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,  
> > IIO_MOD_X_OR_Y_OR_Z,  
> > > +					  IIO_EV_TYPE_THRESH, ev_dir),  
> > This is unusual for event detection as it's a simple or of separately
> > applied thresholds on X, Y and Z axes.  Given the effect of gravity that
> > means you have to set the thresholds very wide.
> > 
> > Also, I'd expect these to be magnitudes, not THRESH - no data sheet that
> > I can find though so can't be sure.
> >   
> 
> Actually, the chip has a referenced, and an absolute mode. We use reference mode
> in this driver, as configured in write_event_config.
> The motion detection details are about the same as ADXL362 (page 14).
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL362.pdf

Interesting.  We should figure out some way to make that clear to userspace
given right now it has no way of knowing that and might set inappropriate limits
without that information.

It's kind of similar to some of the adaptive thresholds, just that it uses
the value at a particular moment.

Worth noting that for the adxl362 at least the maths is
ABS(Acceleration - reference) > Threshold which is a magnitude not a threshold
unless you want to represent it as a pair of thresholds (above and below) which
gets fiddly as I assume there is only one control

> 
> 
> > > +		       iio_get_time_ns(indio_dev));
> > > +
> > > +	return true;
> > > +}

...

> > > +static int adxl367_write_event_config(struct iio_dev *indio_dev,
> > > +				      const struct iio_chan_spec *chan,
> > > +				      enum iio_event_type type,
> > > +				      enum iio_event_direction dir,
> > > +				      int state)
> > > +{
> > > +	struct adxl367_state *st = iio_priv(indio_dev);
> > > +	enum adxl367_activity_type act;
> > > +	int ret;
> > > +
> > > +	switch (dir) {
> > > +	case IIO_EV_DIR_RISING:
> > > +		act = ADXL367_ACTIVITY;
> > > +		break;
> > > +	case IIO_EV_DIR_FALLING:
> > > +		act = ADXL367_INACTIVITY;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = iio_device_claim_direct_mode(indio_dev);  
> > 
> > It's unusual (though not unheard of) to have events that cannot be enabled
> > at the same time as a fifo.  If that's true here, please add some comments
> > to explain why.  Or is this just about the impact of having to disable
> > the measurement to turn it on and the resulting interruption of data
> > capture?
> > 
> > If so that needs more thought as we have a situation where you can (I think)
> > have events as long as you enable them before the fifo based capture is
> > started,
> > but cannot enable them after.
> >   
> 
> That is indeed the case. You mentioned in a previous patchset that various
> attributes could toggle measurement mode while the FIFO capture was running,
> so I checked all the possible places where that could happen and added claim
> direct mode. Not too nice, but it's the nature of the chip...

Hmm. I'm not sure what the right thing to do here is. Maybe we need a docs update
to explicitly call out that this might happen for the event enables?  Calling
it out for all devices is fine because all we are doing is saying userspace would
ideally cope with this situation and make the decision to disable the buffered
mode if it wants to enable events then reenable it afterwards if that is what
is desired.

Jonathan


