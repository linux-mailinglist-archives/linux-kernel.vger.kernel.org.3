Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EEF503606
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiDPKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiDPKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EB2DA9D;
        Sat, 16 Apr 2022 03:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F24660EAE;
        Sat, 16 Apr 2022 10:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDB2C385A1;
        Sat, 16 Apr 2022 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650106247;
        bh=RkB4upXvMfxDGFkSumlo2MiPEu9CpWUwg3tw+DZmoGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3hXolKKzF+4UV49YK/QRUPRjCXqtbpPxgpJ2zDGQ3Ho/DEAciItTNbrv18gCLPLC
         cv4SI9lk/df6HiVqJ4Tw9FBlItBWr8Rcf+hqotAR4De+izxzfcEA5uO1TlB/rzpe0c
         Ygd28Z3uWZqNeDlEqkhr1LVAvgAQaXgnDwpjkRqvTX9AwMgNZQc/3yRqtj05Mnjggi
         1MRgJ/eTqM97UXm/egHMXINhgeDiFfdLAdZIJ+uwqD6XXLXbiK3yW+klCekD14i2fW
         txqhHnzN7dycEKE65G8adbfarjHE9NE+DvnfO9g3pmYrRYgqw3aBocnicQ3ltJNgzU
         G7+H555PzeCoA==
Date:   Sat, 16 Apr 2022 11:58:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: ping: Replace OF specific code
 by device_get_match_data()
Message-ID: <20220416115846.4f6be506@jic23-huawei>
In-Reply-To: <20220413183421.20427-1-andriy.shevchenko@linux.intel.com>
References: <20220413183421.20427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 13 Apr 2022 21:34:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of calling the OF specific API, use device_get_match_data().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/ping.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index 24a97d41e115..d56e037378de 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -29,9 +29,8 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/sched.h>
> @@ -288,7 +287,7 @@ static int ping_probe(struct platform_device *pdev)
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = dev;
> -	data->cfg = of_device_get_match_data(dev);
> +	data->cfg = device_get_match_data(dev);
>  
>  	mutex_init(&data->lock);
>  	init_completion(&data->rising);

