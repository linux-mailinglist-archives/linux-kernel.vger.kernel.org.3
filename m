Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD948069F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhL1FtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:49:19 -0500
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:40288
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234867AbhL1FtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:49:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbem0GxBzQnfJTmOIPuzi2CzHhIl8YRW2MFhize3TOfDcQ/AqnQ4Dch9PS4CE5u2I9K+o6FpA0yOIBDoZwzOMYbOu9sd1SvQu7vjg7ivrFP/cNkbQ3pMqRBhKrdD57s3Dsx0v8fFj+Y+UxN4CrTtPQliJ2wCgyGaCVWB+7x4M3xx8ujDD7voysinEY+H7l+VMeOt/zosao0wkerXpVorrMzFpBweUlbDPBDu851HF5/SlnFFxvw75N+QfJPPpN8AdjlNccEy5o8L7+C2sgGQ7s5ljV2k94cwUYJ9+Bv2SzgVKO+KePNvEsgAqfpkTGTM6fKL9H+Op9IOJGT0EpSFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFY2o1Mi8/ucN2sxjyPSMlVgNILojVLIUTTxCnmrkpM=;
 b=nI8sgXnh0iLOyUJlieEh0Zo+UvvmwVA556wPedQmuL9UuBc6fGT13nkQQ4TwJPS2qeY9EoVHO8VPs18XTMukXwG9ok6FKrYBUflqSLDVq+YxWHnIOWBpqmZLnrmhwh3HAzMfntKedjTxPKV9UM8Rra48LOZ4udbs3U4Xid1V1f+EyVZrA2RLS9SLwvoF4078ekX8IbStcPNS90AyNrhb+x/aVZMht4W3h4X6ekzw04cpEe9osLVtm3KxOrXvuJCM22zxUp8u7NRPEfd5lbZqKGdROV8x61YDrj2jxXmmImrMsLO0TBzFmr84UiEKMd1Bf0moJXl5SjlgRA9huphk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFY2o1Mi8/ucN2sxjyPSMlVgNILojVLIUTTxCnmrkpM=;
 b=NQZ0LcBSIlRtv4ErVA8CNZQZQ6AS48VfnDcNX2HU+wRKfBJtgYNy0aMBAB5oQGW1vq7iHxtHkeC5xTeJqikkZeqELnUoYTZeasSs/qOi9hWiYw/RD4JiWIchCVA2T6Nk97vNluC3Q8yLhMsjEX3rrwRitaioRzMEtHHVT7I4FBcl+35iaIfCthXyx0+4LtcxN53suj0ilxzJGYO+6vR+JD4aaH/WKWn0G6Kcf/Uzu4/3129H+DgFivnxHZaJilKOBjuPET9l7aVxCqZRt4S6YXJVmej1g/0CLblondEwvRL3ufJpv6A0ax/5mI0/NvoYWkljJWrn3xvU64W6ZkXhTQ==
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Tue, 28 Dec
 2021 05:49:16 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::20) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Tue, 28 Dec 2021 05:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Tue, 28 Dec 2021 05:49:15 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 28 Dec
 2021 05:49:14 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 28 Dec
 2021 05:49:14 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Tue, 28 Dec 2021 05:49:14 +0000
