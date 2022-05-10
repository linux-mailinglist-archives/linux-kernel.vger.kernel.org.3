Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21CE5214ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiEJMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbiEJMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:17:20 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A944C7B8;
        Tue, 10 May 2022 05:13:22 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4D9AD2800F9B5;
        Tue, 10 May 2022 14:13:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 41A92155B88; Tue, 10 May 2022 14:13:20 +0200 (CEST)
Date:   Tue, 10 May 2022 14:13:20 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     maz@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <20220510121320.GA3020@wunner.de>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
 <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:54:21AM +0100, Mark Rutland wrote:
> On Fri, May 06, 2022 at 10:32:42PM +0200, Lukas Wunner wrote:
> > On Tue, Oct 26, 2021 at 10:25:04AM +0100, Mark Rutland wrote:
> > >  int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
> > >  {
> > > +	WARN_ON_ONCE(!in_irq());
> > >  	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> > >  }
> > >  EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
> > 
> > Why isn't the WARN_ON_ONCE() conditional on handle_enforce_irqctx()?
> > (See handle_irq_desc() and c16816acd086.)
> 
> I did this for consistency with the in_nmi() check in
> generic_handle_domain_nmi(); I was unaware of commit c16816acd086 and
> IRQD_HANDLE_ENFORCE_IRQCTX.

Actually, since you're mentioning the in_nmi() check, I suspect
there's another problem here:

generic_handle_domain_nmi() warns if !in_nmi(), then calls down 
to handle_irq_desc() which warns if !in_hardirq().  Doesn't this
cause a false-positive !in_hardirq() warning for a NMI on GIC/GICv3?

The only driver calling request_nmi() or request_percpu_nmi() is
drivers/perf/arm_pmu.c.  So that's the only one affected.
You may want to test if that driver indeed exhibits such a
false-positive warning since c16816acd086.


> > I believe the above change causes a regression in drivers/gpio/gpio-dln2.c
> > such that a gratuitous WARN splat is now emitted.
> 
> Do you mean you beleive that from inspection, or are you actually seeing this
> go wrong in practice?
> 
> If it's the latter, are you able to give a copy of the dmesg splat?

For gpio-dln2.c, I believe it from inspection.

For smsc95xx.c, I'm actually seeing it go wrong in practice,
unedited dmesg splat is included below FWIW.

That's with the following series applied on top of current net-next:
https://lore.kernel.org/netdev/cover.1651574194.git.lukas@wunner.de/

You need to remove the __irq_enter_raw() in patch [5/7] of that series
to actually see the WARN splat.  I used it to work around your
WARN_ON_ONCE() and that's what Marc took exception to.

With gpio-dln2.c, the call stack looks like this:

  dln2_rx()                         # drivers/mfd/dln2.c
    dln2_run_event_callbacks()
      dln2_gpio_event()             # drivers/gpio/gpio-dln2.c
        generic_handle_domain_irq()

That's basically the same as the callstack for smsc95xx.c below.
Interrupts are disabled in dln2_rx() via spin_lock_irqsave(),
but there isn't an __irq_enter_raw() anywhere to be seen
and that would be necessary to avoid the false-positive
WARN splat in generic_handle_domain_irq().

Thanks,

Lukas

-- >8 --

