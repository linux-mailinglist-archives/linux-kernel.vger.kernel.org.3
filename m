Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D228D46F463
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhLIT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:58:33 -0500
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:8544
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhLIT6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:58:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm5MYQJHvLD9PerLCgjjOe5NdubXz2Gfi2b3k9lCaq5J7yoL6defbQ3A/ZxwV27bEQwJL7Stu/9nY1lrfl65dDnknHIpazPacTT8rtEPpAV4yD2V9ZRHontICbtq08VKHI+0LB0PdxvqxawTyhjBr4ktkCLwA2+P8C5LwIPAztFkg9MBAo9+0ExkgpB8jEIwvrZyvZR7o+h1OSniw3mNq+ctpuWtdrfPNCbSFK6Nt46GIP3v96i7yuuKEHYXeapl7Mw003QVlygztIa8bxGsiXSg4Bu+hlr/9jTZlfedm6dhSpEpXblhTybjjjOTz/GH95/k4HkT/HTWWe4gGZre0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YIOqasBugR+i8av/u8krFympiDbrIIl2J0yjSWq9OY=;
 b=SGj75yZm8uGCLYt+P4A7WEqO8Bhp7M8dve0WG6HQg9kk3xZ5P9gdeB/wHq1NKpCdDOba/wDSJ4NiuzkkIxKxIjOZARwMY0mGT0gUxjD25dCJFwXUXlHm/qdg6HZ2M9Lg131A+aE60PJ0tBPxufXkWe/QFo1dahb9aEs6+qyDLCiQYl1W0qK37e8ASZnv+L3jhKwkBitOMrLc5T0Dx6NhwWYvtkV+CytnTPV5uxBtWhcKY9S/FNtHcTOi0aP/1NccGEMYBCzNBrCYSg3o9xSE7Ur5Zu9tyzOJ5+UVKpB7lwGPVycPhEbh+qBVOc88Gxh3E+KTVyD6F7xJg022biat8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YIOqasBugR+i8av/u8krFympiDbrIIl2J0yjSWq9OY=;
 b=fGrsikf3VurbT2DRax/mcWMQ7i+FmfmJ9yEFOxZ+7BIe8Y3ZrOt6ORVhqtXLCMYPl9yuOcQBjHfZ4ELXir2cCr67KHHImA47cLGFvYUf2ySCdqxovLmpr5Z4xzBlcETmD1ftcU6dOtUtmH6/1JGdtF+TUfw4RLmdNTDTNCZBtFMj+6NVKLVs7dM3YJnXfjtbn4Nu3hO61TLsuU9wgiwQ7r2NaL5fVXVVCqQlp2HS7dFG0DIsXCbal6mbpfBW3vb97LxrhD7VgShf/c/f/Ox5dzzkVEbtPs0dcJQ6sbri67aL1XPkpzSUSExgEJlKNsxziycas5LVRiAXAiI2/hpAOg==
Received: from BN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:ee::9)
 by CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 9 Dec
 2021 19:54:57 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c8) by BN0PR04CA0004.outlook.office365.com
 (2603:10b6:408:ee::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 19:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:54:56 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:54:54 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:54:53 +0000
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 11:54:52 -0800
Date:   Thu, 9 Dec 2021 11:54:51 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
Message-ID: <20211209195450.GB35526@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afaffd34-37c9-441d-fcaf-08d9bb4dc69c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1157:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1157F3E5E492E57892EF2A61AB709@CY4PR12MB1157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooDdpkEDsWjRieLlFmAHRwpEB2Mbk6TFWAdiS1tqW6L3Pt/PyXUxemgvDSnL/4GOW+7pRqmzkf7v3IHRrLxEJQQi+3av+HS/KhYDV5bQK0TlPinK04JyOogicefe7odRpBNGdp0eNMA0qvMIKZ66zEOPKdLdWznkNZWr64nZb6iD8K8DzewTbUFinPOEz1U7EHgU9kUTVrfpS0bucVHL87npd40MXsYjrjbKzSrfULqrw8RAHErnL2fmUdAwWQFGODMUa0PH0t2Np43VS0siDHEddIU/BznwQduNbYss0Z14O14xcVXcd99srB+1jHl4UFUW8+zSnU5dhhezYtkw8leGOp99Ry6p50VGUOQHVGPCa1fx7pwDn+CnRQm2tOn9os9AOeew+EbZlysuuQ2qOjGIZcB1iMI60i9P0A7u6zJeG1Yc6uhxBDLysYdudngNugspeBVc+n9sOA3HmYpeugHUTE6EbMaAwZ7+TgRjf15q0lc7T6HfcnSYyBu6aGN0SCLgptB4VRboKK3y+W1cZrbE8I/wRbAOyWJRYapvaeoAyBDNDBA5qS4P6vnIfSZFKnt8gERoZknDc0dNAucus7fWSBk+RTEt0S+T4NTF+NrEGtMkXhxo5bzj+d3Pad6IW3swvbAtKDh3JafYAzkWu/quklnVRQHcIdNPN7okJ0LHZln4vRAMb5IkawO0BHWy3JMQJwbFjldUoX93aSQ0dv4N9W6h9yR6r5gkuZNP/AErVdm2TRcz6Ho61v8PSwIuFYSRcjmIoA5/+HYC5K7HwpoI6nsiW6Inmy+VLOSNBo8=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(34020700004)(70206006)(47076005)(9686003)(26005)(70586007)(5660300002)(33656002)(4326008)(86362001)(36860700001)(55016003)(186003)(336012)(33716001)(8936002)(426003)(1076003)(8676002)(7636003)(54906003)(40460700001)(2906002)(6916009)(356005)(82310400004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:54:56.3689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaffd34-37c9-441d-fcaf-08d9bb4dc69c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:44:25PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 09.12.2021 22:24, Nicolin Chen пишет:
> > On Thu, Dec 09, 2021 at 05:49:09PM +0300, Dmitry Osipenko wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> 09.12.2021 10:38, Nicolin Chen пишет:
> >>> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
> >>> +{
> >>> +     return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
> >>> +            (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
> >>> +}
> >>
> >> I'd change the return type to u32 here, for consistency.
> >
> > The whole file defines iova using "unsigned long", which I see
> > as the consistency... If we change it to u32, it'd be probably
> > necessary to change all iova types to u32 too... So I'd rather
> > keep it "unsigned long" here. If you see a big necessity to do
> > that, an additional patch would be nicer IMHO.
> >
> 
> In general IOVA is "unsigned long", of course. But in case of Tegra
> SMMU, we know that is always u32.
> 
> Alright, I see now that there are other places in the driver code that
> use "unsigned long", so need to change it in this patch.

I think we should do that in a separate patch that changes the iova
type in the entire tegra-smmu file. I can add one in this series, if
this makes you happy...
