Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0545542FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiFHMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiFHMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:02:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AF131F08
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:02:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyuOd-0002h2-HI; Wed, 08 Jun 2022 14:02:47 +0200
Message-ID: <26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de>
Subject: Re: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in
 ->irq_unmask()/irq_mask()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Wed, 08 Jun 2022 14:02:46 +0200
In-Reply-To: <17d3adc7d7d329cab65b54ce71db05bc070872d1.camel@nxp.com>
References: <20220608105057.2607812-1-victor.liu@nxp.com>
         <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
         <17d3adc7d7d329cab65b54ce71db05bc070872d1.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
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

Am Mittwoch, dem 08.06.2022 um 19:29 +0800 schrieb Liu Ying:
> On Wed, 2022-06-08 at 12:56 +0200, Lucas Stach wrote:
> > Am Mittwoch, dem 08.06.2022 um 18:50 +0800 schrieb Liu Ying:
> > > Now that runtime PM support was added in this driver, we have
> > > to enable power before accessing irqchip registers.  And, after
> > > the access is done, we should disable power.  This patch calls
> > > pm_runtime_get_sync() in ->irq_unmask() and pm_runtime_put() in
> > > ->irq_mask() to make sure power is managed for the register access.
> > > 
> > 
> > Can you tell me in which case this is necessary? IIRC the IRQ core
> 
> With the i.MX8qxp DPU driver[1], I see below synchronous external
> abort:
> 
> [    1.207270] Internal error: synchronous external abort: 96000210
> [#1] PREEMPT SMP
> [    1.207287] Modules linked in:
> [    1.207299] CPU: 1 PID: 64 Comm: kworker/u8:2 Not tainted 5.18.0-
> rc6-next-20220509-00053-gf01f74ee1c18 #272
> [    1.207311] Hardware name: Freescale i.MX8QXP MEK (DT)
> [    1.207319] Workqueue: events_unbound deferred_probe_work_func
> [    1.207339] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.207349] pc : imx_irqsteer_irq_unmask+0x48/0x80
> [    1.207360] lr : imx_irqsteer_irq_unmask+0x38/0x80
> [    1.207368] sp : ffff80000a88b900
> [    1.207372] x29: ffff80000a88b900 x28: ffff8000080fed90 x27:
> ffff8000080fefe0
> [    1.207388] x26: ffff8000080fef40 x25: ffff0008012538d4 x24:
> ffff8000092fe388
> [    1.207407] x23: 0000000000000001 x22: ffff0008013295b4 x21:
> ffff000801329580
> [    1.207425] x20: ffff0008003faa60 x19: 000000000000000e x18:
> 0000000000000000
> [    1.207443] x17: 0000000000000003 x16: 0000000000000162 x15:
> 0000000000000001
> [    1.207459] x14: 0000000000000002 x13: 0000000000000018 x12:
> 0000000000000040
> [    1.207477] x11: ffff000800682480 x10: ffff000800682482 x9 :
> ffff80000a072678
> [    1.207495] x8 : ffff0008006a64a8 x7 : 0000000000000000 x6 :
> ffff0008006a6608
> [    1.207513] x5 : ffff800009070a18 x4 : 0000000000000000 x3 :
> ffff80000b240000
> [    1.207529] x2 : ffff80000b240038 x1 : 00000000000000c0 x0 :
> 00000000000000c0
> [    1.207549] Call trace:
> [    1.207553]  imx_irqsteer_irq_unmask+0x48/0x80
> [    1.207562]  irq_enable+0x40/0x8c
> [    1.207575]  __irq_startup+0x78/0xa4
> [    1.207588]  irq_startup+0x78/0x16c
> [    1.207601]  irq_activate_and_startup+0x38/0x70
> [    1.207612]  __irq_do_set_handler+0xcc/0x1e0
> [    1.207626]  irq_set_chained_handler_and_data+0x58/0xa0

