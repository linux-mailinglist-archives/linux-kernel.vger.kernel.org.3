Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15B4B4A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiBNKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348065AbiBNKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:34:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 567B0A1BFD;
        Mon, 14 Feb 2022 02:00:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2274B1396;
        Mon, 14 Feb 2022 02:00:40 -0800 (PST)
Received: from bogus (unknown [10.57.3.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6EC3F718;
        Mon, 14 Feb 2022 02:00:38 -0800 (PST)
Date:   Mon, 14 Feb 2022 09:59:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Edwin Chiu =?utf-8?B?6YKx5Z6C5bOw?= <edwin.chiu@sunplus.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Message-ID: <20220214095950.vt7fkvrkvio3gtkw@bogus>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
 <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 07:44:30AM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2022 03:55, Edwin Chiu 邱垂峰 wrote:
> > Hi Krzysztof:
> > 
> > Please see below answer.
> > 
> >>> +static struct cpuidle_driver sp7021_idle_driver = {
> >>> +	.name = "sp7021_idle",
> >>> +	.owner = THIS_MODULE,
> >>> +	/*
> >>> +	 * State at index 0 is standby wfi and considered standard
> >>> +	 * on all ARM platforms. If in some platforms simple wfi
> >>> +	 * can't be used as "state 0", DT bindings must be implemented
> >>> +	 * to work around this issue and allow installing a special
> >>> +	 * handler for idle state index 0.
> >>> +	 */
> >>> +	.states[0] = {
> >>> +		.enter                  = sp7021_enter_idle_state,
> >>> +		.exit_latency           = 1,
> >>> +		.target_residency       = 1,
> >>> +		.power_usage		= UINT_MAX,
> >>> +		.name                   = "WFI",
> >>> +		.desc                   = "ARM WFI",
> >>
> >> I have impression that there is no point in having custom driver with WFI...
> >>

+1

> >> Still the main question from Daniel and Sudeep stays: why do you need
> >> this? You copied exactly cpuildle-arm driver, there is nothing different
> >> here. At least I could not spot differences. Maybe except that you use
> >> cpu_v7_do_idle explicitly.
> >>

Please comment or answer why you can't use standard driver.

> >> Unfortunately I cannot understand the explanation here:
> >> https://lore.kernel.org/all/0812c44f777d4026b79df2e3698294be@sphcmbx02.sunplus.com.tw/
> >> Why exactly cpuidle-arm does not work in your case?
> >>
> > Edwin=> I mean cpuidle-arm driver can't directly use with no modified.
> >        If someone want to use cpuidle-arm driver, below modification seems necessary.
> >        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >        Static int sp7021_cpuidle_suspend_enter(unsigned long index) {~}
> >        Static int __init sp7021_cpuidle_init(struct device_node *cpu_node, int cpu) {~}
> >        Static const struct cpuidle_ops sc_smp_ops __initconst = {
> >             .suspend = sp7021_cpuidle_suspend_enter,
> >             .init = sp7021_cpuidle_init,
> >        };
> >        CPUIDLE_METHOD_OF_DECLARE(sc_smp, "sunplus,sc-smp", &sc_smp_ops); //declare enable method
> >        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >

May be. It depends on what is your enable-method. I did a quick grep and could
see any support for sunplus platform upstream. So I am not sure what is the
cpu boot/enable method used. Is it PSCI or something custom. You should be
using standard PSCI if it is relatively new platform or you have any other
strong reasons to use custom method. If you are using custom method, then
some changes like above is required but that will be in the platform port
and not the core cpuidle driver/framework.

In short NACK for any dedicated driver for this platform, use the generic
cpuidle-arm driver with appropriate platform hooks(like the above one only
if you choose to use custom enable method and not standard PSCI)

-- 
Regards,
Sudeep
