Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC15394E9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbiEaQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346122AbiEaQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:22:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F765C848
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTg9x/WXTqSp9vjkAectbvQv+gOHebr4D4gJtszUwCjcVlsiipzXWcZSoR2cdjVxBmINYuEJOeb1sIyDMUz9tftThcRLA+Ecmd+kEA5cAK1MAPD2KQq/U0PJr5e3FPCA4vn5Wuy7oKg/t0odLl5Fa7p5A2+I8TuvAd6ZWBljpkwa9O71BjPTtETwppL17m1bVAmpD4kegMoClpLf4WU9V7+oXKAueLqMCSq4upEB6ClgJuVWpBO3K16Ma2zmqZre/MlDiqDtIfa902KTy+Rgm6VG29lBkNmRZvHLgWluhpbh2y7Q73s1dlSjAlbSGjtlr2PJ6apOLUdCP1Jb+noEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2S8+hWVWPB00Udo8VMa7mTuGvxmdcOc1i5xzCLrzoc=;
 b=CMdmHPXzNRlIaTmTI5cStnP9GxBYvFS6inSACNS5wERpwwzNRk5JM4XyepxrqLn/EQWeBgXgQG4XcbqAHkvm0xlpfZIWZigjMMUFP5n/ZNcwyp4ZwJ5DP4a5hSEEk0wwHIW2X1fGA1Qtr3opkvV6jNMCkxa0/cYs3mdwJj4eauzNGUKc5OL3beNKeRxrECdm90GK0PipFW9uRZ0oGKUTKsdJxgx8M6EQz/kttDr7O4LpHW4EzQujFHBWkRORL4C4QabEZkw2/GMCDnuU/fN4tdL7/xBDFeTR3QSQ2jhCwpV+uVRBve+Gk8CMYjbLeRU1br/QAW9qYcsUmfXSOE9uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2S8+hWVWPB00Udo8VMa7mTuGvxmdcOc1i5xzCLrzoc=;
 b=ejEw0uPwSJl3IZsv6S9p6B62NYL8JXMX8W84r0vXYs1TP4pynR4lbNnFcicxGAGZ21n+5IJUlbNGYomd+YrARk8tsuZGhwYwtKMp8PiMB++hN13PJqwC3hkmMpLmxesRFRnhmTLgcehWOawn7xiYq7i6jPfnivevtjaWYnx7XQ1RaY7klsdcW0Z9gfReM64NWaMFLY1FlaFkbnrO0Xy0phC3sWw+UJc59CuS0vxr2u7++QBeTlNd3aA1E4YroFugoiZ6SmWOs6R43Q/N0dR/NbZmgytOekIW+e/yKCafZR14b5qrPbB5QMEzhplcvI9Cubd8zt6oNZWdEaSr/Ab8IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2647.namprd12.prod.outlook.com (2603:10b6:a03:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 31 May
 2022 16:21:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 16:21:54 +0000
Date:   Tue, 31 May 2022 13:21:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531162152.GH1343366@nvidia.com>
References: <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a80500-6486-437a-d82b-08da4321acd6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2647:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB264721EC2AB10DC6A7281D0FC2DC9@BYAPR12MB2647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i459Krqpf73eehpi/PGZXYPVkxjm5pmQ06359WTDjMvxTdtxPS1q6EFHtoJs+5Z8jSX3cpa4sySOq8BciBuf2dVuwSELXq8JvAyIrU/dz5sAox/7g2XN7v6N+ThVxQAJUUdRx0kDo3iuvl/NgOVwXcAyuYd1ML/QG2/TROS/tCQIhpaTOZ4ajEbeZhgALGsN+fG8vizpy4SnGt52PRYSYj75pxFSNZRUA4tTnpU7tlQeSwhHTp+NPPJzRQkxPmNT0orABpi8E5bEpmQkEQwtbk7xkZhzE2NrH9s3X0tpTHtEey29Il7Z5ghi32QXWWxrhrsU1N/73C1wnB0WBb1Esx5hIkH4epbNRHnWBjFRvPU7Q8dLM1/rVUuQrKZuSO3oprujcKcFpuhMfZng6V0S5I9/burRObvXEiO1ruQxiicPMbDbnJtoIZPDXUejM57H/V9jGqDA2ITXB1kIbIJizbss/7Pkfm5c30PnApuEpIw0SGaIlFkYL3NasVzbiYh2/YNLTnuUhUoA3a1toWkhPdYDOd2I34M/ci7uhBXuyLB7J67Tlb5nvyshROTwGB51/o9F2a1z8/e7u3VixyocoRATQZATy9TdO5qVi92kFc5AWG7oJYLlqt+8LykaE9VYJpFQucBO9zfGHV1GYwpnFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(2616005)(26005)(2906002)(4326008)(38100700002)(6916009)(54906003)(316002)(36756003)(8676002)(66946007)(66476007)(66556008)(6486002)(7416002)(83380400001)(6512007)(186003)(1076003)(8936002)(33656002)(5660300002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTBnr6V63ebUXlCPav7XYSUAZ+ROmgd/U/GnfwPVF3glC9VeuNIYDSlBgGGC?=
 =?us-ascii?Q?h2OOHJTdo/6BdSc+EzO0jqkGofjfHrE9AQnRu/F7x9LO9mmsnkU0rv28H4oK?=
 =?us-ascii?Q?31tGd28msInTAs15kmfSHYVhs8De52AZuN0TtiTweiUyvxAiVhWgUkrijPri?=
 =?us-ascii?Q?AN/FoTw89Ra4gRAtVp7D36wenQ/0L0MvntiiQ+vZe00QcuQt3Fkaf2XzqbLL?=
 =?us-ascii?Q?sDKhXA3bx7IaGxOnfblD6HdapAW+M+NEp5N9xH53hiagLGDyluVUpm7bKOEh?=
 =?us-ascii?Q?vAb4ugl0zOl2fKcfflKnFRfUX+lmr8kaQHcJ2qaMtC9853w31j8K1Pq/CV70?=
 =?us-ascii?Q?vRuZJdfg4U/+o1W16kKMQJZ/HYz+gq9tA5RVvUZ2a2S5weoxAUpAvCFimZl3?=
 =?us-ascii?Q?Xi0/igLF0hQCEb2MDnSdNuQsLLVYgIKhxC1rYe51oL4+Zv1FmGDx1eWSZLgS?=
 =?us-ascii?Q?/fwyxe0KICaDYGhOhYYZ9hMtF8sz9/JwVbl8OplQVcblMKNFlR6xwH/pXK+M?=
 =?us-ascii?Q?ql7yDQN0cCTBiKcS1DUid8verMJEJf7vFEbicjr0I/akKxTQRd4nhUy4pVeB?=
 =?us-ascii?Q?FuH6Dm26hXZdqnW+0ydU25kglZ1oxFkThHBcwlW8O6U5PhTQI21P3JZ4Vnfk?=
 =?us-ascii?Q?gjHHzAiMgxDr+wZhBBGBK9TkEsr2oY6sVMmyFEr2NGchKHvQDAgZJkx5mg1k?=
 =?us-ascii?Q?3hMSCHZpAzF4wiOQs5UzF8dLCyc6XfxiQP3AhXHUWvqrFlRPoCh8c4Y2oR8c?=
 =?us-ascii?Q?x+BZfx+1uM1BlinwXBPheqsyrK7whfLHUHCAoooQ4NyeQj6tQpXz3Z0ROqbK?=
 =?us-ascii?Q?kG3OEv0O9Fi2bh42BswEdp/yFPEua4e5qP+ZtxU4q8Lpg32jJjLK8d6NyfW1?=
 =?us-ascii?Q?SwgDAuR8w9mbDkAN0K5Lo+PlOFxucjtNAf3TE5t1UL2yCMRQtkMMotMfQZpj?=
 =?us-ascii?Q?Y/YdMo+FEZ0BmcsPEvJkbL8R4QIEY7vsM22HFqmYx+93YRqdlXJ4Ad2qN/jj?=
 =?us-ascii?Q?OSz3dxlehmfxk4yftfOxMFPCM5ERt6yrs7OZwQlX3lgf+z0Rzlmx1S1r9Ni7?=
 =?us-ascii?Q?yto22D2tqwNNBCWZ03baUxrSmfG/8VmqIngH47vkTe2ICpLasIjnPLfOPSVf?=
 =?us-ascii?Q?WaQLaQKRm/W8EnxWHO1wEKcEhroI8p3qgE2rK5LRpsS/trqx9VpZzN+5BzXp?=
 =?us-ascii?Q?+xRP5ORWi/XnjSH5ynKDFhQdDqYA+aDMOTo1IzGq/lKYFnTNg8YKVsrJSS+o?=
 =?us-ascii?Q?lhrMeLwtrA1ZPZ2874eHK9BhTZIBUVFmJ+Z5dyD8qqIgImiZ47LZLfvAwa9W?=
 =?us-ascii?Q?MyR60C+J5Pp0sJVvBaYgVPLRcu6kqcjMLUyxkSqE9IH5NR3p34x6cCOzI6fX?=
 =?us-ascii?Q?DXNFXCnV+DMQ61UhroTjjYGFf2aAhznl7Ah1tHjgxZ8VAW44ztSfyKiXX0vs?=
 =?us-ascii?Q?ViqabfhNLQWfOdWhiO8pXGmBrLrNbwULLQc/dosml+7jn3fJyb/j3I5XtMrU?=
 =?us-ascii?Q?x4eSbILUvh1Cco08L9b0jjW50foiOaj3Vm8x4xvN33DshWO0VNXmeopufn+B?=
 =?us-ascii?Q?K+8Hf4sj3hy3RBSVyOYeF0L7GbRIJtGhw6sq1gXCWXbddOoATRZQWwnlwFci?=
 =?us-ascii?Q?qGO8bHshAbplE4up/kEGQrXJaV6gpIPWTOWXUp+Mzx2/tObPyJznCMY7Htyc?=
 =?us-ascii?Q?DRK7KsriqeJ9XC2FOlFoIKzmRrCPB+3V9XfDlW+QE17W5vWTwwGujcMkcAdL?=
 =?us-ascii?Q?fNN8QEP7Qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a80500-6486-437a-d82b-08da4321acd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 16:21:54.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tonsp2Jz6JFFb8YtTBFsdsanesotTBZdiaJxXt3l81rCjM5ijaaAFoBOHXTXURp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2647
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 05:01:46PM +0100, Robin Murphy wrote:

> The DMA API doesn't need locking, partly since it can trust itself not to do
> stupid things, and mostly because it's DMA API performance that's
> fundamentally incompatible with serialisation anyway. Why do you think we
> have a complicated per-CPU IOVA caching mechanism, if not to support big
> multi-queue devices with multiple CPU threads mapping/unmapping in different
> parts of the same DMA domain concurrently?

Well, per-CPU is a form of locking.

So what are the actual locking rules here? We can call map/unmap
concurrently but not if ... ?

IOVA overlaps?

And we expect the iommu driver to be unable to free page table levels
that have IOVA boundaries in them?

> The simpler drivers already serialise on a per-domain lock internally, while
> the more performance-focused ones implement lock-free atomic pagetable
> management in a similar style to CPU arch code; either way it should work
> fine as-is.

The mm has page table locks at every level and generally expects them
to be held for a lot of manipulations. There are some lockless cases,
but it is not as aggressive as this sounds.

> The difference with debugfs is that it's a completely orthogonal
> side-channel - an iommu_domain user like VFIO or iommu-dma can make sure its
> *own* API usage is sane, but can't be aware of the user triggering some
> driver-internal introspection of that domain in a manner that could race
> more harmfully. 

The mm solution to this problem is to RCU free the page table
levels. This way something like debugfs can read a page table under
RCU completely safely, though incoherently, and there is no
performance cost on the map/unmap fast path side.

Today struct page has a rcu_head that can be used to rcu free it, so
it costs nothing.

Jason
