Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65C4F06AF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 01:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiDBXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiDBXeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 19:34:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA39BE17
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaAcpW3XKCo5UKv0jOINiYawNYkdLhqUio3OYIDiQ815H3tS1NLqKXH8ac+H8Xj3IKswnU8z9nJUaAOdAwp3LN0aatBQAMnJYmgspTzaZzsXdhKvb5jybMMwuCzbbAq08s7tZI/CTFX6hCznrzC4IOistF1fLRUR1QZgIlWgS7dl+HExaGy/6OFiB2a3cSrS28zYELzcPiiiQUjLNyO/nuE+7RJcwPJGJMR+Cx0HB0rqb1oOPGfM07ghMWnkPQS+CvUXP6MmW2fzsfJI77U6yMC7MuqpCU8TKRvrpiW9bzwS4pBxsahsnFb4FsrtHo8N5gT21v4Qq9f8+Okhvbk+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBXqRV3nqXN6sxPJic0DUmTswsY+vSfdqetoDwcgODc=;
 b=H8VLi4PU8tmcizEdim36wPe4CyUaU+WUKAWtGdznZUZG1ih8Dr3MOy0X6MZ+X59Qomq7zCL5mSFol2CURZQzkYY+yQEe+nPGa5sGfqSWHUWtKtb4dH8ysQ+l8NCn5nb/p+C0L9mvOJQB/O3ndNTJxZpwzFqNysBYEnVaksu6t5KY/mVbxYQGYp1KGdHXMx8PaqneuxIyIlaW5buq2HWTujpbjSaDzqdUU1zVKuDjZKacbejRmd218ZOLgR93oaZ6biRO1eDvpDg8hyA5vVgtEp6XaMEbWkHkYNw53DHu/HhK3AB5j6ZWL6FnPLffeSrCxzsy9SiuGrjTRGzrgJXJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBXqRV3nqXN6sxPJic0DUmTswsY+vSfdqetoDwcgODc=;
 b=guVvWqVXnb9nk+pJrQEBfnOZsC6Hs4VFLq9ix0kJhAdYUiOP/PUsEw+vV14mRQGaOhEKj/7Tz6A/oIVgYo9uuG2sWDGKv8fu6sz1HNX278p/3ntHnmYk4wfZTgcgMiCbcze4R1u1AxSw7kxb1n0nmdHWkZWFO1H1pg/1o9EDoyqJ8/VgLHW7foQCQsrSA0vtyrqisDWwYQtjGsPuFGHaPk19vvbuSlpqx3K3rgHhIgFg5q2V9hBNe+M58YkCGzZeO/N/QMMruf+yQ+Yw2ZHeRPWmuEsnrQuxUfXImc+14c6Kl29lj3LBtsH+tRuDnrSxjQOkgPrVLkrfhfVDekAE8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 23:32:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 23:32:13 +0000
