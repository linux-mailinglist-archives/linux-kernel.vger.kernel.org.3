Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62579498751
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiAXRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:55:51 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:55968
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237347AbiAXRzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:55:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM4Fxvhuf9WKCGhj2ex86PnQsGbv+xZFTVxUQGkzE4BRKLn1u6f9lXs+09M169+0QBYRsxNFfd6qll3Mf01dh4mo1SMhKEPzn4MX6twUdEZWYRi2kdYTl0cSaiCPmXP1MDH6yKonKnab9X2KTFXTGnjyXB938fmbzw4aLhWKUn/5iHdk60/sEjW7UzENTUdFXtMGh5kcB5XZGjuRDXXx+B5jkIg7UJK2dM8Ek8r8QvAZ9nXHU761Ne5QXWK1XcT2AoRjdpmYNF72i7EQJxBP3tf+Qllr7hvuM8wYpcKPph5mSwJM/yi06Fwp8DTtGZjCBGXYtsjYiHM//N1fao4V9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYUvqrW4ciSC8jEAnTe+ON+6/BsMiCseITU/z6jEzXk=;
 b=c9D1OQAIXAPXeZa8LRoU3isyO7DaXjwA7rY0XqthI/iWSOXd3ngFH6y22EJQDcl/xiXcLmLJDiI+eDxVYvDLal+tdnxIGTPTrTMGj8YhATcyzemkzvNQYlqi3n/8VUk/5Uh7eHGetxUYSbwaHXbvu9B5f1B1BDTbte3cA2K24Sm3K/Bc/Cf5Yd1BleQJFMg796P2AOnNzryQuCUqV+GVsw0w62gp0pN50620o/2E11PLFinfTFVH0mfxq5Kf6jgwUdd0LIRAv+rIfn8JKNsgY7wFuUHzWlOgVnND4YDn7dyGaPMxSb3XdfFGXbLsyVKA8dUOcYv09C4rap3lAz0yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYUvqrW4ciSC8jEAnTe+ON+6/BsMiCseITU/z6jEzXk=;
 b=Tid/z7V3mfm4ZKkY8aDKgY7cXqD7A7b7qUATiEPN3kb76gmD5z8QbAPK1VNqTsPkTy7P5MIYN/9iZnUP+UU9Fqe+aYsfRpkGcZlBJ1ofOdvyJtFY+781bAxTmNZBYfb66oTz10xu9taIJembS16xOFL91v4RqChh1kc0Jps0f8yOquSL82823+NVi9DwHXYVs/pcm678t7H7VnSv8tsgSKWsl2eZuAx1aVVsGulLQNpP9kRYcoPVplei9Yn6Ch3+Pu31KTMnizso9YYZI9dFlcfIr2dFAdvhiGCGMk5O401bvw2Hb3UZbcQ0PPz765MUeY+Uqu9My8s1bDRmULTnxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 17:55:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:55:43 +0000
