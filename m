Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEE5970F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiHQOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHQOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:21:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA4C8B9A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:21:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00921152B;
        Wed, 17 Aug 2022 07:21:25 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8073F70D;
        Wed, 17 Aug 2022 07:21:22 -0700 (PDT)
Date:   Wed, 17 Aug 2022 15:21:20 +0100
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
Message-ID: <Yvz5YLh41gWLmPSa@e120937-lin>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
 <20220816072450.3120959-6-cristian.marussi@arm.com>
 <Yvvb6Y+lzuABT1fy@sirena.org.uk>
 <YvypBAnzjKvHBEzi@e120937-lin>
 <YvzwUPGmZPFAzw07@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvzwUPGmZPFAzw07@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:42:40PM +0100, Mark Brown wrote:
> On Wed, Aug 17, 2022 at 09:38:57AM +0100, Cristian Marussi wrote:
> 
> > ...moreover at the end the whole disable and go-back-to-normal really
> > makes little sense in a typical CI scenario where anyway the system
> > under test is most probably rebooted between runs of different test
> > suites, so we really do not care about any weird final state probably.
> 
> > I, nonetheless, posted this RFC with this such support, at first to have
> > some general feedback, BUT also because I'm still anyway wondering if it
> > would not be worth to keep at least the capability to only enable it at
> > run-time (dropping the disable-back-to-normal feat), because this would
> > enable to build an image which includes this SCMI Raw support, which is
> > default disabled, and that can at will enabled at runtime only on selected
> > runs, so that this same test-image could still be used in a number of
> > different CI test-runs (keeping raw mode disabled and silent) but also then
> > used for a specific SCMI testing run that would eventually enable it.
> 
> The enable usecase does indeed make more sense, though I'd still worry
> about other code having problems with the SCMI support getting
> hotplugged out from underneath it since that isn't a thing that happens
> in practical systems.  For example the archrandom code is going to get
> confused since it probes once to see if SMCCC TRNG support is available
> and if it's present sets a flag which it assumes will be true for the
> rest of system runtime.  I don't entirely know how the image build costs
> play off here for the people who'd actually be running these tests, but
> my instinct is that the extra kernel build isn't really much in the
> grand scheme of things compared to shaking out the consequences of a
> runtime switch and the costs of actually running the tests.

Indeed Sudeep had the same concerns and when I tested this with a dummy
driver using an SCMI clock I could see that the disappearing clock was
seemingly handled safely by the clock framework, but this is just one
of the possibly involved framework, I cannot be so sure about all the
others and any future frmk that will have to interact with this dynamic
unplugging...so at the end probably is not worth the effort as you are
saying...I'll most probably drop this next....

Thanks a lot for your feedback.
Cristian

