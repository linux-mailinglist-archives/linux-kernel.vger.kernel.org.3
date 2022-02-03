Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2A4A8328
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350234AbiBCLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242857AbiBCLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643887956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itWiruytU2kLGOGapHpMQOUeYdsg6uAbojfcTpmhA2E=;
        b=TbI7e/nlDzsEU3kHhROZ8iXIB2Tf0jx5o8VMrkc8Of31Ihru2HVJWQI6gs8DvnN8ttwi7M
        p9IjKYiX3P/Dc0QqFOmVqXP9HNWBYdF+pclEbYDQ6wN8WyrTKVMbFjoBFq5BQu70rakZpG
        2tzM/J3pkjGCZn1HEg1UQ9YHMLSeSgw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-hcx4XKbxOPW6cEycXh4z_A-1; Thu, 03 Feb 2022 06:32:35 -0500
X-MC-Unique: hcx4XKbxOPW6cEycXh4z_A-1
Received: by mail-wr1-f71.google.com with SMTP id k7-20020adfb347000000b001dd761d46c7so552568wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=itWiruytU2kLGOGapHpMQOUeYdsg6uAbojfcTpmhA2E=;
        b=Cioj5c/WrRt4liLUB+ZNOSZQ1Fh4IPLSv6jREmwgs97T+2c3rQ0evjCV/1PGhdblyx
         y4SQTLp9BGi2mHj1S5PRbCIJ1UOmglkB6MoKQ8JhlccZpsRkB2OITS7pcf56TrgWuXFP
         98lKBfARMRCEu6FEzgq6MCaxu8Ui1ybPurn8ja+zgnnhZjbaS59RDcZwYKdEKrcrKn8f
         GCCnok6K84tzgx78XF6L4wbaoLX9Oy9Ny70Yp/sCafX6L/lzFRavAGs7Sn1UCO88+qCF
         HRRFLP9zCjz7jllGYmAoocZ7CjRKfVeCek2pVjuvOR1JWYffhztopsWEed61jJRgAC9Z
         Z3Cg==
X-Gm-Message-State: AOAM531jpcskAkcdZV7L5NT+dMeL/4Mlysne0Jg0doWTUgsxXKfHrmzl
        YidUS5mHZ9NfvNDWAWsA+GbrxFI70UxlLELN5A0883MjQJhrCSoTc3gmXoMdS6lBzD2f8ettu2L
        6jnk1hMLoW734I85rVqr+3oyN
X-Received: by 2002:a5d:588e:: with SMTP id n14mr30777354wrf.45.1643887954389;
        Thu, 03 Feb 2022 03:32:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdLaO64Cw0scAK+697PXreQjSocOclVGkxGWknz3mN3YgqgeWd6Q25NgJrPtGirlAqR87WZw==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr30777336wrf.45.1643887954184;
        Thu, 03 Feb 2022 03:32:34 -0800 (PST)
Received: from redhat.com ([2.52.9.182])
        by smtp.gmail.com with ESMTPSA id bg23sm8886500wmb.5.2022.02.03.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:32:33 -0800 (PST)
Date:   Thu, 3 Feb 2022 06:32:29 -0500
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
Message-ID: <20220203063115-mutt-send-email-mst@kernel.org>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
 <20220201131434-mutt-send-email-mst@kernel.org>
 <20220203105105.GB2535@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203105105.GB2535@e120937-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:51:19AM +0000, Cristian Marussi wrote:
