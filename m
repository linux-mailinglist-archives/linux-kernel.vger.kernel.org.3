Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB215A5319
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiH2RZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH2RZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:25:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEAD4C608;
        Mon, 29 Aug 2022 10:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7FA8B8119D;
        Mon, 29 Aug 2022 17:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB40BC433C1;
        Mon, 29 Aug 2022 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661793929;
        bh=9OEgeUDCfTi9FzYK0R6gTerji4mpgeD8bhEZsF5KzR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afDem3itAZHSy7KJzrY90B4UEoilNN1Lctj4Zaur3HrwS2OLzyWjBIt2tsylnVhFZ
         8QLmkL4dNJ4h4xbsS7tOMe5VRpMcMt31J4PkN53EqaLNNmftKgPqeBXA9XsqvsPpLC
         xH6+R61FfqyhRwRNJ7ALvFFYoN7C3wY2wQ7iuXjnUOrPGKck0Wa/kGUEGhodRRTP48
         vmMbZ5klkGXBQhJTWKLwhAOzplrYTIy9f/eObujF3P4xZvG7H1Wews8Xv528HbBcz1
         Juq1teDCxB89eHFPy8wIngG3+MGJ0HRZZhds5tqsfaEhv/3qVDjs434l412tjjqEIk
         LTRKpAt1ryj3Q==
Date:   Mon, 29 Aug 2022 17:51:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: Add new event type gesture and use
 direction for single and double tap
Message-ID: <20220829175109.7e0544ee@jic23-huawei>
In-Reply-To: <20220825194604.15645-2-jagathjog1996@gmail.com>
References: <20220825194604.15645-1-jagathjog1996@gmail.com>
        <20220825194604.15645-2-jagathjog1996@gmail.com>
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

On Fri, 26 Aug 2022 01:16:03 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add new event type for tap called gesture and the direction can be used
> to differentiate single and double tap. This may be used by accelerometer
> sensors to express single and double tap events. For directional tap,
> modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> doubletap direction.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
LGTM though I'm still keen for more review on this, particularly with an
eye on generality.

J
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 69 +++++++++++++++++++++++++
>  drivers/iio/industrialio-event.c        |  7 ++-
>  include/linux/iio/types.h               |  2 +
>  include/uapi/linux/iio/types.h          |  3 ++
>  tools/iio/iio_event_monitor.c           |  8 ++-
>  5 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index e81ba6f5e1c8..4035173030b7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2038,3 +2038,72 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_en
> +What:		/sys/.../events/in_accel_gesture_doubletap_en
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Device generates an event on a single or double tap.
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_value
> +What:		/sys/.../events/in_accel_gesture_doubletap_value
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the threshold value that the device is comparing
> +		against to generate the tap gesture event. The lower
> +		threshold value increases the sensitivity of tap detection.
> +		Units and the exact meaning of value are device-specific.
> +
> +What:		/sys/.../events/in_accel_gesture_tap_value_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available threshold values which can be used to
> +		modify the sensitivity of the tap detection.
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_reset_timeout
> +What:		/sys/.../events/in_accel_gesture_doubletap_reset_timeout
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the timeout value in seconds for the tap detector
> +		to not to look for another tap event after the event as
> +		occurred. Basically the minimum quiet time between the two
> +		single-tap's or two double-tap's.
> +
> +What:		/sys/.../events/in_accel_gesture_tap_reset_timeout_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available tap reset timeout values. Units in seconds.
> +
> +What:		/sys/.../events/in_accel_gesture_doubletap_tap2_min_delay
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the minimum quiet time in seconds between the two
> +		taps of a double tap.
> +
> +What:		/sys/.../events/in_accel_gesture_doubletap_tap2_min_delay_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available delay values between two taps in the double
> +		tap. Units in seconds.
> +
> +What:		/sys/.../events/in_accel_gesture_tap_maxtomin_time
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the maximum time difference allowed between upper
> +		and lower peak of tap to consider it as the valid tap event.
> +		Units in seconds.
> +
> +What:		/sys/.../events/in_accel_gesture_tap_maxtomin_time_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available time values between upper peak to lower
> +		peak. Units in seconds.
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b5e059e15b0a..65ef0fc3be23 100644
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
> @@ -247,6 +250,8 @@ static const char * const iio_ev_info_text[] = {
>  	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
>  	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
>  	[IIO_EV_INFO_TIMEOUT] = "timeout",
> +	[IIO_EV_INFO_RESET_TIMEOUT] = "reset_timeout",
> +	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
>  };
>  
>  static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a7aa91f3a8dc..4716a4b3d614 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -17,6 +17,8 @@ enum iio_event_info {
>  	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
>  	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
>  	IIO_EV_INFO_TIMEOUT,
> +	IIO_EV_INFO_RESET_TIMEOUT,
> +	IIO_EV_INFO_TAP2_MIN_DELAY,
>  };
>  
>  #define IIO_VAL_INT 1
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

