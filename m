Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87C51EE70
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiEHPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEHPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:09:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEBDF63;
        Sun,  8 May 2022 08:05:46 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nniTd-0000uy-O3; Sun, 08 May 2022 17:05:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource conflicts with firmware
Date:   Sun, 08 May 2022 17:05:40 +0200
Message-ID: <1860576.taCxCBeP46@phil>
In-Reply-To: <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
References: <20220406014842.2771799-1-briannorris@chromium.org> <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. April 2022, 03:48:41 CEST schrieb Brian Norris:
> On RK3399 platforms, power domains are managed mostly by the kernel
> (drivers/soc/rockchip/pm_domains.c), but there are a few exceptions
> where ARM Trusted Firmware has to be involved:
> 
> (1) system suspend/resume
> (2) DRAM DVFS (a.k.a., "ddrfreq")
> 
> Exception (1) does not cause much conflict, since the kernel has
> quiesced itself by the time we make the relevant PSCI call.
> 
> Exception (2) can cause conflict, because of two actions:
> 
> (a) ARM Trusted Firmware needs to read/modify/write the PMU_BUS_IDLE_REQ
>     register to idle the memory controller domain; the kernel driver
>     also has to touch this register for other domains.
> (b) ARM Trusted Firmware needs to manage the clocks associated with
>     these domains.
> 
> To elaborate on (b): idling a power domain has always required ungating
> an array of clocks; see this old explanation from Rockchip:
> https://lore.kernel.org/linux-arm-kernel/54503C19.9060607@rock-chips.com/
> 
> Historically, ARM Trusted Firmware has avoided this issue by using a
> special PMU_CRU_GATEDIS_CON0 register -- this register ungates all the
> necessary clocks -- when idling the memory controller. Unfortunately,
> we've found that this register is not 100% sufficient; it does not turn
> the relevant PLLs on [0].
> 
> So it's possible to trigger issues with something like the following:
> 
> 1. enable a power domain (e.g., RK3399_PD_VDU) -- kernel will
>    temporarily enable relevant clocks/PLLs, then turn them back off
>    2. a PLL (e.g., PLL_NPLL) is part of the clock tree for
>       RK3399_PD_VDU's clocks but otherwise unused; NPLL is disabled
> 3. perform a ddrfreq transition (rk3399_dmcfreq_target() -> ...
>    drivers/clk/rockchip/clk-ddr.c / ROCKCHIP_SIP_DRAM_FREQ)
>    4. ARM Trusted Firmware unagates VDU clocks (via PMU_CRU_GATEDIS_CON0)
>    5. ARM Trusted firmware idles the memory controller domain
>    6. Step 5 waits on the VDU domain/clocks, but NPLL is still off
> 
> i.e., we hang the system.
> 
> So for (b), we need to at a minimum manage the relevant PLLs on behalf
> of firmware. It's easier to simply manage the whole clock tree, in a
> similar way we do in rockchip_pd_power().
> 
> For (a), we need to provide mutual exclusion betwen rockchip_pd_power()
> and firmware. To resolve that, we simply grab the PMU mutex and release
> it when ddrfreq is done.
> 
> The Chromium OS kernel has been carrying versions of part of this hack
> for a while, based on some new custom notifiers [1]. I've rewritten as a
> simple function call between the drivers, which is OK because:
> 
>  * the PMU driver isn't enabled, and we don't have this problem at all
>    (the firmware should have left us in an OK state, and there are no
>    runtime conflicts); or
>  * the PMU driver is present, and is a single instance.
> 
> And the power-domain driver cannot be removed, so there's no lifetime
> management to worry about.
> 
> For completeness, there's a 'dmc_pmu_mutex' to guard (likely
> theoretical?) probe()-time races. It's OK for the memory controller
> driver to start running before the PMU, because the PMU will avoid any
> critical actions during the block() sequence.
> 
> [0] The RK3399 TRM for PMU_CRU_GATEDIS_CON0 only talks about ungating
>     clocks. Based on experimentation, we've found that it does not power
>     up the necessary PLLs.
> 
> [1] CHROMIUM: soc: rockchip: power-domain: Add notifier to dmc driver
>     https://chromium-review.googlesource.com/q/I242dbd706d352f74ff706f5cbf42ebb92f9bcc60
>     Notably, the Chromium solution only handled conflict (a), not (b).
>     In practice, item (b) wasn't a problem in many cases because we
>     never managed to fully power off PLLs. Now that the (upstream) video
>     decoder driver performs runtime clock management, we often power off
>     NPLL.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


