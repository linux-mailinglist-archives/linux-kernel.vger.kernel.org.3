Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED8546A29D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhLFRWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhLFRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:22:09 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59EC061746;
        Mon,  6 Dec 2021 09:18:40 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so4551231ood.9;
        Mon, 06 Dec 2021 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqH7yr1I7QwoW5kKDKfii6Og16iXjUvJo6cV2H86U60=;
        b=R/xtTXimPuCUAEaNfuf4WIyPHRXs+RYRNI9GdL5H9WKqBBqTMgYCyfwFrQOx+Q6b+d
         uTSIjf862eQiqWfAVbWlVBCCGWMZvRuvj14Hsa5Bf27vCZI/ddNn0/VGBhbl+5WuvX3/
         z9to+pydPI+i/eF6HLt/SSorNhOF3qwZ/yUj4iyDy6QrIe0HR4WFLLv++3Tb/5GsXm+2
         cohittgSzV3HpduUBKtYOnTwEzaWcZt9Eo8U92AWjLcCXYfQilzP+lFq3398eNzU4HaK
         FcUZllHNSh0DGJ5JbGhKnyF62Z/jFPJrJbx1XyoOfF28kUVCHwWFnPJDDf1rQC4RWRes
         7Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NqH7yr1I7QwoW5kKDKfii6Og16iXjUvJo6cV2H86U60=;
        b=p/8wMEarTwpGKN3lbFtsQHKj33b5NkUW/PZxVVT3cJ+j4vmv1FWrQIPXUHaNURj8sh
         nHgqDR3xLA6xzNrS2hmxiXc+SuMzvMgidb17+oVVNKqonUQwRAXgY+jhlX34BKiGJIPr
         NcAY0tyEqGKZI8Yojo1uIqYaAxukwmpdl7gxUMBAckR4b7jbXhi1QCRsBI/iDWLPH1s7
         gJWl8leqpGFBFPhXDvFWadyMAyaZ/ycCT8tcBlGF1xFc82L4aDapuy1SeOs5/R9CUPnt
         27wtgfbR5bCdEcYubYwT1e2Bx3+YvmuLJi67OOVQwiSyCnb6IWdRBkEHEK725qW/Cc7i
         +kBQ==
X-Gm-Message-State: AOAM532S5BoELlK/Pg52IEOFJoMPev0eWURAfb7CgIP9qezdOnSWKwCT
        ceqLorica+AxOtaVrKtTUPqJz2P4+FU=
X-Google-Smtp-Source: ABdhPJwSCSaLJgG6yUOyVhbjddbDY7Yv9gEm5XldDMLFkQxRs1k3gFsn54Ot57wpPWTxQuhp6OLTxw==
X-Received: by 2002:a4a:a5cf:: with SMTP id k15mr22966949oom.70.1638811120277;
        Mon, 06 Dec 2021 09:18:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5sm2230477otk.70.2021.12.06.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:18:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Dec 2021 09:18:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, vz@mleia.com
Subject: Re: [PATCH] watchdog: Fix file path that does not exist
Message-ID: <20211206171838.GA3423410@roeck-us.net>
References: <20211206144224.2931-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206144224.2931-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:42:24PM +0800, Wei Ming Chen wrote:
> All the file path are now under drivers/watchdog/ instead of
> drivers/char/watchdog/
> 

Having a file name in its source is pointless. If you want to make any
changes, please drop those file names instead.

Also, "Based on ..." is still correct, as it refers to where the code
was located when the driver was written, not where it is today.
That code may actually have been removed by now, and then what ?
Please do not change those locations.

Last but not least, the bcm63xx driver is about to be removed.
Please do not touch it to avoid unnecessary conflicts.

Thanks,
Guenter

> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/watchdog/davinci_wdt.c | 2 +-
>  drivers/watchdog/it8712f_wdt.c | 2 +-
>  drivers/watchdog/ixp4xx_wdt.c  | 2 +-
>  drivers/watchdog/max63xx_wdt.c | 2 +-
>  drivers/watchdog/pnx4008_wdt.c | 2 +-
>  drivers/watchdog/scx200_wdt.c  | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index e6eaba6bae5b..91e548ad046f 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * drivers/char/watchdog/davinci_wdt.c
> + * drivers/watchdog/davinci_wdt.c
>   *
>   * Watchdog driver for DaVinci DM644x/DM646x processors
>   *
> diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
> index 3ce6a58bd81e..cb60ed310ab6 100644
> --- a/drivers/watchdog/it8712f_wdt.c
> +++ b/drivers/watchdog/it8712f_wdt.c
> @@ -6,7 +6,7 @@
>   *
>   *	Based on info and code taken from:
>   *
> - *	drivers/char/watchdog/scx200_wdt.c
> + *	drivers/watchdog/scx200_wdt.c
>   *	drivers/hwmon/it87.c
>   *	IT8712F EC-LPC I/O Preliminary Specification 0.8.2
>   *	IT8712F EC-LPC I/O Preliminary Specification 0.9.3
> diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
> index 31b03fa71341..59369cf7f082 100644
> --- a/drivers/watchdog/ixp4xx_wdt.c
> +++ b/drivers/watchdog/ixp4xx_wdt.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * drivers/char/watchdog/ixp4xx_wdt.c
> + * drivers/watchdog/ixp4xx_wdt.c
>   *
>   * Watchdog driver for Intel IXP4xx network processors
>   *
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index 9e1541cfae0d..69349f1d0f34 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -1,5 +1,5 @@
>  /*
> - * drivers/char/watchdog/max63xx_wdt.c
> + * drivers/watchdog/max63xx_wdt.c
>   *
>   * Driver for max63{69,70,71,72,73,74} watchdog timers
>   *
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index e0ea133c1690..94d54247fcab 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * drivers/char/watchdog/pnx4008_wdt.c
> + * drivers/watchdog/pnx4008_wdt.c
>   *
>   * Watchdog driver for PNX4008 board
>   *
> diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
> index 7b5e18323f3f..77e630797572 100644
> --- a/drivers/watchdog/scx200_wdt.c
> +++ b/drivers/watchdog/scx200_wdt.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/* drivers/char/watchdog/scx200_wdt.c
> +/* drivers/watchdog/scx200_wdt.c
>  
>     National Semiconductor SCx200 Watchdog support
>  
