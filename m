Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5285F47C906
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhLUWAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:00:46 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:3169
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231538AbhLUWAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:00:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je0tV/IFwu6FB3ir4B28wQXPpAwLC/3q0s2UaYoLXROby/clU+jC9pfKQVsKi9isyAh/zmI1sX9wGLl1ya5arJpsJb+sKuWC+I5YpNl6YYD7bGXphgPsQItASlD6T8WSKPc7/SiDiGRn+oyf+NuyXHSg0kffL7NezwlFbRZzH8L6IlQk1b3XD/cAcwegny3uLm0m6QhpCdIoSBR2ZIweXTkVZxwPrT1EpNXRj0D6G5BtASroYCDNninOmiMqkFD1ddCaboUmwd0j/T2wi9qCWFawBAUAbMKoELoc1XZDv1RxwUuQy75mZZAn1lG6590ae7lH/Dl/VUl6RiYcMq9Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhkQoWGel7knkTtoeuROdAg3SStMI7ZqVTEnWBsdVlQ=;
 b=LvU5JEnN1YTCeAhW49c40WOa6Kjuo8d85ildu8AsrBcBjIrXkVLdjqFG7FbvxvszPSHUtM2IpTy17jZoIyS9165XLVWiusYBwl9hca9+oMHzmQOAC4HRwo1MTbI8ycM8H7zrDJwj4LnHH33Qf07mYz8GXAUu5lMdx/qQ3EG1AXkZoL5YBw4D/XHNoKOVE5XcH3B1nJCe6cxHslorXq7iiGhPdBLUiEiHnf1xkNbhmUUGIFJd7Yfwd7sf72oKQ8AfvFfJcAZBNa1OFJ+uNnPqnjyRPcMfvPoIpWH+xnrGUyH7WxvPGMj7newnfhiaXdF2T7rY5BvHngNEae/T5nddjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhkQoWGel7knkTtoeuROdAg3SStMI7ZqVTEnWBsdVlQ=;
 b=umnC5XeJ84JOCXKu5299PGzq6fXjgr6nIfkli5IBv/jI0lAOmxFcBiaboz6hP+o/JMiJ9xY48OE111RvAip2tTMmRMyRYd0XjJgrGPmMebONiPYCB02OaNCW6S5R9ZmdOwx/rtSOPWz+Oul6x3Q9SrcVTqOi5vPAZ3d+tLPoARvbZXuPGMZg0RKcqj6Hk6jsMOsF9BayOcPdlK192Hicl2UzxCX866cuHy2TCT1UqOQpZ/awMFzc5nDHEbx+2QCTfLe/QVCuBY9UrNPVHsj+0UWDCvPEcuXRnkeoru+v9sYMxGn/2Ot/rh/0tlc6Pi7+CCDwSt+QiuwNstesy/LTHQ==
