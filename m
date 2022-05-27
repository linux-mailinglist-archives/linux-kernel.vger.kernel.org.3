Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0853646D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353382AbiE0O7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE0O7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:59:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357D02656D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJt1jug1KwHBs+goEuBHf7Mc3vx7tedZtca0Jld9JvgHbLzHrOlKAnMyv1AIeIu6hKgLJmLfAJECTq+dMd6tIvyqgkisB/V4qgz+/8GCCGId3SPHG5sWp6VGYFuqhQXRrWoeMSbhAdE7gS54H8QCnAqGmRhsJ2omXgjUsCbYvaXupw1XN6BeHMzsKr5HuuN5Ky5N7DVMpKtbrlJXsNLc9uaXnH39UHB32DGwwCSC+UxAdFi+XtvBPKdo7aiO6jGpfKS6p8GD5bYm38sgY5dryWM6SGyYej8yiJUvSZLPkgNEYWtu2sR/6Oeyv8FrQHknBB46qVFOMiLxzOQtVTofwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27q5Fux17/VrD4hiGLrDOjBk7RhnI5z/QeSr0XM9nYw=;
 b=PBFXTpYwLxwGKAQxv1DLkmj+bLNSP1jV6ZzjedKeOrTTl7+PZS5taoq4GDnJ45dyvD132F7rjQgRqMnJJjZnpIGDXAS77D9ZPw2uvVfuAwKrCWAVjoIRFhHyde2tKDkWv6DY5iqqJYtMu3KwQ+p75L9wBscJiY4OL11liB6ZIp5zZwkP88jIP2L6lm99IZsMnhr7t5pRxImRDOpCvqIagbvf8Jb05f5/qerY9AoiUNXxOs0e8rp1WsEA0gYPk+4+vM3zzY4pIP63lT7j7g56IzII6W38qv8Yb/NftPBnjFiFVuh/BVePqirZHLaquPbQtLTt0a0hAdfEYdnUZNpg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27q5Fux17/VrD4hiGLrDOjBk7RhnI5z/QeSr0XM9nYw=;
 b=EOM3E1e0ugEKR50eRed0mrdqUu7qXZfh4E5RR8a1sh6nMUVezW7vDBwk9vEAhRgwzqNW/eJURc29tuuYNjuBT1lgdO4PjiX3EJAeGy1k1ufdAU6d3thh+sqZaJJGpdy3b0NT6S2kyU9ImA3UL6fSXlPdgh1yCoGDD1pQzB2gJWb9byAc2NtmxmOVXucOU/JCB+nh44LNSKXb4CNwb+gF6sWbxlZlCexWTMKU6ilZ/D8I6gmC6juMbpauQRMpUYbtn7xGMbmKolcYFiTkk9Pym65roucINTlB+WoxrjIkq1EGxwmVuy8wqJdoMVuuCe/zQmcvLGHWBH+H2yBrilVQgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0084.namprd12.prod.outlook.com (2603:10b6:405:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 14:59:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 14:59:11 +0000
Date:   Fri, 27 May 2022 11:59:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220527145910.GQ1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063019.3112905-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 277ca796-bcbd-46d4-8e27-08da3ff17565
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0084:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00841558FAFF1D45FED8690EC2D89@BN6PR1201MB0084.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1Zaep2ZHh7WNYITEKSlS3bwsCGzSnU2pTHCIunCeABv3hPeONRhKgoCAYoFKg+U89uvFD6uhDo0jIuzOBkRo7xxYRSytoOjcwBM0ItOKORomUof6c3N+vcimRw9CB2t5B9gobeoImGaBWMTDbmWPAmtHvgJ4aKoR3YhjdTZiXZhrQRARMQzNR6TMsETQBAA2W0ubKc91maih08Dp3c6JuyREewqXksBrtxSfvr6BSF+/vuRkGgY4A/lwrMYqbq9JXvFrH0PRBaKHkat66kymbb1+AwJfU9zEIQcTYjhGbLNoEpjXsxgjv1S4g7oSYG+GWfuqNpDYuXR9QPgaIqHtxs1xGqxbYFccaZiV7eUm7FGqn7tUEE4riFGu/0hc0SD1O5QOjHYlcxAgO27CriI1ecK3REE3G/fIuIwW5dbT7DIdAS/xXGskwSWjJO3gzD/6hgkc8OCj24kRFdQJT9EA8NVNRll6B3g7J2T42pW6LqsYMzogOcr06pItMFPaPhPj2LPGbd7jY9uLRnC31G265Fk2ZUduOsJXNyRFYEa4XQPyLxSlvnzvstWtLcIVta5EFsEq9cvja94oIjri3VtFSQ17zrZb9M9H519PUsI8oq1Ih7VAAQs1e9wU8iVVJybgjO8bJDRZKtxCkG5qFJnBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(4326008)(8676002)(5660300002)(6916009)(54906003)(66946007)(66556008)(66476007)(2906002)(33656002)(36756003)(6506007)(83380400001)(26005)(6512007)(7416002)(2616005)(6486002)(186003)(86362001)(1076003)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6q5EJGD/l9K25Vfa+gXj+X4ib8GCqSLlzVs88Nl6aO/MZj2TzjdwGT+gm6iX?=
 =?us-ascii?Q?1727harNMwSFB6d9Wv1U8WkuUO+0NubCwubw4WBbEHbEjqsanjJOsaHzEn7i?=
 =?us-ascii?Q?r6DuVfLMy3+oHbMmVbFBX9ZQok5PKETjttnMBCelJOIch8EvQmIkCcY1Kimx?=
 =?us-ascii?Q?xlIMA2vQBx7MZNBLyRYq9ACT4jitqlOWTNdIkQu5C5At5DVhYc48L296zBVy?=
 =?us-ascii?Q?t7a6krSts2A4FE6OhNKHrLKD2iE2OJxAP8iZGrzec8eiYnByc3qjEWOdGjXh?=
 =?us-ascii?Q?uj7+iuVmiWKLbfzI2S56/4l1lGcRR6ZWJWQLeCltxxUDKBqCARlW1CQLAtGA?=
 =?us-ascii?Q?1xxv3HvfOM4a7iRoc58yMYpF6YUydHqEEeyMkMt7A7ZG9hSy6fKi9EJ16wXm?=
 =?us-ascii?Q?vSO/HWXR070sZBaXQxuayCB0KUuqTHC3cjbgCdEKC04o89dLK9LhGf4mowmO?=
 =?us-ascii?Q?lXiSpnVIr4CM0NrYAt/pl5zU5itXMPBe3AE7HeRLANk0zGjQtjRNcvEtwmci?=
 =?us-ascii?Q?SX6JWyWiAMKitf2DsgZAHSXVrn35FlrmPhbYsdoIFQS7MHzBLZhTA8pAS8ej?=
 =?us-ascii?Q?APhtvGxn2kkG8DVGrAYOqXinxniOu3Go7YJZQFSVDMzqeSzQU6BY3leU9SNk?=
 =?us-ascii?Q?hZf6grQ2fhEBY3kRiAcEv4hEBu8VHT/XkaI01co74CcHk0R978YsHBYKY80z?=
 =?us-ascii?Q?0BVSiSDpp2xpJHO3aArCQDvDySj1d9rTD632+PT14JDSKKvY/3iziwb/WEkP?=
 =?us-ascii?Q?7ya96Ru7B3UupStygD0if5iSvQKsBrJkp7r8h25cI2rCgMl/0rppZyageqye?=
 =?us-ascii?Q?BVeUlNlitfsFz1OvH6J9UaF5OJX7qtwQYwMLwB2EZitBTxtmMq42l3tgnl0b?=
 =?us-ascii?Q?mNBHCchtXkEEc1LVNTUtCxKdv9m2VOnqUgq+WvFLZAmCe33vCYzqwFCg7Okx?=
 =?us-ascii?Q?NbRQaHUA16dtZ6TdsJ/I6B3V1TEb6x4OQdXSUXyqbUQvXZcJB4mCX8UcOCxh?=
 =?us-ascii?Q?8fR4IXwwy3+CiCUYgJlWo1quwmiHIf0Ri1g3OdtQzyZVnoLth9UyfSgEy+9J?=
 =?us-ascii?Q?DhaMU+4RZgpnxSWkmoJej5WmzzzLC9l71Q5DjNSMCZTDiL0YbGOxK3PugrRn?=
 =?us-ascii?Q?gxU/APly2HuujG0q6o7KNg/K9V2CPmEWNdB93X96VB+lcxKuhw26oUI3wzv7?=
 =?us-ascii?Q?31ZDT6GWQ23scorabha1LmY7DbIdKN8q1ZaRrVMhsQ6OnJX/E0MTL0oiZinB?=
 =?us-ascii?Q?S5lCZ4Ewgkpf5y68GE3mxzgktbg3YbK6kd39AZLzpBpaLd+wuBI8FCQWsoAh?=
 =?us-ascii?Q?eBSWl7uddNFSsWsBLY0PVY3BCsDWUHqLcSomhCBWLyPve+OtReg06LneTn9L?=
 =?us-ascii?Q?XuoaBscOmmJAGuS1lveWz9U3RhQE0jxb1HK+5Z0s5s5K6W0h74LRwbX9Dei0?=
 =?us-ascii?Q?QXiMh2nDBoXkgDmoC75kh54s0c59jnAQVPBSdVbvjRS1iVvaPcPA8/9ETTIL?=
 =?us-ascii?Q?T0fhGNy9VnkJf5ZXBxicqfKPxbSvsuP5tLWYjE2pb6wvD6iMZ58yQSatEQr4?=
 =?us-ascii?Q?/nBeGfUrlYzLrZaky6ERnrL91+M7Th5RBfvi3tqpst1B50yV0PSS/tSbyPi2?=
 =?us-ascii?Q?cgixu1TzFzCr5ht8LxCKlR724xyU5Ou+jqnejG1cEVT+lD8nuPcMOng7NbtT?=
 =?us-ascii?Q?ZM2umDQbfQO1HhEyPQDLD1xzshLJVQupVbU5Hq5oSFMbOtPqdaU3OU456QW0?=
 =?us-ascii?Q?tUtxCYAt/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277ca796-bcbd-46d4-8e27-08da3ff17565
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 14:59:11.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9kiXHXBcZRBTBCqeD4dh3Y6+Xi94vdK4QjR7d2XDPLl4kro8dis1smDWRWZvUBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0084
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:30:08PM +0800, Lu Baolu wrote:
> Retrieve the attached domain for a device through the generic interface
> exposed by the iommu core. This also makes device_domain_lock static.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  drivers/iommu/intel/iommu.h   |  1 -
>  drivers/iommu/intel/debugfs.c | 20 ++++++++------------
>  drivers/iommu/intel/iommu.c   |  2 +-
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index a22adfbdf870..8a6d64d726c0 100644
> +++ b/drivers/iommu/intel/iommu.h
> @@ -480,7 +480,6 @@ enum {
>  #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>  
>  extern int intel_iommu_sm;
> -extern spinlock_t device_domain_lock;
>  
>  #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
>  #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index d927ef10641b..eea8727aa7bc 100644
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -344,19 +344,21 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
>  
>  static int show_device_domain_translation(struct device *dev, void *data)
>  {
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain = info->domain;
> +	struct dmar_domain *dmar_domain;
> +	struct iommu_domain *domain;
>  	struct seq_file *m = data;
>  	u64 path[6] = { 0 };
>  
> +	domain = iommu_get_domain_for_dev(dev);
>  	if (!domain)
>  		return 0;

The iommu_get_domain_for_dev() API should be called something like
'iommu_get_dma_api_domain()' and clearly documented that it is safe to
call only so long as a DMA API using driver is attached to the device,
which is most of the current callers.

This use in random sysfs inside the iommu driver is not OK because it
doesn't have any locking protecting domain from concurrent free.

Jason
