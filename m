Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D322A4E26E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbiCUMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347572AbiCUMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:51:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F348AF1CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA+ITrGAuKvNVP+o8GFGE/W8DzhAfo2d4BO+6Kh/LA+ziLo2hnphDcfRQIheR/D4BL8cl3nj8hXBJ/Ncy0i3i1Q9K0mctv3yuJDwQ5Ggrlmu9CAf2legOV4xSzolISL4xt1x0aLAhgfPQ3nxOHZvNarUHL6Y5XlzZ4IYl4+5gJdBsXOrjL4UOMK0nGqH3lQ5chlH6KOiqfIYYVtVuFgQ8zFHDjPfz3+7DMsJ/MZb9sTm14GB+ErQ7haVHYwBbS9tQQAfRTIrTRvqcFdRACUwDS089xr2oPetFh+ulBjn1cZuNcTElcbyID8ZhR5nyIBzJTiEoKUSlsdrbKj4qhgAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbd8Z85pJKTPUULAAkWPd2B9KsnqdGiVqpaHa05f04Y=;
 b=QcqhaPhEiHkV0ClJ3a/CGhv5CEzivpdiET/cH/1qbJCertVD6s0+ZPqzjDYQnF/WnE/0nB2Z0FddOE1+3ipsoA9TRzxZb/zXbo9D9jceRe9cwI4vlZgA6vjtXF/FkIN5K8qD5D+gNyB4QY01XD8zQKf/IN72rwIwUYpOKSt7y47110NOd5ZJ+qLX7lkcKN+FmrCZnUDKtcPqWENUYnmZXmE7flDti8AZ7MRR/p47G1iTGOjL7Q1+U41mfHirOzwwZjpEK+qUvfG4aM9ThMJ/XBDM6Dlcr5gvEmAEp0KA73MZWevrH3MYevEdwSxB2bf8EgfhEnsS1LUzHjtOU8rpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbd8Z85pJKTPUULAAkWPd2B9KsnqdGiVqpaHa05f04Y=;
 b=Uw9FeGWNFQArjgqSGz0ZJj0otd7LmS3PbcY8jB4Ggl+qPRsJrhIdsHHVKc9Pzppt+yT6ZtPCTi3ThtRNtxYJw10kcGxp5NSnzQotNMivUIsCUAD84v1IX2GyMg2wBxBDVwvAUqyS9KHXWgVPNUuTUUnaZ29wO0Jk/+YjWus2scll+AQuNBSjj6oqGiHVvQEY5iM1aQhQvfQZggVbNi681MlCdJf4/RdRaoFBIALV1YxiwoDjH+lq+6SftelOAuGgB2LWJq1ZdpOq0e5uW7RqtsUAArKrKWcHWMnbk/FSyAlQY1QCIQyMFceYqHzavTi4slgqLlGn2ljZv8aPN9kUug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:50:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:50:22 +0000