Received: from MWHPR14CA0042.namprd14.prod.outlook.com (2603:10b6:300:12b::28)
 by CH2PR12MB3656.namprd12.prod.outlook.com (2603:10b6:610:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 22:00:42 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::35) by MWHPR14CA0042.outlook.office365.com
 (2603:10b6:300:12b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Tue, 21 Dec 2021 22:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Tue, 21 Dec 2021 22:00:42 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 22:00:40 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 22:00:40 +0000
Received: from Asurada-Nvidia (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 22:00:39 +0000
Date:   Tue, 21 Dec 2021 14:00:39 -0800
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
Message-ID: <20211221220037.GA6292@Asurada-Nvidia>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
 <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
 <20211220192714.GA27303@Asurada-Nvidia>
 <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3f4fd5-579b-4c21-818d-08d9c4cd5506
X-MS-TrafficTypeDiagnostic: CH2PR12MB3656:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3656CB16842BFDC5C8BB0947AB7C9@CH2PR12MB3656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wX3T0Uox+8AlEBF9AfKJE5jyuOXrdqjZr85DazKkVX/d+enljOS23emjhtoITiUScfBeDaH0n54O8zVaMavtNuuAtohXujNGc3cRKG1S5tYiBA6cyBCMl+LbN6IA+1sEaD8kVSJVAzH4R+qjOK/NwvB6yeX7fZ+AScu7HM9pyCi8bBZDS1eKXrrbYO9X6NJchHgtXrTA/ejiP4UkQw1A8BEpp2lwklhtRwf7Y3rn8pDf20SKtB5H2LtLUfribYy7Mvf2Yi6ngvJ4B8tPyw5eEfn6GsbPwnXeMdxHNGfnQEEG/o3zOhtFzYYu6J0byJZJCkMkBzTfzkxiEis3NDdW/5sSlHcubfzjXahQeiLjmrg32EvTg8aN0skxvq11StBAIsMnCJ1RGJIjsd7c9DTphhzHiD7hmDhH/8i6xV4i72jW9TzvQtomGm9J05pQTcYPSOAF6YRu7u6pLiAxcmnEBwXmYmjXZzYwcC/9mN87Ak7K4a+K/5gZTnPvaCYXjt4+cXYd7ffKZnA3hQ1H8rT8duupPxCGYfKqDzXDUghJBaZVmYqEgz0I1JUNNPMGIx8pVsaNu8JorpivPe469fhAYX4YASJAT95ZtTRk2j6GmFj+uKWhgN0NHSuFOTppryyukCvuMZHwflv0ygVyWBCz3ImLn+TfA3rzTQXXr013CRXakJ3KXZfTNI+a3NpVGeCRXGbz6+z3fe44JzaRAjaAoReqh7WnQOJW4uW43yFQY/iZY9Ps+iQn/ob8ebAjJ9XXX/HU11XIAW8UNOAtgtcUGuY9ADvV8OhVEPesQpi/0a4lCu7QwqLeH1w63YBPAhBstocOshocaPH8EG6nVsHY/Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(316002)(36860700001)(7416002)(82310400004)(83380400001)(54906003)(47076005)(53546011)(33656002)(55016003)(2906002)(86362001)(1076003)(8676002)(426003)(5660300002)(40460700001)(356005)(34020700004)(9686003)(186003)(81166007)(8936002)(107886003)(4001150100001)(6916009)(70586007)(70206006)(336012)(26005)(508600001)(33716001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 22:00:42.2371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3f4fd5-579b-4c21-818d-08d9c4cd5506
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:55:20PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2021-12-20 19:27, Nicolin Chen wrote:
> > Hi Robin,
> > 
> > Thank you for the reply!
> > 
> > On Mon, Dec 20, 2021 at 06:42:26PM +0000, Robin Murphy wrote:
> > > On 2021-11-19 07:19, Nicolin Chen wrote:
> > > > From: Nate Watterson <nwatterson@nvidia.com>
> > > > 
> > > > NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
> > > > which extends the standard ARM SMMU v3 IP to support multiple
> > > > VCMDQs with virtualization capabilities. In-kernel of host OS,
> > > > they're used to reduce contention on a single queue. In terms
> > > > of command queue, they are very like the standard CMDQ/ECMDQs,
> > > > but only support CS_NONE in the CS field of CMD_SYNC command.
> > > > 
> > > > This patch adds a new nvidia-grace-cmdqv file and inserts its
> > > > structure pointer into the existing arm_smmu_device, and then
> > > > adds related function calls in the arm-smmu-v3 driver.
> > > > 
> > > > In the CMDQV driver itself, this patch only adds minimal part
> > > > for host kernel support. Upon probe(), VINTF0 is reserved for
> > > > in-kernel use. And some of the VCMDQs are assigned to VINTF0.
> > > > Then the driver will select one of VCMDQs in the VINTF0 based
> > > > on the CPU currently executing, to issue commands.
> > > 
> > > Is there a tangible difference to DMA API or VFIO performance?
> > 
> > Our testing environment is currently running on a single-core
> > CPU, so unfortunately we don't have a perf data at this point.
> 
> OK, as for the ECMDQ patches I think we'll need some investigation with
> real workloads to judge whether we can benefit from these things enough
> to justify the complexity, and whether the design is right.
> 
> My gut feeling is that if these multi-queue schemes really can live up
> to their promise of making contention negligible, then they should
> further stand to benefit from bypassing the complex lock-free command
> batching in favour of something more lightweight, which could change the
> direction of much of the refactoring.

Makes sense. We will share our perf data once we have certain
level of support on our test environment.

> > > [...]
> > > > +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > > > +{
> > > > +     struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
> > > > +     struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
> > > > +     u16 qidx;
> > > > +
> > > > +     /* Check error status of vintf0 */
> > > > +     if (!FIELD_GET(VINTF_STATUS, vintf0->status))
> > > > +             return &smmu->cmdq;
> > > > +
> > > > +     /*
> > > > +      * Select a vcmdq to use. Here we use a temporal solution to
> > > > +      * balance out traffic on cmdq issuing: each cmdq has its own
> > > > +      * lock, if all cpus issue cmdlist using the same cmdq, only
> > > > +      * one CPU at a time can enter the process, while the others
> > > > +      * will be spinning at the same lock.
> > > > +      */
> > > > +     qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
> > > 
> > > How does ordering work between queues? Do they follow a global order
> > > such that a sync on any queue is guaranteed to complete all prior
> > > commands on all queues?
> > 
> > CMDQV internal scheduler would insert a SYNC when (for example)
> > switching from VCMDQ0 to VCMDQ1 while last command in VCMDQ0 is
> > not SYNC. HW has a configuration bit in the register to disable
> > this feature, which is by default enabled.
> 
> Interesting, thanks. So it sounds like this is something you can get
> away with for the moment, but may need to revisit once people chasing
> real-world performance start wanting to turn that bit off.

Yea, we have limitations on both testing setup and available
clients for an in-depth perf measurement at this moment. But
we surely will do as you mentioned. Anyway, this is just for
initial support.

> > > The challenge to make ECMDQ useful to Linux is how to make sure that all
> > > the commands expected to be within scope of a future CMND_SYNC plus that
> > > sync itself all get issued on the same queue, so I'd be mildly surprised
> > > if you didn't have the same problem.
> > 
> > PATCH-3 in this series actually helps align the command queues,
> > between issued commands and SYNC, if bool sync == true. Yet, if
> > doing something like issue->issue->issue_with_sync, it could be
> > tricker.
> 
> Indeed between the iommu_iotlb_gather mechanism and low-level command
> batching things are already a lot more concentrated than they could be,
> but arm_smmu_cmdq_batch_add() and its callers stand out as examples of
> where we'd still be vulnerable to preemption. What I haven't even tried
> to reason about yet is assumptions in the higher-level APIs, e.g. if
> io-pgtable might chuck out a TLBI during an iommu_unmap() which we
> implicitly expect a later iommu_iotlb_sync() to cover.

Though I might have oversimplified the situation here, I see
the arm_smmu_cmdq_batch_add() calls are typically followed by
arm_smmu_cmdq_batch_submit(). Could we just add a SYNC in the
_batch_submit() to all the queues that it previously touched
in the _batch_add()?

> I've been thinking that in many ways per-domain queues make quite a bit
> of sense and would be easier to manage than per-CPU ones - plus that's
> pretty much the usage model once we get to VMs anyway - but that fails
> to help the significant cases like networking and storage where many
> CPUs are servicing a big monolithic device in a single domain :(

Yea, and it's hard to assume which client would use CMDQ more
frequently, in order to balance or assign more queues to that
client, which feels like a QoS conundrum.

Thanks
Nic
