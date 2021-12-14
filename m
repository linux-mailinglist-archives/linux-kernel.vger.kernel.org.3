Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638214740D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhLNKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:52:46 -0500
Received: from foss.arm.com ([217.140.110.172]:51734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhLNKwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:52:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE246D;
        Tue, 14 Dec 2021 02:52:44 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D97DA3F5A1;
        Tue, 14 Dec 2021 02:52:42 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:52:40 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v7 08/16] firmware: arm_scmi: Add
 sync_cmds_atomic_replies transport flag
Message-ID: <20211214105240.GF6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-9-cristian.marussi@arm.com>
 <20211213115437.23ecitnqztx5yl7g@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213115437.23ecitnqztx5yl7g@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:54:37AM +0000, Sudeep Holla wrote:
> On Mon, Nov 29, 2021 at 07:11:48PM +0000, Cristian Marussi wrote:
> > Add a flag to let the transport signal to the core if its handling of sync
> > command implies that, after .send_message has returned successfully, the
> > requested command can be assumed to be fully and completely executed on
> > SCMI platform side so that any possible response value is already
> > immediately available to be retrieved by a .fetch_response: in other words
> > the polling phase can be skipped in such a case and the response values
> > accessed straight away.
> > 
> > Note that all of the above applies only when polling mode of operation was
> > selected by the core: if instead a completion IRQ was found to be available
> > the normal response processing path based on completions will still be
> > followed.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v5 --> v6
> > - added polling_capable helper flag
> > v4 --> v5
> > - removed RFC tag
> > - consider sync_cmds_atomic_replies flag when deciding if polling is to be
> >   supported and .poll_done() is not provided.
> > - reviewed commit message
> > ---
> >  drivers/firmware/arm_scmi/common.h |  8 ++++++
> >  drivers/firmware/arm_scmi/driver.c | 43 +++++++++++++++++++++++-------
> >  2 files changed, 41 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 99b74f4d39b6..bf25f0e89c78 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -412,6 +412,13 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
> >   * @max_msg_size: Maximum size of data per message that can be handled.
> >   * @force_polling: Flag to force this whole transport to use SCMI core polling
> >   *		   mechanism instead of completion interrupts even if available.
> > + * @sync_cmds_atomic_replies: Flag to indicate that the transport assures
> > + *			      synchronous-command messages are atomically
> > + *			      completed on .send_message: no need to poll
> > + *			      actively waiting for a response.
> 
> Not sure if atomic is right term to use. It is atomic w.r.t OSPM though.
> Can we just say sync_cmd_complete_on_ret or something similar.
> 
Yes, I really never liked the naming so I'll happily take you suggestion :D

Thanks,
Cristian