Date:   Mon, 21 Mar 2022 09:50:21 -0300
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
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <20220321125021.GQ11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-11-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640fd6ff-707b-4fda-abcf-08da0b395ce8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125CB527C99FD7C46887C24C2169@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y7kHOQAuDJkiWX00fwf9xHo1/1r6qsdar26yj9lT07MKqFxvlQk0mCgC3d14hbKaDLUWF/QCCmANqVUTb8McJGbXLIW1Og1sITDeXzzbmNbuIBAoM/TrpyTDN4LsBCwKa9y+e0xbCjc+DfxklC4qiIcC4QAcfP/d2gB8flEiqzbQZiZeM+OB5qbWVvi9YHeBu3qwx16HT7l5mOPTdZvKJthuCKvSUFR+Xi6Y3Fj4K/c7gblu0ZkZM3IXJVOcxfDBFTSs8kD++vAok7Qv68HdtPyV0fMzfnQSBM3lJicAfvI4BMhzBetFUg3w6ORJbAuwKXskfNP2BafVDHQqyezap2ttXCJ9It0YdIOglq0qtdOQ80NFk5QasbUa1H8KKyXMpS9s03HNxxbzVdQOeiiYNeGx06hqyzbI2H4+BecZrIosasRvmcQWPzqlEAzovya/6Dmk8+eKH4P6GYrFZpBVRtR2kftab7kjMJ1M7XgN4OtfYpK0NpZ8zqDWNmO0YOu6o8zvsND2hs50+fyZFie/0rxKo9SUX8H9118goBP3SQ4rclyOeL5nmRvrQWjgB61pZORlXwN7Yf3fu0/HOi0hXY/Thnguyb/7iPGkQPKot+h9SLVsoHJI5j8B7KU+8P2XLgpC4z1nZfk0Q67b2FrXR2JEU1AttCYjevG5SovtUhZNRtRuILD7agz31o/liFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(26005)(2616005)(1076003)(316002)(7416002)(508600001)(6916009)(83380400001)(4326008)(2906002)(6486002)(66946007)(66476007)(66556008)(86362001)(8676002)(54906003)(6512007)(6506007)(36756003)(186003)(38100700002)(33656002)(5660300002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PK7h6VNEOuyHGyMGGu1pgL4waQ7zMlAeggZ65nE1xp6bT7XU7kHlVPGjlhIO?=
 =?us-ascii?Q?YNfuqfIJW+YpEss+20y62TsNn+IYoblvEWYzKN5t6GS3//SVva3DDdiv3IkF?=
 =?us-ascii?Q?VWOI3Lm3tWodKSiLUlSoszC3QYGMpLHuA7lGq7BpcFSVGtrSUChaWCBAG5IX?=
 =?us-ascii?Q?Cbd0cCUlUSIs5DoMZSZLTqd0NpVxBRzXR1tHFD6hKqFmW+TeK4ZNmX9dkXTk?=
 =?us-ascii?Q?joKqs7HzDKJeUImZJ62d7tpUhUblFzdgGCOSzF0cWb0Nv5zv+DRBPqIR/vJc?=
 =?us-ascii?Q?L4jykIKpKanTBzbKkYthwiUT/Kq0SZdQVVqYSyLjJRjXIcsXgVFG+wW7sRds?=
 =?us-ascii?Q?725iG3LQPB6avoEZRIrwWbhXZEirwWnO1CKcl+QFlgiDocPjIn+F+I+woM6t?=
 =?us-ascii?Q?nwmIQQWBSYYjJ7M4IXLjPu1edIO0cFsCc7IPqOzcbTdWKO/OkyFElt9lHqCX?=
 =?us-ascii?Q?MDoQD1vVOJmH0QvmEwtXBgDX5I2ihixCBHVBxwrIon+925ZABiwf2X89Ey77?=
 =?us-ascii?Q?LTZviNiUVc+p7XjojHP1DlXDSQT/PkVrgWtxcG7hdk9xTX5SUG5l8USh0Ewl?=
 =?us-ascii?Q?EfYbkULBXhic5LVrlGnrB7SVQ1CWJZ36S6w8/m70JTKIiXTQwgGPY+F4vWsp?=
 =?us-ascii?Q?lDxsDIYTINuyxsylcgzEl6MmjblZ5C4mxujFzYQDt8Zmpd0UbmgHcQ1AXc/E?=
 =?us-ascii?Q?mkIBeFHtMmIojq2Rkn4uDYbYv9C9zRSH5ccF6HYho9uowLrfL41T0MUOxAkL?=
 =?us-ascii?Q?PPMOIGTrYB3QUfZwQPdljUWaxTCWiOGFoyx3TId/PGY/nl52gCgku2BoaeWr?=
 =?us-ascii?Q?GO3Kiuv1hRCT11KF9nck8VBgm8JlLWJwXUaxBy1QTzUOUuh9mnM3YN4LkgR2?=
 =?us-ascii?Q?rhbCNpZMRwnobPnMFD75QoYNIqEEUIJzHT7oKBFCiUt3t+/Get68Y6DBOuqM?=
 =?us-ascii?Q?cyTt7DEJcexz1dQCtm4SkSYOc0Q6tyfXb9PY+blvWX+6TML0Ud0QOGMNyYNT?=
 =?us-ascii?Q?4SRfBjKS3hZEXKpBMC+LF4OB5WCKjtgo7UYau0Yt9amJfjbMi34IkmBayXyp?=
 =?us-ascii?Q?wCwICcp2APEju+1avna5ReHJx5y13b1jyOUC6fYIAdot7O+sZ7Miaex90VAw?=
 =?us-ascii?Q?GynkffmzPShphYbbHqTlUzzp3LxIr1YgWBdNSJT6+4VtaDc1YNkQTPQ8oVBI?=
 =?us-ascii?Q?c7Dy18YLnKBfD3XoNCAEckYibjyPIcXP4jR+5vZXbC/sPQbo4f5c3cF6IzNo?=
 =?us-ascii?Q?lgZUTylLNxFqbY2vxOFFk2fE95JyFdbiAgtasJYMJQTjagUyblytnhD4H6zW?=
 =?us-ascii?Q?+DD4aZOEFt5WyY3f6JxT6GJof9mNrtFND0TA5C3SpmpE9fUcLO71RZZWS80j?=
 =?us-ascii?Q?nimflRXewBsCOcH9jy5aKT2c0gDVRjdaFG18O3WHSe2YRZdqNFx86CGdaoKR?=
 =?us-ascii?Q?+1CRYJKuS02WJWnFTg9109BuX7pZdqeq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640fd6ff-707b-4fda-abcf-08da0b395ce8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:50:22.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukJflA5y6fvTSsGqtx9dIUXZC7U6FV1HbdM3eTKsiQNHQCnjWMQbIMpjfHMdGSeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:

> +static enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	struct iommu_domain *domain = data;

Why is the iommu_domain not passed in as a fully typed object? I would
think data should some opaque value used by non-sva cases.

What is the lifetime model here anyhow?

> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &fault->prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = domain->sva_cookie;
> +	if (IS_ERR_OR_NULL(mm))

Do not use this function

Do not store err pointers in structs.

> +out_put_mm:
> +	mmap_read_unlock(mm);
> +	mmput(mm);

mm structs are weird, they have two refcounts.

The 'sva_cookie' should hold a mmgrab/mmdrop() refcount to keep the
pointer alive but to touch the mmap lock you have to upgrade it to a
refcount that prevents destruction using mmget_not_zero() just for
this short period.

Jason
