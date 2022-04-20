Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327D508D94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380729AbiDTQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380724AbiDTQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:46:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A74666D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2n/tRwPK17SJ+eysE/jVsDb7fZxjN9bGJJqv8+0m8HlHDzyE+b7KEPkTOkBorBTvqMMbCBplSxJGGZF59+0rc691+sxx+inbbocAn3oJTF0fzvQdeqlgypsiQbi5Ycv3k8JLtB0NSEmKC8gOY5i3XG8Ph5SrSbV4byWgB+Bpd1xrwboZcGcYbiIJMkRBP7KLWhEWwldQf3HtZnPnAptrUwJTnol6Lyl0p/fHHaMoYbFod616u6lyOGRNH+fN5tj5GQGHvJ8uuAc8uYGYWCB+a2BGlnFjED+R8rZODF6pZbGsqIRwmcQlf3aWK0LIQgVzXqJ8FA1XAb1QH/B0MGS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XryMlwN2p+Asjqt5S01Kt13ZxN9m2lnbd51vZSHGPU=;
 b=Hw61IjoZueW7VIOzdhRjqF9VSF8mzKWtU+uOpxtY82COY4IE80PAj/q1CZOSf1ksDfGz8xnyGAZEOHfRBSTAuQR+2GP0BHvypk+8Zsixsda6jN4QfL0iO55hCkUseFKeDpaGsouPIripTkj5l98yji+5k7a6NxyF/2ihYAbVrOUjNC83PASiPa/A5LZ7a1abJXlsTKs6D5fjAmr1w990yU4vQRfe2ii8fB/f4KstvUtfMryPVvR5pXnMAc5pwv0ctKBfsqX+SQi4Eaeo2OqqNNuvCCR5YUGpGerOOqz6hpRB/LviP3SFQj0MDk0XkPiLs4VJpcOPuFh5V9Gqp/slCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XryMlwN2p+Asjqt5S01Kt13ZxN9m2lnbd51vZSHGPU=;
 b=tVebin3s3n3BCZFOW9IgW0PqRHurht9s/j5zH+6nG2HG8gicp66Nfbkq1kLKrm0yAXIPubCGxXsHGbIuZaeDtFqWUCZtjzXpmBxdp8q5IESh9WSTgr416xJjXR7U9Mecx+cHJBYVaZ9zY+ZUyBNMbXsw34dq5x03UkssBQcceOTYsLt63yYfM+mo6G7ranpJVt8jNCN9D12vkdjDiN1g4OGzHbCYhMooza2xC2WZhJYVqjB0JKiL3p2uToC+lNZavUHXXKcIafBnhvOBM+m/yAoPKDsLDIzxRagpxdSS4NARtlhLuIr2Qk2Ja6ln2Czh+XzTO8eRfYPj2r1Nk/Pd6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 16:43:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:43:52 +0000
