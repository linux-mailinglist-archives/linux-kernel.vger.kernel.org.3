Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BA3563617
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGAOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiGAOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:47:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 008701658A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:47:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA541143D;
        Fri,  1 Jul 2022 07:47:24 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D082B3F792;
        Fri,  1 Jul 2022 07:47:22 -0700 (PDT)
Date:   Fri, 1 Jul 2022 15:47:20 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make use of FastChannels
 configurable
Message-ID: <Yr8GsvW+cnf3PkSG@e120937-lin>
References: <20220627123038.1427067-1-cristian.marussi@arm.com>
 <20220627123038.1427067-6-cristian.marussi@arm.com>
 <20220701140307.upgfn4qpxhl63syg@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701140307.upgfn4qpxhl63syg@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:03:07PM +0100, Sudeep Holla wrote:
> On Mon, Jun 27, 2022 at 01:30:34PM +0100, Cristian Marussi wrote:
> > Add a Kernel configuration entry used to optionally disable, globally, the
> > usage of SCMI FastChannels even on platforms where they are available.
> > 
> > Make such option default-no to preserve the original SCMI system behaviour
> > of using any available FC.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v2 --> v3
> > - fixed wording in Kconfig
> > - reverted Kconfig logic _USE_ -> _AVOID_
> > ---
> >  drivers/firmware/arm_scmi/Kconfig  | 13 +++++++++++++
> >  drivers/firmware/arm_scmi/driver.c |  6 ++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index 1e7b7fec97d9..3fb34db01014 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -42,6 +42,19 @@ config ARM_SCMI_HAVE_MSG
> >  	  This declares whether a message passing based transport for SCMI is
> >  	  available.
> >  
> > +config ARM_SCMI_AVOID_FASTCHANNELS
> > +	bool "Avoid using SCMI FastChannels even when available"
> 
> Without default, won't this prompt user now ? I would have explicit default n
> if we are adding this. But why do we need this is my question ? This would
> be a quirk IMO on systems where FC is broken. I don't want people to enable
> this during testing and ship f/w with FC broken(or not developed yet).
> 
> We can add this if some platforms really need this as a quirk in the future.
>

Ah ok an explicit default no is better indeed to avoid prompting if you
do not defconfig (I missed this difference between default implicit NO
and explicit NO) ...

... regarding why, I am using personally this indeed for testing with or
without FCs without having to change the installed FW blob, BUT the reason
for upstreaming such an option is that FC support is indeed optional by the
spec so I thought it would have been acceptabel that you could want to
configure a platform NOT to use them even though the FW implementation you
are using, maybe across multiple platforms, supports it.

Thanks,
Cristian

