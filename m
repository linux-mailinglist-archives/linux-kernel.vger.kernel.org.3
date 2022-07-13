Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE95573607
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiGMMJE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 08:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiGMMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:09:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27B8149C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:09:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBbAr-0002Oe-3V; Wed, 13 Jul 2022 14:09:01 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBbAp-000hWx-V2; Wed, 13 Jul 2022 14:08:59 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBbAo-0006a0-SV; Wed, 13 Jul 2022 14:08:58 +0200
Message-ID: <4a12868d0bffbaef9912fbc54e5998e0c50bccf6.camel@pengutronix.de>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Steen Hegelund <steen.hegelund@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Date:   Wed, 13 Jul 2022 14:08:58 +0200
In-Reply-To: <595347d292ee31a9f0de031d6349f44e@walle.cc>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
         <73dc6fcedebcae098751bd093fe2d028@walle.cc>
         <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
         <595347d292ee31a9f0de031d6349f44e@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mi, 2022-07-13 at 11:52 +0200, Michael Walle wrote:
> [+ Horatiu, I missed you earlier, sorry]
> 
> Hi Steen,
> 
> Am 2022-07-13 11:40, schrieb Steen Hegelund:
> > I am afraid that the exact list of affected modules is not available,
> > so using the
> > RESET_PROT_STAT.SYS_RST_PROT_VCORE bit is the best known way of
> > resetting as much as possible, and
> > still continue execution.
> 
> Mh, you are designing that chip (at least the LAN966x) no? Shouldn't
> that information be available anywhere at Microchip? ;)
> 
> Anyway, it looks like almost the whole chip is reset
> except some minor things. So the driver has actually a
> wrong name. Until recently only the switch driver was the
> sole user of it (at least on the lan966x). So, my question
> remains, is this correct? I mean the switch driver says,
> "reset the switch core", but what actually happens is that
> the the entire SoC except the CPU and maybe the io mux is reset.
> What about the watchdog for example? Will that be reset, too?

If [1-3] are to be trusted, RESET_PROT_STAT[VCORE_RST_PROT_WDT], which
protects the watchdog from soft reset, is not set by default. So yes?

There are also AMBA, PCIe, PDBG protection bits against Vcore soft
reset in this register, depending on the platform.

[1] https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=cpu,cpu_regs,reset_prot_stat
[2] https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,cpu_regs,reset_prot_stat
[3] https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html?select=cpu,cpu_regs,reset_prot_stat

regards
Philipp
