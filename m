Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE357EFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiGWOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiGWOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:33:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF7B70
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDsFHxq+j6J8zamJthzV5FqRGRNd4n0FAJWzEwT+v6MUYi5d6z3XMD1H2qM29EUnMa/ecKkSSGfq28dgicii88aiJWWwkeBdlUWu3O0RVnr7aQB0SgCukupykWf9Xtj62jEXREAX/dLNa8FaENRigyQC314QfoZDTIg2nkDNBS7sQoy+z7xNWZl1SNu11nio2y01GXmc8drMCHO+szrP+V0x+YTYUTKExDNbdC7YFa818hsZyDigMEshGYfdi3kSBMHqtX4iJFcpnjS7c+tJ9tpdPkDovpcr/XabS4ecVrDU3S1M2lWQPTYEQIjRpkmSZYQYTPSw0NEGwUhko6XIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bpQ5WCCgfaBNVttQVqKXLfBeciVl4tpteg61aMz81Q=;
 b=W8FdSy/nrFdd4xWZirrgJKst9THmzfAKYxMagMBN1Ge4e3/8hLfObH3uwrK5yAyjA8+YBwz93bx+QaDfDIHltaadSyZMjK/EJ/NHr7ZJS904iXBLxvrmGPtDtIR+ttoiH9wi+50PESAfxN5jFfqKOIwp/Q395OW/dDRC26K4w1xmi8Yr9NTZ6Ph1mAMpjyvXtLO3dYCI+TnzBimkjV1tFcI96WGee1EBW++pB1kiQcg5DbUopOjgVI03EnNxpUFd82JDRMTL7i7er9eUtX9zVmhugzV9TY06HLDWJLaNWQmzdiyA27yB6pm3snXdN+91u4MgApgyvvWS3t2IFEFl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bpQ5WCCgfaBNVttQVqKXLfBeciVl4tpteg61aMz81Q=;
 b=BUDiqqt/lkMUKmG/AHh6akaR4D5isB8Z5EKk7mPXkBMF5H04AeJdM65huiAvUcN8xgHYHrWH14IFzc6DOwda0011WD3ZHFUusOKp9Tziq5B8kFyYA3tYyxPtGDR838HExYG8wUpCCLXGy0Xnv7t+L0fRb6d937l30VrT68NTKRBFhrKVmleI6AXkGI9Z1eZgDFWja6WnExysr7lyr7m6KKfcBb+UWckT+D8Zi72hqGEWgKK0MdtB+iPGEtDaNs8Tu56VVqlpOUt8HsAua9NGT+p936XzBTHAbYsHd/rUt2a7xHtHwaFE4wUDh/XktHhAu8Fe7QISQZiUnpX28e3TGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Sat, 23 Jul
 2022 14:33:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:33:36 +0000
