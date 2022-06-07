Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80053F644
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiFGGie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFGGi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE1D1880D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654583905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wbmh+cLiNUkJ2GMihMw3AGFn+jmS9SCo8bwKY106OII=;
        b=IB9YQwt50vIv9yYFDNoP3aSEQlv3DdQk/UHOo396Dc2JF91nqHKY7fuNyz0Ipf+irk3yhl
        RONAQAYnHbXlEZoyLpcm1iJmWq0T213LXYH4SbewepLe2CTqwOj+Pc9tp0fusZgCloUvc2
        row3JS5+wPvvbtJaiCYF8AyXQExouHU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-7qRm7xAJM-2j1L2Y-5hQwA-1; Tue, 07 Jun 2022 02:38:22 -0400
X-MC-Unique: 7qRm7xAJM-2j1L2Y-5hQwA-1
Received: by mail-ed1-f69.google.com with SMTP id o17-20020a50fd91000000b0042dbded81deso11969329edt.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wbmh+cLiNUkJ2GMihMw3AGFn+jmS9SCo8bwKY106OII=;
        b=2jPDX6crTjGCSYQc6kfQFjQYS81ecwXOSL1rU+KfAOMEjVGaxTTLNPLuhYRlyv6dVY
         b/z9svoqwwMHgYF4ZCJKA72fSgFOb55pLtl4bR/zS9MsKirFTth4EtZCiQcfoRByo9bs
         TUgveF3B6/3UhmNIkMs5w2XHXoOoCvpIrQUG9KJm7B6tTN0rh3RFaFvTw0XLbpGZC+Ie
         4U86uaZTuWdH8v6j0h5LQ/T3FQPQJY/ugawWa26quajtwwdjLAKbtMwVL0SHrs57GExt
         IyooM+1bfhHGhd0/SXQjPLQ5bZ1xlU/AxnpqAxRFuI3U8xOcbQG/XgC6yZZEP6VSZ1kf
         HuLA==
X-Gm-Message-State: AOAM533ds1/RcMnEzeqM2cn/DNN/cV9ngqdVg+BP76z+txpk9z1f5ncD
        +5VF3yC0AfGHrGnH3Ow+4uxF+2BVhYp1GcJSjQU1eX96nW57Z3fut0ItHefREhbJm7c2ooDKjp2
        pqXsjbNlX5mhZOaxGJU2LPoGL
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id r7-20020a05640251c700b0042df4ea0c09mr31162735edd.319.1654583900922;
        Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Jps7kQ/xohH/8dtmq4OQwlyD81Z2cqYGOAsw9R6m19VYfQyyVmkIypwUyyL51/3gQ8oV5Q==
X-Received: by 2002:a05:6402:51c7:b0:42d:f4ea:c09 with SMTP id r7-20020a05640251c700b0042df4ea0c09mr31162718edd.319.1654583900647;
        Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
Received: from redhat.com ([2.55.169.1])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b0043120d5f3dcsm4829582edb.14.2022.06.06.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:38:20 -0700 (PDT)
Date:   Tue, 7 Jun 2022 02:38:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call
Message-ID: <20220607023646-mutt-send-email-mst@kernel.org>
References: <20220607005951.2221-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607005951.2221-1-liubo03@inspur.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 08:59:51PM -0400, Bo Liu wrote:
> In many functions, the parameter passed in is "_vq", which still call
> to_vvq() to get 'vq'. It can avoid unnecessary call of to_vvq() by directly
> passing in the parameter "vq".
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

What does the patch accomplish? Is the generated binary faster? smaller?

