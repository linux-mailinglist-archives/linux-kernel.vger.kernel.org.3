Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E334AF31F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiBINly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiBINlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:41:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C5C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWDOjsaEWy9DL7/2zVwnOvzf+cnKcEzwKXezHP2ea0DLsqBFJjQ1iKI9zrn+P/4mPWz+6UkDPyzK/zFDnx+1lZ3fJ5gZQknnOJVn4jw3jN/fxH+nFQJiNDoQDMfZo5qf/aEGRktLNHfOCOp6ZpLCn13OkGXbnJGQ9vRSHflSUNmqsE6onyH+fPFVY+gTvTLxyE5BF/2r1gnzaap4HBwXAPZ/9AScR6+FEGPq6BUeTlFkJR28vMVdqaXlAbSv02vf+NBJ/N/OFMQTAePLPrDuvhRLlj0r0SEYQHQ4eUFzBF0vDBeVPD8Isk1kPJWxwgjhCpF7jZsiC9426B7ZDa379w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbw1qmh8WqX8/qdUZ0hYOeIeE0V+AneJEMWjZvL76k0=;
 b=VgV+6jB3d197s27ktqEa6l9HriY+qoGK3ytKLPAFqr0urkwoyesFLecFKUI92TcpAQu97QI84OBUNHhZc94ePOvGrnjfOm4TT7OUpa1Y2M31SD8WBEo2ErFFtMqOuY6QdPtQhYryKiFiExoSG/uCsmUa1U5COQBzdDxjhGUJFjPf3k9BjgjALt6Xbam4SMRtPtRVRMby/BAvHguN2Y3OYY3+5syhuiUGMVO9nNdlbD5H9tJMHnHraYYF2VP/OUEixQzTx3ghdfPbaXVnDvV9QJKUTMkfJwxTMvUFLbH9qqebgWwOg3txzC/ZUkh+XW4WMD+0NklQAtQVaD8rEmh1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbw1qmh8WqX8/qdUZ0hYOeIeE0V+AneJEMWjZvL76k0=;
 b=ZGGnPhZ5KoB72pmB8w6lqrmMli42Qjde0JGS5XxWdYU4Ov2VUhY1XN9Tq7beUDxilcGpsSdGN5jRwIMCnbxPXkhXjNjMHQOBrpo1WBuuqoRD5OqsY+Q0fN6a4SjrP7cIO4qNX9uUnBR0tWTrV+G275lVN8c3u6cXbyRRYDJ6xIpvhfXrLLMYIZx+k3hoyvqg6HNCKVd3oi4y1cH4k8nEMt1uAlUy+lVBWBK4Jqfl5ttsrEOb35DP43o1i3GBf8HsQg62xGEnTSqjrrobXEC1OTnLnnHpC7DXQ1wygAXDREsDG4gYH/UBbzZLTYMpuSi8Wlo3ombE8o+AEs0KxCAuYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3712.namprd12.prod.outlook.com (2603:10b6:208:164::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 13:41:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:41:53 +0000
Date:   Wed, 9 Feb 2022 09:41:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iommu: Use dev_iommu_ops() helper
Message-ID: <20220209134152.GA4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:208:134::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ffb4c3-8ca5-4c47-1491-08d9ebd1eeaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37120F213146DF0389A60F08C22E9@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaHbv69B6zcbXS4Sh0yTwtpiOJFirNCZ1+Z7BarK+f1fe+FuOxxMXOPX0NfdVHGYgvQWlhJDpBoeX8beKAZnQ3sXNLxNes/UBhMSamGkTXodH/cGabkUaLaqlaK0JTJPDO8ha4mhqcQMdHgTTh0+BvoZnDnTbJ44cd3v0xfK6Fy3aDZb/RgIl2swsvD6PWyJcWX87BDqR7/XCAPAS2dZT8znBTyx/dzzPbED4vUjY8rCWb57TC4wv30QCPWsVIWgnAKQIK2KKVVfvwngE8zKVwniOZ8K4g6TYV6rhGubcoFXILt0x2rsPr/s8p1ZcUn5dWX/PfPQ6NE0ittvn3442GuUbao40pqOlu9xBNKE5Z05FfMNMqaqoidLLphBmiaCVYmS1k/0NywMYNCv18uEtSa4mkn4yauv23GYHxFKcJqWqxMy59XOvH6jezC6B2j/81MKAZzd15yYBc6XZ9b1CZ8YH/cvfgoFvlTaezk7byeSBi1s0gRxZFcWlLb6IBmvHMLtqsA7kNV2IsUvHB4ewE8HgZD7tcp+coA9WdcbRyNqa37TDBen+cvxEgq/eTP9lRu1OipYvI8KB8qlhmLyNMKuyFss/8PvmnwR+kUzJN/8HZytwJK0kkECSjxc4J1yXNGWqF55ACWAnShdgNdUhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66556008)(8676002)(7416002)(6512007)(508600001)(6506007)(6486002)(66946007)(6916009)(54906003)(316002)(36756003)(2616005)(1076003)(83380400001)(2906002)(186003)(26005)(38100700002)(86362001)(33656002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YmN7AF0EKfKmdm93w0DN/F5e2jSjh5L8SPI8JA0ak3xaZGzPjVDNnVTPZZE?=
 =?us-ascii?Q?fFddNPDb19i4kJYldNZizHCX0+0Y7u3s1MUDtKZytS9CLsLKJ5JvEEFD0+5B?=
 =?us-ascii?Q?QyzAew4Kx6n5DXOshnA1L2t1y+DYV6x3RqZH87nLu77wTURuCV7XiMz+mOME?=
 =?us-ascii?Q?WSQ1bBTAZE/8rLGNWoXIc4BySJ54/QjrGPBvG64Ye3Wi3UrMQvvTldIqyIfS?=
 =?us-ascii?Q?oKg1UuNfnpWlPQ3ATZGPKxs7AQYSxzeW5zTAc1qrOzo69XQ5v8ycNs3fCsqd?=
 =?us-ascii?Q?bnNChTcWvIEqFHgViBf/5uryrQMx9NzGT2T2zXLGBSYcWUDPYEU43KaUh7nE?=
 =?us-ascii?Q?oHJJoEinLY+1lC3zf1e5NW2Zx9tsiOPUSTl+lWYqfTFvF0ndQCvb2ZeuU1N7?=
 =?us-ascii?Q?K8L0RU91VY75D9SADcxOM/fLFdR1PhOA1oTKGO6pncY2Qi0aspC0uwMzQcbt?=
 =?us-ascii?Q?ELUhj2ltvHWF1mdW3jEIQACNmJH26YEFW9zLJv/YRt8MJs01nhYtv+SVok9t?=
 =?us-ascii?Q?hyJS+mzhPOjYfEET3h43Sygfm5nMjv7azXZDwowcKI4rrW6j5bdW4AIB3zyl?=
 =?us-ascii?Q?QkogWoEHBcgqmeVcvIWOPuGr6BIyb7cApkUPqwT2XfPz9xJMbpjksB77A8fB?=
 =?us-ascii?Q?PwmXKbHAa9X9bOccR0qOf7lf0hu+9wrgXC9LlPWTY+Qv915gSiaQj00Plm4u?=
 =?us-ascii?Q?X+xslVq2waj5ToemEt09pfroizXX4IbJQ8x8klcWB7f9o0GVpKnHX8gEh66x?=
 =?us-ascii?Q?9J4rzna99hdPMMPbNwDjxf+WAH0TUJjKaOYf2Ek0C4dhumjNwOSN5M0s+saY?=
 =?us-ascii?Q?33x7phvdCLmQU1ahL8jZXLH7ddg6zVTObCc/f0t5RmN1nQAZY/+UVZDOfiG3?=
 =?us-ascii?Q?w90O61Om4bBMi93dXxBR1pr8ddkEzfX7wOJCNP8kuh9wZxDJwlg/O/fVSKr3?=
 =?us-ascii?Q?/u3fLWm+TO2DpCn8yBAEnEI07BK0R4X7lMFyp71e5znWD8jN9EvYyvblWKwV?=
 =?us-ascii?Q?y60s+Ia8ZItrObISiL7Btu993MFB6tVx0u0LyAwwCTbej5iN6Ct4AXdRG4rl?=
 =?us-ascii?Q?zNL5LlRSqsbTMjsAgg7Vmv/tOUBZ4OJQVBB8vIx+2m6X0tpnHZtkbnYWZ5rC?=
 =?us-ascii?Q?WVcLB5r7YVXrgyDbLZ4UfX4CRf0gusyPlCnOjcdaSM39Dp2xgSomAGmUvKP9?=
 =?us-ascii?Q?GAapZXJvInBrUjaa26F7ltYPPM2SGfNtquVa+qjljoRFmIrT9fpBsQxuhDLw?=
 =?us-ascii?Q?lhBVD6cIVbHmV/5tKFe4own159T/BMkOqGBkMwGTYbeib7tQ2jeN8FjeWzlL?=
 =?us-ascii?Q?NrytDxqtp55CIidm4qLXKPx3RrppIMNvlryuea4TgNu4HBVF8R8DX1wxPPPC?=
 =?us-ascii?Q?JJRBV8NrBGpHv+UslY03zVkwKT1WeXHZ2ZM/iTvV6srLKidmaPcf5/WhRQHI?=
 =?us-ascii?Q?umAWdT2NDLflEdkzn6qqo16TkZYWBmOCavjhc6m3ZDdsNlysxljls3ByaR1p?=
 =?us-ascii?Q?qd20PNA2G4Fwjpn62/OzwPP/Jj1Jl4aUJdiwC/57LtHBcXnXpG/fDhRapik3?=
 =?us-ascii?Q?NbXKB5potDM7D9+sXdE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ffb4c3-8ca5-4c47-1491-08d9ebd1eeaa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:41:53.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +peSEKA/iLJPddqSb8dFU468sDFUnE6tEBxQ4ekslAhD7Mz3mBCE8ptfRalko/HL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:58AM +0800, Lu Baolu wrote:
> Convert all the feasible instances of dev->bus->iommu_ops to
> dev_iommu_ops() in order to making the operation of obtaining
> iommu_ops from a device consistent.

Why are there two patches doing this conversion? Roll this into the
prior patch?

>  void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	if (ops && ops->get_resv_regions)
>  		ops->get_resv_regions(dev, list);

And agree with Christoph, don't keep confusing ops null tests -
dev_iommu_ops() never returns null and any function using it must rely
on the caller to handle this, somehow.

However, I wonder how safe this is. Certainly some APIs like this one
it is fine, but I would be happier if the 'first' APIs like
bind/attach/alloc/etc fail silently upwards. In many cases these APIs
are called based on things like DT configuration, or VFIO or
something, and the caller is expecting the iommu layer to do all
necessary validation.

> @@ -2788,7 +2789,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {
>  	struct iommu_group *group;
>  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	if (!ops || !ops->sva_bind)
>  		return ERR_PTR(-ENODEV);
> @@ -2831,7 +2832,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  {
>  	struct iommu_group *group;
>  	struct device *dev = handle->dev;
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  
>  	if (!ops || !ops->sva_unbind)
>  		return;
> @@ -2850,7 +2851,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>  
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
> -	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
> +	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
>  
>  	if (!ops || !ops->sva_get_pasid)
>  		return IOMMU_PASID_INVALID;

We all agreed that this sva object will turn into a domain and thus
all of this will eventually move to domain ops?

Jason
