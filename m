Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271D4BC949
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiBSQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:25:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3641959D3;
        Sat, 19 Feb 2022 08:25:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2C760B35;
        Sat, 19 Feb 2022 16:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26930C004E1;
        Sat, 19 Feb 2022 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645287902;
        bh=kDljAIp9S1nSRednTbW/1jhULMQHBXru5memF9e/114=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u6tRX8o8oFx+AiAPMTv++UvtcGNZDLln3yzOi62DHpYeFgtQUalBv5OLhISDN1aan
         2WqbrQtVPexuTjCsdI+gF5QepBUFwxvmNEs3y+gsxpIO1mbwPXmOGKCIBWNd3z0XWK
         JINSPX5dIl1vSBNPPX+/pwF3UDi91sXLJ0AT1WVjrE0xv3PocKQAdkDtWGXrYese4Z
         PFKStfB4L7+ChtVFF5c5kstM8WvHuWBpY701N0olloB4HU3CUf/hTYjsrWlDGDOkNy
         gg/SbfdaofvcOHSQiOsN8uMYu8HyJ2bmjuiKD4WLu+savllgsnXiH5+iAAXMlXx745
         M5CYylmNsvxoA==
Date:   Sat, 19 Feb 2022 16:31:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v3 05/13] iio: document pitch, yaw, roll modifiers
Message-ID: <20220219163149.6c33318c@jic23-huawei>
In-Reply-To: <20220217162710.33615-6-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
        <20220217162710.33615-6-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Thu, 17 Feb 2022 17:27:02 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch introduces ABI documentation for new modifiers used for
> reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
I've lost track of what we already discussed about this, but why have these
as measured in degrees?

Gah. I thought we'd maintained consistency on this, but seems incli is
in degrees, angl is in radians and rot isn't documented at all.

Checking drivers the adis16209 has rot in degrees and I can't immediately figure
out what the hid sensors driver is using.  The underlying spec supports the
hardware returning in either radians or degrees I think. 

Ah well, at least these are new so given the existing mess means at least some
units are already in degrees we aren't making things worse.

Perhaps it's worth a comment on the unit inconsistency in this patch description
so we can at least look back at the history if it comes up for a future driver.

Thanks,

Jonathan


> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b2fb4d9abcd1..1b8d77577608 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2008,3 +2008,12 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
> +KernelVersion:	5.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) euler angles readings. Units after
> +		application of scale are deg.

