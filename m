Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724EA55A975
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiFYLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiFYLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:36:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBF165AD;
        Sat, 25 Jun 2022 04:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BDBAB8068F;
        Sat, 25 Jun 2022 11:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C898C3411C;
        Sat, 25 Jun 2022 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656156970;
        bh=Eqfq1nB5/JJaYIJeFfnkIEtpwZLZgoHl3No6eg+VrCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kxRleohwbgUyVMJTAxSpZtKvYDqyOFt/s/dpRCdQ3fcc/Qm+o4vwxHzvcB2Aiu03Y
         4SxL7ZQzeQZ/3nXdy30XhOAqjyzKuKq7bVOudkpnuTcPpxi7CXtexwivXem4LlSgVf
         jialgac4ueDMnqB8AvG8PSHxxwkG4wzQMa87y3Jj31zN1jJ/9ElGiIt+RFNqxVtJKe
         Tf4E13hWpUqGjrXWuKE0QNNWs/duCnOhIj7B+WA/bGA4D34tZ+alQTKKzrrfAG8WDk
         KqnC/5pT7di72bs0qY5lWC5onYVGPRpWRzEf+e4itJYFsIVLGxDFIcVMVhMiO3WQO+
         227gJABoQjtuw==
Date:   Sat, 25 Jun 2022 12:45:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: adc: mcp3911: add support for buffers
Message-ID: <20220625124537.163bf426@jic23-huawei>
In-Reply-To: <20220625103853.2470346-3-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-3-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:46 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add support for buffers to make the driver fit for more usecases.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

Good to see this feature.  A few comments inline, mostly around
optimising the data flow / device accesses.

Thanks,

Jonathan

> ---
> 
> Notes:
>     v2:
>         - No changes
> 
>  drivers/iio/adc/mcp3911.c | 58 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 25a235cce56c..2a4bf374f140 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -9,6 +9,10 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
> @@ -54,6 +58,10 @@ struct mcp3911 {
>  	struct regulator *vref;
>  	struct clk *clki;
>  	u32 dev_addr;
> +	struct {
> +		u32 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> @@ -187,16 +195,58 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = idx,					\
> +		.scan_index = idx,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 24,				\
> +			.storagebits = 32,			\
> +		},						\
>  }
>  
>  static const struct iio_chan_spec mcp3911_channels[] = {
>  	MCP3911_CHAN(0),
>  	MCP3911_CHAN(1),
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mcp3911 *adc = iio_priv(indio_dev);
> +	int scan_index;
> +	int i = 0;
> +	u32 val;
> +
> +	mutex_lock(&adc->lock);
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan =
> +			&indio_dev->channels[scan_index];
> +		int ret = mcp3911_read(adc,
> +				MCP3911_CHANNEL(scan_chan->channel), &val, 3);

I was a bit surprised not to see some overlap of address setting and
read out here if both channels are enabled, so opened up the data sheet.

Can we take advantage of "Continuous communication looping on address set"
(6.7 on the datasheet).  Also for buffered capture we'd normally make
things like shifting and endian conversion a userspace problem.  Can we
not do that here for some reason?  You'd need to take care to ensure
any buffers that might be used directly for DMA obey DMA safety rules
(currently avoided by using spi_write_then_read), but it would be
nice to do less data manipulation int his path if we can.



> +
> +		if (ret < 0) {
> +			dev_warn(&adc->spi->dev,
> +					"failed to get conversion data\n");
> +			goto out;
> +		}
> +
> +		adc->scan.channels[i] = val;
> +		i++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
> +			iio_get_time_ns(indio_dev));  
> +out:
> +	mutex_unlock(&adc->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info mcp3911_info = {
>  	.read_raw = mcp3911_read_raw,
>  	.write_raw = mcp3911_write_raw,
> @@ -303,7 +353,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  		goto clk_disable;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

The core sets INDIO_BUFFER_TRIGGERED as part of devm_iio_triggered_buffer_setup()
so you need to set DIRECT_MODE here (that one isn't visible to the core)

>  	indio_dev->info = &mcp3911_info;
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -312,6 +362,12 @@ static int mcp3911_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
Can't use devm here for the same reason it was inappropriate in patch 2.

I'd suggest a precursor patch(es) to move the driver fully over to
devm_ managed such that you don't need a remove function and the ordering
is maintained.
> +			NULL,
> +			mcp3911_trigger_handler, NULL);
> +	if (ret)
> +		goto clk_disable;
> +
>  	ret = devm_iio_device_register(&adc->spi->dev, indio_dev);
>  	if (ret)
>  		goto clk_disable;

