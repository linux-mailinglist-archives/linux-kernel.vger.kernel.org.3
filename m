Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200B523638
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiEKOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbiEKOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:53:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4F31D866F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjV1tNhTWlVGIHMMW6puIor7nk2LSwWbZaTnBbVdUH1lprMMgi7uE+F+Gts2VvVW3oUT1wgKx76N+JTY0cmICUoA+V0Ko0u9ti9+SsToDM1KzB4WY7BoqqQtqF4TOv6uXo4yOlWKc9XlbZhfbzaosJmEjo/KIxOb0AR6UqYXuh+1UeRWm/NEa6E1knjAp/GQ1Zkxn0mXSbDAifmQA5mY4fCztrVHHi2nhmmWKAOKZlx0pLwtmN8WW7Sava+Aa68Jhh+/9M+8jJ+nxe49tIqjIS6NwLBG44pJKKppzvw3BNibbvpoQWWPapubzVcqPlssas6QLVLymhwnXVrBlS87og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfZ97WX5jgaTd1qnBFHgWoG9GhqCC02fX9pYbKIjwSk=;
 b=hcr134TbjscO2LQLy6zYCMWRqGNCk3fsoRKrQRvvwc6OkOYLuUYQuHvsi5fMxJhP9dGSC61/NQn9pvKy2A1VjQl3QIccHRp1IHdfHiBk6mBpiMIfD7GRLdGB1mj1RVs4tZxan10SY7C+6H/mSNF/NZTh5Ohj/Z4H+IL+bjmw/3EN/ylrpBrzOc0YOI7MXpn815TQg/sSSriF8dSW8cId14vKP2pd6kjmKW+g3ylcVEjXLgISEx4p3vFONDf8iqUq3+OVDGxkuzlC/iOXq8M75gycoqJ4DN9T2jb9g77E7Cx7++84GMKbu7/+nMF/KgClUWyLvTs7ovHNeBtsRDS6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfZ97WX5jgaTd1qnBFHgWoG9GhqCC02fX9pYbKIjwSk=;
 b=N0BMJ6u0FQCEpFiPJAy9CSRlcNDA9pu5dcppCkcpDgQN5HjvGGCil/dbJBPcN8zYdtHye/hf5347QrUAoAVm5T6dXoMu5Ss1vGsgJhu/9T8iNYU4bFuDrWQB110OjdyRXvPan/SM9OooMrQ8PzUF+CtXQa6qrS7PwxHuUQ4EnPeMcFD9Oo/Ba80l8ghKOTaxoWg4xNk+GGsAK9DABtqlIjZY7LkPt1uqq2GSQ/QuiC6PBNySWGiRn5laVm7cqq0IXUATxp78w6A25JdnqN0jxcjIcDxcNE1svulq/L6RacIyLmN2Up7PNstTKPv6ki+GX/7ZcxO2K0mrnrA5PeS9VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 14:53:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 14:53:20 +0000
