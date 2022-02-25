Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3624C4759
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiBYOWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBYOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:22:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10D8022A246;
        Fri, 25 Feb 2022 06:21:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEED2106F;
        Fri, 25 Feb 2022 06:21:27 -0800 (PST)
Received: from bogus (unknown [10.57.3.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC0373F5A1;
        Fri, 25 Feb 2022 06:21:25 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:20:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PM: cpu: Add CPU_LAST_PM_ENTER and
 CPU_FIRST_PM_EXIT support
Message-ID: <20220225142036.cxh7u24wljgwu3od@bogus>
References: <20220223125536.230224-1-shawn.guo@linaro.org>
 <20220223125536.230224-2-shawn.guo@linaro.org>
 <20220223193050.y7parhlmnspcyom3@bogus>
 <20220225043311.GB269879@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225043311.GB269879@dragon>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:33:11PM +0800, Shawn Guo wrote:
> On Wed, Feb 23, 2022 at 07:30:50PM +0000, Sudeep Holla wrote:
> > On Wed, Feb 23, 2022 at 08:55:34PM +0800, Shawn Guo wrote:
> > > It becomes a common situation on some platforms that certain hardware
> > > setup needs to be done on the last standing cpu, and rpmh-rsc[1] is such
> > > an existing example.  As figuring out the last standing cpu is really
> > > something generic, it adds CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT)
> > > event support to cpu_pm helper, so that individual driver can be
> > > notified when the last standing cpu is about to enter low power state.
> > 
> > Sorry for not getting back on the previous email thread.
> > When I meant I didn't want to use CPU_CLUSTER_PM_{ENTER,EXIT}, I wasn't
> > thinking new ones to be added as alternative. With this OSI cpuidle, we
> > have introduces the concept of power domains and I was check if we can
> > associate these requirements to them rather than introducing the first
> > and last cpu notion. The power domains already identify them in order
> > to turn on or off. Not sure if there is any notification mechanism in
> > genpd/power domains. I really don't like this addition. It is disintegrating
> > all the solutions for OSI and makes it hard to understand.
> > 
> > One solution I can think of(not sure if others like or if that is feasible)
> > is to create a parent power domain that encloses all the last level CPU
> > power domains, which means when the last one is getting powered off, you
> > will be asked to power off and you can take whatever action you want.
> 
> Thanks Sudeep for the input!  Yes, it works for me (if I understand your
> suggestion correctly).  So the needed changes on top of the current
> version would be:
> 
> 1) Declare MPM as a PD (power domain) provider and have it be the
>    parent PD of cpu cluster (the platform has only one cluster including
>    4 cpus).
> 

[...]

> 
> Let's me know if this is what you are asking for, thanks!

Matches exactly. I don't know if there is anything I am missing to see,
but if this possible, for me it is easier to understand as this is all
linked to power-domains like other things in OSI cpuidle.

So yes, I prefer this, but let us see what others have to say about this.

-- 
Regards,
Sudeep
