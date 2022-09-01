Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79525A9469
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiIAKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiIAKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:24:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A93138582;
        Thu,  1 Sep 2022 03:23:53 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHDz37Fqz67xgN;
        Thu,  1 Sep 2022 18:23:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:23:50 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 11:23:50 +0100
Date:   Thu, 1 Sep 2022 11:23:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 08/15] cxl/acpi: Check RCH's CXL DVSEC capabilities
Message-ID: <20220901112348.000003f1@huawei.com>
In-Reply-To: <YxBRmXOpc+ldConT@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-9-rrichter@amd.com>
        <20220831115224.00003afd@huawei.com>
        <YxBRmXOpc+ldConT@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 1 Sep 2022 08:30:49 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 11:52:24, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:56 +0200
> > Robert Richter <rrichter@amd.com> wrote:  
> 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index ffdf439adb87..f9cdf23a91a8 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > >  {
> > >  	struct pci_bus *bus = host ? host->bus : NULL;
> > >  	struct acpi_device *adev;
> > > +	struct pci_dev *pdev;
> > > +	bool is_restricted_host;
> > >  
> > >  	while ((bus = pci_find_next_bus(bus)) != NULL) {
> > >  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> > > @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > >  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> > >  			acpi_dev_name(adev));
> > >  
> > > +		/* Check CXL DVSEC of dev 0 func 0 */  
> > 
> > So assumption here is that the hostbridge has a one or more RCiEPs.
> > The spec (r3.0 9.11.4) allows for the EP to appear behind a root port
> > - that case always felt odd to me, so I'm fine with not supporting it until
> > we see a user.  
> 
> The software view of an RCD is always the same, it shows up always as
> an RCiEP. See figure 9-12 and 9-13 of the spec.

Ah. I see I misread the following from CXL r3.0 9.11.4 

"This ACPI Host Bridge spawns a legal PCIe hierarchy. All PCIe Endpoints located in the 
RCD are children of this ACPI Host Bridge. These Endpoints may appear directly on the 
Root bus number or may appear behind a Root Port located on the Root bus."

I guess that is allowing 'additional' PCIe endpoints below a root port attached
to the ACPI Host Bridge, but not dev 0 func 0.  That's a subtle distinction
I missed.


> 
> -Robert
> 
> >   
> > > +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> > > +		is_restricted_host = pdev
> > > +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > > +			&& pci_find_dvsec_capability(pdev,
> > > +						PCI_DVSEC_VENDOR_ID_CXL,
> > > +						CXL_DVSEC_PCIE_DEVICE);
> > > +		pci_dev_put(pdev);
> > > +
> > > +		if (!is_restricted_host)
> > > +			continue;
> > > +
> > > +		dev_dbg(&host->dev, "CXL restricted host found\n");
> > > +
> > >  		return host;
> > >  	}  

