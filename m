Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64B4AC640
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbiBGQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbiBGQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:38:00 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D89EC0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:37:59 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 08EB3120242;
        Mon,  7 Feb 2022 16:37:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id CA6F36000C;
        Mon,  7 Feb 2022 16:37:41 +0000 (UTC)
Message-ID: <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
Subject: Re: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Mon, 07 Feb 2022 08:37:55 -0800
In-Reply-To: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA6F36000C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: kteytq1t4m7ks8uegmowbi3jhcaufp7z
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18PmfyryuwvxUexaIDlJ1cTu6itrewLoEA=
X-HE-Tag: 1644251861-121208
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 12:48 +0200, Andy Shevchenko wrote:
> In a couple of messages the constants, which have their definitions,
> are hard coded into the message text. Unhardcode them.

Found by inspection or tool?

> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
[]
> @@ -409,8 +409,8 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
>  	new_custom->size = n_entries * n_size;
>  	/* check Steinhart size */
>  	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE) {
> -		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
> -							new_custom->size);
> +		dev_err(dev, "Steinhart sensors size(%zu) must be %d", new_custom->size,
> +			LTC2983_CUSTOM_STEINHART_SIZE);

probably better using "%u" and not "%d"

and better with a \n termination too.

>  		return ERR_PTR(-EINVAL);
>  	}
>  	/* Check space on the table. */
> @@ -1299,8 +1299,8 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
>  		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
>  			ret = -EINVAL;
> -			dev_err(dev,
> -				"chan:%d must be from 1 to 20\n", sensor.chan);
> +			dev_err(dev, "chan:%d must be from %d to %d\n", sensor.chan,
> +				LTC2983_MIN_CHANNELS_NR, LTC2983_MAX_CHANNELS_NR);
>  			goto put_child;
>  		} else if (channel_avail_mask & BIT(sensor.chan)) {
>  			ret = -EINVAL;


