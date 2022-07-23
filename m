Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788957EF6A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiGWORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:16:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FE2C3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvfkB+vYkP81NCu++7unMpd8a/aFTlzSp67OveCH6G9OH0ubtCPTAjGuafnKH17cSXCo1XL5qVzhiyV3l4isPZ1tNGpJESG6jG55d9O5/CbY6eqYEUwFZxS+MTju04snqFohYBh9DF0lP3Keg7QvAYejZ3fTbSjAO/BgzhEoiQyuOOzBxRXiOSPnuwtf0SGeul8jtECcx983PPqe/QV4zlzqL850xQLXkq8iNBPXWZE8WOk/k98mVqLvEa1x3KJHwumO/CTTt8XwAfKEIJaPM6xknBJ+DyAqHJHiN65aTjTPoSMTN2QpegGbb4HSqO3OYQt80XEPtiDxa2R+myneCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aU5vwugKqU9RLsGbx2to+ov2ByUySPEepvdQxgh3Ag=;
 b=eVIzwcu1JVbKCbZGAvJi2H4fIxWbbOW2ID/7CEE895Ip6WYgVZoUp32/5LohxF8XPRP2SvVnrQFTwZh2uf1aRVtfsc33zKqURGYMexTp2dFTQM8xVnFr/GBpCpDdqrmEMn1sBPKjJGuML1vKJuw3Dn9J6kRwr13rvWTBWXxvitGUle3+7p9tOdYuJ2bc+vXbJSNgcRBaJkd4lTFEbv2T9ZmMRPox+g9UQcvbBI368Yu7+lhKFPUK/fHdoCNgI3bdJhMSOHqOl0IttL29wphG+61sdsRPm/AiYcmGY6c+ObMYNp47dEWvu0PW0t/Jz9h2q4iIzTkDdYaYkUdsHe6Dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aU5vwugKqU9RLsGbx2to+ov2ByUySPEepvdQxgh3Ag=;
 b=DochGsXG2czTCdy482/d298JnAOGTrkF3MKg0kj0BXA1It8wBNvEeoHQhhqyTyZ92hSnNytwJ25AP/yvLSz7KvQr9+bizIyLJuRKIAJsjJ0RG5g0OuOFZ99MvYgZhjEBHnfX6n6OmylDpP1WjqEd657UX/AIP0xXhMHpj7cGty0ekhstdZ/co+nCF3Y4LKI3CT4V3qQd+8etNL/NCMsn4KP37j5bv0Q/mTVsM8yNNbo9g7SOWeo2GVSLmCQKlqesOESS4IJ+nNVYhsUOnRBz32W+obhGTek7jpGHUGWgxkkPjhY74Jt1/dikhrsUR1UbKSD9jIfFZuUdakf+gAqY2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 14:16:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:16:55 +0000
