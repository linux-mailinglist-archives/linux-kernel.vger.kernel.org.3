Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433C75A8E45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiIAGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiIAGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:31:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB695ABD6F;
        Wed, 31 Aug 2022 23:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1hOQJI8oB44X2QQuMcGegD7HitMe5mjGw6s9a5szlk074HyxFSoKvQk/x6LOtrwuutYxpFda2UsH0boeeMOEIlpddFbi4rD2KCslMLeW4K7iZUViDVb9w+1Cz7lvv80VdOlVB/mCUqpm8xOPX08dabSBaNBWSnmwjrg2qRN/c32NBEw+CzHqo/HSKujzqPy4zfVNtMhK4a5EAE6pN02TNtVZNjTznCER6dA7NlC3yrSjSp5jFlAKYcyBtcBbFRyLCSkOEWm9j3uNN+cktokfMzlgc84JrvM6D7nyIBLmzv5rty08VlpYIg+ZnbXxxaxgrJOj/GDRf6H6q5XCu7B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWGw0qBjPvo6QmXc0Ia+lGjXfmvyFTFuAgVtwTE0C0o=;
 b=YCOxX1zo4FsBwk5kyyZ1L73i8Gi/vLtobtTQCP9kdn6/mEPFLlA3Sum8YZqHhw8llviY2sfQsezLpQnzsxhou5GfA9MRy0BnCXRseYDBB4LiR74wi5NCE8SbzOEzhjy3C+6oeu1aqRWAYvnLcNh/TtAQGy367isNCEmCA2GuiBI9FYFnbdl4TIRXnwth8wp1Sfu1rwGVbiONgGdpbgEgPZiDFeBj2EKug/uipSkWGgUE5zGeCtRAs5Gx1ADbMFrKLfPfYLTaKD4zDwLsrVIkqOwJIASSXuSu+eIySQ+DZ5GVkZ3ojwW+hz7DTGwd5RXeUDcqdfeX+AKq6uUhl7g1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWGw0qBjPvo6QmXc0Ia+lGjXfmvyFTFuAgVtwTE0C0o=;
 b=u8UpFkTfBVSeCVSDOflAq/vK41gwVxaP2fb+6U61LdNiQ/TmBJJX/qtV+ZGFWb4dX6vZr1SgGuNgmQVlbSMwF60F7HYGCZxnjGes0xKFcd1zYnsmEb/Zf6qQyGJ3SicFVhuTJ0kEL/2WT3VBb7id6XQAGV8RCgvDduYfiDfZJZs=
Received: from MN2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:208:a8::33)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 06:31:05 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::3f) by MN2PR12CA0020.outlook.office365.com
 (2603:10b6:208:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 06:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Thu, 1 Sep 2022 06:31:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 01:31:01 -0500
Date:   Thu, 1 Sep 2022 08:30:49 +0200
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
Message-ID: <YxBRmXOpc+ldConT@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-9-rrichter@amd.com>
 <20220831115224.00003afd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831115224.00003afd@huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c91b3e-dfea-49a9-28b6-08da8be38c31
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2qrV5E0xpDZ+GgjkdDnXUlgLKRy/CCbjiVRuG31Y1jf+FMlKvow6Wq+TSL61XFdzkC6UHxhGGyl+U47bQkSLlatytuISCbZ51o5YfcobKzdINyxqSDVuZKa9HxOoiPnEAQCsJfdoHU2SBc9wfuwc9wGLYAWfnTyPkoRNmT1KclT8YHhCAdJXdHZI9lWqWYnUV640WE0CGRXKNIhTEADKJFgZ6y1elgYTvqTZSeBbCUAWl9V3jEyy81UmPJORwt7mnvpwr0XFcGxbGlrBevMIb1ADfNFgUFeAjZQJ+a2W0lwguM7/NfC6XLXorR5gboMnx0jqIA9ZKV3wdjgeDA+djhRndQQhMk7doclhnBnCBs06ZZ4CM31qgEKBUhwTxA+nBwM0ImLy0qyJyJfedKigoHxPwvxSppEWNv/j94DPNpqAsZmF7KsVlxpdtYluajdNFmEiHejSb48CgF6N+ZT9++VzoRIiB3yqqkWXTS4odnyy1YfDgRo5rGAbjJ3Qgld1wwr7nbdMA7xnFed7M4Xi5XM+CL7L55SQDC0hYaBRJyROjizKvpW1GCjvDyCW7WP+jYewig9b7FaNBktJrv4DeMFmBIrMzhFgF0RlXaV1HEczoAC9LHCV+LL912imtJoM7P1qsxLOM8QKB2J3PuNyRre8Pv3ODMJq8Qc4y2SIZBy5DQTi+DyQgHJ+jopngboF08XQR6UbbK2FvwWY3H1tbbfx0PBUwKHA4ujO/71m4J8HTG9ILRRpRLsra8yWtGF/EPLxPj0VmCYn6WMgWK4e5rFrdXZ9eOZ3aZ1Cr8gW8ccRXFTE46DSXRxzEMsI7LAEvD8iEIQGqE0yYP+6eWezQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(40480700001)(81166007)(40460700003)(36860700001)(82740400003)(55016003)(356005)(5660300002)(41300700001)(82310400005)(54906003)(478600001)(316002)(70206006)(6916009)(7416002)(8936002)(70586007)(8676002)(4326008)(7696005)(53546011)(16526019)(47076005)(336012)(186003)(426003)(6666004)(2906002)(26005)(9686003)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:31:05.1433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c91b3e-dfea-49a9-28b6-08da8be38c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 11:52:24, Jonathan Cameron wrote:
> On Wed, 31 Aug 2022 10:15:56 +0200
> Robert Richter <rrichter@amd.com> wrote:

> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index ffdf439adb87..f9cdf23a91a8 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> >  {
> >  	struct pci_bus *bus = host ? host->bus : NULL;
> >  	struct acpi_device *adev;
> > +	struct pci_dev *pdev;
> > +	bool is_restricted_host;
> >  
> >  	while ((bus = pci_find_next_bus(bus)) != NULL) {
> >  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> > @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> >  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> >  			acpi_dev_name(adev));
> >  
> > +		/* Check CXL DVSEC of dev 0 func 0 */
> 
> So assumption here is that the hostbridge has a one or more RCiEPs.
> The spec (r3.0 9.11.4) allows for the EP to appear behind a root port
> - that case always felt odd to me, so I'm fine with not supporting it until
> we see a user.

The software view of an RCD is always the same, it shows up always as
an RCiEP. See figure 9-12 and 9-13 of the spec.

-Robert

> 
> > +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> > +		is_restricted_host = pdev
> > +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> > +			&& pci_find_dvsec_capability(pdev,
> > +						PCI_DVSEC_VENDOR_ID_CXL,
> > +						CXL_DVSEC_PCIE_DEVICE);
> > +		pci_dev_put(pdev);
> > +
> > +		if (!is_restricted_host)
> > +			continue;
> > +
> > +		dev_dbg(&host->dev, "CXL restricted host found\n");
> > +
> >  		return host;
> >  	}
