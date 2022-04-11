Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829044FC43B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiDKSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiDKSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:40:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B602612B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjjXvAPeOc7P1ZEVTUWI1b90paf6c7/Xg8mYzjlKLM3AvlfW2wD6r9MW4q1cyhvdicIoc9xSxNfuqJTmNgzMPQ/MOicTndCQV/BOrPc8BAyeW+w9nNH+YTUPyE8PkP0j1m8oNKMicUrUNZMvrcZ+qk9coYBt73TXeDdZH88a8OLhXOfElNGS4mWgkVZ46+jR8UypdtCBKzosUuN/iQX9pz9RfMZe7qLx4G75+wlA+jjNCdY0Yq/NmgFPEctAHaZ2eCAxgBXaoCHJRnN1hQjnLk/FvNbqNzOPOoYJaVlpcD7v4YWsNyqSpbjZZMvQO2IuAJDQNWk+sRczKLaoCvjgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSOySz1ZT+IXufU5E0yBOE+lx8DO9xFJinboh55RGis=;
 b=NM1IG3G6p+Irw6rohecGnszocd134NdzSRT3aY3uFdK7g/LU1y/sSchP3ZIjNQW8C0oRF7gdUZvjKwS6A6OwhS40pNDpIDJTN+OPEnALJwTF+AneEOEetCFhrxaDdQCSpY/Kkw8L3ZvqTJxv/ngK2iRXUhsHTmWdYzVoSszwXLIw/xyyl8fThco42idOdqPiPiPg5sLiegd88Atv8QAWmaVJjUuEYXaqqcu5KblMhM2NsRG7FlWz6CkiYcCTFGk2lYuWkyyR0neudeVWBtZ3FTAlrs49z0ygi9T0e5GkgURfGrQgdFJ14YnPQynh+ZkRDSS7VLIvRmcx4ZOMVmPFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSOySz1ZT+IXufU5E0yBOE+lx8DO9xFJinboh55RGis=;
 b=YyL2pcCiRvPDJfiIDZc/4Wxd4uKF5Au0mqrIEnYrzxNIqTJm1S63LdAHkkEq4kiOwRtfHiy9QleBOh+2fPNuDN8k7HPhVN505+ClmXMlNOiKo/PP8jicWAZY6t3JueOeCtiwGiRRa13cs4+h5rWXRNoZVjCYw3TlH+DSV911WcPlbCS1eyGHTna9ONM7WxXdEGB5Hxvefnihb/gy3g1BuBxqq4WYFEXhFXMOF7ZYLVNG4fidf/KvnEDuDfnG+493/dEPECoqsxKTrURva4zy+s8vYnt3gRYK4jm3I4dKWc5MnW2Ty6cXwg5VaQ8A1baaHUfjlsl778iQJ1d8B+3JCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1290.namprd12.prod.outlook.com (2603:10b6:3:74::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 18:38:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 18:38:34 +0000
Date:   Mon, 11 Apr 2022 15:38:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/34] drm/i915/gvt: pass a struct intel_vgpu to the vfio
 read/write helpers
