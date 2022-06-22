Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20ED554C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357384AbiFVOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357971AbiFVOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:09:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE30938BFD;
        Wed, 22 Jun 2022 07:09:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3E41042;
        Wed, 22 Jun 2022 07:09:01 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D783F792;
        Wed, 22 Jun 2022 07:08:59 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:07:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: remove generic ARM cpuidle support
Message-ID: <20220622140748.laklytigxtfdbbg2@bogus>
References: <20220529181329.2345722-1-michael@walle.cc>
 <09f392794c815cbfb38e5103d92310da@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f392794c815cbfb38e5103d92310da@walle.cc>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:59:07PM +0200, Michael Walle wrote:
> Am 2022-05-29 20:13, schrieb Michael Walle:
> > Playing with an own PSCI implementation, I've noticed that the
> > cpuidle-arm
> > driver doesn't work on arm64. It doesn't probe because since commit
> > 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
> > arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit
> > removed
> > the cpu_idle_init and cpu_suspend ops.
> > 
> > It left me puzzled for quite some time. It seems that the cpuidle-psci
> > is
> > the preferred one and this has been the case for quite some time. The
> > mentioned commit first appeared in v5.4.
> > 
> > Remove the ARM64 support for the cpuidle-arm driver, which then let us
> > remove all the supporting arch code.
> > 
> > Michael Walle (2):
> >   cpuidle: cpuidle-arm: remove arm64 support
> >   arm64: cpuidle: remove generic cpuidle support
> > 
> >  arch/arm64/include/asm/cpu_ops.h |  9 ---------
> >  arch/arm64/include/asm/cpuidle.h | 15 ---------------
> >  arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
> >  drivers/cpuidle/Kconfig.arm      |  3 ++-
> >  4 files changed, 2 insertions(+), 54 deletions(-)
> 
> Through which tree should this patchset go? I've seen it is marked as
> "Handled Elsewere" in the linux pm patchwork [1].
> 

Generally based on the changes, it is decided. I can see why Rafael would
have marked so in PM patchwork. Daniel has already acked small change in
CPUidle config file while the bulk is removal of arm64 code. So, it is
better to route it via arm64 tree.

Will,

Assuming you will handle v5.20, can you pick this up ?

-- 
Regards,
Sudeep
