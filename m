Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B176E47D96B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhLVWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 17:52:47 -0500
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:36640
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhLVWwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 17:52:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maf/41XZTyPkrp+puK2fcnc5R+GiEDYbXxoxDjLfT/OO9k7M5V6qIdWgPhGR6Why6SSGwJdERc9y5eVAgz8f5eVC/GiVGoZjNXA0ghwx5PSXAN6kDb92QudvaaOoPMbR1/XqRWOpEb8Zd8N/Z11zBa4+xkBttFS7/dGXUXSVvdktVpM+YbvRc/O1C6Ij2Hgl3MbqR4TlYkagQ5XOGNXZv65N6CYCiwTNiQyqif0km+tvRuVgc/EqEmgXWeOKL/XtvvK/hROPNr4YQZ32tsX7uejr9IUNqtu4+xONVUJOe64SL/Pch4KD91h0+ZTQnqODA6FTJIvMx1l+Yc0H+ZNKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhRifqNjKh97D4zNpyN7zrEHJYexMckcYmOAa4FkE9s=;
 b=DM8G9dMq6tQMk20BnVR6xfHOHMFIpSxLqUNlS3BbSbWMhDvRr75oXg6wsBfzzNxDqX/+8xVlVuGdRTOjrTeyPthLHw0BHyfdQSQHw/jZ+REtL7i1QbF+2t+b7HuQaUZi0LctZhV9ACsfGX9/bj6UcNIW5+k9xkJgbKvkXOmIpOXBb4j/4K2W0/zxR3zXsf8qg5JdqxXesmusbcKmb5ZyAeM2h/QhdHxky8XElBPrt1rojkIIe7XLzlEw0TYqn+nZoepCTji+nTGu2TWExbJEzUp0lsrV6i0IK2twwk1DYxXxvg/IvEAGmKlHOUjGEQmWrrpH41GS2jG4s/v7TWezDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhRifqNjKh97D4zNpyN7zrEHJYexMckcYmOAa4FkE9s=;
 b=lGn5MMi24LP3FQms19rJ0SFg1+7rF7pL/GAxeFAc2cIrsgNDrG6vFcrZtn0pVG9mrpN40P7o1eq3ymrAgSdddrW7DRL/79uhp0i8BtD7sB2PPkzaqOwOnoQUv42S828JMScwOWkCOR5VzDU6pnjS09A4iq4+oaUNfIottS4NLCFfBZsNDB+kzKKDygklXi+lgXRMeP1pDLiLbBVaawuza02RvKu8ddYopH3IcTckAwPfuusgtSNUjUFc/glkazEH5ATCZ+rB/2vOv1kyWj4M13NW2ZkgyMZuzDGnbOkVtg1rcsZTvu+1mMfgKR/2R2H1yyDubPJwmp9cGc1rx8rvqA==
