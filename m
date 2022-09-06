Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACA5AE530
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiIFKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiIFKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:20:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CD419A7;
        Tue,  6 Sep 2022 03:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9pPtE5z37tmPCpiMlMGpSsN0p3seuwS0AIWv54S5JkTkOuBVR5RB6IewirGmyEKI4PTXJytGJfuC+cuz01pqRMJ7WITaB5zPC4xD3Ww0YxEuO7LyOYa+niJXXI2+Ufoi8A7ivgScRTlxDQ3GB16ToIGxsmTBF3Xu9Om51FTydguXCQ7qUW2sATmanIuGFDrmSQgGvOitU9SOJlfmHRw5/2oEY6hfaoQv+URZ2afgFwn3WRe3R4ZI8wljXowQrAqw/8zQ6DNhmLytxy+LJZDBjAA+sP/yhrG6i2gA6muwwtBQRG4yqbxA55QEwSgbtejKjheZnaX7LabC6N0G6RsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PhL6rePSG6AsEFHHd6mbmbLmFb70gLv+qTpdmGUeB0=;
 b=Q6qZlzisb2dB42e9bY0RW4ny3JAJSsK3swn04L/aO7K+LhFBNp2s4uwGz+ZntALPIfAb6sBRWSIkPgHnprD8bEATqCyTj4eAn1h5vuJmHS687EMEIDH8Bb/bwjn5gr7yGGurzYmcVEeBmk65aCGZkB5Ym77q+BqSU/7LOYnmRx/JtokZNIAsFDPiHf6ZLJbr56Grt7exDu1seDuiBUcJ7KD7A1rQclQFixwjMOiQUFBYVyqqfQULO/3LF8ufqbMtj7pd4fWBojHMA1n2ku7R0ZG4JsDsXi6rF1VxvcSsgoK1voRcGnBuQg7pErCrAE4JvnsbXubjyMP6j0gZmH8iDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PhL6rePSG6AsEFHHd6mbmbLmFb70gLv+qTpdmGUeB0=;
 b=uHdzvN7uhzp2UgwfFxzBCGm8RcivQFR6R/wu0Dvm1dB2mhchDRsQs02CCN8zA1VHp3EzhcblTZ0zMPNgMbCF3fYV/RgGj53ilGvQOka2k3DmALpwFxVIvG9kvbmgeToRXRNGLGV/gFxwVs5dhVsOZqF2FNY65d6AknwTB8E7QGc=
