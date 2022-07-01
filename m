Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD94C5636CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiGAPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGAPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:18:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9542AC5C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:18:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA9F113E;
        Fri,  1 Jul 2022 08:18:33 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4CA3F66F;
        Fri,  1 Jul 2022 08:18:31 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:18:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 8/9] firmware: arm_scmi: Add scmi_driver optional
 setup/teardown callbacks
Message-ID: <20220701151829.j2blytsgma5so6ox@bogus>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-9-cristian.marussi@arm.com>
 <20220701140946.uar5ohadyjksf2ka@bogus>
 <Yr8I6KHUrOfLSmEj@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8I6KHUrOfLSmEj@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:09:05PM +0100, Cristian Marussi wrote:
> On Fri, Jul 01, 2022 at 03:09:46PM +0100, Sudeep Holla wrote:
> > On Mon, Jun 27, 2022 at 01:30:37PM +0100, Cristian Marussi wrote:
> > > Add optional .setup and .teardown methods to the scmi_driver descriptor:
> > > such callbacks, if provided, will be called by the SCIM core at driver
> > > registration time, so that, an SCMI driver, registered as usual with the
> > > module_scmi_driver() helper macro, can provide custom callbacks to be
> > > run once for all at module load/unload time to perform specific setup
> > > or teardown operations before/after .probe and .remove steps.
> > >
> > 
> > What can't the driver call this setup/teardown on its own before/after
> > calling scmi_driver_register/unregister ?
> 
> > 
> > Based on the usage in 9/9, I guess it is mainly to use the
> > module_scmi_driver ? If so, I would avoid using that or have another
> > macro to manage this setup/teardown(once there are multiple users for that).
> > IMO, it doesn't make sense to add callbacks to do things that are outside
> > the scope of scmi drivers. No ?
> >
> 
> This is exactly what I was doing in fact :D at first ... defining a normal
> init/exit from where I called what I needed at first and then ivoke the
> scmi_driver_register()...so bypassing/not using the module_scmi-driver macro
> indeed...then I realized I needed something similar also for the SCMI Test
> driver, so I tried to unify; in both cases indeed the required ops to be
> done before the scmi_driver_register are NOT scmi related things.
> 
> So I can drop this if you prefer and use bare module_init/exit that
> calls scmi_driver_register() after having setup what needed for the
> specific driver initialization (before probe)...I was not really
> convinced it was worth this level of unification.
> 

We can add macro for that too if there is another user for this. i.e.
if and when we merge the test code using something similar, we can
wrap them in a macro module_scmi_driver_setup_teardown(driver, setup, teardown)
and simplify things for the users.

-- 
Regards,
Sudeep