Received: from BN1PR14CA0008.namprd14.prod.outlook.com (2603:10b6:408:e3::13)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 22:52:44 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::ba) by BN1PR14CA0008.outlook.office365.com
 (2603:10b6:408:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Wed, 22 Dec 2021 22:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:52:43 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 22:52:43 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Dec
 2021 22:52:43 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Wed, 22 Dec 2021 22:52:42 +0000
Date:   Wed, 22 Dec 2021 14:52:40 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jean-philippe@linaro.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-tegra@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jgg@nvidia.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Message-ID: <20211222225134.GB5698@Asurada-Nvidia>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
 <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6259e1db-12be-41ac-dd08-08d9c59dc3f4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5218F8A9458432DF88E735AAAB7D9@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gneU9TTugnzxi4tu+VWIMZEGnqSExhZArEvCsgeQca6Z9+sdnfBH8TrU7Fh1rk3tADzh5vqkzTa7R1w5dV0nKYRFrCjdjvvRK5Kgd+aarBwCwmOv6xLjNZ5g+AWtW7lx/m6z+v0nGVcSEwUHjI7kaPeGf8gT9n+bL275V5zZ7rQwM8gA6svxpZPz5iKpXS0w/AIe6DSUuRmk3oSyiz+v+L0Nm87QuxwuCEFWHLNDQED5tt1AosE1jFKbdEajExVd5R5Xy4+B/V4wkctv/9Yw27bh7N5yQPkl8QgsxOUl0XaB+nol4f5gY8bjQrmDCM273cGNCKdAEgN7XtxfSIuiLi+j723u/d8wiK3JEUqPmI954Y9IxYb2+Hc39eJd4p9u2wkXhz+z+zqMKc5fX6vNSQEy7cJ2YCGC7qGbyNGqxADEP7ZhzbcEzU/US5gtm6vao5CtFcPDtzjhV3RTdP1RIPMSgGbRiVG7skV0UrJMBgpnQ1G2t0i06ZwNSmQ0YzPyqlIZYBw3cuPOhjkOrkQ+7zEvwRr/2mtv2k9qpCDrT41vauExZQnoIqvyXdHCRHOPYDa0AZWH3wkQRzT5ngN4NiK85WRbAvDDRC0uGw01KEoNq6im451WSNpbphc++6OE9sTEtW0sWxP4uFaFvIsjcC0pgFIL+7tBE16R6DTjGgjqdE+Kl6um2NiXEDE7xuTCrYgzHuijfHny7x++DmMWWPUkuFSCUuYCOA60pTUkrt4YgKKJqTLBiGoxEZ+xmHo4sHg3wfJIYQI3mRZK1o0bsbbWSUzb9ulTWRhXPn9m75sTLSxwA/GluQrYddL+wVmGYZkkyjUfCa92gd+e9FL0Ndz15+IfNTIGoCf96Phfj7H0ajeZZ4QN1o7swJZSh9WrDkwN8oy4A4UKJWbFfOS52xEt7NZ7wIxF2d7FA4wDDH8=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(8936002)(53546011)(70206006)(70586007)(9686003)(83380400001)(4001150100001)(316002)(6916009)(33656002)(2906002)(966005)(186003)(8676002)(26005)(5660300002)(47076005)(356005)(86362001)(54906003)(1076003)(426003)(40460700001)(36860700001)(82310400004)(55016003)(81166007)(336012)(4326008)(34020700004)(33716001)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:52:43.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6259e1db-12be-41ac-dd08-08d9c59dc3f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:32:29PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2021-11-19 07:19, Nicolin Chen via iommu wrote:
> > When VCMDQs are assigned to a VINTF that is owned by a guest, not
> > hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
> > are supported. This requires get_cmd() function to scan the input
> > cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
> > unsupported commands can still go through emulated smmu->cmdq.
> > 
> > Also the guest shouldn't have HYP_OWN bit being set regardless of
> > guest kernel driver writing it or not, i.e. the user space driver
> > running in the host OS should wire this bit to zero when trapping
> > a write access to this VINTF_CONFIG register from a guest kernel.
> > So instead of using the existing regval, this patch reads out the
> > register value explicitly to cache in vintf->cfg.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
> >   .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
> >   3 files changed, 36 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index b1182dd825fd..73941ccc1a3e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >       return 0;
> >   }
> > 
> > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> > +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> >   {
> >       if (smmu->nvidia_grace_cmdqv)
> > -             return nvidia_grace_cmdqv_get_cmdq(smmu);
> > +             return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
> > 
> >       return &smmu->cmdq;
> >   }
> > @@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >       u32 prod;
> >       unsigned long flags;
> >       bool owner;
> > -     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
> > +     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
> >       struct arm_smmu_ll_queue llq, head;
> >       int ret = 0;
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 24f93444aeeb..085c775c2eea 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
> >   nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
> >                             struct acpi_iort_node *node);
> >   int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
> > -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
> > +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
> > +                                               u64 *cmds, int n);
> >   #else /* CONFIG_NVIDIA_GRACE_CMDQV */
> >   static inline struct nvidia_grace_cmdqv *
> >   nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
> > @@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
> >   }
> > 
> >   static inline struct arm_smmu_cmdq *
> > -nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> >   {
> >       return NULL;
> >   }
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > index c0d7351f13e2..71f6bc684e64 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > @@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
> >       return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
> >   }
> > 
> > -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +struct arm_smmu_cmdq *
> > +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> >   {
> >       struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> >       struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> > @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> >       if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> >               return &smmu->cmdq;
> > 
> > +     /* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
> > +     if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
> > +             u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
> 
> I'm not sure there was ever a conscious design decision that batches
> only ever contain one type of command - if something needs to start

Hmm, I think that's a good catch -- as it could be a potential
bug here. Though the SMMUv3 driver currently seems to use loop
by adding one type of cmds to any batch and submitting it right
away so checking opcode of cmds[0] alone seems to be sufficient
at this moment, yet it might not be so in the future. We'd need
to apply certain constrains on the type of cmds in the batch in
SMMUv3 driver upon smmu->nvidia_grace_cmdqv, or fallback to the
SMMUv3's CMDQ pathway here if one of cmds is not supported.

> depending on that behaviour then that dependency probably wants to be
> clearly documented. Also, a sync on its own gets trapped to the main
> cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the
> VCMDQ, huh?

Yea...looks like an implication again where cmds must have SYNC
at the end of the batch. I will see if any simple change can be
done to fix these two. If you have suggestions for them, I would
love to hear too.

> > +
> > +             /* List all supported CMDs for vintf->cmdq pathway */
> > +             switch (opcode) {
> > +             case CMDQ_OP_TLBI_NH_ASID:
> > +             case CMDQ_OP_TLBI_NH_VA:
> > +             case CMDQ_OP_TLBI_S12_VMALL:
> > +             case CMDQ_OP_TLBI_S2_IPA:
> 
> Fun! Can the guest invalidate any VMID it feels like, or is there some
> additional magic on the host side that we're missing here?

Yes. VINTF has a register for SW to program VMID so that the HW
can replace VMIDs in the cmds in the VCMDQs of that VINTF with
the programmed VMID. That was the reason why we had numbers of
patches in v2 to route the VMID between guest and host.

> > +             case CMDQ_OP_ATC_INV:
> > +                     break;
> Ditto for StreamID here.

Yes. StreamID works similarly by the HW: each VINTF provides us
16 pairs of MATCH+REPLACE registers to program host and guest's
StreamIDs. Our previous mdev implementation in v2 can be a good
reference code:
https://lore.kernel.org/kvm/20210831101549.237151fa.alex.williamson@redhat.com/T/#m903a1b44935d9e0376439a0c63e832eb464fbaee

Thanks
Nic

> > +             default:
> > +                     /* Unsupported CMDs go for smmu->cmdq pathway */
> > +                     return &smmu->cmdq;
> > +             }
> > +     }
> > +
> >       /*
> >        * Select a vcmdq to use. Here we use a temporal solution to
> >        * balance out traffic on cmdq issuing: each cmdq has its own
> > @@ -199,13 +218,22 @@ int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
> >       vintf0->idx = 0;
> >       vintf0->base = cmdqv->base + NVIDIA_CMDQV_VINTF(0);
> > 
> > +     /*
> > +      * Note that HYP_OWN bit is wired to zero when running in guest kernel
> > +      * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
> > +      * set of supported commands, by following the HW design.
> > +      */
> >       regval = FIELD_PREP(VINTF_HYP_OWN, 1);
> >       writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
> > 
> >       regval |= FIELD_PREP(VINTF_EN, 1);
> >       writel(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
> > 
> > -     vintf0->cfg = regval;
> > +     /*
> > +      * As being mentioned above, HYP_OWN bit is wired to zero for a guest
> > +      * kernel, so read back regval from HW to ensure that reflects in cfg
> > +      */
> > +     vintf0->cfg = readl(vintf0->base + NVIDIA_VINTF_CONFIG);
> > 
> >       ret = readl_relaxed_poll_timeout(vintf0->base + NVIDIA_VINTF_STATUS,
> >                                        regval, regval == VINTF_ENABLED,
