Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59684740EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhLNKy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:54:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhLNKy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:54:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D3C6D;
        Tue, 14 Dec 2021 02:54:58 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE163F5A1;
        Tue, 14 Dec 2021 02:54:56 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:54:50 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v7 12/16] firmware: arm_scmi: Add atomic mode support to
 smc transport
Message-ID: <20211214105450.GG6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-13-cristian.marussi@arm.com>
 <20211213114233.iwxllcmggkwhglvm@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213114233.iwxllcmggkwhglvm@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:42:33AM +0000, Sudeep Holla wrote:
> On Mon, Nov 29, 2021 at 07:11:52PM +0000, Cristian Marussi wrote:
> > Add a Kernel configuration option to enable SCMI SMC transport atomic
> > mode operation for selected SCMI transactions and leave it as default
> > disabled.
> > 
> > Substitute mutex usages with busy-waiting and declare smc transport as
> > .atomic_enabled if such Kernel configuration option is enabled.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v5 --> v6
> > - remove usage of atomic_capable
> > - removed needless union
> > - reviewed Kconfig help
> > v4 --> v5
> > - removed RFC tag
> > - add CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE option
> > - add .atomic_enable support
> > - make atomic_capable dependent on
> >   CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > - make also usage of mutexes vs busy-waiting dependent on
> >   CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > ---
> >  drivers/firmware/arm_scmi/Kconfig | 14 +++++++
> >  drivers/firmware/arm_scmi/smc.c   | 66 ++++++++++++++++++++++++++++---
> >  2 files changed, 74 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index 638ecec89ff1..d429326433d1 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -78,6 +78,20 @@ config ARM_SCMI_TRANSPORT_SMC
> >  	  If you want the ARM SCMI PROTOCOL stack to include support for a
> >  	  transport based on SMC, answer Y.
> >  
> > +config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > +	bool "Enable atomic mode support for SCMI SMC transport"
> > +	depends on ARM_SCMI_TRANSPORT_SMC
> > +	help
> > +	  Enable support of atomic operation for SCMI SMC based transport.
> > +
> > +	  If you want the SCMI SMC based transport to operate in atomic
> > +	  mode, avoiding any kind of sleeping behaviour for selected
> > +	  transactions on the TX path, answer Y.
> > +	  Enabling atomic mode operations allows any SCMI driver using this
> > +	  transport to optionally ask for atomic SCMI transactions and operate
> > +	  in atomic context too, at the price of using a number of busy-waiting
> > +	  primitives all over instead. If unsure say N.
> > +
> >  config ARM_SCMI_TRANSPORT_VIRTIO
> >  	bool "SCMI transport based on VirtIO"
> >  	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
> > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > index b2f31d3feb10..0fc49cb49185 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/smc.c
> > @@ -7,6 +7,7 @@
> >   */
> >  
> >  #include <linux/arm-smccc.h>
> > +#include <linux/atomic.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > @@ -14,6 +15,9 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > +#include <linux/processor.h>
> > +#endif
> >  #include <linux/slab.h>
> >  
> >  #include "common.h"
> > @@ -23,14 +27,23 @@
> >   *
> >   * @cinfo: SCMI channel info
> >   * @shmem: Transmit/Receive shared memory area
> > - * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
> > + * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
> > + *		Used when NOT operating in atomic mode.
> > + * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
> > + *	      Used when operating in atomic mode.
> >   * @func_id: smc/hvc call function id
> >   */
> >  
> >  struct scmi_smc {
> >  	struct scmi_chan_info *cinfo;
> >  	struct scmi_shared_mem __iomem *shmem;
> > +#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > +	/* Protect access to shmem area */
> >  	struct mutex shmem_lock;
> 
> Ditto here, do we really need to do this saving ? I would wait until someone
> really complains about space. It unnecessarily makes it hard to read.
> 

Yes, indeed I can remove ifdeffery and go with runtime checks. I'll do.
> > +#else
> > +#define INFLIGHT_NONE	MSG_TOKEN_MAX
> > +	atomic_t inflight;
> > +#endif
> >  	u32 func_id;
> >  };
> >  
> > @@ -54,6 +67,46 @@ static bool smc_chan_available(struct device *dev, int idx)
> >  	return true;
> >  }
> >  
> > +static inline void smc_channel_lock_init(struct scmi_smc *scmi_info)
> > +{
> > +#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > +	mutex_init(&scmi_info->shmem_lock);
> > +#else
> > +	atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
> 
> You can do both if you remove conditional definition of struct.
> 

Yes.

> > +#endif
> > +}
> > +
> > +#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> > +static bool smc_xfer_inflight(struct scmi_xfer *xfer, atomic_t *inflight)
> > +{
> > +	int ret;
> > +
> > +	ret = atomic_cmpxchg(inflight, INFLIGHT_NONE, xfer->hdr.seq);
> > +
> > +	return ret == INFLIGHT_NONE;
> > +}
> > +#endif
> > +
> > +static inline void
> > +smc_channel_lock_acquire(struct scmi_smc *scmi_info,
> > +			 struct scmi_xfer *xfer __maybe_unused)
> > +{
> > +#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> 
> If possible make it based some local variable or you can always do
> 
> 	if (IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE))
> 

I'll do.

Thanks,
Cristian
