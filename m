Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7154D376
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbiFOVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiFOVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38065535B;
        Wed, 15 Jun 2022 14:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5B861587;
        Wed, 15 Jun 2022 21:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DABC3411A;
        Wed, 15 Jun 2022 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655327783;
        bh=EsKroJBZ7tfp1Hmc6iEWarYjfY2NCNFIVVURsC5wcwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMBRODUIFQ5AsoFCRkThTmC4nRUwehZ3NrDVUmVIwfyupO0TzM5QWNwPkivvmOiCU
         dzFpa+2LC5aZpCmw6SN4tAaZq/s1hgsStu8qJH3BCLInzdXL/KUxJal9FlyKHEqOyA
         0TT+cNcOjyR6m+9+l6ueCdS48YjbLRP+QehZOxuHXMsqV4aRmNhsq/FMeKhqIlQ4GP
         EgdwCaeuM9A2aP8S4h/viHEjp/lQAcQt+GZqZFoWMMbGWfoRuV+QJJRFqJ7uBzYjHw
         6R/WVXUoCXdGDK3r6pWVAeHf8lIv3cZFwf8ACXGVRoOqdBF2apTMpEMi4pslnpMZ+h
         NAfZ1zxPiyqUw==
Date:   Thu, 16 Jun 2022 02:46:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com
Subject: Re: [PATCH] bus: mhi: Disable IRQs instead of freeing them during
 power down
Message-ID: <20220615211621.GD3606@thinkpad>
References: <1654782215-70383-1-git-send-email-quic_qianyu@quicinc.com>
 <62d09e6f-9898-6233-dfd6-b5ba5d837571@quicinc.com>
 <9659ecb9-9727-a146-e286-d28d656483c3@quicinc.com>
 <9a11394d-f7df-e549-8afb-0834f7d30202@quicinc.com>
 <8eceb966-b5c1-8913-ac97-95348f92650d@quicinc.com>
 <b3f5e49d-8917-79ab-8f59-29ad6cec3973@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3f5e49d-8917-79ab-8f59-29ad6cec3973@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:07:02AM -0600, Jeffrey Hugo wrote:
> On 6/12/2022 7:48 PM, Qiang Yu wrote:
> > 
> > On 6/10/2022 10:00 PM, Jeffrey Hugo wrote:
> > > On 6/9/2022 9:21 PM, Qiang Yu wrote:
> > > > On 6/9/2022 9:54 PM, Jeffrey Hugo wrote:
> > > > 
> > > > > On 6/9/2022 7:43 AM, Qiang Yu wrote:
> > > > > > EP tends to read MSI address/data once and cache them
> > > > > > after BME is set.
> > > > > > So host should avoid changing MSI address/data after BME is set.
> > > > > > 
> > > > > > In pci reset function, host invokes free_irq(), which also clears MSI
> > > > > > address/data in EP's PCIe config space. If the invalid address/data
> > > > > > are cached and used by EP, MSI triggered by EP wouldn't be received by
> > > > > > host, because an invalid MSI data is sent to an invalid MSI address.
> > > > > > 
> > > > > > To fix this issue, after host runs request_irq() successfully during
> > > > > > mhi driver probe, let's invoke enable_irq()/disable_irq() instead of
> > > > > > request_irq()/free_irq() when we want to power on and power down MHI.
> > > > > > Meanwhile, Host should invoke free_irq() when mhi host driver is
> > > > > > removed.
> > > > > 
> > > > > I don't think this works for hotplug, nor cases where there
> > > > > are multiple MHI devices on the system.
> > > > > 
> > > > > The EP shouldn't be caching this information for multiple
> > > > > reasons. Masking the MSIs, disabling the MSIs, changing the
> > > > > address when the affinity changes, etc.
> > > > > 
> > > > > It really feels like we are solving the problem in the wrong place.
> > > > > 
> > > > > Right now, this gets a NACK from me.
> > > > > 
> > > > After free_irq(), MSI is still enabled but MSI address and data
> > > > are cleared. So there is a chance that device initiates MSI
> > > > using zero address. How to fix this race conditions.
> > > 
> > > On what system is MSI still enabled?  I just removed the AIC100
> > > controller on an random x86 system, and lspci is indicating MSIs are
> > > disabled -
> > > 
> > > Capabilities: [50] MSI: Enable- Count=32/32 Maskable+ 64bit+
> > 
> > system: Ubuntu18.04, 5.4.0-89-generic,  Intel(R) Core(TM) i7-6700 CPU @
> > 3.40GHz
> > 
> > After removing MHI driver, I also see MSI enable is cleared.  But I
> > don't think free_irq clears it. I add log before free_irq and after
> > free_irq as following show:
> > 
> > [62777.625111] msi cap before free irq
> > [62777.625125] msi control=0x1bb, address=0xfee00318, data=0x0
> > [62777.625301] msi cap after free irq
> > [62777.625313] msi control=0x1bb, address=0x0, data=0x0
> > [62777.625496] mhi-pci-generic 0000:01:00.0: mhi_pci_remove end of line,
> > block 90 secs.
> > # lspci -vvs 01:00.0
> >          Capabilities: [50] MSI: Enable+ Count=8/32 Maskable+ 64bit+
> >                  Address: 0000000000000000  Data: 0000
> >                  Masking: ffffffff  Pending: 00000000
> 
> At this point, the MSI functionality is still enabled, but every MSI is
> masked out (Masking), so per the PCIe spec, the endpoint may not trigger a
> MSI to the host.  The device advertises that it supports maskable MSIs
> (Maskable+), so this is appropiate.
> 
> If your device can still send a MSI at this point, then it violates the PCIe
> spec.
> 
> disable_irq() will not help you with this as it will do the same thing.
> 
> I still think you are trying to fix an issue in the wrong location (host vs
> EP), and causing additional issues by doing so.
> 

