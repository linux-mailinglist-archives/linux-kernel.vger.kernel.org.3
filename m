Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD74C8B85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiCAMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCAMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:25:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067F84BB9B;
        Tue,  1 Mar 2022 04:25:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48BCED1;
        Tue,  1 Mar 2022 04:25:06 -0800 (PST)
Received: from [10.57.5.157] (unknown [10.57.5.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D213F70D;
        Tue,  1 Mar 2022 04:25:04 -0800 (PST)
Message-ID: <a2871e71-02af-198f-3944-d6565f3cd5f9@arm.com>
Date:   Tue, 1 Mar 2022 12:23:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
To:     =?UTF-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <20220221105151.6rvyoqyvj6ehhtnj@bogus>
 <7b09a22cc178439aa41a752af936313d@sphcmbx02.sunplus.com.tw>
Content-Language: en-US
Organization: ARM
In-Reply-To: <7b09a22cc178439aa41a752af936313d@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:18:31AM +0000, Edwin Chiu 邱垂峰 wrote:
> > 
> > You really don't need a cpuidle driver to just WFI for any states.
> > Add the driver when you have something non WFI in the suspend function.
> >

This is still valid and you haven't responded to this.

> > > +static const struct of_device_id sp7021_idle_state_match[] = {
> > > +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
> > > +	{ },
> > > +};
> > 
> > This is better than adding new driver like you did in previous version.
> > 
> > I did a quick check but couldn't figure out. How do cpus get switched ON
> > or OFF on this platform(for example during CPU hotplug) ?.
> > 
> 
> In this patch, I just want to submit cpuidle function.
> So there have no cpu hotplug function now.


You need to document the binding now for both idle and hotplug. You
can't mix and match. You can either use PSCI or custom "sunplus,sc-smp"
for both cpu on/off and suspend. So you must document it now even if you
don't plan to support hotplug now. And when you add later, you must use
the same method.

However, you still don't need this driver for just WFI, so please
explain why you think otherwise. Until then, you still won't get ACK
from my side.

-- 
Regards,
Sudeep
