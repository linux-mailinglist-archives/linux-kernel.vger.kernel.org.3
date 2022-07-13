Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D10573383
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiGMJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiGMJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:52:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B6F897D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:52:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7667D2222E;
        Wed, 13 Jul 2022 11:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657705920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwnhdLLIH/ztIf1B0luePvRjqCfvKsdMVxFwIwlVIUQ=;
        b=StaWDPjXVzfBqSyBYE1HKYApzxrbhlNbcDTJ7750A2SUTCjOS4RlxPF0E+QkmoMOftYK5q
        rPOyXRD7ROB9VjR7IuNbJP4//ILzppLN2Il7yhB9Z+hzBvvT6JlDr2P2yK8RTRn9Od8WzA
        x2qI1N/H9X326CjGYXEAf86HrS+tGeU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Jul 2022 11:52:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
In-Reply-To: <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
 <73dc6fcedebcae098751bd093fe2d028@walle.cc>
 <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <595347d292ee31a9f0de031d6349f44e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Horatiu, I missed you earlier, sorry]

Hi Steen,

Am 2022-07-13 11:40, schrieb Steen Hegelund:
> I am afraid that the exact list of affected modules is not available,
> so using the
> RESET_PROT_STAT.SYS_RST_PROT_VCORE bit is the best known way of
> resetting as much as possible, and
> still continue execution.

Mh, you are designing that chip (at least the LAN966x) no? Shouldn't
that information be available anywhere at Microchip? ;)

Anyway, it looks like almost the whole chip is reset
except some minor things. So the driver has actually a
wrong name. Until recently only the switch driver was the
sole user of it (at least on the lan966x). So, my question
remains, is this correct? I mean the switch driver says,
"reset the switch core", but what actually happens is that
the the entire SoC except the CPU and maybe the io mux is reset.
What about the watchdog for example? Will that be reset, too?

-michael

> This is what the Sparx5 datasheet has to say about the
> SYS_RST_PROT_VCORE protect bit:
> 
> The device can be soft-reset by writing SOFT_RST.SOFT_CHIP_RST. The
> VCore system and CPU can be
> protected from a device soft-reset by writing
> RESET_PROT_STAT.SYS_RST_PROT_VCORE = 1 before
> initiating soft-reset. 
> 
> In this case, a chip-level soft reset is applied to all other blocks
> except the VCore system and the
> VCore CPU. When protecting the VCore system and CPU from a soft reset,
> the frame DMA must be
> disabled prior to a chip-level soft reset. The SERDES and PLL blocks
> can be protected from reset by
> writing to SOFT_RST.SOFT_SWC_RST instead of SOFT_CHIP_RST.
> 
> The VCore general purpose registers (CPU::GPR) and GPIO alternate
> modes (DEVCPU_GCB::GPIO_ALT) are
> not affected by a soft-reset. These registers are only reset when an
> external reset is asserted.
> 
> BR
> Steen
> 
> On Wed, 2022-07-13 at 11:03 +0200, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> [+ Claudiu, Kavyasree ]
>> Am 2022-07-13 10:40, schrieb Philipp Zabel:
>> > This reverts commit b6b9585876da018bdde2d5f15d206a689c0d70f3.
>> >
>> > This breaks MDIO on kswitch-d10, presumably because the global switch
>> > reset is not released early enough anymore.
>> >
>> > Reported-by: Michael Walle <michael@walle.cc>
>> > Cc: Clément Léger <clement.leger@bootlin.com>
>> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> 
>> Thanks!
>> 
>> Tested-by: Michael Walle <michael@walle.cc>
>> 
>> And maybe Microchip can chime in here and tell us what
>> subsystems in the SoC will actually be reset by this.
>> I fear this reset will affect almost every part of the
>> SoC. So it would have to be bound to every single
>> device? Or maybe adding that reset to the switch driver
>> was a mistake in the first place?
>> 
>> I mean, if it wouldn't be for the guard bit, it would
>> also reset the CPU core..
>> 
>> -michael
