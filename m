Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930704DA5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbiCOXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344119AbiCOXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:06:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD8830F45
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDbVjYF9dxlP18RDMWFdrinbLmeHqPUpeQWo2fDh90+8d2+szJu/6hLLyUSDrgRz864XN7Dts6Gh/AI3Ab2N3xftKlbDldvwA6hQPihvfThrhbaxPLz6ZosEpZTpEgVvmWCZbQue81VEe9fmuGRaqqqPeEZtZABOKXUOSOET9ElCWTBdCmePXXiK0wbYcYoK9FBhAeYdDI5VUZFsG3N0acp0L7EGndiQvgFtY2cCZ+usvVhAyUn/TYqRSAArsMeepXzJwq+Q054COYQg1jc39RRUoVscW0P1dbuysVkxIza2lFEwBIAOJWccIig2xTg2CDoeoLRXCRHFV4MsA5Xrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q/2/ctCWYaC787n5xyQbRLQrnvBh1c7z3Wdyh3T9KI=;
 b=F7OFqUGj5b25N7zItzdnnhITBskLI8GSljm2r+simroKrFcM6mdkU03+GK/6t/DTZmZHyVX1QiqaXXb4bsHLk3IGSc+RXoD2CNSEehxNHcJbSDJiyubccF82yHruf0j8cu36tHAQk+fLn9qLGNLoYFLl2xxCH2I7EHr+yRhZ/0kYyOanY23TK7PceK9avcmm7pAqN3zsmt1lFasULGhUr9Do0PbFRrChhn7Sfczszxqpa+gcMQR1VqopqCh3VOxq35z6138U3M+SlSUgKLsps41piykATEb13tLgIgGno5aJ/GRgY7isMyKtRiyx1y0/5F4R6GrOgGaua8fIQHULfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q/2/ctCWYaC787n5xyQbRLQrnvBh1c7z3Wdyh3T9KI=;
 b=G9EZwJO9xIkYuFTAjXOX8nzPRIM+hajnNZSQwVt02adFbvehQVQYdr9S+kVdVEqE2QOlKIckbn25trVumDm4LPCfv+fFU2GhuubSCitqPXCO7fJ/H5pmvXFrGVFviSjLuZxSTH3hRnb9dl5yb9etpWokpFR81jMTKT3vEX12CwvpLcI6y/7O/D/3OKSE7TT8NDh9AW5ptCDi0vR7EA1Lz23gVQGk0n61jUOyXPnCWYRJ40zOqmahXa+Pn9qL+0sBPet+iveoSbcTRHI3CL3JIht4J8dd43pP0aLaSFTD/9f5O+NUoXUhRRsOumuBhqf4ZZUot+X621pmhTXIsO7QvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 DM5PR1201MB0076.namprd12.prod.outlook.com (10.174.106.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Tue, 15 Mar 2022 23:04:59 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:04:59 +0000
Date:   Tue, 15 Mar 2022 20:04:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220315230457.GO11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153620.710a30fa@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef214b9b-486b-4d2d-dcc3-08da06d83a65
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0076:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00767F723AC4B4E3DB37A3C8C2109@DM5PR1201MB0076.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBqXTrTvzarl81cedkG6n6FDkn3isxYjUXi0wOONk0wNl5zQcX/G0PcsJeiUsjkQ2cNUJTHxN9VFipnT522hRp6aG0fU75Wae8VMvDEoHZNP8dxtd+q3n+u1qHIge0AOHw+p38W6VsqILDO2M5PfsyaDrKGHpKmUt/iE5ldW2FeDWirMpt0HOxrb//hrY3Dm6eqOuBNpQE0Lvg8/MXSWMPeH/X/EpuuKf3A4xqxzchS22EHQ1CrR9e0ml1iu1RO1F1xCpwM2wn3Wzec8UQx3WZm2dYnUX336/APZcp/FyD7ylxgiQMwlnaNOMT5dDBND/nW5d9G37Ck3NxJwbKGDIoM1wihVR1G7I4VCdmO3RqHYWYaD4Kr9fI/f7GOIZV0hwt3x0FuZLcJ59WvkMv8ga5EgLn8a7kfkPk1L8v/xTeNdLCz0MHTAgW1dqzjH/rJSYU0P78AYltzYKwHn+KlUHrZFrSA2WEGRRvmXwlFQGOKyeb0ZHRWOZP5KN6nE1NcGtjzrgjGk6ehG60q+x4cJQ3bDPquQWf4b6dUYSGXyhP7C2bWyUG24hOrnM6PYIrWGiqmaoq1m+ynlx/jKfSsHVNDvCtpapDQgBIXPrWHD4UB4sO1X/nx38y02dryHlPOyZBlBQBnKtZPajYHEw2LEwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6916009)(54906003)(316002)(6512007)(36756003)(6506007)(2906002)(186003)(26005)(1076003)(2616005)(5660300002)(66946007)(66476007)(86362001)(66556008)(38100700002)(8936002)(7416002)(8676002)(33656002)(4326008)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UOt5vX+zWpagbTl0kJ+eExZiJi50tT6jyglH5C01oC5DwwhwdV4cqf3Jtxx?=
 =?us-ascii?Q?9fPgRdC/J0i/XGeWUscB1JG5Yj/zsdW9SjZQNEuQllb4tqoQNuUC0arwtXHI?=
 =?us-ascii?Q?X9+KpOrLXgGDVXJRnlMNK/kKDz4uX1f9smVW3yaCzcYLgkDHCTrSneFPxSKB?=
 =?us-ascii?Q?FtQv7Rf6vGLZxpDn25Zhtd2nJ5ukDMCLAi/G0wb7ErbRXknvzFHnz8l/soyx?=
 =?us-ascii?Q?5q15gDSUfWVS8IFiggqtALD87nRGCJnnkYm/q6aG1wvmNwTLbImVNIQV4zKW?=
 =?us-ascii?Q?9NHoFuyNoF3yVkxzTSqYfpgI5vjHXQi337uC7eO4y5BI6QKBQc6wF6BfI6BK?=
 =?us-ascii?Q?SPtUIE0fuc3KFQE7BvR05/QCQWlln6dzidTVlJnrKIq5Njxpo3CGXkOZXubE?=
 =?us-ascii?Q?hhNpHnFCzGpHd+KVBXR278j6epIpHfmSl4eA3j8Q6Lz01RGqiGNrrRGbhrM9?=
 =?us-ascii?Q?4lsGmNHewGJ0pX/KRQl9rZc9/6vaLlhCzZvSSatblS1ZcnxawPa/gAfZAoUV?=
 =?us-ascii?Q?LOAh5rXeuIL4NWz8VOgwr5jkfKzewomQkNSpi0/X8Ik6m2goTA+EXUfCHM/Y?=
 =?us-ascii?Q?7JuC5eu/YytYcVWY9JaliiwiGTlFq/lCr0TrT3LMHytNwdTmJrlJi8vjL4/C?=
 =?us-ascii?Q?BtflaROD3MMCESaOkywUe7J/k7q+LgVc55eUcHU69OU46U3HVoXUDQpw/m1e?=
 =?us-ascii?Q?I52BY3p1Qnnuh8lBf4b4uumBRta+6S7KAp7GSbUST7qG7SuwFnx7NXZPJ/zT?=
 =?us-ascii?Q?JFmysNOmB04R/1ESOaPDdofmIs6QnT61Jgwjree9sf6/BFcn8T3a4gpLXIjq?=
 =?us-ascii?Q?M5Ju/lO3X3mrMh2d/mAXutVXIZVZ+BDr7lsgAXgwu3/rXHFICcVVLflDUZE4?=
 =?us-ascii?Q?QLFMFzZf0aq8jZnLuqs/gVWwwmUxszl5VbwoD8Vrayo7RHzc9fHNpugHKkjV?=
 =?us-ascii?Q?ot6IdegmYzb32Sf2KjVmM/BHYxIwCd04eMIyWRRZXWdksbk683K05Mn+gbCy?=
 =?us-ascii?Q?Mo3ZN6JZ5M9F3DNjEsOH5D0oE90915/YvMcVqrMq78FfAEOb+A9hXGAqsQ3V?=
 =?us-ascii?Q?Ui8Jtcgg9Azi/QyZhXWNs1kjQ5dwk7xHzy5TOJu/lmMBOQWjLGoApGVZ+ips?=
 =?us-ascii?Q?6+1lA8ePD55QQnRZY7+wroNCIEGvzNch8r803Q3V1yqIoWBqIaqoQ/ufu7wn?=
 =?us-ascii?Q?9WlnLsyDUl0ywl9kl6xqIwHYkX9DNocpxOMAgLGmyprnqJSmfiH9MXsn5WBc?=
 =?us-ascii?Q?Rniuur3sRQMoMyNiybKzuA/7NQgIHhwqnyD1ZUH1c9c8TQ4Dh5HYKLpRPMRW?=
 =?us-ascii?Q?Eo4vKK6cJqHJdeHV7/hwHZlbU6obJ+1WvJK9Nr4BM9maYY+TVNVWjwn/8aRd?=
 =?us-ascii?Q?NLScOMBwYxcQIwe7fAyz/gFCpqroz5DXoZw/19g5qCumJQJl6YuPiGwed1FZ?=
 =?us-ascii?Q?h2ooN8rXShBwZyFEc23xfDl05NuWihek?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef214b9b-486b-4d2d-dcc3-08da06d83a65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 23:04:58.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m67d+ZDxlKVvJScMeBHXm+SEziHGk3wptDJpzx5dxNS0vqetPgcClP4jc/w3YbDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0076
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:36:20PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 15 Mar 2022 11:33:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:
> > > +	/*
> > > +	 * Each domain could have multiple devices attached with
> > > shared or per
> > > +	 * device PASIDs. At the domain level, we keep track of unique
> > > PASIDs and
> > > +	 * device user count.
> > > +	 * E.g. If a domain has two devices attached, device A has
> > > PASID 0, 1;
> > > +	 * device B has PASID 0, 2. Then the domain would have PASID
> > > 0, 1, 2.
> > > +	 */  
> > 
> > A 2d array of xarray's seems like a poor data structure for this task.
> > 
> > AFACIT this wants to store a list of (device, pasid) tuples, so a
> > simple linked list, 1d xarray vector or a red black tree seems more
> > appropriate..
> > 
> Agreed.
> It might need some surgery for dmar_domain and device_domain_info, which
> already has a simple device list. I am trying to leverage the existing data
> struct, let me take a closer look.

Maybe the core code should provide this data structure in the
iommu_domain.

Figuring out what stuff is attached is something every driver has to
do right?

Jason