Irrespective of caching the MSI data in endpoint, I'd like to get rid of
request_irq/free_irq during the mhi_{power_down/power_up} time. As like the MHI
endpoint stack, we should just do disable/enable irq. Because, the MHI device
may go down several times while running and we do not want to deallocate the
IRQs all the time. And if the device gets removed, ultimately the MHI driver
will get removed and we are fine while loading it back (even if MSI count
changes).

I didn't had time to look into the patch in detail but I'm in favour of
accepting the proposal.

@Jeff: Any specific issue you are seeing with hotplug etc...?

Thanks,
Mani

> > [62868.692186] mhi-pci-generic 0000:01:00.0: mhi_pci_remove 90 sec expire.
> > # lspci -vvs 01:00.0
> >          Capabilities: [50] MSI: Enable- Count=8/32 Maskable+ 64bit+
> >                  Address: 0000000000000000  Data: 0000
> >                  Masking: 00000000  Pending: 00000000
> > 
> > I also add msleep() at last of remove callback to block the remove
> > operation, then lspci shows MSI is still enabled  and after MHI driver
> > is removed,
> > 
> > lspci shows MSI is disabled. It proves free_irq does not clear MSI
> > enable, although I am not sure who does it (probably pci framework
> > clears but I don 't find it).
> > 
> > I delete pci_free_irq_vectors() when I test.
> > 
> > > 
> > > > Maybe EP should not cache MSI data and address. But I think this
> > > > patch is necessary and we will talk with EP POC.
> > > > 
> > > > > > 
> > > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > ---
> > > > > >   drivers/bus/mhi/host/init.c        | 31
> > > > > > +++++++++++++++++++++++++++++++
> > > > > >   drivers/bus/mhi/host/pci_generic.c |  2 ++
> > > > > >   drivers/bus/mhi/host/pm.c          |  4 ++--
> > > > > >   3 files changed, 35 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > > > > > index cbb86b2..48cb093 100644
> > > > > > --- a/drivers/bus/mhi/host/init.c
> > > > > > +++ b/drivers/bus/mhi/host/init.c
> > > > > > @@ -18,6 +18,7 @@
> > > > > >   #include <linux/slab.h>
> > > > > >   #include <linux/vmalloc.h>
> > > > > >   #include <linux/wait.h>
> > > > > > +#include <linux/irq.h>
> > > > > 
> > > > > Should be in alphabetical order
> > > > > 
> > > > > >   #include "internal.h"
> > > > > >     static DEFINE_IDA(mhi_controller_ida);
> > > > > > @@ -168,6 +169,22 @@ int mhi_init_irq_setup(struct
> > > > > > mhi_controller *mhi_cntrl)
> > > > > >       unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
> > > > > >       int i, ret;
> > > > > >   +    /*
> > > > > > +     * if irq[0] has action, it represents all MSI IRQs have been
> > > > > > +     * requested, so we just need to enable them.
> > > > > > +     */
> > > > > 
> > > > > This seems like an assumption about how the interrupts are
> > > > > allocated and assigned that may not hold true for all
> > > > > devices.
> > > > 
> > > > All interrupts are allocated and assigned together in
> > > > mhi_pci_get_irqs() and mhi_init_irq_setup().
> > > > 
> > > > So I think if irq[0] has action, other irqs must be requested
> > > > successfully. If any other msi request fail, irq[0] should have
> > > > been freed.
> > > > 
> > > > > > +    if (irq_has_action(mhi_cntrl->irq[0])) {
> > > > > > +        enable_irq(mhi_cntrl->irq[0]);
> > > > > > +
> > > > > > +        for (i = 0; i < mhi_cntrl->total_ev_rings; i++,
> > > > > > mhi_event++) {
> > > > > > +            if (mhi_event->offload_ev)
> > > > > > +                continue;
> > > > > > +
> > > > > > + enable_irq(mhi_cntrl->irq[mhi_event->irq]);
> > > > > > +        }
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > >       /* if controller driver has set irq_flags, use it */
> > > > > >       if (mhi_cntrl->irq_flags)
> > > > > >           irq_flags = mhi_cntrl->irq_flags;
> > > > > > @@ -179,6 +196,11 @@ int mhi_init_irq_setup(struct
> > > > > > mhi_controller *mhi_cntrl)
> > > > > >                      "bhi", mhi_cntrl);
> > > > > >       if (ret)
> > > > > >           return ret;
> > > > > > +    /*
> > > > > > +     * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
> > > > > > +     * so disable it explicitly.
> > > > > > +     */
> > > > > > +    disable_irq(mhi_cntrl->irq[0]);
> > > > > >         for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
> > > > > >           if (mhi_event->offload_ev)
> > > > > > @@ -200,6 +222,8 @@ int mhi_init_irq_setup(struct
> > > > > > mhi_controller *mhi_cntrl)
> > > > > >                   mhi_cntrl->irq[mhi_event->irq], i);
> > > > > >               goto error_request;
> > > > > >           }
> > > > > > +
> > > > > > +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
> > > > > >       }
> > > > > >         return 0;
> > > > > > @@ -1003,8 +1027,14 @@ int
> > > > > > mhi_register_controller(struct mhi_controller
> > > > > > *mhi_cntrl,
> > > > > >         mhi_create_debugfs(mhi_cntrl);
> > > > > >   +    ret = mhi_init_irq_setup(mhi_cntrl);
> > > > > > +    if (ret)
> > > > > > +        goto error_setup_irq;
> > > > > > +
> > > > > >       return 0;
> > > > > >   +error_setup_irq:
> > > > > > +    mhi_destroy_debugfs(mhi_cntrl);
> > > > > >   err_release_dev:
> > > > > >       put_device(&mhi_dev->dev);
> > > > > >   err_ida_free:
> > > > > > @@ -1027,6 +1057,7 @@ void
> > > > > > mhi_unregister_controller(struct mhi_controller
> > > > > > *mhi_cntrl)
> > > > > >       struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
> > > > > >       unsigned int i;
> > > > > >   +    mhi_deinit_free_irq(mhi_cntrl);
> > > > > >       mhi_destroy_debugfs(mhi_cntrl);
> > > > > >         destroy_workqueue(mhi_cntrl->hiprio_wq);
> > > > > > diff --git a/drivers/bus/mhi/host/pci_generic.c
> > > > > > b/drivers/bus/mhi/host/pci_generic.c
> > > > > > index 6fbc591..60020d0 100644
> > > > > > --- a/drivers/bus/mhi/host/pci_generic.c
> > > > > > +++ b/drivers/bus/mhi/host/pci_generic.c
> > > > > > @@ -945,6 +945,8 @@ static void mhi_pci_remove(struct pci_dev *pdev)
> > > > > >         mhi_unregister_controller(mhi_cntrl);
> > > > > >       pci_disable_pcie_error_reporting(pdev);
> > > > > > +
> > > > > > +    pci_free_irq_vectors(pdev);
> > > > > >   }
> > > > > >     static void mhi_pci_shutdown(struct pci_dev *pdev)
> > > > > > diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> > > > > > index dc2e8ff..190231c 100644
> > > > > > --- a/drivers/bus/mhi/host/pm.c
> > > > > > +++ b/drivers/bus/mhi/host/pm.c
> > > > > > @@ -500,7 +500,7 @@ static void
> > > > > > mhi_pm_disable_transition(struct mhi_controller
> > > > > > *mhi_cntrl)
> > > > > >       for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
> > > > > >           if (mhi_event->offload_ev)
> > > > > >               continue;
> > > > > > -        free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
> > > > > > +        disable_irq(mhi_cntrl->irq[mhi_event->irq]);
> > > > > >           tasklet_kill(&mhi_event->task);
> > > > > >       }
> > > > > >   @@ -1182,7 +1182,7 @@ void mhi_power_down(struct
> > > > > > mhi_controller *mhi_cntrl, bool graceful)
> > > > > >       /* Wait for shutdown to complete */
> > > > > >       flush_work(&mhi_cntrl->st_worker);
> > > > > >   -    free_irq(mhi_cntrl->irq[0], mhi_cntrl);
> > > > > > +    disable_irq(mhi_cntrl->irq[0]);
> > > > > >   }
> > > > > >   EXPORT_SYMBOL_GPL(mhi_power_down);
> > > > > 
> > > 
> 

-- 
மணிவண்ணன் சதாசிவம்
