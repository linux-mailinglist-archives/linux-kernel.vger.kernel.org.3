Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5147C85E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhLUUnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhLUUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:43:44 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95125C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:43:44 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t11so51373qtw.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKiPZyIkoZhEjEDCqZ1DtyFgXU8NshvCITLb8EMLKaI=;
        b=CYFfDlLIU66KdQFysHb+R2290xq5I394wVK4oN+LvtUSA5Z28tPjPcdmiak3N9lX0r
         O2TKLX75rMy8ohumQRS6S3tRnIqzeAsVKNXfSYxbSJ1I8/MOOXOJ6lKmutSX4GXEDqvY
         4f+dqalG18NBriuneMdo+HwNPGcu2uoNivpfbiJJVbAooL/fFfPlSAXhgqAGH/mo/PFH
         mbspLQ9LjDFiarjVTkmEEEKvgNcFcsDGnNHlL5Y92rVa/y3TYV1/APeSqZT369sBmkiP
         Vh8ltOh/k+dAara+WkhVsdxNbmImSrukp7c4Sc4UccmwnFtrTXtkjkbfEDa3kj4CHybv
         W0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKiPZyIkoZhEjEDCqZ1DtyFgXU8NshvCITLb8EMLKaI=;
        b=4fXy5/vvJVa9nRz9lDFnjcjIfImmCwOnhj+I9xQNZ6k4OwdVrZtZx0gsVgZUoI2l+2
         SpTwfkapaP1ZZ0SHw1XupL/p8lPfV8qI341hKo2u5/r1EfYWgsdII2totcdYCejjIUdQ
         fT+n4hnMMh6SiWqGAS3fOSRyJ/fCeApzY7S1TrMjX4Sze+3vIO7BtPOYetYN6Kd+GRqa
         fPxSG3ZUmpXjcH/q2ljPFWX/8yqkz1fc5Eg1swaY3Wj5QHzj0Grzho4WZrdeaRcM30q8
         XXg+Eb8qW6mavMJekS3qhL4yiXmCoQIZhFWPl+vhaKZX/lPwzd9Ym2VLehIuykN5hk+Q
         wP1Q==
X-Gm-Message-State: AOAM531LU6BS83ydEyKwX9U7EJNfHJ1GJOOzg98qFtdLdOW9cs+TPjB8
        bQG11eyy1SFKXJW9g1G7TR8=
X-Google-Smtp-Source: ABdhPJzGvtMrKNtgAJPQ/tiMnVAROthZ8TxUxb1fUIMtfUksE/JZwFkkX3E0wt1YNg204OfGICLP/Q==
X-Received: by 2002:a05:622a:3cc:: with SMTP id k12mr3784308qtx.412.1640119423538;
        Tue, 21 Dec 2021 12:43:43 -0800 (PST)
Received: from debianG ([190.191.20.243])
        by smtp.gmail.com with ESMTPSA id y10sm37914qkp.128.2021.12.21.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:43:43 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:43:42 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: Re: [PATCH 3/4] staging: vc04_services: avoid the use of typedef for
 function pointers
Message-ID: <YcI8fiPib2VNSO2w@debianG>
References: <cover.1639858361.git.gascoar@gmail.com>
 <a218f1bd092d874ccd96e3a94c1174ad41fffebc.1639858361.git.gascoar@gmail.com>
 <YcFyjXOfGz9GwPAD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcFyjXOfGz9GwPAD@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:22:05AM +0100, Greg KH wrote:
