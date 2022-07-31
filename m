Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02E0585FEB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiGaQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGaQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BED60EE;
        Sun, 31 Jul 2022 09:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3C560F5F;
        Sun, 31 Jul 2022 16:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14789C433D6;
        Sun, 31 Jul 2022 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659285729;
        bh=FN1FeRRKXEtihsMgozwQ7+8M7oAV8pcnlJSWByizBMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UfWhOf5FZI2vaxYB4S+34DX9TwX+nSJnyi0QOP2R13sYyH1yCUgelUlnB4bGoGRWm
         yc42AV5RQ5B8fscvKKAWuny40QjyFh0YK4dr0ogUvF31r/xxlbfCY2wPRORbCHg2K+
         /ulD476jdYkoX7CI5TYgGjIRhoxSIov0otqIpgopjJzmwm7GDGakmiXRI0nFoWxQML
         5qlNN2HJiMA4X7pBenMbv2degU3i3Qa77JlG4ALfFS0PtCtRk2k4kmH7jTja8oEzbC
         R9q/QLnJPJE698Y6kCU8opVgFMC9hyGyY0ZK74/oTo+sBLtSB8Vq7WhhZ1Lf8vTMnG
         DPt3EtOCPklAw==
Date:   Sun, 31 Jul 2022 17:52:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] iio: adc: mcp3911: add support for interrupts
Message-ID: <20220731175221.4adbbfa6@jic23-huawei>
In-Reply-To: <20220722130726.7627-7-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
        <20220722130726.7627-7-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:07:23 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Make it possible to read values upon interrupts.
> Configure Data Ready Signal Output Pin to either HiZ or push-pull and
> use it as interrupt source.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Looks good to me.

J

> ---
>  drivers/iio/adc/mcp3911.c | 53 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 96c0a2a50c7c..7db2c75da4ac 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -29,6 +29,7 @@
>  #define MCP3911_REG_GAIN		0x09
>  
>  #define MCP3911_REG_STATUSCOM		0x0a
> +#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
>  #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
>  #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
>  #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> @@ -62,6 +63,7 @@ struct mcp3911 {
>  	struct regulator *vref;
>  	struct clk *clki;
>  	u32 dev_addr;
> +	struct iio_trigger *trig;
>  	struct {
>  		u32 channels[MCP3911_NUM_CHANNELS];
>  		s64 ts __aligned(8);
> @@ -346,6 +348,23 @@ static void mcp3911_cleanup_regulator(void *_adc)
>  	regulator_disable(adc->vref);
>  }
>  
> +static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +	struct mcp3911 *adc = iio_trigger_get_drvdata(trig);
> +
> +	if (enable)
> +		enable_irq(adc->spi->irq);
> +	else
> +		disable_irq(adc->spi->irq);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops mcp3911_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +	.set_trigger_state = mcp3911_set_trigger_state,
> +};
> +
>  static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -409,6 +428,15 @@ static int mcp3911_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
> +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +				0, 2);
> +	else
> +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +				MCP3911_STATUSCOM_DRHIZ, 2);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mcp3911_info;
> @@ -419,6 +447,31 @@ static int mcp3911_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> +	if (spi->irq > 0) {
> +		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +				indio_dev->name,
> +				iio_device_id(indio_dev));
> +		if (!adc->trig)
> +			return PTR_ERR(adc->trig);
> +
> +		adc->trig->ops = &mcp3911_trigger_ops;
> +		iio_trigger_set_drvdata(adc->trig, adc);
> +		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * The device generates interrupts as long as it is powered up.
> +		 * Some platforms might not allow the option to power it down so
> +		 * don't enable the interrupt to avoid extra load on the system.
> +		 */
> +		ret = devm_request_irq(&spi->dev, spi->irq,
> +				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
> +				indio_dev->name, adc->trig);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>  			NULL,
>  			mcp3911_trigger_handler, NULL);

