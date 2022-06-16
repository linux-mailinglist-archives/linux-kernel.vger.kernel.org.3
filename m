Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C954DAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359045AbiFPGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358754AbiFPGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354F9E09C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655361758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hKBsqqF9iM7wCkQHKkjJhfnlmx1MpDb85k4E3ksF7E=;
        b=NBW0pPJaFTn/fmufBkO3ab9Th1OLojpWwpmxz1tb9tnViKLnL/AS95r2wDKbph44g8fAcX
        ieY8pNYAXXgmsxB+t0I/mnHTeNYrWc/sRE+NMJOIvFCVCAb8wXqkVHSoRUs2gjDZPc8Y0l
        OtyAKkA7CKs8uci7Ks3c3X8TcBvjKe8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-xzefLD8hNmy-l6DaFplLLQ-1; Thu, 16 Jun 2022 02:42:29 -0400
X-MC-Unique: xzefLD8hNmy-l6DaFplLLQ-1
Received: by mail-wm1-f70.google.com with SMTP id r83-20020a1c4456000000b0039c8f5804c4so657382wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5hKBsqqF9iM7wCkQHKkjJhfnlmx1MpDb85k4E3ksF7E=;
        b=m9OrsOdsxnbdDTJSo4pJWYl2As3dTKLl8PI8EM/DUMm+X2aJN/IP35BEd5qd890BcS
         IxcRvhqFnJw9jMTf7DRhQEHkm+jMZ6l7bNLto+2zCONeJkitdJ98mB5mwn6AWptReYXV
         9t2AQsvfj4GcyNKKG/UiRnJ5pzLIvnlbs/X1pUoiUjFpEtPQl8kbc2/7oxfe8JHWUWYe
         RjKx6Nw90edjs86DWrMlXwfYqy3Smr0HO1PQ+J6GXhV0M1spt4XRTv71afOYYHt/1bdD
         ZnKHHiB7iEZJHZBkDoRIBnkQ8Ivzxdxr6raC3crjbOtkGlZTNV46XTVpWN9cd2prK/V9
         /m4A==
X-Gm-Message-State: AOAM530IkPowZ4Nj4XlYX9fapAtrDMasJJobO5uFqZ3zDoY3fMb7Au/R
        xoceQtH2GUhInvQgcsTlYZBxzmuiCGMD7XfcM6b+39m5He8i8SIjjZzSJxGeHho4TAHe6n/2gPt
        I5QiUxYHmcYFpRPybjLiwoKUL
X-Received: by 2002:a7b:cd16:0:b0:39c:4fff:88cc with SMTP id f22-20020a7bcd16000000b0039c4fff88ccmr13564761wmj.122.1655361748309;
        Wed, 15 Jun 2022 23:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhbOPd8VRoXb4skZki7wrmCRjEAVTwkgPiOKOCqccbZNh39gvdtqOded3/KjKHMKlAZkQbbg==
X-Received: by 2002:a7b:cd16:0:b0:39c:4fff:88cc with SMTP id f22-20020a7bcd16000000b0039c4fff88ccmr13564752wmj.122.1655361747969;
        Wed, 15 Jun 2022 23:42:27 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107d:d500:e9ae:3150:6c35:ac38])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d5641000000b0021108003596sm932162wrw.10.2022.06.15.23.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:42:27 -0700 (PDT)
Date:   Thu, 16 Jun 2022 02:42:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     jasowang@redhat.com, yuanzhu@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_ring : keep used_wrap_counter in
 vq->last_used_idx
Message-ID: <20220616024148-mutt-send-email-mst@kernel.org>
References: <CACGkMEtz-1=3=+zUZvc+CX4LrufZZfZO=_zONo5GuAUX+BrpAQ@mail.gmail.com>
 <20220616051221.28506-1-huangjie.albert@bytedance.com>
 <20220616015331-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616015331-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 02:07:19AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 16, 2022 at 01:12:21PM +0800, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > 
