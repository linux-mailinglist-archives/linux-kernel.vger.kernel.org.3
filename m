Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B37488A26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiAIPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAIPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:20:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A35C06173F;
        Sun,  9 Jan 2022 07:20:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38EDDB80D51;
        Sun,  9 Jan 2022 15:20:05 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A529EC36AEB;
        Sun,  9 Jan 2022 15:20:01 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:25:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: fix memory corruption by
 preventing array overflow
Message-ID: <20220109152557.74f06d2d@jic23-huawei>
In-Reply-To: <20220107081401.2816357-1-o.rempel@pengutronix.de>
References: <20220107081401.2816357-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 09:14:01 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On one side we have indio_dev->num_channels includes all physical channels +
> timestamp channel. On other side we have an array allocated only for
> physical channels. So, fix memory corruption by ARRAY_SIZE() instead of
> num_channels variable.
> 
> Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Hi Olesij,

Have you managed to make this occur, or is it inspection only?

I 'think' (it's been a while since I looked at the particular code) that the timestamp
bit in active_scan_mask will never actually be set because we handle that as a
separate flag.

So it is indeed an efficiency improvement to not check that bit but I don't think
it's a bug to do so.  More than possible I'm missing something though!

This one had me quite worried when I first read it because this is a very common
pattern to see in IIO drivers.

Jonathan

> ---
>  drivers/iio/adc/ti-tsc2046.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 91f6bd5effe7..8126084616e6 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -395,7 +395,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	mutex_lock(&priv->slock);
>  
>  	size = 0;
> -	for_each_set_bit(ch_idx, active_scan_mask, indio_dev->num_channels) {
> +	for_each_set_bit(ch_idx, active_scan_mask, ARRAY_SIZE(priv->l)) {
>  		size += tsc2046_adc_group_set_layout(priv, group, ch_idx);
>  		tsc2046_adc_group_set_cmd(priv, group, ch_idx);
>  		group++;
> @@ -561,7 +561,7 @@ static int tsc2046_adc_setup_spi_msg(struct tsc2046_adc_priv *priv)
>  	 * enabled.
>  	 */
>  	size = 0;
> -	for (ch_idx = 0; ch_idx < priv->dcfg->num_channels; ch_idx++)
> +	for (ch_idx = 0; ch_idx < ARRAY_SIZE(priv->l); ch_idx++)
>  		size += tsc2046_adc_group_set_layout(priv, ch_idx, ch_idx);
>  
>  	priv->tx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);