Date:   Wed, 20 Apr 2022 13:43:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PULL v2] gvt-next
Message-ID: <20220420164351.GC2120790@nvidia.com>
References: <5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com>
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf09e86d-ab82-42f4-f1b5-08da22ecf3b9
X-MS-TrafficTypeDiagnostic: DM8PR12MB5479:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54793CDD2977E336FD1DC521C2F59@DM8PR12MB5479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLTfoH7+tujzXXb2LODizGcrvtL5JPcgXpNgklz/QmqdCemGcKC5hclvAd8wP4bOz3d7dorOdOFWUEu4niQsxnLKBsU3rELufozsY27mbAVf5XpIdvD6gZ2F84N5tCIXS1mmfyWWRGOI7e3tBXNjT4erTl+eDUiOj/syOciTFSLZ7pe6riLL0hY901Qsxl3q1FDzY3oRpeavWOXCCqAHDdTPFJGuypL0hjjQut/XanGsTjrLyChTuMcR+fLlJEydhVazh44Gz3BBEv2kU9yaHBSDqtc9iwmyvANY8h2uYkDKsCB4V0Io1SLTf6VPhXL+//eQRzStookW2do5PSPx+Px+TA9WMMjmioPD7scILC/CDTBnmDmznRXc0+LsXxla317g4pKJqBnlOvDiKoKheljzZ9Yug3oFORvGHhSLmTc/pMqCpZmT5euo1oHl5XtMRDjDeExUmKXv8dsrJhdCHNT6pXGt0Ujx40JRRlgyx4uJAgbypdQauyFIDnXeF7atbkgzZn8YnfbjavU9YZNt1PsiSfyB4uSOTctvQTs5FWieRHFjYwla3dmUGYSKWFrv3CAmnIiqZNntfLiKKu0G7/yGmwIsHrzMS/QzKqdfUVcnm0dhO+WqD6zlKj+tra/mcmFalemw8PnoOUZOvUpeqGHH1eERAUvWI5yY8VwJVH93LGrFsVYSQLrDv/qKbgbxOw36eOPf4sgIa5INa5yaXcgzK0oiCdocP1SqwxiiHIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(1076003)(2616005)(54906003)(36756003)(66946007)(8676002)(4326008)(316002)(186003)(66556008)(6916009)(66476007)(86362001)(6506007)(966005)(6486002)(26005)(38100700002)(8936002)(83380400001)(2906002)(5660300002)(508600001)(7416002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hp0XrAwHHw2L0Zi3Nf2fWUDkXH3i7/eUhAnD2Ugcx6DsK372lndiKcPiY5wg?=
 =?us-ascii?Q?IC0FBbVMPBbwQRfB5qfSCCQCFmJCZp9X/jWpwNgHaorJTrkL8zdmE4E0mfOm?=
 =?us-ascii?Q?x7/BHQMJEFgJggrX/Zw/P8gjdibjqsSi4p6CjNuuy0ib7e2/VbXIyjLI1yHv?=
 =?us-ascii?Q?b/+icRYJZnK/BxsMcEog/1Hi2MxzbUEsT07X6uHouQmdi+snmYYPOjpwAUdj?=
 =?us-ascii?Q?ovxZmtKVhDC27A6Ag2lSxxDruPr5dfU88vV6W+BRD7Qq0ccedKhwYn7/8BXs?=
 =?us-ascii?Q?XvSq89vxLdRQ1aIRMfQ3ZnmLu5LylZYmoUZ/iBUBne+D2xBHWxn2+Z1cHOlc?=
 =?us-ascii?Q?rFAd7+gb05SLIfmpIWfwvAFaFo6IRLgcJc9t91/NZJR4abps30LjyrJ8VXYE?=
 =?us-ascii?Q?Lfxsef0nSky/zzGCAl9O1BRF6siPzC7wkw1gInD8R0aXIQzdENujQmwSvjJu?=
 =?us-ascii?Q?ArgpHC/ByIouV0W5PVLbuU6Naz92JELgCSUFLu+g5Qbdlfwct25laEKPvVNk?=
 =?us-ascii?Q?F2Qn5EBTuCebcf/0OHNO5HvciPbkvpc4E1uf51M4sDfD+gCE/dm7d5MAPmml?=
 =?us-ascii?Q?ejUUKNLMak/5rdudon1p6bedKWUBMj4tI1/ezjR+n6ioGqy8Yj8p/mBF+n6t?=
 =?us-ascii?Q?GiJ7nsZ1W5av1ptcWT3S+DqjK/Q8GmLBDNnypzlGQwv7BFm9OxnnAg+SP7TO?=
 =?us-ascii?Q?nwzdILTQ+IV7oMps7yVxG1YLavIcRkzp7BKpHR55VowBdYhnt6bXOx3LNCZl?=
 =?us-ascii?Q?jKWr/YNfHqO6vmB0avRTdCp+41Egwb3e10plakGjadwx7MdZ2Mp7NpCysq7d?=
 =?us-ascii?Q?jh6wh34CU55Gk9TRIp0d0zD22bbKpRVmz5mPwbxVbvKxwy9NL11KI6xOLI9I?=
 =?us-ascii?Q?yw3FvBJ0HyNTcttBBEXRuXiQS9UlnL8T8VHlV+TKT4saTTWAIG/3gHaTYVAC?=
 =?us-ascii?Q?f1NPUN6kH8l8IKH4R8yywaERo+oZf3kj1CsNaJP6RYjPy3ILCLA1zBA7vM8c?=
 =?us-ascii?Q?Y3fye4+rhpcvE5O314OSRq+hr12WL0sA9jwQeriv9wYcxWaAS2adU0qz/ULi?=
 =?us-ascii?Q?Bennvwi0q26ypuANU6bmwqByvzIcmbUaNiOL/aizceocwvWmmWM2PbTuFwXa?=
 =?us-ascii?Q?Gb2vWO43FTbSF6re+vi59Q/4un6S8yK6hLiXQ5ra/WYT4rXjCoDlbyl1Y2rV?=
 =?us-ascii?Q?fAssW8OrgLj0kwfQFeV7XTfHD8FfQCN4BTAGqWhLPFHcpEs/X2pSDnwzExUU?=
 =?us-ascii?Q?Bc9gIlBc2AxzdIbVbuLd+7ii6IPWKe8xytHOIRaSzExQJ0m1Hh4nJijJH2Zj?=
 =?us-ascii?Q?wmrk2aTBt/LLHLiAieGQi8h06o14nSO7qZXZNh+IGPQcU9Lq+Xfd7RYrOGHI?=
 =?us-ascii?Q?orFDvAqHGIwhRmREGT70igit9qVXuE+jZncbITc+uu9kn9mMZofLBmEd8XEi?=
 =?us-ascii?Q?uz8UiFNo47GsA34ayRMTg/khSChwsxsCc89Nm09wsry7YgE981ivAH/Zl1Yv?=
 =?us-ascii?Q?cCC90ScZwSUUF2N63F10kaIwzAn5FL0aIXOwV9tYv5SjoIga+UBJyVaSrsuu?=
 =?us-ascii?Q?7uM6EpTw/TFCrUAhD953cT3LgDFTbIlisgOv/ZavSiyvePPvwyonEjyMzOLH?=
 =?us-ascii?Q?Zmy85nLFk5+x/xpMBf31EV9YjbDGHcOZtJfJROOaWm3NEvqHl6NPIr+0KS5O?=
 =?us-ascii?Q?aWX6dPAd/97Y97mBrZhMhx6yJ8O1RIlTrNpbfbNg+X2q9KJxnLJiitWWJiNi?=
 =?us-ascii?Q?OUC067xBPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf09e86d-ab82-42f4-f1b5-08da22ecf3b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:43:52.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB0czCPaxCsEcPBKGp7Ec+j54hTY178bnWDWQ+lml8gR3lO97j2NuFT0sFLipivQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:34:47PM +0000, Wang, Zhi A wrote:
> Hi folks:
> 
> Here is the PR of gvt-next. Thanks so much for the patience.
> 
> Mostly it includes the patch bundle of GVT-g re-factor patches for adapting the GVT-g with the
> new MDEV interfaces:
> 
> - Separating the MMIO table from GVT-g. (Zhi)
> - GVT-g re-factor. (Christoph)
> - GVT-g mdev API cleanup. (Jason)
> - GVT-g trace/makefile cleanup. (Jani)
> 
> Thanks so much for making this happen.
> 
> This PR has been tested as following and no problem shows up:
> 
> $dim update-branches
> $dim apply-pull drm-intel-next < this_email.eml
> 
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/intel/gvt-linux tags/gvt-next-2022-04-20-for-christoph
> 
> for you to fetch changes up to ae7875879b7c838bffb42ed6db4658e5c504032e:
> 
>   vfio/mdev: Remove mdev drvdata (2022-04-20 03:15:58 -0400)

This looks well constructed now! thanks

Alex you can pull this for VFIO after Jani&co grab it

I'll respin my vfio_group series on top of this branch

Jason
