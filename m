Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB5B5A907A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiIAHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiIAHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:38:23 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE6109085;
        Thu,  1 Sep 2022 00:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFqKvwPGO0NC6c81rmXECkvxbQHaqL6EKN6140cH9iWgBwdIY56xrhPicNUV7dlBaP+qB2OfT4aUKkwXkVssH//xGmw0CKEx1COWgKZ78De8BVUor1xJIqFK7OGSZioZszwIZwfX09vmk//6BzXOiQYCxxI3/plNQkzxEZL9rqNsTNptpWPJIkCGNOGEZkTcODKacdw6RugjKyTytgrJRZXZ+nc8XBfJ6pvXZZEipR1u3aP6W5ueBaOh+VqjLZtzrOp9/BD78GlfE0gwDqKq1Ao9h8WDn8e/8x8vCcudpdAmkitjVkjsPFY9TEm6uTPiaNxdNa772SQdX+ounNVWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qVxyvhoJQaDpxz9vR9FVIK1c0s9HfqZNZMOqfAKCAY=;
 b=H2zOma9NkZq0bRJWqy9RjhrRsV6C2BxFuAzjx/BDvKtL2VdRXK8rdKfb65zqgIdEsG0c6cphKpNqJq4U24HxCBfggzJyRZ8QAS1wzAPTtPAek+71aVWtYFZz0CxLFBn8QeBU5ghg9EdPRUfypUfb5gVoVKy93Tkhdb6H9vj2UXLtqu64+u9UfIEelXUTqn6ScMCo3z4kRHCo3mUKpDpiEOGopvHjoE2sDfF3U68QeyegRXkWl89wHcp778SDDNDHjaLNgSa/k7SX0GYz4qHevWMMMWE33Mvllog5YSSMCL/SGvjmu6P210GM//ssjgrohZAd4VWye750D3oxezra6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qVxyvhoJQaDpxz9vR9FVIK1c0s9HfqZNZMOqfAKCAY=;
 b=Squ2iVENl1ZH2/tIXD+2FNjMR0J3xcn1gcdH3KA7kNo0cFFD7K2NpSF+Q5L1vF+Wganf5drc6bkpZN238B4y/jR4MNAiqH398XoMYhLE8f2ZYKiDGPfY3NxlbQN91TLu6fmICc8o+tQL3NySycujGfvpU8IPX1JVTORGUzDTTJA=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Thu, 1 Sep 2022 07:38:19 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::3) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:38:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:38:15 -0500
Date:   Thu, 1 Sep 2022 09:38:13 +0200
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
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 11/15] cxl/acpi: Extract the host's component register
 base address from RCRB
Message-ID: <YxBhZdYz606i+pAN@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-12-rrichter@amd.com>
 <20220831125656.00007beb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831125656.00007beb@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc88475-899e-4b1d-bdba-08da8becf083
X-MS-TrafficTypeDiagnostic: PH8PR12MB7157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPywuGUX8tU2j3FmMqAgucKgytZOYu72mKwJYunCWS1+pf0fBeelv8+nr2Q7+Gr8oWVUGdc8wVaeP77+rB2yy+zVdvUx3zpT+l5ALNPKqkYtJiqBSSJLU+QeJbTU4ejBIv/m4CHmVbmx1n2RSAVgHlamyjIRfe8HUJe3si22kq0qTECu0mSJPTPhPa346XuAOhSkJNy34utz/BH4EDwmdReBmgd9yP7Jsng9srA7P4zzd2VWugcDToz6g5pyr3vHEj8ZhJ2D/uMmyjhBzNHBl9r3H2eCH1ZQkWkNAnz7c63rrp7bWPfu730iYtzgL0IF48eiObTsz7txALwGT8HQ6x35fKAJKdkN5FIsmGT1b0wYru8ujMFYDEgDttaLboXun2l6K4Q+pPjMtKGTnDoUp/OOnua4GB4al2I2VlRaK2JzP13+ZdiE2FdcLneOZDCebtpUErxwyh+Rr3etCFOW6wKKAg5sKlXgCcBUjPUaHo9yGsaySsiP1+X6RXnwFdEzVtwGCpeNDHcC5rCnimFFULMHgCsZBduv+X4cyoYkxkXU2/HKI7EgFNfFoxpd1K2acemOfRgH+MEVjXdqr+EQbpLzxpCKWY5Jnvp3cJThD5k9A2oR63/b6MpIXiFoP6m7K/d0ScF7xcbdYKb4PKbT56OfL8dp3jJqiBzO1kE54Px/DoqfnInbjOTCOnQhgekOTdT17QhFgQLjIjQKE71ATkgET7TY+V4qyX9lkrbN4jAHzfAtjHyH0FgVHrRVjh8IyBrD6sNCGS46lVm2HRUpMaopLcONKeBxe+RswGmyTbYmvbZJ3Z0g/+hp9RCE8omJM0NhWThaY3+1tZ8YEN/guw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(54906003)(16526019)(83380400001)(36860700001)(426003)(70206006)(2906002)(47076005)(82310400005)(186003)(82740400003)(356005)(316002)(81166007)(336012)(40460700003)(26005)(53546011)(9686003)(5660300002)(6916009)(41300700001)(7696005)(8676002)(4326008)(70586007)(55016003)(7416002)(8936002)(478600001)(40480700001)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:38:18.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc88475-899e-4b1d-bdba-08da8becf083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 12:56:56, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:59 +0200
> Robert Richter <rrichter@amd.com> wrote:

> A few comments inline.  Mostly requests for references for things
> I couldn't find in the specs.

Most of it comes from the pci base spec (5 or 6).

