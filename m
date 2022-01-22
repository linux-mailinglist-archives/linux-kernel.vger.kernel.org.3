Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA24496CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiAVQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiAVQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A4C06173B;
        Sat, 22 Jan 2022 08:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7D760E05;
        Sat, 22 Jan 2022 16:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179B0C004E1;
        Sat, 22 Jan 2022 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642870718;
        bh=5gZrthvBYcROpsTd1AT/pYU+NE8D3dCyafqvhAjkSbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ubCZ6QK/l5hO08fFvQC6kHaZfg54zz+sd3tf33Vgt+8rlc15U9flFt33uKbnyw2Vw
         DpDAlUjh3wVJ+KyQadOWmB3GM2jGQ+yDGtSidIknmwDO1hny35k9tcAQ2JhzfDetoA
         Ck6NyazaZcgz9PueYUdwshSJDFu/yqGAv0ybOszQmVx9pm4+c3idNBQQ38YZxjYZtJ
         qWrLaI+6U7cE929FWqyWq79WSJqFgJp2ueShCiOfzvVbFeU+0lWDic9K15Qg3dG2iw
         LwGBEa7gqFPTy6zNxdn+/SNn/+vNsqpZGHWkXnsbpoT5o5xk5iRfFrd57cIjDwdaJ/
         DFtPbOTFWTRdA==
Date:   Sat, 22 Jan 2022 17:04:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] iio: at91-sama5d2: Limit requested watermark value
 to hwfifo size
Message-ID: <20220122170447.68f35cfa@jic23-huawei>
In-Reply-To: <20220117102512.31725-2-paul@crapouillou.net>
References: <20220117102512.31725-1-paul@crapouillou.net>
        <20220117102512.31725-2-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 10:25:12 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Instead of returning an error if the watermark value is too high, which
> the core will silently ignore anyway, limit the value to the hardware
> FIFO size; a lower-than-requested value is still better than using the
> default, which is usually 1.

There is another potential error condition in this function which will
also be ignored by the core.

As such whilst I agree this is a sensible thing to do in this
particular case I think we should also be handling the error in the core.

I think it would be better to clean that up at the same time
as these improvements - particularly as I'd guess you have a convenient
test setup to check the error unwind is correct?

Thanks,

Jonathan

> 
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 854b1f81d807..5cc84f4a17bb 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1752,7 +1752,7 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	int ret;
>  
>  	if (val > AT91_HWFIFO_MAX_SIZE)
> -		return -EINVAL;
> +		val = AT91_HWFIFO_MAX_SIZE;
>  
>  	if (!st->selected_trig->hw_trig) {
>  		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n");

