Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAD46F447
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhLITzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:55:23 -0500
Received: from mail-dm3nam07on2066.outbound.protection.outlook.com ([40.107.95.66]:14304
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhLITzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:55:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMNDyNCWf8wD9mappMD1wV1rhMSkafr2urQY91O7ghy3H3FdmTfEjRlPfSrUAzOGSO/xdfK1vn68DtMr+EH1L27lBJjMkT7KT/M6pwi2unPZHnFtnenb9IL8rV/ZQ3RADpX/jb00I8SQYzT5Yegp4Z+AvHwl3ANfg745ld4CcigticNoTyJc9EKYpVg1JTpJYg/grGd+e99pbgleOmz8LYegMXInXWaQqcoKeUFagUoz24RpPQsWuc1YDOhfIV6QDd4pWDtLNUbDjLmZLpvfbCrAVRecskrG3xwPD5jleQ6v/IEIkD6oeda3ZHKz4QdqJ9kO/TI/Sa/0JM+hIF/1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRReX6rrC4qe9FgkRERC6R62kVSq4YtfGMwN53WNlx0=;
 b=Tr5lZptIm3yeVinxtbiFLJcxdrBPJqWpwhEceSbeJ3hTx6G9RNQ7H25gLkD8FOV79+o2eZZfjnu2/ApXI4fuQ+3153yqNcp1ZgDtyxMOOgbP7CxG7TBjEZ+b9ECls+pxD+U4tKolLMmg7a/Y1HVqVmZsscxsfQe9Zm8o6OXAlKUkZEQGqp7WntpEEvb3wIsJjdMa4JZrGQP7v2uOMv1wRUJrZMMPgoRm8tCtWFrnBOE76N0PcNj18DDKhC7tAMHmTN8IRDB5vRNkR4i1FApc5ux0ooVV/xA7syR7Bp8YrGL1FYtNX4xQhfgJpT467yvQY0iFTiWLqWjQ6WfOX8J2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRReX6rrC4qe9FgkRERC6R62kVSq4YtfGMwN53WNlx0=;
 b=VxrKPg21ghBuhLEDXIfAxN3YnKVG54dDSRwlzc0GA1NA/B2ZalrhOrUhMV3AlG+3nSEAeTuhcgHcE8OuWBjPcDY7gIM8cpvR8qb+eSz67jTGRQiNCIm1F7+mpTA7gNb+gC66HZtiXOyngDzWR5qw8EQycL062ZjX0Av/Kp1BPwb/C91sx7Yl8LeLkXJkCRfpCma6+NzHwOYklFpPjfQ2EAe1Zy12lSPimF2aQmwxjEOQTn+tgBJ9jwbjp26DPOG7LSliGi7EPqImtiSqYyOWmqZ5tmVoHDFABNywyCh78Y+WxEBTC+973ssPnweP1YnNdOhIltxoEo69nxTmlQjg7Q==
Received: from BN1PR14CA0018.namprd14.prod.outlook.com (2603:10b6:408:e3::23)
 by CY4PR1201MB2551.namprd12.prod.outlook.com (2603:10b6:903:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 19:51:47 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::77) by BN1PR14CA0018.outlook.office365.com
 (2603:10b6:408:e3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Thu, 9 Dec 2021 19:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 19:51:46 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:51:33 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 19:51:31 +0000
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 11:51:30 -0800
Date:   Thu, 9 Dec 2021 11:51:29 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
Message-ID: <20211209195128.GA35526@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc928aa1-9a6c-4508-97fa-08d9bb4d554a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2551:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2551ED44302D81CC3088FD03AB709@CY4PR1201MB2551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chiRlmhCa9cTOjJ2vfxrMhvcYhulhZUCqA2HrwI09BLouzBnb1pdhFF/FrSdRv83u8phOZ0y7uUoAXTNkL0SuOaWqWZzEdt1d5T1JOQ5HPQFJ4dba3W/WvLdT7oYb0CEDWpfOSUOQ/sSkP8BbAEbuebVAQRYNsfH/3zhwcMfztAoDniz14UpfHlyRqephbVJkk/b5w4wFY6Vgj6eCJM+2ZKakHHACX0GIpTV5wpPHLoYxxkJRbNmh27NbkesRH5uT/NJ8JinjCIuNVsOqbN1b6WPhTt81X5/PfQ2DAoiB/UIfeJIZJBuJin80Z/y7eDkNaFHUaNPCgcu6wt6+XAaHg0W4EZzAqBZG9X4ek20MVbjh9ukBXzTuaWtqXZPN1jpidIvGDrfUNcPEvCNiCSculLsQKemaOC1f070jU6CCjHASfiUy9eMNe5cyDyU30SoMQvrXv4UI8+i796pkJY14W4/F1hYpiOeMTA9XQtBHaO1UNSDwSJgjbT8gbIZfh/C7SFjiK2nfwUNiwFeFb3A500xi5fJXkYnbESuRmyY+HyCfrLUbhQ4zUfTIxWs/DOsuU5anqkAXyBnbIVm0J1ZWUijq6B0vGSrN+EsZexGoXNuQgerx3W98HS3OT8haztvbfcebLk9UZqNLupGGYQYN/DSImC7g6JbMw9x1hugxLW/iG3ZsMoeDkm/vmIdiGxoBnV+H1tU2/JCzwhDOLiKfT7roGbtPJzCAcOlEA4/DGQgTF9+qp7vd468wGUV7reoDqves+JuYpusJpge5X5bJoHqZ8cH5i4K9sPvY66RRgw=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(1076003)(33716001)(9686003)(7636003)(356005)(316002)(5660300002)(33656002)(86362001)(8676002)(4326008)(8936002)(36860700001)(55016003)(70586007)(40460700001)(47076005)(82310400004)(2906002)(426003)(83380400001)(336012)(70206006)(6916009)(186003)(26005)(508600001)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:51:46.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc928aa1-9a6c-4508-97fa-08d9bb4d554a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:40:42PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 09.12.2021 22:32, Nicolin Chen пишет:
> > On Thu, Dec 09, 2021 at 05:47:18PM +0300, Dmitry Osipenko wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> 09.12.2021 10:38, Nicolin Chen пишет:
> >>> @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
> >>>               if (group->swgrp != swgrp)
> >>>                       continue;
> >>>               group->as = NULL;
> >>> +
> >>> +             if (smmu->debugfs_mappings) {
> >> Do we really need this check?
> >>
> >> Looks like all debugfs_create_dir() usages in this driver are incorrect,
> >> that function never returns NULL. Please fix this.
> > debugfs_create_dir returns ERR_PTR on failure. So here should be
> > to check !IS_ERR. Thanks for pointing it out!
> >
> 
> All debugfs functions handle IS_ERR(). GregKH removes all such checks
> all over the kernel. So the check shouldn't be needed at all, please
> remove it if it's unneeded or prove that it's needed.

debugfs_create_file can handle a NULL parent, but not ERR_PTR one,
and then it puts the new node under the root. So either passing an
ERR_PTR parent or creating orphan nodes here doesn't sound good...
