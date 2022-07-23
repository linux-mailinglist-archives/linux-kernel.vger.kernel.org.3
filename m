Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1559357EFBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiGWOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiGWOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:35:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1BA19F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf1+2KXEgo1bhms+MFd89bBzqbra8pOZpncfEACx6C9++bgh53KkQsi8nWhT9wkg0BaWgw5Ob2OBXSVVB0++BgKDxGA21Kc5Byf0z7Zzl2mfJKLdBQVk5MgESEKFl1+J+OSOHuIkx0oobR34FtHL5KPv3Ni/GKBjS0hdjGEl1N8HohGJWjcAVkKxDSkJi7GH99jArMFBj1MPcIbVbC9tBG1Jb7tTCHugT9IV0ZN+ORP0ZqTkrpILT7aDPnT6aFXqTN3wypTfYgo2t2eH7ip4I1+WYszQKXpn3zOm67rQALwMuBRz6GtgRwoNKmt3nR3FiuprsqFrsALYsb2Mm6Bq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbiUy1Vjg5TVT2xPMgV235O5/WJuOxGYU49Oz4h9GZI=;
 b=kU+PSnAiqAYXnPJWllRkSe+iC2sZmSG/VjyaU/FuNIHpo+ugDdFtpDRuMvI0v0B6V3pZ4r1Ngh42vuzadDNlmOGfWckpX5f/YuNEDLrrvqlF6MXgYRJnagb5HA2yZnAKYPfAm6xB7W3kSyLcUDA2Hf89pihmR6J1SgTnxv8kUH95JZvZiRQZunFG5oRIATyaiPd6JYcslhIlSs+BhbdbHRhwLweZ+3HAlEvnOQB5pZzicVi1glbusFThYXlSQVm2+u3tRl5kJp4cQbVV4cP0eVJ8X/REodcKGvjKlavRHqE/borxivm0pR9Ou4cK0AuKd62VFAgRjmd+pDdL8edmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbiUy1Vjg5TVT2xPMgV235O5/WJuOxGYU49Oz4h9GZI=;
 b=BO9GHzqsjqIZenLiNm8Tan9SQqar6meNQFQsfsKEyOk5ROHPOtqv5XpyxoE1OibDtaolLlcXY7oYgGcTSugYoPGISgCHrYKLumi8MThcssv+TK06O3bKgi33aPMFZmQ1G2P9yVbjIkz8jTExRM1f0l8HhKd5mGMUv6fDSmLXj41p7+sUBoY85H0spAC2AbhNkP55o4kKQqrObtq/Mysxf6NtPS4+9zju2AzrVOcWr5vkGU11DhGbQ6UVp85n2gJGx0M1WgC1ybO1fueXqEoETct4SPxhjjaLG5RgR0BBkxBgKB41CWSphj2nhHZ6wbMG+mnYZabC/OtbHMSlseirow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 14:35:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:35:01 +0000