Date:   Sat, 23 Jul 2022 11:16:52 -0300
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
Subject: Re: [PATCH v10 06/12] iommu/vt-d: Add SVA domain support
Message-ID: <20220723141652.GF79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8660f42f-430f-44c8-1407-08da6cb5feef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChDc5WcLPg+//BJmhBly66Tsz+gSEs8Kb4dYMfZTD7aTStbGIoku/lY4+hoSCPj1Y10Ur+erU4rwctM5whrFuT3Gyk1f6+M+o2R/tfvrWPCmpUJAvbpUYgm3M7MfuHNu2BMJKmIBz6O1PRQTmKJzUPpaK1yRjXOIH0JMXlBqBbILAkLFRmUzRMSlz/pHYj8e6F9K4U/e/nTBKO72Jb+NyQVSjmJD3BQg59ejfI7ZzRWPDjn+h2BdePgCeZ3XpoRLpUGi5kZwMEXT961+TK9Tcv89p+gDNBFA29vEGFN/miS8xQJN/A9RxYisySPepa8C2i4UOzbLSExyQRgoRQLO7P2bNKnL1hefTsvVutGdoRuzB0DjtP9nYOxFRDwzpjV/f6gFjPakTCWz9s/a9FIMUBwpYYN00r9rFeVjav0+9ghFU/OD9xCq04E+KOqbTS6Mn/jvGGVffOTka4xcfcUyJ+KHYA7NTAod1vogU18X4UPmyM1ISfQUco5yabUB4sDPzB0Zk3xEa97SYO+d1mKIxT0sBPcJ3kyDu54gMIkbmLCju3/6JGeqKEN4K11+RNcqPqP6IRYI/g4ZL90FvgL2/h0+uCwOubv84MInXtjcMQL/fl6FKV4CS0IxuYid4UYFUZJSOHDk93IsS4FVFhyDEDsrFks9g+D6IAiCGlQJMEc9a922IZqcvWrE9mphsCYPA+VvCS9Vn1EcD06OuGFQAs+FzbBzqMjJLAgo/SZzbE0nC07oRBOA1HTsefNkXT1h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(316002)(36756003)(38100700002)(4326008)(5660300002)(66476007)(8676002)(66556008)(54906003)(33656002)(6916009)(66946007)(2906002)(6486002)(26005)(478600001)(41300700001)(6512007)(6506007)(4744005)(7416002)(1076003)(86362001)(6666004)(2616005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHgEOhoN8PRYXqeS2hip3mxlBcGxBvE46+639HnBPGrK0b+JyNengCCThQO+?=
 =?us-ascii?Q?6uk4Iop/AbZb51oNegncxwBoRE7yCYNgJ/nehSfHUOxTmtD0DtGaQdVlvBkE?=
 =?us-ascii?Q?yWsOYRSJ781yLx7dEYmYwSzkXKe66BZh2lP/NNlnqfxYUYfcLHh0L62OzUKV?=
 =?us-ascii?Q?gEexs2aK1lD2MmOa/LABSIFndMurgqOl6A7mJ2Kcj0VlF6yb8AaUkkO02pIn?=
 =?us-ascii?Q?Sdq/UMib2pnezlU2eiWtx3XvDg22hLcOnnE9zhLWFaTb0TP9JhX66OHZnfhx?=
 =?us-ascii?Q?vmXAW27crhh6Zv3edm4n1nu1LNpk/TuhRXLEg8temFzDNwW8rUS7bIpX9kQQ?=
 =?us-ascii?Q?8fVJ9E5zXvORVYPKrqQhvU1bTkNOaGjnRpgLeZomIy8w2QZpi4BjMBChtW52?=
 =?us-ascii?Q?VzFOfztcjoXejhxgS2Cuc5e9WYQIqkdiYfKbwfDb5d8iIxC8VmXovQy9SImj?=
 =?us-ascii?Q?rA+uVGzHDTr0Z+grIWDoK7gyDVUic1dsOSnjwau3IH/0yWUKMA/cMiuSAgJr?=
 =?us-ascii?Q?KAuGj6jeSlCUep0Z+MAo9xa062nLynY4z8HBjPqKhG8mxnN2O6uoUroRtODq?=
 =?us-ascii?Q?NIMpMGI1pVnomjcWgBQFyN+R4OophdTpJ3dXeDM2DKaG4NyR9xEFHPZoarPl?=
 =?us-ascii?Q?EpdWNlgkGlEYQJLVu6MBT5vocKsJt7xHuOaH/E5TFg49GHT0kLmi1PFwqXpV?=
 =?us-ascii?Q?VsYqwL6DD5mWSr1gnPUTBrfJIZAN7yUGpqfsH5NGceBx0tTa47vlETRfTpLh?=
 =?us-ascii?Q?7RkAPmdQ8vNQg6+l0yMtfv5i+dXRET1AGeIUR0a0B0DVCuhURzAn82XcoHBK?=
 =?us-ascii?Q?qIUCLutf74PXNBURkfjIAhjUmLhlHq2Sqz09gDKosK7z99dQYOSnjxgOUwsr?=
 =?us-ascii?Q?yUzwEQ6WDaiol1weOLqHofFcrQfhsmiYf80evSRdeYs3+j2BJDHmap6IX/e/?=
 =?us-ascii?Q?AofI3p/yHBm/TkZZ7nRHdAFNJw1m1oMMjYeU+I8/bHeZWGKwK1BsxZuZTnpt?=
 =?us-ascii?Q?v+sLbKUWK16/6CC1BpDbc466YnHNEWBaUAcsQYHAyre0c/FUreF+aBQPGg4O?=
 =?us-ascii?Q?iRva+vLxl0JGfkwN4oyC1NB5d39V/XATSeYNtiFOYWFAyRWRHSFI1kc1iohs?=
 =?us-ascii?Q?Sm7M/jm8dInXX6gWKHfsFCk5UjJii6NS+4Z/zhs59sZ0Rd/RqVg2lhgGaSUi?=
 =?us-ascii?Q?+cHatqjxdjW8XuyGzciGptUXxWsPBpMX2LCxVWJLg7MYbA/8nvvo/KQBKIbU?=
 =?us-ascii?Q?UHrIqQ0PTJGxy+BPy7BZSPVKfcZZ+I5O1qFBZGLdW/A31S9nmAB7XGX6HKcK?=
 =?us-ascii?Q?vo//z4fRAmmEiAiqMsj/+jZxFNXAyNiG6uQyEnq1ZRzukOoGwUhYrGxsD54j?=
 =?us-ascii?Q?6OPGbpcw4kVmef/RNp8ZkAfdMpHyRNo8jX894yXkG4zvTxbPA4GQuj9PJjJT?=
 =?us-ascii?Q?WO2fsVkEU7Reecs1HWO8Pa8tmpfh2rQDr/8WPJFPEzfbr6azZ3n30dd4rF+K?=
 =?us-ascii?Q?P8EMpSAiJhYR+KwOfSRu8Vl0i0y8YsSqzs26ij31fQJvc70ZlrGdU6nnhe6w?=
 =?us-ascii?Q?El1+IPfGc5St3G4vjoOHp0Roh5piO75eIQwOx+y/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8660f42f-430f-44c8-1407-08da6cb5feef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:16:54.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ir+bpAuK0wnhPnnjvU4l7C0z+Xq/URK+r5DNtU2FOUSL/lLovoixcamMJ2Rkr9o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:04PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/intel-iommu.h |  5 ++++
>  drivers/iommu/intel/iommu.c |  2 ++
>  drivers/iommu/intel/svm.c   | 49 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