Ooh, I think this is the problem. The IRQ is not requested in the usual
way when a chained handler is added, so this might bypass the runtime
PM handling normally done in the IRQ core. In that case this is a core
issue and should not be worked around in the driver, but the core
should take the RPM reference for the chained handler, just like it
does for normal IRQs.

Regards,
Lucas

> [    1.207642]  dpu_core_probe+0x368/0xbd4
> [    1.207653]  platform_probe+0x68/0xe0
> [    1.207667]  really_probe.part.0+0x9c/0x28c
> [    1.207678]  __driver_probe_device+0x98/0x144
> [    1.207692]  driver_probe_device+0xac/0x140
> [    1.207704]  __device_attach_driver+0xb4/0x120
> [    1.207716]  bus_for_each_drv+0x78/0xd0
> [    1.207727]  __device_attach+0xdc/0x184
> [    1.207739]  device_initial_probe+0x14/0x20
> [    1.207749]  bus_probe_device+0x9c/0xa4
> [    1.207762]  deferred_probe_work_func+0x88/0xc0
> [    1.207774]  process_one_work+0x1d0/0x320
> [    1.207788]  worker_thread+0x2c8/0x444
> [    1.207799]  kthread+0x10c/0x110
> [    1.207812]  ret_from_fork+0x10/0x20
> [    1.207829] Code: f94002a3 531e7662 aa0003e1 8b22c062 (b9400040)
> [    1.207839] ---[ end trace 0000000000000000 ]---
> 
> DPU DT node references an imx-irqsteer DT node as the interrupt parent.
> The DPU driver adds an irq domain by itself.
> 
> [1] 
> https://patchwork.kernel.org/project/dri-devel/patch/20220407091156.1211923-6-victor.liu@nxp.com/
> 
> Regards,
> Liu Ying
> 
> > already keeps the chip runtime resumed as soon as a IRQ is requested,
> > so why would it be in runtime suspend at mask/unmask?
> > 
> > Regards,
> > Lucas
> > 
> > > Fixes: 4730d2233311 ("irqchip/imx-irqsteer: Add runtime PM
> > > support")
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > >  drivers/irqchip/irq-imx-irqsteer.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/irqchip/irq-imx-irqsteer.c
> > > b/drivers/irqchip/irq-imx-irqsteer.c
> > > index 96230a04ec23..a5eabe71e8ab 100644
> > > --- a/drivers/irqchip/irq-imx-irqsteer.c
> > > +++ b/drivers/irqchip/irq-imx-irqsteer.c
> > > @@ -45,11 +45,14 @@ static int imx_irqsteer_get_reg_index(struct
> > > irqsteer_data *data,
> > >  
> > >  static void imx_irqsteer_irq_unmask(struct irq_data *d)
> > >  {
> > > +	struct device *dev = d->domain->dev;
> > >  	struct irqsteer_data *data = d->chip_data;
> > >  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> > >  	unsigned long flags;
> > >  	u32 val;
> > >  
> > > +	pm_runtime_get_sync(dev);
> > > +
> > >  	raw_spin_lock_irqsave(&data->lock, flags);
> > >  	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
> > >  	val |= BIT(d->hwirq % 32);
> > > @@ -59,6 +62,7 @@ static void imx_irqsteer_irq_unmask(struct
> > > irq_data *d)
> > >  
> > >  static void imx_irqsteer_irq_mask(struct irq_data *d)
> > >  {
> > > +	struct device *dev = d->domain->dev;
> > >  	struct irqsteer_data *data = d->chip_data;
> > >  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> > >  	unsigned long flags;
> > > @@ -69,6 +73,8 @@ static void imx_irqsteer_irq_mask(struct irq_data
> > > *d)
> > >  	val &= ~BIT(d->hwirq % 32);
> > >  	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
> > >  	raw_spin_unlock_irqrestore(&data->lock, flags);
> > > +
> > > +	pm_runtime_put(dev);
> > >  }
> > >  
> > >  static const struct irq_chip imx_irqsteer_irq_chip = {
> > 
> > 
> 


