Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F15925B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbiHNQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbiHNQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C40AB483;
        Sun, 14 Aug 2022 09:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59467B80B78;
        Sun, 14 Aug 2022 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67363C433C1;
        Sun, 14 Aug 2022 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660496062;
        bh=IwUdBLHMT3ieqA5j2bOHu/ZJtDZ4uf4XW2Ju/9Ex+yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uqOmZ+Yq+YKTd6ZVLoxx/G483wJvouziDzDIKizNsLQcu40Ov5qUPrQP5GZw5y1F0
         zGm8j4PACCjh5mpqS2ICkfpGNPsxGkYuSu0GfD7oZ9+VC8Ret6cNrBuQFMsa5f7WFF
         lGhDI45L/liNCNDuMxr4njl0xn0LBclu/TcURiN405YBz9QFiLa45tyjgxhqd3mP/w
         C3y5tmjozxOxpSo7JQx1GLgrY90O9TT7uzKvXETL8tdyZpqJs8xkxl9TcDuy0hUB3e
         0myZRgD3INOhiXLEX+7o/KsC7WSYSd4ebtDUCLV+kMXJJZxzpOkS8SmQg3qtF7npfL
         F2PkBY8Tn9TUg==
Date:   Sun, 14 Aug 2022 18:04:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Add new event type gesture and use
 direction for single and double tap
Message-ID: <20220814180451.44a27126@jic23-huawei>
In-Reply-To: <20220813071803.4692-2-jagathjog1996@gmail.com>
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
        <20220813071803.4692-2-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 12:48:02 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add new event type for tap called gesture and the direction can be used
> to differentiate single and double tap. This may be used by accelerometer
> sensors to express single and double tap events. For directional tap,
> modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> doubletap direction.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

This ABI is definitely something I want more eyes than ours on, so
whatever happens I'll leave it on the list for a few weeks.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
>  drivers/iio/industrialio-event.c        |  7 ++++-
>  include/linux/iio/types.h               |  2 ++
>  include/uapi/linux/iio/types.h          |  3 ++
>  tools/iio/iio_event_monitor.c           |  8 ++++-
>  5 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index e81ba6f5e1c8..54cb925f714c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2038,3 +2038,44 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_en
> +What:		/sys/.../events/in_accel_gesture_doubletap_en
> +KernelVersion:	5.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Device generates an event on a single or double tap.
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_value
> +What:		/sys/.../events/in_accel_gesture_doubletap_value
> +KernelVersion:	5.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the threshold value that the device is comparing
> +		against to generate the tap gesture event. Units and exact
> +		meaning of value are device specific.

I wonder if we should list a direction?  As in smaller is more sensitive?
(at least to first approximation)
That way a user would at least be able to consistently decide if they should
raise or lower the number to get the perf the want.

> +
> +What:		/sys/.../events/in_accel_gesture_singletap_reset_timeout
> +What:		/sys/.../events/in_accel_gesture_doubletap_reset_timeout
> +KernelVersion:	5.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the timeout value in seconds for the tap detector
> +		to not to look for another tap event after the event as
> +		occoured. Basically the minimum quiet time between the two
spelling.  occured

> +		single-tap's or two double-tap's.
> +
> +What:		/sys/.../events/in_accel_gesture_doubletap_tap_2min_delay

I'm not sure this naming is intuitive enough. Might be a simple
as doubletap_tap2_min_delay?  My brain didn't parse 2min correctly.

This one is a bit odd, so definitely want to hear more view points on whether
this is general enough to cover sensors and intuitive enough that people
have some hope of setting it right.

> +KernelVersion:	5.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the minimum quiet time in seconds between the two
> +		taps of a double tap.
> +
> +What:		/sys/.../events/in_accel_gesture_maxtomin_time
> +KernelVersion:	5.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the maximum time difference allowed between upper
> +		and lower peak of tap to consider it as the valid tap event.
> +		Units in seconds.
Needs to be associated with 'tap' in the naming.
Easiest is probably only to define it as
singletap_maxtomin_time + doubletap_maxtomin_time and not have the
shared version as we'd lose the 'tap' part of the name.


