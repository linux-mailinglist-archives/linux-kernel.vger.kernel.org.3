Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A8557CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiFWNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFWNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:19:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92A49C8B;
        Thu, 23 Jun 2022 06:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96838B82337;
        Thu, 23 Jun 2022 13:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E9C341C4;
        Thu, 23 Jun 2022 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655990352;
        bh=ncg899RK9f+f5Z0KZ/AxsbE694mnUgGJh3xSzIgIgsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJOAkmsVQioytc3R9Tq/vWOmqUHR/zUaiilHD/ZxUfFuDblgrReUdhOac6B30GMiH
         Nav+0JJfW0xK11Ks092NJ41K5Az/fop4wYgOEpCjTyr3EGETA/vIqMmrnHAWAEc1vx
         JGtmmc6uGhdZFTVq3HJemtJhPvN3azwxQ8GXGcrFtUOHRUg4crVZU2wMeoQirfnBSp
         ZsCD6JNPZl69anKxkGNsQdIGVXxRd/mfJGxrppniIeB+0W5+fRjkbAQ+GreG+Jr1uA
         nVraVmzulz+6SN8psQ37WYaC507n+zyBRYqyBzEuXRK1rq/DrZM3OVzsbRAkVk+zRb
         MoLvINaQCe7NQ==
Date:   Thu, 23 Jun 2022 14:19:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Michael Walle <michael@walle.cc>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: remove generic ARM cpuidle support
Message-ID: <20220623131906.GA16222@willie-the-truck>
References: <20220529181329.2345722-1-michael@walle.cc>
 <09f392794c815cbfb38e5103d92310da@walle.cc>
 <20220622140748.laklytigxtfdbbg2@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622140748.laklytigxtfdbbg2@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:07:48PM +0100, Sudeep Holla wrote:
> On Wed, Jun 22, 2022 at 01:59:07PM +0200, Michael Walle wrote:
> > Am 2022-05-29 20:13, schrieb Michael Walle:
> > > Playing with an own PSCI implementation, I've noticed that the
> > > cpuidle-arm
> > > driver doesn't work on arm64. It doesn't probe because since commit
> > > 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
> > > arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit
> > > removed
> > > the cpu_idle_init and cpu_suspend ops.
> > > 
> > > It left me puzzled for quite some time. It seems that the cpuidle-psci
> > > is
> > > the preferred one and this has been the case for quite some time. The
> > > mentioned commit first appeared in v5.4.
> > > 
> > > Remove the ARM64 support for the cpuidle-arm driver, which then let us
> > > remove all the supporting arch code.
> > > 
> > > Michael Walle (2):
> > >   cpuidle: cpuidle-arm: remove arm64 support
> > >   arm64: cpuidle: remove generic cpuidle support
> > > 
> > >  arch/arm64/include/asm/cpu_ops.h |  9 ---------
> > >  arch/arm64/include/asm/cpuidle.h | 15 ---------------
> > >  arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
> > >  drivers/cpuidle/Kconfig.arm      |  3 ++-
> > >  4 files changed, 2 insertions(+), 54 deletions(-)
> > 
> > Through which tree should this patchset go? I've seen it is marked as
> > "Handled Elsewere" in the linux pm patchwork [1].
> > 
> 
> Generally based on the changes, it is decided. I can see why Rafael would
> have marked so in PM patchwork. Daniel has already acked small change in
> CPUidle config file while the bulk is removal of arm64 code. So, it is
> better to route it via arm64 tree.
> 
> Will,
> 
> Assuming you will handle v5.20, can you pick this up ?

Yup, on it.

Will
