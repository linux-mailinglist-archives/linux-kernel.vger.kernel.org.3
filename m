Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A305D5A8E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiIAGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiIAGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:39:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F380B276A;
        Wed, 31 Aug 2022 23:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlj0iddrcCBEXXCMcFQ95iZkudvwUG/pczqRlj7xLcb282et6IgvrCcbxldrkhx8Mr14PN7jLUtUM2iNE4YNE72wrGIUyDedMopFAjcW20HSKW1G2wFnAuzZGkUaHN31ACZkFza1IzgjAkbWw+xKtxkJLiDJqN7VFijRoghhlCTDBwhMVwL/dK4ARTKS/5t2RvRZthRG7axLWZuKIrZfypLEyz7uX2kT0Sx33V5NomHFzV20E+IJ+jLpSLmUdu91eyCEyeZ6u/oDdMKIdpwOdYAekdmKJZzVyAaKBQTH5wi/KPc+FWF+REbzGFMtlugGeGpdI25nCEUdJ8XVXYz4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBQJh9l7fv4LcBCmuT5obUkaAMFNrC1W1sHmLg60vsU=;
 b=S0I4QM01YGVAjkrgQCaLoZgEHCq9lkvXZipNOQcVVyCX37zz2rDJkgboHNl2zE9sSkeXsjgeAegxJnEnKULwhPAUGada0veZB0iJx7qqnxqlwWRYL8iSRTHG8bu2FR3wp28A/JirW9zLmhNxuU4nbcxySpy0/Avju/mbKCymChOGGN2G0x4rDKpLqzfSKAVtOP4Xh1NirFq+k5BUxUq+3z9jT+kj0Fs0lLQI0d81W9Lo8cVY9XxfMAhAbESh1wE7yS9FLGJjTpnmotJ2TEughKN8CB4sIMnvHL9tvDPBM9mgGGl5Xj8bdJW/eurKBeyQqOqdTJbAihc/FWXzCf/VgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBQJh9l7fv4LcBCmuT5obUkaAMFNrC1W1sHmLg60vsU=;
 b=tK9KumljwRG2SJqaKWvHwAJw0x6QLmh6QE/5Bd1rgThcJOtfABB1r9Lp7Sn/k3v5Yq0wghky0qexkFEVtDp/MkQ/3UAp148HSb7Gvj3r+X7OvCDvIcom97Wqn4EIubTUXcYByBPgM2Wc2GESZLfUvaMTna4weh7HqVH9e+M2VOg=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:38:58 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::32) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Thu, 1 Sep 2022 06:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:38:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:38:55 -0500
Date:   Thu, 1 Sep 2022 08:38:52 +0200
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
Message-ID: <YxBTfD+4hDgo6Sah@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-9-rrichter@amd.com>
 <20220831115224.00003afd@huawei.com>
 <20220831121222.00000977@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831121222.00000977@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465caa96-2625-4e07-2fe1-08da8be4a5d0
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyeT2h180eg0PW7dwIsuM+hsgashM8bQU6sdH6C+mWlVU5HpTmrfuXu+U/uNwyseHMocJLUy6V+AT9X50T74wsXpOCGz00VpvaYbxTyBbn72TeBSKeipd4/cx7qLGnAXvwATfczKIurToqndDLy8ghwlGzgkP0FCi6iOXC2E4AaGrZfPuTho314mq0zDNF0Bj03vSFemJFX+f3obHWaGd4Q9yzwSHeS08XsKTlKCiLGzQD++uYgGXoARP8MIDm6oCpe5TwnjEFDabSVKKcX9l6WjkWySSltkZCfAg4qFoBXyGDaXwo4UWW5rgQBlVSG9XRYKWJqJ+TfLwkSIy3l1HPMQpPYqw6pDddRVJCr+rkoe7y4Hxy0/GyrFhOP1k9+ZhJKgecvlIQwy8SN9kmXlnDxmp797dG7HzOyQrlFRQu42WCrX+t11YkpYadb+/gUysSfXLWyyVfViEP4IODKUSa78oVjtGhYMfpjSFPmAmlQrqbVaPzzlFbkbBNxXl6U+MRmwFbc37vmaTIPlNbYt3RMHzJUU7hGsOK2CjlPTpmtSo+4NrQZw/h3W/XavtmbQBkeRtLmg4FyJLcVk7pkNzliM2+42BJkrejAwZaz+idFDbtkbJXwyIoJ2IPaypp0sPBtsYwyegjOBMKzSgzMeuod9bUv9Lbk3BIkBRku3/Yhh6qptnQU5nIJ+sF7EJDkzxwZ9gCU/Je7aKjeqBNDOe+VtkTQ4cRK1oqJZcWBriI+d8503vJBELkMlvtdIhAhvQqu78lh7i69GjYm1vn2IdbZjLE6ktT7H0/pbTyANPySwOkt+SuCt1FqSuwUWFcc0x5VI0CYab2OH5JFfKHXoEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(81166007)(26005)(9686003)(36860700001)(356005)(7696005)(16526019)(426003)(41300700001)(336012)(47076005)(186003)(83380400001)(6666004)(53546011)(54906003)(40480700001)(55016003)(4326008)(82310400005)(316002)(8676002)(5660300002)(70586007)(478600001)(7416002)(40460700003)(82740400003)(6916009)(70206006)(8936002)(2906002)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:38:57.5941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465caa96-2625-4e07-2fe1-08da8be4a5d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 12:12:22, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:56 +0200
> > Robert Richter <rrichter@amd.com> wrote:

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
> > 
> > > +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> > > +		is_restricted_host = pdev
> > > +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > > +			&& pci_find_dvsec_capability(pdev,
> > > +						PCI_DVSEC_VENDOR_ID_CXL,
> > > +						CXL_DVSEC_PCIE_DEVICE);
> 
> Thinking a bit more on this.  I'm not sure this is sufficient.
> Nothing in CXL 2.0 or later prevents true RCiEP devices (there are a
> few references in CXL 3.0 e.g. 9.12.1 has RCDs or CXL RCiEPs - so just
> detecting that there is one on the host bridge might not be sufficient
> to distinguish this from a non RCH / RCB.

An RCD has its own host bridge created (software view, not the phys
topology). Host and device are paired in this case. Non-RCDs are
standard endpoints and not RCiEPs, they have their own host. There
cannot be both types connected to the same host.

Again, see figure 9-12 and 9-13.

-Robert

> 
> > > +		pci_dev_put(pdev);
> > > +
> > > +		if (!is_restricted_host)
> > > +			continue;
> > > +
> > > +		dev_dbg(&host->dev, "CXL restricted host found\n");
> > > +
> > >  		return host;
> > >  	}
> > >  
> > > @@ -354,6 +370,7 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> > >  	struct pci_host_bridge *host = NULL;
> > >  
> > >  	while ((host = cxl_find_next_rch(host)) != NULL) {
> > > +		dev_info(&host->dev, "host supports CXL\n");
> > >  	}
> > >  
> > >  	return 0;  
> > 
> 
