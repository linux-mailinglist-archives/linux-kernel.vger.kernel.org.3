Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6948F888
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiAORo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiAORo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:44:58 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E5C061574;
        Sat, 15 Jan 2022 09:44:57 -0800 (PST)
Received: from [81.101.6.87] (port=47192 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n8n6g-0005QG-LR; Sat, 15 Jan 2022 17:44:51 +0000
Date:   Sat, 15 Jan 2022 17:50:53 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Message-ID: <20220115175053.3757f641@jic23-huawei>
In-Reply-To: <ab212905-2377-040b-ce8a-2cef3ae13002@gmail.com>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
        <20211217114548.1659721-3-cosmin.tanislav@analog.com>
        <20211223130100.059231d6@jic23-huawei>
        <edb634a17ba04f4cb5e77fa3b5c69358@analog.com>
        <20211228205757.7654cb66@jic23-huawei>
        <ab212905-2377-040b-ce8a-2cef3ae13002@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 00:43:25 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 12/28/21 22:58, Jonathan Cameron wrote:
> > Hi Cosmin,
> > 
> > Happy New year for a few day's time.
> >   
> >>> ...
> >>>      
> >>>> +
> >>>> +static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
> >>>> +{
> >>>> +	unsigned int ev_dir;
> >>>> +
> >>>> +	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
> >>>> +		ev_dir = IIO_EV_DIR_RISING;
> >>>> +	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
> >>>> +		ev_dir = IIO_EV_DIR_FALLING;
> >>>> +	else
> >>>> +		return false;
> >>>> +
> >>>> +	iio_push_event(indio_dev,
> >>>> +		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,  
> >>> IIO_MOD_X_OR_Y_OR_Z,  
> >>>> +					  IIO_EV_TYPE_THRESH, ev_dir),  
> >>> This is unusual for event detection as it's a simple or of separately
> >>> applied thresholds on X, Y and Z axes.  Given the effect of gravity that
> >>> means you have to set the thresholds very wide.
> >>>
> >>> Also, I'd expect these to be magnitudes, not THRESH - no data sheet that
> >>> I can find though so can't be sure.
> >>>      
> >>
> >> Actually, the chip has a referenced, and an absolute mode. We use reference mode
> >> in this driver, as configured in write_event_config.
> >> The motion detection details are about the same as ADXL362 (page 14).
> >> https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL362.pdf  
> > 
> > Interesting.  We should figure out some way to make that clear to userspace
> > given right now it has no way of knowing that and might set inappropriate limits
> > without that information.
> >   
> 
> Any suggestions on how I should do this?

*laughs*  you caught be avoiding thinking about how we might do this.  Going to need
some new ABI that can be universal or per event.

I think the best bet is probably to define something similar to adaptive_thresh in
that we are saying it's a threshold / magnitude as appropriate but not on the
raw underlying signal.  We could potentially use adaptive again but maybe we need
something more specific as that is used when the threshold tracks some low pass
filtered version of the signal. Perhaps

in_accel_x_referenced_magn_* with appropriate ABI docs that make it clear that for
acceleration the point is to remove G, but leave it open what referenced might mean
for other types of signal. 


> 
> > It's kind of similar to some of the adaptive thresholds, just that it uses
> > the value at a particular moment.
> > 
> > Worth noting that for the adxl362 at least the maths is
> > ABS(Acceleration - reference) > Threshold which is a magnitude not a threshold
> > unless you want to represent it as a pair of thresholds (above and below) which
> > gets fiddly as I assume there is only one control
> >   
> 
> Indeed. I didn't catch onto the difference between magnitude and
> threshold. So, I should use IIO_EV_TYPE_MAG rather than
> IIO_EV_TYPE_THRESH? Or IIO_EV_TYPE_MAG_ADAPTIVE? The ABI doesn't
> describe these too well.

Well for what we have today it would be IIO_EV_TYPE_MAG. Roughly speaking
(there are varriants that are similar enough we don't distinguish).
IIO_EV_TYPE_THRESH is signed comparison. If you happen to have a signal that
is always positive (e.g. an ADC) then it's preferred of IIO_EV_TYPE_MAGN even
though they would be the same thing.

So if you have an accelerometer that does -10m/sec^2 to 10m/sec^2 a
rising threshold detector at 5m/sec^2 would only trigger when we pass 
5m/sec^2 heading upwards towards 6, but not when passing -5m/sec^2 heading
for -6m/sec^2.

Magn is basically a threshold applied to the absolute of the reading so a
rising magn threshold would fire on both passing 5m/sec^2 heading for 6m/sec^2
and on passing -5m/sec^2 heading for -6m/sec^2.

The adaptive variants are more fun in that rather than applying to the raw
signal they 'typically' apply relative to some filtered version of that raw
signal (normally Low pass filtered).  The idea is to detect a sudden absolute
change but ignore a slow drift.  So filter on signal - LowPass(signal) with
same thresh vs magn rules as above.



> 
> >>
> >>  
> >>>> +		       iio_get_time_ns(indio_dev));
> >>>> +
> >>>> +	return true;
> >>>> +}  
> > 
> > ...
> >   
> >>>> +static int adxl367_write_event_config(struct iio_dev *indio_dev,
> >>>> +				      const struct iio_chan_spec *chan,
> >>>> +				      enum iio_event_type type,
> >>>> +				      enum iio_event_direction dir,
> >>>> +				      int state)
> >>>> +{
> >>>> +	struct adxl367_state *st = iio_priv(indio_dev);
> >>>> +	enum adxl367_activity_type act;
> >>>> +	int ret;
> >>>> +
> >>>> +	switch (dir) {
> >>>> +	case IIO_EV_DIR_RISING:
> >>>> +		act = ADXL367_ACTIVITY;
> >>>> +		break;
> >>>> +	case IIO_EV_DIR_FALLING:
> >>>> +		act = ADXL367_INACTIVITY;
> >>>> +		break;
> >>>> +	default:
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	ret = iio_device_claim_direct_mode(indio_dev);  
> >>>
> >>> It's unusual (though not unheard of) to have events that cannot be enabled
> >>> at the same time as a fifo.  If that's true here, please add some comments
> >>> to explain why.  Or is this just about the impact of having to disable
> >>> the measurement to turn it on and the resulting interruption of data
> >>> capture?
> >>>
> >>> If so that needs more thought as we have a situation where you can (I think)
> >>> have events as long as you enable them before the fifo based capture is
> >>> started,
> >>> but cannot enable them after.
> >>>      
> >>
> >> That is indeed the case. You mentioned in a previous patchset that various
> >> attributes could toggle measurement mode while the FIFO capture was running,
> >> so I checked all the possible places where that could happen and added claim
> >> direct mode. Not too nice, but it's the nature of the chip...  
> > 
> > Hmm. I'm not sure what the right thing to do here is. Maybe we need a docs update
> > to explicitly call out that this might happen for the event enables?  Calling
> > it out for all devices is fine because all we are doing is saying userspace would
> > ideally cope with this situation and make the decision to disable the buffered
> > mode if it wants to enable events then reenable it afterwards if that is what
> > is desired.  
> 
> By docs you mean the ABI file?

Yup.  

Jonathan

> 
> > 
> > Jonathan
> > 
> >   

