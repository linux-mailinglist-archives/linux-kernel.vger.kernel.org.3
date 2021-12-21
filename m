Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE747C833
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhLUUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:23:42 -0500
Received: from foss.arm.com ([217.140.110.172]:60078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhLUUXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:23:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8A2ED1;
        Tue, 21 Dec 2021 12:23:40 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185D33F718;
        Tue, 21 Dec 2021 12:23:38 -0800 (PST)
Date:   Tue, 21 Dec 2021 20:23:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v8 01/11] firmware: arm_scmi: Add configurable polling
 mode for transports
Message-ID: <20211221202336.ebkpfoernygotepp@bogus>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-2-cristian.marussi@arm.com>
 <20211221193852.pmb4nu43zzu6trqt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221193852.pmb4nu43zzu6trqt@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 01:08:54AM +0530, Pratyush Yadav wrote:
> Hi,
> 
> On 20/12/21 07:56PM, Cristian Marussi wrote:
> > SCMI communications along TX channels can optionally be provided of a
> > completion interrupt; when such interrupt is not available, command
> > transactions should rely on polling, where the SCMI core takes care to
> > repeatedly evaluate the transport-specific .poll_done() function, if
> > available, to determine if and when a request was fully completed or
> > timed out.
> > 
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
> 
> This patch breaks linux-next build for me with LLVM.
> 
> drivers/firmware/arm_scmi/driver.c:869:6: error: variable 'i_' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         if (IS_POLLING_ENABLED(cinfo, info))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/arm_scmi/driver.c:59:33: note: expanded from macro 'IS_POLLING_ENABLED'
>                         IS_TRANSPORT_POLLING_CAPABLE(i_));              \
>                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/firmware/arm_scmi/driver.c:45:19: note: expanded from macro 'IS_TRANSPORT_POLLING_CAPABLE'
>         typeof(__i) i_ = __i;                                           \
>                     ~~   ^~~
> 1 error generated.
> 

Thanks for the report. The bot complained last night and I have pushed
the update though not in time for linux-next today, must make it to
tomorrow's cut.

--
Regards,
Sudeep
