Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7047528C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiEPSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbiEPSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:04:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB12CDEB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFn0GYdbtG7PhHcIlWL0AN+0hkdKBIrnpuA1/ymgBFmGhLicIk3EvBD8iHuZ07/DWKrKo5GDy7OPfV/kXNXryjhJxESRIYYqna9Nxrwj9msq/Jj0bqwk2qedi2gdrTsztkBX9x+OK4C/IYjWVV8TGv66dvgbjFeTShj9pVC0N7CmXz+mvVCk+NV6hui3ZROD7ScYEXAOEz0XSm9KL+nrmxH3pkQm0n6nZGXvCinhGiP9XVMR8FH5iESoPgX2YDnKAkRm9Xd4q0PNOrFDWmaFO/IXrRTUKITP0av0USXa4GcH1GIzC831heR5b7L0Tb6nI8p3/RBM02EwoTsiSjGKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAh5XdfqRfjT1gE/cXJDD8c7NtQ1hXBoqQT63rLR2Vw=;
 b=gzh/Dnc8pSw6rsO5CyjwxT/ZkUzTPfC0IKgtYXqtS3swqK0lByiunl4aNifCWBKVexyrPnaiJGmKEPdHiR3BmnH55of5aubX7slgPwMa1OyU3+jA+xDuJYfh31O79tcpczm47G9Gm+dWvMgY2y46Hd0KR4KPRM41Jka3wCt1qX65aQLj7UkLQFGXvwhqIi8wt8fvE/X7TiwVc3/6md02DhXJVMWiYFUZ2zq4MD+qaBLDOSQxzTzmx29IQHL89FxXs1m0s8nt1LSD7U03z6DtErC+R/HN40BMrDRarh6ithRssswZmVxlQuGZL/A9YODKB+FMO54M1p/RgO2k7IyskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAh5XdfqRfjT1gE/cXJDD8c7NtQ1hXBoqQT63rLR2Vw=;
 b=P+JfTjMx61YCiUhzIX+HgxnB4gBffRrkWcfgADR98UbsgtGBMhAYXip5T86XTfqOjU7q0JL+APmw5IhuDw4YJLbE4oby9c9xsWcqxozNzsVOY2bx9u+K8xxbYKRgGPG7hqTx/osxM6iknZ7hCsexhHuaN8sokLNvGnkx+x5Z+clobZkews6NtIKcTuN+wfsCLKyrd+VnzbykaXoSJZ9c3hzpFxAP5Ufis4O5ZvR+b3pKiosa53b+7yvOcCbZmzQFdMydnQiQXQ+j9rE1ha2X0LtDdlKb9oWW2lUN1zcC3Z33yTJBvaarjj7rh7uX+KcW1CuQxu/PRMzq1ZBkuW06YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 18:04:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:04:24 +0000
