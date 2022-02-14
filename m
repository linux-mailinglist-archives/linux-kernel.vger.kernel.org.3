Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311374B5198
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiBNN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:26:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354257AbiBNN0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:26:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39448890
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:26:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT+CVmdZecKieZDgbYoPuxhgwFkb1SID+ujD29itg8xDyHn/5FjuV0EpCIWIJ4bfjdf2pkL3Gp0GNUhk9a5lF9F7oI+WWelCq/5Q7k4rY0IQ3n5KtJ+9ZUEc+EvHLqSpf/m+uMchE5kJxH28vOOOQ1Vvp4Y43f0M6Rd3hVrLu+x+XXHRawyUwIMa3NNSSFKr8ExK852b6ozHGlH3PDJf20Ix25YJ/QvgOfj/bOJJr3lBlrg8BB74zs1GJH9lM8zZexNrezcjK1634mPYE/5+XKecLr1i4mB1ZWmzT2D5dsEDesK0BIJv5E5IP6P06KZ1pyn+4v4l8U1n7jwv32v6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgy3dPdcs1TuOS3t+JUW90yHJzHZGXd1SKdZs4z/1Ew=;
 b=CwA0HQT1lBeXP+1pnUQI3DF5xgzSoLknbmYeFTyxjvEOwSEFcy+DVIY7ePWfG2IuLHFBAXLxvFfXLRFP86jjjWgmhHxPo8YVboMJlUY3qh0wJlTnZXYa/prplBDNRMGhkD7FzKC9RqhYciTURLe0w85C/r0eP8c53qdoQ2QRhI6J+KMWkwBX/JseNT8Yy7XK+s6/VkC7lckpIJAYH+YZ5oWZzAQVxswpUzjJWYGnb3TM/ZxmObn6Bqis2nzkE4ru/As2ZuTGM//J/YJ0JOW+5Wm+zGeyunYHb4suPRIiT2zmxjLxQuvR7DNW/sk6kDvv/vIPWFesbs4eTn35T5rWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgy3dPdcs1TuOS3t+JUW90yHJzHZGXd1SKdZs4z/1Ew=;
 b=IS7e/oSXXux6/h36vNBRjpa0pZT8RKv+c3qcbFgND5kD+gL3yB/5VsOoucUSlz1Iq5+01RU5QtlkTo2JLQ8LyOv6MkVSk5dDw0QonJVTSOh2l8ptEAQjEwhxJBo03jgW9bxT3qc+53roewIK/FvT3fb2n9gUyMbOiYouhHLl3qfGWrH0Zr3mYWs/yx0v0SG9VB0mPcMzmbQIOfdKKycjJrWO018Fdth9eWc9ywi7X46tFt6gRFzKnuwcGLpyf/eewqXI0AUhd0x3J7sRaU5zdOJQuwK/9ptiJOMpNQCSUf699VQpVfhmQzGA2Sn2Oh5ak88cAcI/srQ7Hn4MJJV/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3490.namprd12.prod.outlook.com (2603:10b6:408:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 13:26:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:26:10 +0000
Date:   Mon, 14 Feb 2022 09:26:08 -0400
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
Subject: Re: [PATCH v3 09/10] iommu: Use dev_iommu_ops() helper
Message-ID: <20220214132608.GA4160@nvidia.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214015538.2828933-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a682f8f1-5225-4a32-435a-08d9efbd9063
X-MS-TrafficTypeDiagnostic: BN8PR12MB3490:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3490BAE51E2529050B54BA77C2339@BN8PR12MB3490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gN8e989RuRB28HwYOPK4c0L5VYuWFGjmOqHw0pmavkrbGhPQsd5LRKmhfBobl4yVkOQewk3ru00738JEkmsyaFRCUiQqLbljVJiyeXoc1VGh6pO245SoPkD/QPq0SXGAKCT50s7QnDslKJmUsSIvDG6c7HpR7hdoMG1nDuJCkfOzl8/MIBgyMTEKKNIcUk/hy6IXQ2ZXyhlwpeUAQ/Us2u0quPDJIbcsW5SJTRFiWtKmaxslglyfyFZBcfC9bV7YxGLISUyZCPZZB6m6+iazAoijQTGh8OcvBTl5D2m+zZOU5mcQqa5h9Kric/KmoltXG+YK4o00I1jFGS6II9qUWSGVK2qAL1JoWhHo7EmBFEHI0QdLvPsOuP3NEW5AO4JGcS/hnBHmxDduIrB2GIwsQwNWtywfns5BpBIUiI+1ZeCsXuGgSShwbGp8pQ/gYtxbOu3TQ0LvOQXgwHLHn7pzyjuMCq31OfXmtFw7jnpK7eme90wLkoDax7Hx1rj2QccKFgCswbm/vmRiP8gTu5Ma5WAhWN+VOmm+6F07f4XbFh8PbSdK4ZJvTep+wezeUvLfgr5hoNurkn3Lc4t2PlLSRTthCfNQDaHhvEMMnJqgPAmV8sMaQ4Wb4FfzluWOMM9Fq5s+MHSOI6G+MYdDPXM5Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(86362001)(33656002)(66946007)(66556008)(66476007)(8676002)(36756003)(316002)(54906003)(6916009)(2906002)(8936002)(4744005)(5660300002)(7416002)(4326008)(6506007)(508600001)(186003)(1076003)(2616005)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWiqEuR5SQvCeq7UjHkPCslnFq1f4UvRVUhotb/3qcBZqDWDfukeUumKF9Dl?=
 =?us-ascii?Q?zCFe/KUANj7PjNZM8NN78GpHBwUW9TVCTA0Qori1UOJtBwhxlAukJ/UgQ0cg?=
 =?us-ascii?Q?DweqOAIPhm+MJ4LllJNWEeWdSDdQmErECV2y53cLWlLtq2+nv2dueDjzXR94?=
 =?us-ascii?Q?CvTYvQHcKoNRrchFaJVsjWxpNQTtqtiudKkPeKUDV78hcGb+vsuLyg+tHq7r?=
 =?us-ascii?Q?jpVi5cIV5QQ4r9j+JCKKQgKUC1Sbi0fTjzM8wR8V56zXROwyne6E9cATVnqU?=
 =?us-ascii?Q?6pgSGNGhZHZv8UX9xlzO1A5ebJFsEaI0CY0l2sYJNATr8dJl8Fdbvj7aXReB?=
 =?us-ascii?Q?7E9samDgFBwXsAOIFrzIwAT1iqSguduXXzdObkrZYnBwLJQ4Law0nDk8Gf2x?=
 =?us-ascii?Q?9QH6E3SSLum9OvzpbODDlMIYXpJr5IuvuXGLbj++kcwom4TR9IgarZOyjOAy?=
 =?us-ascii?Q?NFiVHemvnVML2Y/WDiODiJSds4MP8aBbfFjBHjEGhJajrQm3OYBjN1ngYJgp?=
 =?us-ascii?Q?XCGnO0IH/zopo7/wxXKfn4ad1JuyXs9MPKlFmFntjU2sBawB7aJy2rCy1W3b?=
 =?us-ascii?Q?agiLX5lkVXFX5GjNQwGVJsllxWSExB9zC8WXItY34VYqp4rpiT3z5j7orZMN?=
 =?us-ascii?Q?c9zyb7Q6OCzFzNJUsEEX7kRkPgYDlwmLkdfW3FvYtwBx5tq3p3MvbzBCletM?=
 =?us-ascii?Q?Yxmp9O9mxTUwaMJ36dycSOTommEwPLgmWkB+d7N6R3zJ7FH2qffg2lBl8ymx?=
 =?us-ascii?Q?A9lHYXpDiU5GOVlHqWvYQu1HJP3QiS+rfPmbbttgPVuHGSds+dNRy7q3EIDM?=
 =?us-ascii?Q?ZCPF+wfaeqwWe9WmSXw8n+4EexO2HCkZl5xtq2KeML2pcyIXTG2g0Zgyq04h?=
 =?us-ascii?Q?QddJVgE/zsk2CEFm0c2rGLsNQuj0O8AdCvMJA+WCHTNxzLtGawGMsCDoTIrJ?=
 =?us-ascii?Q?5OVlTVGtLaWiu2f0NxI+uqZSjcnS5rFOuH5rX/b9vw8yzkCCu4LZwkduuN8q?=
 =?us-ascii?Q?+YMtsfmZmAFOBKpMB3xNzijnS1hWnadPO+N0IAGMVWva870OSM+tIdnnUqXK?=
 =?us-ascii?Q?N2nrELJGBJ/6V+QBYyZd0A4yuJ2COrvPiNdsgch4TeSXCQ018gpLtTiwM9X6?=
 =?us-ascii?Q?btkCF0XALn7ZNFRsS6mHSNW2/dIfZhcs9iYOKXYdBdpywmvcmeyAPwfjZHNt?=
 =?us-ascii?Q?X3SW9/FqKvp3Ia/NtW/fjaVp/7UCNx0af++oFcb24fkVxEg+fQmKdMn5RTmg?=
 =?us-ascii?Q?JQdQ+UfSH0d9Ke5eLgO1OOm74nengrmkqPJ8LMoCuTyxUcmB1kvR2fUAM3BL?=
 =?us-ascii?Q?HBXF9C+X3B8F/5+enkreN0kQ9W7j+YV1/gozaFzKrhxRvlAl5xMVg0v0bkHF?=
 =?us-ascii?Q?xKt8iMwcxelfaA+Gwi3+9QebVzAtbHJrQ4C2TdJENRruSntIaQtgfjAAA4XP?=
 =?us-ascii?Q?2Z1l3G6mECsW3kjz2Fpet59nvzHzlzAMKFvueLd/ZhqzDUR4A/n/p9exj1Qd?=
 =?us-ascii?Q?0YSOHxHeJIoiw0QVSIUw57PMxdByUUDeNNJgTsi996vJx1SiVZosLejblVm+?=
 =?us-ascii?Q?xv5fXmdliHFrc3SVoGo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a682f8f1-5225-4a32-435a-08d9efbd9063
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:26:10.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4EiCtPZ4x2h7IJ9YeQJNpbXIYF4S/frd5DtYTxajy9ayf5HAwCR0FRQ7IXEqXZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3490
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:55:37AM +0800, Lu Baolu wrote:
> This converts all the feasible instances of dev->bus->iommu_ops to
> dev_iommu_ops() in order to make the operation of obtaining iommu_ops
> from a device consistent. The dev_iommu_ops() warns on NULL ops, so
> we don't need to keep the confusing ops check.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

I thought you were going to squish this into the prior patch?

Jason
