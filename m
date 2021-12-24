Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D200F47ECEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351914AbhLXIDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:03:02 -0500
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:54561
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343618AbhLXIDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:03:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLzCquRb57c5VDGXE35vTg6x5XzU1DA9pF9Ka6vfZ87fMjaFH0idZzB3XAeeLWdHyCkbgVRueEvI4DsBR3DNySIy1/SkpQpB6kkgjopazO8TSvneq+mUUWDlCGbArYdEmhNUQ1g9bHbLrxjOvgNNPQB6es4rZ46HysHsdicPnZyd1gOGiHnqIGGe4TuVdQrfAKSymp5VrbeAfQ2crTgluvEx3421urKoj6tS4XM0ACnlrxA+5cOBr3M7x3OrOGIkf1bEkiw3uY1EculHx2FPJX5ehQ0BbELaK6Z2pTCIn/CVnkq3t0cwEoJkGaIVL1lOfJsK2Z3mEDo11/kNBuoM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRQAfDTdNSH3XKNaBs8R4rFNda8Y8C0eU5x6KTeaghI=;
 b=USIwIzbLn6n/cKwBoqsyml1a1V0DN5r/pXXDkwwH0K8wIqZTxi3K2UzaVb+pr5VQ6WyIjZpqUsMXzuEZLOSLdo3YGwG6okCO0Mb0BM3Rer+vU1vQu3HHgbRon9zF2aJIKnflv2XpR2YQUnExwaL0ify2x1ZZDVOpqDhhiEuw6b7rS1CU9ZZE2HYWnl+v/LDSFwMtqZKEisFUHtuVkYkpC46ZFDlxshuQ9o0kH7LFEFEUQmNDigHIoguq4tldWwMT1z3BdeX7yy5onrTgNzoA62OyDw7dQG6qdGj1uigGrGybbhPxx6GPEpZereOlASoTknBFjohpYPuYOlBb6svUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRQAfDTdNSH3XKNaBs8R4rFNda8Y8C0eU5x6KTeaghI=;
 b=uaKt453pnyten0S8p0q0T+PEswrBsmh/yAL7dCzqUSvQotQq5gs0c8obdSEiWywaf/XRlmLGwIvQDI7BaGC3hqbBdxl8CKv912ANEHANINUBS2ClUEZVBOv2/kM+TIaQVujCHx6lMj5P5LQIBiOLXa5MwUvZojw7JOKpKg3AsEnmOSi0sV7WcLDNb+d5zO2AMfbxCUaRYDbO+0c6fVOdtHnPvc70vP2BDamQh31LD0Uw1YJSptoylQNxtYchyrwSnJQvIxm7OBAld2PlDUxOK0C/G/kKa7JAGokPO6HsMtWqxzSgqR7iZkUvWGfwy7dEwAWuhfQ3LAXobVvwY2yT3g==
