Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5653D757
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiFDO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiFDO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D9DA6;
        Sat,  4 Jun 2022 07:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF5AF60C69;
        Sat,  4 Jun 2022 14:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D4AC385B8;
        Sat,  4 Jun 2022 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654354616;
        bh=PqOK2jmzrzVvd+pTI4tgoob/fXORaJiue7+8OoRS5pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XhayD6p1Ooemd6YWWsDEc5bEvfCn7D87xjowDh5kSIZX/vWxPU3lavYe76DfH1aQZ
         ukHRIZMEe0uCCfhtp70XHwsCHYzfy22iRwWrODw68qBFKMC7KbUM8vi643UkE+W0Dj
         VBTi5KTQ5zcWWjvHJWnR2b3YJ3HGPgn9vAuP5J3wup9MEKIJr0QtgHQM4JqTuAJKb0
         E/nnN4kN6f+e7VJ+LX4nO1KoNb+6XD22EdmXq1WAbjp3bAWMrD2+fwWiwtobry0fsk
         hIXSKFrfv5IIdW0dCz/DUW8hji6eteErHP3pF5BZqLmQmOEgBEbMwOHMEMz0MUO3zy
         up+Na8mHA2Vhg==
Date:   Sat, 4 Jun 2022 16:05:57 +0100
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
Message-ID: <20220604160557.1e82077e@jic23-huawei>
In-Reply-To: <20220122170447.68f35cfa@jic23-huawei>
References: <20220117102512.31725-1-paul@crapouillou.net>
        <20220117102512.31725-2-paul@crapouillou.net>
        <20220122170447.68f35cfa@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022 17:04:47 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Jan 2022 10:25:12 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > Instead of returning an error if the watermark value is too high, which
> > the core will silently ignore anyway, limit the value to the hardware
> > FIFO size; a lower-than-requested value is still better than using the
> > default, which is usually 1.  
> 
> There is another potential error condition in this function which will
> also be ignored by the core.
> 
> As such whilst I agree this is a sensible thing to do in this
> particular case I think we should also be handling the error in the core.
> 
> I think it would be better to clean that up at the same time
> as these improvements - particularly as I'd guess you have a convenient
> test setup to check the error unwind is correct?

Hi Paul,

I was trawling through patchwork and realised this one is stalled.

Thoughts on the above?

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index 854b1f81d807..5cc84f4a17bb 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -1752,7 +1752,7 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> >  	int ret;
> >  
> >  	if (val > AT91_HWFIFO_MAX_SIZE)
> > -		return -EINVAL;
> > +		val = AT91_HWFIFO_MAX_SIZE;
> >  
> >  	if (!st->selected_trig->hw_trig) {
> >  		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n");  
> 