[ 1227.718928] WARNING: CPU: 3 PID: 75 at kernel/irq/irqdesc.c:702 generic_handle_domain_irq+0x88/0x94
[ 1227.718951] Modules linked in: sha256_generic cfg80211 rfkill 8021q garp stp llc ax88796b asix raspberrypi_hwmon bcm2835_codec(C) bcm2835_v4l2(C) bcm2835_isp(C) v4l2_mem2mem bcm2835_mmal_vchiq(C) snd_bcm2835(C) vc_sm_cma(C) videobuf2_dma_contig videobuf2_vmalloc snd_pcm videobuf2_memops videobuf2_v4l2 videobuf2_common snd_timer snd videodev mc micrel ks8851_spi ks8851_common uio_pdrv_genirq uio eeprom_93cx6 piControl(O) ad5446 ti_dac082s085 mcp320x iio_mux mux_gpio mux_core fixed gpio_74x164 spi_bcm2835aux spi_bcm2835 gpio_max3191x crc8 industrialio i2c_dev ip_tables x_tables ipv6
[ 1227.719076] CPU: 3 PID: 75 Comm: irq/89-dwc_otg_ Tainted: G         C O      5.17.0-rt15-v7+ #2
[ 1227.719084] Hardware name: BCM2835
[ 1227.719087] Backtrace: 
[ 1227.719091]  dump_backtrace from show_stack+0x20/0x24
[ 1227.719106]  r7:00000009 r6:00000080 r5:80d25844 r4:60000093
[ 1227.719109]  show_stack from dump_stack_lvl+0x74/0x9c
[ 1227.719120]  dump_stack_lvl from dump_stack+0x18/0x1c
[ 1227.719134]  r7:00000009 r6:801957f4 r5:000002be r4:80d1e8ac
[ 1227.719137]  dump_stack from __warn+0xdc/0x190
[ 1227.719148]  __warn from warn_slowpath_fmt+0x70/0xcc
[ 1227.719161]  r8:00000009 r7:801957f4 r6:000002be r5:80d1e8ac r4:00000000
[ 1227.719163]  warn_slowpath_fmt from generic_handle_domain_irq+0x88/0x94
[ 1227.719177]  r8:81e87600 r7:00000000 r6:81d28000 r5:00000000 r4:81d4be00
[ 1227.719179]  generic_handle_domain_irq from smsc95xx_status+0x54/0xb0
[ 1227.719195]  r7:00000000 r6:00008000 r5:81f28640 r4:60000013
[ 1227.719197]  smsc95xx_status from intr_complete+0x80/0x84
[ 1227.719213]  r9:81d40a00 r8:00000001 r7:00000000 r6:00000000 r5:81f28640 r4:81d4bd80
[ 1227.719216]  intr_complete from __usb_hcd_giveback_urb+0xa4/0x12c
[ 1227.719229]  r5:815b3000 r4:81d4bd80
[ 1227.719232]  __usb_hcd_giveback_urb from usb_hcd_giveback_urb+0x118/0x11c
[ 1227.719245]  r7:811498e0 r6:81d4bd80 r5:81682000 r4:815b3000
[ 1227.719248]  usb_hcd_giveback_urb from completion_tasklet_func+0x7c/0xc8
[ 1227.719262]  r7:811498e0 r6:81d4bd80 r5:81682000 r4:8639f800
[ 1227.719264]  completion_tasklet_func from tasklet_callback+0x20/0x24
[ 1227.719277]  r6:80f8d140 r5:b6b5c330 r4:00000000
[ 1227.719279]  tasklet_callback from tasklet_action_common.constprop.0+0x148/0x220
[ 1227.719288]  tasklet_action_common.constprop.0 from tasklet_hi_action+0x28/0x30
[ 1227.719301]  r10:81d28000 r9:00000001 r8:00000000 r7:811498e0 r6:00000000 r5:00000001
[ 1227.719304]  r4:81003080
[ 1227.719306]  tasklet_hi_action from __do_softirq+0x154/0x3e8
[ 1227.719316]  __do_softirq from __local_bh_enable_ip+0x12c/0x1a8
[ 1227.719328]  r10:801970b0 r9:80f85320 r8:00000001 r7:00000000 r6:00000001 r5:00000100
[ 1227.719332]  r4:40000013
[ 1227.719334]  __local_bh_enable_ip from irq_forced_thread_fn+0x7c/0xac
[ 1227.719347]  r9:81d40ac0 r8:814f3c00 r7:00000001 r6:00000001 r5:814f3c00 r4:81d40ac0
[ 1227.719350]  irq_forced_thread_fn from irq_thread+0x16c/0x228
[ 1227.719363]  r7:00000001 r6:81d40ae4 r5:81d28000 r4:00000000
[ 1227.719365]  irq_thread from kthread+0x100/0x140
[ 1227.719380]  r10:00000000 r9:8154fbfc r8:81d43000 r7:81d40ac0 r6:80196dcc r5:81d40b00
[ 1227.719383]  r4:81d28000
[ 1227.719386]  kthread from ret_from_fork+0x14/0x34
[ 1227.719394] Exception stack(0x81777fb0 to 0x81777ff8)
[ 1227.719401] 7fa0:                                     00000000 00000000 00000000 00000000
[ 1227.719408] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 1227.719414] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 1227.719422]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8014a6c8 r4:81d40b00
[ 1227.719425] ---[ end trace 0000000000000000 ]---
