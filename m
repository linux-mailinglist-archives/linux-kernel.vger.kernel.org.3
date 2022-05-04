Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C525519F03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbiEDMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbiEDMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:14:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C540E2317D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmJPEasaIDa+1QeutegviJQxMP4I+YjinVxp99NolrOgxHkOTZg9OUKlmSGLlJuJ/b4zIaIj7mLgPf7Twui/8dvnMK2R7T92CNbK3RJeQjZ1vAJn6tg/wKRAg3XQJBhzga2oEO1VAG2ZEiA0iN32D3F5fqWlxPDnvdwcVk/pm2/fmFTCVQToTZAqBUqBtyWooSxjLU4aO455O5qHQftlRHNa/40Y31tH8YqcmbKly13lzb+3pGUwrRJCHnCJOGbDw/SLVenB+ZRZkuI8jEi2EiotDbWKWIg5BI67haCgzHUQ93yvJg48KQTslifgEoz+0XBLXRIlZ/vB8BoSwWfFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlB9unKuVi7BhrwCCHU3CCzDe3MVzBVmvq3wyVCNQF8=;
 b=XN2kA82UBEW43T7xEmm/qxFj6fSUcwv1TC0Q6jy37nWpqXT+nm3agx46M8P9fz6IDDZXTaUOCDxdn7F7o82pI/gjJc4Izr66pih8Egp8GRmOzLGQTg4gmdPp91M7MGv9nR1CMm5Y60yjNs9kwhuidvRMjPYlscqKll1OOIr91GOQFYUZ3pr0eqNptlnpoPgsgnUzUemIDFgC3OoLTI6Lx8Ey4I/6OGdGCIS4WOVTk0IyeeNHyqznvBxmQdOmasI/ceHUIJBMQFCnXbE7S5YqslvN5+jBElusmvykhTrjhyuLHfUDSRLY9A86SCANQ3gq3WEY2QRDeLxC7Ee0+R+BZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlB9unKuVi7BhrwCCHU3CCzDe3MVzBVmvq3wyVCNQF8=;
 b=oxhuHFO8mnuvWIHJo5MbjAjrkmNM7rRoPZuJSS09f0GFypsZuKh59TOFMbPZdjfLtm1HGvRLkkrhHwAU/SGPHmc6ZOAI14ubo8zK4hWSfX4QcTsWLL417fMBNpUKcyywhlzPz85VYiKtz4mwX/A/9cXbNP6/yM15Cr1JnwXcbLxZE+YD6sy90/TmHoHrXvEzD3CGsSnz9Be3R9X4/uptl8lSIpLuO1kUoQ/P2T3ehxKa8Uqxli9/EsYpiBPkJyGHhJJpyuNJbpoZR8q0xIwC7b/KyFOiBapgdTWezphblATY/EerWpHvP83POp1RxkoQjeGVykVFuwvFuHnmArMrLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1874.namprd12.prod.outlook.com (2603:10b6:404:fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 12:11:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 12:11:10 +0000
Date:   Wed, 4 May 2022 09:11:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jan Stancek <jstancek@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, bgoncalv@redhat.com
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
Message-ID: <20220504121108.GB49344@nvidia.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
 <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a707f6-a0d8-47e9-c23b-08da2dc72cc8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1874:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB187427D2AB9715B40D289462C2C39@BN6PR12MB1874.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8gVWVpMINKENAGMb/sjpO43zm92OYAt1FrQqtAuAKC2hOr6q3AOlT/Re5YqRN13vf/HVgf5fZnGa4JmvDOmkbweNU8Fq+I5aJTPIYqr/rdriaQbGpHc6B63cEUKyjHOe8M1s96oClAr5gbRPn4lYpS9VDakfBl+ZjksYlJTFLRjZQYAZVxf7/ARAP4xuySrVhk5t+FeARG29WtemHVfgu18GyjDTIbd+FeVyAxzHWD2qK8lhVhcAX3F1fsBFjK4Jk0Z0S2BMbU49m18fuRJGCCAz1sYcrY5bmG7Hn7lcOzbrQxnZr41t7e6BkShKit8JGdT7HYS8vCJLsMUVsQjI4txvD3oA0ep7BvmarPd4xeZ9cfSlZYWi9hwmElJ4Qs5Hl2ybKgyRb0JXPJO73dsikLyNwGfgA2obcQ3po5xIqXEl7QwtgYiqXLwHKq6CnPSF6+9dSzf8XINoCmj7zIEemRVkd4FaslzYdBygk48QqKQmbU9LmLVhJQ89pGTbTDcj1nWNhRgdIEAFd9ipd+vgPuHPchnmzwPxKmQIXHp0odoftI+tzeIgYbU8h8k0k3gCMYcxz4AGLjVh87AWJA5vosnqzt1eN3wwnbSwyfZYpKVqMoQuackdfcj83u0Kd0cODrDWkom4az9G0uRKE75wJwBUnWsjHYIiXGgyLeP/937vrLmUb9hxFfaw3ZvstV/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6916009)(38100700002)(6486002)(26005)(54906003)(2906002)(6506007)(316002)(186003)(86362001)(508600001)(2616005)(83380400001)(6512007)(36756003)(53546011)(7416002)(5660300002)(8676002)(8936002)(4326008)(66556008)(33656002)(66476007)(66946007)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwD9STXaYtuwJtqyCYO2HBjDhLyNAIrGftpb3osmprCsRebhvbuFGCFl+mU0?=
 =?us-ascii?Q?WI9IHsERM65ggF9iqduy9mszRhF41TmE0BXoD+4hEYiqI827EvF8SuNVlCYX?=
 =?us-ascii?Q?O/x8fEF/EqJ2+0RKHW3oaX4kDEBtGtgCLkfvRpZoB1r0cR05lP80CNn3hL9F?=
 =?us-ascii?Q?9MgbICTapp6IBBWKHCoq/f8blUv9YjFtKLkeQtjiUZTvx8lZulQWciH4YwIz?=
 =?us-ascii?Q?lDd6SBT4cGGm0P4sQkivy3HI14a41JG54KGsQ7DeUhWs9WVlfjaQE6ntm3cw?=
 =?us-ascii?Q?cw1RBDnQgIV8Jr1sVT5Mpy8fbCo7uaw5//qjC1hHPLmcgsIehCA/4/L+eeVN?=
 =?us-ascii?Q?tFFBhc4ihFtuJqXeKacO0YvAeOp0pm/Nc+NToTcJLcTfjjJGud57NrZm6T0R?=
 =?us-ascii?Q?/ifoAM/SVPWuAAGaTv5kdylJfIFJ9HfdLqVWF2P3EjrKzAfu+FDhln7LTAtb?=
 =?us-ascii?Q?6VOYS8ZbQVVKMfFo46OtIacUC8aXSYtq7WdZoDXUxc6hjfNM4YyYj93j0tiL?=
 =?us-ascii?Q?J7aJM2Ra8AZEgk8A+eK3924Tj7q0EuObnyIhBU3m6rLiHw0HfoTg8wxK3Wla?=
 =?us-ascii?Q?s9R13xJpcBRfta3Ks7aVMoz2b6G/QSL59tIDnfdrffMAV15NyVowLzlzpzqA?=
 =?us-ascii?Q?YH2li+wAUQ1ooSOz2/GAE9hM5jdmdFfIcAj/6gyC7Hu2IXMSr8f8p9yHN1bX?=
 =?us-ascii?Q?ZfVlH41PgyKrd24JGodoAQQ/XLUu78M/+vdXGnexJKLxyKlBoXxzLCkSlJJO?=
 =?us-ascii?Q?OMDBVW0jCKnyqGNVkdxy3qYXZg/tepif0rfBCR5vFz2rdzdpCyYU/lLdo7Et?=
 =?us-ascii?Q?1sn9TYHhDG7cjf3YJrotygh0F8GTih3FXgbRvKeuWIFRHhiseQcNWLQymcf9?=
 =?us-ascii?Q?2Vtkokgc3b7h67iSYIt1EsS0C+iWfD/rkmyB7sC7WNHo+Fg6bIi4dsmlBh80?=
 =?us-ascii?Q?unfQ0qbptaZL40tsLn+QElOYTArxwi888omlJtyad6zCtae8JicDjCv7MC9K?=
 =?us-ascii?Q?0//v+0PX5YopzyiNoS5XaA51HhVy6Uzvl2XImQbXzNZlKxZdNquW20ME+tRM?=
 =?us-ascii?Q?OukDD7XTsZYRnmijP3NbdyF3Ygr9IXSYuWTssycPuLMQvvbbum3aOzRctd1i?=
 =?us-ascii?Q?GML4wf4tztKJOeR+1ZqZYo2ZAUxQCt2ZaxlTUX2U2kN8dToaxQ5rjuBraI7w?=
 =?us-ascii?Q?6g8OL72LioabLMvzM9KOVeBPvAVZZKF4V5/ne5NcH8mNPoO47WMX+cmK8sJw?=
 =?us-ascii?Q?W0k32sLGMAckjCqtIeAMlJ8jQKatzhuF51i3Xip76z94iRAvl2y79wOogk+E?=
 =?us-ascii?Q?7j/e0GmjC37sXZfkZXN5d6Vk82M45uI3I2wlx+yYqoAJdJNX2MFVUMhSZj9B?=
 =?us-ascii?Q?cE/Zl3TQ/mwGJNYn7K49wp+C3s6L8TW+VxVG2Vkx8gawbgL+s9ZLZ+yDh/ca?=
 =?us-ascii?Q?uumRm2VA23R+G56e6pBI95n+XLxny73DBhHGOiOL6v1TgAxnp26U6ILww91a?=
 =?us-ascii?Q?4rq2dXba+3FtUOua30BlWGvNsMOKjC4lL0y0hn/TcCznZfpjmoPdCk9Lecvh?=
 =?us-ascii?Q?ZJbEo2cNp/Qz6cYxxH07CFbwE6K2UXRySa9DNvZERs0lqS3GG+BQUrOFwloF?=
 =?us-ascii?Q?fvJkk9COqZWtcjfACaTcHofv+7hSzJThirrFuZCM/5qImo4BBX0/DZGF7o6c?=
 =?us-ascii?Q?AbPIBjzm8jPSAbYFeNWDFBPXEU90VNA+AOkyYU4C4oA1wl3Ns8xYZqzFy8Ov?=
 =?us-ascii?Q?vl9JvspwDA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a707f6-a0d8-47e9-c23b-08da2dc72cc8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 12:11:10.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMLQ+vKP9cmxh8GUyK3aqZjieCohe86ZVJtRZpbNyc9RFNPMzA5zWpjkK4++wePT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1874
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 12:14:07PM +0100, Robin Murphy wrote:
> On 2022-05-04 08:53, Jan Stancek wrote:
> [...]
> > Hi,
> > 
> > I'm getting panics after hunk above was applied in this patch
> > on ppc64le KVM guest, dev->iommu is NULL.
> 
> Oof, this can probably be hit with vfio-noiommu too, and by the look of
> things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
> up as well. Does the patch below work for you?
> 
> Thanks,
> Robin.
> 
> ----->8-----
> From abf0a38563bb2922a849e235d33d342170b5bc90 Mon Sep 17 00:00:00 2001
> Message-Id: <abf0a38563bb2922a849e235d33d342170b5bc90.1651662442.git.robin.murphy@arm.com>
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Wed, 4 May 2022 11:53:20 +0100
> Subject: [PATCH] iommu: Make sysfs robust for non-API groups
> 
> Groups created by VFIO backends outside the core IOMMU API should never
> be passed directly into the API itself, however they still expose their
> standard sysfs attributes, so we can still stumble across them that way.
> Take care to consider those cases before jumping into our normal
> assumptions of a fully-initialised core API group.
> 
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
