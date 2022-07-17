Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574057766B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiGQNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:44:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DAE02E;
        Sun, 17 Jul 2022 06:43:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so13387785wrb.11;
        Sun, 17 Jul 2022 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cFuBewbkyjB+iZbBdIas3lipeNBlzCnMmSiTJJaaLis=;
        b=opwd2+K3gwX+08GH6RAe3x11lbmVIuzg71eTgtQobjhXGWCIrqfKTi+3cEvdtmcR4n
         RfaxEkzBJja1Lf6lDX2GA6G6DR/XS+aZa9pJmB5ftq9Gr7JsnlrLiu2YaFnnQYFu+4Ao
         4UUqoC427QOvHJjW35IW5RaLyoFLxZ32Gn6DT8uiMsPx9fC6oruZ+3cwjLjERQguLaKD
         O/Bbtd5AH2vcE1Mmzp//GzaFIwv0AhqQTdz6LuIDlGZHwT6B4MwBiSIUcneY77jkeSA4
         EGGg2CzKYsXoiNlMWf51uteslohagS1gbhSF0obZAfSByEN2iiY5Hbl8whGTCtIdQSlm
         zTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cFuBewbkyjB+iZbBdIas3lipeNBlzCnMmSiTJJaaLis=;
        b=zbV1akfzfQkqnq+DkkcGJOiA/E01EalwNvrTGuutzsrvDA5ulHzi5qQP7SbZR8rEir
         syS4umqCjhSrplTxVMCH7o/GWw4MjvfvyI2DjnlSj92keqrH147C0gO9S5Kk3WVnqfn1
         O0+ogP2KlG+Vf3YXcvGQXzG8HhqgOvf5iuefAn8pV+IjU8TBu7R4DyymHnEdTGX1g1mn
         kEHUZ8oBjdSkCIMeqquWMh93JPRaBbUEnRVsiG38srpCEsH+SZz6q5BSXjDanLeggJZl
         FwBcEPfcDwT0IRXj2+1QnM83iwanlA0azF8qa97dmEzPEQIhDUI+FuswcOICBpkrk9K4
         Vp+g==
X-Gm-Message-State: AJIora8mz5gfFyMD2aP7yBw8LPF2tBrInaYYJMRcMSAX3iSW5wMQOEK6
        uwosIGEYDMYkGQk++FoBXRQ=
X-Google-Smtp-Source: AGRyM1uWaFZMOH5JQTR+RXQoYT2f87FaNNxCUC2e9+LysV8xaOf9dZ7sQohTArFCw8Rcja7FUb3YFA==
X-Received: by 2002:adf:f7ce:0:b0:21d:cb21:f6ee with SMTP id a14-20020adff7ce000000b0021dcb21f6eemr12057378wrq.438.1658065438415;
        Sun, 17 Jul 2022 06:43:58 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0021d746d4820sm8268430wrs.37.2022.07.17.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 06:43:58 -0700 (PDT)
Date:   Sun, 17 Jul 2022 15:43:56 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org
Subject: Re: [PATCH RESEND v2] media: uvcvideo: Fix memory leak in
 uvc_gpio_parse
Message-ID: <20220717134356.GA246248@elementary>
References: <20220108170439.49984-1-jose.exposito89@gmail.com>
 <YtG7sRuSIeZNhzNK@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtG7sRuSIeZNhzNK@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:10:41PM +0300, Laurent Pinchart wrote:
> Hi José,
> 
> Thank you for the patch.
> 
> On Sat, Jan 08, 2022 at 06:04:39PM +0100, José Expósito wrote:
> 
> I can't believe I've managed to ignore this patch for so long :-( Sorry.

Hi Laurent,

No problem, thanks for reviewing it, I just emailed you v3:
https://lore.kernel.org/linux-media/20220717133847.245703-1-jose.exposito89@gmail.com/T/

José Expósito
 
> > Previously the unit buffer was allocated before checking the IRQ for
> > privacy GPIO.
> > In case of error, the unit buffer was leaked.
> > 
> > Allocate the unit buffer after the IRQ to avoid it.
> > 
> > Addresses-Coverity-ID: 1474639 ("Resource leak")
> > Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > 
> > v2: Add Fixes and Reviewed-by tags
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 7c007426e082..9e83e2002710 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1533,10 +1533,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
> >  	if (IS_ERR_OR_NULL(gpio_privacy))
> >  		return PTR_ERR_OR_ZERO(gpio_privacy);
> >  
> > -	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> > -	if (!unit)
> > -		return -ENOMEM;
> > -
> >  	irq = gpiod_to_irq(gpio_privacy);
> >  	if (irq < 0) {
> >  		if (irq != EPROBE_DEFER)
> > @@ -1545,6 +1541,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
> >  		return irq;
> >  	}
> >  
> > +	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> > +	if (!unit)
> > +		return -ENOMEM;
> > +
> >  	unit->gpio.gpio_privacy = gpio_privacy;
> >  	unit->gpio.irq = irq;
> >  	unit->gpio.bControlSize = 1;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