Date:   Wed, 11 May 2022 11:53:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220511145319.GZ49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76c2e0df-201f-4101-8035-08da335dfd5a
X-MS-TrafficTypeDiagnostic: PH0PR12MB5433:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5433D8A278BED04FEFAD4528C2C89@PH0PR12MB5433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eiz87vfBU5lme74XO8v4bHvk5hV5L6SHFAUE+LhaqwSYnnU62wvl55jqK5t0Iaq++A8ssakvY9ebwY1e6wFWeg88AdezIFOMuWt9tZA7eq0VJZY/SjKO9D6nN2pggTrXxByKeAb5JO9AjKVh8B+xwzg8wN36IhQOICBRdBTYTH3tIBy0h8leI1FjF1CWj/+4BtFuJ5kmRU8R/XE1r/InKPoghFe5L+jMd+xdLhKVo4uwAkv31wXILY5shW0vu0nrtPAbMEFrQ0UztIC38txWZBxMoxKcpnsS4QtzRRIs3b7cTlXKQSuwHp0RLeeHFvXFFdNZXdvisT2wAiD9qNCZ17jsCCb2UE3nY7OSMUdyNH45H+hko5jm8rkfAsuxHVJ0flqgwiEucKSh3+FtbDogTvjQ/UaN5ZvdQnCcATlnNDNNKDCZEibWSvA/Uje/e5OlwiHuuZ9LUM6FOt+XJYoT1pFnAGpAlZxHbwYjsSA5X2QlShGRoGYt1ytif3RXjWzbBZAemaGYU+ZrBTSrTwBEh72lNkk222aK4s4Bc0guBOMpUKp2FpRjuck1hhKop9yX3/Zuq84XQjL/fh3RaNsWtF4WhAqZ8swYIISKfOPZJkHTTdo0sQe59vEk16nhtTl3Knv94FCOUUWfWhe5bgRTiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(36756003)(7416002)(2906002)(38100700002)(5660300002)(508600001)(186003)(1076003)(33656002)(66556008)(8676002)(66946007)(83380400001)(2616005)(66476007)(54906003)(316002)(53546011)(6506007)(6916009)(6486002)(6512007)(26005)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5++rWblHDAPTdnvYZV/HZB+EYVrN2uUYS7mGDGjijO81Z+0sNmQHC9iAT+fl?=
 =?us-ascii?Q?Ibhmh31zJ+JuVBEPelXqiqCFK9WEPo9bOjkLmCO6fPcHD2n+0iB8690buhVP?=
 =?us-ascii?Q?Bk6yUw4JMD6bUPiTlV7WvnOgtrVFKOjU2MAbMjI9/Dk56ZHHZKoWdbzMDT3i?=
 =?us-ascii?Q?hC9wh1G859BeoH4U14XjbZEYSclL2ctM9AvN8OyLNdvLWiZzDzTIpgg1PEqV?=
 =?us-ascii?Q?gztVpKksEw6ldTErQzvbg2CUN3R/CuwxHEplTN0P+ul3liOeN3aDLnJlq59h?=
 =?us-ascii?Q?hxcWCfYidWVkdFIOCYmQAH3Rj9MhwJ8zjL/ePDuWn66KsELJFoX75QkRhM7W?=
 =?us-ascii?Q?T8PZ1CB3rcbYLFmftbGyEyi8vsjVBc3xENg4kSGgGYdOQRZm8jqjdTDEXQZN?=
 =?us-ascii?Q?QV6WT8yirRicGdpUSDMXonSohZuVu6PZ1Jdx5ByswEPo8rXpfLIUg9ygAU+3?=
 =?us-ascii?Q?hO0V8lJbgg5IMTHcVVF3JNL4ayNlWOPM0WdYikH2992mmC5z4Vkj+YFiv8QT?=
 =?us-ascii?Q?fYu/RHfvbADZMqmvNpJ7YX0Pi676yXT5Ym8Ghe0TaCxk/RzWnq5Y/kxVK/7Q?=
 =?us-ascii?Q?fqEuZUIKGP07TL1OW7usNsXPXlCffseMNDudLT4caRxUgmlZQuXrX978Qisl?=
 =?us-ascii?Q?fYmuLjrakMYmPROxAf6weDI6T8NcwkPevl5fhwixuCvr/nma2CMd0NFFCao5?=
 =?us-ascii?Q?Nu8eooWdlCeLnQ8FlXqA7F5IbSrHxh3nFNKfvfCljT1M+yFSK8AJVsYq73KU?=
 =?us-ascii?Q?qN+OOan5EopUEaGLCtZ/EblYq6/eZFx3yJQF2GUib2pnZ1UAQ0oI7/r6zv8l?=
 =?us-ascii?Q?u9Zco1XrfiGFWR1H9mj/i2QHHnhTHFPj+Q2MMl8Nh5lKHgAU7OqLXaSNf+xg?=
 =?us-ascii?Q?BxgGTMjt0qaxqIdnIh1gybD/6nXIBOFrkSi9IOtXWj0uUtUeuJY6aU6Vc9tb?=
 =?us-ascii?Q?rMwLaZ90/JCAEiBLnJQmKQv+HCQj/zRkV+yZaEbjDZFPjcLZx9WAaVArPJVO?=
 =?us-ascii?Q?YQX/C8FOC2iZUG+m7IPxRgPOQXoTsfDuYUtQ3iXnPnScYuJM0kLg+kjgGkqB?=
 =?us-ascii?Q?BNxqkFWl5nrVEwqlZc7lL8oybKNFR1qFxvhNAYaETpr2Nv9CM1MvnYJ2b20s?=
 =?us-ascii?Q?/X53tuHZ6IF80D32VFjJez4MF/cLIWynjKD82IE3hv0lq/2+tGqPT3SU6iVE?=
 =?us-ascii?Q?wgmdh1F3r7fIU3zogdFIjZCmI64zjd2RVixXl2ZUV7VsDk0aQq/2qdJxjqN0?=
 =?us-ascii?Q?OtKe7pE0Zpb+6RdtK5itdS0chD+3NtoOaezvlGsSY31Xhmr5IHnr3kDjru3R?=
 =?us-ascii?Q?ublPjSn89d4oQJ/wDfop3HIGEc6RkQ/wUczapobFE/4SXJj1UJbW2tZpOcay?=
 =?us-ascii?Q?nqigYlr+zrZgoY8zup8iTOVn9mjdXb2DzJGT5XDjgxoambkERY09tH1dLA5O?=
 =?us-ascii?Q?pJDmeZZZfHAsdcpG59mlzHCVahbq5Xcknvri+2UxmtCV73hxTp8/UvSeCzZ0?=
 =?us-ascii?Q?5IOZYRfgSN+/GeHseLNoS4Xrm5Mk1FpaLaz2w96XHXyj7NxtrVEyTEdat5Gc?=
 =?us-ascii?Q?oC6qFPdYSqczW/GO0gdJ/Kiy9ggIuUqjOwR8AaV+09PHNJLV+Xo5XXwJyTng?=
 =?us-ascii?Q?Jd+hPweqDjuAoNbfoTC81v1uQ8IQfXt1zZDdmnGJnC3Pkpg3/HUekwgIYENE?=
 =?us-ascii?Q?IP+OJ9Yw4d83gGTZenSPUcVYE17ur3uTRfRjIgQqyfB88e9NpnAQWxm4b6et?=
 =?us-ascii?Q?CYQVlC9dTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c2e0df-201f-4101-8035-08da335dfd5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 14:53:20.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+VYA+TeBZLwUi//247HZYBHiMwv5FF6XWSk5O6uLCR/faFUz3LQSoysIWgUM5hF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:21:31PM +0800, Baolu Lu wrote:
