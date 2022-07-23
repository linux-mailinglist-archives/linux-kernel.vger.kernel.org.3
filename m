Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7057EFA2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiGWO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiGWO04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:26:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8F1C103
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5VeJ81+TnNMem/4Q4x0sgw0fw3aH3x74jtBBMsoxpSAbaHN9aj/waCI8oNkL5IrcqSWqaHxSKWiRWSARFg1G4m51uTUXh/lK5JMqtLVQG+9ENQgOOWn/wlutwdQIhgMmX1YmwI+6iK0MIgk3MbD7wHrsJrA2rMJkEtpdeU/AbQkIcCHOFYEnWV+YavY9bTHBxMiQmLVlsfMN7HYh2W9WtbAloJKuvyjn5qstbCUOafBeE68gJ0RsP72WwLOiZmFXqR6wHgLzYg7oXXogQwPlFT7DYhKmEzJD46THkgtN7zGXOtUyH92MXZXnmzFU7pqtapB12MeiCNJb2azpff+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HohITy5mM4Eyzg4iagJODnMJs3tvPR865QKPsqyygo4=;
 b=LP8beOmnKweFNIPFVUlPaYhBEnBlU3Z9f2cx+wuiGBzioKTRqnSTWYaQhDLPMzhgddMet3J23+60Rn0g8ajmOUKZU6o3R/CzQ1WjjfuroQPfEOHC4uhESxLogXnC3zgUGdxFP+2cduvH5XbmxlnGxHVry3O+NronVN7qgbLjqidhDNhD8i5pcnbRtwf2w9I+2yicM2kpwdLlp4K/L5IHoT2DzHtydFyC8Xm9xetBT0lG4VZGrBc5QH2UpYF5ME1oQa7SJt++Bl2xVuLwYKiNVrB41hB0l7U33JAvDwWEw8lMXb6iMgV7XWI5k0YRxZdrSbkKgGt2+CjHJylVi6GplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HohITy5mM4Eyzg4iagJODnMJs3tvPR865QKPsqyygo4=;
 b=snEgrHrKzzdV79cRLc8jYjzJXBMjNxxfcIjp+jaWbXoEQ/EJaBRy7vcbrlvFaaHqwbZl+k8oa/XCxeFtexZUCiAI5cZWELeVWH3MLqcR+ZiMJMom4RuMD5W9SlDw1wBNC7a3KrV1+Sc/uKJAqbfb7FzuiPhb/IbEhb//nlUwS8Gf5hzQiAfsSCJ9WiNdpUQqwZBdVeNykaqhaM265YP4Du+vm7u6BZFU0TIx25kBktMaE3R6Bv76EifyFE7PWFWaGEWaJSWmbFlUaXaUlH7xdW7G0jhZkbyPtRECFiLJwlpo0U3uviuNOpxA2EwqFxEkNHC5wDtr7dLGnqGyY9q7jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1933.namprd12.prod.outlook.com (2603:10b6:300:10b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 14:26:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:26:52 +0000
