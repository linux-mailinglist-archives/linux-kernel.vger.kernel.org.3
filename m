Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A9532B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiEXNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbiEXNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:44:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DC49B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 06:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOV3vWoOvjZiZxxbB8fS9p6UMYnD1Ae6nV2jRYVLNCQzJr8a/dy1mZQwSIMcLH17AGrSTNPdR63dmKz4uUv8sKM0GFxygVVdXVsAqISP3M+4myyDHRU7YgleXhmmg0/GHUSA8U1lE3G1kYma3pW5bby1V0dPoccICDPKG2wGW492409MFeDGLximSGk4B7KmE6NvoQqeZSjvvLtnh3eqdDrBhVxN9gxFDjpxIfDrGUL/KWd7fdHfBv62rgPhXBLHf5DBFz1bjA+Rg4CLUYhJeMlNvRePumRthD/zRCz0xfTbZ5HviDx5hRlWeR/aob4jOogkRm+oN6k9ZPurv1KH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s67stO5lglYEVsr0QqXqnxUq33QM9JAPrU0sw7DgsVs=;
 b=iOdZ3wBoiOg2TNw6mIHAwY4DsHGBJolCsDIUFNNXqOZCWvnou7Q620iJWxDalFF5N/PtNgHfZvlWrENT0GO9xeqlcphFMAGJWpfU6tlRbYGSZmy8Yde37aynbHLF1XNMPCEsEsvTh5p9fRzyCnySqVnH1pfzhPxE9T7QxiG++bsewLb2c4sS3ksFbERQEcybGepX4zIomwaHdJAOfnZjGGp085OLa9YVgFR2u/Mn/dfDkC23cHB6VyIsjH2muAlcigIYOUc8jgOfwc2RdAxGcEGrpT1mk4ElTr+QE9D7FZfGitl7I0JDhpNkwzy8l1q5hibsZ6jpnwLmD/+/MPpj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s67stO5lglYEVsr0QqXqnxUq33QM9JAPrU0sw7DgsVs=;
 b=m2amWpnA5Wn0bL7M8xT2OObsWDD0nfCyZreFLmiPSrlrQcVXOpkuwZtcPWx2BpSTMmcz0alHoSDbQFIAs9w0vxZ5GWlll7vuRYovTAbz93gZaptzv61L7e4n3ucxjhknrqyJuA0tsTgadkp11HjT/TKHuzWOyGtPkd8jiWH09hMxGVHxAfeBlcjSyBe/eub+E18hJtqKrilwl9NDJ8loijGlfqwxfHuCXm+10FDCv6i9/Qdb9S0A3aN8jgelrR4mfAEK6JphN8mI28/7SjLKyjT/0cx7zC1lek61kDReoR2Rh4RDoYMzNiFuslldIAuSKuxAE9t++S6ezUcVVdwOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 13:44:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:44:42 +0000
