Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C140459C948
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiHVTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiHVTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696E52DCF;
        Mon, 22 Aug 2022 12:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9549E61254;
        Mon, 22 Aug 2022 19:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0513CC433D6;
        Mon, 22 Aug 2022 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661197934;
        bh=ShFJ2TGJJbdMrkcEWhJxnGSDlE6UztbQu3XQLJxc21w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dxj/TJruxaMrzKSDsghLzrUeoAfCfmE4I8J88DF7Thecpek92MPwUPmcWcWRC79ec
         pB6F4uGMLA66pxSHA0EusRJ3By6cVpEHlBLJYhVf7appe+Luoq+X7eRCvaq2iKhuGQ
         5wV8ZjvRcgTi2dV2B8Vm/eBreLrSiwJ7X32rKi6fO+A/RPPmKI0lLa+Y/6VuSLFiAp
         CfKGamzm76RoD9QD0nkzgcW1TnPT6CM7VBT/mLv/snxUiGbevqq3gl2HT2wEK18h2e
         ZgITcAZtPxRjxLqhZ4xLBLoMqIsrRF2scdcykyxZxLWr2+kF0I6aNzI8Drqjzvuh6v
         J5cZItyUWnVEw==
Date:   Mon, 22 Aug 2022 20:17:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ciprian Regus <ciprian.regus@analog.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Message-ID: <20220822201745.1e09fee7@jic23-huawei>
In-Reply-To: <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
        <20220822125106.1106798-4-ciprian.regus@analog.com>
        <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 22 Aug 2022 16:08:12 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 8/22/22 14:51, Ciprian Regus wrote:
> > Set the iio device's name based on the chip used.  
> 
> While the change is correct it breaks the ABI. This needs a bit of a 
> better explanation what is being done, why, what are the potential 
> problems, why do we want to do it anyway.

+ it's a fix, so if we are doing this we need to enable backporting
by moving to first patch in series (obviously just for the
already supported parts).  

Jonathan

> 
> >
> > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> > ---
> >   drivers/iio/adc/ltc2496.c      | 1 +
> >   drivers/iio/adc/ltc2497-core.c | 2 +-
> >   drivers/iio/adc/ltc2497.c      | 2 ++
> >   drivers/iio/adc/ltc2497.h      | 1 +
> >   4 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> > index 98338104c24a..86470f49e8ca 100644
> > --- a/drivers/iio/adc/ltc2496.c
> > +++ b/drivers/iio/adc/ltc2496.c
> > @@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
> >   
> >   static struct chip_info ltc2496_info = {
> >   	.resolution = 16,
> > +	.name = "ltc2496"
> >   };
> >   
> >   static const struct of_device_id ltc2496_of_match[] = {
> > diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> > index b2752399402c..6dd9ab601904 100644
> > --- a/drivers/iio/adc/ltc2497-core.c
> > +++ b/drivers/iio/adc/ltc2497-core.c
> > @@ -169,7 +169,7 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
> >   	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
> >   	int ret;
> >   
> > -	indio_dev->name = dev_name(dev);
> > +	indio_dev->name = ddata->chip_info->name;
> >   	indio_dev->info = &ltc2497core_info;
> >   	indio_dev->modes = INDIO_DIRECT_MODE;
> >   	indio_dev->channels = ltc2497core_channel;
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index bb5e0d4301e2..a0aad71c8130 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -99,9 +99,11 @@ static int ltc2497_remove(struct i2c_client *client)
> >   static struct chip_info ltc2497_info[] = {
> >   	[TYPE_LTC2497] = {
> >   		.resolution = 16,
> > +		.name = "ltc2497"
> >   	},
> >   	[TYPE_LTC2499] = {
> >   		.resolution = 24,
> > +		.name = "ltc2499"
> >   	}
> >   };
> >   
> > diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> > index f4d939cfd48b..0e86e38248ee 100644
> > --- a/drivers/iio/adc/ltc2497.h
> > +++ b/drivers/iio/adc/ltc2497.h
> > @@ -12,6 +12,7 @@ enum chip_type {
> >   
> >   struct chip_info {
> >   	u32 resolution;
> > +	char *name;
> >   };
> >   
> >   struct ltc2497core_driverdata {  
> 
> 

