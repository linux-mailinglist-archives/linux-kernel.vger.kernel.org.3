Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1278752ECC9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349678AbiETNAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiETNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:00:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9B816A271
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:00:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D731477;
        Fri, 20 May 2022 06:00:08 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDCE3F73D;
        Fri, 20 May 2022 06:00:05 -0700 (PDT)
Date:   Fri, 20 May 2022 13:59:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
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
Message-ID: <20220520125959.wlxz53cfqldljxjy@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-9-sudeep.holla@arm.com>
 <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:10:51PM -0500, Rob Herring wrote:
> On Wed, May 18, 2022 at 4:34 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > ACPI PPTT provides cache identifiers and especially the last level cache
> > identifier is used in obtaining last level cache siblings amongst CPUs.
> >
> > While we have the cpu map representing all the CPUs sharing last level
> > cache in the cacheinfo driver, it is populated quite late in the boot
> > while the information is needed to build scheduler domains quite early.
>
> Late is because it's a device_initcall() rather than late in the cpu
> hotplug state machine, right?

Right. The expectation is to run in on each online CPU in CPU hotplug state
machine for some architectures. We may not need that on arm64 especially
since we get all info from DT or ACPI, but e.g. x86 uses cpuid which needs
to be executed on that CPU.

> The late aspect is for sysfs presumably,but I think we could decouple that.

OK, not sure when this sched_domain info is actually needed. It think it
could be decoupled if we can wait until all the cpus are online.

> Do all the firmware cache parsing early and then populate the sysfs parts
> later.

Yes that may work on DT/ACPI based systems, as I said x86 relies on cpuid.

> It's not a unique problem as the DT unflattening and init code has to
> do the same thing. I'd assume the hotplug and cpu sysfs devices have
> to deal with the same thing.
>

OK, I will take a look at how to do that.

--
Regards,
Sudeep
