Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8831A46F483
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhLIUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:05:25 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:7073
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231337AbhLIUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:05:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h285Yy5NEa4oAlxnTWGoLVahi/VtYuG5zirVyGqO4QeYKRfR4sTQ+vi+XVWpMFJJIV3Ax8AB44jH/cGX2sCq5W90Svw2TxSWmsbPnFeWiurj4OgjoDPJj8zb0cjs/pEIiQUxDLgwyvK9PBOFTWYu5kp6MwBmTPinAAFIp1ovEr+rx9GA0/iYKheEBrA6AlYeMaEPIw9Bi70r6DQq2JQefWsCbC1v6Fsf+bDIwyhspKQV1hsWzLAudDUySOMMHA6bDMG1EK2kPh4B7aSgeNb5yW9EOa/zertXqt7S5P7hlQXHw31pbPlmZW6FMtQv8eFq8Y/jhZvxyW5IwuFA8WjC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/sKYk0Sk9uGT5Vu3aWJ9CSXpXyin9UyGQTDj4gkVaE=;
 b=KBK+blXQ0aX89zB0989bmXSbJY97nDXQybg/LFo0FKsKAcuL+WuczPUVPJSLqS76fLLImrPovwmTaJXA03Oyy7G6ZQh2B47s8xVZRjm58AyO9xjJ1kHgkAzjdczIlOHMt2dauibTmOTisnFYz3853bb5Cahq0AkZNxYJfGusZXVYSUSMugpLSCpfIr1jJ6dOyNFSQHCgxkfXRRWJHDDGAemsyOvEMkNiuQlx/Ge/vGt6ltNnwbT+t6NlybcTQQ1hpF3O9mQB86kVGY2jgls0dohZOKQdH+D0Z71xlt0rJq/fq8buDP4Psceqmwgo5YbuoMKW22vkxLWxarCq+dRp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/sKYk0Sk9uGT5Vu3aWJ9CSXpXyin9UyGQTDj4gkVaE=;
 b=RKP+eKr/wWMXJUq0WVPkrgB6vv1IolDumyfGNLo9/JIhH7/Hwe6UUIcxQWCNc/5H7cXF31W4n7zdkRv+Rs6hG1n/ewXiumffz5VUGPdSJqmPofJJAz1GgoAgaRaHwKdqR7tDes3X5ifOnG7YgjWtAU8/cReYepCjqx0W856CIzENAsOaioatwKKZRi7ZG0pFRKkacYVS5Nq64xkANqh5EPnXuesmYaEt8PBZRYeqxU6kRGXPKlzlIRg7NvjW78yrzCxT+FzRDlY7Lr1QBH01yJvp5wzmXzEFUmTFyJ9G+rHyGs+pT5PRVU6PO5Wzxq2WkjtFzfQe2M8GQJjexp361w==
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:01:47 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::d4) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 20:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 20:01:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:01:45 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 20:01:43 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 20:01:43 +0000
Date:   Thu, 9 Dec 2021 12:01:41 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
Message-ID: <20211209200141.GA35858@Asurada-Nvidia>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
 <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539773a0-17ca-4d06-61d1-08d9bb4ebb95
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5258DD2710694843C1BA84E3AB709@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55u3wO0dJfXDmoz4Y5us58rEGiJF2kpkK6hIL2dAeTkNE4S8RDty3zC5mDatODNpI4EfN+8OOKVsVea5OTXnvP2Z/89uvN83Duv4xZuOXeWWhEID1+z0ouu9MwDA9LKW9YDbF1Z/PmWoCEa0lOvnv51rqi+NJtvRvchrtd7uldodAGYnUXaQ+0aNpZFddlW2CfN07pn7vUembNpcSyTJYbG3a5jIP0cMiFN8jZ17awEHaVUq+xyNHzvFzwKT6lLtcQqzmpVgKCzwMTn/c1zjrkpY48AgfJywPSWbjJfTImuI8MIfy/dh0l5J3IdkT7ZW0sowj15vbQaDEz6S0SeLhCRcFkOknXA5suzU7DwAxjPM+4uAf0ZRQ4tpBa/xmV7lQGGhWKrYsB3OhdhKnSQP3Sh33tVYexijE+8o0tKwRmNh/tb3DKU+LXFxbiJawxoK0XP4YIeDHWl5rbY/Qie+xeQ9kQm7BeT4SUbZ2cQetV3bGrLAKF7IEE2mjKZPfsTZ+CFgW++4HiLs/xIP9iaGsZ8r25xSEIc0R+QfEs+sm0yWx1+itszWX0iEZsoYAAuYwyLyHzB6MBLX88sRg+giPlWORisWGIAuKRXxULyi0NXMr9UIeUY1VvGHaAJ1Syj9vN9o+Sayo6+J0QLhk4sIDN3m+AaQqWc8pvon5fRXxjFiPbKoElvVQC8F0Q+EuUHmNnOE2Y/G5AZe4zwoGZO/b9PayUK/2TIdDWCo8IJk0mae+8EX9QM2xiFJiP8hW7pDMDoyhV4MDaMVUQKCYvuvBoeVVNp1TL5mZQhW30osn2o=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(186003)(40460700001)(55016003)(8676002)(47076005)(34020700004)(8936002)(6916009)(426003)(26005)(356005)(508600001)(7636003)(336012)(33656002)(9686003)(4326008)(70586007)(1076003)(33716001)(70206006)(2906002)(316002)(54906003)(36860700001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:01:47.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539773a0-17ca-4d06-61d1-08d9bb4ebb95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:58:32PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 09.12.2021 22:54, Nicolin Chen пишет:
> > On Thu, Dec 09, 2021 at 10:44:25PM +0300, Dmitry Osipenko wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> 09.12.2021 22:24, Nicolin Chen пишет:
> >>> On Thu, Dec 09, 2021 at 05:49:09PM +0300, Dmitry Osipenko wrote:
> >>>> External email: Use caution opening links or attachments
> >>>>
> >>>>
> >>>> 09.12.2021 10:38, Nicolin Chen пишет:
> >>>>> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
> >>>>> +{
> >>>>> +     return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
> >>>>> +            (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
> >>>>> +}
> >>>>
> >>>> I'd change the return type to u32 here, for consistency.
> >>>
> >>> The whole file defines iova using "unsigned long", which I see
> >>> as the consistency... If we change it to u32, it'd be probably
> >>> necessary to change all iova types to u32 too... So I'd rather
> >>> keep it "unsigned long" here. If you see a big necessity to do
> >>> that, an additional patch would be nicer IMHO.
> >>>
> >>
> >> In general IOVA is "unsigned long", of course. But in case of Tegra
> >> SMMU, we know that is always u32.
> >>
> >> Alright, I see now that there are other places in the driver code that
> >> use "unsigned long", so need to change it in this patch.
> >
> > I think we should do that in a separate patch that changes the iova
> > type in the entire tegra-smmu file. I can add one in this series, if
> > this makes you happy...
> >
> 
> Please keep it "unsigned long", no need for extra patches.

Oh, I guess that "so need to change it in this patch" should be
"so (no) need to change it in this patch" then?
