Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24456CF36
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGJNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 09:00:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE41642C;
        Sun, 10 Jul 2022 06:00:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso2212771wms.5;
        Sun, 10 Jul 2022 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URkBqTaJYZiBKaHkMPyuusVxdAfWQV7wmB1QtdU3dqc=;
        b=H28NNWSz9kCHmESG/8FbsQ+m+Jzxy0qUH0fyz1nTVT1VnfBfH5jiuEPkD53FXHjSzn
         B/1dX86SUM+LrKgLI+OYmFPx82FdsB7V7yt8sf5XzwbtSzPbPhDXFQePbTiQi3lyyDyP
         gMD3/4c+Za4D22NF6y4FK7z/NMbKVISAdm+vnmThUgp797/YBqaFhAmGGecJT+SZcrvc
         nZn0bWReEM8Dfarg2Hm6x7djFxVUPsFttf22okgYsWEwwHRp6hldOhLKJUHUfEK3zrDn
         HiqibjwQLKcAMiflSho4wiD/UVJX6XpYIzFXuACDbKgxRHdZNZO8RPbciEo4gE2fs92g
         WkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URkBqTaJYZiBKaHkMPyuusVxdAfWQV7wmB1QtdU3dqc=;
        b=KojpgyeKoH2cLjkG0xmtD2aPZuhOAbdEo9wkqDXnqebBrOz6PArZzIebMTDwVDX8d6
         RC6/BWrLOZXiorJmKMaIlCmdg1W9VwNqDPmTeaphieCauXNkyvq7nS7W7qzZ1L0+PQzK
         rr5hf8rvjVyxSt1DZIzQ2by+GrBnVVtwNi6Qa4YdKqbrT2pEvwgpfZp4wvxkVT6Q0fbK
         NvIFgWBWckZnjZYcR9RRfBgqTszrAIfRxRYNLm8ve3hl0XkhB6MyO474UlR3iKoTCHJS
         3o0++BgyGJJI8lFE4CvKmLRDAzIgAsGASjI1F48Vjhx/EBLtAhGwq6coeAlL/hJIUBiG
         WycA==
X-Gm-Message-State: AJIora8Vl5Rx5OHe8cHufP82IIaMPm/3nKqUHfDyTKo9jQvejNaOH0gH
        zsI7VcNenxAAyWwtNXzNv1M=
X-Google-Smtp-Source: AGRyM1vsTGSbf96VTwX0XNh02DsOlmP27A9LgNPMyEn1EV6Jd3PuivbWE971HAL4v79NdOzdGIsDng==
X-Received: by 2002:a05:600c:4f4d:b0:3a1:98de:abde with SMTP id m13-20020a05600c4f4d00b003a198deabdemr10439595wmq.36.1657458022784;
        Sun, 10 Jul 2022 06:00:22 -0700 (PDT)
Received: from mandalorian.koija ([2a02:587:4ba0:ca00:f1ee:516:279c:45e9])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c2b8200b0039c8a22554bsm3876989wmc.27.2022.07.10.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 06:00:22 -0700 (PDT)
Date:   Sun, 10 Jul 2022 16:00:19 +0300
From:   Christos Kollintzas <c.kollintzas.92@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace udelay with usleep_range
Message-ID: <YsrNY+uU8tUXJiPV@mandalorian.koija>
References: <YslTQLhM7GSaGXki@mandalorian.koija>
 <YslY25NnW6O5Tn+p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YslY25NnW6O5Tn+p@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 12:30:51PM +0200, Greg KH wrote:
> On Sat, Jul 09, 2022 at 01:06:56PM +0300, Christos Kollintzas wrote:
> > Adhere to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > 
> > CHECK: usleep_range is preferred over udelay
> > 
> > Signed-off-by: Christos Kollintzas <c.kollintzas.92@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
> > index c680160d6380..eeafbab4ace1 100644
> > --- a/drivers/staging/fbtft/fb_upd161704.c
> > +++ b/drivers/staging/fbtft/fb_upd161704.c
> > @@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
> >  
> >  	/* oscillator start */
> >  	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
> > -	udelay(100);
> > +	usleep_range(100, 110);
> 
> When doing these types of changes, you really need access to the
> hardware involved in order to be able to properly test it.
> 
> Especially for this type of function which is trying to do timing
> changes which the hardware requires.
> 
> Did you test this on the real hardware and did it work properly?
> 
> thanks,
> 
> greg k-h

I did not.

I will try to find the hardware and send a patch that is
properly tested.

thanks,

Christos Kollintzas
