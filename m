Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997674ECD01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiC3TKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350540AbiC3TKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:10:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD110FCD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr5rbVUVJDaTpIzoHAT7Sbdrnkogl3U1MoZvgp4b5Bs0vAOoB1RrRFIz848KRotCDFMzCTiYuygvkql2b0JK8clBvNiQGsxsFsFEcDt9EPvZhAiJo4a47mo31wUa5j6KKfLy7eCnHMzmwz3xiCORarbRzdaO0iyTk7FqSw8JarLF4irUimTtGNhbmG8NbIsYk+b2TzVtYv78dBN2Yldi7QUk1rzLXFJprXkdezB++Gp6y1ulOUMkogUyDl7Ap98gk1ICl4JvTiUBCIh5m6I9ZJs7H8j6hVJLWmVPunfdhyLFIRqLL+xidPsEhX/pM9+xbj6Qj/7GKcKVzotvrUandw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqv5gjcvz5P6uqiUps9PKWcqSk0bOyVcrh4gGKGFe2I=;
 b=jJcfGgfUT0RXhxNNUjVeht6qFHQyqBGR+Uy34yWLeC1gvIpoy2LWuoczkgb6m5MXZjz2iOhLZtjFwMZN1c6vSR9ps63Rl7dqEZ0JgEddJkxW141keKuLdQJObx2mHGaTxChWtgRBGXFqxN1nWxJLzFPmd07JwaV0TJTqS5sfKjSyLzI7HcrQcZ7spsMHYxz0x7m8wP0SvacbNB6FP6GcWJyRzIf21P6cLwypmnu3I5ArJQsx3rlrf/Y54x30xuCKbCbu8wQ2+A3HBeEZOMReDZH3LkPhIBwZzO88Id5O3X7j4Wevq7rwkiPH/N1+7n7q1AlTywaVN8fWefG9r6l3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqv5gjcvz5P6uqiUps9PKWcqSk0bOyVcrh4gGKGFe2I=;
 b=NTiv/Ahm4nRpXpyO1JgMX58m7QiLUSq4wNLwCBI20iWW4pLDGSe5RuXWIfZXmNbSLi9wsp73V+6tQH4QI1TvuK+yu6lSSg5S2OORYR3mQdNfeOzbB68e3DB5eAsJZ00laUpFjnHyxBVa9UWgYS8CixJ4JWilLLPv+zd8K43xr27gNGIN8do9VYVmUGNsMa9mMEdSxQNUtcuQH4uZlWGfaDX0TaLKUaHiAZQWrO1x1dyzoWc2o7EQuW7qg70VYP9dtJrCAoNYkys0OdzjbSSCm1KX1Z1IanVyqAlMHDb6DvwcVhGiTvBTA5IplKAsDdrNCAWNGOP3+u5mWH1J6EZe7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 19:08:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:08:53 +0000
Date:   Wed, 30 Mar 2022 16:08:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/11] iommu: Add attach/detach_dev_pasid domain
 ops
