Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2A48F895
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiAOSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiAOSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:03:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D03C061574;
        Sat, 15 Jan 2022 10:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA079CE04F0;
        Sat, 15 Jan 2022 18:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6EC36AE7;
        Sat, 15 Jan 2022 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642269820;
        bh=lSEWF5AdYQnuJcWaG8FltWXTLP4RPuyq39ItcWZ8vBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lqWR0eA71yPDz1lUEry84J6D83hliJ59NmGYm/lq/0MU2oS9Za5Ac25fq12Q/CHgz
         I9Iw4JFkEZy/vcLVHmW7B/pqHmT0QRNCwPPdXxeING7Uv2B66UgU1j6ZrdyAzGTD+L
         vmvrshygclDneDj4Y/8qt1PrQe0Kd5yGxMm5yZW61BMJinyJ0ShbgBTVuApt2s3yEg
         mF5/xsr/4T3Ivdf6I3x4J5nc4l5nd3OEsNns0V6dwcVXflV4Xrv0ku+DGJw/iZtAgB
         BLWM772WaToqLl9YcicJpG6QmVJz6SR2yJ2V1xKhn0UPEZx74lpB25HTSSZx5m4r3j
         GSAA9FTk6tG3w==
Date:   Sat, 15 Jan 2022 18:09:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH] iio: frequency: admv1013: remove the always true
 condition
Message-ID: <20220115180941.709a667a@jic23-huawei>
In-Reply-To: <YdS3gJYtECMaDDjA@debian-BULLSEYE-live-builder-AMD64>
References: <YdS3gJYtECMaDDjA@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 02:09:20 +0500
Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> unsigned int variable is always greater than or equal to zero. Make the
> if condition simple.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Hi,

+ CC Antoniu and this should have a Fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/admv1013.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index 6cdeb50143af..3f3c478e9baa 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -348,7 +348,7 @@ static int admv1013_update_mixer_vgate(struct admv1013_state *st)
>  
>  	vcm = regulator_get_voltage(st->reg);
>  
> -	if (vcm >= 0 && vcm < 1800000)
> +	if (vcm < 1800000)
>  		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
>  	else if (vcm > 1800000 && vcm < 2600000)
>  		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;

