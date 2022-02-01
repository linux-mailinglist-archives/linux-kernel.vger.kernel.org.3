Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB60D4A63CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiBAS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241009AbiBAS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643740067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZNaYTZmYX8SAV2IvxTXhkNs0jj6KRq86m7Q14LMjvE=;
        b=cfcgZZ5QoWr3ERX6OXl2YACg4rQZ8b6eGByzSe+csNMLay5EDmd2oqfhxVuX7Vh6SmMyeb
        0QSYIDFc67jSTNQWQD2PyOeAoo4RdOFyzebx6zhQddJeY0/l4zojaf5lu8wPmx3vDjj06T
        uKQQbCc8aGC3Cm5SiDwPSjD1XnENaVQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-gXB-erqKMt2uT9F7rA_BWg-1; Tue, 01 Feb 2022 13:27:46 -0500
X-MC-Unique: gXB-erqKMt2uT9F7rA_BWg-1
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so2081021wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZNaYTZmYX8SAV2IvxTXhkNs0jj6KRq86m7Q14LMjvE=;
        b=rI3uelo6p61mv5n7Z3VPpnOm7PjRo4TTkMcDEUgSriiphpEKMKtiJ7aV5OISsaoRf+
         MWUYcMCL6fu52zW8ZRBiZz4Qq1LiDVSDGFy8d57KAHxtn33CjRfKMlteTm/DeZDI9KS2
         cJlVmq2Kv581ub6zR1L/BZN60xbbnJ5q4xTgmZBZ8N3so8Znr30oGuf7Q9Smx62Vl+t5
         v3x1HBQm6UR9Xm9nt85hEzluQBpVhneWF/L9VLWrpBt03n/MtnU8ltw8D7rMAXBaSuqd
         CFD2BYEK5DOeCHhkXKBqg9bZ3/rMdUqA35xiRokBDjcilWAaqzd/7I+wZu0ONoq76zcI
         lYWA==
X-Gm-Message-State: AOAM531yTOWyECKX5cw/WulxiLJO5j0lfvmjxpAUXv/T8zSiadliKs2W
        vipyHgfB90RNUZSqk2wO3N4aVBHCfs84I6y5hKZ+v8erboZdCC0wfy9RoWqmbMzYaOo6h5v+USE
        NykIlLeWcrjsbHzrCe7d34qfK
X-Received: by 2002:a5d:5443:: with SMTP id w3mr22607761wrv.188.1643740065030;
        Tue, 01 Feb 2022 10:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoRnz9FX5T4stkcbEepAQH0Vaob3Ap3Q0yHX7Zr0nuN2RMKU9RMxJWLUqZMqXyQ2okix3BMQ==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr22607734wrv.188.1643740064752;
        Tue, 01 Feb 2022 10:27:44 -0800 (PST)
Received: from redhat.com ([2.55.147.35])
        by smtp.gmail.com with ESMTPSA id m64sm2760020wmm.31.2022.02.01.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:27:44 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:27:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque
 poll index value
Message-ID: <20220201131434-mutt-send-email-mst@kernel.org>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201171601.53316-4-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks correct, thanks. Some minor comments below:

On Tue, Feb 01, 2022 at 05:15:55PM +0000, Cristian Marussi wrote:
> Exported API virtqueue_poll() can be used to support polling mode operation
> on top of virtio layer if needed; currently the parameter last_used_idx is
> the opaque value that needs to be passed to the virtqueue_poll() function
> to check if there are new pending used buffers in the queue: such opaque
> value would have been previously obtained by a call to the API function
> virtqueue_enable_cb_prepare().
> 
> Since such opaque value is indeed containing simply a snapshot in time of
> the internal

to add: 16 bit

> last_used_index (roughly), it is possible that,

to add here: 

if another thread calls virtqueue_add_*()
at the same time (which existing drivers don't do,
but does not seem to be documented as prohibited anywhere), and

