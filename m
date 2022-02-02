Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F644A7A15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347479AbiBBVN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbiBBVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:13:55 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C304C061714;
        Wed,  2 Feb 2022 13:13:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id y8so424948qtn.8;
        Wed, 02 Feb 2022 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKbhLaruFzJihRr6tuHWqUwiyv5AacGBfXx3Ff7B0io=;
        b=SYedvhKztxYN6/73vqzNbvu0Qr5H5hpvoKUwVsBTwGsvFLq1GKGs5oF77oWeMy1gtR
         17RhhPxDJRo/NdyISTDSIRI84kFh9x1D7x5M2AFL5lE4MbIwN3H7z+rCsPHiyXGLgutB
         Tv9wbPZUtLpfcFYANRdDAlsIWXzVX0fG6Y9i+o+HIHoGPAH19h5yjZuuf/vpf/29MY7x
         zEjRwyoQgzUhTwtVQhyLkWZfXCY6FaS+wcfgnU2DXEB8UtrVj4x2FbPE4Cq2RHXf38Np
         FgBiMBqrAM74b+jQIv1f0AhXr3LqMAiDrUex57Ze6sVUDvkISJAHqSu6eYdWwUrlFL1X
         s8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKbhLaruFzJihRr6tuHWqUwiyv5AacGBfXx3Ff7B0io=;
        b=0PDyigdySpBSHsn7i3U8JBMyUg1cRmmkC5bqOp5BnpC90s3Z7NuCjTbI+g8ri8LtkE
         LcRJYh/GJmOSQhqCGg87Un1uG7xI1nP5WhFnKbp+ePXE/ZGGpu2t0vuzBUNT18xma8LL
         oJikVmp1utAatxkJI4Rxp3lsMg8J1Rv4DXERUTJv+32dhcV+Vb3wQG1rzCuAKusMlvOk
         VvwT/UtG9wvMjz7uuZ/tHGmwA0sW0zLuAUyrRtVlkheTpeANYLKN7CBi36qR2AuemiCD
         pik9uWzIfzRkcP/MCNCXn9emrZ6vuZlN/C0aRwS85XZMnfFqL3vKNFAyy8JceqXifOu8
         HOwA==
X-Gm-Message-State: AOAM531lF61k0/Up7lG0BMX/SEqvDgxtrzcUdrlA5X8egw7OqvbTXCVP
        FEA0ku8ZkE5UUXwZOcnORXJqEXgpxqA=
X-Google-Smtp-Source: ABdhPJxFYaSprVyP6Y01tg0cALKPhGKkbkgEwLvuLUBcJPUVAI8RstL1ZwH9nCGZN7X25+ma9ES2aw==
X-Received: by 2002:ac8:7d55:: with SMTP id h21mr24439359qtb.331.1643836434380;
        Wed, 02 Feb 2022 13:13:54 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id w4sm13542192qko.123.2022.02.02.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:13:53 -0800 (PST)
Date:   Wed, 2 Feb 2022 16:13:51 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v13 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <Yfr0D3MabWcGLOde@shaak>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-3-liambeguin@gmail.com>
 <8347a069-c36c-cb30-a0be-5b38f3c59b32@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8347a069-c36c-cb30-a0be-5b38f3c59b32@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On Wed, Feb 02, 2022 at 06:04:25PM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2022-01-30 17:10, Liam Beguin wrote:
> > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > Add support for these to allow using the iio-rescaler with them.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > Reviewed-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index 65832dd09249..f833eb38f8bb 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> > +#include <linux/units.h>
> 
> This include should be moved to the first patch that uses stuff from
> it.

Some defines are used a bit further down in mult

(copied back from the original message):
> >	case IIO_VAL_INT_PLUS_NANO:
> >	case IIO_VAL_INT_PLUS_MICRO:
> >		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;

> Cheers,
> Peter
> 
> *snip*

Cheers,
Liam
