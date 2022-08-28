Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA65A3EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiH1RuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH1RuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:50:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D2AE59;
        Sun, 28 Aug 2022 10:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52AC9CE0924;
        Sun, 28 Aug 2022 17:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7300EC433D6;
        Sun, 28 Aug 2022 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661709001;
        bh=n4c+Zs1RDtqEmf3PHYAX7fiNNaE9MPBLhz4hULHNWTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJMfmhAgtYnvEwlPAQ9InnckQiJCbIU7wBRF8qbMKiZkaJDM++SVRRsJs2+rHtUhO
         wwAS96OsuXxDxxg7V14qKzgxhWq2O1w7NPZj7OHkXNURWkJw1ePtUNlpQ7FhgRP26O
         0VzPy6N9LyxqE+Fmjz5gzvxuq8uEZ0Tjk4Smetstf8+Ce+Zp4vJmLYVaoAf1IqGdfw
         aWDNzBYVrcU2kIY5yz0LIA0b4xh4SXp31YjFRrG6QfhH7pU5oLCiWQ8PLmGbX3ipGm
         0mA/S5Ak7H6FdL2TABeXL5chswNIkvLezHvjhtGv0Kxrx9PsYBXqMkFUdUYBDmDD4a
         LaxOcHP37jBEQ==
Date:   Sun, 28 Aug 2022 18:15:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>, axel.jonsson@axis.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
Message-ID: <20220828181539.12dfd21e@jic23-huawei>
In-Reply-To: <CAHp75Vda3bbsRw+mftXjrH445UqSkxcB7q9kXUc+-ODUE+VQ9g@mail.gmail.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
        <20220824104002.2749075-3-vincent.whitchurch@axis.com>
        <CAHp75Vda3bbsRw+mftXjrH445UqSkxcB7q9kXUc+-ODUE+VQ9g@mail.gmail.com>
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

On Thu, 25 Aug 2022 23:06:01 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > From: Axel Jonsson <axel.jonsson@axis.com>
> >
> > Add support for triggered buffers.  Just read the channels in a loop to
> > keep things simple.  
> 
> ...
> 
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>  
> 
> Ordering?
> 
> But honestly, I prefer the linux/iio/* to be split in a separate group...
> 
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  #include <linux/regulator/consumer.h>
> >  
> 
> ...and be put here.
> 
> ...
> 
> > +       device_index = spi_get_device_id(adc->spi)->driver_data;  
> 
> Hmm... Wondering if this can be derived from channel number or alike.
> 
It is weirder than the name implies. 
Seem device_index is actually the chip type from amongst those the driver
supports.

That wants cleaning up, particularly there is also a chip_info structure.
Various ways of doing it, but simplest is probably a set of callbacks
covering the different data extraction methods in mcp320x_adc_conversion.

Jonathan


