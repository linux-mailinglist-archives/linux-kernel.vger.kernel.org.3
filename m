Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BF4B0B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiBJK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiBJK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:56:14 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76271008
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVQ+wnP8gxI5POHQOyGATzCZuyaaJ7i+na8temlj2Sj8B0gBrUk7SFXKXxe0aKmRjuXzCTs1JO1eV+vXxnzfgYtheXSD4CGl1hu47CseVOkphjUJ8cu+/lVkrBwhBz1RNK/re/rzLDKlCn50ksIOQ1iSFTQyrSOf+vzM9douH4BdZx9wJ0ltn2fwr9lKEvknII0HUMjiB+PiqC/ZM2dGYeg3YsDCeU914hVAUsOv0HdzrS3cIjFtDAQJ4X+A8/swcJZJb94ACHkt9gFPm7SswIv0ptAffgfX4IyNWncnK1EqEc60MGShcYSOCkmfolQF/4O1zNbSKMcVQ1rDtGHlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag4H1VFrJjRfxOy5JvMEM+Q+U/NlkfVgNPrcLDz1DR8=;
 b=axZlSIMPqYrQKcrVkssqi7Pc9IG0sgzx2cnzaJh/PQXxX19/MfSoINGB3P8lFZr+3XLTcf/MhSYPQJSmfYqqK84c79+/zQ2pVU3sl0zMwpnOciiTMZcAbDHz82TFbwWLsPtnhVCa7pmVVx0GCPpACgj840uLqGv9MXpPDnACTQBkHlFP4ypc0kLAmXIQ5rcjt5fugYvtcMAqx7W4puF1c3yNiSNpo0ceWCVKxjhO3u3yAGjfuBCkimYHKUKS4IiCMCHx3QsF/oyHhsrNApwOQEQde7Zdq1AXrzqsL6Xs0fIzHQz02Xc6p2EqVyHKZvbGqV6sIE8+S9pqCt63Ioy9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag4H1VFrJjRfxOy5JvMEM+Q+U/NlkfVgNPrcLDz1DR8=;
 b=CiUxiNanCU3WzPK7pgz7x2PUFOElSJvGWnE6/71xamtooFi3klDw01rW6zqTuWQ1vw41qLxb7hHCOc81CpUCKR8huQDdTjaoKHKtU2yPYba/dd9pYu7bnK0krkblMzP/Lrb9eUVsZz7QGIYesr4nZ2sh554SrFgRcMG79lqOQefQrJGlHiVkFm5NoYlX1SWg2ktd9i6+lLhgxHKVRi2u4WlcPQbqfJ0i4zicL3bjAwmw+mS5rd+brh8lJ4rc2atrzmWN/wU35g//9lS7o8/5RIVHmctZ/fpAK6mu9A0WrJ36O0nRbrWKDm8AN5tKFwv7BtfO5Fpez5v9Z0HdvmsfPQ==
