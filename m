Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7BA4740F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhLNK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:57:07 -0500
Received: from foss.arm.com ([217.140.110.172]:51856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhLNK45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:56:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D3DC6D;
        Tue, 14 Dec 2021 02:56:56 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A41823F5A1;
        Tue, 14 Dec 2021 02:56:54 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:56:43 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 14/16] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20211214105643.GH6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-15-cristian.marussi@arm.com>
 <20211213113456.neztrurf3xxcraow@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213113456.neztrurf3xxcraow@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:34:56AM +0000, Sudeep Holla wrote:
> On Mon, Nov 29, 2021 at 07:11:54PM +0000, Cristian Marussi wrote:
> > Add support for .mark_txdone and .poll_done transport operations to SCMI
> > VirtIO transport as pre-requisites to enable atomic operations.
> > 
> > Add a Kernel configuration option to enable SCMI VirtIO transport polling
> > and atomic mode for selected SCMI transactions while leaving it default
> > disabled.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > V6 --> V7
> > - added a few comments about virtio polling internals
> > - fixed missing list_del on pending_cmds_list processing
> > - shrinked spinlocked areas in virtio_poll_done
> > - added proper spinlocking to scmi_vio_complete_cb while scanning list
> >   of pending cmds
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  |  15 ++
> >  drivers/firmware/arm_scmi/virtio.c | 241 +++++++++++++++++++++++++++--
> >  2 files changed, 243 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index d429326433d1..7794bd41eaa0 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
> >  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
> >  	  take care of the needed conversions, say N.
> >  
> > +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +	bool "Enable atomic mode for SCMI VirtIO transport"
> > +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> > +	help
> > +	  Enable support of atomic operation for SCMI VirtIO based transport.
> > +
> > +	  If you want the SCMI VirtIO based transport to operate in atomic
> > +	  mode, avoiding any kind of sleeping behaviour for selected
> > +	  transactions on the TX path, answer Y.
> > +
> > +	  Enabling atomic mode operations allows any SCMI driver using this
> > +	  transport to optionally ask for atomic SCMI transactions and operate
> > +	  in atomic context too, at the price of using a number of busy-waiting
> > +	  primitives all over instead. If unsure say N.
> > +
> >  endif #ARM_SCMI_PROTOCOL
> >  
> >  config ARM_SCMI_POWER_DOMAIN
> > diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> > index fd0f6f91fc0b..0598e185a786 100644
> > --- a/drivers/firmware/arm_scmi/virtio.c
> > +++ b/drivers/firmware/arm_scmi/virtio.c
> > @@ -38,6 +38,7 @@
> >   * @vqueue: Associated virtqueue
> >   * @cinfo: SCMI Tx or Rx channel
> >   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> > + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
> >   * @is_rx: Whether channel is an Rx channel
> >   * @ready: Whether transport user is ready to hear about channel
> >   * @max_msg: Maximum number of pending messages for this channel.
> > @@ -49,6 +50,9 @@ struct scmi_vio_channel {
> >  	struct virtqueue *vqueue;
> >  	struct scmi_chan_info *cinfo;
> >  	struct list_head free_list;
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> > +	struct list_head pending_cmds_list;
> > +#endif
> >  	bool is_rx;
> >  	bool ready;
> >  	unsigned int max_msg;
> > @@ -65,12 +69,22 @@ struct scmi_vio_channel {
> >   * @input: SDU used for (delayed) responses and notifications
> >   * @list: List which scmi_vio_msg may be part of
> >   * @rx_len: Input SDU size in bytes, once input has been received
> > + * @poll_idx: Last used index registered for polling purposes if this message
> > + *	      transaction reply was configured for polling.
> > + *	      Note that virtqueue used index is an unsigned 16-bit.
> > + * @poll_lock: Protect access to @poll_idx.
> >   */
> >  struct scmi_vio_msg {
> >  	struct scmi_msg_payld *request;
> >  	struct scmi_msg_payld *input;
> >  	struct list_head list;
> >  	unsigned int rx_len;
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> 
> Do we really need the #ifdefery for struct definition ? TBH I don't like
> the way it is. I would avoid it as much as possible. I assume some are
> added to avoid build warnings ?
> 
> Doesn't __maybe_unused help to remove some of them like the functions
> mark_txdone and poll_done. I haven't tried but thought of checking.
> 

Ok, I'll remove ifdeffery while addressing Peter concerns.

Thanks,
Cristian