> > the used_wrap_counter and the vq->last_used_idx may get
> > out of sync if they are separate assignment，and interrupt
> > might use an incorrect value to check for the used index.
> > 
> > for example:OOB access
> > ksoftirqd may consume the packet and it will call:
> > virtnet_poll
> > 	-->virtnet_receive
> > 		-->virtqueue_get_buf_ctx
> > 			-->virtqueue_get_buf_ctx_packed
> > and in virtqueue_get_buf_ctx_packed:
> > 
> > vq->last_used_idx += vq->packed.desc_state[id].num;
> > if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> >          vq->last_used_idx -= vq->packed.vring.num;
> >          vq->packed.used_wrap_counter ^= 1;
> > }
> > 
> > if at the same time, there comes a vring interrupt，in vring_interrupt:
> > we will call:
> > vring_interrupt
> > 	-->more_used
> > 		-->more_used_packed
> > 			-->is_used_desc_packed
> > in is_used_desc_packed, the last_used_idx maybe >= vq->packed.vring.num.
> > so this could case a memory out of bounds bug.
> > 
> > this patch is to keep the used_wrap_counter in vq->last_used_idx
> > so we can get the correct value to check for used index in interrupt.
> > 
> > v1->v2:
> > - reuse the VRING_PACKED_EVENT_F_WRAP_CTR
> > - Remove parameter judgment in is_used_desc_packed,
> > because it can't be illegal
> > 
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> 
> 
> This looks good, just a small suggestion below:
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 57 ++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 13a7348cedff..b22d97c9a755 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -111,7 +111,12 @@ struct vring_virtqueue {
> >  	/* Number we've added since last sync. */
> >  	unsigned int num_added;
> >  
> > -	/* Last used index we've seen. */
> > +	/* Last used index  we've seen.
> > +	 * for split ring, it just contains last used index
> > +	 * for packed ring, it not only contains last used index, but also
> > +	 * used_wrap_counter, the VRING_PACKED_EVENT_F_WRAP_CTR is
> > +	 * the bit shift in last_used_idx
> > +	 */
> >  	u16 last_used_idx;
> >  
> >  	/* Hint for event idx: already triggered no need to disable. */
> > @@ -154,9 +159,6 @@ struct vring_virtqueue {
> >  			/* Driver ring wrap counter. */
> >  			bool avail_wrap_counter;
> >  
> > -			/* Device ring wrap counter. */
> > -			bool used_wrap_counter;
> > -
> >  			/* Avail used flags. */
> >  			u16 avail_used_flags;
> >  
> > @@ -1406,8 +1408,12 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> >  
> >  static inline bool more_used_packed(const struct vring_virtqueue *vq)
> >  {
> > -	return is_used_desc_packed(vq, vq->last_used_idx,
> > -			vq->packed.used_wrap_counter);
> > +	u16 last_used;
> > +	bool used_wrap_counter;
> > +
> > +	last_used = vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> 
> This only works if last_used_idx is 16 bit and
> VRING_PACKED_EVENT_F_WRAP_CTR is 15.
> 
> I think you want 
> /* all bits below VRING_PACKED_EVENT_F_WRAP_CTR */
> vq->last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> 
> 
> > +	used_wrap_counter = !!((vq->last_used_idx) >> VRING_PACKED_EVENT_F_WRAP_CTR);
> 
> 
> A bit more efficient and clear:
> 
> !!(q->last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> 
> 
> 
> Also this logic is repeated in multiple places. Let's add a couple of inline
> functions:
> 
> static inline bool packed_used_wrap_counter(vq)
> 
> static inline u16 packed_last_used(vq)

Or better:

packed_used_wrap_counter(u16 last_used_idx)
packed_last_used(u16 last_used_idx)


> then use these everywhere.
> 
> 
> > +	return is_used_desc_packed(vq, last_used, used_wrap_counter);
> >  }
> >  
> >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > @@ -1416,6 +1422,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  	u16 last_used, id;
> > +	bool used_wrap_counter;
> >  	void *ret;
> >  
> >  	START_USE(vq);
> > @@ -1434,7 +1441,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	/* Only get used elements after they have been exposed by host. */
> >  	virtio_rmb(vq->weak_barriers);
> >  
> > -	last_used = vq->last_used_idx;
> > +	used_wrap_counter = !!((vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR));
> > +	last_used = (vq->last_used_idx) & (~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> >  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> >  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> >  
> > @@ -1451,12 +1459,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	ret = vq->packed.desc_state[id].data;
> >  	detach_buf_packed(vq, id, ctx);
> >  
> > -	vq->last_used_idx += vq->packed.desc_state[id].num;
> > -	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> > -		vq->last_used_idx -= vq->packed.vring.num;
> > -		vq->packed.used_wrap_counter ^= 1;
> > +	last_used += vq->packed.desc_state[id].num;
> > +	if (unlikely(last_used >= vq->packed.vring.num)) {
> > +		last_used -= vq->packed.vring.num;
> > +		used_wrap_counter ^= 1;
> >  	}
> >  
> > +	last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
> > +	vq->last_used_idx = last_used;
> > +
> >  	/*
> >  	 * If we expect an interrupt for the next entry, tell host
> >  	 * by writing event index and flush out the write before
> > @@ -1465,9 +1476,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> >  		virtio_store_mb(vq->weak_barriers,
> >  				&vq->packed.vring.driver->off_wrap,
> > -				cpu_to_le16(vq->last_used_idx |
> > -					(vq->packed.used_wrap_counter <<
> > -					 VRING_PACKED_EVENT_F_WRAP_CTR)));
> > +				cpu_to_le16(vq->last_used_idx));
> >  
> >  	LAST_ADD_TIME_INVALID(vq);
> >  
> > @@ -1499,9 +1508,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >  
> >  	if (vq->event) {
> >  		vq->packed.vring.driver->off_wrap =
> > -			cpu_to_le16(vq->last_used_idx |
> > -				(vq->packed.used_wrap_counter <<
> > -				 VRING_PACKED_EVENT_F_WRAP_CTR));
> > +			cpu_to_le16(vq->last_used_idx);
> >  		/*
> >  		 * We need to update event offset and event wrap
> >  		 * counter first before updating event flags.
> > @@ -1518,8 +1525,7 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >  	}
> >  
> >  	END_USE(vq);
> > -	return vq->last_used_idx | ((u16)vq->packed.used_wrap_counter <<
> > -			VRING_PACKED_EVENT_F_WRAP_CTR);
> > +	return vq->last_used_idx;
> >  }
> >  
> >  static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> > @@ -1550,9 +1556,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  	if (vq->event) {
> >  		/* TODO: tune this threshold */
> >  		bufs = (vq->packed.vring.num - vq->vq.num_free) * 3 / 4;
> > -		wrap_counter = vq->packed.used_wrap_counter;
> > +		wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
> >  
> > -		used_idx = vq->last_used_idx + bufs;
> > +		used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + bufs;
> >  		if (used_idx >= vq->packed.vring.num) {
> >  			used_idx -= vq->packed.vring.num;
> >  			wrap_counter ^= 1;
> > @@ -1582,9 +1588,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  	 */
> >  	virtio_mb(vq->weak_barriers);
> >  
> > -	if (is_used_desc_packed(vq,
> > -				vq->last_used_idx,
> > -				vq->packed.used_wrap_counter)) {
> > +	wrap_counter = !!(vq->last_used_idx >> VRING_PACKED_EVENT_F_WRAP_CTR);
> > +	used_idx = (vq->last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> > +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> >  		END_USE(vq);
> >  		return false;
> >  	}
> > @@ -1689,7 +1695,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->notify = notify;
> >  	vq->weak_barriers = weak_barriers;
> >  	vq->broken = true;
> > -	vq->last_used_idx = 0;
> > +	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> >  	vq->packed_ring = true;
> > @@ -1720,7 +1726,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  
> >  	vq->packed.next_avail_idx = 0;
> >  	vq->packed.avail_wrap_counter = 1;
> > -	vq->packed.used_wrap_counter = 1;
> >  	vq->packed.event_flags_shadow = 0;
> >  	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
> >  
> > -- 
> > 2.31.1