> On Tue, Feb 01, 2022 at 01:27:38PM -0500, Michael S. Tsirkin wrote:
> > Looks correct, thanks. Some minor comments below:
> > 
> 
> Hi Michael,
> 
> thanks for the feedback.
> 
> > On Tue, Feb 01, 2022 at 05:15:55PM +0000, Cristian Marussi wrote:
> > > Exported API virtqueue_poll() can be used to support polling mode operation
> > > on top of virtio layer if needed; currently the parameter last_used_idx is
> > > the opaque value that needs to be passed to the virtqueue_poll() function
> > > to check if there are new pending used buffers in the queue: such opaque
> > > value would have been previously obtained by a call to the API function
> > > virtqueue_enable_cb_prepare().
> > > 
> > > Since such opaque value is indeed containing simply a snapshot in time of
> > > the internal
> > 
> > to add: 16 bit
> > 
> > > last_used_index (roughly), it is possible that,
> > 
> > to add here: 
> > 
> > if another thread calls virtqueue_add_*()
> > at the same time (which existing drivers don't do,
> > but does not seem to be documented as prohibited anywhere), and
> > 
> > > if exactly
> > > 2**16 buffers are marked as used between two successive calls to
> > > virtqueue_poll(), the caller is fooled into thinking that nothing is
> > > pending (ABA problem).
> > > Keep a full fledged internal wraps counter
> > 
> > s/full fledged/a 16 bit/
> > 
> > since I don't see why is a 16 bit counter full but not e.g. a 32 bit one
> > 
> .. :D I wanted to stress the fact that this being a 16bits counter has a
> higher rollover than a 1-bit one wrap_counter already used...but indeed
> all are just counters at the end, it's justthe wrapround that changes...
> 
> I'll fix.
> 
> > > per virtqueue and embed it into
> > > the upper 16bits of the returned opaque value, so that the above scenario
> > > can be detected transparently by virtqueue_poll(): this way each single
> > > possible last_used_idx value is really belonging to a different wrap.
> > 
> > Just to add here: the ABA problem can in theory still happen but
> > now that's after 2^32 requests, which seems sufficient in practice.
> > 
> 
> Sure, I'll fix the commit message as above advised.
> 
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > > Cc: virtualization@lists.linux-foundation.org
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > Still no perf data on this, I was wondering what exactly to measure in
> > > term of perf metrics to evaluate the impact of the rolling vq->wraps
> > > counter.
> > > ---
> > >  drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 47 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..613ec0503509 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -12,6 +12,8 @@
> > >  #include <linux/hrtimer.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/bitfield.h>
> > >  #include <xen/xen.h>
> > >  
> > >  static bool force_used_validation = false;
> > > @@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
> > >  #define LAST_ADD_TIME_INVALID(vq)
> > >  #endif
> > >  
> > > +#define VRING_IDX_MASK					GENMASK(15, 0)
> > > +#define VRING_GET_IDX(opaque)				\
> > > +	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> > > +
> > > +#define VRING_WRAPS_MASK				GENMASK(31, 16)
> > > +#define VRING_GET_WRAPS(opaque)				\
> > > +	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> > > +
> > > +#define VRING_BUILD_OPAQUE(idx, wraps)			\
> > > +	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> > > +
> > 
> > Maybe prefix with VRING_POLL_  since that is the only user.
> > 
> 
> I'll do.
> 
> > 
> > >  struct vring_desc_state_split {
> > >  	void *data;			/* Data for callback. */
> > >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> > > @@ -117,6 +130,8 @@ struct vring_virtqueue {
> > >  	/* Last used index we've seen. */
> > >  	u16 last_used_idx;
> > >  
> > > +	u16 wraps;
> > > +
> > >  	/* Hint for event idx: already triggered no need to disable. */
> > >  	bool event_triggered;
> > >  
> > > @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >  	ret = vq->split.desc_state[i].data;
> > >  	detach_buf_split(vq, i, ctx);
> > >  	vq->last_used_idx++;
> > > +	if (unlikely(!vq->last_used_idx))
> > > +		vq->wraps++;
> > >  	/* If we expect an interrupt for the next entry, tell host
> > >  	 * by writing event index and flush out the write before
> > >  	 * the read in the next get_buf call. */
> > 
> > So most drivers don't call virtqueue_poll.
> > Concerned about the overhead here: another option is
> > with a flag that will have to be set whenever a driver
> > wants to use virtqueue_poll.
> 
> Do you mean a compile time flag/Kconfig to just remove the possible
> overhead instructions as a whole when not needed by the driver ?
> 
> Or do you mean at runtime since checking the flag evry time should be
> less costly than checking the wrpas each time AND counting when it
> happens ?

The later.

> > Could you pls do a quick perf test e.g. using tools/virtio/
> > to see what's faster?
> 
> Yes I'll do, thanks for the hint, I have some compilation issues in
> tools/virtio due to my additions (missing mirrored hehaders) or to some
> recently added stuff (missing drv_to_virtio & friends for
> suppressed_used_validation thing)...anyway I fixed those now and I'll
> post related tools/virtio patches with next iteration.
> 
> Anyway, do you mean perf data about vringh_test and virtio_test/vhost
> right ? (ringtest/ excluded 'cause does not use any API is just
> prototyping)

can be either or both, virtio_test/vhost is a bit easier to use.

> > 
> > 
> > 
> > > @@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >  	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> > >  		vq->last_used_idx -= vq->packed.vring.num;
> > >  		vq->packed.used_wrap_counter ^= 1;
> > > +		vq->wraps++;
> > >  	}
> > >  
> > >  	/*
> > > @@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >  	vq->weak_barriers = weak_barriers;
> > >  	vq->broken = false;
> > >  	vq->last_used_idx = 0;
> > > +	vq->wraps = 0;
> > >  	vq->event_triggered = false;
> > >  	vq->num_added = 0;
> > >  	vq->packed_ring = true;
> > > @@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > >   */
> > >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > >  {
> > > +	unsigned int last_used_idx;
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  
> > >  	if (vq->event_triggered)
> > >  		vq->event_triggered = false;
> > >  
> > > -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> > > -				 virtqueue_enable_cb_prepare_split(_vq);
> > > +	last_used_idx = vq->packed_ring ?
> > > +			virtqueue_enable_cb_prepare_packed(_vq) :
> > > +			virtqueue_enable_cb_prepare_split(_vq);
> > > +
> > > +	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >  
> > > @@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >   * @_vq: the struct virtqueue we're talking about.
> > >   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> > >   *
> > > + * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
> > > + * is an opaque value representing the queue state and it is built as follows:
> > > + *
> > > + *	---------------------------------------------------------
> > > + *	|	vq->wraps	|	vq->last_used_idx	|
> > > + *	31------------------------------------------------------0
> > > + *
> > > + * The MSB 16bits embedding the wraps counter for the underlying virtqueue
> > > + * is stripped out here before reaching into the lower layer helpers.
> > > + *
> > > + * This structure of the opaque value mitigates the scenario in which, when
> > > + * exactly 2**16 messages are marked as used between two successive calls to
> > > + * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
> > > + * since the pure last_used_idx is exactly the same.
> > > + *
> > 
> > Do you want to move this comment to where the macros implementing it
> > are?
> > 
> 
> Sure, I'll do.
> 
> Thanks,
> Cristian

