Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0D47B3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhLTT1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:27:23 -0500
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:8797
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240606AbhLTT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:27:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lATzTkFWXTSmUI33LjclOfMk+2rldCxYhyX6UBMZkVoPCAmg6VdXlxwlcL5fGS09Y357pEkYkcs3rhfAc3orIEd6oKP1UDOE7/KK1/MNi9NZ2U0wUy88tpqLE8VUPAQMSjz6k2Eyz2aUgYBePZg/sbL3Kg/+prtEu4WpvasWEkUbsL8LqS8ljAjX2rowTFLS83sRUQ0OUkBpbAh0KJNMwdmlzfz4NZGw6JqobMLPfUUeroj/jpoOoPVs3nIdC0w4eJz1lKJ+1YMkH38RCjISm1xDE/9Ff0FnQ0LrEdPpRV2GBvc/Mi2lMkyLk1HcHaZben3ZcMV7ngqL9qtNl3MfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+JtwPxwTGnQMdU5kTIA11MBT/VDwZTaVXHKbyaREJ4=;
 b=hW6C1hoc/EbbA6fSdMGJPgB95YAZJu6OtlTajy5ghgUcYMt+C9rxpSeKmtHPNfw+Jtbxor/mnMFEr/XFaWR5hgUbhE66F/PtSapfWeokYuBiS8Ag8z7J7+vY8Y0UiAYJtZwQOslDOXUFaxscmTIPI5GWeAz1JkX4rYMf/GKNBxVjABcrpLw6M9RwD0tpQTltoFs0k+MhEfaXL6iAEh0HCb8nPZyCPQosyllfvUh/aOduRPqpFkQ5qIvq6j6UiPXGr6NbpENLqw1VqN8qB4+ZHE0/N0bR9Z7trTkii8SioeuGHtlSw/t9Kqr3RxEsCdPFXhLKRR8fmeXiJZkDbujluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+JtwPxwTGnQMdU5kTIA11MBT/VDwZTaVXHKbyaREJ4=;
 b=ChzKepYI/BtFncu/56U0g6F6YRpiiN+t5sKSHjMwdYVl7TZ0H2XeLy/bmNM79klWWUQ8gwQ3mtP3lxTH4LUUBZgkUXAN+h0LjTeZ7GQqlhpqUK/4c253XQAe21jopUPnLZdYXyrt8n/vdne2bjKVQHHsRCqNxcAqk/18UCF/tQe3ThzpFPW0KmwhEduuYLzOhFFjDzK1gK2HRKTwR9lvPYGXexgYofI1ICLwmFa+2newRYRzgKMRT6f3Q4DlaSrYxzppHERxXXihGPkkFuzxAqXwBviT5cw/2REzdGshCSg4A2LP2ofgFKksdsMuin2yfsaf6B7/yPtM2MLezO7O9A==