Received: from DS7PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:3b7::6) by
 BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 10:20:41 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::91) by DS7PR03CA0091.outlook.office365.com
 (2603:10b6:5:3b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Tue, 6 Sep 2022 10:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 10:20:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 05:20:37 -0500
Date:   Tue, 6 Sep 2022 12:20:35 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <Yxce87j/jFtAd5/V@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-9-rrichter@amd.com>
 <20220831115224.00003afd@huawei.com>
 <20220831121222.00000977@huawei.com>
 <YxBTfD+4hDgo6Sah@rric.localdomain>
 <20220901113757.00004193@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901113757.00004193@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c02463f-aeed-43fa-5d91-08da8ff1730d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5851:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqH0YdOOMsdd7WOFqg51V4Uu9spglrs2Ph0lsCLxQF+LLfRZIpUpsaupTWYhsH24a2VKkzfDs2q5B9oefnNYVHnKyf2fkDl4iwhuGkb7PWMssZStq8HCt8p0ITbA/tIDcczRI/p5Jl38DeuHFrk+tanKQqMgg35SpuMbHDrcarbtQLwKU51BWfc6qDGV0XzE9CJ51aFv/4pv5YMZVKjIWbK+XaomzjuJLpTNLQk2K6UQqJvbUflB4oNRSbJk85aSY9/2xjkgs5kfyzqFnwTDEVdx99ZEnIqSPkU9YcXcIRBzXo9rCxpryo5gMwjldMX/Bytnw9NdRUYZOb4gRI2zdeQwc+QD+rEXW27DrsF4V3qGwyzDORSoQS8GVtRCdWtq0B1PAuSxit2HCe+6ENgtlXjwxTGuc6ji807LfvTrFYYeaqSN/yNlrAhH7kCH+AZ3LaaNdR2mUj39B+/GDjKP34Zo6dhxSDfVFhKGK9x3tGKLhnV+HCkcLHOIvlkjA399FlhmaeTN21ggKfgMPeBZlkMdOjZM5UN6kRAUhwHcJML3S+sEvMYKw4DJaxnIQYf9NzQ6hMFITDWrgFUVupPtkZDTPFfrkeXJqNTstpE5pbk694QlPiXBd6EEUIqZkihijqQfqmT5rPeDI6UIqVmU5yx7hbWvqWhLxVwZgSlUdbJmrC6xgnH17vZV/UNluBGG8EGzGWAXm5c9DK9Yu7HZs+Nq715gFfFpgzC4dqz/stGXlUns4wTuC+I429lD4Ie3SzBH4Dzwh7uHhyYPUZ/F/QEURb6hoNRN2pBfZ/O0LnxA/4xeY7yqVkGRVsZ/WuLD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(40470700004)(46966006)(478600001)(53546011)(7696005)(70206006)(9686003)(26005)(70586007)(2906002)(4326008)(36860700001)(40480700001)(55016003)(7416002)(82310400005)(47076005)(5660300002)(426003)(40460700003)(8676002)(41300700001)(186003)(83380400001)(54906003)(316002)(336012)(82740400003)(81166007)(8936002)(356005)(16526019)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 10:20:40.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c02463f-aeed-43fa-5d91-08da8ff1730d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 11:37:57, Jonathan Cameron wrote:
> On Thu, 1 Sep 2022 08:38:52 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 31.08.22 12:12:22, Jonathan Cameron wrote:
> > > > On Wed, 31 Aug 2022 10:15:56 +0200
> > > > Robert Richter <rrichter@amd.com> wrote:  
> > 
> > > > > @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > > > >  {
> > > > >  	struct pci_bus *bus = host ? host->bus : NULL;
> > > > >  	struct acpi_device *adev;
> > > > > +	struct pci_dev *pdev;
> > > > > +	bool is_restricted_host;
> > > > >  
> > > > >  	while ((bus = pci_find_next_bus(bus)) != NULL) {
> > > > >  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> > > > > @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > > > >  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> > > > >  			acpi_dev_name(adev));
> > > > >  
> > > > > +		/* Check CXL DVSEC of dev 0 func 0 */    
> > > > 
> > > > So assumption here is that the hostbridge has a one or more RCiEPs.
> > > > The spec (r3.0 9.11.4) allows for the EP to appear behind a root port
> > > > - that case always felt odd to me, so I'm fine with not supporting it until
> > > > we see a user.
> > > >   
> > > > > +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> > > > > +		is_restricted_host = pdev
> > > > > +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > > > > +			&& pci_find_dvsec_capability(pdev,
> > > > > +						PCI_DVSEC_VENDOR_ID_CXL,
> > > > > +						CXL_DVSEC_PCIE_DEVICE);  
> > > 
> > > Thinking a bit more on this.  I'm not sure this is sufficient.
> > > Nothing in CXL 2.0 or later prevents true RCiEP devices (there are a
> > > few references in CXL 3.0 e.g. 9.12.1 has RCDs or CXL RCiEPs - so just
> > > detecting that there is one on the host bridge might not be sufficient
> > > to distinguish this from a non RCH / RCB.  
> > 
> > An RCD has its own host bridge created (software view, not the phys
> > topology). Host and device are paired in this case. Non-RCDs are
> > standard endpoints and not RCiEPs, they have their own host.
> 
> I disagree. CXL spec does not exclude the possibility of real CXL
> RCiEPs. So a CXL 2.0+ device that talks CXL configuration for some
> reason but is part of the root complex itself (maybe a chiplet or
> something where there isn't necessarily a real CXL bus involved).
> Same reason we have RCiEPs in normal PCIe.
> 
> Chasing references - there is only one I can find (CXL r3.0 9.12.1)
> "If a Host bridge is not associated with RCDs or CXL RCiEPs."
> 
> Both listed because they are different things.
> (I think it's fine to say here that this has been queried in
> appropriate place in the past and is something that is allowed).
> 
> So I still don't think the above check is sufficient'. If you
> happen to have just one CXL 2.0+ RCiEP on a host bridge with
> not root ports, then the check will identify it as a restriced
> host.  Maybe I'm missing another check that wouldn't though....
> 
> > There
> > cannot be both types connected to the same host.
> > 
> > Again, see figure 9-12 and 9-13.
> Examples - don't show all the crazy things people are allowed to 
> build - you would need an awful lot of diagrams to do that.

Right, there are references to CXL 2.0+ devices implemented as RCiEPs.

"9.12 CXL VH Enumeration" states that for the CXL Host Bridge
identification the CEDT should be used:

"""
CXL Early Discovery Table (CEDT) may be used to differentiate
between the three software concepts listed above.
"""

This check is added in patch #10 where the RCRB is extracted, so we
are good here.

-Robert
