Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4B4B1452
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiBJRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:36:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiBJRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:36:06 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456DE70;
        Thu, 10 Feb 2022 09:36:06 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g4so5435243qto.1;
        Thu, 10 Feb 2022 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqqX8I9VlNvDu0KoaYvKANv47rrTRQzRPu0wHbwbTV4=;
        b=GArrRZ+0BFsblT8+KswnxS4OtevwlsyonS9+5MZ8LabHs5PHTErREszat1NDy1yyYV
         cTWXAt+ZIOjO5f17UfGtGqQJz/pY9nXeYQjUfn5s+UMre/9Mx4hhh53X2MEyxQOawoCL
         ivvueMibx1OiS8zyGud2tpvb3JL9VeM+YT7z+Xrnsqiop+DXeyMBkVooaXvEvbmHR8lP
         j3yJWbbRtBog+vzg1jFQi7G2uQwm6m1ZNo7z0U5dpLZ65lF4ez/cjZRBwIsj3L2wkAdz
         UGCXFhGYm7nUZQUlh3CWbit3huiQzBavxaw5qDrhIlKJLSRTgLx5vTLTU1i3ZBgOMLlp
         I0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqqX8I9VlNvDu0KoaYvKANv47rrTRQzRPu0wHbwbTV4=;
        b=r4L9g0z2mjm+VPHZQ74Zym2CWrsulWtd/qlg0J7lejYaKNLtSZ/0L+saSQQpdK/uTx
         1FOrn3M8j7ZjnfaMLNd5flHs5EStpTAtd5BZH6NAKvzQeLh6Gxc4h0ih1bkDR6zgxu5S
         hTFNBY9yhmvF33Di4Y6E9dJ/drhLxJbWSKFo79/Af9kfIf168AkR6O7kTLmNQDuFVLMn
         rsWgnpkErWsvTFJtBeMLsG92VHFVE8xEWGoBkfxXq3K9vq/FI5mRv65dQuY63I7gHdGa
         VOAkI0YfIQtjGXb+MXAqjMKxQiYbziHPtCGPIphKkmiLIzC0eUNa60yKoW9J+8TBSR/d
         UfbA==
X-Gm-Message-State: AOAM530p89GonsB67An1/rMgovzZDXLYdBvjDY1UjabPNvdz8uTXyDsp
        3KCE0wC0oWWyQYrR9iOfR2o=
X-Google-Smtp-Source: ABdhPJwUKgBRh2buNEFEKTTrnDM99atF/0aETP/RuALbugTx/GTvHvfq0qPEZ7215x6IS+LoRmhbuw==
X-Received: by 2002:a05:622a:1488:: with SMTP id t8mr5552733qtx.111.1644514565529;
        Thu, 10 Feb 2022 09:36:05 -0800 (PST)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id b8sm11355810qtx.79.2022.02.10.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:36:04 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:36:02 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, andy.shevchenko@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v14 02/11] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <YgVNAj7kz1QbKkhy@shaak>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
 <20220208020441.3081162-3-liambeguin@gmail.com>
 <fbb84b08-5d3d-3684-fdee-5ce367280857@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb84b08-5d3d-3684-fdee-5ce367280857@axentia.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Feb 10, 2022 at 05:42:25PM +0100, Peter Rosin wrote:
> Hi!
> 
> As usual, sorry for my low bandwidth.

No worries, I understand. It's been pretty slow on my end as well.

Thanks for still making time for this :-)

> On 2022-02-08 03:04, Liam Beguin wrote:
> > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > Add support for these to allow using the iio-rescaler with them.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > Reviewed-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)

...

> > @@ -41,6 +45,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  		tmp *= rescale->numerator;
> >  		tmp = div_s64(tmp, 1000000000LL);
> >  		*val = tmp;
> > +		return scale_type;
> > +	case IIO_VAL_INT_PLUS_NANO:
> > +	case IIO_VAL_INT_PLUS_MICRO:
> > +		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
> 
> By now, we all agree that the big numbers in this context have nothing
> to do with unit prefixes of physical quantities, so the macros are not
> really appropriate. However, in this case we have IIO_VAL_INT_PLUS_NANO
> and IIO_VAL_INT_PLUS_MICRO. Not using "NANO : MICRO" here, and instead
> go with "GIGA : MEGA" is just plain silly, if you ask me.
> 
> So, either "NANO : MICRO" or "1000000000 : 1000000".
> 
> I'm not sold on the macros. I frankly don't see all that much value
> in them and am perfectly fine with raw numbers. To me, it just looks
> like someone has read somewhere that constants should not appear in
> the code, and from that concluded that #define TEN 10 is a good thing
> without thinking very much about it. There is also the possibility
> that someone who has never seen these defines thinks MEGA is 2^20
> instead of 10^6, because that is a much more likely candidate for a
> define in the frist place (not everybody knows all the digits of
> 1048576 by heart and 1 << 20 many times require extra brackets that
> might make it look more complicated than it needs to be).
> 
> Back to this case; the connection to the naming of IIO_VAL_INT_PLUS_NANO
> (and ..._MICRO) makes it ok to use the defines. So if you feel strongly
> about not using "1000000000 : 1000000" I'm ok with that.

I like that the macros make the number of zeros more "obvious" in a
sense, but honestly at this point, I'd rather go back to not using them.
Depending on who you ask, one way makes more sense than the other, at
least with the raw values, there's no ambiguity.

Cheers,
Liam

> Cheers,
> Peter
