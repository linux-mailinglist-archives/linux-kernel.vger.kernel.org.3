Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF90249DD51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiA0JIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:08:10 -0500
Received: from foss.arm.com ([217.140.110.172]:48898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234522AbiA0JIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:08:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F781FB;
        Thu, 27 Jan 2022 01:08:07 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56AB3F7D8;
        Thu, 27 Jan 2022 01:08:05 -0800 (PST)
Date:   Thu, 27 Jan 2022 09:07:59 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220127090759.GA5776@e120937-lin>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
 <20220124100341.41191-2-cristian.marussi@arm.com>
 <425e9a2b-a03f-a038-2598-33f28cd5f4e9@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425e9a2b-a03f-a038-2598-33f28cd5f4e9@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:28:52PM +0100, Peter Hilber wrote:
> On 24.01.22 11:03, Cristian Marussi wrote:
> > Add support for .mark_txdone and .poll_done transport operations to SCMI
> > VirtIO transport as pre-requisites to enable atomic operations.
> > 
> > Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > and atomic mode for selected SCMI transactions while leaving it default
> > disabled.
> > 
> 
> Hi Cristian,
> 

Hi Peter,

> please see one remark below.
> 
> Best regards,
> 
> Peter
> 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---

[snip]

> > +/**
> > + * virtio_poll_done  - Provide polling support for VirtIO transport
> > + *
> > + * @cinfo: SCMI channel info
> > + * @xfer: Reference to the transfer being poll for.
> > + *
> > + * VirtIO core provides a polling mechanism based only on last used indexes:
> > + * this means that it is possible to poll the virtqueues waiting for something
> > + * new to arrive from the host side but the only way to check if the freshly
> > + * arrived buffer was what we were waiting for is to compare the newly arrived
> > + * message descriptors with the one we are polling on.
> > + *
> > + * As a consequence it can happen to dequeue something different from the buffer
> > + * we were poll-waiting for: if that is the case such early fetched buffers are
> > + * then added to a the @pending_cmds_list list for later processing by a
> > + * dedicated deferred worker.
> > + *
> > + * So, basically, once something new is spotted we proceed to de-queue all the
> > + * freshly received used buffers until we found the one we were polling on, or,
> > + * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
> > + * in the vqueue at the end of the polling loop (possible due to inherent races
> > + * in virtqueues handling mechanisms), we similarly kick the deferred worker
> > + * and let it process those, to avoid indefinitely looping in the .poll_done
> > + * helper.
> > + *
> > + * Note that, since we do NOT have per-message suppress notification mechanism,
> > + * the message we are polling for could be delivered via usual IRQs callbacks
> > + * on another core which happened to have IRQs enabled: in such case it will be
> > + * handled as such by scmi_rx_callback() and the polling loop in the
> > + * SCMI Core TX path will be transparently terminated anyway.
> > + *
> > + * Return: True once polling has successfully completed.
> > + */
> > +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> > +			     struct scmi_xfer *xfer)
> > +{
> > +	bool pending, ret = false;
> > +	unsigned int length, any_prefetched = 0;
> > +	unsigned long flags;
> > +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> > +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> > +
> > +	if (!msg)
> > +		return true;
> > +
> > +	spin_lock_irqsave(&vioch->lock, flags);
> 
> If now acquiring vioch->lock here, I see no need to virtqueue_poll() any more.
> After checking msg->poll_status, we could just directly try virtqueue_get_buf().
> 
> On the other hand, always taking the vioch->lock in a busy loop might better be
> avoided (I assumed before that taking it was omitted on purpose), since it
> might hamper tx channel progress in other cores (but I'm not sure about the
> actual impact).
> 
> Also, I don't yet understand why the vioch->lock would need to be taken here.

There was a race I could reproduce between the below check against
VIO_MSG_POLL_DONE and the poll_idx later update near the end of the poll loop
where another thread could have set VIO_MSG_POLL_DONE after this thread
had checked it and then this same thread would have cleared it rewriting
the new poll_idx; so at first I needlessly enlanrged the spinlocked section
(even though I knew was subtopimal given virtqueue_poll does not need
serialization) and then forget to properly review this thing.

BUT now that, following your suggestion, I introduced a dedicated
poll_status that race is gone, so I shrinked back the spinlocked section
as before and works fine (even poll_idx itself does not need to be
protected really given it can be accessed only here)

I'll post the fix in -rc2 together with the core change in the
virtio-core I proposed last week to Michael (if not too costly as perfs)

Thanks,
Cristian