> On Mon, Dec 20, 2021 at 06:29:13PM -0300, Gaston Gonzalez wrote:
> > Replace the function pointer typedef vchiq_mmal_buffer_cb with
> > equivalent declaration to better align with the linux kernel coding
> > style.
> > 
> > While at it, realignments were done in some touched lines.
> > 
> > Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> > ---
> >  .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 24 +++++++++----------
> >  .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 13 +++++-----
> >  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> Same subject line as patch 1/4 :(
> 
> > 
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > index 76d3f0399964..54e5ce245ae7 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > @@ -269,10 +269,10 @@ static void buffer_work_cb(struct work_struct *work)
> >  
> >  	atomic_dec(&msg_context->u.bulk.port->buffers_with_vpu);
> >  
> > -	msg_context->u.bulk.port->buffer_cb(msg_context->u.bulk.instance,
> > -					    msg_context->u.bulk.port,
> > -					    msg_context->u.bulk.status,
> > -					    msg_context->u.bulk.buffer);
> > +	msg_context->u.bulk.port->vchiq_mmal_buffer_cb(msg_context->u.bulk.instance,
> > +						       msg_context->u.bulk.port,
> > +						       msg_context->u.bulk.status,
> > +						       msg_context->u.bulk.buffer);
> >  }
> >  
> >  /* workqueue scheduled callback to handle receiving buffers
> > @@ -1327,13 +1327,12 @@ static int port_disable(struct vchiq_mmal_instance *instance,
> >  			mmalbuf = list_entry(buf_head, struct mmal_buffer,
> >  					     list);
> >  			list_del(buf_head);
> > -			if (port->buffer_cb) {
> > +			if (port->vchiq_mmal_buffer_cb) {
> >  				mmalbuf->length = 0;
> >  				mmalbuf->mmal_flags = 0;
> >  				mmalbuf->dts = MMAL_TIME_UNKNOWN;
> >  				mmalbuf->pts = MMAL_TIME_UNKNOWN;
> > -				port->buffer_cb(instance,
> > -						port, 0, mmalbuf);
> > +				port->vchiq_mmal_buffer_cb(instance, port, 0, mmalbuf);
> >  			}
> >  		}
> >  
> > @@ -1363,7 +1362,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
> >  
> >  	port->enabled = 1;
> >  
> > -	if (port->buffer_cb) {
> > +	if (port->vchiq_mmal_buffer_cb) {
> >  		/* send buffer headers to videocore */
> >  		hdr_count = 1;
> >  		list_for_each_safe(buf_head, q, &port->buffers) {
> > @@ -1454,9 +1453,10 @@ EXPORT_SYMBOL_GPL(vchiq_mmal_port_parameter_get);
> >   * enables a port and queues buffers for satisfying callbacks if we
> >   * provide a callback handler
> >   */
> > -int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
> > -			   struct vchiq_mmal_port *port,
> > -			   vchiq_mmal_buffer_cb buffer_cb)
> > +int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance, struct vchiq_mmal_port *port,
> > +			   void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> > +							struct vchiq_mmal_port *port, int status,
> > +							struct mmal_buffer *buffer))
> >  {
> >  	int ret;
> >  
> > @@ -1469,7 +1469,7 @@ int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
> >  		goto unlock;
> >  	}
> >  
> > -	port->buffer_cb = buffer_cb;
> > +	port->vchiq_mmal_buffer_cb = vchiq_mmal_buffer_cb;
> >  
> >  	ret = port_enable(instance, port);
> >  
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > index 1dc81ecf9268..39615ce6584a 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > @@ -42,11 +42,6 @@ struct vchiq_mmal_port_buffer {
> >  
> >  struct vchiq_mmal_port;
> >  
> > -typedef void (*vchiq_mmal_buffer_cb)(
> > -		struct vchiq_mmal_instance  *instance,
> > -		struct vchiq_mmal_port *port,
> > -		int status, struct mmal_buffer *buffer);
> > -
> >  struct vchiq_mmal_port {
> >  	u32 enabled:1;
> >  	u32 handle;
> > @@ -76,7 +71,9 @@ struct vchiq_mmal_port {
> >  	/* Count of buffers the VPU has yet to return */
> >  	atomic_t buffers_with_vpu;
> >  	/* callback on buffer completion */
> > -	vchiq_mmal_buffer_cb buffer_cb;
> > +	void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> > +				     struct vchiq_mmal_port *port, int status,
> > +				     struct mmal_buffer *buffer);
> 
> There is no need to rename the function pointer at all.
> 
> >  	/* callback context */
> >  	void *cb_ctx;
> >  };
> > @@ -126,7 +123,9 @@ int vchiq_mmal_component_disable(
> >  int vchiq_mmal_port_enable(
> >  		struct vchiq_mmal_instance *instance,
> >  		struct vchiq_mmal_port *port,
> > -		vchiq_mmal_buffer_cb buffer_cb);
> > +		void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> > +					     struct vchiq_mmal_port *port, int status,
> > +					     struct mmal_buffer *buffer));
> >  
> 
> Here is where using a typedef is ok.  Again, typedefs for function
> pointers is normal and keeps code smaller and easier to follow.
>

Ok, I had my doubts about this one just because that lines.

Will drop it.

thanks,

Gaston


> thanks,
> 
> greg k-h
