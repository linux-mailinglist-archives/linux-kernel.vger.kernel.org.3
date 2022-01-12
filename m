Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3248C018
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351704AbiALIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351692AbiALIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:40:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E1C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:40:08 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u15so3158545ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGT+OmnHAaV8+CpqkOxHNu2JHcWJotBh+uAlzG+Es4s=;
        b=KLJdbf+PfYk80rI4D2vUJy2bVIr9S7yYHpGppI9h/OnmTUECA1HNXVz27xhjtvZ/05
         gno7Hjc+EbYpkj+o7HZubDLlyElGrW7RI1Kn5nBgPCaDdyHr5XPp2dvAwAysoEzwNDFx
         DIaqJ8CdWcfsxNwzZDQqe0F0SroXifZSbaYtRlzNN/+xEDNKWvJuecGQyZYiEzlFaDjS
         XXLsegvOiz5qVtzD5VvknHcFPEu+iHqWK8d5BxsX1ctzN8WolwJ7yYZhMZI3p1ua7iZ1
         rjZnyDoqtCYitle6qHqOXTiXg+4oACfa9gtVa1XrYUGhTAvpAahDkpTdRRniwlykCgPc
         flSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGT+OmnHAaV8+CpqkOxHNu2JHcWJotBh+uAlzG+Es4s=;
        b=WHb+5DcOE3cSEl9afRPPlECH+bU/Y8UR/DaV5hE5TjV3mbA0oOin8pGO9HAngeLeDR
         8zeSg0Ymn4sij2FpbfmZ7hwz9sDj2plFs3Y3zj9i4lItImi+29lHaLisKkhmCmLp3hF1
         KnD3EXQBdZMWiShwhrXxCwUr4HEI/ODDKDRCXtb5s9ZP2zZCOAXA6fVCJsRTszEzvlYa
         CESz1l3IzLpTG4zxk1O15UqL/klcTyAUbUSQCbGV4Z5dmu9/877lwU7RGF+twpsb4GlT
         PgxES8JDuzHhO/eHiYI2r74Up0Bl5+gAeiQoRLFc3Klmfv2xOxN+cV2XFARoYXpkMZqf
         vrgg==
X-Gm-Message-State: AOAM532GMgt9MCQBhry1WvgvVLSZ1bxIzFj8mfL6jb6TzHJN+ZVz+dBC
        j0FIfb4hgg9voEX/sfv8Zd4=
X-Google-Smtp-Source: ABdhPJxAorWeZUwWiVuAdF3aZFd2ZIFw3b6RqWM4ERhR5+nQdMUkVCc/BfcPa78w6mG6JFXXgK+PBQ==
X-Received: by 2002:a17:90b:3ec9:: with SMTP id rm9mr4605684pjb.142.1641976808160;
        Wed, 12 Jan 2022 00:40:08 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id u126sm1854361pgc.22.2022.01.12.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:40:07 -0800 (PST)
Date:   Wed, 12 Jan 2022 21:40:02 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: enforce tx_cfg to be set before any
 message can be sent
Message-ID: <20220112084002.GA27596@mail.google.com>
References: <20220108222652.GA11883@mail.google.com>
 <20220110091723.GB1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091723.GB1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:17:23PM +0300, Dan Carpenter wrote:
> Seems reasonable.
> 
> On Sun, Jan 09, 2022 at 11:26:52AM +1300, Paulo Miguel Almeida wrote:
> > meta-comments:
> > - I'm not entirely sure if -EPERM is the best error code to return here,
> >   I'm taking suggestions
> 
> Better to just return -EINVAL.

> > ---
> >  drivers/staging/pi433/pi433_if.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> > index 051c9052aeeb..3e9913f4bc7d 100644
> > --- a/drivers/staging/pi433/pi433_if.c
> > +++ b/drivers/staging/pi433/pi433_if.c
> > @@ -108,6 +108,9 @@ struct pi433_device {
> >  struct pi433_instance {
> >  	struct pi433_device	*device;
> >  	struct pi433_tx_cfg	tx_cfg;
> > +
> > +	/* control flags */
> > +	bool			tx_cfg_initialized;
> >  };
> >  
> >  /*-------------------------------------------------------------------------*/
> > @@ -823,6 +826,16 @@ pi433_write(struct file *filp, const char __user *buf,
> >  	if (count > MAX_MSG_SIZE)
> >  		return -EMSGSIZE;
> >  
> > +	/*
> > +	 * check if tx_cfg has been initialized otherwise we won't be able to
> > +	 * config the RF trasmitter correctly due to invalid settings
> > +	 */
> > +	if (!instance->tx_cfg_initialized) {
> > +		dev_dbg(device->dev,
> > +			"write: failed due to uninitialized tx_cfg");
> 
> Use dev_notice_once() or similar.  Maybe "unconfigured" instead of
> uninitialized?
> 
> 	dev_notice_once(device->dev,
> 			"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)");
> 
> 
> > +		return -EPERM;
> > +	}
> > +
> >  	/*
> >  	 * write the following sequence into fifo:
> >  	 * - tx_cfg
> > @@ -897,6 +910,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  			return -EFAULT;
> >  		mutex_lock(&device->tx_fifo_lock);
> >  		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
> > +		instance->tx_cfg_initialized = true;
> >  		mutex_unlock(&device->tx_fifo_lock);
> >  		break;
> >  	case PI433_IOC_RD_RX_CFG:
> > @@ -950,7 +964,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
> >  	/* setup instance data*/
> >  	instance->device = device;
> >  	instance->tx_cfg.bit_rate = 4711;
> 
> This is sort of pointless because it can't work until that gets over
> written.
> 
> 
> > -	// TODO: fill instance->tx_cfg;
> > +	instance->tx_cfg_initialized = false;
> 
> kzalloc() will already set this to false.
> 
> regards,
> dan carpenter
> 

I agree with you on all points mentioned above. I will send another
version of this patch shortly.

Thanks for the patch review.

Paulo A.