> 
> > ---
> >  drivers/cxl/acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 439df9df2741..88bbd2bb61fc 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -401,12 +401,84 @@ static resource_size_t cxl_get_rcrb(u32 uid)
> >  	return ctx.chbcr;
> >  }
> >  
> > +static resource_size_t cxl_get_component_reg_phys(resource_size_t rcrb)
> > +{
> > +	resource_size_t component_reg_phys;
> > +	u32 bar0, bar1;
> > +	void *addr;
> > +
> > +	/*
> > +	 * RCRB's BAR[0..1] point to component block containing CXL subsystem
> > +	 * component registers.
> > +	 * CXL 8.2.4 - Component Register Layout Definition.
> 
> For references include spec version.  Based on discussion other day,
> preference is always latest version. So r3.0 8.2.3
> is probably right. I think your references are CXL r2.0?

Right will update the comment.

> 
> 
> > +	 *
> > +	 * Also, RCRB accesses must use MMIO readl()/readq() to guarantee
> > +	 * 32/64-bit access.
> > +	 * CXL 8.2.2 - CXL 1.1 Upstream and Downstream Port Subsystem Component
> > +	 * Registers
> > +	 */
> > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> 
> The spec is a bit confusing on this, but I think you are reading into
> MEMBAR0 of the RCRB, for which there isn't a lot of description other than
> it being an address. It's referred to as a 64-bit BAR in places so you
> might be right - or it might be intended to be a bare address..
> 
> We might want a clarification on this...
> 
> Also it's a 64 bit address so we need to read it in one go. However it's
> referred to as a being a 64 bit address at 0x10 and 0x14 so who knows...

This is part of the pci base spec and clearly defined there. There are
also some similar implementation in the kernel already.

> 
> 
> > +	iounmap(addr);
> > +
> > +	/* sanity check */
> > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> > +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +		component_reg_phys |= ((u64)bar1) << 32;
> > +
> > +	if (!component_reg_phys)
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	/*
> > +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> > +	 * Upstream Port RCRBs).
> 
> The rcrb is 8k though I'm not immediately spotting an alignment requirement,
> but I'm not sure the component regs have any restrictions do... Add a reference perhaps?
> For non RCD devices there is a 64K alignment requirement, but I can't find
> anything for RCDs (might just be missing it).

This are the requirements of the pci base spec to membar ranges. The
range size is power of 2 and base must be aligned to its size.

> 
> > +	 */
> > +	if (component_reg_phys & (SZ_8K - 1))
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	return component_reg_phys;
> > +}
> > +
> > +static int cxl_setup_component_reg(struct device *parent,
> > +				   resource_size_t component_reg_phys)
> > +{
> > +	struct cxl_component_reg_map comp_map;
> > +	void __iomem *base;
> > +
> > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > +		return -EINVAL;
> > +
> > +	base = ioremap(component_reg_phys, SZ_64K);
> 
> Add a spec reference for the size. Table 8-21 perhaps?

Can add a comment here.

> 
> > +	if (!base) {
> > +		dev_err(parent, "failed to map registers\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cxl_probe_component_regs(parent, base, &comp_map);
> > +	iounmap(base);
> > +
> > +	if (!comp_map.hdm_decoder.valid) {
> > +		dev_err(parent, "HDM decoder registers not found\n");
> > +		return -ENXIO;
> 
> Hmm. HDM decoder capability is optional for RCDs - might be using the
> range registers.  Seems like we'd really want to handle that for
> RCDs.  Future work I guess.

I used the same message as for the non-RCD code path. HDM decoding is
just a subset of features handled with component regs. We need to
generalize the code for this in the future.

> 
> > +	}
> > +
> > +	dev_dbg(parent, "Set up component registers\n");
> > +
> > +	return 0;
> > +}
> > +
> >  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >  {
> >  	struct pci_host_bridge *host = NULL;
> >  	struct acpi_device *adev;
> >  	unsigned long long uid = ~0;
> >  	resource_size_t rcrb;
> > +	resource_size_t component_reg_phys;
> Trivial: As before, if we can reduce scope to inside the while loop, slightly cleaner
> and more local.
> > +	int rc;
> >  
> >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> >  		adev = ACPI_COMPANION(&host->dev);
> > @@ -425,10 +497,18 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> >  
> >  		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
> >  
> > +		component_reg_phys = cxl_get_component_reg_phys(rcrb);
> > +		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);
> 
> Perhaps rename to make it clear this is getting the DSP component registers.
> 
> Future work would be to add support for the CXL 3.0 feature that lets even an
> RCD just put some of these registers in a BAR as per CXL 2.0 devices.

Yes, this is left out atm.

> 
> > +		if (rc)
> > +			goto fail;
> 
> > +
> >  		dev_info(&host->dev, "host supports CXL\n");
> >  	}
> >  
> >  	return 0;
> > +fail:
> 
> Better to have a more specific error message and return directly above.
> Note that so far vast majority of CXL error messages are dev_dbg,
> so for consistency perhaps this should be as well.
> (I prefer dev_err() but not my subsystem ;)

There is more verbosity on the errors with dbg enabled. Note there are
only a few dev_info/dev_err messages to not polute the logs. dev_err()
is only used if something unexpected happens (e.g. the device exists
but component regs are broken).

> 
> > +	dev_err(&host->dev, "failed to initialize CXL host: %d\n", rc);
> dev_err_probe() is slightly nicer to use if things can only happen in
> probe() paths.

Will consider that.

-Robert

> 
> > +	return rc;
> >  }
> >  
> >  static struct lock_class_key cxl_root_key;
> 
