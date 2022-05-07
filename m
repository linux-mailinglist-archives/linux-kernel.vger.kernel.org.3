Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7378251E877
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386101AbiEGQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiEGQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F113E2C;
        Sat,  7 May 2022 09:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C0EF612E6;
        Sat,  7 May 2022 16:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D1AC385A9;
        Sat,  7 May 2022 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651940148;
        bh=Vz3M/nqRG3cA+FhaaCNj7VcKlTqWYVLdzOxM5rlHhP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DbU+0vZXhWEWhANN+RcnV3m/vd2qGdm9no8dv20fRufHe+qKonyhRIPMFjyyJBdrO
         av2QtvawkqA/Yb4XHf9EIyHE1dWU3se3uU/wt1684d6M+z9+X03wEG6vhOMhMCtRgj
         kNaMtAC9ihSAFBFcH+FtLY43yxpLY6XVzoFenHxgbCDgWniVJ/rZ4Ecs78q/C1lde5
         iQt/ZurPPRE7O3K4PgZk5hnnAolI28OHZOOeYS3CQReJjIIEwPAvFF/BlOjj2zu3X3
         RGj7HB0kNh6DQ8veOmqdWmlaLh4o/BGPgdHPlumyWYk4XpBKHQL/TwSPUORkHbMUmc
         9ua4ooESUd0dw==
Date:   Sat, 7 May 2022 17:24:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] iio: Add channel for tap and new modifiers for
 single and double tap
Message-ID: <20220507172416.0c74d4cb@jic23-huawei>
In-Reply-To: <20220505133021.22362-10-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
        <20220505133021.22362-10-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Thu,  5 May 2022 19:00:20 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

Strangely the last time I can remember discussion around how to
support tap detection was way back in the early days of IIO, perhaps
10 years ago. I don't recall us ever coming to a conclusion on how to do it.

> Add new channel type for tap and also add new modifiers for single and
> double tap. This channel and modifiers may be used by accelerometer
> sensors to express single and double tap events. For directional tap,
> modifiers like IIO_MOD_(X/Y/Z) can be used along with rising and
> falling direction.

Not sure how that would work seeing as there is only one modifier
field and it's not a bitmap. 
The event code would need to encode both what type of tap and
the direction and there aren't two fields in which to do that.

One way I can see this 'might' work would be to use
the event type to encode tap and the direction could be 'abused'
to encode single vs double (or other events like this)

in_accel_x_tap_single
in_accel_x_tap_double

We could possibly be more generic and have the 'type' as
'event' or something like that allowing us to use the
7 bit direction field to encode different detectable events
(I'm not that keen on the name event though, could maybe
map it to gesture which would cover some of the other
motion pattern detection devices out there)

That would give us

in_accel_x_event_singletap
in_accel_y_event_doubletap

etc.

How ever we move forwards we do it this want to be in a new series with a nice
bold title to attract that attention of people who don't really
care about he bma400 but do care about tap detection; it's
a common feature of accelerometers.

Jonathan



> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>


> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  3 +++
>  include/uapi/linux/iio/types.h          |  3 +++
>  tools/iio/iio_event_monitor.c           |  6 ++++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d4ccc68fdcf0..bf2d10d6ad9b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2030,3 +2030,14 @@ Description:
>  		Available range for the forced calibration value, expressed as:
>  
>  		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_tap_single_change_en
> +What:		/sys/.../events/in_tap_double_change_en
> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Accelerometer device detects single or double taps and generate
> +		events when threshold for minimum tap amplitide passes.
> +		E.g. a single tap event is generated when acceleration value
> +		crosses the minimum tap amplitude value set. Where tap threshold
> +		value is set by using in_tap_change_value.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..9b0d7bbd07fc 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_TAP] = "tap"
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -134,6 +135,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_ETHANOL] = "ethanol",
>  	[IIO_MOD_H2] = "h2",
>  	[IIO_MOD_O2] = "o2",
> +	[IIO_MOD_TAP_SINGLE] = "single",
> +	[IIO_MOD_TAP_DOUBLE] = "double",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 472cead10d8d..d1e61c84e0d5 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -47,6 +47,7 @@ enum iio_chan_type {
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
>  	IIO_MASSCONCENTRATION,
> +	IIO_TAP,
>  };
>  
>  enum iio_modifier {
> @@ -95,6 +96,8 @@ enum iio_modifier {
>  	IIO_MOD_ETHANOL,
>  	IIO_MOD_H2,
>  	IIO_MOD_O2,
> +	IIO_MOD_TAP_SINGLE,
> +	IIO_MOD_TAP_DOUBLE,
>  };
>  
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 2f4581658859..7fa7d4285f40 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE] = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_TAP] = "tap",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -122,6 +123,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PM4] = "pm4",
>  	[IIO_MOD_PM10] = "pm10",
>  	[IIO_MOD_O2] = "o2",
> +	[IIO_MOD_TAP_SINGLE] = "single",
> +	[IIO_MOD_TAP_DOUBLE] = "double",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -164,6 +167,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_POSITIONRELATIVE:
>  	case IIO_PHASE:
>  	case IIO_MASSCONCENTRATION:
> +	case IIO_TAP:
>  		break;
>  	default:
>  		return false;
> @@ -215,6 +219,8 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_PM4:
>  	case IIO_MOD_PM10:
>  	case IIO_MOD_O2:
> +	case IIO_MOD_TAP_SINGLE:
> +	case IIO_MOD_TAP_DOUBLE:
>  		break;
>  	default:
>  		return false;

