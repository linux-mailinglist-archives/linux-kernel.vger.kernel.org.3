Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB014503620
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiDPLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiDPLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:02:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4655A146;
        Sat, 16 Apr 2022 03:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F067CB80687;
        Sat, 16 Apr 2022 10:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F3C385A1;
        Sat, 16 Apr 2022 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650106768;
        bh=sibJV/RKG56aZPeMc2C4JBMgg/l3MOrABmFndh0H3Po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GXQGfM+K4pX4aqbmQXpchU0gvK4qvcXc+m/kkubMvS4D+QBjxSO8aIxofIJ9ic51y
         kTF45RY3p0CCo2Kz7YFPo/gmvORuKH4QaAissW3qQvc288rHQfOCjBIt+vagmB+wb0
         02KmXXZgv3NuD5Fg+aZZyv9TeCaq0FoE4COHrur9FZoLHGTnsjBUIx7X/dLvW7adC7
         A3ZuqwzxuO9p6bQBX30S37NXdWSA2gelq4WJDHZLxwwk3jnDPLmIkjeMvKAB5PfKzC
         7TtXZilo33K8ZrKHSHhh5n4ciXD4m1gN9E9QJ4ZDLHLFgv30IqCqK/epFe2mM1SpK+
         yUMt6Lh4yEosA==
Date:   Sat, 16 Apr 2022 12:07:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: mb1232: Switch to use
 fwnode_irq_get()
Message-ID: <20220416120726.0ba78960@jic23-huawei>
In-Reply-To: <20220413183123.20292-1-andriy.shevchenko@linux.intel.com>
References: <20220413183123.20292-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 21:31:23 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> We have OF-centric variant of fwnode_irq_get() in the driver.
> Replace it with a call to an agnostic implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Whilst I 'think' this ends up being functionally identical
I'd like to leave it a little longer to see if Andreas has
time to take a look and verify this change is fine.

There seem to be subtle differences in the irq setup as the
new code does a sanity check on the domain being available
and defers if not which I don't think happens with the
existing code.

Thanks,

Jonathan


> ---
>  drivers/iio/proximity/mb1232.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> index ad4b1fb2607a..0bca5f74de68 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -10,12 +10,14 @@
>   * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/of_irq.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/bitops.h>
> +#include <linux/property.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -209,7 +211,7 @@ static int mb1232_probe(struct i2c_client *client,
>  
>  	init_completion(&data->ranging);
>  
> -	data->irqnr = irq_of_parse_and_map(dev->of_node, 0);
> +	data->irqnr = fwnode_irq_get(dev_fwnode(&client->dev), 0);
>  	if (data->irqnr <= 0) {
>  		/* usage of interrupt is optional */
>  		data->irqnr = -1;

