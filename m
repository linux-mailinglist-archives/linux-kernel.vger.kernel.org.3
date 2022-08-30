Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA95A67E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiH3QH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiH3QHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:07:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F1F72F8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:07:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oT3mA-00071b-F1; Tue, 30 Aug 2022 18:07:42 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oT3m6-0004SO-0i; Tue, 30 Aug 2022 18:07:38 +0200
Date:   Tue, 30 Aug 2022 18:07:37 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: adc: tsc2046: silent spi_device_id warning
Message-ID: <20220830160737.GC16715@pengutronix.de>
References: <20220830110709.2037302-1-o.rempel@pengutronix.de>
 <20220830110709.2037302-3-o.rempel@pengutronix.de>
 <20220830140228.000013ca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830140228.000013ca@huawei.com>
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

On Tue, Aug 30, 2022 at 02:02:28PM +0100, Jonathan Cameron wrote:
> On Tue, 30 Aug 2022 13:07:09 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Add spi_device_id to silent following warning:
> >  SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/iio/adc/ti-tsc2046.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > index bbc8b4137b0b1..b9a1fac659d46 100644
> > --- a/drivers/iio/adc/ti-tsc2046.c
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -761,7 +761,15 @@ static int tsc2046_adc_probe(struct spi_device *spi)
> >  		return -EINVAL;
> >  	}
> >  
> > -	dcfg = device_get_match_data(dev);
> > +	if (!dev_fwnode(dev)) {
> > +		const struct spi_device_id *id;
> > +
> > +		id = spi_get_device_id(spi);
> > +		dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
> 
> Driver data not set below.

..facepalm..

> Otherwise this looks good to me.  An alternative more common form (I think...)
> is call device_get_match_data() unconditionally and if that is null follow
> the driver_data path. Either way is fine though.
> 
> Could you add to the patch description where
> the warning is coming from?   Build time / runtime etc and what tool?

ack. It is runtime warning in the kernel log.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
