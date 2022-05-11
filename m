Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36DA52324F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiEKMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbiEKMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:00:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596D24562B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDR8DSpFC903Vlt1jQcnQvEJlU5sx269fRZ4ru+iGxDP0JrRdF3eQH1mKfW7YToGhneX7nh9SdbNp5spRCKu+864OO90Ki77f9SQDaXBNh4kpsllYJnilq7EXXqS9aff6LSAsU/1ZWbzo1JQDHqNtwXQSsms5W7W/8cR2xqm98I5N0F4qSZQRm8NVQzA/WYfwuQzDWB6HHguSAQwCHu+yLz6UlIjIdcIfXlQKX+Rjghxg0+75FSN3+XKMRDqUpxWPvulGaxLngPe3SnlUnAZLX5OonCMxfw3mS54NbeJdmNfZ3PyGuIr7ELdrWsYr+wk6uTXs2O6fzsfAdjVC5kejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw22N5oasm7WjYPQzem0uaTPzVuOQQEUlxp1qr7Ls/Y=;
 b=Y3QZm02QZ0wwacfxiPBMttdH2/sBTSTsngUsPgWzvgPVNKjkzj6I2qjonOHsyaalZqFS12wpJxqVQxSjv1SuUCEsY9hzZJvpDyfBpkqmRHsHVpTn18drCuGNGAKcLK+aXmpisl3rfkpGXRCq/ng4iUpUAm/Hptxxi0APcudxUxpxLvl7SNG+Hx+h3iL2ajPfSqj9tZ7OQkNqU7QTjEwPIe2EPHLA9Agu//9tkKs85FVfA6cZSKgpuBAWYRjU5hZ5cIMHAdWtoykZS6fD5rVDqKwRcEPAO93eSYiDO731/ylIsVZlDRIzOBw8MUNCBpmAqKXIKs0z6hnKc5NF0M9hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw22N5oasm7WjYPQzem0uaTPzVuOQQEUlxp1qr7Ls/Y=;
 b=Auv9ZAJY7/fY50q/NTrdFqFXCOy0M5Xx58nlm34B7eJ4IyB1a3d1PfYM7GAQC+8wA2ioFmqdL6Wh3TPkM/tR2Q5QJ+vbOCC12HDCtgJ8KVSGP8r6N6gIf2uoKaVJivIY1uypRNfFmvintAo2RE3GGRJEtbQkuZvkxwKxJxGsf0j37nYJnzRCKX12zqVcgqA9RCzbrrBDdY6ikFBTDb5Dx+KPMzxbEl2/53eD76J+S+3zTZQcNPgmm6dkNWup55XACeEnMpbmV4HFstl65w86wI/D6FmK7fEvBO/UmgVhLdTv2KUHRwIGcrGxlCieIZNkp1dvvzP8eiFmvQGYNbMtgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 11:59:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 11:59:53 +0000