Date:   Mon, 27 Dec 2021 21:49:13 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jean-philippe@linaro.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-tegra@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jgg@nvidia.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Message-ID: <20211228054908.GA6611@Asurada-Nvidia>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
 <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
 <20211222225134.GB5698@Asurada-Nvidia>
 <6d570b70-245d-bd99-a64c-065ade787d98@arm.com>
 <20211224080254.GA4653@Asurada-CZ80>
 <e44a90f6-be69-5dca-3903-46a8caa4a37c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e44a90f6-be69-5dca-3903-46a8caa4a37c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8e9cda-6985-41f1-b65b-08d9c9c5c87d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1703:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB170396791086624FFDAEF7A9AB439@CY4PR12MB1703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GYO8rgXXNro+p1JUxQvSiSBaqP8dlFQat2wh0L79f4zRl+liq8quk4+qbFbrsMpcyGUkWuagDtpSQLZmvdZ6HxEpT0wk+ggebEeIwOKm+sEfvhgtgYlMPIHAirApkd5pc1LkcSRhwy4JPVL9VKpxa8QEckfjt8rbTaOTx1AE9N8NclH8PzwuuyQfGxuZjgJ3GLC5tzRDOq0upCWhtdK5J2CehPUKwAOojQLlptOutQtqf+uZvZiX1nkBjeehnARVoGGPFQFrHdv2bFrelVbHa/jNEHsKJtn3pNqi4U7shmF5vx1j6lNoLZWedzStLiACruIb6LJVzM1h1it+PEU69a5hNk9L+0Rzon7pANK6liaWnaG/b2cZtqOkgPcV/NW/rwp2wPsp5biHq7he4JLyLBEJionmOUMstiiSAmL6sVmjIQmpw4FfXhadaBPl5FcJc3BKbpJS7YnHo7xKBBsJ/TN5GXNhUNe1rQOvjUpD4PfUiLM9V/YR5AhURcg3GS+g37AcqmxKeeJC4XUX5Qkm3JL0yKDfoXta3HqykwH1sh0fRc8qFwbGBgki2rLzG5NVrEsmIG5yE9dUxTbys31xtt5fZoHoDiEIpSRVhE00nYM51U9twpHO8le4IsZJNChTrpwqTN2bNx47nY0jkIb2J3I3pBXudZ3QRUV+EkBKlcefRzDTRY6Vx+fNLdAFK1qmw9pO2DqGYw+zrraYv42aa1nTBOanxlJTQ57gQS70pUgMSdeyuVTaJcZhJQZ42qZ0K5/1tatnBJQ7T/qt1pv06yDE3YeuKSKYiVIUQ5hlZfj5caHCOP1mGOw9rXnPeLBM4ZAKnizXaT4HhxfTlxhY6mfTm7REQW47HW2tT+DQPNzogdHXDGW4u6eOHwyW7MV
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(33656002)(2906002)(55016003)(356005)(1076003)(82310400004)(40460700001)(54906003)(508600001)(83380400001)(8936002)(30864003)(5660300002)(9686003)(336012)(426003)(4326008)(186003)(33716001)(70206006)(36860700001)(86362001)(316002)(966005)(81166007)(47076005)(6916009)(26005)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 05:49:15.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8e9cda-6985-41f1-b65b-08d9c9c5c87d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:13:57PM +0000, Robin Murphy wrote:

