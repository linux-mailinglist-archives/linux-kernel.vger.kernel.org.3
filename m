Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C00528C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbiEPSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbiEPSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:06:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9B267E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUtBRBL5dS3fKs6QWVd+5dYsQcp+NwAOxIUp9Fe+WT8kTL+lVnQqiXVzx+lmZplrUI7HiqWGE4Fd/G+JDBJcq35ktGlXt75l+RSdY7i806w+pVQ6cKFQOqaQpuMiS/D8uyI1g8O4DKE1fTSfrq3Nov4gGOXZ/edwzKOqfvckSnk0SDL8Xqg7Kpb0bZY9pqus+LXsl1F5Z8Eaaon8jyykC7DwMz0n1CZzEIv2jlN8wSL+pQvpjg4hzC4ugu2PF6z4qtjWQzEfOvhZn+lN2YsHB8GS3tPti9DjTsW4QxM1JUl2w5TB6nGhLDejqh2QVGgpJujKJgC77kL4x8mMon+Mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66lV+vb/k8Zc62qUhTgFEaeEz9WhiKYWzft6P7182Pw=;
 b=LdD0R6z7cWxqZtnb6bmqJdgvmN0JyZy8EDXJVslJbAkv4M2cWVnwgPg9Hdfbk0maRh/sEDeC1pel4pRlJfKdy7gwMkjiv0LbeoyKUp3tbsojz8zDRcVoBxGKhPE59Tw/f7GLTT9v9JngPYNsyhujx0hqpNlxPoMB83+DfrPHsLYqmdtDTwQbXBWmTeobMJVrod+lzToRgMFqnD68OqM6aMzWai1c8BvmkiMZ7WWTRMsUaZP/wEFLzQD0+wEjKvCI+2RGiRoznEIOJM7bgi1cNPI2gH67636DIwSlFIt9Xp6YT80bOvnXIzWyyd67lEDI+3eoPS5WGdLUaB/dGOKH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66lV+vb/k8Zc62qUhTgFEaeEz9WhiKYWzft6P7182Pw=;
 b=c2c6Smwev6H9gawjmDrLS5dhfb7ENjXrzya82PsczfcsDSJuNsIhKovGZszvJw5LzaHJOFE9rMC56TPhzfowglTBM0+9BhR6j/kqAhdQ8R3VHKG8PDjFq5ibHKhxakhPHv8tcmPQbOxCFhwGWN4dCGIOFDdOJba8HUEPd7/Lh1qbsvZGm3vYvnKkV/SCUTTPblA9lBgjB+B1Q/+Hr/ThQOEZ6gVM7t9jlEUc2QM5nGAbe9kQspUI865lPQ9KGqL/iJ7AiRdCUeXNw+04Dk/1oqrXXHpI1I62sCKsK9VVZQoHkcWzTnuliqSWQ+Dl3Sx7+VNq1qpWm3DabL4T3qfJ0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 18:06:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:06:29 +0000