Message-ID: <20220330190852.GC2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329053800.3049561-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9718e1fa-9e6e-438e-381b-08da1280bb63
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45210012EF158B5C211B5ED3C21F9@MW3PR12MB4521.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1oRKrVFGFloDhZf7qwEie3v4QZADtTXg8JF38mfU8dpdTziws8t1JMps62euD9HE7IaWgX1j9evTUjpoWPz1xfJr+FAh3bPPkZJaRhsYs0AixzvMfudTpjV3FdE7JlcuImRhj9yzBbQ20szLrcrZjmBZtLh/fV1c51of79HX93UovNNIy8+La/qkH1DcRAEvmysk/ioCyr2JYjIyDX7ADr6ortv7OccFwY81r+J2SXNci3OK8qZcVv9uKC1xEenLdIX5YN+RHrCBfx+ZoExt5BUk1A3p5VKYO2SYJZ95r0+5VKyN43KCnM3p+kZ6b4NWN+4eZYvYGQyu2NWBY48Z6LmsaaZS/aCk9fGmZsSi0H5UZXpfyEpikYVbjy5OWpjOjjZhf5ddkHk2EZLvxAFRsRznR9XB/GtA3vXPYM0pOUdSCfENQOk+r7STpPyOzZ9O9PR+1Vnfe7Lbs6aA5ANZJ/g5oQ4ACOi2OY4OjHWIAetMaKsA9YM/o4q+I17PnFi0ViUay+ucwCyJuS6WFaww5WEO3jeL+4kPVzSshEx1XT0TRqeQ0ofYrxf4tP+pRpovCdqqFiFNzSHgKw7l5mlMWoVKvVi1g/l9j2rGE5qqOqy6mcj7YYZ9FYGOkGw4Yoh809lZu9ky1bOHStaDeKqTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(54906003)(36756003)(186003)(6916009)(6486002)(26005)(8936002)(66556008)(8676002)(66476007)(7416002)(66946007)(316002)(5660300002)(4326008)(86362001)(6512007)(1076003)(2906002)(2616005)(38100700002)(83380400001)(33656002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAzJ55vkt+XmcjHzKHpWhF5wF2yaTjKmPngmFfMDw9ko4RYzBKzqZQS8ENJB?=
 =?us-ascii?Q?UK78WPrUYbP/80ApAyQ8DIuSOxEd5xsvyCCIodVz2ebinnC+KZqMFZZhBQei?=
 =?us-ascii?Q?P2OYTl/6QcuNDzeIdL6pIG7t11ikoeZgQVccLJd/UdxbaPyDNrociJZxg9Mt?=
 =?us-ascii?Q?+yhamin7R5JKqgVUsvZyWRN/J1dtVTUWVbTpojtC0sX6kpTjO0m7az3rItCu?=
 =?us-ascii?Q?+oGD4guW+s9JxdquIF5WnktfF4rkku4j/vpfz1kwXAcal9F8qZKuilm1d3zR?=
 =?us-ascii?Q?KZ8wbL32XoplrswSPU8tDio8xgBPntx2fKL0BKJH/925gGCfPXbhVp1xhJov?=
 =?us-ascii?Q?8cF9jOtwsDiPaX/aaT2cx2mcEmaQ5shisbgZ9A4CDUWdPCmpUenz1CqRz9hO?=
 =?us-ascii?Q?9U0GWhWEwSDCBR7JAZ33yGsy9MmhLGjlumEJCFa/ECOj0+OkQ0unpvT7xJOF?=
 =?us-ascii?Q?T3GmZ+ClV4xsYZ91GalCXdi6K6bzRbXT6QZcUstXWJLewVbMC69xUosNEaYL?=
 =?us-ascii?Q?773O/yE02hI6Kq5UkQ2oH6rWdHPcsE08eCd9AIRhHJusDP6UMRski2DRYq7f?=
 =?us-ascii?Q?NPVes+8Cfm21c+FnzoPf5UwxDMC/oOk4UYN/d172y+OKWdAo7f7Q3t9UoLuI?=
 =?us-ascii?Q?FGfIgBf1SZ97nnunFSPeRMf4VeYhiGRj5gJXgzAjDS63vRwoS/xbTu99XLc8?=
 =?us-ascii?Q?Y6bGkH8GLAPN0F0CZQqbU1cssaQERujgOgM1TdGbDtQMBst4VhLi4aImP65r?=
 =?us-ascii?Q?WjFk5JhRSmquZ6+kCBTke6RVnyCPn6j9g5f51qk1HzDu8gACEJPsqRXBdkZR?=
 =?us-ascii?Q?/a9N6jabKz6fdgdqHGIQtlyelsSw+GbfyWOd0gMW9M14q3WU1yidUFEFXm7f?=
 =?us-ascii?Q?rmTnVgC2+UiaP5io64N7KGNbz3239lW2mtpKLrMYagp9aQIdwA/mAUAByR14?=
 =?us-ascii?Q?hcNNq4WslptetUp3kLSbvViYTUwFizinIMyYpC82BEv4WCF3yl9BD03BDxdI?=
 =?us-ascii?Q?GzTLjJXjogLoKQEfc28QP5slXIzeWBcuNIiswOEZE6OjFux5TcxjZECjkRA6?=
 =?us-ascii?Q?Q7LFk7DY6HPyw0M14OnqOpfYQLaXkgAZ+bPD8OzO+f8kRo2Z1R4CzPSOscDo?=
 =?us-ascii?Q?5/hj5GLK+YE6CZCJrDNH7INecibx8Se9dwjYv1d5m78qdn5Wz5K3bA3xh7bi?=
 =?us-ascii?Q?/LKwMab5KRAnCX8wGOEn7Z70MZEZkFjbWiHWEVINHViwQ8jpCbpKVp9MLtjd?=
 =?us-ascii?Q?JGdXXP9Dk6Kye28VHxt+vIvkDbChc6Ua6EuD4/OfyAKoNlwG1sdyr7JBGblZ?=
 =?us-ascii?Q?2OjgRH+vHHo4mUYTKYwB/j7RWq1RxAD5kQQtCUVUccXszYvfPm42ST/4bNuh?=
 =?us-ascii?Q?uvCkudnAVSoaOhQjy12bPw6mFhBTNROlX2AFRNXPf6MqbfwY7rJEf1rx1BEE?=
 =?us-ascii?Q?FeK55iKeZNUnVxkPQUSPtKZJcTrsuQoKGqtR9utTREp/x+9g3UGbae6DHen7?=
 =?us-ascii?Q?b7shXm1US4/MHPC+XmUs+Ojtjh1nAGbWJ8Nab6ocU5+AlmpM8DHk0SBPpw12?=
 =?us-ascii?Q?H6pRx0MsbHs+i5Q+LsXgFcJJLG1eEnCZ2rzaaK/9LMGaCFWtD5CoptWoD1r7?=
 =?us-ascii?Q?nSjuiU2yQfw9sNSWRRLVp3HEs9fc1i9lot3GjloatFkrFTeymbW19s36E5Nd?=
 =?us-ascii?Q?1nx3n5rCscDdFB4K4Obz2RAs52Tu1Ryp1DNfkqB5dEEhFBSZn0EQl0xQ/Yvu?=
 =?us-ascii?Q?v6ZPJnhHXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9718e1fa-9e6e-438e-381b-08da1280bb63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:08:53.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /65X5hCBKAUV6PVpkOHwgwPX1UwT5T7ATnOOXYrsAvL+wPwk5RkCyq/iAKnMGnx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:37:53PM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of common domain ops for this purpose and adds some
> common helpers to attach/detach a domain to/from a {device, PASID} and
> get/put the domain attached to {device, PASID}.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/iommu.h | 36 ++++++++++++++++++
>  drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 29c4c2edd706..a46285488a57 100644
> +++ b/include/linux/iommu.h
> @@ -269,6 +269,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -286,6 +288,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);

