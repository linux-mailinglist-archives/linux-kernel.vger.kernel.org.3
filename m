Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C154E33F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377655AbiFPOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbiFPOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4EC33914E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655389179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6CVFy1NTxAkO1h3Mgn+h5m0fI6FBao8LsiY1exkXQA=;
        b=TjRGjIUezE3GZN2ffot8tMFWvNo75z0VGqImHzZ5hmNMArigx76OvOLysbpOb4GydmRTz3
        JqMzgvVd5HoxC50Mfdv/Y76xe30IpoxuBlPH06Beg4bClQXGQAqZPSztLZsx9SIzNsl8eq
        7IsEUV6cFfM8m15tXWIeQ57Brc/tC7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-0VArXBPVMDWkKv2wRBAgfw-1; Thu, 16 Jun 2022 10:19:38 -0400
X-MC-Unique: 0VArXBPVMDWkKv2wRBAgfw-1
Received: by mail-wm1-f71.google.com with SMTP id 2-20020a1c0202000000b0039c94528746so1210118wmc.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U6CVFy1NTxAkO1h3Mgn+h5m0fI6FBao8LsiY1exkXQA=;
        b=K8pc1j1/9NhidBkChnbFavFRJ2o+IhVEznjErG6o/jz4/b0LbE2G0tsMOd/qCStOIR
         f6WFyuZrQHCzrRndefjDfgT4G23SSt88oO0fOGDdne+xoHj974LbHmoz8Zyep69XW0oz
         KoKcibBF5UfmMkHdXvrn0Y/CkiTore5hYtMvo5V4pG3sLEwMt1eYClwq14novBhM/17s
         hDV84O6GDI4C8VHwgrmnlO9db0X2Z77aK7VAgtQgMsoufLLsiIPBi8U906P8LYXMBplO
         ECXhpxwBSJzZNhyDsk34MuSio0z+fqIPL6VUARbliXgLGz4gXR99M6wR6op0vcYqYrFn
         YOcA==
X-Gm-Message-State: AJIora9ZgsMod+R/H3mPdsoE0ycLBjvQtyek+KlAmTC0dRCMm7ozIVdo
        Jq27mfFOrEvsgsk+imLjwKTF2kyeZwfpzqPXfHmI2kA8dWxwJ8/E4sdlcDdMZWFPh9mYCfVXsOw
        S0rQhP1no0afQYwRzSy5zyq11
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr4828294wrc.38.1655389177286;
        Thu, 16 Jun 2022 07:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbi9B8wa6CwE7PtNRqbdJNn7TJfoqZifyvOdwQebh1MBl4mEQJRMWCkuQXwQ2sBFWBD42a1Q==
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr4828261wrc.38.1655389176987;
        Thu, 16 Jun 2022 07:19:36 -0700 (PDT)
Received: from redhat.com ([2.53.13.204])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003974860e15esm7563757wmq.40.2022.06.16.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:19:36 -0700 (PDT)
Date:   Thu, 16 Jun 2022 10:19:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     yuanzhu@bytedance.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio_ring : keep used_wrap_counter in
 vq->last_used_idx
Message-ID: <20220616101823-mutt-send-email-mst@kernel.org>
References: <20220616081812-mutt-send-email-mst@kernel.org>
 <20220616125737.48878-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616125737.48878-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:57:36PM +0800, Albert Huang wrote:
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
> v3->v4:
> - use READ_ONCE/WRITE_ONCE to get/set vq->last_used_idx
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
> index 13a7348cedff..719fbbe716d6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -111,7 +111,12 @@ struct vring_virtqueue {
>  	/* Number we've added since last sync. */
>  	unsigned int num_added;
>  
> -	/* Last used index we've seen. */
> +	/* Last used index  we've seen.
> +	 * for split ring, it just contains last used index
> +	 * for packed ring:
> +	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
> +	 * bits VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.

bits from VRING_PACKED_EVENT_F_WRAP_CTR

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
> +	last_used_idx = READ_ONCE(vq->last_used_idx);
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
> +	last_used_idx = READ_ONCE(vq->last_used_idx);
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
> +	WRITE_ONCE(vq->last_used_idx, last_used);
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
> +		last_used_idx = READ_ONCE(vq->last_used_idx);
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
> +	last_used_idx = READ_ONCE(vq->last_used_idx);
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

