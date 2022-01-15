Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1348F896
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiAOSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiAOSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:06:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E2C061574;
        Sat, 15 Jan 2022 10:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3E660EE6;
        Sat, 15 Jan 2022 18:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0516CC36AE5;
        Sat, 15 Jan 2022 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642269961;
        bh=3NCsbltn2VNl6BzDPPc4Nq1K5dUg7nI/HG6wnmIgY+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OnWlvXYtrHm8ajgKrq4HrkwkEyFbpYg/a+OtSu/g4oGdVLFUWFoTfByCnnR/RTG1K
         LOHe6F6x6x/MmzC5uSxo6YsxzcZ8T61cpR/vVCxDT48zAfauJRDlnMFO19RU5nLRB1
         HIu/CK+dW0OAiwLRZSiu+kLDfaZPe9KV+GDYSY3RV+qFV6/LgJUWYzpzYwVLLPLCqz
         Fk/7COhMapazdHXX4lIvFObffW2sO6lgATm7OAFQqDRW48lgCgDE/f/TfyY7gV8GgH
         BeEeqiIXhN6ZGjhiD6h34ASaGl1V4qqqo5i3i5s48a4awgZOqGFbCyRXXF2mTD/WVy
         QX6Dw4iDI7QIA==
Date:   Sat, 15 Jan 2022 18:12:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] iio: addac: Do not reference negative array offsets
Message-ID: <20220115181202.476f09eb@jic23-huawei>
In-Reply-To: <b87576f4e44e459bba4d3bd3c0b38693@analog.com>
References: <20220105180214.2435001-1-keescook@chromium.org>
        <b87576f4e44e459bba4d3bd3c0b38693@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 06:31:55 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Put "iio: addac: ad74413r:" in patch title, maybe?
I can fix that up whilst applying.

I'll pick this up after rc1 is out.

Thanks,

Jonathan

> 
> > -----Original Message-----
> > From: Kees Cook <keescook@chromium.org>
> > Sent: Wednesday, January 5, 2022 8:02 PM
> > To: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Kees Cook <keescook@chromium.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Tanislav, Cosmin
> > <Cosmin.Tanislav@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> > linux-iio@vger.kernel.org; Linus Walleij <linus.walleij@linaro.org>; linux-
> > kernel@vger.kernel.org; linux-hardening@vger.kernel.org
> > Subject: [PATCH v2] iio: addac: Do not reference negative array offsets
> > 
> > [External]
> > 
> > Instead of aiming rx_buf at an invalid array-boundary-crossing location,
> > just skip the first increment. Fixes this warning seen when building
> > with -Warray-bounds:
> > 
> > drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
> > drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below
> > array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
> >   843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> > AD74413R_FRAME_SIZE];
> >       |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
> >    84 |                 u8 rx_buf[AD74413R_FRAME_SIZE *
> > AD74413R_CHANNEL_MAX];
> >       |                    ^~~~~~
> > 
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org
> > Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1:
> > https://urldefense.com/v3/__https://lore.kernel.org/lkml/20211215232321.
> > 2069314-1-
> > keescook@chromium.org/__;!!A3Ni8CS0y2Y!vadcwdERjyNVz3vFIp5m5S2ms
> > oFHro8aKzH9ulwPevCKHpev6D53gibZrv5U9mPHGcoB$
> > v2:
> >  - use "xfer" for checking "first through the loop"
> > ---
> >  drivers/iio/addac/ad74413r.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index 5271073bb74e..aba9a643a4ca 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -840,7 +840,7 @@ static int ad74413r_update_scan_mode(struct iio_dev
> > *indio_dev,
> >  {
> >  	struct ad74413r_state *st = iio_priv(indio_dev);
> >  	struct spi_transfer *xfer = st->adc_samples_xfer;
> > -	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> > AD74413R_FRAME_SIZE];
> > +	u8 *rx_buf = st->adc_samples_buf.rx_buf;
> >  	u8 *tx_buf = st->adc_samples_tx_buf;
> >  	unsigned int channel;
> >  	int ret = -EINVAL;
> > @@ -894,9 +894,10 @@ static int ad74413r_update_scan_mode(struct
> > iio_dev *indio_dev,
> > 
> >  		spi_message_add_tail(xfer, &st->adc_samples_msg);
> > 
> > -		xfer++;
> >  		tx_buf += AD74413R_FRAME_SIZE;
> > -		rx_buf += AD74413R_FRAME_SIZE;
> > +		if (xfer != st->adc_samples_xfer)
> > +			rx_buf += AD74413R_FRAME_SIZE;
> > +		xfer++;
> >  	}
> > 
> >  	xfer->rx_buf = rx_buf;
> > --
> > 2.30.2  
> 

