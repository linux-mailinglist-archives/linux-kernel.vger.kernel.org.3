Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707F4B8BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiBPOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiBPOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:47:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112241BE05C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:47:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D29C6113E;
        Wed, 16 Feb 2022 06:47:30 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2422A3F66F;
        Wed, 16 Feb 2022 06:47:29 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:47:19 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 1/8] firmware: arm_scmi: Add a virtio channel refcount
Message-ID: <20220216144719.GD6072@e120937-lin>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-2-cristian.marussi@arm.com>
 <e63e2331-c30c-7151-9348-7f01850ff82e@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63e2331-c30c-7151-9348-7f01850ff82e@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:15:40AM +0100, Peter Hilber wrote:
> On 13.02.22 20:58, Cristian Marussi wrote:
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
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

Hi,

> > v2 --> v3
> > - Break virtio device at shutdown while cleaning up SCMI channel
> > ---
> >  drivers/firmware/arm_scmi/virtio.c | 140 +++++++++++++++++++----------
> >  1 file changed, 92 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> > index fd0f6f91fc0b..112d6bd4be2e 100644
> > --- a/drivers/firmware/arm_scmi/virtio.c
> > +++ b/drivers/firmware/arm_scmi/virtio.c
> > @@ -17,7 +17,9 @@
> >   * virtqueue. Access to each virtqueue is protected by spinlocks.
> >   */
> >  
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
> > @@ -76,6 +77,63 @@ struct scmi_vio_msg {
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
> > +	unsigned long flags;
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
> > +	virtio_break_device(vioch->vqueue->vdev);
> > +	spin_unlock_irqrestore(&vioch->lock, flags);
> > +
> > +	scmi_vio_channel_release(vioch);
> > +
> > +	/* Let any possibly concurrent RX path release the channel */
> > +	wait_for_completion(vioch->shutdown_done);
> > +}
> > +
> >  static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
> >  {
> >  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
> > @@ -119,7 +177,7 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
> >  
> >  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  {
> > -	unsigned long ready_flags;
> > +	unsigned long flags;
> >  	unsigned int length;
> >  	struct scmi_vio_channel *vioch;
> >  	struct scmi_vio_msg *msg;
> > @@ -130,27 +188,27 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> >  	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
> >  
> >  	for (;;) {
> > -		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
> > -
> > -		if (!vioch->ready) {
> > +		if (!scmi_vio_channel_acquire(vioch)) {
> >  			if (!cb_enabled)
> >  				(void)virtqueue_enable_cb(vqueue);
> 
> This seems unneeded ATM (in particular since the virtqueue is now broken when
> freeing the channel).
> 

Yes I was unsure indeed. I'll drop it.

Thanks,
Cristian

