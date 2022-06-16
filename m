Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1054DA36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358921AbiFPGHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358968AbiFPGHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C471FD21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655359650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNWmdhLxppKdCA9eexLAnO1+hC4KXJHf7QP0BJFQUZ8=;
        b=QtPsu0ey/Xrb/I+AuG7cxal95fVtbRpozPBGowLy5G3oELVGAUcd/n4pFI4fX5qKt19L0K
        oVgBV43SmsrHTwnB95hKdbTooh4CbRC1nsOt3s9w+RRRmNgqKsWT80bC4QjwH4vFr3uVFo
        j0bap9J8/EKhtjkvF0tIb4UMZxw+k6U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-n2gu7KqgMciZV-AgOb1HaA-1; Thu, 16 Jun 2022 02:07:20 -0400
X-MC-Unique: n2gu7KqgMciZV-AgOb1HaA-1
Received: by mail-wm1-f69.google.com with SMTP id l4-20020a05600c1d0400b0039c60535405so185253wms.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HNWmdhLxppKdCA9eexLAnO1+hC4KXJHf7QP0BJFQUZ8=;
        b=vDNZjatGllRMpbV6a35EMjB3xGQiHSVgAn0l73jpxIEV+UyS8CX+SnDmFfhlImWF85
         6izOqd12Q1QUKhQB8/Q4CiaDexByA8AWKn8XvvgZKk3sVE0Tif2OpHvKn14vHW62q2OI
         rWn/sEvV8SMwJzLdLBUv5+ys6AjV2HjdxNnFcdoDQipuR0G5JdhOwyQJnSaf/va016Bg
         oPitKzodB+MJ7lBKLiLNc7d+RvtPDTbDsTNoVmVyj4DGz1ys1lSYG0i62oiywhKXoBNO
         wvKGuvfCKFSSbroaVhZ4qC00hZIBONJLzZrL9UYtwb/Iy1CbS4joD2U3kUmCJXwd6bL4
         xioQ==
X-Gm-Message-State: AOAM531ypuU3VuCfiGn2qCMnZetPBJ+jJGhpkg8FFo2XSrwTIF0vIJy6
        Eo+qbNS1TsfN/Xi+g7Qfu11pWevt8l8g+8GsoC8VvmwdN5hz0seqLvErtSRukNS8ZDXuOm8k+8h
        If8moliy5UtiGhxFW4KpT9FYt
X-Received: by 2002:a05:600c:2256:b0:39d:4b0c:7ce4 with SMTP id a22-20020a05600c225600b0039d4b0c7ce4mr13747559wmm.146.1655359639674;
        Wed, 15 Jun 2022 23:07:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytTWfzuBXUqF+rTavH6EUE6BvRB+FYWOqKWlFJT60lH/tlUJz6gGZsgrjF15LFvw2O0JP/Lg==
X-Received: by 2002:a05:600c:2256:b0:39d:4b0c:7ce4 with SMTP id a22-20020a05600c225600b0039d4b0c7ce4mr13747537wmm.146.1655359639345;
        Wed, 15 Jun 2022 23:07:19 -0700 (PDT)
Received: from redhat.com ([2.55.50.22])
        by smtp.gmail.com with ESMTPSA id v15-20020adff68f000000b0021576694d9dsm812535wrp.97.2022.06.15.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:07:18 -0700 (PDT)
Date:   Thu, 16 Jun 2022 02:07:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     jasowang@redhat.com, yuanzhu@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_ring : keep used_wrap_counter in
 vq->last_used_idx
Message-ID: <20220616015331-mutt-send-email-mst@kernel.org>
References: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
 <20220616051221.28506-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616051221.28506-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:12:21PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> the used_wrap_counter and the vq->last_used_idx may get
> out of sync if they are separate assignment，and interrupt
> might use an incorrect value to check for the used index.
> 
> for example:OOB access
> ksoftirqd may consume the packet and it will call:
> virtnet_poll
> 	-->virtnet_receive
> 		-->virtqueue_get_buf_ctx
> 			-->virtqueue_get_buf_ctx_packed
> and in virtqueue_get_buf_ctx_packed:
> 
> vq->last_used_idx += vq->packed.desc_state[id].num;
> if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
>          vq->last_used_idx -= vq->packed.vring.num;
>          vq->packed.used_wrap_counter ^= 1;
> }
> 
> if at the same time, there comes a vring interrupt，in vring_interrupt:
> we will call:
> vring_interrupt
> 	-->more_used
> 		-->more_used_packed
> 			-->is_used_desc_packed
> in is_used_desc_packed, the last_used_idx maybe >= vq->packed.vring.num.
> so this could case a memory out of bounds bug.
> 
> this patch is to keep the used_wrap_counter in vq->last_used_idx
> so we can get the correct value to check for used index in interrupt.
> 
> v1->v2:
> - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> - Remove parameter judgment in is_used_desc_packed,
> because it can't be illegal
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>


This looks good, just a small suggestion below:

