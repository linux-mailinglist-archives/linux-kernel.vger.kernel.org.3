Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D3520F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiEJIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiEJIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975528E4FE;
        Tue, 10 May 2022 01:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FDFBB81B55;
        Tue, 10 May 2022 08:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D3BC385A6;
        Tue, 10 May 2022 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652170793;
        bh=97t5SSRW42cNr7qqY2EZ1Z2IgU0S7OqzktsuTvBVZT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kn9fckBEtQCD/7YuDVWt3hssXR3ImB0py9IRtdog2PFeWa72xjv628Ch1ZIK1IGiG
         kwZo131g/GSX6eNxeJU0FsPV1qUdeG6aVeBI3TxOJNwjOgRh/oY/zhG87A6/XoZRra
         i+Myv/ObyBAuP6mHmzj+PbLFlzJy1PQzZLKh/1lGGOWxJtCuymD5HFwrvbhYLNh1hz
         PpmkIykuyWKG2V0t9bOECqt+4H296sTUISbs63anW4hM2MISPuVTzuJKmwTMPbI2dU
         3iggs+HvjC4FJA6t3ypyphFnAkBz9DleweDHeNfsO/3KxqC32TTH1GPX4gg8HzTw/3
         Y+xBN8rO31LqQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1noL5z-00ABBV-AT; Tue, 10 May 2022 09:19:51 +0100
MIME-Version: 1.0
Date:   Tue, 10 May 2022 09:19:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmtimer: ack pending interrupt during suspend on am335x/am437x?
In-Reply-To: <YnoK+XQiargRGUy/@atomide.com>
References: <YniiqM0S+hwsGFni@x1> <YnoK+XQiargRGUy/@atomide.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4de411aa2fc8a6f185afb8bfd5da63d4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tony@atomide.com, dfustini@baylibre.com, daniel.lezcano@linaro.org, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On 2022-05-10 07:49, Tony Lindgren wrote:
> * Drew Fustini <dfustini@baylibre.com> [220509 05:07]:
>> Hello Daniel, Tony suggested I mail you along with the list to get
>> feedback. I'm attempting to upstream these two patches [1][2] from
>> ti-linux-5.4.y for arch/arm/mach-omap2/timer.c:
>> 96f4c6e2ba8a ("ARM: OMAP2+: timer: Ack pending interrupt during 
>> suspend")
>> 7ae7dd5f8272 ("ARM: OMAP2+: timer: Extend pending interrupt ACK for 
>> gic")
>> 
>> On the TI AM335x and AM437x SoCs, it is possible for a late interrupt 
>> to
>> be generated which will cause a suspend failure. The first patch makes
>> omap_clkevt_idle() ack the irq both in the timer peripheral register
>> and in the interrupt controller to avoid the issue.
>> 
>> On AM437x only, the GIC cannot be directly acked using only the 
>> irqchip
>> calls. To workaround that, the second patch maps the GIC_CPU_BASE and
>> reads the GIC_CPU_INTACK register before calling irq_eoi to properly 
>> ack
>> the late timer interrupts that show up during suspend.
>> 
>> However, Tony removed most of arch/arm/mach-omap2/timer.c with:
>> 2ee04b88547a ("ARM: OMAP2+: Drop old timer code for dmtimer and 32k 
>> counter")
>> 
>> The timers are now implemented in drivers/clocksource/timer-ti-dm.c 
>> and
>> drivers/clocksource/timer-ti-dm-systimer.c. The function
>> dmtimer_clocksource_suspend() disables the dmtimer and clock but does
>> not ack any interrupts.
>> 
>> Tony suggested the right place to ack the interrupt during suspend is
>> in CPU_CLUSTER_PM_ENTER inside omap_timer_context_notifier().
>> 
>> Do you think that would be an acceptable approach?
> 
> Based on what we chatted on irc yesterday, I'd suggest try resetting 
> the
> clockevent on suspend first for am3/4 at omap_clockevent_idle() and see 
> if
> that takes care of the issue. If it's the timer hardware blocking the
> deeper idle states, this should work, and GIC will lose it's context
> on system suspend anyways.

Maybe, but the core tracking code will still know it is in the
middle of an interrupt. I´d expect things like lockdep to shout
at you...

         M.