> ---
>  drivers/virtio/virtio_ring.c | 100 ++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..f82db59fdbdc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -648,9 +648,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	return -ENOMEM;
>  }
>  
> -static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 new, old;
>  	bool needs_kick;
>  
> @@ -667,12 +666,12 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
>  
>  	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> +		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
>  					vring_avail_event(&vq->split.vring)),
>  					      new, old);
>  	} else {
>  		needs_kick = !(vq->split.vring.used->flags &
> -					cpu_to_virtio16(_vq->vdev,
> +					cpu_to_virtio16(vq->vq.vdev,
>  						VRING_USED_F_NO_NOTIFY));
>  	}
>  	END_USE(vq);
> @@ -735,11 +734,10 @@ static inline bool more_used_split(const struct vring_virtqueue *vq)
>  			vq->split.vring.used->idx);
>  }
>  
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
>  	unsigned int i;
>  	u16 last_used;
> @@ -761,9 +759,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> +	i = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> +	*len = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].len);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
> @@ -785,7 +783,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
> -				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
>  
>  	LAST_ADD_TIME_INVALID(vq);
>  
> @@ -793,10 +791,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
>  		if (vq->event)
> @@ -804,14 +800,13 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>  			vring_used_event(&vq->split.vring) = 0x0;
>  		else
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
>  }
>  
> -static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used_idx;
>  
>  	START_USE(vq);
> @@ -825,26 +820,23 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
>  		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
> -	vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
> +	vring_used_event(&vq->split.vring) = cpu_to_virtio16(vq->vq.vdev,
>  			last_used_idx = vq->last_used_idx);
>  	END_USE(vq);
>  	return last_used_idx;
>  }
>  
> -static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_idx)
> +static bool virtqueue_poll_split(struct vring_virtqueue *vq, unsigned int last_used_idx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> +	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->idx);
>  }
>  
> -static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 bufs;
>  
>  	START_USE(vq);
> @@ -858,7 +850,7 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_flags_shadow);
>  	}
>  	/* TODO: tune this threshold */
> @@ -866,9 +858,9 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  
>  	virtio_store_mb(vq->weak_barriers,
>  			&vring_used_event(&vq->split.vring),
> -			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
> +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
>  
> -	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->split.vring.used->idx)
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
>  					- vq->last_used_idx) > bufs)) {
>  		END_USE(vq);
>  		return false;
> @@ -878,9 +870,8 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
>  
> @@ -893,7 +884,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>  		buf = vq->split.desc_state[i].data;
>  		detach_buf_split(vq, i, NULL);
>  		vq->split.avail_idx_shadow--;
> -		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> +		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  				vq->split.avail_idx_shadow);
>  		END_USE(vq);
>  		return buf;
> @@ -1296,9 +1287,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	return -EIO;
>  }
>  
> -static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>  	bool needs_kick;
>  	union {
> @@ -1410,11 +1400,10 @@ static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  			vq->packed.used_wrap_counter);
>  }
>  
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id;
>  	void *ret;
>  
> @@ -1475,10 +1464,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>  		vq->packed.vring.driver->flags =
> @@ -1486,10 +1473,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  	}
>  }
>  
> -static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	START_USE(vq);
>  
>  	/*
> @@ -1522,9 +1507,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  			VRING_PACKED_EVENT_F_WRAP_CTR);
>  }
>  
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	bool wrap_counter;
>  	u16 used_idx;
>  
> @@ -1534,9 +1518,8 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
>  	return is_used_desc_packed(vq, used_idx, wrap_counter);
>  }
>  
> -static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 used_idx, wrap_counter;
>  	u16 bufs;
>  
> @@ -1593,9 +1576,8 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	return true;
>  }
>  
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
>  
> @@ -1906,8 +1888,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
> -				 virtqueue_kick_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> +				 virtqueue_kick_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -1977,8 +1959,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> +				 virtqueue_get_buf_ctx_split(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2007,9 +1989,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  		return;
>  
>  	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(_vq);
> +		virtqueue_disable_cb_packed(vq);
>  	else
> -		virtqueue_disable_cb_split(_vq);
> +		virtqueue_disable_cb_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -2032,8 +2014,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -				 virtqueue_enable_cb_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> +				 virtqueue_enable_cb_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2054,8 +2036,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  		return false;
>  
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -				 virtqueue_poll_split(_vq, last_used_idx);
> +	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> +				 virtqueue_poll_split(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2098,8 +2080,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
> -				 virtqueue_enable_cb_delayed_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> +				 virtqueue_enable_cb_delayed_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -2115,8 +2097,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> -				 virtqueue_detach_unused_buf_split(_vq);
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> +				 virtqueue_detach_unused_buf_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> -- 
> 2.27.0

