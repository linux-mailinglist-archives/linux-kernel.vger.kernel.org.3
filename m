Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176824AF2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiBINeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBINd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:33:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC8C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:34:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg1Ywl8LsEEwTXM5aBpKFs0vQRgDmIo4WK6CqEqTPjDQFCnXeP42x32xBXQ4G0u3Peax94n6K30lHKMdlHSLayMYYUJ+7C2UBjY16+oNSurOMKWPw0MEFBRtpFqwnlpfxsbvT5MLkoMLv1Hyan214OK+EfYPSSQvZt/GPcHTqH6XmrQSxAN6sjPRPLvTsME69fKK9+X9whABhWuJ1kTv/jrOl/hKkE6Vc9hc0BnXnWBGw6MnCD0tQZgNluoyc+RC2aFYvqR2aYDB01A+fI7rVE/u4oQ1ig6OQqLTdK6ewNV3D5DufOq7nrlbTd/znBCwLaQFgtLyT1b778nfEKis+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4UpN/0bsE2acPK676eiv1WFo0OpXLJWPHVjVtQ9LZ8=;
 b=jOLi1LHwTHmZ7hAnda9sR5nvfG0dr0F4S6rvi+5JwgkdJ6GhRDrXUoOMug0u69NC0BqXu+xLIixR32Esbwvcuz+8jGVjfy+3b79wy6NqdFVzQMhX4+O0Hu3TZQV89UiLF61p9eCfU8jxIgfLvpHRdSngLyK15sXK/opy8T/Q4W+oTwsiXsrgO9+gvwgcOKP35PbNDq/2cfQbDvlXVm4o8PLDn8gHW35fDX8/kp8Sn1RB42c3FpWsiSeHb2F3QwKBCmYkNNKAD7y3Uh64W48CBnVYxPZ3kD/w1bB8mMFtxp8at8Gmt25h7qwrN9pm//P+b3+gN8CL+5IN6gOj5Jy1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4UpN/0bsE2acPK676eiv1WFo0OpXLJWPHVjVtQ9LZ8=;
 b=SOkk8KFguoN85AlyhFrTgV499FPhcwmTpIBxqPT3YV3OIa7E2ugohRK8XhDMtYjkBbgJSw/XszzwMFDoTpqF35I3resXsTJiP2oi6IUfLoD5wkpu+F34dAhusTwmesrajjxf4GomyTRQN69mxHeXL6tdgfgjEw0GeE38gec8/txM6EKtkaeT/uiF1KkvZxOWZoF1Yn95fs7+iLalL8VKSClQ06pVW9SyuGKc1eVQl+rImDlOP0DLP9B23zwhBZvM+vpI3l5JMqpdXiT3arFAey8UnP7/JWi6e4C/hGK7Cxa3Hsyz5kjMl9PNDdfwV0lOvH4lgY7tEOTo7FylS+Y5iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 13:33:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:33:57 +0000
