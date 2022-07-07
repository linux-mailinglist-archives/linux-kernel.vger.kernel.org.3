Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20F56A6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiGGPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGGPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:12:46 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFF62CDF9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:12:45 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id ED5052F6E0D;
        Thu,  7 Jul 2022 17:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1657206763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyh/5lNVuEw7BeBKEgILa47+nLSXZrJB+DRzXHEONXE=;
        b=2Qpm++Lka0nsO5CtJVS7ivgl3S1xoy86MVdZhHPUzQorJBvJLHCUQbUs0a0W8xPa7leOe3
        UQPuZvGEjqNwt8gaOfGVcO8Nrp81m4zCH40/EgoQGjUvOPuEzaF6cZSL8xPcaWCTL1d/kr
        agL1ULMFVKm6s8HfTVM5iOjT/b5H6x8H2I9zZBaPMeiig5sffDrYUSKG7G5jU9N1U3bWOm
        STM3JSvmNRMtFjE9R+B834vDW8cBt7izw1VIo0YWlI/hD+2yIZZJ1tXOv0cwqlDm9j6K/q
        dXu3ByIH0U+ZdIq4uxvVcs1O3HM973pJYCW3gHrf6lTsxy2fOV+foqVum94T7Q==
Message-ID: <468a2c8578d099eef0e0106fe273f73f5d70ef94.camel@svanheule.net>
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Jul 2022 17:12:42 +0200
In-Reply-To: <20220707143930.GA14693@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
         <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
         <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
         <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
         <20220707100630.GC9894@alpha.franken.de>
         <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
         <20220707143930.GA14693@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-07 at 16:39 +0200, Thomas Bogendoerfer wrote:
> On Thu, Jul 07, 2022 at 02:57:15PM +0200, Martin Blumenstingl wrote:
> > On Thu, Jul 7, 2022 at 12:11 PM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> > [...]
> > > > - why can MIPS CPU interrupt 6 and 7 be enabled unconditionally whi=
le
> > > > 2-5 cannot be enabled unconditionally?
> > >=20
> > > 7 is timer interrupt and is usually wired for 34K cpus and 6 is
> > > performance counter hopefully handled as well. And I agree that
> > > this still isn't the best approach here
> > Thanks for this explanation!
> >=20
> > > > - seeing that there's also a mips_gic_present() check in the opposi=
te
> > > > case of what Aleksander's patch modifies: does this indicate that
> > > > unmasking CPU interrupt lines for VPE 1 is not handled by the MIPS =
CPU
> > > > interrupt controller driver at all at this point (and if so: do you
> > > > have any suggestions how to properly fix this)?
> > >=20
> > > I haven't checked how GIC is integrated. Iirc it does something simil=
air
> > > to Lantiq's irq controller and hides all CPU internal interrupts behi=
nd
> > > it.
> > >=20
> > > So I see two solutions for your problem.
> > >=20
> > > 1. Add "mti,cpu-interrupt-controller" to the DT and wire it up
> > I think this is the preferred way. I tried this before (if you are
> > curious, see [0] and [1]) and it didn't work.
> > Are you aware of any MIPS SoC with upstream drivers which do have
> > working IRQs on VPE 1?
>=20
> I don't know of such SoC. Looking at the comment in vsmp_init_secondary()
>=20
> /* This is Malta specific: IPI,performance and timer interrupts */
>=20
> there is probably some Malta board using it.
>=20
> > Or can you point me to the code in
> > drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
> > interrupts on VPE 1 (is it simply unmask_mips_irq)?
>=20
> IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
> on the same CPU. I've checked MIPS MT specs and it's possible do
> modify CP0 registers between VPEs. Using that needs changes in
> irq-mips-cpu.c. But mabye that's not woth the effort as probably
> all SMP cabable platforms have some multi processort capable
> interrupt controller implemented.

Maybe I'm not getting this right, but as I understand vsmp_init_secondary()=
 is
run on VPE1, changing the local c0_status on that VPE. When unmask_mips_irq=
() is
called from code running on VPE1, I would expect it does the same thing: en=
able
the requested irq on VPE1 by modifying the local c0_status register.

Since these IRQs can be configured VPE, aren't these then also per-cpu
interrupts? I have been wondering if a cascaded IRQ controller needs to tak=
e
special care with such per-cpu interrupts, but haven't been able to figure =
that
out until now.

Sorry if the above doesn't make much sense, but like Aleksander I've been
struggling with this and would like to understand what the proper solution =
is.

Best,
Sander

> I thought about another way solve the issue. By introducing a
> new function in smp-mt.c which sets the value of the interrupt
> mask for the secondary CPU, which is then used in vsmp_init_secondary().
> Not sure if this is worth the effort compared to a .boot_secondary
> override.
>=20
> Thomas.
>=20

