Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78B4A369D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354973AbiA3ONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:13:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46944 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354964AbiA3ONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:13:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8FD6B80D24;
        Sun, 30 Jan 2022 14:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF6FC340F0;
        Sun, 30 Jan 2022 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551997;
        bh=137KAOgxQxq5H3WxKNVyxwmutOBva+lpHHW1WAXVK68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p3xJzsLIaViunoxpfA/yNFWG5fX8Sa5pJ9pIPRaf1FkMEZN4lFpCA7Cg/kPQsI1H9
         7xLaLlNwg2t85mlf5zoAmU07kbPWhRFM4NRGdo7oKjGKjFH+Y1Rkj0/wOITdbFbJdQ
         M8WBeDq5QVOVFVA55eptQw4OxRP+EFYvn9IxskIsz6XsQPJqc92s5qE6jqhfc0TPKz
         M5PYkUKT17X+wOUCESAB9/j3r6wwqFuxd5KWPAo+2weY9aAWS9HL9LP6Y3OCddY3cg
         CXV+u487QKTYraFJabGaJ0JiL2jiVz5mnGcU8CtfNue+Bln1QE7fW8uIh/nAGrcsNP
         MXarEpYalL6Xw==
Date:   Sun, 30 Jan 2022 14:19:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] iio: addac: ad74413r: Do not reference negative
 array offsets
Message-ID: <20220130141942.7c653e0d@jic23-huawei>
In-Reply-To: <8e6a081daeb54be38fdd658c796ec120@analog.com>
References: <20220112203456.3950884-1-keescook@chromium.org>
        <8e6a081daeb54be38fdd658c796ec120@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 21:57:22 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> > -----Original Message-----
> > From: Kees Cook <keescook@chromium.org>
> > Sent: Wednesday, January 12, 2022 10:35 PM
> > To: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Kees Cook <keescook@chromium.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> > linux-iio@vger.kernel.org; Tanislav, Cosmin <Cosmin.Tanislav@analog.com>;
> > Jonathan Cameron <Jonathan.Cameron@huawei.com>; Linus Walleij
> > <linus.walleij@linaro.org>; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org
> > Subject: [PATCH v2] iio: addac: ad74413r: Do not reference negative array
> > offsets
> > 
> > [External]
> > 
> > Instead of aiming rx_buf at an invalid array-boundary-crossing location,
> > just skip the first increment. Seen when building with -Warray-bounds:
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
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org
> > Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> > Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > hardening/20220105180214.2435001-1-
> > keescook@chromium.org/__;!!A3Ni8CS0y2Y!oWs0KcGPANFn-
> > L0qJPZgP47AQIYpBXJxg5LHiLDFGa_-SI2DwmSMzjgl3ehyu-8JYPgq$
> > v2:
> >  - Update commit Subject prefix
> >  - add Reviewed-by
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