Date:   Sat, 23 Jul 2022 11:26:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <20220723142650.GH79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c68489b-72da-4a91-2d2b-08da6cb76352
X-MS-TrafficTypeDiagnostic: MWHPR12MB1933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yua+me+0u1dCzdvCsxU7dLLDCDz3MZXACXtz9UnyS1HxYW6i9xvUmCIEvqUfuUdvh3UYiKwi7g94OwaXCKskg/YxRgzoMufo8ocIGVS2BlxEPSdupKJJn02Dpl3vK/mpdIAOE8jy/DdVkALC0zqmx4sVUwTLsNMfIBQoA9s4VoqgMjJI+aNWupnTF6Kuq9OdQvccQHGbRq0tpWcCErxI6PxropN85Tcjc8og63aCU1iIo9G7Y7FKU91YUDj7T6Tpcdt6HdeSUpCRSAYG3GuTURO/KHXB0OVewNJ5Wdmy1WdT5mseJSP7JMhg3Ma812CBPKDCdUa0TiHhThRNb9zfbhYcu7rlwTaLOhJCQRiaTYCmZfMPZibTUe/Nvp0RmlaFcGtPKk/FdBUka8IoeNQSwIW+2FlI64BNiRvlLVvKNRdyDrSWC3U8xLdeRDMmjyfP20+g9+DSZ8HVZVaBKSqrwiZcrTgaswqDdcC5ukUY4Gpo6Y4Hw1kDFkrQ/dj+5GcRb0oX2HkQ5NSxSdtVHeUO5539KGJU9/xcsE4xOVOB2xvrgjoaRZfj2Kl7RGREz5yG5Je+SPlSfO579zzjcQ+NXROYIWKhvoJ6yCz4pSEMkjpF6cfoD145fH7GFiLO9jw9Gtn9cvFuv2kNfcNB1HBrTQbeZdvTxQHoLcOPZRTZXn81Dq4Shgc8cMU03elLCEXOOhFmsLqrs3M+9q6br1GvVPmo+YbIAzwMg/zMnWNJOg6R71UsoZKMkgcaloN0kLYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(66476007)(8936002)(5660300002)(66556008)(2906002)(8676002)(66946007)(7416002)(83380400001)(4326008)(36756003)(86362001)(38100700002)(6916009)(186003)(6512007)(41300700001)(33656002)(6506007)(316002)(54906003)(2616005)(478600001)(1076003)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCeii39+On4Wmojopuq+NXUrpOEsEHA9hv+lj4pQHgN/WO5v5qC+X1QPfibN?=
 =?us-ascii?Q?N7J/iFieaz6SnzXz6tUdWz+U05HZbvnpGQ/A8oZ0TV1x0LUK3JsRitPS8iIW?=
 =?us-ascii?Q?IsdU1PGehi+Gwijl2IeT0kEKjuVr5/7dQeMKNLRUzKzUXh2ETr8dtTqCGoF/?=
 =?us-ascii?Q?9EMUIor3J1umqXtPwSwCVrje7owk6fbJMkdKgEI7HyVFAt7Q6ll34LL4SWR9?=
 =?us-ascii?Q?INQSVHQTVJvDqxSJXHiV6yAmeFPXUsPWpyih+yisIEBsQFnUQnxkMMHb6TFA?=
 =?us-ascii?Q?PQdmQHeoxIm33ZD4ArBjJNukuUJ6j5biWLvwBzJV8rSTlvT7fvaQOCCHNdyC?=
 =?us-ascii?Q?4fhStFVxhPcT50WjGMA4zB+HIERgObe0KzRK0V2dHaFYYZHk4Rjk9L1QeKvk?=
 =?us-ascii?Q?8tOJZcX1igx7iF6bfEEPyxhSlzUBbwnv+tmEiyvKqyL1CtaZYKi3aIhkvyR/?=
 =?us-ascii?Q?zDFGuFJfzuPNcMDyLcQyWj2AbMI8tZyhg1NVrhgp/dfh3y5ep+00ofNPDxkt?=
 =?us-ascii?Q?f39of9dLWQ3KmB5wBkP2+EvkclZCcykF7aZExpL1jinXqwrSvw+kcSWxzh2d?=
 =?us-ascii?Q?CDcLHoRlqFu2g5z9CGgHAQ5oJjzLx/fSqM6/lCeM/btS95sIKX1/gfxfrZOW?=
 =?us-ascii?Q?p8ixaU/ghX9AIP87Vw7ubsBfBoOJXGPvw/M3QsDuneACXzIat6tBu4JPO5B9?=
 =?us-ascii?Q?pN8g4QUtKh5UHWmljBgToEQ+5wOxo2lb2PbPurY2D/b3TkRMe4YSVyTcuOM0?=
 =?us-ascii?Q?kwIZ2npepqtVlPoYCVluyXr/GZw5vsWQcnasYSED6P7JKMFlwbwR0neGWyCe?=
 =?us-ascii?Q?UZkcSVcW07Fizw2wVV37QzqYjshHv+K4w66xchkudfE7A1SSLwmlLdNsIfhf?=
 =?us-ascii?Q?hMjzEMxTg5jpmEfeSv5+Xk4QpHoKXanp6uFAsE14fJk5vdnolihSlNxthsBz?=
 =?us-ascii?Q?O5aRXfSkyWvXCW+Ih0genoFiuljbqu9XlF7PwWawDKIVAlcgMeIXrJskD+No?=
 =?us-ascii?Q?KW6kmjlofM5SllN0kScyIY4QW03OQzSPT/iSM7nLb40yyupU164/8boTSrT1?=
 =?us-ascii?Q?asiL2plq3j+lTgMfYmueU0j9FpPF79t0KUNz8xBuF/MvaMyXN+wZfsGkbnAJ?=
 =?us-ascii?Q?ylYz65M2tisB/s5fRH8dqy9pMFfYYIO0z1oAkLTlxOMGpLjHjbAhLYW9Kreu?=
 =?us-ascii?Q?A429xdJSv7OFBs88H9Fh0GMYD/OAM56Gh9BQ37ndLQQEeLk6CBbK7inZhMHY?=
 =?us-ascii?Q?1hSVKwMK+m8Y1MRnmcs+v8Ewndj2nKJF3ZjIbWvzuc2WgkBjO9WGfLLhdQSa?=
 =?us-ascii?Q?wR02BcdtexkUOPmg914vHosWh3T7+ogAvKNQcZWSsl03iWWj/pIA9dB501kn?=
 =?us-ascii?Q?Zl3g5xcmF0vXBbEAIuBNWKIpwt1QwAu/1x89LQ2f5TaYcDKd+ErWDkiRZEaI?=
 =?us-ascii?Q?h1exZOrMRxCQDag20MvrIGQ523DfqBYTMWYDjN+4ncW73GyoJ+xKYxkdGDSe?=
 =?us-ascii?Q?AEuZfy5RxUtH8HjAKyRuucxm+w94w6mo/kGH9cKL9i7iozbTjjYtENWq51zc?=
 =?us-ascii?Q?e+X+OD2HhrJf/NM95u6/7nSaQvFO/rqut7p5YSOI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c68489b-72da-4a91-2d2b-08da6cb76352
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:26:52.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qa7piW29x+MxalSI4AFvEJE5FNlV9c2B2pgQmiOG+/tQuh1/6NHde8sxyczBKgrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1933
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:06PM +0800, Lu Baolu wrote:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h         |  67 +++++++++++--------
>  drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>  3 files changed, 165 insertions(+), 119 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 42f0418dc22c..f59b0ecd3995 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -39,7 +39,6 @@ struct device;
>  struct iommu_domain;
>  struct iommu_domain_ops;
>  struct notifier_block;
> -struct iommu_sva;
>  struct iommu_fault_event;
>  struct iommu_dma_cookie;
>  
> @@ -57,6 +56,14 @@ struct iommu_domain_geometry {
>  	bool force_aperture;       /* DMA only allowed in mappable range? */
>  };
>  
> +/**
> + * struct iommu_sva - handle to a device-mm bond
> + */
> +struct iommu_sva {
> +	struct device		*dev;
> +	refcount_t		users;
> +};
> +
>  /* Domain feature flags */
>  #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
>  #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
> @@ -105,6 +112,7 @@ struct iommu_domain {
>  		};
>  		struct {	/* IOMMU_DOMAIN_SVA */
>  			struct mm_struct *mm;
> +			struct iommu_sva bond;

We can't store a single struct device inside a domain, this is not
layed out right.

The API is really refcounting the PASID:

> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> +					struct mm_struct *mm);
> +void iommu_sva_unbind_device(struct iommu_sva *handle);

So what you need to do is store that 'iommu_sva' in the group's PASID
xarray.

The bind logic would be

  sva = xa_load(group->pasid, mm->pasid)
  if (sva)
     refcount_inc(sva->users)
     return sva
  sva = kalloc
  sva->domain = domain
  xa_store(group->pasid, sva);

Jason