ID should be pasid for consistency

> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EINVAL;
> +	void *curr;
> +
> +	if (!domain->ops->attach_dev_pasid)
> +		return -EINVAL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * To keep things simple, we currently don't support IOMMU groups
> +	 * with more than one device. Existing SVA-capable systems are not
> +	 * affected by the problems that required IOMMU groups (lack of ACS
> +	 * isolation, device ID aliasing and other hardware issues).
> +	 */
> +	if (!iommu_group_singleton_lockdown(group))
> +		goto out_unlock;
> +
> +	xa_lock(&group->pasid_array);
> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			    domain, GFP_KERNEL);
> +	xa_unlock(&group->pasid_array);

Why the xa_lock/unlock? Just call the normal xa_cmpxchg?

> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (WARN_ON(!group))
> +		return;

This group_get stuff really needs some cleaning, this makes no sense
at all.

If the kref to group can go to zero within this function then the
initial access of the kref is already buggy:

	if (group)
		kobject_get(group->devices_kobj);

Because it will crash or WARN_ON.

We don't hit this because it is required that a group cannot be
destroyed while a struct device has a driver bound, and all these
paths are driver bound paths.

So none of these group_get/put patterns have any purpose at all, and
now we are adding impossible WARN_ONs to..

> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;

And now we are doing useless things on a performance path!

> +	mutex_lock(&group->mutex);
> +	domain = xa_load(&group->pasid_array, pasid);
> +	if (domain && domain->type == IOMMU_DOMAIN_SVA)
> +		iommu_sva_domain_get_user(domain);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);

Why do we need so much locking on a performance path? RCU out of the
xarray..

Not sure I see how this get_user refcounting can work ?

Jason
