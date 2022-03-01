Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78194C91DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiCARjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiCARjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:39:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED241AF0F;
        Tue,  1 Mar 2022 09:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B0E5B81BE8;
        Tue,  1 Mar 2022 17:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF433C340EE;
        Tue,  1 Mar 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646156338;
        bh=ReB1AHIDSVDCmRMjQGBl11DT4sgFf0L/LuSK3Y+v9w8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dDgu84yJwqG2+6gzd9hDjEKwYgEr308ungqc4SZb3ZnxQqf3kh/fMbAKKcm1y5lkl
         el1IlJzIVvIVMLZzUqbJO9B0F8GQXXb3IV/fW6Cs1Vqui1g1o3NGTUwBE6P7bsZFbP
         gS5SewkmDb6rRF7tWbpAFHPC2J5vH2IC6tRxSQ7o0M+dohCgxo+6mFld8tRU0Bh1Vs
         Lhewoo+Xq9EeNYra03QUScexi9RDVBf8cIgbhdqvXzwdOXr7mu1bLi9PHHVjaB5XC3
         PqfhHnO1cBWA05UsJ7ysn8CLtxvtvaBIU2jK3qBta8sz56DChnNV8d0SmJmt4vs+Yk
         rrArPmfOE4Ejw==
Date:   Tue, 1 Mar 2022 11:38:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        "Meena, Mahesh" <mahesh.meena@intel.com>,
        linux-pci@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Prevent recursive locking on interrupt
 allocation
Message-ID: <20220301173856.GA633200@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5W9WHNH2FNu4hG@e123427-lin.cambridge.arm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 05:25:09PM +0000, Lorenzo Pieralisi wrote:
> On Sun, Feb 13, 2022 at 02:54:05PM +0100, Thomas Gleixner wrote:
> > Tejas reported the following recursive locking issue:
> > 
> >  swapper/0/1 is trying to acquire lock:
> >  ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0
> >  
> >  but task is already holding lock:
> >  ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at: __pci_enable_msi_range+0xf2/0x290
> >  
> >  stack backtrace:
> >   __mutex_lock+0x9d/0x920
> >   msi_get_virq+0x30/0xc0
> >   pci_irq_vector+0x26/0x30
> >   vmd_msi_init+0xcc/0x210
> >   msi_domain_alloc+0xbf/0x150
> >   msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
> >   __pci_enable_msi_range+0x155/0x290
> >   pci_alloc_irq_vectors_affinity+0xba/0x100
> >   pcie_port_device_register+0x307/0x550
> >   pcie_portdrv_probe+0x3c/0xd0
> >   pci_device_probe+0x95/0x110
> > 
> > This is caused by the VMD MSI code which does a lookup of the Linux
> > interrupt number for an VMD managed MSI[X] vector. The lookup function
> > tries to acquire the already held mutex.
> > 
> > Avoid that by caching the Linux interrupt number at initialization time
> > instead of looking it up over and over.
> > 
> > Fixes: 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
> > Reported-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Bjorn, this is a fix for a patch we merged in the last cycle,
> if possible we should be sending it before v5.17 is released,
> please.

Agreed.  I think Thomas merged 82ff8e6b78fc, and it looks like he's
just merged this fix to irq/urgent of tip, so I think this should be
already taken care of:

  https://lore.kernel.org/r/164542867635.16921.13795049956787158926.tip-bot2@tip-bot2

> >  drivers/pci/controller/vmd.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -99,11 +99,13 @@ struct vmd_irq {
> >   * @srcu:	SRCU struct for local synchronization.
> >   * @count:	number of child IRQs assigned to this vector; used to track
> >   *		sharing.
> > + * @virq:	The underlying VMD Linux interrupt number
> >   */
> >  struct vmd_irq_list {
> >  	struct list_head	irq_list;
> >  	struct srcu_struct	srcu;
> >  	unsigned int		count;
> > +	unsigned int		virq;
> >  };
> >  
> >  struct vmd_dev {
> > @@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domai
> >  	struct msi_desc *desc = arg->desc;
> >  	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
> >  	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> > -	unsigned int index, vector;
> >  
> >  	if (!vmdirq)
> >  		return -ENOMEM;
> > @@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domai
> >  	INIT_LIST_HEAD(&vmdirq->node);
> >  	vmdirq->irq = vmd_next_irq(vmd, desc);
> >  	vmdirq->virq = virq;
> > -	index = index_from_irqs(vmd, vmdirq->irq);
> > -	vector = pci_irq_vector(vmd->dev, index);
> >  
> > -	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
> > +	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
> >  			    handle_untracked_irq, vmd, NULL);
> >  	return 0;
> >  }
> > @@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev
> >  			return err;
> >  
> >  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> > -		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
> > +		vmd->irqs[i].virq = pci_irq_vector(dev, i);
> > +		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
> >  				       vmd_irq, IRQF_NO_THREAD,
> >  				       vmd->name, &vmd->irqs[i]);
> >  		if (err)
> > @@ -969,7 +969,7 @@ static int vmd_suspend(struct device *de
> >  	int i;
> >  
> >  	for (i = 0; i < vmd->msix_count; i++)
> > -		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> > +		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
> >  
> >  	return 0;
> >  }
> > @@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev
> >  	int err, i;
> >  
> >  	for (i = 0; i < vmd->msix_count; i++) {
> > -		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> > +		err = devm_request_irq(dev, vmd->irqs[i].virq,
> >  				       vmd_irq, IRQF_NO_THREAD,
> >  				       vmd->name, &vmd->irqs[i]);
> >  		if (err)
