Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939424EEC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbiDALyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbiDALyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:54:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD4270874
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHYh0gQ/l1UJAF44+WDYn3hdfSlRiHNM7nLlisSytozxN0oMNygiIW+WJ72EuqNWe0LadaPFCuljrgoO5eTfZgbxFv89Ht8aafoJeu2PWAgGA1xZ4KDNajHJcOyoxfKrcJ4o94RMAsFhlK5M7CFGJ8rmOUIzBewQx1CbnRsmnaKn20VDXvMzwgUMQW3b/y4sojA11eDN1XM5ubGFXvgQlYFAgg4v2ixe6HJIM1Scv9af5a4Hf4IBlQ035XEX//AtFCJlzksZivn1ZNZwzj31gEn0hBgPM1qwjMHdfUyGTPxrLGek7nv4HOaupG9TX2ZYlZF5YHMGHbuCfneSTYkOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKwZrdKAJXP7d+zqYf+NNE++8XFgSEDbK16IohXKXGI=;
 b=H4Iroi7n5+wnam/gRKlaWNPg3WxMjKDEzQmRL//ytZib6YBuv19KmkDd+3FRmM5iqzDXtab6oEgOZGtW25Sw0MiVMpoSOYCh6DcxeeDqtleSEIsHMJUV32XwbNMat6qJsMoHJJuHR3IrWmkry5r53uveZn19WrGj4JasVT8UISKQ1ulLbHaAZijN+ojqZbcUZHEvU3qehkV8ZkBMa7bclrQpqIWNbXVQ2wK2OYB3fNLEU8ncTb8kLFUhvC96S2NmDLwtosZNzctFpexRCMUQEkTjO6TNEVXIMarEZzBCl4Kna6RJ7/uaAPg008VZrc0lJ/Pf9tq62/j5sbVMp/MWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKwZrdKAJXP7d+zqYf+NNE++8XFgSEDbK16IohXKXGI=;
 b=kg0QRH9DZ6/GAarB2MdLIMewsO4A5wDYk/NjTbEq/vth2pL4hfuBPcY8dfSFi94sQpuBieac6yTj5d7496y5lGDaGHLVUACgKwL8J9WDpo7TtFGSy565wX9GFgHrXfVA3Fb2iqTKb4uh3UK/XulS5JIbsPffGWhHzC/PSDUUSpQxlIuFKCgrIDpC012x1xv/9kLxXdbUjYGhjNKC4QR4UHe8MnCnzr2MW7qh4NTc/ar42KsuTQQ2O2SteBueIzFDSRKCHx+c+iOQBgwVZpl4W7vkRR/hwLfn4dHP/b2CIMjHcTurSkmi8qu9UtSDic6XvlmeZtAzcx4fNU0G0Z9CnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2395.namprd12.prod.outlook.com (2603:10b6:907:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 11:52:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 11:52:13 +0000
Date:   Fri, 1 Apr 2022 08:52:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220401115212.GJ2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <81ea9536-ba36-deef-b849-6b407b5409e0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ea9536-ba36-deef-b849-6b407b5409e0@intel.com>
X-ClientProxiedBy: MN2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:208:15e::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f630666-0688-40f0-d4b9-08da13d60f8a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2395:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23957E197318CA34F29AD344C2E09@MW2PR12MB2395.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n2ZRelrnXELqb6n0Xte41Ip1V/n84RmHhkIVIo/0iPYeaCMmmjG4DuJLGyCz4iC1qHVFhPG3633R2JLrFHOX7j5tanS8fN1cIgVonXIj86C/XLaGwL/s16JmeIsOjdiDX1UGLPA7unKhmG1RBhy5Y4okEGHR1y+OOGh5swf5PsHFY5cKcjQ3LtRra8JqZZ3bfDjBTsstz4ZAoOD1tsWvsuVGyDIQni51bFnnrUl19XPzm+pZJbBdmCVdx/grFaeHtGQKfbbfP6BAjT5lz2zDHG2kE7vcg2UsVD7FxH1guuGZPIbczvLHq38gsMeJ8vL72tr3HtOaqlaPHP1d1QsXJwFYf0Pbh1H+QYzlaYlIcHObww8RcyhTEiUwWrSM02LZ76zGzTANoAuL0lTd5KiQAT/+sc4ffRWk2Bqxem6gdx/JQUlvyrdxxPL7Mws1NjHsN+jzlABbo3AfTV3veDXrhjruPpxDUmeymMe3uqrJrojwNJcDvbAJu40MyRJvAY5AHIkmMVlkGdCtfiQy/L/xcmqg140RLfKS3/RSZw7HtmdUtKFyzS2QTbJLykMkMMMouRtux/rkgIali/mml0pfTumnE6uR2UlKSEGi+HndRI2zODpKhPF33C3zA/ctOZpGNR2XJz7xsNPuHQS6JChqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(38100700002)(8676002)(2906002)(66946007)(66476007)(66556008)(4326008)(53546011)(33656002)(6506007)(1076003)(6512007)(6916009)(2616005)(316002)(5660300002)(186003)(508600001)(54906003)(26005)(86362001)(7416002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?npPF+pDi2oQqEtYMZqCHaHgh9lzjL0UhvewIOE3wFCOHtphpaobGeJcYRrDq?=
 =?us-ascii?Q?T8SbUh7CRrD7iC62kvywOo3mevBuVHjyh5kTIH2J/bHoaJe+dXRBQnEVN908?=
 =?us-ascii?Q?aTmJI+leK363eHc8LjxhIQdHM+c3MMPhoRGHZmUi7oWmwjz8FxYwmSZtDGos?=
 =?us-ascii?Q?Xk48L6Ngb6XpuKVUzHm76VcVSsN3KpZ72et+uXPERWgWaPCQywpaLbdxzJ1O?=
 =?us-ascii?Q?FNByAZ6LmEVolkcYKzI+NqtjE3Z32WeaI4+a8+qY/JuK1vUuSanvh/YSMGcQ?=
 =?us-ascii?Q?FYfyxYHSvbYbZtnvj5Rj92reoFlu5CiPvPPfrSlPy1sUuUwdfejr3oDdqySI?=
 =?us-ascii?Q?tbh1NZ80Vn7tArKICaPsHeiYU75TLYbSD0Zj3JtBK4BPloL+o6Wrxie9ANGL?=
 =?us-ascii?Q?MgIi1W55Br/5YHy/ydEYfrL7rmgs3wfz/eFed7jU9KrbRyXawiHkXt0uzGC4?=
 =?us-ascii?Q?1cin0wycJjcdjsSrIDm3SL9VCl4T/PXSoh6LVRegQTtCp0ZmrGQjVBpyY9ro?=
 =?us-ascii?Q?A0tROkDhZILI0JyYWo0PFMt88T/95qQ68LPJB1qCWiVOxMboCi6NkqYlLMOT?=
 =?us-ascii?Q?KhJyT3Y3kzil2BwEIEH5MJ/vmUdwQDM/NpDJSnhB863nZH0PbR8ed65AhLpT?=
 =?us-ascii?Q?KOdH8LUFclT7RSdg7OLHhISf28DmnSvF5oIP+s0jnKbzPN3Wky4Vd9XcvlpY?=
 =?us-ascii?Q?W0zt1ChUbDflL/vJ2BMKw7UqWScs01n4PSnt4x5HGvLRCIcgg5o9BTSS8kaj?=
 =?us-ascii?Q?GnWRiATLdLjEIzhTwggZFSRl6WbhbHElbFfQEOKA5rIdeGCJ8mMEGzs+8quC?=
 =?us-ascii?Q?TcYO+cQjZ7JGnTeZUqcYL0hEPVENLscD7Yi0ph1rR6dYgCt4BmEKiTFkHTqJ?=
 =?us-ascii?Q?tQT7o3IYmHnInSqi0c0mQKtUauCZ5Ddk1Hg5hoZzp3UI9sKinALI91tmFwmU?=
 =?us-ascii?Q?FY7kko1DMdliHKlW+lsfiaWNPFCAQpFOWttWXane5nEVOb2dU39yZdXaF4Eh?=
 =?us-ascii?Q?VBRsxVmCW2EejXF29nt+CZtaiU7VBIINbsqtQy46e6PVuLXVCNTNUna9HKe9?=
 =?us-ascii?Q?iMGacJfHhDBNzs16hnJD/vL5Px2cqOt/6Cg7WxSRun8P/f8jqO2vPQZpkye3?=
 =?us-ascii?Q?dCcWdpTTfxmHiNziHTwX8ojp55G/FuWauB/F3aVG85wfhi7JSRLCaD926BTh?=
 =?us-ascii?Q?b/LAqP1EtJZrSfrk2eWTUb7GKiQMqMFKbSwnS4HFxLSTAjWVbLNX2wuOAihY?=
 =?us-ascii?Q?30GQ7biR1EDfBJOmMmfII0vWRXxo9Ml759XPohtPmU57d/bewoBvs6TYB+ku?=
 =?us-ascii?Q?GpmTC6R8pqtCNUktORIe2Cil2dFzjbO8Z8l6o3R90qR6ajJkgYGOUSuq7CiL?=
 =?us-ascii?Q?Z3BCMhRR8yj5tM4wNOYyDrgLkmCOtD2V/62wF4n0vWF4b08AcRO5Vph2XhOi?=
 =?us-ascii?Q?mqD9dLjgG+7QujcaV8o+LpFR31YBj9XNU/hDoQY8yZpO2WODBZVoTGUVyu9M?=
 =?us-ascii?Q?zfBNpB+IQka/X4q08wl52O1y2ylZsQqnryXCzw0U4d5AlTQ4w7TebHbmsm8V?=
 =?us-ascii?Q?t/Hsm0G4S+bMSsvxLaz+VgxUomdtU+E4BF4aCFCctxBbCevXpAW7tYP4ggnf?=
 =?us-ascii?Q?G/Dt2gqI1YBxoanXLkyURBFLobJ+fs6CEJWQrsMsCk4i1GffRYVIbRnPLrKK?=
 =?us-ascii?Q?OrQ0Tbw/ATb9WojR1SGcyqFUsL+Lqtx17GeiKGYJXCC44yYGgXMcpYhfInCB?=
 =?us-ascii?Q?VC4BwwLGig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f630666-0688-40f0-d4b9-08da13d60f8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 11:52:13.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjM1BxYdbz7OMKpVcHt+o9i90gyxiz9SunxDCfaUiu7yihuV44W/UyMTFDy9aq4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 02:20:23PM +0800, Yi Liu wrote:
> 
> 
> On 2022/3/29 19:42, Jason Gunthorpe wrote:
> > On Tue, Mar 29, 2022 at 08:42:13AM +0000, Tian, Kevin wrote:
> > 
> > > btw I'm not sure whether this is what SVA requires. IIRC the problem with
> > > SVA is because PASID TLP prefix is not counted in PCI packet routing thus
> > > a DMA target address with PASID might be treated as P2P if the address
> > > falls into the MMIO BAR of other devices in the group. This is why the
> > > original code needs to strictly apply SVA in a group containing a single
> > > device, instead of a group attached by a single driver, unless we want to
> > > reserve those MMIO ranges in CPU VA space.
> > 
> > I think it is not such a good idea to mix up group with this test
> > 
> > Here you want to say that all TLPs from the RID route to the host
> > bridge - ie ACS is on/etc. This is subtly different from a group with
> > a single device. Specifically it is an immutable property of the
> > fabric and doesn't change after hot plug events.
> 
> so the group size can be immutable for specific topology. right? I think for
> non-multi-function devices plugged behind an PCIE bridge which has enabled
> ACS, such devices should have their own groups. Under such topology the
> group size should be 1 constantly. May just enable SVA for such devices.

Like I said, you should stop thinking about group size.

You need to know that 100% of TLPs translate through the IOMMU to
enable SVA, nothing less will do, and that property has nothing to do
with group size.

> > ie if we have a singleton group that doesn't have ACS and someone
> > hotplugs in another device on a bridge, then our SVA is completely
> > broken and we get data corruption.
> 
> I think this may be a device plugged in a PCIE-to-PCI bridge, and then
> hotplug a device to this bridge. The group size is variable. right? Per my
> understanding, maybe such a bridge cannot support PASID Prefix at all, hence
> no SVA support for such devices.

Any PCIE-to-PCIE bridge will do, don't ned to involve legacy PCI here
to have hotplug problems.

Jason
