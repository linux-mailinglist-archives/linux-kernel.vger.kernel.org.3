Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7559F71F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHXKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiHXKIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:08:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F444AD75;
        Wed, 24 Aug 2022 03:07:59 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCMGY35VKz6H76r;
        Wed, 24 Aug 2022 18:07:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 12:07:56 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 11:07:56 +0100
Date:   Wed, 24 Aug 2022 11:07:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] CXL: Read and clear event logs
Message-ID: <20220824110755.00000c1e@huawei.com>
In-Reply-To: <YwQJAqThYczUHhOB@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220822161802.h47v7yfrqufeltqt@offworld>
        <YwQJAqThYczUHhOB@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 15:53:54 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Mon, Aug 22, 2022 at 09:18:02AM -0700, Davidlohr Bueso wrote:
> > On Fri, 12 Aug 2022, ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Event records inform the OS of various device events.  Events are not needed
> > > for any kernel operation but various user level software will want to track
> > > events.
> > > 
> > > Add event reporting through the trace event mechanism.  On driver load read and
> > > clear all device events.
> > > 
> > > Normally interrupts will trigger new events to be reported as they occur.
> > > Because the interrupt code is still being worked on this series provides a
> > > cxl-test mechanism to create a series of events and trigger the reporting of
> > > those events.  
> > 
> > Where is this irq code being worked on? I've asked about this for async mbox
> > commands, and Jonathan has also posted some code for the PMU implementation.  
> 
> I'm still trying to work out how to share irq's between PCI and CXL.  Mainly
> for DOE.
> 
> I thought that we could skip IRQ support for DOE completely and this would
> support your proposal below.  But I just found that:
> 
> "A device may interrupt the host when CDAT content changes using the MSI
> associated with this DOE Capability instance."

As of today that doesn't work because there is no status flag anywhere to let
you know that was the interrupt source.

It's been raised in appropriate places, but I can't say anymore on that
until stuff is published.

Hence I'd not worry about that corner for now.

> 
> So I guess it needs to be supported at some point.
> 
> > 
> > Could we not just start with an initial MSI/MSI-X support? Then gradually
> > interested users can be added? So each "feature" would need to do implement
> > it's "get message number" and to install the isr just do the standard:
> > 
> >      irq = pci_irq_vector(pdev, num);
> >      irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s\n", dev_name(dev),
> > 			       cxl_irq_cap_table[feature].name);
> >      rc = devm_request_irq(dev, irq, isr_fn, IRQF_SHARED, irq_name, info);
> > 
> > The only complexity I see for this is to know the number of vectors to request
> > apriori, for which we'd have to get the larges value of all CXL features that
> > can support interrupts. Something like the following?  
> 
> Generally it seems ok but I have questions below.
> 
> > One thing I have not
> > considered in this is the DOE stuff.  
> 
> I think this is the harder thing to support because of needing to allow both
> the PCI layer and the CXL layer to create irqs.  Potentially at different
> times.

My reasoning on this is that IRQ creation has to be done by
the PCI device driver.  That may result in some juggling and late starting
or indeed restarting of DOE mailboxes once we can know the list of vectors.
(e.g. query them by polling, then a later driver register can request enabling
the DOE with an irq).
Or it needs the ability to do dynamic increasing of the requested IRQ vectors.

