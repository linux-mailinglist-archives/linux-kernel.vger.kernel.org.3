Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E851503639
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiDPLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiDPLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD954A94F0;
        Sat, 16 Apr 2022 04:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6855560E73;
        Sat, 16 Apr 2022 11:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2194BC385A1;
        Sat, 16 Apr 2022 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650107350;
        bh=kh5r9cbB7fwoB+X+RIjkMvT5RGWxR4kbshMlqan9fhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eEq3+wV6ZmtU1ECpF0H34v3j6A5kWRBtjOivkYZityg9O95Bf/gFIvPVCXM7M1sHN
         64adcwBsroZiT5uD4Yjr0EE8W1/Xwr7mxQlvRgJANHlf3gbfiju3SjqlyPlTwCRWTA
         Vf+ldD7LL6s8nR0lpazmBhblR70biCs6j5PONRJDJYyw3WFjnCI2xtZ/061qdzODAI
         10yfTS9j6P1oeC81nrCl8yDWgJ710bVrLj+FqZwAhAwN7V5lqZCdNQIiOCWx6fZZjz
         vHyV/fqKxIl/pJmuu5nkog0G21SN+AcR9wSKLxIe04tehBPOcHopy018K3Xp7ScS8l
         RQRtPzVo8iX5w==
Date:   Sat, 16 Apr 2022 12:17:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: core: Convert to use firmware node handle
 instead of OF node
Message-ID: <20220416121708.37018ce9@jic23-huawei>
In-Reply-To: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
References: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 21:02:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Switch the IIO core to use firmware node handle instead of OF node.
> This will allow to get label from firmware on non-OF systems.
> 
> Note, this doesn't change of_iio_*() APIs for now.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at this and see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2f48e9a97274..ffbe76806e07 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1893,20 +1893,22 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	const char *label;
> +	struct fwnode_handle *fwnode;
>  	int ret;
>  
>  	if (!indio_dev->info)
>  		return -EINVAL;
>  
>  	iio_dev_opaque->driver_module = this_mod;
> -	/* If the calling driver did not initialize of_node, do it here */
> -	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
> -		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>  
> -	label = of_get_property(indio_dev->dev.of_node, "label", NULL);
> -	if (label)
> -		indio_dev->label = label;
> +	/* If the calling driver did not initialize firmware node, do it here */
> +	if (dev_fwnode(&indio_dev->dev))
> +		fwnode = dev_fwnode(&indio_dev->dev);
> +	else
> +		fwnode = dev_fwnode(indio_dev->dev.parent);
> +	device_set_node(&indio_dev->dev, fwnode);
> +
> +	fwnode_property_read_string(fwnode, "label", &indio_dev->label);
>  
>  	ret = iio_check_unique_scan_index(indio_dev);
>  	if (ret < 0)

