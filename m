Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3504A8210
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349592AbiBCKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:08:48 -0500
Received: from foss.arm.com ([217.140.110.172]:36126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233557AbiBCKIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:08:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32747113E;
        Thu,  3 Feb 2022 02:08:47 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2FF3F40C;
        Thu,  3 Feb 2022 02:08:45 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:08:39 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com
Subject: Re: [PATCH v2 1/9] firmware: arm_scmi: Add a virtio channel refcount
Message-ID: <20220203100732.GA2535@e120937-lin>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-2-cristian.marussi@arm.com>
 <20220201165947-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201165947-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:05:27PM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 01, 2022 at 05:15:53PM +0000, Cristian Marussi wrote:
> > Currently SCMI VirtIO channels are marked with a ready flag and related
> > lock to track channel lifetime and support proper synchronization at
> > shutdown when virtqueues have to be stopped.
> > 
> > This leads to some extended spinlocked sections with IRQs off on the RX
> > path to keep hold of the ready flag and does not scale well especially when
> > SCMI VirtIO polling mode will be introduced.
> > 
> > Add an SCMI VirtIO channel dedicated refcount to track active users on both
> > the TX and the RX path and properly enforce synchronization and cleanup at
> > shutdown, inhibiting further usage of the channel once freed.
> > 
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/virtio.c | 148 +++++++++++++++++++----------
> >  1 file changed, 100 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> > index fd0f6f91fc0b..536e46eab462 100644
> > --- a/drivers/firmware/arm_scmi/virtio.c
> > +++ b/drivers/firmware/arm_scmi/virtio.c
> > @@ -17,7 +17,9 @@
> >   * virtqueue. Access to each virtqueue is protected by spinlocks.
> >   */
> >  

Hi Michael,

thanks for your review first of all.

> > +#include <linux/completion.h>
> >  #include <linux/errno.h>
> > +#include <linux/refcount.h>
> >  #include <linux/slab.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_config.h>
> > @@ -27,6 +29,7 @@
> >  
> >  #include "common.h"
> >  
> > +#define VIRTIO_MAX_RX_TIMEOUT_MS	60000
> >  #define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
> >  #define VIRTIO_SCMI_MAX_PDU_SIZE \
> >  	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
> > @@ -39,23 +42,21 @@
> >   * @cinfo: SCMI Tx or Rx channel
> >   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> >   * @is_rx: Whether channel is an Rx channel
> > - * @ready: Whether transport user is ready to hear about channel
> >   * @max_msg: Maximum number of pending messages for this channel.
> > - * @lock: Protects access to all members except ready.
> > - * @ready_lock: Protects access to ready. If required, it must be taken before
> > - *              lock.
> > + * @lock: Protects access to all members except users.
> > + * @shutdown_done: A reference to a completion used when freeing this channel.
> > + * @users: A reference count to currently active users of this channel.
> >   */
> >  struct scmi_vio_channel {
> >  	struct virtqueue *vqueue;
> >  	struct scmi_chan_info *cinfo;
> >  	struct list_head free_list;
> >  	bool is_rx;
> > -	bool ready;
> >  	unsigned int max_msg;
> > -	/* lock to protect access to all members except ready. */
> > +	/* lock to protect access to all members except users. */
> >  	spinlock_t lock;
> > -	/* lock to rotects access to ready flag. */
> > -	spinlock_t ready_lock;
> > +	struct completion *shutdown_done;
> > +	refcount_t users;
> >  };
> >  
> >  /**
> > @@ -76,6 +77,71 @@ struct scmi_vio_msg {
> >  /* Only one SCMI VirtIO device can possibly exist */
> >  static struct virtio_device *scmi_vdev;
> >  
> > +static void scmi_vio_channel_ready(struct scmi_vio_channel *vioch,
> > +				   struct scmi_chan_info *cinfo)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	cinfo->transport_info = vioch;
> > +	/* Indirectly setting channel not available any more */
> > +	vioch->cinfo = cinfo;
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	refcount_set(&vioch->users, 1);
> > +}
> > +
> > +static inline bool scmi_vio_channel_acquire(struct scmi_vio_channel *vioch)
> > +{
> > +	return refcount_inc_not_zero(&vioch->users);
> > +}
> > +
> > +static inline void scmi_vio_channel_release(struct scmi_vio_channel *vioch)
> > +{
> > +	if (refcount_dec_and_test(&vioch->users)) {
> > +		unsigned long flags;
> > +
> > +		spin_lock_irqsave(&vioch->lock, flags);
> > +		if (vioch->shutdown_done) {
> > +			vioch->cinfo = NULL;
> > +			complete(vioch->shutdown_done);
> > +		}
> > +		spin_unlock_irqrestore(&vioch->lock, flags);
> > +	}
> > +}
> > +
> > +static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
> > +{
> > +	int timeout;
> > +	char *vq_name;
> > +	unsigned long flags;
> > +	struct device *dev;
> > +	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
> > +
> > +	/*
> > +	 * Prepare to wait for the last release if not already released
> > +	 * or in progress.
> > +	 */
> > +	spin_lock_irqsave(&vioch->lock, flags);
> > +	if (!vioch->cinfo || vioch->shutdown_done) {
> > +		spin_unlock_irqrestore(&vioch->lock, flags);
> > +		return;
> > +	}
> > +	vioch->shutdown_done = &vioch_shutdown_done;
> > +	vq_name = vioch->is_rx ? "RX" : "TX";
> > +	/* vioch->cinfo could be NULLified after the release */
> > +	dev = vioch->cinfo->dev;
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	scmi_vio_channel_release(vioch);
> > +
> > +	timeout = msecs_to_jiffies(VIRTIO_MAX_RX_TIMEOUT_MS + 10);
> > +	/* Let any possibly concurrent RX path release the channel */
> > +	if (!wait_for_completion_timeout(vioch->shutdown_done, timeout))
> > +		dev_warn(dev,
> > +			 "Timeout shutting down %s VQ.\n", vq_name);
> > +}
> > +
> 
> Hmm. So if it times out then what? It's ok to corrupt memory then?
> Why? I suspect if you want to recover from this you need to mark device
> as broken, synchronize with all callbacks (we don't have an API
> for that but we really should). Only then you will know it's
> not doing anything.
> 

In fact I was not sure how to address this situation and not sure even
if it was a real possibility, but indeed a constant flood of evily
interleaved messages coming from the queues could keep the refcount
indefinitely > 0 (and the fact that I am shutting down is no excuse to
corrupt memory...my bad)

So what if I mark the device broken here BEFORE this possible final
release, so as to disrupt completely any communication on the virtqueus
at first (inhibiting also any callbacks invocation on IRQ) and then sync
on my channel refcount as it is now.
(and then just wait indefintely without any timeout..)

something like (not tried still..):

....
	vq_name = vioch->is_rx ? "RX" : "TX";
	/* vioch->cinfo could be NULLified after the release */
	dev = vioch->cinfo->dev;
+	virtio_break_device(vioch->vqueue->vdev);
	spin_unlock_irqrestore(&vioch->lock, flags);

	scmi_vio_channel_release(vioch);

	/* Let any possibly concurrent RX path release the channel */
+	wait_for_completion(vioch->shutdown_done);


Thanks,
Cristian

