Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3553CE03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiFCRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbiFCRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:23:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212552B03;
        Fri,  3 Jun 2022 10:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2B87CE234C;
        Fri,  3 Jun 2022 17:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D75C385A9;
        Fri,  3 Jun 2022 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654277004;
        bh=IC0b4j9tRA7J2kGa80DzPEvWME4w+UNjiMU0VqZZJJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wlep1SZv7MhpG4ewG6PDQwTxXox7R54NkMKwVTHUs9F/YpWxQSMrNcBhb5qR7fWKi
         tC/KpeNV2nL1DA91vvJra1NnfUUa0wTqIa6K1nfkChUrcsybLGFucsvmPt57rNNxTE
         l2j73b8UPWVfT1KJz6Npk7ZlnR2NhOE9qz56PzoGgWr77t+sKWNObUpHzK0piB1JpF
         ubYhfiNTfoSafXa3wU9dJWfYK40KR8iYrXMMOKOvaNrpC2bo5oj5zzll0isNkCzgqx
         3T1t6C6Hyj8YipCj69a/hCr7TWaFxaXQE46FIBwKJ3VUBKLbWH1nB8nAGhq/jN961Z
         P06aZ/rk3o+Fw==
Date:   Fri, 3 Jun 2022 18:32:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Message-ID: <20220603183224.540b3808@jic23-huawei>
In-Reply-To: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
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

On Tue, 31 May 2022 17:11:17 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

These both seem good to me, but as the driver is fairly actively maintained,
I'll let this one sit on the list for a while so others can take a look.

Whilst it 'seems' unlikely anyone will ever use this driver with other firmware
I am keen to reduce the number of of-specific drivers in IIO just to avoid
any chance of cut and paste.

Who knows, I'm trying to run an aspeed-i2c driver with ACPI at the moment
because it's handy for a emulated setup, so maybe the same will one day happen
with this device :)  Weirder things have happened.

Jonathan


> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 39 ++++++++++++------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 823c8e5f9809..e883f95f0cda 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -17,10 +17,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/overflow.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  
> @@ -1182,14 +1183,13 @@ static const struct of_device_id xadc_of_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, xadc_of_match_table);
>  
> -static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
> -	unsigned int *conf, int irq)
> +static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>  {
>  	struct device *dev = indio_dev->dev.parent;
>  	struct xadc *xadc = iio_priv(indio_dev);
>  	const struct iio_chan_spec *channel_templates;
>  	struct iio_chan_spec *channels, *chan;
> -	struct device_node *chan_node, *child;
> +	struct fwnode_handle *chan_node, *child;
>  	unsigned int max_channels;
>  	unsigned int num_channels;
>  	const char *external_mux;
> @@ -1200,7 +1200,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  
>  	*conf = 0;
>  
> -	ret = of_property_read_string(np, "xlnx,external-mux", &external_mux);
> +	ret = device_property_read_string(dev, "xlnx,external-mux", &external_mux);
>  	if (ret < 0 || strcasecmp(external_mux, "none") == 0)
>  		xadc->external_mux_mode = XADC_EXTERNAL_MUX_NONE;
>  	else if (strcasecmp(external_mux, "single") == 0)
> @@ -1211,8 +1211,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  		return -EINVAL;
>  
>  	if (xadc->external_mux_mode != XADC_EXTERNAL_MUX_NONE) {
> -		ret = of_property_read_u32(np, "xlnx,external-mux-channel",
> -					&ext_mux_chan);
> +		ret = device_property_read_u32(dev, "xlnx,external-mux-channel", &ext_mux_chan);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -1247,19 +1246,19 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	num_channels = 9;
>  	chan = &channels[9];
>  
> -	chan_node = of_get_child_by_name(np, "xlnx,channels");
> +	chan_node = device_get_named_child_node(dev, "xlnx,channels");
>  	if (chan_node) {
> -		for_each_child_of_node(chan_node, child) {
> +		fwnode_for_each_child_node(chan_node, child) {
>  			if (num_channels >= max_channels) {
> -				of_node_put(child);
> +				fwnode_handle_put(child);
>  				break;
>  			}
>  
> -			ret = of_property_read_u32(child, "reg", &reg);
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
>  			if (ret || reg > 16)
>  				continue;
>  
> -			if (of_property_read_bool(child, "xlnx,bipolar"))
> +			if (fwnode_property_read_bool(child, "xlnx,bipolar"))
>  				chan->scan_type.sign = 's';
>  
>  			if (reg == 0) {
> @@ -1273,7 +1272,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  			chan++;
>  		}
>  	}
> -	of_node_put(chan_node);
> +	fwnode_handle_put(chan_node);
>  
>  	/* No IRQ => no events */
>  	if (irq <= 0) {
> @@ -1316,7 +1315,6 @@ static void xadc_cancel_delayed_work(void *data)
>  static int xadc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *id;
>  	const struct xadc_ops *ops;
>  	struct iio_dev *indio_dev;
>  	unsigned int bipolar_mask;
> @@ -1326,15 +1324,10 @@ static int xadc_probe(struct platform_device *pdev)
>  	int irq;
>  	int i;
>  
> -	if (!dev->of_node)
> -		return -ENODEV;
> -
> -	id = of_match_node(xadc_of_match_table, dev->of_node);
> -	if (!id)
> +	ops = device_get_match_data(dev);
> +	if (!ops)
>  		return -EINVAL;
>  
> -	ops = id->data;
> -
>  	irq = platform_get_irq_optional(pdev, 0);
>  	if (irq < 0 &&
>  	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
> @@ -1345,7 +1338,7 @@ static int xadc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	xadc = iio_priv(indio_dev);
> -	xadc->ops = id->data;
> +	xadc->ops = ops;
>  	init_completion(&xadc->completion);
>  	mutex_init(&xadc->mutex);
>  	spin_lock_init(&xadc->lock);
> @@ -1359,7 +1352,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &xadc_info;
>  
> -	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
> +	ret = xadc_parse_dt(indio_dev, &conf0, irq);
>  	if (ret)
>  		return ret;
>  

