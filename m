Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5575F4E25C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiCULzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347068AbiCULzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:55:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED75FD2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZb25REvrbKSoPgXnQzo7e7kTwuMoSPJAjkwA1T2LeCuSinRiIyJQyytz+YBjJkxr+eR/MGdB3w/gwzM9gwtarFCjf6AJAZTq+nGQdr02r8GBjBlqEtOlVsQfVauuis8hptCxvdVUlBchvvPRSEE7fkBjsm9AUHj4BX2UaVH4D70m3wCoZGf0U3A6aILPttUYpzd4DZMjXlO+EtvUM3AxztPunjLxPQ+pcR7hY24VKPET9unl5Ee9gyjaiARD4MBm8YbrI0kPi+3sJVXxRdJxkr9VNIPAelxrB4mJE2VCKWHq4RyiwlhErVZxbJnARAI1s/bAhj57PrioyMxpb0BFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx8NsBkvvpMYV1uduBD3QJFGkOBXTeErLIbar2SO9hM=;
 b=jFJGiGkpCvFckch0j/ukAaplNnqj/jg/v8gDh+a5Bboi6AC6lM3PU1Xn6hi/dCy+yHV1SS/lNuksBHLg8ZFvUyo0NAhKJGMd88FDr+/lYka9/7o56qZE1UZbgU215LDsnqJ5r31QAm5woE+2xAe2kjkObsiFJFLfw/WZTPY/htYMrjxxY3IxSJdg8TW7hUvoqGZVF3Bi/vMMiBBcDeDDKSDKcesR2k/hr5QoDKJpXuWMnUper/d59VrF0kFcSIaHjBBWb/CigdwO41+F82I7YOt5uodYqWdaUva1osMirh0DsI2wtQjTh7hDSH8kWiIg3/J94AEPbrGbs5XW8sQQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx8NsBkvvpMYV1uduBD3QJFGkOBXTeErLIbar2SO9hM=;
 b=Eervnx/ng/j6Mwp1qUWiZDGC4N+bbaRZCwp9elgSFV1c1vJPU+R5MhWqb+ah8NA5IQUQ1ppcZbPCYsBiQT99uEb4cYNyTo3IbjnzA5PfXHncOm5ceryHt93/m3eD+/VvJsFKSY8rhBUly/pphkkAXknOUhDIj5cwSo62GzO9plnbEInpuhxfJhU/KUkCSRJ84lkSBSeMtGOSkWtovVe8tjTLCuzv1T+ro5VmR5dLN65MrWOQEOppcTIRxDPsMShF8xGxenu1hif3OZy6yRhRw+8Ggn2cqqDz1AKosW3QjP0XLn+IrqI9PKgqMADkljo9W2ST4uyxkXu1WJYbrHL07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 11:53:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 11:53:09 +0000
Date:   Mon, 21 Mar 2022 08:53:08 -0300
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
Subject: Re: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220321115308.GJ11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-4-baolu.lu@linux.intel.com>
 <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a068cd-1514-4106-0e6d-08da0b315e59
