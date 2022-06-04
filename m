Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283653D741
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiFDOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CA1AD83;
        Sat,  4 Jun 2022 07:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E284060C48;
        Sat,  4 Jun 2022 14:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1905FC385B8;
        Sat,  4 Jun 2022 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654353276;
        bh=11w43XmXCfXrW3BUjnWcLn987BRfVWfTBifjn0v+j44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QU6DSGojHnCgVjkohMLT7rpseRAaJ+8iPJwnOAVpNB9ODb8cRfKErvjG2rtjHilSm
         9+eCwqQPH/ILkQRbU9pT03D703Cs68SCj1a+tadUuOwHWiPCAsvyPIwBRU41jsKrTG
         MIGv+YruW4gkLSZJmn9bhHvEflhuFrPw3ErZIXZPVbFGAxrCVMz6lkuLGOPaojiuTk
         Qe3XwdF/Rg/7E+y589kvgOgS6Q5Sz/q4J44SqmrbRwtiDz8Uepdqwzs3TpAO8qR8qU
         uqCQvekIpyCsGTNRIMVuFDsoFsgVtmXBK/Sb3nOxekdjeyRmeGM9BxiczyKwDd3LYI
         OSOpGtoA7rB1Q==
Date:   Sat, 4 Jun 2022 15:43:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] iio: Add new event type gesture and use direction for
 single and double tap
Message-ID: <20220604154338.26a9ddf7@jic23-huawei>
In-Reply-To: <20220529040153.4878-2-jagathjog1996@gmail.com>
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
        <20220529040153.4878-2-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 09:31:52 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add new event type for tap called gesture and the direction can be used
> to differentiate single and double tap. This may be used by accelerometer
> sensors to express single and double tap events. For directional tap,
> modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> doubletap direction.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Looks good to me in general. A few comments on the documentation. 

I briefly thought about whether we should make the direction enum dependent
on the type of channel, but then I checked and we have 7 bits for that
fields, so 'hopefully' we will always have plenty of space.

If people start defining 100s of gestures we may need to rethink.

This is bold new userspace ABI, so I definitely want to give this
more time on the list for others to have the opportunity to take a look
and think about whether it works for their devices etc.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
>  drivers/iio/industrialio-event.c        |  5 ++++-
>  include/uapi/linux/iio/types.h          |  3 +++
>  tools/iio/iio_event_monitor.c           |  8 +++++++-
>  4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3e00d7f7ee22..2d4866203ccf 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2035,3 +2035,22 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_en
> +What:		/sys/.../events/in_accel_gesture_doubletap_en
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Accelerometer device detects single or double taps and generate
> +		events when threshold for minimum tap amplitide passes.

I'd keep this a little more vague as different accelerometers have different
magic algorithms to detect this and we don't want to care about how they do
it.

> +		E.g. a single tap event is generated when acceleration value
> +		crosses the minimum tap amplitude value set. Where tap threshold
> +		value is set by using in_accel_gesture_singletap_value.

That's a very simplistic tap detector. Given the control on the threshold
on the bma400 is a whole 3 bits, I'd not what to hazard any guess to
what 'tap sensitivity is'.

So I'd make this description much less specific. (even drop the device type)
Perhaps:

"Device generates an event on a single or double tap".

> +
> +What:		/sys/.../events/in_accel_gesture_singletap_value
> +What:		/sys/.../events/in_accel_gesture_doubletap_value
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the threshold value that the device is comparing
> +		against to generate the tap gesture event.

This is why 'gesture' detection is a pain.   What are the units of this
value?  (typically tap detection is done via some mixture of jerk and
thresholds on the raw acceleration plus temporal constraints).  

Perhaps for now, we just add a sentence that says.

'Units and exact meaning are device specific.' ?



> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b5e059e15b0a..22d59eb0a8a2 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -231,12 +231,15 @@ static const char * const iio_ev_type_text[] = {
>  	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
>  	[IIO_EV_TYPE_CHANGE] = "change",
>  	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
> +	[IIO_EV_TYPE_GESTURE] = "gesture",
>  };
>  
>  static const char * const iio_ev_dir_text[] = {
>  	[IIO_EV_DIR_EITHER] = "either",
>  	[IIO_EV_DIR_RISING] = "rising",
> -	[IIO_EV_DIR_FALLING] = "falling"
> +	[IIO_EV_DIR_FALLING] = "falling",
> +	[IIO_EV_DIR_SINGLETAP] = "singletap",
> +	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
>  };
>  
>  static const char * const iio_ev_info_text[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 472cead10d8d..913864221ac4 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -105,6 +105,7 @@ enum iio_event_type {
>  	IIO_EV_TYPE_MAG_ADAPTIVE,
>  	IIO_EV_TYPE_CHANGE,
>  	IIO_EV_TYPE_MAG_REFERENCED,
> +	IIO_EV_TYPE_GESTURE,
>  };
>  
>  enum iio_event_direction {
> @@ -112,6 +113,8 @@ enum iio_event_direction {
>  	IIO_EV_DIR_RISING,
>  	IIO_EV_DIR_FALLING,
>  	IIO_EV_DIR_NONE,
> +	IIO_EV_DIR_SINGLETAP,
> +	IIO_EV_DIR_DOUBLETAP,
>  };
>  
>  #endif /* _UAPI_IIO_TYPES_H_ */
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 2f4581658859..b3b3ea399f67 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -69,12 +69,15 @@ static const char * const iio_ev_type_text[] = {
>  	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
>  	[IIO_EV_TYPE_CHANGE] = "change",
>  	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
> +	[IIO_EV_TYPE_GESTURE] = "gesture",
>  };
>  
>  static const char * const iio_ev_dir_text[] = {
>  	[IIO_EV_DIR_EITHER] = "either",
>  	[IIO_EV_DIR_RISING] = "rising",
> -	[IIO_EV_DIR_FALLING] = "falling"
> +	[IIO_EV_DIR_FALLING] = "falling",
> +	[IIO_EV_DIR_SINGLETAP] = "singletap",
> +	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -227,6 +230,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
>  	case IIO_EV_TYPE_CHANGE:
> +	case IIO_EV_TYPE_GESTURE:
>  		break;
>  	default:
>  		return false;
> @@ -236,6 +240,8 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_EV_DIR_EITHER:
>  	case IIO_EV_DIR_RISING:
>  	case IIO_EV_DIR_FALLING:
> +	case IIO_EV_DIR_SINGLETAP:
> +	case IIO_EV_DIR_DOUBLETAP:
>  	case IIO_EV_DIR_NONE:
>  		break;
>  	default:

