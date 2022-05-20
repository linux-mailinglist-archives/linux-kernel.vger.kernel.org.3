Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9352EEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbiETPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345536AbiETPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:07:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E56486CF51
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:07:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A884F1477;
        Fri, 20 May 2022 08:07:01 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E6E3F73D;
        Fri, 20 May 2022 08:06:59 -0700 (PDT)
Date:   Fri, 20 May 2022 16:06:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling
 on DT platforms
Message-ID: <20220520150652.n6cfl7qpzbjrjh2f@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-9-sudeep.holla@arm.com>
 <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
 <20220520125959.wlxz53cfqldljxjy@bogus>
 <20220520143620.GA3788938-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520143620.GA3788938-robh@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:36:20AM -0500, Rob Herring wrote:
> On Fri, May 20, 2022 at 01:59:59PM +0100, Sudeep Holla wrote:
> > On Thu, May 19, 2022 at 01:10:51PM -0500, Rob Herring wrote:
> > > On Wed, May 18, 2022 at 4:34 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > ACPI PPTT provides cache identifiers and especially the last level cache
> > > > identifier is used in obtaining last level cache siblings amongst CPUs.
> > > >
> > > > While we have the cpu map representing all the CPUs sharing last level
> > > > cache in the cacheinfo driver, it is populated quite late in the boot
> > > > while the information is needed to build scheduler domains quite early.
> > >
> > > Late is because it's a device_initcall() rather than late in the cpu
> > > hotplug state machine, right?
> > 
> > Right. The expectation is to run in on each online CPU in CPU hotplug state
> > machine for some architectures. We may not need that on arm64 especially
> > since we get all info from DT or ACPI, but e.g. x86 uses cpuid which needs
> > to be executed on that CPU.
> 
> That's a separate issue. I'm not suggesting changing that part (that 
> would just be an optimization).
> 
> > > The late aspect is for sysfs presumably,but I think we could decouple that.
> > 
> > OK, not sure when this sched_domain info is actually needed. It think it
> > could be decoupled if we can wait until all the cpus are online.
> 
> No need to wait for all cpus to be online. I think you keep doing 
> it as part of cpu hotplug. The device_initcall() is used because you 
> cannot have struct device or sysfs calls before the driver core is 
> initialized. If we run the cacheinfo code earlier (I think the arch code 
> will have to call it) just like the topology code and skip the sysfs 
> parts, then you can use it.
>

Yes I was thinking something on similar lines, though I didn't think of
pushing code to arch. Let me check, must be possible.

> > > Do all the firmware cache parsing early and then populate the sysfs parts
> > > later.
> > 
> > Yes that may work on DT/ACPI based systems, as I said x86 relies on cpuid.
> 
> I'd assume using cpuid works at any time?
>

I think so, I can't recall the details since I looked at that about 5 years
ago. I have to check again anyways to explore early initialisation.

-- 
Regards,
Sudeep
