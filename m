Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC351034B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352981AbiDZQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbiDZQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:28:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DD90169417
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:25:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E12B23A;
        Tue, 26 Apr 2022 09:25:36 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78D63F73B;
        Tue, 26 Apr 2022 09:25:34 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:25:28 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 02/22] firmware: arm_scmi: Make protocols init fail on
 basic errors
Message-ID: <Ymgc+AkuWiVCuCHw@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-3-cristian.marussi@arm.com>
 <20220426153528.bhskpchq2huhjtjk@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426153528.bhskpchq2huhjtjk@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:35:28PM +0100, Sudeep Holla wrote:
> On Wed, Mar 30, 2022 at 04:05:31PM +0100, Cristian Marussi wrote:
> > Bail out of protocol initialization routine early when basic information
> > about protocol version and attributes could not be retrieved: failing to
> > act this way can lead to a successfully initialized SCMI protocol which
> > is in fact not fully functional.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/base.c    |  5 ++++-
> >  drivers/firmware/arm_scmi/clock.c   |  8 ++++++--
> >  drivers/firmware/arm_scmi/perf.c    | 10 +++++++---
> >  drivers/firmware/arm_scmi/power.c   | 10 +++++++---
> >  drivers/firmware/arm_scmi/reset.c   | 10 +++++++---
> >  drivers/firmware/arm_scmi/sensors.c |  4 +++-
> >  drivers/firmware/arm_scmi/system.c  |  5 ++++-
> >  7 files changed, 38 insertions(+), 14 deletions(-)
> >

Hi Sudeep,

thanks for the review first of all...

> > @@ -370,7 +372,9 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
> >  	if (!cinfo)
> >  		return -ENOMEM;
> >
> > -	scmi_clock_protocol_attributes_get(ph, cinfo);
> > +	ret = scmi_clock_protocol_attributes_get(ph, cinfo);
> > +	if (ret)
> > +		return ret;
> 
> Does this result in removal of scmi_dev associated with devm_* calls ?
> Otherwise we may need to free the allocated buffers ? I am not sure
> if the dev here is individual scmi_dev or the platform scmi device.
> I assume latter and it is unlikely to be removed/freed with the error in
> the above path.
> 
> Similarly in couple of other instances/protocols.

So, ph->dev used in the above devm_ is indeed the arm_scmi platform device
and I was *almost* gonna tell you 'Good catch', BUT then, rereading my own
code (O_o), I saw/remembered that when a protocol instance is initialized on
it first usage, there is indeed a devres_group internally managed by
the SCMI core, so that:

scmi_get_protocol_instance()

	@first_protocol_usage (refcount pi->users):

	--> scmi_get_protocol() // just in case was LKM proto
	--> scmi_alloc_init_protocol_instance()
		gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);

  		ret = pi->proto->instance_init(&pi->ph);
		  ====>>> i.e. scmi_clock_protocol_init(ph)
		if (ret)
			goto clean;
	.....

	   clean:
	   	devres_release_group(handle->dev, gid);


So basically all that happens at initialization time in scmi_clock_protocol_init,
BUT also everything that happens implicitly inside scmi_alloc_init_protocol_instance
during that protocol initialization (like the events registration) is undone on
failure transparently by the SCMI core init/free management functions
(via devres_ groups...)

All of the above is because each protocol is initialized only once on
its first usage, no matter how many SCMI driver users (and scmi_devs) are
using it...only in case (unsupported) we have multiple SCMI instances
(platforms) there will be one instance of protocol initialized per SCMI
server.

... having said that, now I'll go and double check (test) this behaviour since I
even had forgot about having implemented this kind of design :P

Thanks,
Cristian
