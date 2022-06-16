Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6554E0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376673AbiFPMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376631AbiFPMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7756D4A931
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655382092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKO9kaIoz02UsmIAowV9+PkxCUTdW7CkFsqbsOOxG00=;
        b=WDua1ee5npb8//JdC6RZckGEj36+ROsvMsTzfbq32p0mgAvpWitVt1aWfx8WrosVUb9MYZ
        PTnDAFacpZRpEi5UUAjm2M+9WWUqAz3kvXg5YRRNKr0Yj7SOFYtZ0zOGHRB93WqANIt2Ru
        I093neYTbsxsC4DBZKZlLOBT/iA+DfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-6TPrMxibO4-60ycNDKYhkQ-1; Thu, 16 Jun 2022 08:21:31 -0400
X-MC-Unique: 6TPrMxibO4-60ycNDKYhkQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay28-20020a05600c1e1c00b0039c5cbe76c1so1081691wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tKO9kaIoz02UsmIAowV9+PkxCUTdW7CkFsqbsOOxG00=;
        b=ESebJSr8cOK0SLFNxKvTrSVCBoDjI+5R3OAyfEZNzvOH8wJuMZmKliTr+YBhqR7loV
         BJbnG8fJ6oe9UiVZer+XBH1d14wPPeSVXRa+bNfSVat2ABiWq0Y027uwUAtxixBnn06/
         aRnAhlDp0ZIamdgdSqZqbWKVgOXTfc3pmyWR17Onbk5arvPlHi1lP+19i1fQiC0GkiMS
         D691nosvusny8VPOtp6zlgKJ3HycvyieTxhcfMf/0YNbdIutqRlsLLZ6vuUuFYv6qR06
         1pVOT4iZvszh3siu/9g8Q7BCXnwyZAXy3x/kXdPv2J2ZYMfVzow35fLBocWhhJHBkNze
         JvUQ==
X-Gm-Message-State: AJIora9xUgoAs6G1lLk4OsJK98TvnI15IOzWt80Heh7Msz8Ayezrb9CT
        RvxtJClj2QBDoQHWKEA0zhGTKV83op0SFFvfXvRi5hdsaY3N7PMAzispfus7EahxtzTVZsrL194
        SO/y7CUFK24bHdMQCU0sai55k
X-Received: by 2002:a1c:7913:0:b0:39e:72d1:b9b3 with SMTP id l19-20020a1c7913000000b0039e72d1b9b3mr3521241wme.53.1655382090137;
        Thu, 16 Jun 2022 05:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vImx8v+Pi0fb3eNoM8UymMi4MsjJuA+BPHWsFLmXTWOlrUWS17EyMKP0suss+nPlbqnZ3UlQ==
X-Received: by 2002:a1c:7913:0:b0:39e:72d1:b9b3 with SMTP id l19-20020a1c7913000000b0039e72d1b9b3mr3521223wme.53.1655382089862;
        Thu, 16 Jun 2022 05:21:29 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107d:d500:e9ae:3150:6c35:ac38])
        by smtp.gmail.com with ESMTPSA id i2-20020adffdc2000000b00213ba4b5d94sm2135823wrs.27.2022.06.16.05.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:21:29 -0700 (PDT)
Date:   Thu, 16 Jun 2022 08:21:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     yuanzhu@bytedance.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio_ring : keep used_wrap_counter in
 vq->last_used_idx
Message-ID: <20220616081812-mutt-send-email-mst@kernel.org>
References: <20220616024148-mutt-send-email-mst@kernel.org>
 <20220616095500.41239-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616095500.41239-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:54:59PM +0800, Albert Huang wrote:
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
> v2->v3:
> - add inline function to get used_wrap_counter and last_used
> - when use vq->last_used_idx, only read once
>   if vq->last_used_idx is read twice, the values can be inconsistent.
> - use last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>   to get the all bits below VRING_PACKED_EVENT_F_WRAP_CTR
> 
> v1->v2:
> - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> - Remove parameter judgment in is_used_desc_packed,
> because it can't be illegal
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..a253f50b8f86 100644
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


