Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F14550AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiFSMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFSMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:45:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883277647;
        Sun, 19 Jun 2022 05:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A284B80BA0;
        Sun, 19 Jun 2022 12:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38A7C34114;
        Sun, 19 Jun 2022 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655642709;
        bh=y/KoPM2t8GXCVFwOcHWS7U4rBK2AjOCrRyDyyhEuJBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oOIaC22WChZaLVL8T+Uy9x9o6X1FhNyiuuf5JwRJDmzE+TyB8wZ05oErWxL+ne6lP
         Www9xz+lSmLxaWV/JsfZdx9Zcxp88sVVBn8cIJH0h2P2dq3OjLX3wZGWTNqmCTRjl7
         0HHoc6Z46GM9K09HOnENh765r3kIR4X2RCV5zyxzVQD4y5i8166zdxmqwdjYYHoqSG
         6H/z4o7HvSXUNcaX8IkIfbdVnC/wsXPQ+Il6ffV3ti6Q+lUZogIO0No8aPbrZBVl7T
         4Zhyj7CqSugyE6YU6Nfyi2T8glTR9/IcfBXZ2SqlHi2sJsCUT9Cr3H18jWcc792tMY
         aZx50+gy8XV0w==
Date:   Sun, 19 Jun 2022 13:54:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: Add new event type gesture and use
 direction for single and double tap
Message-ID: <20220619135427.4ffc2d3d@jic23-huawei>
In-Reply-To: <20220613191706.31239-2-jagathjog1996@gmail.com>
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
        <20220613191706.31239-2-jagathjog1996@gmail.com>
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

On Tue, 14 Jun 2022 00:47:05 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add new event type for tap called gesture and the direction can be used
> to differentiate single and double tap. This may be used by accelerometer
> sensors to express single and double tap events. For directional tap,
> modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> doubletap direction.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Hi,

With fresh eyes I think we need to rethink the use of _period to make sure
we have 'space' for another very like ABI element which is the maximum
time between events for them to be considered a double tap.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
>  drivers/iio/industrialio-event.c        |  5 ++++-
>  include/uapi/linux/iio/types.h          |  3 +++
>  tools/iio/iio_event_monitor.c           |  8 +++++++-
>  4 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3e00d7f7ee22..4eaf85e01911 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2035,3 +2035,27 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_en
> +What:		/sys/.../events/in_accel_gesture_doubletap_en
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Device generates an event on a single or double tap.
> +
> +What:		/sys/.../events/in_accel_gesture_singletap_value
> +What:		/sys/.../events/in_accel_gesture_doubletap_value
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the threshold value that the device is comparing
> +		against to generate the tap gesture event. Units and exact
> +		meaning of value are device specific.

I'm fine with this one being device specific, as likely a complex alg
involved.

> +
> +What:		/sys/.../events/in_accel_gesture_doubletap_period
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Minimum time period between before and after the double tap
> +		event. Units and exact meaning of period value are device
> +		specific.

I think the units need to be standard.  Also would this work better
as a description?

	Minimum time in seconds between the two taps making up a double
        tap event.

Raises a question though. How would we specify the maximum time? I.e.
if taps are further apart than Xseconds, they are reported as two single
taps.

Maybe reusing period here isn't a good idea and we need to have new ABI for
this?