> 
> > 
> > Thanks,
> > Davidlohr
> > 
> > ------
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..b334d2f497c1 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -245,6 +245,8 @@ struct cxl_dev_state {
> > 	resource_size_t component_reg_phys;
> > 	u64 serial;
> > 
> > +	int irq_type; /* MSI-X, MSI */
> > +
> > 	struct xarray doe_mbs;
> > 
> > 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index eec597dbe763..95f4b91f43b1 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -53,15 +53,6 @@
> >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> > 
> > -/* Register Block Identifier (RBI) */
> > -enum cxl_regloc_type {
> > -	CXL_REGLOC_RBI_EMPTY = 0,
> > -	CXL_REGLOC_RBI_COMPONENT,
> > -	CXL_REGLOC_RBI_VIRT,
> > -	CXL_REGLOC_RBI_MEMDEV,
> > -	CXL_REGLOC_RBI_TYPES
> > -};  
> 
> Why move this?
> 
> > -
> >  static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> > 						 struct cxl_register_map *map)
> >  {
> > @@ -75,4 +66,44 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> >  void read_cdat_data(struct cxl_port *port);
> > +
> > +#define CXL_IRQ_CAPABILITY_TABLE				\
> > +	C(ISOLATION, "isolation", NULL),			\
> > +	C(PMU, "pmu_overflow", NULL), /* per pmu instance */	\
> > +	C(MBOX, "mailbox", NULL), /* primary-only */		\
> > +	C(EVENT, "event", NULL),  
> 
> This is defining get_max_msgnum to NULL right?
> 
> > +
> > +#undef C
> > +#define C(a, b, c) CXL_IRQ_CAPABILITY_##a
> > +enum  { CXL_IRQ_CAPABILITY_TABLE };
> > +#undef C
> > +#define C(a, b, c) { b, c }
> > +/**
> > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> > + *
> > + * @name: Name of the device generating this interrupt.
> > + * @get_max_msgnum: Get the feature's largest interrupt message number. In cases
> > + *                  where there is only one instance it also indicates which
> > + *                  MSI/MSI-X vector is used for the interrupt message generated
> > + *                  in association with the feature. If the feature does not
> > + *                  have the Interrupt Supported bit set, then return -1.
> > + */
> > +struct cxl_irq_cap {
> > +	const char *name;
> > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> > +};
> > +
> > +static const
> > +struct cxl_irq_cap cxl_irq_cap_table[] = { CXL_IRQ_CAPABILITY_TABLE };
> > +#undef C  
> 
> Why all this macro magic?

Agreed. I'm rarely persuaded it's a good idea to do this sort of trickery
and it definitely isn't worth the readabilty problems unless there a
large number of users.

> 
> > +
> > +/* Register Block Identifier (RBI) */
> > +enum cxl_regloc_type {
> > +	CXL_REGLOC_RBI_EMPTY = 0,
> > +	CXL_REGLOC_RBI_COMPONENT,
> > +	CXL_REGLOC_RBI_VIRT,
> > +	CXL_REGLOC_RBI_MEMDEV,
> > +	CXL_REGLOC_RBI_TYPES
> > +};
> > +
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..c0fe78e0559b 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -387,6 +387,52 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > 	return rc;
> >  }
> > 
> > +static void cxl_pci_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int rc, i, vectors = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > +		int irq;
> > +
> > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > +			continue;
> > +
> > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > +		vectors = max_t(int, irq, vectors);
> > +	}
> > +
> > +	if (vectors == -1)
> > +		return -EINVAL; /* no irq support whatsoever */
> > +
> > +	vectors++;  
> 
> This is pretty much what earlier versions of the DOE code did with the
> exception of only have 1 get_max_msgnum() calls defined (for DOE).  But there
> was a lot of debate about how to share vectors with the PCI layer.  And
> eventually we got rid of it.  I'm still trying to figure it out.  Sorry for
> being slow.

I'm not yet setting huge advantage in wrapping this up. For now a set of
linear calls to establish the max irq vector is more readable.  Sure
down the line moving to this may make sense.

> 
> Perhaps we do this for this series.  However, won't we have an issue if we want
> to support switch events?

We 'could' extend existing stuff in the portdrv code (which is ultimately
where this general approach was copied from ;) but I suspect doing that
for non generic PCI stuff is going to be controversial.

That whole infrastructure in PCI may need a rewrite.

> 
> Ira
> 
> > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> > +	if (rc < 0) {
> > +		rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI);
> > +		if (rc < 0)
> > +			return rc;
> > +
> > +		cxlds->irq_type = PCI_IRQ_MSI;
> > +	} else {
> > +		cxlds->irq_type = PCI_IRQ_MSIX;
> > +	}
> > +
> > +	if (rc != vectors) {
> > +		pci_err(pdev, "Not enough interrupts; use polling where supported\n");
> > +		/* Some got allocated; clean them up */
> > +		cxl_pci_free_irq_vectors(pdev);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> > +}
> > +
> >  static void cxl_pci_destroy_doe(void *mbs)
> >  {
> > 	xa_destroy(mbs);
> > @@ -476,6 +522,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > 
> > 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> > 
> > +	if (cxl_pci_alloc_irq_vectors(cxlds))
> > +		cxlds->irq_type = 0;
> > +
> > 	devm_cxl_pci_create_doe(cxlds);
> > 
> > 	rc = cxl_pci_setup_mailbox(cxlds);  

