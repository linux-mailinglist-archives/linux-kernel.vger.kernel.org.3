Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95E46F3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhLITgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:36:43 -0500
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:22592
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229710AbhLITgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:36:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWQjJ90wcVSmj7FR9862E+Wazeuv+fFu7dwRV78VXGpXY5D3x/nLKU/5cFCRT1bi2+B+BAH+3+3G2uj0MDSPV9J81YgQyMhVmXQVlhQUwg3m8WYPr97KhHuqTZTZIfNIv5PRbwRV2Ai87pvXM+CpB80IsSqjipn224nzfn7iX+LzHGQfppVyr5HHfYyLm3ble3L1E2q+zjxlpWUKQKRpQ3QDFuCWB+YI+mAStVFro70yuFjuZr6aviItWtL7LR3eBs3y+6xOmm38JMJFBiPcZKN6Uev/tqTEQE17NiZpyP5hSsxb+Duqx+X84bTsVOPn5vDcETQssikz2tRfNV1fyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vC1oCsLsLFntE7Po+rLG7D6DxpSBMKUY1ECMyDmGcA=;
 b=YtW34fnFOmJFJ+3dsHKhIJl91jC4HnnzXJO2F/Ze3Dn9kASICYrGKHVhcNGDEuzQLh+pKjh0yAfUB6sFNVwJvsQC8/Yz7RaDBY36QFIuOLE3gORoKLGqKHHShSy2DrU1VVUPVT6AhLmoEs2+mRVrNEa7yvpHEi5WX06+c1vg5fZWCEmrB6rR1eLgvm+Y6qo16sUboh47VJLVySvQZwno0Du9F+NleN8MJwiVWTjkXd1dY40RrkuRuS/WCHjm+unVjuU/ynAXtS+LBXQcIDaQNZ9/OBCP2iAbkMrZmwD+t1KDpzCbKZJAWMNDhqhiO17KjSXcOJrOfYa2NMBKo+8hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vC1oCsLsLFntE7Po+rLG7D6DxpSBMKUY1ECMyDmGcA=;
 b=NpZJ4+rVSWNJqNsfugr8ZcLIA32faFA7vpE7d1EV+wHQXTKAnZ15Qm0e+TaLcgWzK4FdBOMsc/8u5ocGyNwa6cQ4p1Oi414wUbMe6BluXNCNRX8cpOnWSON1jaZOuEkGR24uvegJXPqp/89WJm98IHWJs2J60jSFLJLJMrNtf4LBd9rU7HtHbSYFasRA572Jkx/FPIkkBUoZaXnLerp11C4NyI3QKR48mncADmlcw1S3zxYaOiI1m4f7IquVO1282KceNAeSxEmSfD2XlOf9ZwLUkBOk8NGY6FZ5CRbIzcoxPR8SEBGqSsKJJWZlduqjKYUJ9ItmePpWI1YZhCFMxg==
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Thu, 9 Dec 2021 19:33:07 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d7) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 19:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:33:06 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:32:57 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:32:56 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 11:32:55 -0800
Date:   Thu, 9 Dec 2021 11:32:54 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
Message-ID: <20211209193253.GB34762@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702f4faa-c5d3-4edb-2079-08d9bb4aba09
X-MS-TrafficTypeDiagnostic: DM6PR12MB4514:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45145D4A8BC68C25ADB3E7FCAB709@DM6PR12MB4514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNrOAFfLiF2ONhnxWTj5q6truJwelpjgmcAm3x/tapGMegDmsllml41nn1aaAgrmSSse5fcwuxhaIQyNi3yU/sf1BI1HM/nF0E0i983F32Du4xqtiiY0okdTXRjlq1d3xQXpt7BJ3pMF8I9Yy/ylRNzrUu6T25UtN0FCI6BBrzr+rK3RLFSqfr/idsx6yvOAgUdGbbSpmPLUNDAXCspXsynptG4q0sYhy5AgkwInK9C3egJO+EE+KiidcfMBMSKVaIuS8mJ/SBO5lbc4mZQFsIfg+RGAh6e16hY5l9IGPhVU/xMGJsRe/EuxePsN66bGvvFVhWZmetKHzOJLxwCjt5GRXqFLwe0h2AiDClz1puVVpZh7n24RCWWF34r2BGPm6zXkXbtX0ulajIb9XNpiykOiBCiKHnkPEuN/u1ak7M7E1uRg1PfOvBR8rHndfoBbaddtjco8XaJ5QXlphxRSLRP+FfhTvs6GoaVF9yR9loRSOstCrCsH0krSzszI8bPKSK7nuoml33ATKF5AVD9jgQEHitOuQNd1L+nXI43VDDeRK+wwwGIkZH5hx7xbfTbMZO56SqTKU0SJOkD74Zm1KKuPUkr0hfLYubCvmv6l9F8hIwS46vy6+PvL7B7K3of3rSG57vwGf/wm/ZsSYERKXpeV2J+ZSYSao/keDYkZRNpfP27BKngZZINfbcifk70TZJc9M8z/Xk129YjT8vAZvnyBaT8+2LVzHVuTNjWuV1Dm2w5Fvi5v4/hRXWnA8aZZOl1jTiorn2lMw8S+6Rx8TTRsJsHRwu0L+0REz9ImQMA=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(34020700004)(9686003)(70206006)(54906003)(36860700001)(33716001)(2906002)(47076005)(4326008)(336012)(6916009)(426003)(86362001)(356005)(8936002)(7636003)(8676002)(5660300002)(55016003)(186003)(82310400004)(26005)(40460700001)(83380400001)(508600001)(70586007)(1076003)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:33:06.9489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702f4faa-c5d3-4edb-2079-08d9bb4aba09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 05:47:18PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 09.12.2021 10:38, Nicolin Chen пишет:
> > @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
> >               if (group->swgrp != swgrp)
> >                       continue;
> >               group->as = NULL;
> > +
> > +             if (smmu->debugfs_mappings) {
> 
> Do we really need this check?
> 
> Looks like all debugfs_create_dir() usages in this driver are incorrect,
> that function never returns NULL. Please fix this.

debugfs_create_dir returns ERR_PTR on failure. So here should be
to check !IS_ERR. Thanks for pointing it out!

> > +                     struct dentry *d;
> 
> The file name is wrong here.
> 
>                         if (group->soc)
>                                 name = group->soc->name;
>                         else
>                                 name = group->swgrp->name;

Yea, I'll add this.

> 
> > +                     d = debugfs_lookup(group->swgrp->name,
> > +                                        smmu->debugfs_mappings);
> > +                     debugfs_remove(d);
> > +             }
> 
> This now looks problematic to me. You created debugfs file when the
> first member of the shared group was attached to AS, now you remove this
> file when any device is detached. The shared debugfs file should be
> refcounted or something.a

Will see how to handle it.

Thanks
Nic
