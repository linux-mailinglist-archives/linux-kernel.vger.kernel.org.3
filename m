Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4124B3C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiBMQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:12:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiBMQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:12:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A865A0A8;
        Sun, 13 Feb 2022 08:12:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB351B80834;
        Sun, 13 Feb 2022 16:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4851C004E1;
        Sun, 13 Feb 2022 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644768764;
        bh=xuzW8T29+w7g8JagA3TMyDQ1UmWgTd03J+GMDiLQGwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cHbJNkM50FzjoLscJbsUxxL1q1uLtVlzah3NiZCkp+uXMvq8Dy4h6H5G2dhDmm9yi
         ZcBsAX6537lJ3ZuIpuJEs/816WvdLlPC4yw7eyJ8YT1yVasxSydytpsSAyKgCsesGA
         0LQQ1bE56i4YuGNnLw1Z3vc50IqL/oIjxBP+0I8WUyjKW7y8QHB6/gzMTWgYlNw0YC
         hxd0Q60j26/JF6UTehrvZubIfWAVydPIrm2+PLX+tKyTysM0UJamRdXp7vwhNfiwTf
         aELbwTeB6U3YJFxufuKdvCT6XmS7PzZPIJXHrnCurgFH5ZnOY0kqtgnJ8SYlqAbUOl
         Pis2SPmsjiMrQ==
Date:   Sun, 13 Feb 2022 16:19:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: as3935: Use devm_delayed_work_autocancel()
Message-ID: <20220213161922.2f2bd797@jic23-huawei>
In-Reply-To: <8d5c50f191bd8f751849d72127f83b14a7636d64.1644755396.git.christophe.jaillet@wanadoo.fr>
References: <8d5c50f191bd8f751849d72127f83b14a7636d64.1644755396.git.christophe.jaillet@wanadoo.fr>
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

On Sun, 13 Feb 2022 13:30:11 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use devm_delayed_work_autocancel() instead of hand writing it.
> It saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Nice.

+CC Matt as it's his driver. As this is an obvious like for like replacement
I'll apply it now.

Applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilders see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/as3935.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index bd7595db31d4..00e06491b188 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
> @@ -344,14 +345,6 @@ static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
>  #define AS3935_PM_OPS NULL
>  #endif
>  
> -static void as3935_stop_work(void *data)
> -{
> -	struct iio_dev *indio_dev = data;
> -	struct as3935_state *st = iio_priv(indio_dev);
> -
> -	cancel_delayed_work_sync(&st->work);
> -}
> -
>  static int as3935_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -432,8 +425,7 @@ static int as3935_probe(struct spi_device *spi)
>  
>  	calibrate_as3935(st);
>  
> -	INIT_DELAYED_WORK(&st->work, as3935_event_work);
> -	ret = devm_add_action(dev, as3935_stop_work, indio_dev);
> +	ret = devm_delayed_work_autocancel(dev, &st->work, as3935_event_work);
>  	if (ret)
>  		return ret;
>  