Date:   Tue, 24 May 2022 10:44:40 -0300
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <20220524134440.GT1343366@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea42f78-2e1b-409a-d970-08da3d8b8e14
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44023B14599E71C4DFBF2AA0C2D79@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+L2TFmbPfnuGCS9y40QVp6nStXkjFlvbELFTDq0+xpvQWiYQtzbJQtaocioXcj0gZ9AgxBepRpA/qo8LGDWHrDwrFIKejP5PBSujZu1ISz2KN8cXOkG4dlgZexmOx3o2YuqvE9Q6dWQVdNl+FLhP3IXIqAvnlJlHsoOQd0yBUJUlDS4OXIHUuKjTgVzQUHuo/wCzVkmObE4L3ZECOtDrqSoEgyXxhMujLepaoURW3Ars/RFX4Rf9iCK+daSjgBsVnSqQf2JGxdsZp5PvroYhSkOFG5bwdIaUtDaV/NlVzqVIi9KLLQ83yrySPfg7V2MyJw+SbjP23SGeVA0iY41oyzWfEAUVz849JVrvuCxN3+yOnwpk4U9L2RZoeFm15lpLLtdROI1NEpj8quYMSZ92DeQ9iR0P23c23flXwpiGk8zhw2Gu1K06vtx0tDHSASAwCaB8FlTYkmx3XhhOHVVgscCTB7t16Q6Wum6a9ycWkMR10LiN3c/+fvIjRk6LQvqaHPlhISzAK3Nhw1UVc/CF6VWFtQBN/wQY2vpxGJedJ7a/EfVN8q/iYQy150mwmzyMmu7up9KrUEMdTmhPNwI0vzz3wTaqEb1lFlGvtVqJ9YfjbdkFRS8XJyuumSthElctCGXKhE0PWqsoGAO1gxSNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(83380400001)(6486002)(26005)(6512007)(54906003)(6916009)(36756003)(33656002)(1076003)(66476007)(8676002)(66946007)(186003)(66556008)(2616005)(4326008)(8936002)(2906002)(38100700002)(6506007)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CAySnsDIcMNFd9VgXBmeTprpHxrhWbcK2yPHKjHQqjOdOr+3ODi2qYhiJPlr?=
 =?us-ascii?Q?6DIg2AH6vwLTaOwG+sCTiaEPnKzOggsprhUiVqigmThK0uIDoeCQayp5P+ES?=
 =?us-ascii?Q?AAVC0PhfnVy/PAi9ARtEidt12E4mvZXku4e6R7QFUhAhnT33mdEhKQ2uWNGR?=
 =?us-ascii?Q?PQLCdnWqlIPVrMzUZurFkDUBLm8+bXFuAEYcOgolNZ5SI68ULWCL/Vz8Iknn?=
 =?us-ascii?Q?pPL2q2wYwUPwumGBurina0yekLWp3508sx6Gc0GGxM4gbXYPM5M6ssrrkFLv?=
 =?us-ascii?Q?nNfGgqPbpcw6CobyEWaEt5a8iLmPHNv+3766uGzD+z79T3b1Gq3zFhsigdzt?=
 =?us-ascii?Q?Yv18t5I4An6o+bctDhgpRJSjeddy3TZeIACaM2IpFB4DrxV7R6uND0lrTfpU?=
 =?us-ascii?Q?l7118k3JJ7lOE+A1velnBkoFXXmirWav/4BFD7C2I+5OJivMQNfdFY5LX+Ge?=
 =?us-ascii?Q?MnifW6Jh0hHymH71eR0Z9+ccwLnaVOJCjk4YgaDWZRMMtXKUeQC/q7904Xyr?=
 =?us-ascii?Q?Z0vwkPFJA9e3lu6PA1+catI1AxhISHRooDJG/flzTbeYcWwNw69E8teO8R2A?=
 =?us-ascii?Q?8DzrAORu0uVaW4/0T1ayVWyH9szEk75Ean05p+kIjfeGkQkofZDcgpswXVwx?=
 =?us-ascii?Q?DanUvkrgeiVFARIa1ZJL6+f8qtOcCyUBRCrz9nDR6eItmSczxkuwwrhOFMhc?=
 =?us-ascii?Q?4Pk3F0E2TLRDTbc4FXovaRAAUKp1knQs/TIUJp1jLyP5UhX04FhV6W4Os6hy?=
 =?us-ascii?Q?CpVlVaRZ0GOFSFpq4G0Y4uDNBRWlmfcYtwjT9gpMsVLRzh8JEO4pcmeH668w?=
 =?us-ascii?Q?zx4c5oDeFjtl8/CLa57jWQIZu/ukfRI0fn7zw4n7UmvK5P6gkOUABkISUnYp?=
 =?us-ascii?Q?XsZflLQRqACNv3tiKj3f8TOsDxaHP8J72ibxy+qmsHT8LNg63NJLKa+NIBv4?=
 =?us-ascii?Q?O850Z8ooLOxXS+n+qBm0ex8OdHuGGWwSNpvXzAre7UcWbm9OT6/kLlN3YhJ0?=
 =?us-ascii?Q?GW6IMYkQI2XpKMF2e9+TLqQ9DXJrYHh11/BD2hvzmmyx1rGhDVUCFp7V9cYP?=
 =?us-ascii?Q?JHDyr/4BT55KgSu0O2WIfvLuAsyRRqNt7oOFRM31dx4ybTo4lDNrIzeL4gdp?=
 =?us-ascii?Q?/jK/UqPyR6rs6ZlRSYgMK+eCwGOANtVMkRS990ToaRnb9yTNTtgKBJvKwE7Z?=
 =?us-ascii?Q?DrKTF5IQoNJNinVHBwnvM1OelHKRPdCowJOVc/WyM+pl+m0dlnRmJNQXqN98?=
 =?us-ascii?Q?mliALDXCLsDpjq+TSvAzae0flrIG/GSWRUISVXqw8kiie6d1j03q33L/UM7I?=
 =?us-ascii?Q?+K/zpX60WNB2RyWboMzTf7d2R6aIcBNir3xA2srgmtYi5Kr7vLke/lT0xKDl?=
 =?us-ascii?Q?8j6Etr3Cn0966fsvt783z/va7tMwIecbz++g9OuULjHm1bzxuWgd0jB142OW?=
 =?us-ascii?Q?VJe1PTexX0geEjbvs8X7FJDeoZjpXn39AFtIyR8AsjV63XZtPNTqCOjFq3Mp?=
 =?us-ascii?Q?FKSl8qUoZ5texmFO2AZXbPF4ZYLmQc0pF955RkdBf3brMNtLHBLRoo6W7jYI?=
 =?us-ascii?Q?3jmDQQyzlI+UgokZq5q44uuWsfk304GG1iwo7LOp+wp+G2xGLlzHQBdN8SOk?=
 =?us-ascii?Q?Ah/N6z8YC3Mohc1X75PM6H/mB7o21tYakwdPtgUS/FerSlQ1/5+1itL0408v?=
 =?us-ascii?Q?BaU1zrqYHNiSwDY/LPv5xonCPcIn7xvaFY0oAhXsurXzUnbcLZLksgE0KVMF?=
 =?us-ascii?Q?UiOirUP+cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea42f78-2e1b-409a-d970-08da3d8b8e14
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:44:42.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lICeNIhcM6aAmZvTVY1QOjDvhLxAhiK0L3HhLL/AhLi8ONts73Pqf+t0pUQeAL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:20:40PM +0800, Lu Baolu wrote:
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA domain
>   type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>   support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>   operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/iommu.h         | 51 +++++++++++++++++++++++++
>  drivers/iommu/iommu-sva-lib.h | 15 ++++++++
>  drivers/iommu/iommu-sva-lib.c | 48 +++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 71 +++++++++++++++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0c358b7c583b..e8cf82d46ce1 100644
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -254,6 +259,7 @@ struct iommu_ops {
>  	int (*def_domain_type)(struct device *dev);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *sva_domain_ops;
>  	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  };
> @@ -262,6 +268,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @set_dev_pasid: set an iommu domain to a pasid of device
> + * @block_dev_pasid: block pasid of device from using iommu domain
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -282,6 +290,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +			     ioasid_t pasid);
> +	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +				ioasid_t pasid);
>  
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -677,6 +689,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid);
> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1050,6 +1066,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline int iommu_set_device_pasid(struct iommu_domain *domain,
> +					 struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_block_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> @@ -1075,4 +1102,28 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm);
> +void iommu_sva_free_domain(struct iommu_domain *domain);
> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid);
> +#else /* CONFIG_IOMMU_SVA */
> +static inline struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +}
> +
> +static inline int iommu_sva_set_domain(struct iommu_domain *domain,
> +				       struct device *dev, ioasid_t pasid)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 8909ea1094e3..1be21e6b93ec 100644
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
> +#include <linux/iommu.h>
>  
>  int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
> @@ -16,6 +17,20 @@ struct device;
>  struct iommu_fault;
>  struct iopf_queue;
>  
> +struct iommu_sva_domain {
> +	struct iommu_domain	domain;
> +	struct mm_struct	*mm;
> +};
> +
> +#define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)
> +
> +static inline struct mm_struct *domain_to_mm(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	return sva_domain->mm;
> +}
> +
>  #ifdef CONFIG_IOMMU_SVA
>  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
>  
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..210c376f6043 100644
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/*
> + * IOMMU SVA driver-oriented interfaces
> + */
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)

This should return the proper type

> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +
> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mmgrab(mm);
> +	sva_domain->mm = mm;
> +
> +	domain = &sva_domain->domain;
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->ops = bus->iommu_ops->sva_domain_ops;
> +
> +	return domain;
> +}
> +
> +void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	mmdrop(sva_domain->mm);
> +	kfree(sva_domain);
> +}

No callback to the driver?

> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid)
> +{

Why does this function exist? Just call iommu_set_device_pasid()

> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid)
> +{

Here you can continue to use attach/detach language as at this API
level we expect strict pairing..


> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->block_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);

Should be the blocking domain.

Jason