> > > > > > @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > > > > >         if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> > > > > >                 return &smmu->cmdq;
> > > > > > 
> > > > > > +     /* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
> > > > > > +     if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
> > > > > > +             u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
> > > > > 
> > > > > I'm not sure there was ever a conscious design decision that batches
> > > > > only ever contain one type of command - if something needs to start
> > > > 
> > > > Hmm, I think that's a good catch -- as it could be a potential
> > > > bug here. Though the SMMUv3 driver currently seems to use loop
> > > > by adding one type of cmds to any batch and submitting it right
> > > > away so checking opcode of cmds[0] alone seems to be sufficient
> > > > at this moment, yet it might not be so in the future. We'd need
> > > > to apply certain constrains on the type of cmds in the batch in
> > > > SMMUv3 driver upon smmu->nvidia_grace_cmdqv, or fallback to the
> > > > SMMUv3's CMDQ pathway here if one of cmds is not supported.
> > > > 
> > > > > depending on that behaviour then that dependency probably wants to be
> > > > > clearly documented. Also, a sync on its own gets trapped to the main
> > > > > cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the
> > > > > VCMDQ, huh?
> > > > 
> > > > Yea...looks like an implication again where cmds must have SYNC
> > > > at the end of the batch. I will see if any simple change can be
> > > > done to fix these two. If you have suggestions for them, I would
> > > > love to hear too.
> > > 
> > > Can you explain the current logic here? It's not entirely clear to me
> > > whether the VCMDQ is actually meant to support CMD_SYNC or not.
> > 
> > Yes. It's designed to take CMD_SYNC in same queue too. Though it
> > also has features, such as HW-inserted-SYNC when scheduler moves
> > away from the current queue or when the number of cmds in vcmdq
> > meets a MAX-BATCH-SIZE setting (in config register), yet it'd be
> > safer for software to ensure the CMD_SYNC is inserted to the end
> > of the batch.
> 
> OK, so the bug here is just that we're missing CMDQ_OP_CMD_SYNC from the
> switch statement? That's reassuring at least. Having to trap to the host
> to issue a sync would be horrible, and largely defeat the point of the
> whole exercise.

Hmm..I'm not sure why we need CMD_SYNC in the switch statement.
I thought that you pointed out a potential corner case where a
batch could be submitted separately, e.g. Batch A {TLBI_NH_VAx2}
and then Batch B {CMD_SYNC}. Right now the SMMUv3 driver submits
all TLBI commands with sync=true, so we don't run into a problem
so far.

> It's not generally much use to software to know that the hardware may or
> may not have automatically inserted syncs at arbitrary points in the
> timeline; certainly for our flow in Linux, which I don't think is
> atypical, we need to know for sure that specific invalidation commands
> have completed before we can safely reuse resources associated with the
> invalidated translations, and the only way to guarantee that is to
> explicitly observe the consumption of a CMD_SYNC from a later queue index.

Hmm, if I capture it correctly, for the potential issue that I
listed above, we could simply ensure each TLBI batch to contain
TLBI commands only and to have CMD_SYNC at the end.

> > > > > > +
> > > > > > +             /* List all supported CMDs for vintf->cmdq pathway */
> > > > > > +             switch (opcode) {
> > > > > > +             case CMDQ_OP_TLBI_NH_ASID:
> > > > > > +             case CMDQ_OP_TLBI_NH_VA:
> > > > > > +             case CMDQ_OP_TLBI_S12_VMALL:
> > > > > > +             case CMDQ_OP_TLBI_S2_IPA:
> > > > > 
> > > > > Fun! Can the guest invalidate any VMID it feels like, or is there some
> > > > > additional magic on the host side that we're missing here?
> > > > 
> > > > Yes. VINTF has a register for SW to program VMID so that the HW
> > > > can replace VMIDs in the cmds in the VCMDQs of that VINTF with
> > > > the programmed VMID. That was the reason why we had numbers of
> > > > patches in v2 to route the VMID between guest and host.
> > > > 
> > > > > > +             case CMDQ_OP_ATC_INV:
> > > > > > +                     break;
> > > > > Ditto for StreamID here.
> > > > 
> > > > Yes. StreamID works similarly by the HW: each VINTF provides us
> > > > 16 pairs of MATCH+REPLACE registers to program host and guest's
> > > > StreamIDs. Our previous mdev implementation in v2 can be a good
> > > > reference code:
> > > > https://lore.kernel.org/kvm/20210831101549.237151fa.alex.williamson@redhat.com/T/#m903a1b44935d9e0376439a0c63e832eb464fbaee
> > > 
> > > Ah, sorry, I haven't had the bandwidth to dig back through all the
> > > previous threads. Thanks for clarifying - I'm still not sure why any
> > > notion of stage 2 would be exposed to guests at all, but at least ita
> > 
> > Do you mean, by "notion of stage 2", Host Stream IDs? The guest
> > wouldn't get those I think. They'll be trapped in the hypervisor
> > -- the user driver (QEMU CMDQV device model for example.)
> 
> I mean if it's emulated as a full SMMUv3 interface, IDR0.S2P=0. At the
> moment it makes no sense for a guest to even *think* it can issue
> TLBI_S2_IPA or TLBI_S12_VMALL. My understanding of the usage model for

Ah..that's true. We've listed those by following the supported
command list from HW team. There might be no use case to cover
those.

> this is that we pick the Context Descriptor from guest memory via the
> emulated Stream Table (or other mechanism like virtio-iommu) and plumb
> it directly into the S1ContextPtr of the appropriate underlying physical
> STE, on top of the host's S2 translation. I don't see how we could also

Yea. VCMDQs are supposed to do TLB invalidation only. All other
commands should be going through ioctls (VFIO or IOMMUFD). What
we currently use for verification is Nesting patches from Eric,
yet the TLB invalidation would run into the VCMDQ pathway, as a
hardware acceleration.

> flatten an emulated S2 into either physical stage without having to go
> back to the costly "trap all pagetable accesses" approach which would
> obliterate the benefit of having a directly-assigned queue.
> 
> > > sounds like there's no functional concern here, other than constraining
> > > the number of devices which can be assigned to a single VM, but I think
> > > that falls into the bucket of information that userspace VMMs will have
> > > to learn about this kind of direct IOMMU interface assignment anyway
> > > (most importantly, the relationship of assigned devices to vIOMMUs
> > > suddenly has to start reflecting the underlying physical topology).
> > 
> > We haven't started to think how to fit the best into the IOMMUFD
> > but we will be likely having some idea or test case in Jan.
> > 
> > > Out of interest, would ATC_INV with an unmatched StreamID raise an error
> > > or just be ignored? Particularly if the host gets a chance to handle a
> > 
> > Mismatched StreamID will be treated as an Illegal command. Yes,
> > there'd be an error.
> > 
> > > GError and decide whether CMDQ_CONS.ERR is reported back to the guest or
> > > not, there's scope to do some interesting things for functionality and
> > > robustness.
> > 
> > Would love to learn more about your thoughts :)
> 
> Basically it's quite neat if we could present a virtual queue to the
> guest as the vSMMU's main queue, such that any commands that the
> hardware can't consume directly could be fixed up or emulated by the
> host with the illusion that they're being consumed as normal. It does
> push more complexity into the host, and a round trip via the GError
> interrupt would be a bit less efficient than trapping synchronously on a
> write to an emulated CMDQ_PROD for commands that *do* need emulating,
> but conversely it means we could support any guest with only the most
> basic understanding of SMMUv3.0, and could potentially be more robust