> if exactly
> 2**16 buffers are marked as used between two successive calls to
> virtqueue_poll(), the caller is fooled into thinking that nothing is
> pending (ABA problem).
> Keep a full fledged internal wraps counter

s/full fledged/a 16 bit/

since I don't see why is a 16 bit counter full but not e.g. a 32 bit one

> per virtqueue and embed it into
> the upper 16bits of the returned opaque value, so that the above scenario
> can be detected transparently by virtqueue_poll(): this way each single
> possible last_used_idx value is really belonging to a different wrap.

Just to add here: the ABA problem can in theory still happen but
now that's after 2^32 requests, which seems sufficient in practice.

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Still no perf data on this, I was wondering what exactly to measure in
> term of perf metrics to evaluate the impact of the rolling vq->wraps
> counter.
> ---
>  drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..613ec0503509 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -12,6 +12,8 @@
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <xen/xen.h>
>  
>  static bool force_used_validation = false;
> @@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>  
> +#define VRING_IDX_MASK					GENMASK(15, 0)
> +#define VRING_GET_IDX(opaque)				\
> +	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> +
> +#define VRING_WRAPS_MASK				GENMASK(31, 16)
> +#define VRING_GET_WRAPS(opaque)				\
> +	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> +
> +#define VRING_BUILD_OPAQUE(idx, wraps)			\
> +	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> +

Maybe prefix with VRING_POLL_  since that is the only user.


>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> @@ -117,6 +130,8 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> +	u16 wraps;
> +
>  	/* Hint for event idx: already triggered no need to disable. */
>  	bool event_triggered;
>  
> @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	ret = vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
>  	vq->last_used_idx++;
> +	if (unlikely(!vq->last_used_idx))
> +		vq->wraps++;
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */

So most drivers don't call virtqueue_poll.
Concerned about the overhead here: another option is
with a flag that will have to be set whenever a driver
wants to use virtqueue_poll.
Could you pls do a quick perf test e.g. using tools/virtio/
to see what's faster?



> @@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
>  		vq->last_used_idx -= vq->packed.vring.num;
>  		vq->packed.used_wrap_counter ^= 1;
> +		vq->wraps++;
>  	}
>  
>  	/*
> @@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->wraps = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->packed_ring = true;
> @@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>   */
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
> +	unsigned int last_used_idx;
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -				 virtqueue_enable_cb_prepare_split(_vq);
> +	last_used_idx = vq->packed_ring ?
> +			virtqueue_enable_cb_prepare_packed(_vq) :
> +			virtqueue_enable_cb_prepare_split(_vq);
> +
> +	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>   * @_vq: the struct virtqueue we're talking about.
>   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
>   *
> + * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
> + * is an opaque value representing the queue state and it is built as follows:
> + *
> + *	---------------------------------------------------------
> + *	|	vq->wraps	|	vq->last_used_idx	|
> + *	31------------------------------------------------------0
> + *
> + * The MSB 16bits embedding the wraps counter for the underlying virtqueue
> + * is stripped out here before reaching into the lower layer helpers.
> + *
> + * This structure of the opaque value mitigates the scenario in which, when
> + * exactly 2**16 messages are marked as used between two successive calls to
> + * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
> + * since the pure last_used_idx is exactly the same.
> + *

Do you want to move this comment to where the macros implementing it
are?

>   * Returns "true" if there are pending used buffers in the queue.
>   *
>   * This does not need to be serialized.
> @@ -2118,9 +2156,13 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  	if (unlikely(vq->broken))
>  		return false;
>  
> +	if (unlikely(vq->wraps != VRING_GET_WRAPS(last_used_idx)))
> +		return true;
> +
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -				 virtqueue_poll_split(_vq, last_used_idx);
> +	return vq->packed_ring ?
> +		virtqueue_poll_packed(_vq, VRING_GET_IDX(last_used_idx)) :
> +			virtqueue_poll_split(_vq, VRING_GET_IDX(last_used_idx));
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2245,6 +2287,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->wraps = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
> -- 
> 2.17.1

