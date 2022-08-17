Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D680596B85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiHQIjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiHQIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:39:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F8F617A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:39:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64B5106F;
        Wed, 17 Aug 2022 01:39:05 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459F53F70D;
        Wed, 17 Aug 2022 01:39:03 -0700 (PDT)
Date:   Wed, 17 Aug 2022 09:38:57 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com
Subject: Re: [RFC PATCH 5/6] firmware: arm_scmi: Add raw transmission support
Message-ID: <YvypBAnzjKvHBEzi@e120937-lin>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
 <20220816072450.3120959-6-cristian.marussi@arm.com>
 <Yvvb6Y+lzuABT1fy@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvvb6Y+lzuABT1fy@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:03:21PM +0100, Mark Brown wrote:
> On Tue, Aug 16, 2022 at 08:24:49AM +0100, Cristian Marussi wrote:
> > Add SCMI Raw mode support which exposes a userspace interface rooted under
> > /sys/kernel/debug/scmi_raw.

Hi Mark,

thanks for having a look.

> 
> > Raw mode can be enabled/disabled at runtime via ./scmi_raw/enable.
> > Once enabled, all the regular SCMI drivers activity is inhibited and a
> > userspace application can then inject and read back bare SCMI messages
> > writing and reading to/from ./scmi_raw/message* entries.
> 
> Is there a strong reason to have the runtime enable/disable?  Given that
> this is going to be used in special kernel builds rather than something
> people have as standard it feels like the transition to/from raw mode is
> opening up a set of extra use cases that wouldn't normally come up for
> the SCMI drivers (especially if the testing ends up leaving the firmware
> in a weird state).

The rationale for this dynamic runtime switch was to try to have a
system that can be configured for SCMI FW testing BUT not necessarily
specifically only for such SCMI tests...IOW a system that can be used in
CI to run a number of other test suites (while in normal mode) and then
switched to raw mode only when SCMI compliance tests are to be run.

Indeed, the enable/disable thing is the main critical point of this RFC
since especially the disable-and-back-to-normal transition proved to be
potentially problematic...i.e. the system generally works in my setup but
it cannot be guaranteed to really bring back the system in a fully
functional state depending on how complex the driver stack is
(..beside the potential FW final weird state issue as you rightly
pointed out)

...moreover at the end the whole disable and go-back-to-normal really
makes little sense in a typical CI scenario where anyway the system
under test is most probably rebooted between runs of different test
suites, so we really do not care about any weird final state probably.

I, nonetheless, posted this RFC with this such support, at first to have
some general feedback, BUT also because I'm still anyway wondering if it
would not be worth to keep at least the capability to only enable it at
run-time (dropping the disable-back-to-normal feat), because this would
enable to build an image which includes this SCMI Raw support, which is
default disabled, and that can at will enabled at runtime only on selected
runs, so that this same test-image could still be used in a number of
different CI test-runs (keeping raw mode disabled and silent) but also then
used for a specific SCMI testing run that would eventually enable it.

If this is not worth really I can just drop the whole runtime switch thing
and stick to the more conservative approach of having a dedicated image
for this kind of SCMI FW testing: a system that once configured at compile
time with this, it just cannot use at all the regular SCMI stack (...which
does NOT necessarily prevent the system to boot and be used for other non
SCMI testing indeed...it would just be probably slower...)

Any thought ? 

Thanks,
Cristian
