Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38764496D36
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiAVSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 13:07:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41324 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiAVSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 13:07:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E3F60E83;
        Sat, 22 Jan 2022 18:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F23C004E1;
        Sat, 22 Jan 2022 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642874847;
        bh=ed4KbG0a448WkbpZMG7EtToBILwDJdJNmhrkkL9oYHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dcybovW4OlYGu+qDAhf4CHjsnfKHuFl30wagBG4FIQGi+sP64xX8pL+20Hce7C1CA
         usRuCttijOh60IWec7d1SsAy5FmstJBUM1/e+1CUXm2dPaaj/KLc6FV+Et/3wx45S5
         4xGnsU6FH9uDYka3blYl78arRt8fOFDJe2JjT73ZU8pjVDmCAhzWfZMgYGc4p53heG
         1IEJ7ar3Mt9ABYgFFViySjJ3qBa8SCBHrKfsi+0F7N3WDhzOUcFhai4cQ8tERfOGfu
         G/ohHXPwSdxIyAPkyxUf8nqaFKU5wkhTBvJEtP72MKBEpy0NbARxIKDHzB2PhEOpnK
         z5Y+nuWBb8JrQ==
Date:   Sat, 22 Jan 2022 18:13:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: add padding to regmap for SPI
Message-ID: <20220122181336.61bed571@jic23-huawei>
In-Reply-To: <20220117074600.gmfonh35ptx6kqbs@skn-laptop.hadsten>
References: <20211220125144.3630539-1-sean@geanix.com>
        <20220117074600.gmfonh35ptx6kqbs@skn-laptop.hadsten>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 08:46:00 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Dec 20, 2021 at 01:51:43PM +0100, Sean Nyekjaer wrote:
> > Add missing don't care padding between address and
> > data for SPI transfers
> > 
> > Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/iio/accel/fxls8962af-core.c | 12 ++++++++++--
> >  drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
> >  drivers/iio/accel/fxls8962af-spi.c  |  2 +-
> >  drivers/iio/accel/fxls8962af.h      |  3 ++-
> >  4 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> > index 32989d91b982..f7fd9e046588 100644
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -173,12 +173,20 @@ struct fxls8962af_data {
> >  	u16 upper_thres;
> >  };
> >  
> > -const struct regmap_config fxls8962af_regmap_conf = {
> > +const struct regmap_config fxls8962af_i2c_regmap_conf = {
> >  	.reg_bits = 8,
> >  	.val_bits = 8,
> >  	.max_register = FXLS8962AF_MAX_REG,
> >  };
> > -EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
> > +EXPORT_SYMBOL_GPL(fxls8962af_i2c_regmap_conf);
> > +
> > +const struct regmap_config fxls8962af_spi_regmap_conf = {
> > +	.reg_bits = 8,
> > +	.pad_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = FXLS8962AF_MAX_REG,
> > +};
> > +EXPORT_SYMBOL_GPL(fxls8962af_spi_regmap_conf);
> >  
> >  enum {
> >  	fxls8962af_idx_x,
> > diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> > index cfb004b20455..6bde9891effb 100644
> > --- a/drivers/iio/accel/fxls8962af-i2c.c
> > +++ b/drivers/iio/accel/fxls8962af-i2c.c
> > @@ -18,7 +18,7 @@ static int fxls8962af_probe(struct i2c_client *client)
> >  {
> >  	struct regmap *regmap;
> >  
> > -	regmap = devm_regmap_init_i2c(client, &fxls8962af_regmap_conf);
> > +	regmap = devm_regmap_init_i2c(client, &fxls8962af_i2c_regmap_conf);
> >  	if (IS_ERR(regmap)) {
> >  		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> >  		return PTR_ERR(regmap);
> > diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
> > index 57108d3d480b..6f4dff3238d3 100644
> > --- a/drivers/iio/accel/fxls8962af-spi.c
> > +++ b/drivers/iio/accel/fxls8962af-spi.c
> > @@ -18,7 +18,7 @@ static int fxls8962af_probe(struct spi_device *spi)
> >  {
> >  	struct regmap *regmap;
> >  
> > -	regmap = devm_regmap_init_spi(spi, &fxls8962af_regmap_conf);
> > +	regmap = devm_regmap_init_spi(spi, &fxls8962af_spi_regmap_conf);
> >  	if (IS_ERR(regmap)) {
> >  		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
> >  		return PTR_ERR(regmap);
> > diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> > index b67572c3ef06..9cbe98c3ba9a 100644
> > --- a/drivers/iio/accel/fxls8962af.h
> > +++ b/drivers/iio/accel/fxls8962af.h
> > @@ -17,6 +17,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
> >  int fxls8962af_core_remove(struct device *dev);
> >  
> >  extern const struct dev_pm_ops fxls8962af_pm_ops;
> > -extern const struct regmap_config fxls8962af_regmap_conf;
> > +extern const struct regmap_config fxls8962af_i2c_regmap_conf;
> > +extern const struct regmap_config fxls8962af_spi_regmap_conf;
> >  
> >  #endif				/* _FXLS8962AF_H_ */
> > -- 
> > 2.34.1
> >   
> 
> Hi Jonathan,
> 
> Did you have time to look at this?

Sorry, saw it go by but bad timing wrt to opening of merge window
so it was still in my 'to apply' queue.

Anyhow, now done so and it is in the fixes-togreg branch of iio.git +
marked for stable.

Note I'll probably rebase that tree after rc1 though as we have a few
other fixes I'd like in the same pull request for stuff that only
went in this cycle.

Thanks,

Jonathan

> 
> /Sean

