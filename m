Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D900468627
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355228AbhLDQVn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Dec 2021 11:21:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbhLDQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:21:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F36B80CFF;
        Sat,  4 Dec 2021 16:18:15 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D2EB8C341C0;
        Sat,  4 Dec 2021 16:18:10 +0000 (UTC)
Date:   Sat, 4 Dec 2021 16:23:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio:dac:ad7293: add support for AD7293
Message-ID: <20211204162252.66e62306@jic23-huawei>
In-Reply-To: <20211203022204.GA12289@chq-T47>
References: <20211202150819.24832-1-antoniu.miclaus@analog.com>
        <20211203022204.GA12289@chq-T47>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 10:22:04 +0800
Cai Huoqing <cai.huoqing@linux.dev> wrote:

> On 02 12月 21 17:08:18, Antoniu Miclaus wrote:
> > The AD7293 is a Power Amplifier drain current controller
> > containing functionality for general-purpose monitoring
> > and control of current, voltage, and temperature, integrated
> > into a single chip solution with an SPI-compatible interface.
> > 
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

I've made a bunch of white space tweaks whilst applying this.
A few things to keep in mind for future submissions.

1) Whilst the rule is 100 chars per line, 80 chars is preferred where it
   doesn't hurt readability.
2) Don't do this pattern.
	betty(x, y, z, fred +
	      wilma, barny)

If you have to break fred + wilma, then

	betty(x, y, z,
	      fred +
	      wilma,
	      barny);

is more readable in my view.


Otherwise endian issue in your debugfs functions.  Don't cast pointers like
that...

Please sanity check the changes I made and shout if I messed anything up.

Applied to the togreg branch of iio.git but pushed out as testing first to see
if 0-day finds anything we missed.




> > ---


> > +
> > +static int ad7293_reg_access(struct iio_dev *indio_dev,
> > +			     unsigned int reg,
> > +			     unsigned int write_val,
> > +			     unsigned int *read_val)
> > +{
> > +	struct ad7293_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (read_val)
> > +		ret = ad7293_spi_read(st, reg, (u16 *)read_val);

This only works on little endian platforms...
Think about where the data ends up on a big endian platform.

I've added a local variable to fix this.

> > +	else
> > +		ret = ad7293_spi_write(st, reg, (u16)write_val);


Jonathan