Received: from MWHPR20CA0031.namprd20.prod.outlook.com (2603:10b6:300:ed::17)
 by BYAPR12MB3223.namprd12.prod.outlook.com (2603:10b6:a03:138::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 10:56:11 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::ce) by MWHPR20CA0031.outlook.office365.com
 (2603:10b6:300:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 10:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 10:56:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 10:56:10 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 10 Feb 2022
 02:56:06 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>
Subject: Re: start sorting out the ZONE_DEVICE refcount mess v2
Date:   Thu, 10 Feb 2022 21:56:04 +1100
Message-ID: <1873253.3FHD7cURoh@nvdebian>
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150ddfd2-cdf3-4084-5dd2-08d9ec83f31b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3223:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB322377E7532637D6A05E3A56DF2F9@BYAPR12MB3223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dx1/xQHl7FjgVb/X8zA03zgxAIpXM4l/XS9C6ibWPaATsU6uG0Siy3lgok194X1tGtLsTD/HDVNAyuB7e1N6vwsL/qTGKSIXPuMdPjS60Ib3BLEjb8qRBW+YP25PtEMBouWxvRXsQAOit1saOyrb3CjMeJYZSlALTIECR9zTLkQqzNAoF+/XjUGgwIOim85X+Afm4eQo6J7WCSaVuHcnv+qq9GYB7dP5seWG18JHqSjnjMuhGgUKL23TQ/uUjeIquYXs37yTESi4Xpza4f+32yqN5g/Qs3PuhtA04mGCMOgSSLx8INEzhyRIq3AtsYXoh3zle6trSbKHru1MFm6L0t1y5ydkvah/qxuxS5YPH+zw0l24wDbGWuXkKSCXpGXGqkxMfT/qRBpEm3pEeTaG7plZXpVqkQj2j+t3eHMJ3ov0V6B1hIsewLvYbeEsp1IpnChcqfCaRI2heW4Fi4f9vaNaiQL6H85/N9cH/79KlgycR0S4tCTsm6ayFyj97NKofQ9Ny8oeaWx7V3ILn8Wj8oHjvusAF7bGzgLIGHA9wh3SCxBKhOm8jcR13BDDv8KKab5PxAvcvtxTRAciU/aqdEa28Cfif3zY7ZCWOYXK9P1VEA4ra0oJZGrZEeviZWpbeVy0svT8aEjcYPRj+4KiY4WXf89KWPvphuJMzPlWCrxPVWRnocMCfyc5zFgkxbmYQxQNIZjNj8T+HOwfCpdOohSRc2vwJdEOCVEHBG2pTkmbhtUx4eMv322Z0hRxaLzz
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(83380400001)(81166007)(110136005)(356005)(47076005)(5660300002)(9576002)(2906002)(336012)(426003)(186003)(16526019)(26005)(9686003)(54906003)(70206006)(508600001)(8676002)(8936002)(82310400004)(36860700001)(86362001)(70586007)(316002)(40460700003)(4326008)(33716001)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 10:56:10.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ddfd2-cdf3-4084-5dd2-08d9ec83f31b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 10 February 2022 6:28:01 PM AEDT Christoph Hellwig wrote:

[...]

> Changes since v1:
>  - add a missing memremap.h include in memcontrol.c
>  - include rebased versions of the device coherent support and
>    device coherent migration support series as well as additional
>    cleanup patches

Thanks for the rebase. I will take a closer look at it tomorrow but I just
ran the hmm-tests and they are all still passing for me with this series.

> Diffstt:
>  arch/arm64/mm/mmu.c                      |    1 
>  arch/powerpc/kvm/book3s_hv_uvmem.c       |    1 
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |   35 -
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |    1 
>  drivers/gpu/drm/drm_cache.c              |    2 
>  drivers/gpu/drm/nouveau/nouveau_dmem.c   |    3 
>  drivers/gpu/drm/nouveau/nouveau_svm.c    |    1 
>  drivers/infiniband/core/rw.c             |    1 
>  drivers/nvdimm/pmem.h                    |    1 
>  drivers/nvme/host/pci.c                  |    1 
>  drivers/nvme/target/io-cmd-bdev.c        |    1 
>  fs/Kconfig                               |    2 
>  fs/fuse/virtio_fs.c                      |    1 
>  include/linux/hmm.h                      |    9 
>  include/linux/memremap.h                 |   36 +
>  include/linux/migrate.h                  |    1 
>  include/linux/mm.h                       |   59 --
>  lib/test_hmm.c                           |  353 ++++++++++---
>  lib/test_hmm_uapi.h                      |   22 
>  mm/Kconfig                               |    7 
>  mm/Makefile                              |    1 
>  mm/gup.c                                 |  127 +++-
>  mm/internal.h                            |    3 
>  mm/memcontrol.c                          |   19 
>  mm/memory-failure.c                      |    8 
>  mm/memremap.c                            |   75 +-
>  mm/migrate.c                             |  763 ----------------------------
>  mm/migrate_device.c                      |  822 +++++++++++++++++++++++++++++++
>  mm/rmap.c                                |    5 
>  mm/swap.c                                |   49 -
>  tools/testing/selftests/vm/Makefile      |    2 
>  tools/testing/selftests/vm/hmm-tests.c   |  204 ++++++-
>  tools/testing/selftests/vm/test_hmm.sh   |   24 
>  33 files changed, 1552 insertions(+), 1088 deletions(-)
> 




