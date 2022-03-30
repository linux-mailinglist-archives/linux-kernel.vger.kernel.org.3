Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36454ECD07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350057AbiC3TMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350626AbiC3TMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:12:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7114665E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA7T4pLzeK1pT8uD2LN8C8xDtYUW39qAEyyqL9RV38BGoLsJ3n4IQg+uACUIni+dYEStW0U7wCNmeGcxUn9v6aThOZFNXy6zRbASYTRgRDB/JH2sVZ4mqRB1yPCQZerIQyTTOKNB5IIsImz0gbg+BG7hy+I2mfHXLP9os68vspEmNWGpLFCqzxEpYhi9SYDjJtO2z++fpYCDiz76VLXALCuYcBu6Fz2Z1jiKhDKdLylz/4WR6X7HxlYJ3FmCU7GEsZdHmH6k8lgSOSaL5p8LQAGWDVrPC7j4xxRcgnppZKC/6Oijvqy0z49glzM+NXAOY8rP6KdxPWYHFCnEjyDkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9NWUqlz1Wum6EvmBudafLjXyo7VLyS6hE+iiw7zAgA=;
 b=BZ1PRjUQA94RwEmvmV/xuzpq0323wTqOeASUOPMpWw2XzW8M3BtxN5r92a6hsRnNiBNT0u4puVsyRih+omdgC7gLfJ0jA9SUWAoDChcB4+QD3W5ddhOzTRSgFYXSBRYKK8QdF1bqKLzqBq1+q1Fzm3Lqu/zWJTdkIPmOBfesX3vkNyJYnIh735Am665OKyWZIfYiHLIR7DhbUQTH5IAjb3bNETnHW76J29ZHOj4qUUNZCjBH+bpC5R7WYxh/ryTN9vjA6tGV4/U4bpuxY/4SOnuzVH7FLoPD0uGHwL98YCVV7lB1SUzHjbvrP/ARhl4QHOjvi0UH0kndlVmva4KR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9NWUqlz1Wum6EvmBudafLjXyo7VLyS6hE+iiw7zAgA=;
 b=JY2ovFHXJq75cnstyCq/nokbEN67L4aaKoWW/JiVp9yDS/RzrtjsKwFg+RIZypbdu2oxEwifCZgHBx5s1BzxQb4/xyTU9ATSP5gM6+rYw92ieQIuL7UYeYnt88l+DFhC7IlUsFL7R8xE4ZlYt7hKiEI54NVSGUTKPPEZUDYROrHSpg5wbqg76Bbr/jVlPp3VpN//Yur69RIwGXdXsdbH5atoBUN5dL/EX8Fhqkla2s7mmuxMH1ClrTSwejvnZosB968n3gH7+JfPNO7LWTJM8y2I1G83gJCxjOPr3OnszyvcKivk9jQLW71tuXUnIo44fPrmlk3PFdsWLlSBoS2nAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 19:09:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:09:57 +0000
