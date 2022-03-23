Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AA4E56F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiCWQxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 12:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbiCWQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:52:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0492140A2E;
        Wed, 23 Mar 2022 09:51:26 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nX4Cb-000381-K5; Wed, 23 Mar 2022 17:51:17 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v6 08/14] riscv: move boot alternatives to a slightly earlier position
Date:   Wed, 23 Mar 2022 17:51:16 +0100
Message-ID: <2695327.BEx9A2HvPv@diego>
In-Reply-To: <mhng-3d591628-2c87-40c7-91e4-407ad313a4aa@palmer-ri-x1c9>
References: <mhng-3d591628-2c87-40c7-91e4-407ad313a4aa@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. März 2022, 01:47:23 CET schrieb Palmer Dabbelt:
> On Wed, 09 Feb 2022 04:37:54 PST (-0800), heiko@sntech.de wrote:
> > Move the application of boot alternatives to soc_early_init().
> > This allows to catch more generic cases of code needing patches
> > than doing it in smp_prepare_boot_cpu() and also makes it actually
> > work if CONFIG_SMP is disabled for whatever reason.
> >
> > The position is chosen mainly as it is before the actual soc early
> > init runs but also already allows accessing the devicetree
> > via fdt_* functions.
> 
> I think this is OK, but it warrants testing on the K210 -- specifically 
> the system is in an odd state before soc_early_init (IIRC some of memory 
> doesn't work right) so I'm always a bit worried about calling stuff 
> there.  I don't have a K210 (or at least a working one), so I'm not 
> going to be able to test it.

just to finalize this partial thread, v7 and onward doesn't move
the alternative-application this early but instead actually behind
fill_hwcaps to be able to read available extensions.

So nothing to do for this - for people reading along, and me if
I don't remember this in the future ;-)

> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/kernel/head.S    | 2 ++
> >  arch/riscv/kernel/smpboot.c | 2 --
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 2363b43312fc..0e1bb97f9749 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -10,6 +10,7 @@
> >  #include <asm/thread_info.h>
> >  #include <asm/page.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/alternative.h>
> >  #include <asm/csr.h>
> >  #include <asm/cpu_ops_sbi.h>
> >  #include <asm/hwcap.h>
> > @@ -341,6 +342,7 @@ clear_bss_done:
> >  	call kasan_early_init
> >  #endif
> >  	/* Start the kernel */
> > +	call apply_boot_alternatives
> >  	call soc_early_init
> >  	tail start_kernel
> >
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index a6d13dca1403..f1e4948a4b52 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -32,7 +32,6 @@
> >  #include <asm/sections.h>
> >  #include <asm/sbi.h>
> >  #include <asm/smp.h>
> > -#include <asm/alternative.h>
> >
> >  #include "head.h"
> >
> > @@ -41,7 +40,6 @@ static DECLARE_COMPLETION(cpu_running);
> >  void __init smp_prepare_boot_cpu(void)
> >  {
> >  	init_cpu_topology();
> > -	apply_boot_alternatives();
> >  }
> >
> >  void __init smp_prepare_cpus(unsigned int max_cpus)
> 




