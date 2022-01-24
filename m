Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88E1498705
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiAXRg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:36:59 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:51616
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241255AbiAXRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:36:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx2u7kjkQBX1urU9GVYfeav52pMB8ceCRrDp7fO2YxCZJFSCi3HPnSk7iH0kJG0rKJfTChiC8rOB6JlCL4vMlvmRZCQiK4z8efTHa18gH2jqQkWH3DDUV39a4Xisthm29VFg9eZSLQwaVg4eVPs0n1LcVBtPZdes6zbQPKoTElqLtNOIUqrK0M4TgMqLKPRPeXKsvHn9+74rt3Ghql3reGnzTLXJbuCcKi0RY/9GPMshVmHyAvkLA6X49jrwdyKfod4G7lKzXLBwhKzISUDmNv487QYwQaxQRR2dujJuDe02w+PTwGN/hrxN3MnBoOiv5ekMHEWpStB8ezwvr8dxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juK4jNss0MeSUeacM1m7QBBO+6FKncgRrKv+gltCN0U=;
 b=fI96dWcVvDuCbs4kJPofpXC+pg0TsZ7SvVRDENODmkwnWeuv1NfepwEjRlkGN58qaRHhhT3UWQYxbY3zqWLI6ML56bQ30YBlZDHA/FLMEBvzbE2al8uWRBI4REhYLcXJ0Kt5s0OYhnkxu3LvkMqD46rRu3JPxpvgrFtskRIpeERe7+NBCjRe1fm1R+IMkEzlRBz8xNfM6Y6jDf9oMgV9RGTAWuOy/wXQu/woOJ4TfAhV0jxxtYG+Nf8Jrn5adML+mXSb5KcY2AI9C/z+Zlv9B3S8VMGJO8Qsa1TP/Gz4zOkvo/5pZVKGayu8WuS9x4xMD+gasYqaBwoinqG+RheD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juK4jNss0MeSUeacM1m7QBBO+6FKncgRrKv+gltCN0U=;
 b=By/+OkUBX30bCE0WwPvDd8Ukp9FV6dPBmiFKpf9YNAX1sk30uzaT+LJvy2+jNp7nmgSeHsjX11zmtr5gvbkqP928pyzU8NTDw1/4F/l4rW3/vWlMyJYf1uiYQ631MQZMgQs6Yg0/RdA2NGDZ7irdqERjlyHxoDTT+Plh+L/NcK3739F6p175eUTAxG0OiLGeoswr5CX/FurocvTAhwzCk+yZrnlLXVv/CdyTh7lHzpOcTDts0/fJM3svRLlvQ4SKjtIyTEOyBjlaQRJkvrJGE5EtezBVbqo6x3aJQxNQDGfxsCHcPoFcRnZfI//1IPafvg7brmWRPErKdXamKPq9ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 17:36:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:36:52 +0000