Date:   Mon, 16 May 2022 15:04:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] agp/intel: Use per device iommu check
Message-ID: <20220516180423.GH1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:208:238::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7dd656-a4a9-45db-6978-08da376682b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB133778BE11CA6F03EFDFAD2FC2CF9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GCwosskQnqMbictGr8LBBBpkZEnpCUEYGFhzk5C+/pmexnLBzUTygrpzZc8ZRWq3HsJVnzq/hB6+tk6r2Jc1gbt4NQl6bc4Jprs+6UX23+1ub8tB1JSuHTkoebzTj26uF/tDeuGJ7y7+xc1HEOUqXTTfOP87inQSr93c+j8F/meHRf3GijxZgjo26+cRUIkyYEujOeRlTXwPo76ygAUkIR/+lMxx2AlVy6Z0kr6rhPbQMZ3cdWW/V+u61blJdWE+rArUsb14LX+5tkL0v8vef5fU8UCi55oqN8NexixCSaEmEv0Xb73fpxll1Mn+iYsdqrq6t2h9/kFlkPsQOVQvBScuCW5DKZr9qKYJOysadGlGRl/B0i3P3txH1QB8WACLhyYWk1C6kkMhr91GJkoXu4aX6znL6h6aQnfjXfu9PW5hFXk23ycYzCK4fowJO1msNOSPi5EdIp3OGYYHZgSwDvX8f3CNRtWQvMGqpIi17WSnVWe7b1Egho1Lli/Ai72B7tXT4NICXkSjBoU+QO+RkGU/QPpDmHZMugfq1MAR7L8z0s6FZFe699AY3XfHnP5AiDw34KqW7uhQtMkkMY/YVPnwa4blNe+zng9VcpB2e7G/W2jJt9p6Q8wwluThT3RoWold3P/t1RqjJBnu65vZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6512007)(7416002)(86362001)(4744005)(6916009)(36756003)(508600001)(6506007)(8936002)(26005)(186003)(6486002)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(54906003)(83380400001)(1076003)(2906002)(33656002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7eaQNd4c5B/ZwOBD7HLXSyqdDq/wTpkNxZDHH5u/julYgCN0LUI99OSt7wjv?=
 =?us-ascii?Q?HWJ835ULxl9cMS/Srrs6sbAhXA2iMZ1rPbYPbWv09668OXmtvg//ut5QLark?=
 =?us-ascii?Q?E49QUkrJUu30rAxC8T3IWzvNC4Y/6VrTwy6AUAO3Y4dwcLiAQyU1oGnVW6V4?=
 =?us-ascii?Q?bouJ+PX/J6ovCOJoWE4IzcfqCs0zaiA9r1p0X1cyFh0zrglYcAdrMTdBaksF?=
 =?us-ascii?Q?GOkqOzDZ54ghHfq68HMUbQ/7E+YIK/5hmMQQcTx4NCBRBKOyhVYQ5D5odqNe?=
 =?us-ascii?Q?fErai2iKgdPTIenI6YykybPjrC1WZywP5AvmKhVDmRqUuTlQuC4biNHHHSS5?=
 =?us-ascii?Q?XoRwgRXhQDEytsfgpIjR2cD4JUgBYxGDy2aZpeNAh5pmvmFa9kqGE8AeqxE3?=
 =?us-ascii?Q?XrNI9cwGyrgtt7FptPX5H7fK4Z7YLOuX+ndxJQFYtwscCGSp7sf3H4CHlrtQ?=
 =?us-ascii?Q?dq8hTWAH+V6XCDLEXsdPp50GBlTrZ83MPex56h2a7m67WCyo18MdsWvQ2T/B?=
 =?us-ascii?Q?Qf+7aOpRmWkGcRuZhGYsU+FU0Uuozcv26yNkZjV6mMb8FKCJie8/tyq3at+7?=
 =?us-ascii?Q?u3yOfTKBIZqO5ga2Pch/MpsS9S3I9yY5lWKtCj69wMWetqQMKx1L6JwCLLiz?=
 =?us-ascii?Q?bDxcjmOz7Cpc9xnWk/r4vGWPL+Ou/Q6nZ8ZlEnp5v9TFyCLpYpjuNZjSlxzA?=
 =?us-ascii?Q?7mCigwmQZIpgydbEMq9l+qrU0ZI76pHxCBU1S3zbVgWpdWPIVplAfn+NwRlB?=
 =?us-ascii?Q?eErv+4ECWpU4uPy6SUGjBMkAU/DO0oaPbXvr0wX1Y7IwvSCuNcq1kIpj29UK?=
 =?us-ascii?Q?OgZjoFOsJsZfenrvRA3GvoowkMSFl+bNa+Mg04yjnjOWz/txHmBN6iqd1osr?=
 =?us-ascii?Q?Tpw7CDlTSUwdvfl/GfqHdJUiP6jcXHW7vg2/xUPAmJG27ussEYNqeZcffy8C?=
 =?us-ascii?Q?eqm8H40BugahPumB2Jlqsz56nBIyVPYaP5d6+pAcypT29SDK55DS2tJ5+zzZ?=
 =?us-ascii?Q?jLUuqNWMUmzbknaAetl8bUygBp6Zpl6eYOmHO9+PhqjytIaDXFsb0jC2HMoJ?=
 =?us-ascii?Q?5Nao04iiDqWu7FGn2ZGkYcj6vrGVFB0bbDQcpGkhQZQ8cXA2v2yVzG9sHKjr?=
 =?us-ascii?Q?5CaFbeEwcR7GiiyGfNEVrFrUW1voaVGlhtNopUfllp3mayMaOkM1PUTdZV1Q?=
 =?us-ascii?Q?JF0cvc9JItoLCITD72+M6+F3aPJwe8o7/XA9YVMWSADfF/gQuqpmui/6E7K0?=
 =?us-ascii?Q?K5Joow0UxdetedlVdo1d8su8Fv7UBM5jgzFqZhqQCkRYL7oGseG56bR4Of45?=
 =?us-ascii?Q?YUQ1VLSbE9JK5aRFVgOPeJYUtOCAbAJr2dmS5aTXw1VsuzOHG7+LCD9Npm/5?=
 =?us-ascii?Q?id52Y1Ld68tLUhQFA+me2x5+XUPbkNpO1aWGxduSbTW21TBWrjgmwrPS400V?=
 =?us-ascii?Q?6+XscvoZNAplxaIdLVnOUlSwrNmWdhXQe/RIaHAG+yP3UKsm78MwSqBooBjD?=
 =?us-ascii?Q?+F0clciQ7M9RmiXBVXMI6sfSgxwzB8zzk/HgLtPFH9hUDpv1SviSnoB8rPb0?=
 =?us-ascii?Q?MpkPs3hQiIwGEIRU0A18cIpzTjur5bewZyzyMTcImsgJUx8TKFbx1uGgYwmD?=
 =?us-ascii?Q?pKlfeDWLDC23m0BqqtfJZI9N4O4rqK5fOGAdKGkjTCVWSGwVKGkWbsyHJCfn?=
 =?us-ascii?Q?ZCWFMQcdpXxCvOzd7Zca/9onI+EoAIQHOLebDnbcs2tgIpf3WHmlqFEvtt9e?=
 =?us-ascii?Q?rpH82tBHjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7dd656-a4a9-45db-6978-08da376682b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:04:24.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3pt8O6eQPzg52NljBShATSYYsQJU5/tg1qBA/O6m35b3wWDxyn2gr1vaWN5pz1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:17AM +0800, Lu Baolu wrote:
> The IOMMU subsystem has already provided an interface to query whether
> the IOMMU hardware is enabled for a specific device. This changes the
> check from Intel specific intel_iommu_gfx_mapped (globally exported by
> the Intel IOMMU driver) to probing the presence of IOMMU on a specific
> device using the generic device_iommu_mapped().
> 
> This follows commit cca084692394a ("drm/i915: Use per device iommu check")
> which converted drm/i915 driver to use device_iommu_mapped().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/char/agp/intel-gtt.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