reword:

for packed ring, bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the
last used index. Bits from VRING_PACKED_EVENT_F_WRAP_CTR include the
used wrap counter.

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
> @@ -973,6 +975,15 @@ static struct virtqueue *vring_create_virtqueue_split(
>  /*
>   * Packed ring specific functions - *_packed().
>   */
> +static inline bool packed_used_wrap_counter(u16 last_used_idx)
> +{
> +	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +}
> +
> +static inline u16 packed_last_used(u16 last_used_idx)
> +{
> +	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +}
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  				     struct vring_desc_extra *extra)
> @@ -1406,8 +1417,14 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  
>  static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  {
> -	return is_used_desc_packed(vq, vq->last_used_idx,
> -			vq->packed.used_wrap_counter);
> +	u16 last_used;
> +	u16 last_used_idx;
> +	bool used_wrap_counter;
> +
> +	last_used_idx = vq->last_used_idx;
> +	last_used = packed_last_used(last_used_idx);
> +	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> +	return is_used_desc_packed(vq, last_used, used_wrap_counter);
>  }
>  
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> @@ -1415,7 +1432,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  					  void **ctx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 last_used, id;
> +	u16 last_used, id, last_used_idx;
> +	bool used_wrap_counter;
>  	void *ret;
>  
>  	START_USE(vq);
> @@ -1434,7 +1452,9 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	/* Only get used elements after they have been exposed by host. */
>  	virtio_rmb(vq->weak_barriers);
>  
> -	last_used = vq->last_used_idx;
> +	last_used_idx = vq->last_used_idx;


I think we need READ_ONCE here. Otherwise compiler is free to still
do two reads.

> +	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> +	last_used = packed_last_used(last_used_idx);
>  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
>  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
>  
> @@ -1451,12 +1471,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
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
> @@ -1465,9 +1488,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
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
> @@ -1499,9 +1520,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
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
> @@ -1518,8 +1537,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  	}
>  
>  	END_USE(vq);
> -	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> -			VRING_PACKED_EVENT_F_WRAP_CTR);
> +	return vq->last_used_idx;
>  }
>  
>  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> @@ -1537,7 +1555,7 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
>  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 used_idx, wrap_counter;
> +	u16 used_idx, wrap_counter, last_used_idx;
>  	u16 bufs;
>  
>  	START_USE(vq);
> @@ -1550,9 +1568,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	if (vq->event) {
>  		/* TODO: tune this threshold */
>  		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
> -		wrap_counter = vq->packed.used_wrap_counter;
> +		last_used_idx = vq->last_used_idx;
> +		wrap_counter = packed_used_wrap_counter(last_used_idx);
>  
> -		used_idx = vq->last_used_idx + bufs;
> +		used_idx = packed_last_used(last_used_idx) + bufs;
>  		if (used_idx >= vq->packed.vring.num) {
>  			used_idx -= vq->packed.vring.num;
>  			wrap_counter ^= 1;
> @@ -1582,9 +1601,10 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	 */
>  	virtio_mb(vq->weak_barriers);
>  
> -	if (is_used_desc_packed(vq,
> -				vq->last_used_idx,
> -				vq->packed.used_wrap_counter)) {
> +	last_used_idx = vq->last_used_idx;


same here.

> +	wrap_counter = packed_used_wrap_counter(last_used_idx);
> +	used_idx = packed_last_used(last_used_idx);
> +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
>  		END_USE(vq);
>  		return false;
>  	}
> @@ -1689,7 +1709,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = true;
> -	vq->last_used_idx = 0;
> +	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
> @@ -1720,7 +1740,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  
>  	vq->packed.next_avail_idx = 0;
>  	vq->packed.avail_wrap_counter = 1;
> -	vq->packed.used_wrap_counter = 1;
>  	vq->packed.event_flags_shadow = 0;
>  	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
>  
> -- 
> 2.31.1

