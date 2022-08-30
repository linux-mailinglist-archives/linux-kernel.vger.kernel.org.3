Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3401C5A5FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH3Jrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3Jrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:47:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25F2A712
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QB4Gq1UMdj3Kc0Wy4bCvW3aFDa+/APBZ/JBQVxJFnQY=; b=0fxfgcVMQSiHJ7x00n/06Z4WD0
        dEEVUb2s9B1OpSIimxRwzSJhMs9kWPPwfqy2NeckmoRMNTGNulpV2u6NhQ+VPVmlSuuinaPoeVmb1
        hSu+b9C/ruHMwT6sNg+vgOExAETQlx1r20Q783nfE1qo/6QimdUfd/UkYBDTjN9M7R5zyUJIlkuGT
        C8GNpO8CFKrf8BNt98qBXQFcJzkikf5yXNnewUSbfxMWYQoWwwpzfmQLQt+5EqtZM00neGs0QDs9Y
        hdCd2GtfdmEfGXqUmSHs9Q+fJIXjEDGWwK3T8jCCdS9Vn+/b8EKPGMgtTt8MTvPj4GqGKhnsxpNeD
        o0hjECMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33988)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oSxqI-0002Uf-6y; Tue, 30 Aug 2022 10:47:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oSxqF-0001P6-K4; Tue, 30 Aug 2022 10:47:31 +0100
Date:   Tue, 30 Aug 2022 10:47:31 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
Message-ID: <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:20:00AM -0700, Saravana Kannan wrote:
> On Mon, Aug 29, 2022 at 11:59 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> > Commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> > forcibly invokes device_add() even if dev->periphid is not ready. Although
> > it will be remedied in amba_match(): dev->periphid will be initialized
> > if everything is in place; Otherwise, return -EPROBE_DEFER to block
> > __driver_attach() from further execution. But not all drivers have .match
> > hook, such as pl031, the dev->bus->probe will be called directly in
> > __driver_attach(). Unfortunately, if dev->periphid is still not
> > initialized, the following exception will be triggered.
> >
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 00000008
> > [00000008] *pgd=00000000
> > Internal error: Oops: 5 [#1] SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc2+ #7
> > Hardware name: ARM-Versatile Express
> > PC is at pl031_probe+0x8/0x208
> > LR is at amba_probe+0xf0/0x160
> > pc : 80698df8  lr : 8050eb54  psr: 80000013
> > sp : c0825df8  ip : 00000000  fp : 811fda38
> > r10: 00000000  r9 : 80d72470  r8 : fffffdfb
> > r7 : 811fd800  r6 : be7eb330  r5 : 00000000  r4 : 811fd900
> > r3 : 80698df0  r2 : 37000000  r1 : 00000000  r0 : 811fd800
> > Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 6000406a  DAC: 00000051
> > ... ...
> >  pl031_probe from amba_probe+0xf0/0x160
> >  amba_probe from really_probe+0x118/0x290
> >  really_probe from __driver_probe_device+0x84/0xe4
> >  __driver_probe_device from driver_probe_device+0x30/0xd0
> >  driver_probe_device from __driver_attach+0x8c/0xfc
> >  __driver_attach from bus_for_each_dev+0x70/0xb0
> >  bus_for_each_dev from bus_add_driver+0x168/0x1f4
> >  bus_add_driver from driver_register+0x7c/0x118
> >  driver_register from do_one_initcall+0x44/0x1ec
> >  do_one_initcall from kernel_init_freeable+0x238/0x288
> >  kernel_init_freeable from kernel_init+0x18/0x12c
> >  kernel_init from ret_from_fork+0x14/0x2c
> > ... ...
> > ---[ end trace 0000000000000000 ]---
> >
> > Therefore, take the same action as in amba_match(): return -EPROBE_DEFER
> > if dev->periphid is not ready in amba_probe().
> >
> > Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> > KernelVersion: v6.0-rc3
> >  drivers/amba/bus.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > v1 --> v2:
> > 1. Update this patch based on:
> >    https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/
> > 2. Move the operations of sanity checking and reading dev->periphid,
> >    updating uevent into new function amba_prepare_periphid().
> >
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 110a535648d2e1f..8e4c7e190880206 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -204,10 +204,9 @@ static int amba_read_periphid(struct amba_device *dev)
> >         return ret;
> >  }
> >
> > -static int amba_match(struct device *dev, struct device_driver *drv)
> > +static int amba_prepare_periphid(struct device *dev)
> >  {
> >         struct amba_device *pcdev = to_amba_device(dev);
> > -       struct amba_driver *pcdrv = to_amba_driver(drv);
> >
> >         mutex_lock(&pcdev->periphid_lock);
> >         if (!pcdev->periphid) {
> > @@ -228,6 +227,19 @@ static int amba_match(struct device *dev, struct device_driver *drv)
> >         }
> >         mutex_unlock(&pcdev->periphid_lock);
> >
> > +       return 0;
> > +}
> > +
> > +static int amba_match(struct device *dev, struct device_driver *drv)
> > +{
> > +       struct amba_device *pcdev = to_amba_device(dev);
> > +       struct amba_driver *pcdrv = to_amba_driver(drv);
> > +       int ret;
> > +
> > +       ret = amba_prepare_periphid(dev);
> > +       if (ret)
> > +               return ret;
> > +
> >         /* When driver_override is set, only bind to the matching driver */
> >         if (pcdev->driver_override)
> >                 return !strcmp(pcdev->driver_override, drv->name);
> > @@ -278,9 +290,15 @@ static int amba_probe(struct device *dev)
> >  {
> >         struct amba_device *pcdev = to_amba_device(dev);
> >         struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> > -       const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> > +       const struct amba_id *id;
> >         int ret;
> >
> > +       ret = amba_prepare_periphid(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       id = amba_lookup(pcdrv->id_table, pcdev);
> > +
> >         do {
> >                 ret = of_amba_device_decode_irq(pcdev);
> >                 if (ret)
> 
> Let's wait for Isaac to review this. He has been looking at the
> locking issue for a bit and there were some tricky cases.

How can we get to amba_probe() if amba_match() has not returned a
positive match for an ID? Surely if that happens, the driver model
is failed - since a probe function should not be called unless the
driver matches the device.

This patch, and 9229/1 both feel like they're working around some
brokenness elsewhere in the kernel.

The description in 9229/1, specifically "But not all drivers have .match
hook, such as pl031, the dev->bus->probe will be called directly in
__driver_attach()." AMBA drivers do not have a .match hook - the bus
does, which all AMBA drivers must be a member of. If amba_match fails,
there is no way that amba_probe() should ever be called.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