Received: from DM5PR06CA0038.namprd06.prod.outlook.com (2603:10b6:3:5d::24) by
 BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.18; Fri, 24 Dec 2021 08:02:59 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::1f) by DM5PR06CA0038.outlook.office365.com
 (2603:10b6:3:5d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16 via Frontend
 Transport; Fri, 24 Dec 2021 08:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 08:02:58 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 24 Dec
 2021 08:02:57 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 24 Dec
 2021 08:02:57 +0000
Received: from Asurada-CZ80 (172.20.187.5) by mail.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend Transport; Fri,
 24 Dec 2021 08:02:57 +0000
Date:   Fri, 24 Dec 2021 00:02:55 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jean-philippe@linaro.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-tegra@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jgg@nvidia.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Message-ID: <20211224080254.GA4653@Asurada-CZ80>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
 <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
 <20211222225134.GB5698@Asurada-Nvidia>
 <6d570b70-245d-bd99-a64c-065ade787d98@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d570b70-245d-bd99-a64c-065ade787d98@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f0d274f-0da0-4627-9730-08d9c6b3ccdb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2598:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2598E97CA5E2B22577793D95AB7F9@BYAPR12MB2598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3ngYTIXP04L7X5EqWnXbB4xs2kUwXkbr1Uz8gtYT6WjYetz3H+39hvxDxjuGnXc+euv445HZ/bRpUJqsMIRsmDJKQZSbGc0TfKpewZoFH+dHSuaLvUzHe4SaJsOmjQJxNgnOJ8ikKLk7M1DkBuKm9K+HnBMgaTejUY9PccwkB6aIYmY2+uWbX2NKbSt0jBsf0pMtyFSKoGjA60hAk4+tmEc6aOnNtkz2hpT7uVvfKn3IWy/xakMYJsbGUYFAyEWRheQwIMPnh8AJPgXBTK5qaAJ3A33jwtxGAff5mDZS92JXFoRhdw6xm3d0BNpNrxdJToL/ybVpTjS5U2zhsVcCgh5UxAqMUsGeLBr6LXKZxNgKMZeJ8HDYgWS4yfXdjSxEcDYXIbRjvUwzclojdmIf1r/0adEaabilklLoh5YvDS77Eak9nXojUVRmMCZyNPFUq/gi/FBCYfJB1JmYZXAcRjPJeSkw3/XEONgYaH3WDPz29Q+1yXyCNRsP8FlxoRyQ6CSba+Np+HsIVAfWUaTdVP81G5u8nPkpiK9e6zg5eKA+JENdflcxtmxCxlP+/Ygj51GflA3Se60uLT+XeZ42I5P1/dbTNj5kIvZU6pBAo0GEqgk8kcDeQqH3Q9RRuuTCA//g/xNRq5ZB/NIoxKPgIBPj7Xgt37dWkuuUqmSKMKkGgWirk+TsJhTjiPZR6Gnxh7d75qiWPwEZSY9lqTuUw+eIKuaGXxW/wKd1uSgKV8q4VJi4zdtiXJMRkFKD/LIxy29JMulZ09XS79VTfUNi/XUq0F5MyM1v4t2R0ZnZIq6Rixrdc1aIUW8OyHMvTR33vg8ViX+tOPIY6V7kzqk1Q5SnmzrwC2VuwZMrt7Ko5WLKAFe2l1OOiFNXuEJ026H
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(33716001)(70586007)(316002)(53546011)(966005)(9686003)(70206006)(83380400001)(356005)(6916009)(54906003)(81166007)(186003)(8676002)(26005)(47076005)(8936002)(1076003)(33656002)(4001150100001)(336012)(40460700001)(426003)(55016003)(4326008)(2906002)(5660300002)(508600001)(82310400004)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 08:02:58.6149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0d274f-0da0-4627-9730-08d9c6b3ccdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:14:17AM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2021-12-22 22:52, Nicolin Chen wrote:
> > On Wed, Dec 22, 2021 at 12:32:29PM +0000, Robin Murphy wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 2021-11-19 07:19, Nicolin Chen via iommu wrote:
> > > > When VCMDQs are assigned to a VINTF that is owned by a guest, not
> > > > hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
> > > > are supported. This requires get_cmd() function to scan the input
> > > > cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
> > > > unsupported commands can still go through emulated smmu->cmdq.
> > > > 
> > > > Also the guest shouldn't have HYP_OWN bit being set regardless of
> > > > guest kernel driver writing it or not, i.e. the user space driver
> > > > running in the host OS should wire this bit to zero when trapping
> > > > a write access to this VINTF_CONFIG register from a guest kernel.
> > > > So instead of using the existing regval, this patch reads out the
> > > > register value explicitly to cache in vintf->cfg.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
> > > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
> > > >    .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
> > > >    3 files changed, 36 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index b1182dd825fd..73941ccc1a3e 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> > > >        return 0;
> > > >    }
> > > > 
> > > > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> > > > +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> > > >    {
> > > >        if (smmu->nvidia_grace_cmdqv)
> > > > -             return nvidia_grace_cmdqv_get_cmdq(smmu);
> > > > +             return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
> > > > 
> > > >        return &smmu->cmdq;
> > > >    }
> > > > @@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > > >        u32 prod;
> > > >        unsigned long flags;
> > > >        bool owner;
> > > > -     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
> > > > +     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
> > > >        struct arm_smmu_ll_queue llq, head;
> > > >        int ret = 0;
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > index 24f93444aeeb..085c775c2eea 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > > @@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
> > > >    nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
> > > >                              struct acpi_iort_node *node);
> > > >    int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
> > > > -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
> > > > +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
> > > > +                                               u64 *cmds, int n);
> > > >    #else /* CONFIG_NVIDIA_GRACE_CMDQV */
> > > >    static inline struct nvidia_grace_cmdqv *
> > > >    nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
> > > > @@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
> > > >    }
> > > > 
> > > >    static inline struct arm_smmu_cmdq *
> > > > -nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > > > +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> > > >    {
> > > >        return NULL;
> > > >    }
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > > > index c0d7351f13e2..71f6bc684e64 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
> > > > @@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
> > > >        return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
> > > >    }
> > > > 
> > > > -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > > > +struct arm_smmu_cmdq *
> > > > +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
> > > >    {
> > > >        struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> > > >        struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> > > > @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > > >        if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> > > >                return &smmu->cmdq;
> > > > 
> > > > +     /* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
> > > > +     if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
> > > > +             u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
> > > 
> > > I'm not sure there was ever a conscious design decision that batches
> > > only ever contain one type of command - if something needs to start
> > 
> > Hmm, I think that's a good catch -- as it could be a potential
> > bug here. Though the SMMUv3 driver currently seems to use loop
> > by adding one type of cmds to any batch and submitting it right
> > away so checking opcode of cmds[0] alone seems to be sufficient
> > at this moment, yet it might not be so in the future. We'd need
> > to apply certain constrains on the type of cmds in the batch in
> > SMMUv3 driver upon smmu->nvidia_grace_cmdqv, or fallback to the
> > SMMUv3's CMDQ pathway here if one of cmds is not supported.
> > 
> > > depending on that behaviour then that dependency probably wants to be
> > > clearly documented. Also, a sync on its own gets trapped to the main
> > > cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the
> > > VCMDQ, huh?
> > 
> > Yea...looks like an implication again where cmds must have SYNC
> > at the end of the batch. I will see if any simple change can be
> > done to fix these two. If you have suggestions for them, I would
> > love to hear too.
> 
> Can you explain the current logic here? It's not entirely clear to me
> whether the VCMDQ is actually meant to support CMD_SYNC or not.

Yes. It's designed to take CMD_SYNC in same queue too. Though it
also has features, such as HW-inserted-SYNC when scheduler moves
away from the current queue or when the number of cmds in vcmdq
meets a MAX-BATCH-SIZE setting (in config register), yet it'd be
safer for software to ensure the CMD_SYNC is inserted to the end
of the batch.

> > > > +
> > > > +             /* List all supported CMDs for vintf->cmdq pathway */
> > > > +             switch (opcode) {
> > > > +             case CMDQ_OP_TLBI_NH_ASID:
> > > > +             case CMDQ_OP_TLBI_NH_VA:
> > > > +             case CMDQ_OP_TLBI_S12_VMALL:
> > > > +             case CMDQ_OP_TLBI_S2_IPA:
> > > 
> > > Fun! Can the guest invalidate any VMID it feels like, or is there some
> > > additional magic on the host side that we're missing here?
> > 
> > Yes. VINTF has a register for SW to program VMID so that the HW
> > can replace VMIDs in the cmds in the VCMDQs of that VINTF with
> > the programmed VMID. That was the reason why we had numbers of
> > patches in v2 to route the VMID between guest and host.
> > 
> > > > +             case CMDQ_OP_ATC_INV:
> > > > +                     break;
> > > Ditto for StreamID here.
> > 
> > Yes. StreamID works similarly by the HW: each VINTF provides us
> > 16 pairs of MATCH+REPLACE registers to program host and guest's
> > StreamIDs. Our previous mdev implementation in v2 can be a good
> > reference code:
> > https://lore.kernel.org/kvm/20210831101549.237151fa.alex.williamson@redhat.com/T/#m903a1b44935d9e0376439a0c63e832eb464fbaee
> 
> Ah, sorry, I haven't had the bandwidth to dig back through all the
> previous threads. Thanks for clarifying - I'm still not sure why any
> notion of stage 2 would be exposed to guests at all, but at least ita

Do you mean, by "notion of stage 2", Host Stream IDs? The guest
wouldn't get those I think. They'll be trapped in the hypervisor
-- the user driver (QEMU CMDQV device model for example.)

> sounds like there's no functional concern here, other than constraining
> the number of devices which can be assigned to a single VM, but I think
> that falls into the bucket of information that userspace VMMs will have
> to learn about this kind of direct IOMMU interface assignment anyway
> (most importantly, the relationship of assigned devices to vIOMMUs
> suddenly has to start reflecting the underlying physical topology).

We haven't started to think how to fit the best into the IOMMUFD
but we will be likely having some idea or test case in Jan.

> Out of interest, would ATC_INV with an unmatched StreamID raise an error
> or just be ignored? Particularly if the host gets a chance to handle a

Mismatched StreamID will be treated as an Illegal command. Yes,
there'd be an error.

> GError and decide whether CMDQ_CONS.ERR is reported back to the guest or
> not, there's scope to do some interesting things for functionality and
> robustness.

Would love to learn more about your thoughts :)

Btw, I think we may continue the discussion on this PATCH-5 and
then to figure out ideal solutions for those potential bugs that
you commented so far, as this patch really is very introductory
to Guest support (we need more implementation based on IOMMUFD.)

For the first 4 patches, they could be separated. Do you see a
chance to get them applied first? They are in the mail list for
a while now. And we'd like to accelerate the progress of those
four changes first.

Thank you!
Nic