Message-ID: <20220411183833.GC2120790@nvidia.com>
References: <20220411141403.86980-1-hch@lst.de>
 <20220411141403.86980-27-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411141403.86980-27-hch@lst.de>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 583ce8fe-7823-4639-f242-08da1bea7c1a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1290C380D50F3B81E1E4AC8CC2EA9@DM5PR12MB1290.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wC7RXLNUAwtO+MlH0a6FqaKboiSEKOHBJ9s1+1E+c1IDAfrYfgvuLZUVOXBLIXbI2ow/DfbHGclmKXuStx3j+y+GNgqqswguKLxZEeXeGP+0ImkzzfjkbNDW3l8oy4IVagQ4+KkFao9Ck7qc1usfbzi/vhSma6GtgllPPVFhdNP27HpJ+UF/+ISp7WODKYWkwCCd5sPfVzpWHS0L3hAHJf/5+F2mpNRc/JRik0l2nX8B8t2c5l1Imj45oFrGikvkBihhTfNN/TngVS54uRifuHT7RRWwlw+aNQr4S1bv7Aiob+ZcLYU0p5LhKxRRRylSFwMZZAj2osfFbxj/Ga/hFw1oPeVAavC7Y9I+WdezKocWof/ZqfqWbgBcq9BVpU+zzGLkydQjS9YdWP5vUnSuxxZBal4r3C6U68Ll8m/NoX4L4NAWbBJMKkzBjVHVNbqh3WTweH29FUqaxH9BsKoUm1ttpVcUg+hIn2pR6I8doeAQItxb24qeDgnJbOznNZuxFhsqrihOV4OnE9mZ3actM/V0itgjT7J2xCDO/ubdUXRDkOmG4NDiOKwaO0KOysA9BI6OMVPpDhibfew2OMDDrwxbMGxfFGjC4fbeNDNvFXRfbkOnYpXHOPglEV5HB0CXtIlk0pCS1k8o6RtGlY4Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(8936002)(7416002)(5660300002)(66946007)(6486002)(66476007)(6512007)(66556008)(1076003)(2616005)(33656002)(26005)(186003)(6506007)(508600001)(36756003)(38100700002)(2906002)(83380400001)(54906003)(86362001)(6916009)(4326008)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eBTC6JuuB9rv3+g2AcX8kSjQ42kZ415ViWD8VmaSg0nnCFPUDl4GNLe6642s?=
 =?us-ascii?Q?khYo77aTiHV7xQv+kMKOQf4DSmudZBXE4dCsS85el4v0MtC/EVal7piPovEJ?=
 =?us-ascii?Q?wMfoeoTBPyt1N5vi5Ogw15G3SuOFEx+lYLtc4JYmU5y4od7eQMv60/X60rxk?=
 =?us-ascii?Q?/7PzqH7B87cnfW22DerCNxyv4XW0jdsjCzUWGkAdpudAodu9WRq/RXh/bS1t?=
 =?us-ascii?Q?MIy7dxLEHa/Hq3QhXZqs3Mw7aoCetGew8W0G6y/iAQB0VwgLAvRwja2yezJd?=
 =?us-ascii?Q?kAL+OQaKZijP1lklW5HhTUa4VTDhWyphfI7nkg2Yn/x0K0fUbaRXHcVNP/cT?=
 =?us-ascii?Q?8O3r6mbhKdWYZl+uN5O4mIeaS/iwaI2ywKZIaf09dz8IzcVTGlIY8vioIMH7?=
 =?us-ascii?Q?36RmxRsdeq/8Yoq6QKHqFwBV9Jn+Th9OzW46fvJeq6jPC6aPgzShN24TQP3E?=
 =?us-ascii?Q?ULKhbmsgmhckxK2oS3e2qzb12gGyutcXNa/uqjf56dXZkMF58RKSjc8i/NFI?=
 =?us-ascii?Q?t4XdYQ6aG5jHXkCsJOR+EKBGMK3jXMhJwzSu8MY9sjuqjuYv1a3toxSX/EE8?=
 =?us-ascii?Q?pEkVxGKHYBlp1usSiGVjO3/Wb/hIfpbq+kwYY/ttKVGYl8tE2InR01yI1ahV?=
 =?us-ascii?Q?7suHS/CtaSABIqVDOJf3zWY2TdhPQD/ee1E9tqljfIYqF4p0WrzccNSXJe3T?=
 =?us-ascii?Q?r9Gq77hlWPVr9/2cAjJwg9fz8FXO+73/YvY4mG9jnCFX1wYbNDQxB65xSZhl?=
 =?us-ascii?Q?qXLJ/tNNnpqruzpIEcxw6/HxP9HHwaTcLJ5Hnqoq6qGm7YXoGkghOFCKXO+G?=
 =?us-ascii?Q?cLUQlCbS/GSOuKByEOtoBUh+7tAhIu5Dwd+Iui6hwgVpXXADadQVq8aGMx1D?=
 =?us-ascii?Q?tJlYDoNVv0lnOEnI6XhcKMx+ygo6g0lTb52g+ub/yWw/S+PitsKzoUufKM+g?=
 =?us-ascii?Q?v8lx1OKC+KH3LzcLON3PZIVwQp44M4HkjB/odP6l9bBxWD+uHIAGfNk0qGoD?=
 =?us-ascii?Q?0eUXnLSmwROQqBrvxX0ldj9s5+nlLGQj7ewS0U5jTNVi0ePfOmsKfxb2VeIv?=
 =?us-ascii?Q?nflyonVEwsKGvPbIlgqs3V1EfOvxySpDirV7q+ATMKqcowJKpbRe3Guihrrf?=
 =?us-ascii?Q?54o2CnCrvarY0iTlUDDPd9x43woP6Riey+jxJmDnzCPbK0qHUdbqiPYIsXHX?=
 =?us-ascii?Q?rLfiROuIXWR2PE5zmHUyYHo4VqT7MZSxZRR75bCudnGkjBuJJqUxPeQTlEwB?=
 =?us-ascii?Q?Qu/XcWtXwcy7dsiuNNuXaM+RPTawpjTitp9JRKC/Kk+2NQmCOWxDSGFj2hzg?=
 =?us-ascii?Q?r63+ijzQ1z/z52O9RrhM126jhMA0/4t8SYJI49p907FoYeW5ME+Mh+FYFZNe?=
 =?us-ascii?Q?SNblS0yGzzGxCfGZUUK9447koJx3hN8Vtj9xc+3R6gnMYfFzHuShxorB7zKG?=
 =?us-ascii?Q?G/LdW8mcKbxK9D3zcAipB7goGejk7uaUoups5RIX6gvpxxQqZXX8ZdBR891J?=
 =?us-ascii?Q?5EIIxPw740hjSS51zShvE0UPLRDExTRr+tjN5oBzt8gQh7bSvhM0F6d+96Yq?=
 =?us-ascii?Q?+limb+VnTefyQYpW0+M+ifBnNXLymXErhVu1s/az9Dyh+aHY5+BkOq1gzd/8?=
 =?us-ascii?Q?p1jFJRZ9bQZPaV6j9jqO6hHUukSj68TSnlklF2ZoruQ9F1clRgbVDwaIPQJr?=
 =?us-ascii?Q?ZrAoqKEgyofnkNWTPjREhLvTbvAYhM1pmC5ZaAlfU2dOemFMe8hX3zws2Z4l?=
 =?us-ascii?Q?4mxxjn5oZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ce8fe-7823-4639-f242-08da1bea7c1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:38:34.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkU4Wi6l0qqNcU5o9QWwWIifNlxMV4GDpLkJ77uPq72s/sPyTjJ2DCbPC9q7g5+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:13:55PM +0200, Christoph Hellwig wrote:
> Pass the structure we actually care about instead of deriving it from
> the mdev_device in the lower level code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