Date:   Mon, 24 Jan 2022 13:55:42 -0400
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
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <20220124175542.GA987164@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6042e2c9-4291-4bb7-8deb-08d9df62bdd4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4306D17B16484838893EE24BC25E9@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdG1vY5oav3yzbCbwBaCv6acFU/uPrpVz2iuJvezrT9STq0lZ6lHEi7Je7KbLMJEnCQq1UzD+V3znmNq+rwOoRQr+nTJPl2o5DjVvKDg5GRg5rbKtndffNjH0jnLSYnpHBAp4jEH+o2vJOgBku3jtPAO996XYT4h0e6F4STky9A9fqpAX/usUHvxDjNaJdjhvMtbiqwBmu/Umer0ga2sqPTg1dICHw6NX7Pji/ZAs9q8qUo7llRVAfWjnkXeGt2bBoQpX+P4hzB4CXW9peHm4kbG+B9+sKA2AOGpXBcE6UON5ugzsrtbzwuIaeMqKmYBMGRYT5jx6NM/xnKIIz+OyJVH3AeiXfznoX/QAGdDtOmXkI9Ij20GRbnfa3wOKba5IUjZjI5yJWGv+ESCzj2n6JYb13QNlfpjmuLLe+648JhmgyitqLwd19tTc4jyc3wnSrV0AYdwBKzuiN7yiz4h7BiwZ66MzpJw7JAWw0aQtsW26w9e8xSCG6wrgKxctTu9T3DIwqM/YbGfmVhspeVoTzfyfhbAHoSnG4o6GlO1jQktnQhT0UwvMfZvmWNjve4TyfN1ZeiGU9HlmsG4ejhn1xoyznP2cAe6ytLALl68kL1ashsPtuXDoY+OUW4Jz0Cl9Y5mqHsTzouHYuvyy/BnKYwN1JVVLs/dgEuoXeeyndYTudnQ1tpfx6QLeILmFWM8ptDMi4MSa+Mk1p6D0C6koQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(36756003)(316002)(6486002)(2906002)(2616005)(6916009)(66476007)(8936002)(1076003)(4326008)(26005)(54906003)(4744005)(33656002)(8676002)(6506007)(186003)(6512007)(508600001)(66556008)(66946007)(5660300002)(38100700002)(7416002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvyUoPF6AfJuvGK8CnZkQBcefhC+sNYgHvMM0mdMhvlS/VE+WPszV+7xkref?=
 =?us-ascii?Q?5F/6qm7gI+Ap6CpCb+PDqRA1WmXWxTXsbDbH0z596WdUjvCooyFHvLjzJ/2B?=
 =?us-ascii?Q?TmMlmdum8XhcCWH0flQNDERN1qnESvFddCOz8Cd1ZaF5PiCfad75GdB3nV0z?=
 =?us-ascii?Q?/+PzTGUFiliOTsSwUBM3p5eeF+e/G/upEH51hEU1yxWIpcZyn6XxLGWqx8o6?=
 =?us-ascii?Q?/dz8ls7OGynntcNzpfpjobeL3je2bgUgUwcOxUhiH6cKeNvniI5VP1/0YbnD?=
 =?us-ascii?Q?GlC+5fTZxnLENu0lsshOOtijTxNwqLYv0lg5QrLz0r29yKeACFbjAvd0LyY2?=
 =?us-ascii?Q?ELNmjAcylWan8ZBl1RLU8NuNvRp8GXZLuJ/AfJnwppu0kq6TKOjCByGOM6Fg?=
 =?us-ascii?Q?kmePSZHUYeqZJvvdDR2eE/9H6pc9W2SwFMTSryCS7DNyl36swH82bYHYMUrO?=
 =?us-ascii?Q?PrVRIsgz+KKSN1uau0i7qg9ywta4fO+w5vlsJBUPr60AvJMgB9HdWlzzhRkL?=
 =?us-ascii?Q?4lithRJBPS9ZVwG8e0Eork5c3AplNXZD1AajeHoPG0Xe7+QLWdtru1H1xfHh?=
 =?us-ascii?Q?8MgGKrrHvIfpWsFJOWwG8nxh68DJic0CO1oxZPr9m1mxCVPiXDOtrH0jGm8S?=
 =?us-ascii?Q?fiX9l8XT2y1qJ2OWaq2064AIuUxmL3SY0FrI9iHJLkmjfsXtx42aJhTvUx48?=
 =?us-ascii?Q?AyKb0yHwfaetLpPrqXAlnPkGOYZK8Ki+WrMcDKFKhv/PjH8JATikO2q1J7N3?=
 =?us-ascii?Q?JTZ1HLWMy+YnW0qCmdTnY9SlDIlb8V76UlRIioTp4pK58v+VG1Obq981w/HA?=
 =?us-ascii?Q?/XtJDjw93rg5yiY8KbAFLGS+SB4Hq8pp/X13wY0pvNOWxEc/4ZR/3Bbqg/l/?=
 =?us-ascii?Q?k/rvdql0zBgROyT758PgMtKdOdKOnmBhrmAMxlKiuw2R328zWWRiQ6SqlPy8?=
 =?us-ascii?Q?szKPHj+7eG/etMEEony64WLgkyaNYXlcIZn2kDKcCs9T3Xdfsjp9Jmfe62+l?=
 =?us-ascii?Q?QVN7Aqey+s+z9wAoV1YQItzyG6Ku/N+w4oxznLCPJcW1TT6yLOOXKOJvbNvH?=
 =?us-ascii?Q?B7LuferNJMOe9uE9SBmhXFQW2zHAmTZqucRAgBYHBnkbKkUpEAex+x9YRosU?=
 =?us-ascii?Q?2JU2NK+XNNlu8cyRnsQFv/exFnC97JbuAVvJP+BulTj9lXfvKV1cn7hGzJlT?=
 =?us-ascii?Q?pdnhSVSvCP1As2BIkZjKX7yfQff/MeDCtIhf8t+WwcTaCDl5ASiuJfQ9F0e7?=
 =?us-ascii?Q?8wqFSB1Lqb3yJfYSZy1x0ZSNzEYLQr/uGeHdwPM0PDgjbAzlhRFyIGpTz8v3?=
 =?us-ascii?Q?SlYF6c0O1iqrLF0x47W1GXFH2EVMpW+l3HhLhT+qFfVaEaS0lkI/XL+/Sg0O?=
 =?us-ascii?Q?6ZO5FUDX9AiIfYJHPDbAOFbo4FSc8XONQWDnbhc8k9iDWc4Ow+G5NkRB5GSc?=
 =?us-ascii?Q?P0z3ZlX4PKhsMNLvwGRB6f6hSH/rsE909nyZw07marX8DdKMR3U611SexdhG?=
 =?us-ascii?Q?3OXOxUfUZgidMSbWlUb1pTqlqGvhINZ7ughMOdwgi6cjlLSI/1MrVq51FRhK?=
 =?us-ascii?Q?VOcFrhlAQ1lmtzE3Y/U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6042e2c9-4291-4bb7-8deb-08d9df62bdd4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:55:43.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypky8X9pPdJvyQSm+1BWgVP9u26peq4ddkmRnSpNKg8jAzBaF5kIBk4xMN9gx1R/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
> -	int (*enable_nesting)(struct iommu_domain *domain);

Perhaps for another series, but enable_nesting looks like dead code
too, AFAICT.

Or at the very least I can't figure how out VFIO_TYPE1_NESTING_IOMMU
is supposed to work, or find any implementation of it in userspace.

8 years after it was merged in commit f5c9ecebaf2a ("vfio/iommu_type1:
add new VFIO_TYPE1_NESTING_IOMMU IOMMU type")

The commit comment says 'which are nested with the existing
translation installed by VFIO.' but it doesn't explain how the newly
created domain knows what its parent nest is..

Lu, there is an implementation in the Intel driver here, is it usable
at all?

Jason