Date:   Mon, 16 May 2022 15:06:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Message-ID: <20220516180628.GL1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:208:19b::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dae12c6-070e-4cc3-7cd5-08da3766cd0b
X-MS-TrafficTypeDiagnostic: DM4PR12MB6493:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6493C304AAA4C469915BBEB4C2CF9@DM4PR12MB6493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmknOjlLMNsgLnOWziVa45gf7kXw/UX2fY/Kd8iH8sKjuzRA76qopFTkvg3CEvyWEWMc0co5loqXCjpoGZXxyp+oHtGOhCeKhw/uSb6GSvo6t4VnG56UldUZMAsqDaD59eNLRHDXndArQdWYINVonqOsYdiQFgjoESWgmhalb0M0kQFYUdoRTDX7fxdhAbeDIGwOxeRUtI0w+T8PyWc+hH1DgZVPSpqW6I6pzxwVSCG/nNhT89gzE+7RumgBOu2utPq90E068cvH/Nc6gnQENJK0BPD7TbNa2QZJ6gmCRmWqRWnAGBl0I80Wq0OvVEC6KNC9BmaZVIzwJx4o+ad6Zm8XqY18l+iQhqoiInTIjPq8uSXXFp5TJ0OlDpXCJpM0cbqiDreXsuISdkwIwug8pK26GxLYwugIB1/QK7OPgj7lE64S2BJ48CApnOx9huw8oPRu9Tcm8HWa+kwzviGCnOsR9Mt3Nn+Y+gY9WnrF4AtfYqfMn85jDucHyxRSITm0WIMlYkp+9mz7EG10XbI7Rn696AUB9JkeDykL4e/EBrYWSPxd4RdhylFurjq+QTODLb3RxpGY9OMwtE7R/GXSjc9mafOw9dYyJ71eOFLwhTWS6wMxiGa/DZ/H+DP31OhUX491BfNkA9c4kEWqhWqLnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(8676002)(66556008)(6506007)(66476007)(8936002)(508600001)(2616005)(5660300002)(83380400001)(2906002)(33656002)(316002)(6486002)(36756003)(6512007)(26005)(54906003)(6916009)(7416002)(66946007)(4744005)(4326008)(1076003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKLpXUm6HRprpPeTnxuWDxIPAE0zlzw6ttilqqjHhFCWg5LgaFt7tUTI1gVJ?=
 =?us-ascii?Q?VNBdCY7uk66ra5F41d9bP2j5x+fv7Rtcr3BPfh4X2Nhcm7z1+GTmtEwLlohk?=
 =?us-ascii?Q?QXCgMzMWvT19uVQn7GSXdeUp0+lv585Sgm5FkXFpNPuUaRS6OeXJt9WahD5j?=
 =?us-ascii?Q?Lrlds2KkVAboZzAhHT0fATlEEWJjovwj+3KRI8PksGqDrm/RTMw2XKyaugyN?=
 =?us-ascii?Q?zh9YYJKy3TZSu2SsJhnMVILoIkCWwqJQMe0tSRmPE2lzYvnV/kfhZfrfr0Cz?=
 =?us-ascii?Q?xTzrJegJrCdPLWed1I30qgr+X+jIqacGRFbk34sg/OGsxb2zPb1564pTP97p?=
 =?us-ascii?Q?AC24l/pJ3rxEngCPpAzV6BZR8Z8zgAI1LpXW7hvY1qAmxQm3W/UVlI/PvIMG?=
 =?us-ascii?Q?53XdXZn3knDAWcz9ZTeMH9mMQBnqGfa2K4RYhpkw5uwYqD46aVl0h0i6P/zh?=
 =?us-ascii?Q?jabxFI8tmIXZUqbzJLDiJ6a9RdScRB6v+zgu7zBrcwaJKWtRZDcirOYN52oi?=
 =?us-ascii?Q?TQLK0mGPpnff/GZjGzxvyNkGJdlzmEg0+jhjqzkw6+azM3b6po87Gx7GCXx4?=
 =?us-ascii?Q?kqVxZVHGAZBR/xz07AMBmx7049tvCIOj94l0nv+RW2xyZ7jnoQJ1dxae1BCj?=
 =?us-ascii?Q?69yQdUlvkhFTgEbMOzwHs2ZM2wpfeUfWz7iv0k1bWqdpOfAt81y9AQtjgUB+?=
 =?us-ascii?Q?ISA/sRx9KJi6iMGsWUHMvY2SYfL1ROFUvTkMhfV1HxEpIiN0IGynee1AqINC?=
 =?us-ascii?Q?J1uT/KiiGDRC5ibWbBtGLYAxml09Ba7c9vOGoH5YjXS9P4iIy62OgGdHF/+7?=
 =?us-ascii?Q?RI5BwnZCX3zql8rFQrq9H+Rt7BDtcTcEQEgj55HHac+pBw5krleMXOqdJbRu?=
 =?us-ascii?Q?Tlu2+aZaJ4iHcCKm/6eixWO0Z0HPhfmnAlHeiLYk070xUlM+meh3iFnju+PV?=
 =?us-ascii?Q?cglI3VhWHgI4O/NVPrnyaaQ6f1YTvIK/CgNHWteZA/pHPC7mcNKfrreVj9b0?=
 =?us-ascii?Q?mDJQEpwNKLle2Hvt56vwGLx3qbZsF7oVrxahYfBiHKVVlJlXlcNZV2Ha2aH7?=
 =?us-ascii?Q?spmTXFooEBJr/iiaTI7IHrZNL1NBCoPBT7XWdvunpPPC2K3LkDf65Iuw6Txd?=
 =?us-ascii?Q?5ObvGjEsw5vFvAmss96j5QigaLvK4mJTlYMzzVSgduxq11sKVH3DP0MNBY3U?=
 =?us-ascii?Q?XIIziZ7xzGKeMojdI4SRQCIpKZFArJ7rLl9NTmV8LNYUJL4GTURJo39FvoGR?=
 =?us-ascii?Q?cBQaF0Cuo8id5rxeP9IdXoN+ZZGUy7vb9iFRqV18HlNblh/rpp9+14iykAbu?=
 =?us-ascii?Q?3mlcJASibrHRcBin0EUQ1V3q9yujxxkq7OLSGUfm8pDSzNgavwDfaTS7bCPd?=
 =?us-ascii?Q?zyhFj8rzn5WQ+Hi0hl5+9fvv1wdYyRjgZiogzGga4bmZweqp2LTw/IJIhvwv?=
 =?us-ascii?Q?vKdLgSYQ8ItUD6LvHMCc0rpOupFkYonor3Ld+QGuk0l9sM1oHA+HUAPQG4XS?=
 =?us-ascii?Q?N9k2798J1t7s14Qi/CQI+L+GvNIg7A0OkYg5G5TMInKVbecJ5yteRZU44QDT?=
 =?us-ascii?Q?7vz1GQgSc68A/2LU8h46izjcK1Xh9LCHdshCRB5qlGrftEOLQePJS6nChFWA?=
 =?us-ascii?Q?thImGG8Itr86P9DGJ/2XG1CP+Ybvk21WP6hdHtfpX2IzinE0y4gcPPWtQ/9C?=
 =?us-ascii?Q?TMuK/7zpqlkwFXriO047DavJUVzz9MdObN4e+cwEPPWiGIz/6CFky0Sigaxx?=
 =?us-ascii?Q?1n2VnyrFbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dae12c6-070e-4cc3-7cd5-08da3766cd0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:06:29.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1xdFyF39tja5NAT5AfhPu5K+WdtEcexwdbs8K1LA8Pie4ALVlxqBLyHHO5SueZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:21AM +0800, Lu Baolu wrote:
> tboot_force_iommu() is only called by the Intel IOMMU driver. Move the
> helper into that driver. No functional change intended.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/tboot.h       |  2 --
>  arch/x86/kernel/tboot.c     | 15 ---------------
>  drivers/iommu/intel/iommu.c | 14 ++++++++++++++
>  3 files changed, 14 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static __init int tboot_force_iommu(void)
> +{
> +	if (!tboot_enabled())
> +		return 0;
> +
> +	if (no_iommu || dmar_disabled)
> +		pr_warn("Forcing Intel-IOMMU to enabled\n");

Unrelated, but when we are in the special secure IOMMU modes, do we
force ATS off? Specifically does the IOMMU reject TLPs that are marked
as translated?

Jason