Date:   Mon, 24 Jan 2022 13:36:50 -0400
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
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Message-ID: <20220124173650.GF966497@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03acc031-3229-46cf-1999-08d9df601b90
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1414198EB4835AF3DA9ED804C25E9@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/a231KnX2spazIXn9y3TuZC98KSgh/OxWwn2yq1e4f+WsJFj81dA70CrkIu/x2hQlR5ysWYz5utXhsat+Ff2fYgbfnLHIv0pYIDAy6yx7MNyajwt2X+QkYwpmxMKVtaAtMCwhChD/UbAnrf+GTNDkdtMsSSKxNuRQoJwNK3HK2R2+xxWp1wGb5M2uTH3W4kz6RA073fwImFSkwZx9yiYhrxOy9kWRPi0h7kkpwrZPKAMWKaos2CUmn1qIq5r3fUZWBhN5JuynonfFRFtJkm2OPR+foXo6SVfKnDjH6ax9D5fokoNSB0OTX2c1s2T+2yBw7NP4b4FRWzbwYatdi9RPj1dymNdBAt4KAv5CgdC8Fb46Hd7tgdQB8ClsQKjvEnkEykEg45M5afuD+DsPVWBJNkQ5rMjqxh+kAVo4EfSmCMkGtUfxRvZ85M3WhzHKBuNEE+V8/7cgEup1OUAV/01n5m2X46ARMv51YDm7R62bj2VCfsjnAYZVGzI3ZjnskqPzs8ifFs2YNEVPJE7GL1ZfR7OEUZKjixUofxiJeuV9fbXUQbo961u3RrUUOHVyn3pwRPetHRwXVt6QsvxR65By2xxn2cwtpuZJCUrnSPvGURuJAIueOTMyAnnc5RiLwEyQGKM/3y6mLEEA37WmSUzX3ZNvdJi6BT1awg2TAwDB2tNdGkvRa2LJx6mrUVIREHQF1UxH1uQ3O/49YCyACMvA2gwGYJrn1Az7JbnTsx+ZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(186003)(36756003)(5660300002)(26005)(2616005)(66946007)(6506007)(8936002)(33656002)(4326008)(6486002)(86362001)(1076003)(6916009)(54906003)(38100700002)(7416002)(83380400001)(316002)(66476007)(2906002)(66556008)(6512007)(508600001)(27376004)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQZMnTV7KzReyomG2/k3bQJ/H0B/3ZyI2vPZsw7vVUVuxX8laqb1L5/y0FkH?=
 =?us-ascii?Q?IZq/LtV6FMY/y4KJhF6XetulaDdGsJkLDPzyQgtDky6ncabZrUw7Gxv/puWl?=
 =?us-ascii?Q?3BFOMqL7ti4CFxax/GVj56SRmEen4oECnKzW24NJZtZtMqYZvDLnuaJKHCtd?=
 =?us-ascii?Q?kZURLptSZ/s3zWxriFeINvWe7aksvCJ9XoIZVV5/vlUb+08QHf83KMo2DHc/?=
 =?us-ascii?Q?ssa/7V+Qm267by2Y/Xwx3LQqLQjS28UNxg0QGJKE4TJGI2sje46kmiLy06Iv?=
 =?us-ascii?Q?TtK4MJj8iFKQeDuFtF5TpI3OhQfKl+lQUTYYmpDH923jziTUTtFzW4j9WBMz?=
 =?us-ascii?Q?PesYAKeWhAgAYRGZdDFL+MXgPjIQYnTOpAt3FVYQIltFgQZGDrL+jXBwD31a?=
 =?us-ascii?Q?nvEJCMvIZWATqmQRUrkA+6vaXiQS0Ui3+rkKIuG+vv2faoKTDzBHdN17vRYm?=
 =?us-ascii?Q?mgO8JguUwQo73/mzImT8bN02cgaasBHOOWZyvPwGE6wIOI4r31AnJbx5Ak6D?=
 =?us-ascii?Q?NrYSfc8Moo5n5RujNKWV9kWmKBF1kzWv4z+z+EmbR6UsUkZSBNFITjX3ykxi?=
 =?us-ascii?Q?DA0G4rMHxPU14BH9refbVxi+jbL7QDqREq1BRxb88LyYfOTyQFNdGzHgw2wh?=
 =?us-ascii?Q?Zu0gftYLQ4v7Q2IUKwlvkglA5aL0Sp6587A4YE0eYnWcKTz5QxcETDZ1n6zD?=
 =?us-ascii?Q?HwE53nAG3nl7t3feWVzuQG+0TxY8S7Woov3syvWrxMHMKeF3nbJ6puo/CDBk?=
 =?us-ascii?Q?R6VOngYVxgtyPyIepW8fxyX2gMTu4btmi1Btj2BFA7Sii5LyHhJJ408VAs+S?=
 =?us-ascii?Q?aibtzXc0y75zt3ExvFpaqbd2F7WZRWrGyaLUQCV2/Has+xfGIYDH0K0jasDk?=
 =?us-ascii?Q?4uvgPqRfqYDa1KwMwhJn5t3WwY0XgA7JZ2sSF/tRfMewiXLFE4k8+88eT3pu?=
 =?us-ascii?Q?gDvpyxSCceJ6l/XgP2hYEsBmtxVlB8tdAGrEFK0rGpsnxK1bWjFDSCYQApwn?=
 =?us-ascii?Q?2HZICuWRk394d1M0M8yBucDzo+93ujlYYbK2Pq/f/xtmXwsJbtu+3iUR2xvU?=
 =?us-ascii?Q?fnij7hyXmgaO9dnh4toNlHztMPnflDosMssjnW3jJ1p9BdIEETM9skHPIy1Z?=
 =?us-ascii?Q?JyiZbA86GVm3wVt0vz2QofcXkCzklTb1UyG7H3mNK0AO8+D6ot9tnbN5VC/Z?=
 =?us-ascii?Q?74cZPJbkbRlAwX5J2dPibWR/f1hzveWDXIfhoombRJKcm0ma8CuqIBfOPgO/?=
 =?us-ascii?Q?PpW5LcSpjYN4zyYMwKzLTfWpcPHVThO63q46UPRj+f0tpGhaU0bB9cMqROqg?=
 =?us-ascii?Q?gKFvsutjjyXdpkPK0X57koR9+eorlRJYrmjKl+yF7L2M9a4V74dkSCpdNxWX?=
 =?us-ascii?Q?gvcyIkM2ge9bwtHoaDxxjLnEMGm3qMvgEI5+lprc0NwcDme0NwBn25OFj4mS?=
 =?us-ascii?Q?k1Iv60ONfKW1nq3AgJcq6BQX8PzqDINldIVAnfVXXgad5D1qX/JCitkMYh9u?=
 =?us-ascii?Q?qJ76MkdBns58eHY7U1tyn/D8JjxuPLtcJblFiedhmnUv5Cgt5N9MBt8MWhsF?=
 =?us-ascii?Q?epCFUJSb4JFP4BkOoYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03acc031-3229-46cf-1999-08d9df601b90
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:36:52.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkK2s2Ika8W5k66U/o+epyw3mLDmgbQV/f1RQQE1Y1iNdn1WJx8S8ZOi4thwWUVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
> The common iommu_ops is hooked to both device and domain. When a helper
> has both device and domain pointer, the way to get the iommu_ops looks
> messy in iommu core. This sorts out the way to get iommu_ops. The device
> related helpers go through device pointer, while the domain related ones
> go through domain pointer.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/iommu.h |  8 ++++++++
>  drivers/iommu/iommu.c | 25 ++++++++++++++-----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index aa5486243892..111b3e9c79bb 100644
> +++ b/include/linux/iommu.h
> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>  	};
>  }
>  
> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device *dev)
> +{
> +	if (dev && dev->iommu && dev->iommu->iommu_dev)
> +		return dev->iommu->iommu_dev->ops;
> +
> +	return NULL;

What is the purpose of this helper?

> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>  	struct iommu_domain *domain = group->default_domain;
>  	struct iommu_resv_region *entry;
>  	struct list_head mappings;
> @@ -785,8 +786,8 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  		dma_addr_t start, end, addr;
>  		size_t map_size = 0;
>  
> -		if (domain->ops->apply_resv_region)
> -			domain->ops->apply_resv_region(dev, domain, entry);
> +		if (ops->apply_resv_region)
> +			ops->apply_resv_region(dev, domain, entry);

Here we call it and don't check for NULL? So why did we check the
interior pointers in the helper?

> @@ -831,8 +832,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>  static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>  				     struct device *dev)
>  {
> -	if (domain->ops->is_attach_deferred)
> -		return domain->ops->is_attach_deferred(domain, dev);
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
> +
> +	if (ops->is_attach_deferred)
> +		return ops->is_attach_deferred(domain, dev);

Same here, at least return false if ops is null..
  
> @@ -1251,10 +1254,10 @@ int iommu_page_response(struct device *dev,
>  	struct iommu_fault_event *evt;
>  	struct iommu_fault_page_request *prm;
>  	struct dev_iommu *param = dev->iommu;
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>  	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  
> -	if (!domain || !domain->ops->page_response)
> +	if (!ops || !ops->page_response)
>  		return -ENODEV;
>  
>  	if (!param || !param->fault_param)
> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>  			msg->pasid = 0;
>  		}
>  
> -		ret = domain->ops->page_response(dev, evt, msg);
> +		ret = ops->page_response(dev, evt, msg);
>  		list_del(&evt->list);
>  		kfree(evt);
>  		break;

Feels weird that page_response is not connected to a domain, the fault
originated from a domain after all. I would say this op should be
moved to the domain and the caller should provide the a pointer to the
domain that originated the fault.

Ideally since only some domain's will be configured to handle faults
at all - domains that can't do this should have a NULL page_response
op, even if other domains created by the same device driver could
handle page_response..

> @@ -1758,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>  
>  static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>  {
> -	struct iommu_domain *domain = data;
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>  
> -	if (domain->ops->probe_finalize)
> -		domain->ops->probe_finalize(dev);
> +	if (ops->probe_finalize)
> +		ops->probe_finalize(dev);

This is an oddball one too, it is finishing setting up the default
domain for a device? Several drivers seem to recover the default
domain in their implementations..

Jason