Date:   Wed, 11 May 2022 08:59:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <20220511115952.GX49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
 <20220510143405.GE49344@nvidia.com>
 <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
 <YnttMpX2geTKRzVV@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnttMpX2geTKRzVV@myrica>
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b445f9-9182-4ae5-3d0c-08da3345c29e
X-MS-TrafficTypeDiagnostic: PH0PR12MB5467:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5467F04399026316A16FDD00C2C89@PH0PR12MB5467.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTNImhyZhm/jtH/Flr/bl3wWLuJlJg+7jvAkW5DOwDoa0UuuIWeP0/iL6UyBwSwpcAp6WuALKoWCaUWwA8N95V6ioT+cMSNUcvNpzx61XPLNe1Da/o8l1sk5Ak1dZfl6Jrq/K1AYi6seAeyj3+NrVkxsHpav/HYBZgTd4nsA4jzRdOJFYZXyaHMtvuZiVdBy48Uw7VxEfOSL8bmg9hR86lXs1p7Y54h5cV8FgCUFAvGf5K9Gs+iWt76jkq7PpjkmeHUIPEhTV1x0/FiqPFPUuKJC6QwYee1CguFNwAy+X+E0c5VjLAz6ccJhxu7lTThKwx1gGuj9F6NfxkWH3qEps7ICytwK2HcgbU29BbrWHy7v9DC4N9UEw5lAb7BEn2VhRD8Mi1/B6zwj8Nj/mchqfIO3e3AAYhmeXHJ4XSG06pYfZZwab0t7E60Zb1e+HOAb1m9ZiQuynPjHds5lSrYUBB0IXSBbjnSaluxI1U9NidxTYkz6ZSd6tvDzNZSST6Lgv/vkjkGT3nx7CAaa79r+/Yu1tx3H+v7I7zQQHilLhK/ogZpjkgNaBuhEMIkHRh2k0RF2UNxWwwGCgVSbY/Q6YDVD6xawiTmJyoCbhU7PZeSJCpooMI34XWB0vBMHKwY698LFVt29TlPDvSpi9Gaq9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4744005)(6512007)(26005)(66556008)(66946007)(316002)(6486002)(66476007)(2906002)(186003)(8676002)(4326008)(54906003)(6916009)(38100700002)(33656002)(86362001)(2616005)(6506007)(8936002)(7416002)(1076003)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qj16VKGbP65RH0q+uF/QkhEl8Otu3Ql+Cv4Sl2Tdq+Pd1Ei/f+IOL/Aqtbqz?=
 =?us-ascii?Q?ohn7UrBdrAxB0hH4UKMnx1YZr5E4qWKt38M2L8JvINEy0s3innDvlwl6yDzh?=
 =?us-ascii?Q?hvuRCQDbhlgfByWkVx13OqavQqSD/uqbPxSbjbLVo98cdAH26vYn7eURhEd7?=
 =?us-ascii?Q?/5S7pWMy9Hf08pa5wiE78Wkklq70/Q/9ZifKtRlY3UijtZjROl2MlfLFP/Ic?=
 =?us-ascii?Q?EjmNiX9N/D3wClgP+K+1DHq0s9+67RbZhdHUPFUtGr+KHcOk+ecw5Fn3lre6?=
 =?us-ascii?Q?Ru52n8DQOmB2Fk/YYKLaKXmAkFjPZ9djQWCu7gwR8ltXK11lovQ9hyTLZfb7?=
 =?us-ascii?Q?ZifjtpdfB2lSpmMLPd85KYyYg70rRhEG8Ujl1j6SUG6c8O8A8xeddATGfpJ8?=
 =?us-ascii?Q?QNw6uBNUfmr5JXjQ20deqfuv2XxjZrowOAbosz+NT7RPhBw5cZd4jRB1GlsR?=
 =?us-ascii?Q?FAmOUNxMu0RB3lWY+B9WOrgyPRlAYaLzcrJk6ePWF5ieMeejfuO0WwfveiJC?=
 =?us-ascii?Q?cpxIShsmLDaEWyhfEe2YQHgHJcm9lXDZkE1ZCk9IMhVje7RL5YaI36AlM+Te?=
 =?us-ascii?Q?Xa2LRtNibu4MKl2Mdx+P/XTeaF4Gi8qWrlVEqwaoR11pT07iNZtExpTeKjPR?=
 =?us-ascii?Q?VLw4FGjRqBuFunJXvK7XoxLWZyc/kUibboUvCixWcH1CPMhDWa5qMw/StrVJ?=
 =?us-ascii?Q?7QhxX6OiJFev4iWbeXM0Ququ5PipDWDyaDmQqSZU4sNb6YiLi6MQOns7NBgv?=
 =?us-ascii?Q?BAxfh6rhepBGj8Ax+wJ9PJuLkFyVzY8Z2xjLADBSyohG0MiBNFVswM8Q9hFz?=
 =?us-ascii?Q?AIwTK+OZMy4TQMraXbFtDvyggLRy4zm1mewyTdZWyE5pHfO8BArJEAbqCT+c?=
 =?us-ascii?Q?uQiDJyp26H7kczGnFz3Tk92uaYzT/N+si+YF6zcQ6OmRPqGgl9LhjK1rk2oL?=
 =?us-ascii?Q?h4p01L10Gp2NM54+69pzuj4eWUWahNhEhcaPO6bCMcWHK6aubL2g7fJvR9L+?=
 =?us-ascii?Q?uZjOgS0U+uGKp+cBgLTnh9HTd3hE9ZIEZDEU0O6XxjwStQ5c+U3+IpKBCyIt?=
 =?us-ascii?Q?0tSaXnFA3WC/3I8OoVu2CaXMJ8QTV3b9ptJZFCVQab5QTwWLCfiVA3661jHV?=
 =?us-ascii?Q?ZO7NhFIIYtP5df6YVKjJEsuCQKiEaWosyt/skOMgaMMgVnX24obzh/ysGCCM?=
 =?us-ascii?Q?Rem/x9/EYh4nOlNw8vy8T96mxcIGHJ1gBfWBrf03/PycnlQv0qLmtme9Etp8?=
 =?us-ascii?Q?vEZ+N5jsPov+UWq/cyHt3e6ux1eXBRerZgfw7W9zJ9ZV/qSk1xeD3/PZxyN5?=
 =?us-ascii?Q?y9StKECpThwIwiG87mOxkGbNsISFvySsr3qfQfHA8Bt70iGwpdl/a12qghMw?=
 =?us-ascii?Q?Hz8oinQI1qdsblubzcUI66q2/rVMMnxuxibZ0Pa0hizNGdPx5d47gOqztJ2L?=
 =?us-ascii?Q?RYADe3STeKma9L8779TsTuFZaj/v0evVHV7AJR0k0X0zoqBVaIAWULDdNaxH?=
 =?us-ascii?Q?eXtFcEf4TdSivqPZvJ+fcbPQNPm5TBeMzu3j1pX1/Q6eTzvyhz0hkPsgSZqx?=
 =?us-ascii?Q?sOkQyzgZolyUdCF3ciZaa715TIitLoNQ7blUZqRlEdMzfWpUCJOR5+KLAQEN?=
 =?us-ascii?Q?l3euvp1YxV3PqOYipAau7Dsw58P9J98pBEAu6dwq3IF1BjVz7MUWvhuYSxdY?=
 =?us-ascii?Q?y6lFFXpSP4Ybf1GdM3YH5fC7Ht33Sx+Rdf+dqObZRFSa8x+1r7+VYFe8DJOn?=
 =?us-ascii?Q?A2ZgML7mWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b445f9-9182-4ae5-3d0c-08da3345c29e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:59:53.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0WUzdvz4OPqZRn1BuaOuAhAMZEHkMgEXxDWjOqHufbnuO1p43SZU7ktfWI8xRcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:00:50AM +0100, Jean-Philippe Brucker wrote:

> > /**
> >  * struct iommu_device - IOMMU core representation of one IOMMU hardware
> >  *                       instance
> >  * @list: Used by the iommu-core to keep a list of registered iommus
> >  * @ops: iommu-ops for talking to this iommu
> >  * @dev: struct device for sysfs handling
> >  */
> > struct iommu_device {
> >         struct list_head list;
> >         const struct iommu_ops *ops;
> >         struct fwnode_handle *fwnode;
> >         struct device *dev;
> > };
> > 
> > I haven't checked ARM code yet, but it works for x86 as far as I can
> > see.
> 
> Arm also supports non-PCI PASID by reading a firmware property:
> 
>         device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
> 
> should be the only difference

That is not "ARM" that is generic DT/ACPI for platform devices and
should be handled by the core code in the same place it does PCI
discovery.

Jason