X-MS-TrafficTypeDiagnostic: CH2PR12MB4309:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4309B68AA4D39D4E08B40E0FC2169@CH2PR12MB4309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+VrihQxxqCD6cPhzyQv7NKSqoEgiSMXrsu3brgQfMJ5aW3kQi8OgcHTadlZRjrN2PfOyHs/Q3ViTvoZaYNzSAc61c7eOQCQBw6imWTAdYgDhgMOsVz2jJelk4eH8FDhQCqGbiiHNBvIatqr8i9oBRIsOdeclITrg0OzMTJwOd2BbhkaZL3Tx9E+iTDKcaFG6ntbuGUhffVI5ryDi3Ego+px9H06GHGegtAebc1f0psLHKCntS+j9Si5jNQhSMpjYN8q5/lUzfkQAzoat7b85A3VFUxh8B5VFxb+xTPWBa2vK43oWoQuYbiecOO/NUW9ys7YPK0JQPwylAZeUGp82ealWQe/ayRdbOoCSjG5gTtE6kIfGesbI9FRdJU0GmgM+098F455mz+u+0lTrkJqLn2W4WBTbYM7ctZQoqAncdLkggy2cp6m9KI7MJWh5YYUtFRSXM/TuEG5wygHl6vIRGX0KP8OyTWm8fTfEssBCugZ8CwSAb6fbF+jy4xN8aoUMSYyxmVEKjaUor1duJm9DsV2Vn5GNGQiaAf2ltKJPHa0qHWjaLHvwRF2QA9DV2L0lsGDYj0lPgn8Q61YEVjOZPhmIpZelh2H5wKwwc3JX6V4ihwJSRUZkwtfqm7JjIArKQgBA6ozcr+sxP+vDb7XgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(6512007)(83380400001)(1076003)(2616005)(7416002)(4326008)(66476007)(66946007)(8676002)(66556008)(26005)(54906003)(6916009)(186003)(86362001)(38100700002)(8936002)(316002)(4744005)(36756003)(33656002)(6506007)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ie/9J31zj+IAyMNBc+A/IkvYEfI7FFoafAYYjvaHdGAOOfJ38VIb67JHJxhW?=
 =?us-ascii?Q?Nq3gefPUe48CCwDDfR5FBVkk7qwDYcAlUpwOZv/4Kv1UkpM+WzC4EaBaMNdq?=
 =?us-ascii?Q?+uUK9s8G2iQBoQGYcZECfGVcAXYC/SuXOOtKmu/InCWKUZgErI/HHL7XY/wB?=
 =?us-ascii?Q?y+y03rR5N1QsB4hIsOBJGmADtqEcX4GAQEFmMH5FMC5/yFy6z8w3eTOxI8I0?=
 =?us-ascii?Q?mPYXHT7jMJ+RqVE+ufFk6rCKC8X1phtL46KexQVnsDvlu1y4w3EVAk/N2KSS?=
 =?us-ascii?Q?6N62Adw1Tf9FcnbkJLqMLqljRR2+MLdgMLoM38yqeEtwqwRZVLo10+LV7lbr?=
 =?us-ascii?Q?5mc8BE37oQqBKtjZrSQ5GMQij445vHX6qwBkUpJ5xqPDTLaEdOKlPxsR/ylA?=
 =?us-ascii?Q?q9/gnmXxt7VI5V87+VSJuGKgnWAnBbWEWsgdJ/9ulPNPjRP+zjiWZFcyoj9Y?=
 =?us-ascii?Q?9fa9okmYR3fFiUN5GkneJAqLhQin5tVGS08jsMdGKFbe99aC7FYDE6EHVrjC?=
 =?us-ascii?Q?2Uy/25OGJpakAs7Mf2rb7gtOzzntys4gu6i+5bC0o1pRBfEw+TcBGrq5dqID?=
 =?us-ascii?Q?CCMsUEc8zr/8oN4vWPdZ+jzBkCEkqg5IW5mOLmZB/b0VxPjhvJG3T8dU4/qf?=
 =?us-ascii?Q?qSPPQvj1AipTTnEoK+9r/5dSbIuFH2CflQS5CFJEJChP7r2b1Jlqx8BzG/G3?=
 =?us-ascii?Q?zGbuNXoIqEA/xOiKDxT6hSQWp08B0f4ClmdTICu77mhXKNm4b/qqF4XwP2vD?=
 =?us-ascii?Q?ckhIjo4CZpix6vqHSSBBC6DHNry6jZpw2yo7dYtnAWGAW18XsN88i+FcZDZM?=
 =?us-ascii?Q?cZON0wVdfpka5MEPR6ZzZ2MYIFHselPmA+m1T7UKL9FywWDex12n5PVYfRDC?=
 =?us-ascii?Q?dlbuQhN4X9rTZmPqMeQYk08iTszfMo7Xev+os6nH2Hut9Tmz2PZDu9LSHzta?=
 =?us-ascii?Q?qHlngbIWCFO72CtIggHrYRohH8rH274ERXg240bX9CHbCIdZdeSrcAnzU1oY?=
 =?us-ascii?Q?/J5a+DiHdE/makZQRYjjbYepYnFy2N4B9501DNlJc88MjhB/4BRfCmuHL2og?=
 =?us-ascii?Q?Q45+XbZa025Xcvs5Aq42SwmAclh9+SvNdCunMShoUVJ9MdUJ6fziGj7Qq4OA?=
 =?us-ascii?Q?AsxIQTaOhjTFzzBSm/CjedYF7GdrMHX5KOGzGQwuqm0VFKquiI7UyA+XK/iD?=
 =?us-ascii?Q?8jbEiXmWrg62FOviu3P8iLfDycE9m2VpzezGw/XyyUJ9pOISrUQ+5Wj6RvQz?=
 =?us-ascii?Q?JXt+nJsoJUgbhzXDhGx7xQvU1atTj7WNNmdOiZEn1c6Ts1+GVEQicJDkDzfn?=
 =?us-ascii?Q?AFdTbMb5K23QoMpDQkQalSVsJKTmPU/qNHsoE+JFEsPxzUItqz3WXPs6zCro?=
 =?us-ascii?Q?98Xemv7TG4RQQB3CIV2HkEiXg/pMZiKDdwOSvZ16st+CWrNj63zPCeLPktqQ?=
 =?us-ascii?Q?SXS+TzDGKulTl66DjunHQSZNRnzcFyB1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a068cd-1514-4106-0e6d-08da0b315e59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:53:09.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL31kX3sDTNbKK58lKtMJ1LRtgR7vnmGNQTa0pp/IM694a2aX9Nmi9WyYpTLMWR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:13:49AM +0000, Tian, Kevin wrote:

> 	/*
> 	 * To keep things simple, SVA currently doesn't support IOMMU groups
> 	 * with more than one device. Existing SVA-capable systems are not
> 	 * affected by the problems that required IOMMU groups (lack of ACS
> 	 * isolation, device ID aliasing and other hardware issues).
> 	 */
> 	if (iommu_group_device_count(group) != 1)
> 		goto out_unlock;
> 
> btw I didn't see any safeguard on above assumption in device hotplug path
> to a group which already has SVA enabled...

This is because using device_count is always wrong for these kinds of
tests.

The exclusion needs to be built up from the new owner mechanism. Once
the device is in SVA mode it is the same as having exclusive ownership
against any other probes()

Jason
