Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455E520E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiEJGxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiEJGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:53:29 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E43C2AC0EB;
        Mon,  9 May 2022 23:49:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 70FFD80EE;
        Tue, 10 May 2022 06:46:00 +0000 (UTC)
Date:   Tue, 10 May 2022 09:49:29 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmtimer: ack pending interrupt during suspend on am335x/am437x?
Message-ID: <YnoK+XQiargRGUy/@atomide.com>
References: <YniiqM0S+hwsGFni@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YniiqM0S+hwsGFni@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drew Fustini <dfustini@baylibre.com> [220509 05:07]:
> Hello Daniel, Tony suggested I mail you along with the list to get
> feedback. I'm attempting to upstream these two patches [1][2] from
> ti-linux-5.4.y for arch/arm/mach-omap2/timer.c:
> 96f4c6e2ba8a ("ARM: OMAP2+: timer: Ack pending interrupt during suspend")
> 7ae7dd5f8272 ("ARM: OMAP2+: timer: Extend pending interrupt ACK for gic")
> 
> On the TI AM335x and AM437x SoCs, it is possible for a late interrupt to
> be generated which will cause a suspend failure. The first patch makes
> omap_clkevt_idle() ack the irq both in the timer peripheral register
> and in the interrupt controller to avoid the issue.
> 
> On AM437x only, the GIC cannot be directly acked using only the irqchip
> calls. To workaround that, the second patch maps the GIC_CPU_BASE and
> reads the GIC_CPU_INTACK register before calling irq_eoi to properly ack
> the late timer interrupts that show up during suspend.
> 
> However, Tony removed most of arch/arm/mach-omap2/timer.c with:
> 2ee04b88547a ("ARM: OMAP2+: Drop old timer code for dmtimer and 32k counter")
> 
> The timers are now implemented in drivers/clocksource/timer-ti-dm.c and
> drivers/clocksource/timer-ti-dm-systimer.c. The function
> dmtimer_clocksource_suspend() disables the dmtimer and clock but does
> not ack any interrupts.
> 
> Tony suggested the right place to ack the interrupt during suspend is
> in CPU_CLUSTER_PM_ENTER inside omap_timer_context_notifier().
> 
> Do you think that would be an acceptable approach?

Based on what we chatted on irc yesterday, I'd suggest try resetting the
clockevent on suspend first for am3/4 at omap_clockevent_idle() and see if
that takes care of the issue. If it's the timer hardware blocking the
deeper idle states, this should work, and GIC will lose it's context
on system suspend anyways.

If there's still a pending interrupt status blocking deeper idle
states for system suspend after clockevent reset, then maybe the related
interrupt controller(s) should clear/reset the state for context lossy
suspend for CPU_CLUSTER_PM_ENTER for system suspend.

Looks like for GIC we have gic_dist_save() being called but it does not
seem to clear anything for system suspend.

For runtime PM, we don't want to clear any pending interrupts on
CPU_CLUSTER_PM_ENTER :)

Seems like a system suspend/resume test loop should be first run to
trigger the issue and see what is still missing.

Regards,

Tony


> [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.4.y&id=96f4c6e2ba8a
> [2] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.4.y&id=7ae7dd5f8272
