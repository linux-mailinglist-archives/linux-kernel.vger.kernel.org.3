Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003465A9615
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiIALxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiIALxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:53:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F14B499
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:53:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oTil8-0001z1-W1; Thu, 01 Sep 2022 13:53:22 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oTil6-0004PT-J1; Thu, 01 Sep 2022 13:53:20 +0200
Date:   Thu, 1 Sep 2022 13:53:20 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: tsc2046: add vref support
Message-ID: <20220901115320.GD2479@pengutronix.de>
References: <20220901041146.3652287-1-o.rempel@pengutronix.de>
 <20220901041146.3652287-2-o.rempel@pengutronix.de>
 <20220901124549.00002287@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901124549.00002287@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:45:49PM +0100, Jonathan Cameron wrote:
> On Thu, 1 Sep 2022 06:11:45 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > If VREF pin is attached, we should use external VREF source instead of
> > the internal. Otherwise we will get wrong measurements on some of channel
> > types.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Hi Oleksij,
> 
> I'm not sure why I didn't review this patch in v1...
> 
> Anyhow, some comments below.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ti-tsc2046.c | 64 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 55 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > index 0d9436a69cbfb..bbc8b4137b0b1 100644
> > --- a/drivers/iio/adc/ti-tsc2046.c
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> >  
> >  #include <asm/unaligned.h>
> > @@ -175,6 +176,9 @@ struct tsc2046_adc_priv {
> >  	u32 time_per_bit_ns;
> >  
> >  	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
> > +	bool use_internal_vref;
> > +	unsigned int vref_mv;
> > +	struct regulator *vref_reg;
> >  };
> >  
> >  #define TI_TSC2046_V_CHAN(index, bits, name)			\
> > @@ -252,7 +256,9 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
> >  	case TI_TSC2046_ADDR_AUX:
> >  	case TI_TSC2046_ADDR_VBAT:
> >  	case TI_TSC2046_ADDR_TEMP0:
> > -		pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
> > +		pd |= TI_TSC2046_SER;
> > +		if (priv->use_internal_vref)
> > +			pd |= TI_TSC2046_PD1_VREF_ON;
> >  	}
> >  
> >  	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
> > @@ -468,7 +474,7 @@ static int tsc2046_adc_read_raw(struct iio_dev *indio_dev,
> >  		 * So, it is better to use external voltage-divider driver
> >  		 * instead, which is calculating complete chain.
> >  		 */
> > -		*val = TI_TSC2046_INT_VREF;
> > +		*val = priv->vref_mv;
> >  		*val2 = chan->scan_type.realbits;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	}
> > @@ -781,22 +787,42 @@ static int tsc2046_adc_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = dcfg->num_channels;
> >  	indio_dev->info = &tsc2046_adc_info;
> >  
> > +	priv->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
> > +	if (!IS_ERR(priv->vref_reg)) {
> > +		ret = regulator_enable(priv->vref_reg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = regulator_get_voltage(priv->vref_reg);
> > +		if (ret < 0)
> > +			goto err_regulator_disable;
> 
> Whilst regulators voltages of references rarely change at runtime
> they are allowed to, so it is logically better to query the
> voltage at the point of use. Requests for scale should be
> rare (unless there is a consumer that keeps querying this?)
> so the slightly overhead there
> shouldn't matter.

The voltage scale is related to actual adc measurements. If it variates,
we will have different scale of challenges.

> > +
> > +		priv->vref_mv = ret / 1000;
> > +		priv->use_internal_vref = false;
> > +	} else {
> > +		/* Use internal reference */
> > +		priv->vref_mv = TI_TSC2046_INT_VREF;
> > +		priv->use_internal_vref = true;
> > +	}
> > +
> >  	tsc2046_adc_parse_fwnode(priv);
> >  
> >  	ret = tsc2046_adc_setup_spi_msg(priv);
> >  	if (ret)
> > -		return ret;
> > +		goto err_regulator_disable;
> >  
> >  	mutex_init(&priv->slock);
> >  
> >  	ret = devm_request_irq(dev, spi->irq, &tsc2046_adc_irq,
> >  			       IRQF_NO_AUTOEN, indio_dev->name, indio_dev);
> >  	if (ret)
> > -		return ret;
> > +		goto err_regulator_disable;
> >  
> >  	trig = devm_iio_trigger_alloc(dev, "touchscreen-%s", indio_dev->name);
> > -	if (!trig)
> > -		return -ENOMEM;
> > +	if (!trig) {
> > +		ret = -ENOMEM;
> > +		goto err_regulator_disable;
> > +	}
> >  
> >  	priv->trig = trig;
> >  	iio_trigger_set_drvdata(trig, indio_dev);
> > @@ -811,20 +837,39 @@ static int tsc2046_adc_probe(struct spi_device *spi)
> >  	ret = devm_iio_trigger_register(dev, trig);
> >  	if (ret) {
> >  		dev_err(dev, "failed to register trigger\n");
> > -		return ret;
> > +		goto err_regulator_disable;
> 
> Please don't mix devm and non devm calls. It makes it much harder to reason about
> the correctness of ordering.
> Use devm_add_action_or_reset() to register a callback to disable the
> vref regulator.
> 
> Alternative is back out the devm_ based registration of everything after
> the regulator enable.

ok.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