Date:   Wed, 9 Feb 2022 09:33:55 -0400
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
Subject: Re: [PATCH v2 07/10] iommu: Use right way to retrieve iommu_ops
Message-ID: <20220209133355.GY4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b24ad2ce-424b-4ba2-87d5-08d9ebd0d2c7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1582FE296CADDBD7CC174F1DC22E9@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DIPd1jmGqhP1OARCg+1nydnqwK2OVKaaRI38jTK7OzPQRJzan81n1Li6cEPEwrQj+3Nla/2mEFwwG/xtCiS3YXEIdcPZwXegw4eqMdtaVZs53dxyd71dv+ppZUK52qwy5qdqqJ+7HZg5fVo0MlT97m3gMd4TPVHUUUjxkql+KmE0N2Gil/Uhdk0KuOKwYhyPe9Ub4O03L4FnzjLyjKEAM2ZAL3ZWxOQ6tTILLyT6rTFwIPHQ7HVQkMPXgVgTzpzu6NPfCTPHZBy38YBO/0XL+Y9e3oOcpb+h5ohBuwkwi6TpUPMC+iE7kKv/uwpChaIVO5oa0n/7Znv0IFXHLb+DzHMKnXl000RWbDrGD2HfQYHhEJpyJAOe3iHax8E9/zhm2ts+Jd1mEO+cUUc9yI9TlADQxEkN1vaYiaiSXz//GsqERcgfdZya1c5fQKOyTgHIDn2G5YTmbsZuWnoIqX29e6ITLxxr6rMW0Z856WHP9uKbAaGrVUEvJvED40NRg1cSIb8y8VhgDM7GzwTxkxS6CcarV8/qUWxWKICMnurUGMTUquxH2jvZfdY0V3G9L9ixwGlmz8e1ZghR3zx1PlTYoo38IAzPr6StHBOUwV0da/12cm1qceGwn8VWQ+6PXcndxExEig2j7ZZBCJrw+y8FvzpSz9kfO15wOnZQ9n6jp3IcL2pXWMo2Kh+dZO8z4DNxlP1aQoW4OOoW4O/4QlxOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2616005)(1076003)(6506007)(6486002)(26005)(186003)(36756003)(86362001)(6916009)(33656002)(54906003)(6512007)(83380400001)(8676002)(66476007)(66556008)(66946007)(5660300002)(4326008)(2906002)(7416002)(8936002)(38100700002)(316002)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s5rxvYhH6OyTbnhv04xn7IFqku4WzbieHo6LIVf1ZoVbUjoY+1jqjGW5lWyn?=
 =?us-ascii?Q?T3xv8o7YuYGB7yF7ZrNo0ETR/4PeXs9EICTEQLO+VefTRJTOzN8j9oewqLsK?=
 =?us-ascii?Q?5EkksNJB51E2Ws0YJnQngJbadRyM40Ne5SllxWoJ4ArP77Rnzubeu2rfSVQ1?=
 =?us-ascii?Q?5sIiNTq8NqHv8g6/BfHlC3DUaABmQWF5EGkZh9AXdL97LGJf1EXzQDCGPdQ1?=
 =?us-ascii?Q?FVDXalj0QOL043r9P3U3MK+tA9K1fcFaSxyI3E1GB7JSVrkiRyvM3qEhuYNF?=
 =?us-ascii?Q?+b7s6xWg9cNXGA+Iwo5/KOKTB6d3zCyL2DWhnOC3PjrPAoC02pShxseHwIQy?=
 =?us-ascii?Q?CfY9WIpOZEoRAEHfaY6qoX4u4egtjBqfIBWtGqsRuLQHBMCP6hgtpi7tkNSX?=
 =?us-ascii?Q?WD8RmI8NEacCEhpW0Egtu3yaNNeg3/hifRraSxKVIlXhfQI507cY/hXU3FF+?=
 =?us-ascii?Q?bojsgqM8cQXwGo39FLPhNK7izB/hXb4c0So4cW5y2F8xYbpNl6n4PGzBI2LI?=
 =?us-ascii?Q?iTeRWPmYIO4BGK2J2obVPFg1NmUtyc70Z7cnlrL+veglwu5CpsHF5PUHj9I2?=
 =?us-ascii?Q?4E1hc5MipXthFBlN5x+1eOnb/0ffR8dG7ZVVtZmmClRcjo2FnJG9saLcLhh2?=
 =?us-ascii?Q?ArycPaWgVPFMuJKjBr81+Szi5e/XFlFCkKARSRqVH71WnAFfGymKBcgLBkbH?=
 =?us-ascii?Q?1sQqF0EHvgSsNbx5yMkRs72wbLkWQx6ryNK3FLibOd4GERY7qG9p3ZRe/GHj?=
 =?us-ascii?Q?fQIWNFRCbKwC+QJNb1F8G6xrkpiiCPp1YPQW5i3x18U53r67K8hbjiVX9h0i?=
 =?us-ascii?Q?P9U6vA21ZyPVvMphbxhvTwKZsb/ZwOxVokHF0lIjRJ/6SSvIcO3030ppBeTg?=
 =?us-ascii?Q?SWTxItlOV7kr2/Vs2thlb6nOSzurYRJfSA0X77jFJCmjFL5rVcgywe+vwTDh?=
 =?us-ascii?Q?C/niAqqX0uSCDyCUPZXHNgJh0roSc8gOWaXRM57h6u3UvhIhMSi0QmLTzQTZ?=
 =?us-ascii?Q?3F6BUQlGiRvJ3wjonyV4Jc4y+7OhDTh/Qp63scqimDJ6GWK8SHaPwGlVFbTA?=
 =?us-ascii?Q?X5NpENGKn6PAxSxFsdIm3paYttAnCC8s3YC9VwmGkpShN17OmteLH/WETjWv?=
 =?us-ascii?Q?s2YHxSaeNDIdQ8rnHhmFM6TP24FIiJXgHPmLDu40MRoEu4UMlG1YEQ2K+iaQ?=
 =?us-ascii?Q?lOFeW5KzAW7gpim/9gVFbzupgvAZ1bjcfukBVTxFj4PqNskA1wbyYR/t1ltM?=
 =?us-ascii?Q?EOLNcIs/VeWv/RXeT2ZOdPCx7XMk3RlnDra38v35SI+rNMyKpIyA0Wa1lR5S?=
 =?us-ascii?Q?JkazKbaZ4y3XMufsBcX31maHV1IecPjsgxH0FkUeqHP2B1g9Bo0hV5aP/02b?=
 =?us-ascii?Q?Nhk5T/U2k3rmqaD/UjBYp1lQb2n0ajajk+DGT1JjL5Nee3/MjWf+m1MhHo5h?=
 =?us-ascii?Q?SZpi+aHMVcIjkkCQarEY3mbQgaTcMOIaf2l4p+GO6/cUyLtUSaGrYx8yr0Kc?=
 =?us-ascii?Q?rI++IOfQ4nzEfHkMyefGN4KZ/sYYC7oukCwnAIjikX5Ugbln4wJsGz4SunBn?=
 =?us-ascii?Q?Oz6kfcCjVnnoYBJmFhI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24ad2ce-424b-4ba2-87d5-08d9ebd0d2c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:33:57.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpguEEutoF76Y3cfdJiHAEDAmvxd0LPdkwLh248J2r3JVX4D5Nv5ZuT+xfSNgwyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:56AM +0800, Lu Baolu wrote:
> The common iommu_ops is hooked to both device and domain. When a helper
> has both device and domain pointer, the way to get the iommu_ops looks
> messy in iommu core. This sorts out the way to get iommu_ops. The device
> related helpers go through device pointer, while the domain related ones
> go through domain pointer.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 14 ++++++++++++++
>  drivers/iommu/iommu.c | 20 +++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9ffa2e88f3d0..eb2684f95018 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -381,6 +381,20 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>  	};
>  }
>  
> +static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> +{
> +	/*
> +	 * Assume that valid ops must be installed if iommu_probe_device()
> +	 * has succeeded. The device ops are essentially for internal use
> +	 * within the IOMMU subsystem itself, so we should be able to trust
> +	 * ourselves not to misuse the helper.
> +	 */
> +	WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
> +		!dev->iommu->iommu_dev->ops);

IMHO this is overzealous. The kernel will reliably crash on null
dereference here, I'm not sure this adds much. But either way:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