Date:   Sat, 23 Jul 2022 11:34:59 -0300
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
Subject: Re: [PATCH v10 12/12] iommu: Rename iommu-sva-lib.{c,h}
Message-ID: <20220723143459.GL79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-13-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-13-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b65fb8-e7cb-442f-e69d-08da6cb886b3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wtDCZ0WPZmNVFG3w9GhiK7eGCmxl+V5w6dstlDL+9EEeaZXaGWTZVEpruWvShdbRpRZ/aO0NOwJWUMfsrizDP5bL+uf9jqPKvPCanst8P3FZDFlC9oGRoOJm469P41RJenFBGcnSHtfr+d2JRHu9zUzy0oG8ijgnTxdM028Nre5Y2vFRGoKSCMvvK5XnaWj5kUiYQs+DTvGO4SHGCfZPrSlCOT5xobGCPxf+qh9oVCTwXM4rwvx2UVTeqJkQXbDckTklMyRpSuf63Bxb0Q2Xb9BFYuEVFPangoIruNw9j4lEtapXBf02WnjsgPrgpG7UybnzAWkaLORyjiVtb/jd+T/KF6Yfw/UdFb43MQGxy3Fc21wUlQ/Ht/Pl70nXjWOJ2huLv/vtx3TxGKR6tr8r6B62E7l4AVmecbu5NnwOOlwE2B6hzw57xRoEAqbM3KkRdmhj8yIcWVz0p/6QQiq8uwdWU5CSvnXVANo45epn8TGOBK+x/qXIfxmyyY/WUWwoSwyOrCXF0KKjb29WRuiOb82dvIodPzCeOyTEUHzrotp4JiCTRJLXDlfZVWMziTunor43lGT9TeEOR/OGI++Zfxeik0avH7eYt1SjcO9EFlhu7B/BI0xogKwBvYX1EQzjqSpyrnXrAsZtUWIjGo0nmEddusWnfzi0sw3nDTo662Mlaa2WvUXgTxJgmhGnQNqWxlC4goAIERYYDXeyqJHA8KjJWJ15HWnmO65bDsUD8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(26005)(1076003)(6512007)(2616005)(83380400001)(41300700001)(6506007)(2906002)(38100700002)(54906003)(6916009)(36756003)(7416002)(478600001)(186003)(5660300002)(6486002)(8676002)(66556008)(316002)(66946007)(4326008)(86362001)(66476007)(33656002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0E3E85E047c+lE0vk3yCHBGnWj27L+Dg+JgjFg7NYVLvuPeA/WVBsjjNbfZ?=
 =?us-ascii?Q?UwAPBn96vPdtjjAB348lwyiiIAbhYXscTC6PebgIj2KJCWYBtIdHGwF8VOgk?=
 =?us-ascii?Q?frz40XOTQoNaGzWptIP1ep0WvKc6oH+hHxnFdZuf/NdtzcPi7iKS2/zdiDwU?=
 =?us-ascii?Q?kryZHSRZd+2LExYiRTeRSSz6jkd57nbzHsTDcD75J/K6c6wX9PQDUy6xjNwH?=
 =?us-ascii?Q?ZeGm3lcb4n1nx+fVn8pVJBO1g1HH91wgusyCfZR+V57rCfAzorDoFo+SwiwW?=
 =?us-ascii?Q?D5EIO7aZgZnuU08JW1it7IkIcnHIJQe/0PjkTNuPJ2ps9SlL4/IukIuaSSm7?=
 =?us-ascii?Q?UU7hrrBTUTjQX6UdSLrNKkU58m6L2O6WGCzCzyzs8dZ6ODD/6RBKyStXSHOY?=
 =?us-ascii?Q?SsoSdWlWjl6CuVfJBk7Sia1kDDG9mR7g/uMdypz22s96zqWU8tiCCikaN/cG?=
 =?us-ascii?Q?+22Cvx5lOQ6ImvxKaUoDnfvMtyeQgmIl3Fy3VbnvxZxYlIqi6B4gSZRQe55a?=
 =?us-ascii?Q?54m3Ermu9doQQnfXAGASfboVlX9YBu9aMSBTPgL3ysLLelHFyAwIladYcQ/a?=
 =?us-ascii?Q?xcDH7xFyx9CelZ+c4DIndofNUVjZhm9LXnMf1muoWTPkykXHvH6L4wn5yyOz?=
 =?us-ascii?Q?DHIOEtHIi82wynaq3X3Hm8HdBn9MA8ptYytqxI4xoFM/dMS0g+VD1t8qSoGj?=
 =?us-ascii?Q?57S0mcm6/vCg0hC8ZLG50slPkWwqxZl6I8wp4Ll1zQcab7lvM0iralTBaPfK?=
 =?us-ascii?Q?20B5sDubMpJtTto90mAzx+F1kPrw67l4fzyr9xIab/JjuTrL9qPnplo8zt+P?=
 =?us-ascii?Q?JasvL9s9uF1A3bkPQ1t7qnE7oeG142sKVSgTJNaRBvtxqSkOXDzwdVMokJbW?=
 =?us-ascii?Q?MW3Jh5jafjdzTtLqnmofGVVlOLvQfs/Rdyx6spg56sUUaoFJkD6c46oIaO1T?=
 =?us-ascii?Q?/K+U95tTxnlR3cCnG2N3lFesYcHfKFcocrZvXjZ5ZYhMeysRj64Qzy4+u5t8?=
 =?us-ascii?Q?h+nKkJ4SXdIAUZKK6pRrIi4BKwcf80AcivVwDEa/b1gIuVPOvFWacBBA3Elu?=
 =?us-ascii?Q?aY6WXnLxhFprOVH3Eh2Dp+QX7WxlL7u8HGHilgj234xobCXnyQz+YPEFJap/?=
 =?us-ascii?Q?sDw7AGMW/3KDp5B3qx+FKXEl5pwf7OzlaeNPdGLIXQLGGTLSS61D6EYKseHl?=
 =?us-ascii?Q?va2bwHLDd60FtoS6Fgyqs9TYVxfsHQ3Rwn9OtM1lxNrwFgZbuJiQClgtX0wV?=
 =?us-ascii?Q?wLDnlJ1Q9C6cgt+IHFqLxOPSaBDEm8BMbrfCASVWbzi0dejtGMaEBEdeVGLo?=
 =?us-ascii?Q?2P8N7KtRWH4Czss+nbJ1993I6zY6fhgo3xrW16wIvIeZjiG/mjmoa5GlIZ27?=
 =?us-ascii?Q?2TtFa2njHJuLBzLULcSBHAWioB6ReoiyBAHqy3fIcKpjCTrSZp+GxMl5OAU/?=
 =?us-ascii?Q?MfYQQHS8zoSqUmA5qV4z6g7Y7UOvxiKpuhA6WwO3hdcg53GTH6Oc+DUmvrCJ?=
 =?us-ascii?Q?7yBMWuRZpXb4U64sxhRDWWTUK2K3lJcXtccdhD3Uzup78GhavmOJscbWMZ+D?=
 =?us-ascii?Q?j7GRqWaXci0End9/Y3vjVE4ZxoBm4afQJOJ4xM/b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b65fb8-e7cb-442f-e69d-08da6cb886b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:35:01.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovUGwWGnTgRg0WYoLBNDyC3IGNi++LaLNKJBoJ9RuNmE9LXcufYH76Aptdv3KoQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:10PM +0800, Lu Baolu wrote:
> Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
> for SVA implementation in iommu core.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
>  drivers/iommu/intel/iommu.c                     | 2 +-
>  drivers/iommu/intel/svm.c                       | 2 +-
>  drivers/iommu/io-pgfault.c                      | 2 +-
>  drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
>  drivers/iommu/iommu.c                           | 2 +-
>  drivers/iommu/Makefile                          | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (95%)
>  rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