Date:   Wed, 30 Mar 2022 16:09:56 -0300
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
Subject: Re: [PATCH RFC v2 06/11] iommu/vt-d: Add SVA domain support
Message-ID: <20220330190956.GD2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329053800.3049561-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0101.namprd02.prod.outlook.com
 (2603:10b6:208:51::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 746b199b-96f4-4407-41c3-08da1280e1a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4283C6DB705D6A1C4B3104CDC21F9@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0XJIz3BdpChpqsigK+F8yDjwpRYE7Gifsu8aWQfdo/jSaRdBczPe7KqQYgylnIrLn6G940Na60+ZA2YfzJriC3/wqVLcLODw4hQ/uFrDsN54WdBJw5i1LqZZF5IoKZl+PeUfBSm0MYVlqngCOAYU2yDPsBXiTw7tW6pjKFjUtP0zhHgKE18c+xOz5tqoqJVMIGkEo9mhzkd65g9cE9y42f3Lt5TW+r3oHz0dJTs4fvKNhvPStUs1TL5fh3NPqtA5L+0p7ZrEfpamCZA0ykTCVRUAtgAkuZWYCPjZDn2dCSGlUbavJKa/UM9Sqqv86RfDpTJmlWef+2fBtov36K+gEBIh9eAhOvsJAluEl6tQb9Jc37UVFHFLx4HdB0hZ4DOO30acESDwxGyZoL4F26lEu3jlbArLKCorzv7RVraOnO3d8Pi+H6iPvViEUzaI9h4Fa3qx0bEn+16Uif3RpfpZ8gIC1ywo3IeQ64tLi/w2zJCHXbBWC04tnR7bcnpn5YziPOLthF+SAh6QyDtd6GTf7bXrI2cISl3fDSOgVeJcTONisWPi8PQtOnmQmjdhL1KY19Dy3xYWrGaTSPF/74+v7ZLO7SfV23iEUPr5ZAg3rvDRzbF5+Wq/6gekiNKdR25UxF6/UKEcj7R3xjqyyVdHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(86362001)(6512007)(316002)(6506007)(2616005)(6486002)(186003)(6916009)(508600001)(54906003)(38100700002)(26005)(66476007)(8936002)(66556008)(66946007)(4326008)(33656002)(2906002)(7416002)(5660300002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDs1h0VaWZclaq5qv286zr97qNLwc/qD+UrHJ5S8mvCwFD3H4W0RKt+3y0j9?=
 =?us-ascii?Q?eXBriV2cEmwE9mK4qkLBdJtJWMntLIbNK0GYB7nl5W1EK61Xe3j8C+WbvK7t?=
 =?us-ascii?Q?ebLJZ3+N0ucaHDeyFzMIeR+jp6zAZW0zVwhSGjexB9uvbUVLhuLl6C9+9R2p?=
 =?us-ascii?Q?eylBpq2ygxdt9EYwlwSVwOgQjYt9UKDX9xohkop3DYCY6vrIxIum4yhDT3WM?=
 =?us-ascii?Q?NYf1+ObNWMTR9Maq+y8rMZx+VvKGX//Pl6uo0O6ZsX8cXT977AgfwvLXCiGg?=
 =?us-ascii?Q?cZkHMBeaG6rQTpjGZBknTAzuh+oQ0NOvwc5zy7teZWrnrx3KzxWi6yk3G0D0?=
 =?us-ascii?Q?8UDtYE0pZB7zJMTVQ56cUcDqKejjQ8aeXczTnX4c3icEowyBZmTC/PLUAQtN?=
 =?us-ascii?Q?LBLSyF+3mbV26Bm66ZMA1TH+rdOKdgXs5Tbvps/k6RP1ggiB173hfomzBr5h?=
 =?us-ascii?Q?UIhKIRwbqivwSHUMpWaO0a9ArrGxr3yXUREEGfsUKssw5utfFGx1YfuEbcu0?=
 =?us-ascii?Q?RTIHx+OqcGH+pB95/cNombVl3RZsRbxKIh42i/Ne4uCZsvIEmOsyTw375GMh?=
 =?us-ascii?Q?TrPhBMH/uK6vWDSSgWqYjaFrxjeoJZ61o2ZWvnNIRzYwKql2EBtQ9j6Oz1kB?=
 =?us-ascii?Q?FEhcavMxCu6HnoqxPniY+4jRLr+3rTxo9Dy/8Hy3GYDSCVSArHgxRKsbNCpx?=
 =?us-ascii?Q?NJNPqYoUOTpSh82gd7GTzJn4u3e9G8RkdRG36y385CtjjNJcdg2fiLjQFcE6?=
 =?us-ascii?Q?Suzx59YS1aEe76ybeRi+KoR04Ghn40irbDhNYvz5zSp5/Nf7wMFvbc+gaiZS?=
 =?us-ascii?Q?aAVXsXU9Dzpx83bwdzDRsMZL6ba+e8IY4pc0aS+3kZnM9PNNi7/yGUmA80rm?=
 =?us-ascii?Q?1jFBvyo5/HqMhveqIRgaOgjZghSO0WA9DLo3MkX8F7qqOfLdflbzkbDKOKhg?=
 =?us-ascii?Q?IHpPzn4v52Yhb43p3wQKnTyTCyGtu/0QsEHNwVAyQ009lqgapqcCHGsMCpO3?=
 =?us-ascii?Q?haOYgM2wej0kcWRdXwKVkdW/7CUltp/VSM7IxPtJKgoi8RKY1W1+8gQ5S0La?=
 =?us-ascii?Q?PltSDLB+A2serE+pxJqh7m549fNNR4VSWuzJW3ynpi3a7O9ByIZrDIsu57AH?=
 =?us-ascii?Q?zNIxkBhHBJQWkLZyF8BBgrLT0aPI/MN+ZII/RoLcQz8Njy9oMzUoKsohXVeU?=
 =?us-ascii?Q?0LXp7yK0No5mDAfTU6KIOz4xvBdwpe5dkfMsAsiYA+wEOeSRawGRXywgMRrn?=
 =?us-ascii?Q?DWrWIkkgnZmvPQmT0pDoBxQVb5+xXiDTfbXImno/NujzUcJzr10HlyHWgnM/?=
 =?us-ascii?Q?YqPgqt+MPSnbqJxNI9J24JpbqaCxt0augJ8Qig1iowCblutEuhOebvQngmwQ?=
 =?us-ascii?Q?9devh1pzHZcNDWSW8p8emNE8nESHW85KDqSpKDWSwbiruGBYRxLTffU0IpyB?=
 =?us-ascii?Q?+IHs1k0MKlX7tCp6LoCFbRW6A/DMwrQJLiudXErvGdwkOV8x1I0GNkSflZ9M?=
 =?us-ascii?Q?fJPead25g43eUmvwl8cIHzLSmSawL5SEN4UQwPzpGCWVM/pr6Bwidzk/NUj5?=
 =?us-ascii?Q?xo0lug0KZ8spgdhPpY3Fpmg9T9OWwB9lS5QWr8lBP+f4QZZhhJdPg7zDej1P?=
 =?us-ascii?Q?gxyUgsL0hwwqHA8H30hT30nsGCcpmkugzu52dTm9EPYER4Lun4B6Vz5H+Itm?=
 =?us-ascii?Q?VgYin6m7VUGl5+fp+KsGRXhNl6kuYfv24JT9gR34YPi6rVPaTfkPQjp3yDUV?=
 =?us-ascii?Q?okwqq6e9qA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746b199b-96f4-4407-41c3-08da1280e1a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:09:57.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM4aXFcORYTkC9OW5zqfpYtIyANI2ylJ2fnXugXWQEOvZJ96E6NObRkB4HGrOMui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:37:55PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/intel-iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  drivers/iommu/intel/svm.c   | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..c14283137fb5 100644
> +++ b/include/linux/intel-iommu.h
> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>  u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg);
> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>  
>  struct intel_svm_dev {
>  	struct list_head list;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c1b91bce1530..5eae7cf9bee5 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4318,6 +4318,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>  		return domain;
>  	case IOMMU_DOMAIN_IDENTITY:
>  		return &si_domain->domain;
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	case IOMMU_DOMAIN_SVA:
> +		dmar_domain = alloc_domain(type);
> +		if (!dmar_domain)
> +			return NULL;
> +		domain = &dmar_domain->domain;
> +		domain->ops = &intel_svm_domain_ops;
> +
> +		return domain;
> +#endif /* CONFIG_INTEL_IOMMU_SVM */

If this is the usual pattern for drivers I would prefer to see an
alloc_sva op instead of more and more types.

Multiplexing functions is often not a great idea...

Jason