Date:   Sat, 2 Apr 2022 20:32:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Message-ID: <20220402233210.GM2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31627cdd-ae52-44eb-2c2f-08da1501042e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270333378A6B14AF57D8356C2E39@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUT98xqY9TBqWSz2iam8qZCTrKPXXnCYc3Tv7N5xbBqmUwjHoa6ksawDtb27aBQ724KA971HhudnVOLjGJhEG7hGTjU2ZCSJDgz44r6hUKyC21OsBwMO2fsKeunOnGg+Fe7Z8vB4Z/knZ43J9kMbv4zKDCHEZTZ+lcMlPw2udv2Vd3ZQVnishrm+DxyPA3c7j/6fie2wrxMSNx1/p8tX4OxJ4FneWDVZnCtqFwJwBO+C6AxFphe/gPLR1gdZwPQNrnv4TUY2zHclmI2b9G2IPauEjd87bUGzSOr4+4FEkhj8ycWBOXn5gehb8UOhsvPk9sVwEuu+q6IY2AksHf0/WNK83o/xs0oj7iS0uopwbEJDDDUjThndytwAYX0LWFDLPMO6bVCujaHzLZouhtHVIWxQiVkSCdDRdG/4qZqlKJdF8eVZwoUKkfQKxqOA4d/YDq6QEu8FKYDt3I/a+3ooCTdMY4zyDptd0OxCzoOO+bsqJLqwTrLDAN4UqIlq99AhA2zSs1GQ1nWxjv+/OhozV3G62nFLdehsuArveUcmKt9qsp5sTK91OxSUeoa7kkeuh9GWfMmw5Qguh9d63y3PuVGdVCuOMVImYvFNgS/OOrzGv2I/tyzEoMKVkCG7BeA+MUffN3/xtG2ZhADGigbSuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(36756003)(186003)(26005)(2616005)(1076003)(83380400001)(33656002)(38100700002)(6486002)(6512007)(6506007)(5660300002)(8676002)(86362001)(2906002)(316002)(6916009)(66476007)(54906003)(66556008)(7416002)(8936002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7MMqTckvJ13TqeD+CPI5Sl/LGa70eeOsD9Qijo77n/NYYbJCvPI0n+y+o8D?=
 =?us-ascii?Q?9pf9MQjT+kJF9rLbPdtc5EjLYiiGIednwMLs5GWDtgq3aiLqRIEAXsW6jGKU?=
 =?us-ascii?Q?y8KurXj5VUv/F/2veEWKwe2U+1ZZiAFOPg9elL+EfDhWutxWMRjkJLSvz/dR?=
 =?us-ascii?Q?hdVwKu/1jBS5iW6gkeBvc7tchz7b+T8p3J3VGVHAWhz5B2DNo94gr2kx9YQ2?=
 =?us-ascii?Q?7UZf6YXY4VjA4hi2A01DGGFLvRXJBVEYddtZvKavneX6KHleZz2y/Hx5iRZA?=
 =?us-ascii?Q?RKtTe089S+Vuxa9UsGN2OUE6NyTwa9mogkUUTCq1mXqz4plajEACh2NjuSEo?=
 =?us-ascii?Q?Gd5cm8d1gZfVXcwzfiiK1MgT+56pla3YQeP7NsjuRgWXJz+GBn0gKsTnoBSE?=
 =?us-ascii?Q?8tZ7IeO1zbBR2vROx5GqP6PmE0Wxvu1F6yhaI/4jgXfbYHbXEZVkW2BZMqBY?=
 =?us-ascii?Q?odw3i7sKyxr35ETUa7yeQZQROYy0JTpuBPbZ5BPFDjku7Mbracsq5wQypVvX?=
 =?us-ascii?Q?dStaTAKNkaFvlx+K8NDhcvDDrE1rmS16+aW5SuEHmY2n2v+sQcVBbouXhLv/?=
 =?us-ascii?Q?Pxj/gheghREd8zrugfRz9OiQ2Gsb4Q/ZzNgoC7LI10Izc6iXa5tb+BOMEiOm?=
 =?us-ascii?Q?rkGhhO9INycofcYJ/dZ94ATSU40tRghIB8MfVyeQn74/CQAOZ6Bcm0QIhCK3?=
 =?us-ascii?Q?cPA7N/SNQUiVzoaYT00oSSlwlpNfCT1gmUVcmFHkzkh8mkQCX5Jd/E9AIfD7?=
 =?us-ascii?Q?vdjQppvZ1bm4e3FYgT6amW7x6EdM7r1w6OWYY/f1TTfecSmBD+cAyuEmbaDW?=
 =?us-ascii?Q?/h7PsvaOelEAjmmFRbLPdkHnNic647OCF3q9YyjfOuABJZLUfa3N424AXkoY?=
 =?us-ascii?Q?GO2reCtswpwdwHXLlQXxftniyCr7OM2NZfD+EgsBOLurSpkimvhuMKv34kiu?=
 =?us-ascii?Q?rGOh1SoJcE11V4rGgvrTag/LDFtS/AQ4Kqp/AGyl+/fvoGJGrhl+WAGtJ60C?=
 =?us-ascii?Q?W8I7IY33ebbYZKXH686kXoh+EBm1BA8LcvKUtGXTFF/OAtHhOakF9Qk/qtFn?=
 =?us-ascii?Q?EkZicBf1JubcZDGX0syepIwvDbyb9vzdHUOqyvqHEpid+sjnuZPJaHOqaA6K?=
 =?us-ascii?Q?Qiz3E9YJMOcb3ZwtivQiGBu2f554GizIRgA8AS5J/BSFYCBIN9t0QcKJXsYn?=
 =?us-ascii?Q?OnsutmQkPp/PN+zLts91/UpC4OzzGOKFnxUchGT+fNd3Fz1YCganXQGt/4pd?=
 =?us-ascii?Q?gw2hD2YqPdwoWoVZ6w0l/J7B0hkkHavQoQ8IIwCxo4LKV/xL9g7iRdr9R64N?=
 =?us-ascii?Q?sQVQGtkPxuZX5fDNG+AO9t+PSVZjN3hHLR1+9bpLcQ0QpIW+k6QgMY4fWHX9?=
 =?us-ascii?Q?nZekc4Zd6CMAm7B+M7CwBG7kbmEMtfaI5sTz42qaSx3b1de3GbhP6FzbBuyh?=
 =?us-ascii?Q?xHTV0GoDnwwYc9yAuFcKHJs0HYdyAUphKnmttDG7FtbRLPjFSlm25LWdMn2E?=
 =?us-ascii?Q?lmJQaZhHKC8ZcMlPsaxX1u1zSwy5wm3fnXeiiz23QFbJIDm8mLVlQdsd97dh?=
 =?us-ascii?Q?8hCBaHRoOrKqjcwITBamfGGsOAdR/Cz75p5lw68LDFoUxp+SagH3Py1kgsCe?=
 =?us-ascii?Q?JmOgI96RXuW5Wfuz+AL+xFYzOTV3su9PQSTwPwoUu/feICQXrKGwMojUgWLg?=
 =?us-ascii?Q?gsD4+qXxpnEYwqx7NHKnTVPDQYJsK2tOxBnchZfX+UUMtoJpVeLDF3CA/0Fm?=
 =?us-ascii?Q?lwu+72jiNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31627cdd-ae52-44eb-2c2f-08da1501042e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 23:32:13.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bPKkubBmQFLA/I9cOlnBRZ4/LBtAFBYRitloJwogq5G8OGK878oyM6WbV3SPZWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 08:43:16AM +0000, Tian, Kevin wrote:

> > This assumes any domain is interchangeable with any device, which is
> > not the iommu model. We need a domain op to check if a device is
> > compatiable with the domain for vfio an iommufd, this should do the
> > same.
> 
> This suggests that mm_struct needs to include the format information
> of the CPU page table so the format can be checked by the domain op?

No, Linux does not support multiple formats for CPU page tables,
AFAICT, and creating the SVA domain in the first place should check
this.

> > It means each mm can have a list of domains associated with it and a
> > new domain is auto-created if the device doesn't work with any of the
> > existing domains.
> 
> mm has only one page table and one format. If a device is incompatible
> with an existing domain wrapping that page table, how come creating
> another domain could make it compatible?

Because domains wrap more than just the IOPTE format, they have
additional data related to the IOMMU HW block itself. Imagine a SOC
with two IOMMU HW blocks that can both process the CPU IOPTE format,
but have different configuration.

So if device A users IOMMU A it needs an iommu_domain from driver A and
same for another device B, even if both iommu_domains are thin
wrappers around the same mm_struct.

Jason
