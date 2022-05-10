Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4D520F92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiEJIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiEJIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:20:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0D2555A4;
        Tue, 10 May 2022 01:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DD4AB81B41;
        Tue, 10 May 2022 08:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A11CC385C9;
        Tue, 10 May 2022 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652170597;
        bh=J7/O303HKOjlJOqWbuNcNBIMSzdGNoVDL+7ArgF5TY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GbwuMG+HE4H0cOIcAe4pSjFJ44IWpyH1Sm6yie+R2KK8WvA3VSy9MUi5ml2qTYk+B
         XGD1S3f2zYOoJFJ7a2MfZMjugzayWoAaFv5HIMLYiNQHWrck3wFbVQGTOAnpiEuJ5c
         EFgdK8K4W9LTXr9sCylO7uTlKx97+cZxX8KwfJZ3GwfRGqbUws6j/mpZkIkoqnjW+H
         9A66vWv63mwB14+ceOxsFCVG4zJOu5ncrKFDCBTOwY6wnfw5ueKlgNZa734iI86BPk
         lYci5VtKrmOmo/yjv6W3G9v1MXif/18hhFQlOiGosWKLb6eTl6hU2hmPCvHOFhvV2R
         Y7aE/UJq0WYeQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1noL2o-00AB98-Mp; Tue, 10 May 2022 09:16:34 +0100
MIME-Version: 1.0
Date:   Tue, 10 May 2022 09:16:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmtimer: ack pending interrupt during suspend on am335x/am437x?
In-Reply-To: <YniiqM0S+hwsGFni@x1>
References: <YniiqM0S+hwsGFni@x1>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7c43bcfd56424d909796977460335f24@misterjones.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dfustini@baylibre.com, tony@atomide.com, daniel.lezcano@linaro.org, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-09 06:12, Drew Fustini wrote:
> Hello Daniel, Tony suggested I mail you along with the list to get
> feedback. I'm attempting to upstream these two patches [1][2] from
> ti-linux-5.4.y for arch/arm/mach-omap2/timer.c:
> 96f4c6e2ba8a ("ARM: OMAP2+: timer: Ack pending interrupt during 
> suspend")
> 7ae7dd5f8272 ("ARM: OMAP2+: timer: Extend pending interrupt ACK for 
> gic")
> 
> On the TI AM335x and AM437x SoCs, it is possible for a late interrupt 
> to
> be generated which will cause a suspend failure. The first patch makes
> omap_clkevt_idle() ack the irq both in the timer peripheral register
> and in the interrupt controller to avoid the issue.
> 
> On AM437x only, the GIC cannot be directly acked using only the irqchip
> calls. To workaround that, the second patch maps the GIC_CPU_BASE and
> reads the GIC_CPU_INTACK register before calling irq_eoi to properly 
> ack
> the late timer interrupts that show up during suspend.

This isn´t an Ack. The Ack happens when you read the IAR register
(Interrupt Acknowledgement Register). Writing to EOI performs at least
a priority drop, and maybe a deactivation.

Simply writing to EOI doesn´t necessarily solve any problem if the
GIC is using EOIMode==1, because you´ĺl miss the deactivation.

> 
> However, Tony removed most of arch/arm/mach-omap2/timer.c with:
> 2ee04b88547a ("ARM: OMAP2+: Drop old timer code for dmtimer and 32k 
> counter")
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

The real issue is that you are apparently suspending from within an
interrupt handler. This is what should be addressed.

Please don´t randomly call into the irqchip code. It will eventually
break, and sooner rather than later.

         M.
-- 
Jazz is not dead. It just smells funny...
