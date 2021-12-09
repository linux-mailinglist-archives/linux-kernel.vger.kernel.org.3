Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D646F4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhLIULE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:11:04 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:1632
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231608AbhLIULC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6Tpom3yRKvI21MTXOnKwACZKiz97mTwGVrHoNc6LMi504yoPtGraxrTpddw13H56z+0mDW7TBVTCO4lK8HnJqACweTXPizp+FwIM61opi7gbtXaUdPDjxC4E6KHG1YEuwXmtkt6UkT0s7LBXw8n3DLkvwqoMeZOTU8A9InpW1lpQyfyIjDmGBlYQc5C7X1Vjuxy4ksLAv3J5czCRZB1H18dNox4XCKqALqba2dy39Thk162TCKLRBI7YrbdkSvqT3BKUBteBVMBGFQmGXTCY2SaS/h49YB3gH/3oLpXKOrF2b7HcOAVcVWnnLBENPopPDulDCKtWc3UQ1W8h+3iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qBDv9Qs1rohVW3WLB4vHrUfp/BI8Q15uIADSfnwuRM=;
 b=Wd6s4TdnriyLeY3iDBvhaFepcPZUbQr/37CijVlvplAV7YKug0b4OaEmTpE20H1AMHCCQbNOwZGmhKEVuS2dQG7D+x0aXLXbDDT7MmFec1SIJpQqFQyfOxGe0xAqa+wW826HbXftx3WsGLLGxNnmjtoCblZZzU6TflowKXSbQ4fkS0nVjS2FqYU8mZ0YGTniHbl5EKHy+z9UIhKYZEuRr3ZnZ6NcqF4rECpb3qHoFUVW7hFrOHKim4Uxk+tbyyaUmEh8I8Zgtfm49wSN2xwZvegHO7uBqOtEszqdDha6Wnk+PXWVJEs0RhUWiu25OLWRZhj3yNeAvzcJkkrVKUwC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qBDv9Qs1rohVW3WLB4vHrUfp/BI8Q15uIADSfnwuRM=;
 b=JqYflR5joUFCPH/5qHd/53/5yTRAMTGXCbsADiDlrHsOIRbr5niZy2PbTjRm7nqlO0rtDcCyqffYuAnYgoG4LwotnXucP7QBxr6kHj51ejD/5Lcb0ERL6Hz2lWqF79Jmdsses7DqpGpMk0RqVPJ0GsGaydqVuApTzuT9ebeetktoKJzPqxcC7krb+A8KDIfrmWSU0VpEQ/dem1LKYsiaiOJEWCCBl+83bT/6rVr56QoZiXRDvMhrbOcyvXip4gMTHaujhouGj9W5gFjO8N/DEwiZs32hswtO+3ajGisP34MhobEhnNjOKbnuwo2S85Ncrh7a8RVvwdgvsXSOfLoWDA==
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 BN8PR12MB3009.namprd12.prod.outlook.com (2603:10b6:408:42::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 20:07:27 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::b0) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 20:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 20:07:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:07:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:06:59 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 20:06:59 +0000
Date:   Thu, 9 Dec 2021 12:06:57 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
Message-ID: <20211209200657.GB35858@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
 <20211209195128.GA35526@Asurada-Nvidia>
 <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726f8ad7-3b3b-4128-0f3e-08d9bb4f85fc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3009:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB300991BF84BAF35DA295D2AAAB709@BN8PR12MB3009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxaG7VQ7Kd5QIE2PWP8wVBh/qO2kcVhFUOApr4a+3o7QFGfe+c4u0miI+kO23OkO7HSu6iFN/9my3qUUG6qzmvj7R6oabHjVt2+ZOcU8aLT7DztFHmYlqDZ4/eWX5Lti9+2vk7IVQkHXUcuaP3HqYhesST7wAOQWghCSgy6MGrhKeLKwK9p/rdVd+nb3K76NXQ/+WwpAJ3bS8Hf/RIy7xXw4QaQRzToJRRYe8xiNsNjmaxTD2trK/qULJgIuQTnuABzgVdzeXP8zV+aHwpDZQ78Z5YiDFPTDwuyQjokmOgzd4SCzGIG5TVQCtIjaP4NlD2wRoUvaf1EDnskE0ed83ajGrDx9YNJNO18yx1XPBjfCcmdgXN85KiVTmv8W3I7I6UH09i94iErlCLHTqnKvf4Ugl5wa8fYtejB1tbQCk9CNQqdj6iww45iF+HnSs0r8yQMxgIQPz5dOVR6nQ8QdqUaN9VKh9Ifx8TjZLFAIlWwO/FoQV1X4YgUdMA0rVjwgV4D2gAe94MDKIjIAphX6uyA24sdxfNsIPWMAf0frwisoO9CJ5wdMEPnsF+QPEx/y+tA+F3ScYqjw1db8ZhD8KBuEC2YXUm5m0+/q72LgzA0dWKdsIsGJxRsWr0ctVsv5XDj6F4AjQ+J7yownjYToCKE3X3V94Wqce4XT8idHrDgvImW4UvaKbRbkOYX0DP7YcVyP9JVfZODsQsDbXZfT9Gz0QTLL2v83s+r/yJ+WoLP54jf2ilKsiB89esJoKBotW4GL5oK/Q7Ncx+bwyQil4q6StIwxBKLMKeUQ8NqEFsg=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(55016003)(40460700001)(82310400004)(33716001)(8936002)(8676002)(33656002)(316002)(6916009)(54906003)(7636003)(508600001)(26005)(9686003)(70206006)(186003)(70586007)(34020700004)(336012)(426003)(4326008)(356005)(2906002)(1076003)(36860700001)(83380400001)(5660300002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:07:26.9803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f8ad7-3b3b-4128-0f3e-08d9bb4f85fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:58:15PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 09.12.2021 22:51, Nicolin Chen пишет:
> > On Thu, Dec 09, 2021 at 10:40:42PM +0300, Dmitry Osipenko wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> 09.12.2021 22:32, Nicolin Chen пишет:
> >>> On Thu, Dec 09, 2021 at 05:47:18PM +0300, Dmitry Osipenko wrote:
> >>>> External email: Use caution opening links or attachments
> >>>>
> >>>>
> >>>> 09.12.2021 10:38, Nicolin Chen пишет:
> >>>>> @@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
> >>>>>               if (group->swgrp != swgrp)
> >>>>>                       continue;
> >>>>>               group->as = NULL;
> >>>>> +
> >>>>> +             if (smmu->debugfs_mappings) {
> >>>> Do we really need this check?
> >>>>
> >>>> Looks like all debugfs_create_dir() usages in this driver are incorrect,
> >>>> that function never returns NULL. Please fix this.
> >>> debugfs_create_dir returns ERR_PTR on failure. So here should be
> >>> to check !IS_ERR. Thanks for pointing it out!
> >>>
> >>
> >> All debugfs functions handle IS_ERR(). GregKH removes all such checks
> >> all over the kernel. So the check shouldn't be needed at all, please
> >> remove it if it's unneeded or prove that it's needed.
> >
> > debugfs_create_file can handle a NULL parent, but not ERR_PTR one,
> > and then it puts the new node under the root. So either passing an
> > ERR_PTR parent or creating orphan nodes here doesn't sound good...
> >
> 
> What makes you say so? Please show the exact source code that will cause
> the problem.
> 
> The smmu->debugfs_mappings can't ever be NULL and debugfs_create_file
> handles the ERR_PTR [1][2].

Ah...my tool jumps to start_creating in fs/tracefs/inode.c instead.

Thanks for the reply. I will remove the if line then.
