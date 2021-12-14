Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709854740CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhLNKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:49:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhLNKt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:49:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B05E26D;
        Tue, 14 Dec 2021 02:49:57 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6138A3F5A1;
        Tue, 14 Dec 2021 02:49:56 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:49:49 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v7 06/16] firmware: arm_scmi: Add configurable polling
 mode for transports
Message-ID: <20211214104949.GE6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-7-cristian.marussi@arm.com>
 <20211213112555.vhjhu3xopesvxmio@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213112555.vhjhu3xopesvxmio@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:25:55AM +0000, Sudeep Holla wrote:
> On Mon, Nov 29, 2021 at 07:11:46PM +0000, Cristian Marussi wrote:
> > SCMI communications along TX channels can optionally be provided of a
> > completion interrupt; when such interrupt is not available, command
> > transactions should rely on polling, where the SCMI core takes care to
> > repeatedly evaluate the transport-specific .poll_done() function, if
> > available, to determine if and when a request was fully completed or
> > timed out.
> > 

Hi Sudeep, 

thanks for the review.

> > Such mechanism is already present and working on a single transfer base:
> > SCMI protocols can indeed enable hdr.poll_completion on specific commands
> > ahead of each transfer and cause that transaction to be handled with
> > polling.
> > 
> > Introduce a couple of flags to be able to enforce such polling behaviour
> > globally at will:
> > 
> >  - scmi_desc.force_polling: to statically switch the whole transport to
> >    polling mode.
> > 
> >  - scmi_chan_info.no_completion_irq: to switch a single channel dynamically
> >    to polling mode if, at runtime, is determined that no completion
> >    interrupt was available for such channel.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v5 --> v6
> > - removed check on replies received by IRQs when xfer was requested
> >   as poll_completion (not all transport can suppress IRQs on an xfer basis)
> > v4 --> v5
> > - make force_polling const
> > - introduce polling_enabled flag to simplify checks on do_xfer
> > v3 --> v4:
> > - renamed .needs_polling flag to .no_completion_irq
> > - refactored error path when polling needed but not supported
> > ---
> >  drivers/firmware/arm_scmi/common.h | 11 +++++++++++
> >  drivers/firmware/arm_scmi/driver.c | 17 +++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 6438b5248c24..99b74f4d39b6 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -339,11 +339,19 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
> >   * @dev: Reference to device in the SCMI hierarchy corresponding to this
> >   *	 channel
> >   * @handle: Pointer to SCMI entity handle
> > + * @no_completion_irq: Flag to indicate that this channel has no completion
> > + *		       interrupt mechanism for synchronous commands.
> > + *		       This can be dynamically set by transports at run-time
> > + *		       inside their provided .chan_setup().
> > + * @polling_enabled: Flag used to annotate if polling mode is currently enabled
> > + *		     on this channel.
> >   * @transport_info: Transport layer related information
> >   */
> >  struct scmi_chan_info {
> >  	struct device *dev;
> >  	struct scmi_handle *handle;
> > +	bool no_completion_irq;
> > +	bool polling_enabled;
> 
> Do we really need a separate flag for polling_enabled ?
> no_completion_irq means you need to enable polling and force_polling too.
> Just trying to see if we can get rid of unnecessary flags.
> 

Not really needed indeed, I was just trying to avoid multiple conditions
checks later on the TX path (given no_completion_irq and force_polling
never change after channel setup so I can just note down at setup that
polling is enabled and then just check that later) and improve readability,
but I can just use macros for readability and just ignore the multiple
unneeded checks.

Same holds later on the series for polling_capable flag that I similarly
setup early during probe to avoid unneeded multiple condition checks.

I'll remove both this internal flags and resort to macros, if it's fine
for you.

Thanks,
Cristian