Date:   Sat, 23 Jul 2022 11:33:34 -0300
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
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <20220723143334.GJ79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-11-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 501ed968-77e9-4ee1-4f80-08da6cb8542a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCYmZ0od7myhDegK3QU2lKLXBC5YobU5B0hj3dVqylPm/Gl/yGWPX6xS4YRbIyuWnGUXFXvTdY2tUHG0uIKYRnjhrx3p5/xTT6ysmU2ybakFityMYIpq1qhR7PQHSoFAbOtE5IZIjDQIog94pKOx1iZKWoiC75f5Scq3HwA9N4LmpDvZpHxedpkFS/Gy7LRAfmNKgN8+WkrnO/MWMKpD8qrCaM+7gZeOaisc17jOOlQ2W2+1gNZC/g+Y3EAALf9CyVSFo3Q2rzc+RZqY2CqWSHu6lCy1C3qUCnESPkIDCz6t+3Ho0n/+6yGZCTMJXvbNnsI7n98mIfoQOLh8I4v4mJbPVanYygYfd3T3FT6RPw1w/I3w9o5FsqmvqU5tzInWtmNelmXi3qcUNOlGBlCGcsEWoXK3oKRWN0f4p+mo8q/Nq3UjtD6eXIlCrgfZIaHc97V3ho/gZji4eNP7zZWQsLWqV88cLQXBzcJA+lnHj41MxMCTZSjIxAIB5xRTYXszTgE/cjgRNJs+/bUmeCLJvk/xLHsCZqYG4D5D7loIcqEbpHwimnBdVBdLeR3lTsz4gAz1PL5Ct81jIszoagChn3CNoxRsiOa8BqYFJXP+lm+BUqwUHN0sv4gFHN5EsEw0Hm35uxnbrSzH9lMW/92/yTZaA25YWNVyeKF0QctGlUM8sUJgAmA9QcCKLatvhS35VfLKFgf0cWkdJhIvnduJbjOmFcMq0Uayj7ZNpAeR6EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(7416002)(36756003)(8936002)(5660300002)(38100700002)(66946007)(66476007)(4326008)(66556008)(8676002)(33656002)(2616005)(41300700001)(2906002)(6486002)(54906003)(316002)(6506007)(83380400001)(6916009)(478600001)(186003)(6512007)(26005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdHAxRc4USIpsbsQEUA1g5Q7OMQKQB3ZYdBcXzxzvMh4JaCHR0MRZzy8Kl+j?=
 =?us-ascii?Q?7dc0RC47kYbosLl9VQLQEli15Edy/7zOtg+uPB4MJR44KGsitjPfOwnSCpeE?=
 =?us-ascii?Q?Q6MZx9zcnafbud9aV0DO6+AxQZhSv1qaHBhT1MbgvujenHSxvKxQzgCH4O6M?=
 =?us-ascii?Q?CRT4YP9gpHuxB7gzPdBpNh5dAOpJ3jndeL0q7LaSptaUXVrmTanqq+EAbANp?=
 =?us-ascii?Q?+/7OjU1zVMmLHTuiRDAAvE/qVxN8WqEwd98J3GWVNHXaqoUgCOJ2ODx4drIM?=
 =?us-ascii?Q?KiON5qomP/3u8mAYM/bmLRhkAukRHUi4ucKbdPdWo0niFg1+/OswXKGD22rg?=
 =?us-ascii?Q?pE8RrvUMvIV/VfLZWTn20t4ORRUCr3jDfFRjt++jsJbnNkQT1G5J+wz1lcN4?=
 =?us-ascii?Q?QPallkt8PgWiAow7sf2QJ7hOf29HCcLzlG/u1hu8Qr/Y7Ztb2Qi256nyM9+U?=
 =?us-ascii?Q?Y7aWuhPu4zCJwdCYLG+4smqvB35bw4Rs+ADwyVZDkJEuj6kDvs9TdTW3A2x+?=
 =?us-ascii?Q?7Jm0NYfz/FupA7uoWnMRhVP9DjSY5I5lV7xFPjLIdc7JpRu+qNtsxVdMHvmY?=
 =?us-ascii?Q?Og9vQkBBoic/GRKjW1iROAtZuV26uRX1iarvGNhMah+hYhfqTEmZCMOTTRdv?=
 =?us-ascii?Q?s25pQ5QiNrYXvgJC7JtbNgW0wUvyZJsfa5Y/zaslxtGHzHwSgqFCsWJmmJZ/?=
 =?us-ascii?Q?wVQu6Wgp6U+rasX1XpX1Leeyv0zHJtbLelmgZIs7b4InGmSKkmnOhBpi6o8Z?=
 =?us-ascii?Q?S9Tv42qT+DbtPpEuG9U4s7s+gzoH5XkerWwxm9tSP1QUzd4WGPJVgupnBxF5?=
 =?us-ascii?Q?5UFlhxCsorp90SMF8fHFtqvblhSIKUkIZMCribCkVfe1m/VNYKmYaL+zRTGy?=
 =?us-ascii?Q?uLRHW0HE/e3UBRCj5MNlRHWtA6pfCzeZqyjw5nmf6E7uyBa+fsUdq/pyJr0B?=
 =?us-ascii?Q?2dZClxN6vYCnTURlpCgmAhHJSDTBcpIXfg7vYXZ4qBmSlDgpb7Z4U8IOT8dI?=
 =?us-ascii?Q?nIKs+9v+TaYv7MyLna0OdnSZIG7sbubbQD0gKNfm9U27U0q7CCa0bjqwnu6M?=
 =?us-ascii?Q?w2t9KQHQoZLPORZN3Xic6oLtcJRmTv2OOtVty3kyLUhGbx9fduETZaQv+gU+?=
 =?us-ascii?Q?pHlr7NgZZoOloGrmA888/RId5Q/I3EzQQkXG08oh/QX3YvclRJ1Jg2Ueyfci?=
 =?us-ascii?Q?DqiLu+JlTE6Yv5w/oGFAm1TulL4WoTCwT0abuFr939oz82JoQoT2QNy6YUev?=
 =?us-ascii?Q?hreNMiE/T8VqA+LpcjZ9x94LvFf6oPeVyIqPomSOFtup3H1uxj2XsGW/a7Wm?=
 =?us-ascii?Q?K9BfXGOyHh8qBHMbwywQ68jLCz04l6fdhi9YUTH1P941ASLGf1XhTX6mwOun?=
 =?us-ascii?Q?2MxpxpD07KEUYURQSVVjwaXpHl/ZkH7udWAj7NiaAPELVP1FVr0I9Psj1vkT?=
 =?us-ascii?Q?4DRSDgHGS0OYYEAly3So7EM1GYicktBIWCw09Gu3B3OKEE2biEObIWMYSjnO?=
 =?us-ascii?Q?03ZefJw7SRTvul6Ks853gc9qnuniFDTvHvWYKVbYrkvN82jFaEYiW1ZvaU5f?=
 =?us-ascii?Q?j8bPnkiCA2d8y64eRlV1v/iyI4diPyvoNI5KGSvd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501ed968-77e9-4ee1-4f80-08da6cb8542a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:33:36.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLaF5p83LC+Z94qyxvnavDL4pNFDoDRm2eNuAyZknN9XiAaUvAZjExvtgsTcopP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:08PM +0800, Lu Baolu wrote:
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
> 
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
> 
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model. The I/O page fault handler
> for SVA is copied to the SVA file with mmget_not_zero() added before
> mmap_read_lock().
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h         |  3 ++
>  drivers/iommu/iommu-sva-lib.h |  8 +++++
>  drivers/iommu/io-pgfault.c    |  7 +++++
>  drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         |  4 +++
>  5 files changed, 80 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ae0cfca064e6..47610f21d451 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -105,6 +105,9 @@ struct iommu_domain {
>  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> +						      void *data);
> +	void *fault_data;
>  	union {
>  		struct {
>  			iommu_fault_handler_t handler;

Why do we need two falut callbacks? The only difference is that one is
recoverable and the other is not, right?

Can we run both down the same op?

> +/*
> + * I/O page fault handler for SVA
> + */
> +enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = data;
> +	unsigned int access_flags = 0;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &fault->prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))

Do not use IS_ERR_ON_NULL. mm should never be null here since the
fault handler should have been removed from the domain before the
fault_data is changed.

Jason
