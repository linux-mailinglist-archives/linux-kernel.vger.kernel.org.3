Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977615A94C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiIAKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIAKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:38:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF541299CB;
        Thu,  1 Sep 2022 03:38:02 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHTc4lJyz688nt;
        Thu,  1 Sep 2022 18:34:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:37:59 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 11:37:59 +0100
Date:   Thu, 1 Sep 2022 11:37:57 +0100
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
Message-ID: <20220901113757.00004193@huawei.com>
In-Reply-To: <YxBTfD+4hDgo6Sah@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-9-rrichter@amd.com>
        <20220831115224.00003afd@huawei.com>
        <20220831121222.00000977@huawei.com>
        <YxBTfD+4hDgo6Sah@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Thu, 1 Sep 2022 08:38:52 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 12:12:22, Jonathan Cameron wrote:
> > > On Wed, 31 Aug 2022 10:15:56 +0200
> > > Robert Richter <rrichter@amd.com> wrote:  
> 
> > > > @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > > >  {
> > > >  	struct pci_bus *bus = host ? host->bus : NULL;
> > > >  	struct acpi_device *adev;
> > > > +	struct pci_dev *pdev;
> > > > +	bool is_restricted_host;
> > > >  
> > > >  	while ((bus = pci_find_next_bus(bus)) != NULL) {
> > > >  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> > > > @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > > >  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> > > >  			acpi_dev_name(adev));
> > > >  
> > > > +		/* Check CXL DVSEC of dev 0 func 0 */    
> > > 
> > > So assumption here is that the hostbridge has a one or more RCiEPs.
> > > The spec (r3.0 9.11.4) allows for the EP to appear behind a root port
> > > - that case always felt odd to me, so I'm fine with not supporting it until
> > > we see a user.
> > >   
> > > > +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> > > > +		is_restricted_host = pdev
> > > > +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > > > +			&& pci_find_dvsec_capability(pdev,
> > > > +						PCI_DVSEC_VENDOR_ID_CXL,
> > > > +						CXL_DVSEC_PCIE_DEVICE);  
> > 
> > Thinking a bit more on this.  I'm not sure this is sufficient.
> > Nothing in CXL 2.0 or later prevents true RCiEP devices (there are a
> > few references in CXL 3.0 e.g. 9.12.1 has RCDs or CXL RCiEPs - so just
> > detecting that there is one on the host bridge might not be sufficient
> > to distinguish this from a non RCH / RCB.  
> 
> An RCD has its own host bridge created (software view, not the phys
> topology). Host and device are paired in this case. Non-RCDs are
> standard endpoints and not RCiEPs, they have their own host.

I disagree. CXL spec does not exclude the possibility of real CXL
RCiEPs. So a CXL 2.0+ device that talks CXL configuration for some
reason but is part of the root complex itself (maybe a chiplet or
something where there isn't necessarily a real CXL bus involved).
Same reason we have RCiEPs in normal PCIe.

Chasing references - there is only one I can find (CXL r3.0 9.12.1)
"If a Host bridge is not associated with RCDs or CXL RCiEPs."

Both listed because they are different things.
(I think it's fine to say here that this has been queried in
appropriate place in the past and is something that is allowed).

So I still don't think the above check is sufficient'. If you
happen to have just one CXL 2.0+ RCiEP on a host bridge with
not root ports, then the check will identify it as a restriced
host.  Maybe I'm missing another check that wouldn't though....

> There
> cannot be both types connected to the same host.
> 
> Again, see figure 9-12 and 9-13.
Examples - don't show all the crazy things people are allowed to 
build - you would need an awful lot of diagrams to do that.

> 
> -Robert
> 
> >   
> > > > +		pci_dev_put(pdev);
> > > > +
> > > > +		if (!is_restricted_host)
> > > > +			continue;
> > > > +
> > > > +		dev_dbg(&host->dev, "CXL restricted host found\n");
> > > > +
> > > >  		return host;
> > > >  	}
> > > >  
> > > > @@ -354,6 +370,7 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> > > >  	struct pci_host_bridge *host = NULL;
> > > >  
> > > >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> > > > +		dev_info(&host->dev, "host supports CXL\n");
> > > >  	}
> > > >  
> > > >  	return 0;    
> > >   
> >   

