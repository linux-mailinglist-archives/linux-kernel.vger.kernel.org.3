Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330F569F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiGGKLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiGGKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:11:41 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6F0450706;
        Thu,  7 Jul 2022 03:11:39 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o9OTx-0007T4-02; Thu, 07 Jul 2022 12:11:37 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 74EE3C02B6; Thu,  7 Jul 2022 12:06:30 +0200 (CEST)
Date:   Thu, 7 Jul 2022 12:06:30 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Message-ID: <20220707100630.GC9894@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org>
 <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:56:47AM +0200, Martin Blumenstingl wrote:
> Without this patch all interrupts are fine on VPE 0 and with SMP disabled.

I fully understand the problem. But not everybody uses this interrupt
setup, so changing generic code will have effects there too.

> - why can MIPS CPU interrupt 6 and 7 be enabled unconditionally while
> 2-5 cannot be enabled unconditionally?

7 is timer interrupt and is usually wired for 34K cpus and 6 is
performance counter hopefully handled as well. And I agree that
this still isn't the best approach here

> - seeing that there's also a mips_gic_present() check in the opposite
> case of what Aleksander's patch modifies: does this indicate that
> unmasking CPU interrupt lines for VPE 1 is not handled by the MIPS CPU
> interrupt controller driver at all at this point (and if so: do you
> have any suggestions how to properly fix this)?

I haven't checked how GIC is integrated. Iirc it does something similair
to Lantiq's irq controller and hides all CPU internal interrupts behind
it.

So I see two solutions for your problem.

1. Add "mti,cpu-interrupt-controller" to the DT and wire it up
2. Create your own struct plat_smp_ops using vsmp_smp_ops as
   a template and overload .boot_secondary

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