Received: from BN6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:404:f7::20)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 19:27:18 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::20) by BN6PR11CA0058.outlook.office365.com
 (2603:10b6:404:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Mon, 20 Dec 2021 19:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 19:27:18 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Dec
 2021 19:27:17 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Dec
 2021 19:27:17 +0000
Received: from Asurada-Nvidia (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Mon, 20 Dec 2021 19:27:16 +0000
Date:   Mon, 20 Dec 2021 11:27:14 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <nicoleotsuka@gmail.com>,
        <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
        <nwatterson@nvidia.com>, <jean-philippe@linaro.org>,
        <thunder.leizhen@huawei.com>, <chenxiang66@hisilicon.com>,
        <Jonathan.Cameron@huawei.com>, <yuzenghui@huawei.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Message-ID: <20211220192714.GA27303@Asurada-Nvidia>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
 <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff955cb-ad81-4345-8782-08d9c3eebcc9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3790:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3790567A7F20BA5584539669AB7B9@MN2PR12MB3790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFFxfjAeVe0727jvIcJS7FKCsfcRVmx1MNtorprOKhk2ld6USrR9t7UxR8kiw5KHw5iJTOJ6HioVL0rPDzGD+ppON1W6lEtJvRqsaJiZckvKbUNUQw8UHxqSFpiBZFOXQMkGJ0kZGDOOwalRKqq+9EHrXZCCoMOOypW6LP22DBYOqeUBx1zTAsZnx7HwqTtVB2thbwjYMBDDmkCqgWwnI7e15jb9eRhx3ce/I8Rvvx4abgr7WrflWJsPkCpnZt6YSXHS8RzyRZP6XSmgcVJKeumGu5RvscdyRHQzejp2ZzaKmanbEVVlGHs8wWeVPtzP8mpec1Y9igTrfmWbH4GkXiIlddRGtzmFcGOQIK35X1YnxsoQwLAqhmOlwc6eaw9E4vU4eonDuuHs0VML2ysao85Fjp7a0VSBrlkRsW9pdvrRabN/mloH/fYWEAM5ep7OVd14Wq2HOeCOuLd1aVQvPecp9cIxQRndp5awlpnm5XXolPlOcoqgA4t9NGSt0n1juiz3AiN3a2PABM5surRvm59KRHXpJU2+itKnsarA6IZC9NQTBeL59gz54XroFnndS8q9B/LuKFfK6HdXzASag7bcC2jXmYlcCFq3jymqOFsMzvFPF1uo6zyZJ8skJ/piydVoGqWA+uyfCaDhjwl7DYDneb1CRcWn4t5M2ggh2ZOWOYVRgt6GHztFPJxXlsGQGK6xyWmwzMla0WO3GVNwN4uZkNZ6SVq5NCcIFQ4yXEZscO93HQcOf2QXwHhlz5fZXs0i1lDnN4UROz+2gyk3+jU4o/CwYCB8TDxMjSRGvr/i43KReXhr31FB6nhCtvwtfM8x8t7C4r02tEPNxeJ2Kg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(4001150100001)(33656002)(36860700001)(336012)(70206006)(107886003)(26005)(5660300002)(426003)(4326008)(70586007)(8936002)(33716001)(53546011)(508600001)(6916009)(8676002)(54906003)(9686003)(7416002)(316002)(1076003)(86362001)(34020700004)(47076005)(83380400001)(356005)(81166007)(55016003)(40460700001)(186003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 19:27:18.4820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff955cb-ad81-4345-8782-08d9c3eebcc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for the reply!

On Mon, Dec 20, 2021 at 06:42:26PM +0000, Robin Murphy wrote:
> On 2021-11-19 07:19, Nicolin Chen wrote:
> > From: Nate Watterson <nwatterson@nvidia.com>
> > 
> > NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
> > which extends the standard ARM SMMU v3 IP to support multiple
> > VCMDQs with virtualization capabilities. In-kernel of host OS,
> > they're used to reduce contention on a single queue. In terms
> > of command queue, they are very like the standard CMDQ/ECMDQs,
> > but only support CS_NONE in the CS field of CMD_SYNC command.
> > 
> > This patch adds a new nvidia-grace-cmdqv file and inserts its
> > structure pointer into the existing arm_smmu_device, and then
> > adds related function calls in the arm-smmu-v3 driver.
> > 
> > In the CMDQV driver itself, this patch only adds minimal part
> > for host kernel support. Upon probe(), VINTF0 is reserved for
> > in-kernel use. And some of the VCMDQs are assigned to VINTF0.
> > Then the driver will select one of VCMDQs in the VINTF0 based
> > on the CPU currently executing, to issue commands.
> 
> Is there a tangible difference to DMA API or VFIO performance?

Our testing environment is currently running on a single-core
CPU, so unfortunately we don't have a perf data at this point.

> [...]
> > +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +{
> > +     struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> > +     struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> > +     u16 qidx;
> > +
> > +     /* Check error status of vintf0 */
> > +     if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> > +             return &smmu->cmdq;
> > +
> > +     /*
> > +      * Select a vcmdq to use. Here we use a temporal solution to
> > +      * balance out traffic on cmdq issuing: each cmdq has its own
> > +      * lock, if all cpus issue cmdlist using the same cmdq, only
> > +      * one CPU at a time can enter the process, while the others
> > +      * will be spinning at the same lock.
> > +      */
> > +     qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
> 
> How does ordering work between queues? Do they follow a global order
> such that a sync on any queue is guaranteed to complete all prior
> commands on all queues?

CMDQV internal scheduler would insert a SYNC when (for example)
switching from VCMDQ0 to VCMDQ1 while last command in VCMDQ0 is
not SYNC. HW has a configuration bit in the register to disable
this feature, which is by default enabled.

> The challenge to make ECMDQ useful to Linux is how to make sure that all
> the commands expected to be within scope of a future CMND_SYNC plus that
> sync itself all get issued on the same queue, so I'd be mildly surprised
> if you didn't have the same problem.

PATCH-3 in this series actually helps align the command queues,
between issued commands and SYNC, if bool sync == true. Yet, if
doing something like issue->issue->issue_with_sync, it could be
tricker.

Thanks
Nic