Wow...that's an interesting idea! So host kernel could have more
numbers of queues to serve those trapping IRQs, although I am not
sure if IRQs, over 64 interfaces and 128 queues, would overwhelm
the host ISR... Can threaded interrupts from the same IRQ number
be served at the same time on different CPU cores? If so, multi-
queue like VCMDQs and ECMDQ might take advantage of that.

Just one concern here: we'll need to support multi VCMDQs on the
guest level too. So using the vSMMU's main queue slot may not be
sufficient for CMDQV use cases.

> overall. As I say, though, it depends entirely on the guest not being
> able to observe an error unltil the host has decided not to fix up the
> offending command.

Well, given that guest IRQs are raised by the user space driver,
I think we can have certain controls to support that.

> > Btw, I think we may continue the discussion on this PATCH-5 and
> > then to figure out ideal solutions for those potential bugs that
> > you commented so far, as this patch really is very introductory
> > to Guest support (we need more implementation based on IOMMUFD.)
> > 
> > For the first 4 patches, they could be separated. Do you see a
> > chance to get them applied first? They are in the mail list for
> > a while now. And we'd like to accelerate the progress of those
> > four changes first.
> 
> I can't speak for Will, but personally I'd consider them exactly the
> same as the ECMDQ patches - it's good to have them out here, reviewed as
> far as we reasonably can, and ready for people to experiment with as
> soon as the real hardware turns up, but I don't see any benefit in
> actually merging unproven complexity into mainline before then. Neither
> patchset gives Linux any new functionality that it can't achieve already
> with the regular cmdq, so there's nothing to gain until it's actually
> demonstrable that we really are addressing the right bottlenecks in the
> right manner to meaningfully improve real-world performance, but what we
> have to lose is more effort spent ripping stuff out again if it turns
> out to be no good. Even patches #1-#3 here fundamentally beg the
> question of whether replicating the full heavyweight cmdq behaviour is
> the right way to go.

OK...looks like we'd have to provide some solid perf data here
for host-kernel use of VCMDQs (PATCH 1-4), or to wait until we
have a full-stack support covering guest use cases too.

> I appreciate you've probably got hardware validation teams on your back
> wanting "the driver" to support every new feature right now for them to
> exercise, but we just have to stand firm and tell them that's not how
> upstream works :)

Well..I'd expect that they'll just push me back to do whatever
I can to get the job done lol

Thank you!
Nic