> On 2022/5/10 23:23, Jason Gunthorpe wrote:
> > On Tue, May 10, 2022 at 02:17:34PM +0800, Lu Baolu wrote:
> > 
> > > +/**
> > > + * iommu_sva_bind_device() - Bind a process address space to a device
> > > + * @dev: the device
> > > + * @mm: the mm to bind, caller must hold a reference to mm_users
> > > + * @drvdata: opaque data pointer to pass to bind callback
> > > + *
> > > + * Create a bond between device and address space, allowing the device to access
> > > + * the mm using the returned PASID. If a bond already exists between @device and
> > > + * @mm, it is returned and an additional reference is taken. Caller must call
> > > + * iommu_sva_unbind_device() to release each reference.
> > > + *
> > > + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> > > + * initialize the required SVA features.
> > > + *
> > > + * On error, returns an ERR_PTR value.
> > > + */
> > > +struct iommu_sva *
> > > +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> > > +{
> > > +	int ret = -EINVAL;
> > > +	struct iommu_sva *handle;
> > > +	struct iommu_domain *domain;
> > > +
> > > +	/*
> > > +	 * TODO: Remove the drvdata parameter after kernel PASID support is
> > > +	 * enabled for the idxd driver.
> > > +	 */
> > > +	if (drvdata)
> > > +		return ERR_PTR(-EOPNOTSUPP);
> > 
> > Why is this being left behind? Clean up the callers too please.
> 
> Okay, let me try to.
> 
> > 
> > > +	/* Allocate mm->pasid if necessary. */
> > > +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	mutex_lock(&iommu_sva_lock);
> > > +	/* Search for an existing bond. */
> > > +	handle = xa_load(&dev->iommu->sva_bonds, mm->pasid);
> > > +	if (handle) {
> > > +		refcount_inc(&handle->users);
> > > +		goto out_success;
> > > +	}
> > 
> > How can there be an existing bond?
> > 
> > dev->iommu is per-device
> > 
> > The device_group_immutable_singleton() insists on a single device
> > group
> > 
> > Basically 'sva_bonds' is the same thing as the group->pasid_array.
> 
> Yes, really.
> 
> > 
> > Assuming we leave room for multi-device groups this logic should just
> > be
> > 
> > 	group = iommu_group_get(dev);
> > 	if (!group)
> > 		return -ENODEV;
> > 
> > 	mutex_lock(&group->mutex);
> > 	domain = xa_load(&group->pasid_array, mm->pasid);
> > 	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
> > 		domain = iommu_sva_alloc_domain(dev, mm);
> > 
> > ?
> 
> Agreed. As a helper in iommu core, how about making it more generic like
> below?

IDK, is there more users of this? AFAIK SVA is the only place that
will be auto-sharing?

> +       mutex_lock(&group->mutex);
> +       domain = xa_load(&group->pasid_array, pasid);
> +       if (domain && domain->type != type)
> +               domain = NULL;
> +       mutex_unlock(&group->mutex);
> +       iommu_group_put(group);
> +
> +       return domain;

This is bad locking, group->pasid_array values cannot be taken outside
the lock.

> > And stick the refcount in the sva_domain
> > 
> > Also, given the current arrangement it might make sense to have a
> > struct iommu_domain_sva given that no driver is wrappering this in
> > something else.
> 
> Fair enough. How about below wrapper?
> 
> +struct iommu_sva_domain {
> +       /*
> +        * Common iommu domain header, *must* be put at the top
> +        * of the structure.
> +        */
> +       struct iommu_domain domain;
> +       struct mm_struct *mm;
> +       struct iommu_sva bond;
> +}
>
> The refcount is wrapped in bond.

I'm still not sure that bond is necessary

But yes, something like that

Jason