> ---
>  drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..b22d97c9a755 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -111,7 +111,12 @@ struct vring_virtqueue {
>  	/* Number we've added since last sync. */
>  	unsigned int num_added;
>  
> -	/* Last used index we've seen. */
> +	/* Last used index  we've seen.
> +	 * for split ring, it just contains last used index
> +	 * for packed ring, it not only contains last used index, but also
> +	 * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
> +	 * the bit shift in last_used_idx
> +	 */
>  	u16 last_used_idx;
>  
>  	/* Hint for event idx: already triggered no need to disable. */
> @@ -154,9 +159,6 @@ struct vring_virtqueue {
>  			/* Driver ring wrap counter. */
>  			bool avail_wrap_counter;
>  
> -			/* Device ring wrap counter. */
> -			bool used_wrap_counter;
> -
>  			/* Avail used flags. */
>  			u16 avail_used_flags;
>  
> @@ -1406,8 +1408,12 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  
>  static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  {
> -	return is_used_desc_packed(vq, vq->last_used_idx,
> -			vq->packed.used_wrap_counter);
> +	u16 last_used;
> +	bool used_wrap_counter;
> +
> +	last_used = vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);

This only works if last_used_idx is 16 bit and
VRING_PACKED_EVENT_F_WRAP_CTR is 15.

I think you want 
/* all bits below VRING_PACKED_EVENT_F_WRAP_CTR */
vq->last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));


> +	used_wrap_counter = !!((vq->last_used_idx) >> VRING_PACKED_EVENT_F_WRAP_CTR);


A bit more efficient and clear:

!!(q->last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))



Also this logic is repeated in multiple places. Let's add a couple of inline
functions:

static inline bool packed_used_wrap_counter(vq)

static inline u16 packed_last_used(vq)

then use these everywhere.


> +	return is_used_desc_packed(vq, last_used, used_wrap_counter);
>  }
>  
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> @@ -1416,6 +1422,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id;
> +	bool used_wrap_counter;
>  	void *ret;
>  
>  	START_USE(vq);
> @@ -1434,7 +1441,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	/* Only get used elements after they have been exposed by host. */
>  	virtio_rmb(vq->weak_barriers);
>  
> -	last_used = vq->last_used_idx;
> +	used_wrap_counter = !!((vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR));
> +	last_used = (vq->last_used_idx) & (~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
>  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
>  
> @@ -1451,12 +1459,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	ret = vq->packed.desc_state[id].data;
>  	detach_buf_packed(vq, id, ctx);
>  
> -	vq->last_used_idx += vq->packed.desc_state[id].num;
> -	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> -		vq->last_used_idx -= vq->packed.vring.num;
> -		vq->packed.used_wrap_counter ^= 1;
> +	last_used += vq->packed.desc_state[id].num;
> +	if (unlikely(last_used >= vq->packed.vring.num)) {
> +		last_used -= vq->packed.vring.num;
> +		used_wrap_counter ^= 1;
>  	}
>  
> +	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
> +	vq->last_used_idx = last_used;
> +
>  	/*
>  	 * If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
> @@ -1465,9 +1476,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
> -				cpu_to_le16(vq->last_used_idx |
> -					(vq->packed.used_wrap_counter <<
> -					 VRING_PACKED_EVENT_F_WRAP_CTR)));
> +				cpu_to_le16(vq->last_used_idx));
>  
>  	LAST_ADD_TIME_INVALID(vq);
>  
> @@ -1499,9 +1508,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  
>  	if (vq->event) {
>  		vq->packed.vring.driver->off_wrap =
> -			cpu_to_le16(vq->last_used_idx |
> -				(vq->packed.used_wrap_counter <<
> -				 VRING_PACKED_EVENT_F_WRAP_CTR));
> +			cpu_to_le16(vq->last_used_idx);
>  		/*
>  		 * We need to update event offset and event wrap
>  		 * counter first before updating event flags.
> @@ -1518,8 +1525,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  	}
>  
>  	END_USE(vq);
> -	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> -			VRING_PACKED_EVENT_F_WRAP_CTR);
> +	return vq->last_used_idx;
>  }
>  
>  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> @@ -1550,9 +1556,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	if (vq->event) {
>  		/* TODO: tune this threshold */
>  		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
> -		wrap_counter = vq->packed.used_wrap_counter;
> +		wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
>  
> -		used_idx = vq->last_used_idx + bufs;
> +		used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + bufs;
>  		if (used_idx >= vq->packed.vring.num) {
>  			used_idx -= vq->packed.vring.num;
>  			wrap_counter ^= 1;
> @@ -1582,9 +1588,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	 */
>  	virtio_mb(vq->weak_barriers);
>  
> -	if (is_used_desc_packed(vq,
> -				vq->last_used_idx,
> -				vq->packed.used_wrap_counter)) {
> +	wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
> +	used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
>  		END_USE(vq);
>  		return false;
>  	}
> @@ -1689,7 +1695,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = true;
> -	vq->last_used_idx = 0;
> +	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
> @@ -1720,7 +1726,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  
>  	vq->packed.next_avail_idx = 0;
>  	vq->packed.avail_wrap_counter = 1;
> -	vq->packed.used_wrap_counter = 1;
>  	vq->packed.event_flags_shadow = 0;
>  	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
>  
> -- 
> 2.31.1

