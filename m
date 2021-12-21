Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5947B9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhLUGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:22:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60236 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLUGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:22:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 049F8B811B1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C2C36AE2;
        Tue, 21 Dec 2021 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640067727;
        bh=ZVK5Ijif2h6VgJNmv+/MqT/5vmyXvTL8OCa/lm+oS7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4us2YE8fQZl3TgMqVQ16st/0Z3koXQ2C6OeRo6JZAMTmwwwnwEsPUO7ZfZuJSfld
         sbZk+WzfEx9EDelqC6Vp9scTVQ8pwJLU+SkgX+Ge4ZAv3h12CBSm2CvbUh/mcW78DS
         gPMr7g2ldwB6x+70ai5QhZ2QHBqMF+taSkHrKjCg=
Date:   Tue, 21 Dec 2021 07:22:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: vc04_services: avoid the use of typedef for
 function pointers
Message-ID: <YcFyjXOfGz9GwPAD@kroah.com>
References: <cover.1639858361.git.gascoar@gmail.com>
 <a218f1bd092d874ccd96e3a94c1174ad41fffebc.1639858361.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a218f1bd092d874ccd96e3a94c1174ad41fffebc.1639858361.git.gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 06:29:13PM -0300, Gaston Gonzalez wrote:
> Replace the function pointer typedef vchiq_mmal_buffer_cb with
> equivalent declaration to better align with the linux kernel coding
> style.
> 
> While at it, realignments were done in some touched lines.
> 
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---
>  .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 24 +++++++++----------
>  .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 13 +++++-----
>  2 files changed, 18 insertions(+), 19 deletions(-)

Same subject line as patch 1/4 :(

> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 76d3f0399964..54e5ce245ae7 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -269,10 +269,10 @@ static void buffer_work_cb(struct work_struct *work)
>  
>  	atomic_dec(&msg_context->u.bulk.port->buffers_with_vpu);
>  
> -	msg_context->u.bulk.port->buffer_cb(msg_context->u.bulk.instance,
> -					    msg_context->u.bulk.port,
> -					    msg_context->u.bulk.status,
> -					    msg_context->u.bulk.buffer);
> +	msg_context->u.bulk.port->vchiq_mmal_buffer_cb(msg_context->u.bulk.instance,
> +						       msg_context->u.bulk.port,
> +						       msg_context->u.bulk.status,
> +						       msg_context->u.bulk.buffer);
>  }
>  
>  /* workqueue scheduled callback to handle receiving buffers
> @@ -1327,13 +1327,12 @@ static int port_disable(struct vchiq_mmal_instance *instance,
>  			mmalbuf = list_entry(buf_head, struct mmal_buffer,
>  					     list);
>  			list_del(buf_head);
> -			if (port->buffer_cb) {
> +			if (port->vchiq_mmal_buffer_cb) {
>  				mmalbuf->length = 0;
>  				mmalbuf->mmal_flags = 0;
>  				mmalbuf->dts = MMAL_TIME_UNKNOWN;
>  				mmalbuf->pts = MMAL_TIME_UNKNOWN;
> -				port->buffer_cb(instance,
> -						port, 0, mmalbuf);
> +				port->vchiq_mmal_buffer_cb(instance, port, 0, mmalbuf);
>  			}
>  		}
>  
> @@ -1363,7 +1362,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
>  
>  	port->enabled = 1;
>  
> -	if (port->buffer_cb) {
> +	if (port->vchiq_mmal_buffer_cb) {
>  		/* send buffer headers to videocore */
>  		hdr_count = 1;
>  		list_for_each_safe(buf_head, q, &port->buffers) {
> @@ -1454,9 +1453,10 @@ EXPORT_SYMBOL_GPL(vchiq_mmal_port_parameter_get);
>   * enables a port and queues buffers for satisfying callbacks if we
>   * provide a callback handler
>   */
> -int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
> -			   struct vchiq_mmal_port *port,
> -			   vchiq_mmal_buffer_cb buffer_cb)
> +int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance, struct vchiq_mmal_port *port,
> +			   void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> +							struct vchiq_mmal_port *port, int status,
> +							struct mmal_buffer *buffer))
>  {
>  	int ret;
>  
> @@ -1469,7 +1469,7 @@ int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
>  		goto unlock;
>  	}
>  
> -	port->buffer_cb = buffer_cb;
> +	port->vchiq_mmal_buffer_cb = vchiq_mmal_buffer_cb;
>  
>  	ret = port_enable(instance, port);
>  
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> index 1dc81ecf9268..39615ce6584a 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> @@ -42,11 +42,6 @@ struct vchiq_mmal_port_buffer {
>  
>  struct vchiq_mmal_port;
>  
> -typedef void (*vchiq_mmal_buffer_cb)(
> -		struct vchiq_mmal_instance  *instance,
> -		struct vchiq_mmal_port *port,
> -		int status, struct mmal_buffer *buffer);
> -
>  struct vchiq_mmal_port {
>  	u32 enabled:1;
>  	u32 handle;
> @@ -76,7 +71,9 @@ struct vchiq_mmal_port {
>  	/* Count of buffers the VPU has yet to return */
>  	atomic_t buffers_with_vpu;
>  	/* callback on buffer completion */
> -	vchiq_mmal_buffer_cb buffer_cb;
> +	void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> +				     struct vchiq_mmal_port *port, int status,
> +				     struct mmal_buffer *buffer);

There is no need to rename the function pointer at all.

>  	/* callback context */
>  	void *cb_ctx;
>  };
> @@ -126,7 +123,9 @@ int vchiq_mmal_component_disable(
>  int vchiq_mmal_port_enable(
>  		struct vchiq_mmal_instance *instance,
>  		struct vchiq_mmal_port *port,
> -		vchiq_mmal_buffer_cb buffer_cb);
> +		void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
> +					     struct vchiq_mmal_port *port, int status,
> +					     struct mmal_buffer *buffer));
>  

Here is where using a typedef is ok.  Again, typedefs for function
pointers is normal and keeps code smaller and easier to follow.

thanks,

greg k-h
