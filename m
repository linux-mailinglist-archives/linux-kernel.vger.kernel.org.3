Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486E04C5AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiB0LUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiB0LUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3D5D674;
        Sun, 27 Feb 2022 03:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C998B80B64;
        Sun, 27 Feb 2022 11:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B636C340F2;
        Sun, 27 Feb 2022 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645960801;
        bh=eYEYj3LCbRQgLsMnc9U2IzhepWtapdC044bPpW77J5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o0bKcIh9uKkUYadq6kTl8O4uwA4dOxE59TkV0SnBNlSvENdpZeaMTiBK9WR65SAYr
         cMUv70YdDx9IXXAK9PdFvOEN9Q72a8NoI5Cz9ha0e0aBAUFZBPAqmcOEJVfEOhIOsd
         yq+kpnZfYzrTUMoEfgdyS6GX/+TxdbMZAKXfW63kS3PbENpXHczEmb/stCM51aM2v/
         wmsFLlHzPRC8FhVlrctXWIMtSnSigmuKqlIbp9Mg6VYiGKZW6QCEWN7WmhkmzxbvSn
         p403DJ0J547oD+lFAgeimLVWCF5JzYlabHCa8XyN2Kfxiaj8dm7qe1V/nwGkl+p5xq
         6ZqtxGG3oD/Zg==
Date:   Sun, 27 Feb 2022 11:27:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Message-ID: <20220227112705.3c2b2870@jic23-huawei>
In-Reply-To: <6df069a3-939d-21be-ed17-bc9e9d20cffc@axentia.se>
References: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
        <6df069a3-939d-21be-ed17-bc9e9d20cffc@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 03:28:15 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> Sorry for the late reply.
> 
> On 2022-02-02 21:44, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: dropped depends on OF
> >  drivers/iio/multiplexer/Kconfig   |  1 -
> >  drivers/iio/multiplexer/iio-mux.c | 48 ++++++++++++++-----------------
> >  2 files changed, 22 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/multiplexer/Kconfig
> > index a1e1332d1206..928f424a1ed3 100644
> > --- a/drivers/iio/multiplexer/Kconfig
> > +++ b/drivers/iio/multiplexer/Kconfig
> > @@ -9,7 +9,6 @@ menu "Multiplexers"
> >  config IIO_MUX
> >  	tristate "IIO multiplexer driver"
> >  	select MULTIPLEXER
> > -	depends on OF || COMPILE_TEST
> >  	help
> >  	  Say yes here to build support for the IIO multiplexer.
> >  
> > diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> > index f422d44377df..e6f0fef96494 100644
> > --- a/drivers/iio/multiplexer/iio-mux.c
> > +++ b/drivers/iio/multiplexer/iio-mux.c
> > @@ -10,11 +10,12 @@
> >  #include <linux/err.h>
> >  #include <linux/iio/consumer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/mux/consumer.h>
> > -#include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  
> >  struct mux_ext_info_cache {
> >  	char *data;
> > @@ -324,37 +325,20 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Same as of_property_for_each_string(), but also keeps track of the
> > - * index of each string.
> > - */
> > -#define of_property_for_each_string_index(np, propname, prop, s, i)	\
> > -	for (prop = of_find_property(np, propname, NULL),		\
> > -	     s = of_prop_next_string(prop, NULL),			\
> > -	     i = 0;							\
> > -	     s;								\
> > -	     s = of_prop_next_string(prop, s),				\
> > -	     i++)
> > -
> >  static int mux_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct device_node *np = pdev->dev.of_node;
> >  	struct iio_dev *indio_dev;
> >  	struct iio_channel *parent;
> >  	struct mux *mux;
> > -	struct property *prop;
> > -	const char *label;
> > +	const char **labels;
> >  	u32 state;
> > +	int children, all_children;  
> 
> I dislike that the pattern with one declaration per line is broken here.
> There are perhaps a few too many variables, but introducing one instance
> of two declarations on one line is disturbing for me.
> 
> So, with that fixed,
> 
> Acked-by: Peter Rosin <peda@axentia.se>
> 
> >  	int sizeof_ext_info;
> > -	int children;
> >  	int sizeof_priv;
> >  	int i;
> >  	int ret;
> >  
> > -	if (!np)
> > -		return -ENODEV;
> > -
> >  	parent = devm_iio_channel_get(dev, "parent");
> >  	if (IS_ERR(parent))
> >  		return dev_err_probe(dev, PTR_ERR(parent),
> > @@ -366,9 +350,21 @@ static int mux_probe(struct platform_device *pdev)
> >  		sizeof_ext_info *= sizeof(*mux->ext_info);
> >  	}
> >  
> > +	all_children = device_property_count_string_array(dev, "channels");
> > +	if (all_children < 0)
> > +		return all_children;

Function seems to be called device_property_string_array_count() so this will need
a v3 anyway as it doesn't currently build.

Thanks,

Jonathan



> > +
> > +	labels = devm_kmalloc_array(dev, all_children, sizeof(char *), GFP_KERNEL);  
> 
> I'm a bit sad to see the copy of the labels array. No big deal,
> but it seems inelegant. But the of_property_for_each_string_index
> macro was also misplaced and therefore inelegant. My guess is
> that the device properties should be fairly static and that the
> copy is a waste?
> 
> So, anyway, I'm just whining here, and the labels copy is ok.
> 
> Cheers,
> Peter
> 
> > +	if (!labels)
> > +		return -ENOMEM;
> > +
> > +	ret = device_property_read_string_array(dev, "channels", labels, all_children);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	children = 0;
> > -	of_property_for_each_string(np, "channels", prop, label) {
> > -		if (*label)
> > +	for (state = 0; state < all_children; state++) {
> > +		if (*labels[state])
> >  			children++;
> >  	}
> >  	if (children <= 0) {
> > @@ -395,7 +391,7 @@ static int mux_probe(struct platform_device *pdev)
> >  	mux->cached_state = -1;
> >  
> >  	mux->delay_us = 0;
> > -	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
> > +	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
> >  
> >  	indio_dev->name = dev_name(dev);
> >  	indio_dev->info = &mux_info;
> > @@ -426,11 +422,11 @@ static int mux_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	i = 0;
> > -	of_property_for_each_string_index(np, "channels", prop, label, state) {
> > -		if (!*label)
> > +	for (state = 0; state < all_children; state++) {
> > +		if (!*labels[state])
> >  			continue;
> >  
> > -		ret = mux_configure_channel(dev, mux, state, label, i++);
> > +		ret = mux_configure_channel(dev, mux, state, labels[state], i++);
> >  		if (ret < 0)
> >  			return ret;
> >  	}  

