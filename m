Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E9563664
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGAPAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGAPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:00:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF85533342
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:00:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55F6113E;
        Fri,  1 Jul 2022 08:00:11 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2F73F66F;
        Fri,  1 Jul 2022 08:00:10 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:00:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, f.fainelli@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/5] firmware: arm_scmi: Support only one single
 SystemPower device
Message-ID: <20220701150008.qsxg5outpqrsce5n@bogus>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
 <20220623124742.2492164-3-cristian.marussi@arm.com>
 <20220701134509.e6wk3vwhimqre6h5@bogus>
 <Yr8FG9/f60AVg7qJ@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8FG9/f60AVg7qJ@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:31:18PM +0100, Cristian Marussi wrote:
> On Fri, Jul 01, 2022 at 02:45:09PM +0100, Sudeep Holla wrote:
> > On Thu, Jun 23, 2022 at 01:47:39PM +0100, Cristian Marussi wrote:
> > > In order to minimize SCMI platform fw-side complexity, only one single SCMI
> > > platform should be in charge of SCMI SystemPower protocol communications
> > > with the OSPM: enforce the existence of one single unique device associated
> > > with SystemPower protocol across any possible number of SCMI platforms, and
> > > warn if a system tries to register different SystemPower devices from
> > > multiple platforms.
> > > 
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/firmware/arm_scmi/bus.c | 31 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > > index a7cbf4d09081..476855d3dccb 100644
> > > --- a/drivers/firmware/arm_scmi/bus.c
> > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > @@ -19,6 +19,11 @@ static DEFINE_IDA(scmi_bus_id);
> > >  static DEFINE_IDR(scmi_protocols);
> > >  static DEFINE_SPINLOCK(protocol_lock);
> > >  
> > > +/* Track globally the creation of SCMI SystemPower related devices */
> > > +static bool scmi_syspower_registered;
> > > +/* Protect access to scmi_syspower_registered */
> > > +static DEFINE_MUTEX(scmi_syspower_mtx);
> > > +
> > 
> 
> Hi Sudeep,
> 
> thanks for the review first of all.
> 
> > Since we create device from the driver, can't we do this from there
> > and keep the bus code free from handling all these special conditions
> > which are checked for each device creation.
> > 
> > Yes scmi_device_create can be called outside the exiting code but since it
> > is not exported(yet), we can assume all users are in kernel and we can
> > catch that if anyone attempts to add. And probably we don't need the lock
> > as well if it is taken care in the single loop creating the device.
> > 
> 
> Do you mean to move the check inside driver.c common routines like in
> scmi_get_protocol_device() right before calling scmi_device_create() ?
> 
> If this is what you meant, yes I can do that to avoid polluting the
> bus code...indeed it would be easier than dealing with all the internals
> in scmi_device_create() like it is now, BUT regarding the mutex I'm not so
> sure I can avoid it since the device creation is triggered at the end of
> main platform probe (driver:scmi_probe()) BUT potentially also whenever a
> new SCMI driver is (lately) loaded and asks for the device creation after
> (or worst concurrently to) the main probe loop.
>

You got it right, I meant exactly that.

Agreed and that's why I mentioned we don't export that and hence it is not
possible. I don't want to make bus code complex checking for this. We may
have to do that if that is the only way in the future, but let us defer
until we have to.

> Beside that, there is the case of definitions of multiple SCMI platforms,
> which is not officially supported I know but that is, in my understanding,
> one of the most possible cause of having multiple instances of an SCMI
> SystemPower driver trying to register. (i.e. multiple scmi DT nodes ALL
> defining a SystemPower protocol with potentially multiple underlying FWs
> advertising SystemPower support which was the thing we wanted to avoid
> promoting ... AFAIU...but I could be missing something..)
>

Agreed, I am not questioning the addition of this change, just how and where
:).

-- 
Regards,
Sudeep
