Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40C528C91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbiEPSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbiEPSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:06:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584F28731
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbTbNp+2ubqJjKx1ILK5ze9w8hQ9JZ2BJGBgCr1GR1jWKYcnq8Z3mr1M98GQ8uFRwYAD/9QJHIKutgY7drvLCe86nGtn+eqWPIAejEGEQvFRtfZPr8XtPzPQ/H1fJOOM8rtUo+pqSIO/E58dJAJj/JRfxUx7BAXXpL+dI9wbflvtRCVMtOgEtrWjSr/TWlROlQ5iUHs+6/1fgcJ54deJUje76TfcYT8BffwW3Re88JQ25KbunMou/2VhwIMkhItiGW24AMHmro3uPP/AElC/r09QDbosI4KuPa2Z5VCvSZ6b+VIXwoRTaiTx2VbxYChojawtm+FzF6meWSx9YkyByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUqFzRUgQMpBuhgSoPRkmFkDxOxdI2cXAdsI+/srlcw=;
 b=fzzgQL8UL72hnv7azRqaao5V9pIFdMKQVYZCK2ymlDKm22T9mPbQdc05roqhKEzGE/k+z3MuRZ4umaBn1qVi21vOMqs7c5Ei9UQPu2em5zt+TkDkhRsr3t1KfFYXBl79+B7Fwzd/yrBy4Zjc2QI9PwumPXiE5OLrWdHRAcm6xMM4UgDgeV4LDtmfG1lyQg4G2EXEH14i4n9VES+G3TZ/KmL7qjlqZ2YMLFkL7O+IfmSl1DG1e7kEUzYEmH/MYvNf+Hi8GwpIm/GibYibehOwx9VzVYKuCBSXbUZe3U8uVQfZpfTirwl7CZkAz6j5YNaoXs7uhP5+5pHZ/hi3V5T3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUqFzRUgQMpBuhgSoPRkmFkDxOxdI2cXAdsI+/srlcw=;
 b=SE4CDvnEzsfu4SS/lrJtkQFOGG8jgTvCrb4/XLsBIvuPy/LFq4Uye/Je9z0sDyW+JTjo/etWBnnDeSgEBA6cEOH7UtvxB223ulkl37N3v6ua3fDAD+U/SL7GqlKSJzS49F07YJnQ0abO5aV94P25afV8Gzj8IKh8+HWtYex/AMoSbVdfROCgxFhgtBzBQmPCRyQowO9+1p2MDZJHchoHVGAVX7/0ymN0vY5KN172ExGL+JOfIgLlbZ+CusvEgUhReYiRUol0oP5mp3XIlqYfiT0KUrGwXd/KBOT3Cyp5nrBXPGAUDkZNXTUxe7FcUjILpaWfXznrwwTwDgJ2EPG8wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 18:06:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:06:48 +0000
Date:   Mon, 16 May 2022 15:06:47 -0300
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
Subject: Re: [PATCH 7/7] iommu/vt-d: Move include/linux/intel_iommu.h under
 iommu
Message-ID: <20220516180647.GM1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1e608c-6e1b-4906-4581-08da3766d89c
X-MS-TrafficTypeDiagnostic: DM4PR12MB6493:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB649331438DB384CA7B918103C2CF9@DM4PR12MB6493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDgp2QZ3XiXFir/apGhkFr0CrVH6XceRWLkHQU7tOhGt6pOiW8PaJcQpiazYJGxq5+0w0PwOecpMGY9kwnRGcqNB2o9R1fPR3LTMtSopbogQ6cuxATWI6Vby9weygvY0VFYiG/Kd7mRqh/v8ozukCZ33Sg1Mmf1BILGCnRQq0UL68PTVw0QNLixs1yPbq5SpU6ekGLUv5/JCK33GIr/JVi4BqPht+qhcch97arjHDWOdtDQp7vtPw5DZ96XITDU5pJ/b0iv27mTkF0rskT7i301YEYSwxCAEK3i7O5D0BkBsVbUjsESDFCgkTieqt8fCu9mFUO7PPxm98kbRQkY9u6+V4V0nHeBOsUuQ13TE70dA0G7Q49vI1qHwKx/0I+RxF5YYb+5Bsd1LDP91x5lF3MBLZC9Ncwl4T8tZ1OBZymesBNslVCK9BpulbeSXMKzQgN36fT2B+ZJYGpucDfDYvgLW+1ZM+NXZx/+/1DkzCl4ERQ+Neuktjqk0NY5EbFHZ4TE4IZJr1Yj0JmAXgay8HLaVhU1KgYd/XycYXi2Yaw9d4xAxEWfDlBkA4wiL2rlyx2Onw6c89zIn+WZ+JgcJ0vs0pmNXfsW+fq1be5GcGGbfRzG/DQdljMS3HIu1RK1JTH4Hehfjvfekkoz72ZceYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(8676002)(66556008)(6506007)(66476007)(8936002)(508600001)(2616005)(5660300002)(83380400001)(2906002)(33656002)(316002)(6486002)(36756003)(6512007)(26005)(54906003)(6916009)(7416002)(66946007)(4744005)(4326008)(1076003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+028O3FYqTHSXll/b6Li8ERL2JdqPUgHUNDebqyaI/8aj8hTP5J3idHxXPk+?=
 =?us-ascii?Q?l0gRwpm9b2T/MeIA1Ua+wFGzgFrG8HPpTj5joFyIMQ/4iMPMSgR179pCj40D?=
 =?us-ascii?Q?4EnAcFzXxITLlXzXkPO5gA7oSbYI16hwUdbgJUgNpGOt2SOG62XOJgxgmRr+?=
 =?us-ascii?Q?O99GmYTpvmXKT4sVY6ngClAzlLi0LkWad3Ilp9O6h6VdzV6sK47RKaa5M49r?=
 =?us-ascii?Q?KItmxKGP6ceuTpcqP46QqAWUBXpdBoblDPbRryiRWdvbbZKTDoTZ3hjDon3S?=
 =?us-ascii?Q?+siV4Kjtl2Q0fqxu4iR0Sc+s2HuWubrM7mdBPCY1QW4Woy9bGAqOcvv57nHT?=
 =?us-ascii?Q?2Vh6qPabQKau1zOn4YNflAyn5tTpSSqmdJOyOGu0zR6950avAYT0hDY4iD/z?=
 =?us-ascii?Q?hZs9qXNe4Mu4EFL915aUffwowp5KKM7vC9UWiBdWd0NoUcmi24hwfpM82uRO?=
 =?us-ascii?Q?mGF532msB7LyrOtxWer0pvRxNwSwwRws4uMTUqqOdze2QDJcY1ss/TM/mEpT?=
 =?us-ascii?Q?bFfgA322yPOPkCVwEWJ8I3HxW0AMvmco8Qof1mpfvDYZLu2VEhQ0vwLqVxiQ?=
 =?us-ascii?Q?P95xnVM3UOtRToX0wbbtwspMT4d0LxOpLDUdoOo930TnapGDGJiveDOEvhXw?=
 =?us-ascii?Q?uQkQKH7ANUqxVljdyfZSXFNAQ/pQr8IBlUuaDXi8vIczTH6+9iaJzGVp96ah?=
 =?us-ascii?Q?0z0cY/Cm5Ymao+Nl+gvsCk+Ycqvn7DU261Tw3tf75PXIc2KuA2ZSdEfZWBV9?=
 =?us-ascii?Q?0woBK8Q0h4d86746zRyhD+h+4wsEZfOSCMVAGCFtkWxitflcGf/71nYkEqwD?=
 =?us-ascii?Q?er9ic514Xq1yJJjn+9izezSlUSZlAZ+TWPNL2vkXGQoKBTvp7ljfzpgoYnua?=
 =?us-ascii?Q?1401upMpgzRuJpv2tqbkUMZ3vTe8BVf+IKXQ0ODfgpKe7ihNIGrQ0RqpCqhp?=
 =?us-ascii?Q?SRIrmaXGlhnRKcaP0TfGKXSL3XvjN2Asmv4iJi9fQThlIw48vMFu6phu5MfS?=
 =?us-ascii?Q?wVtL+VFqCv59FaNTBiq6A+5F8QMasZQClgUASZYs1qRVmK7v32vhLSdXNLfY?=
 =?us-ascii?Q?HMxtHI5sKM7GuDtjMcDimc445L4QDKQMr25h/U0KJBcoFwvXHKNntEQMPtg4?=
 =?us-ascii?Q?7pexhP0b+jNPGJ+W1Xin+rqOD15Z268jiGGrodR640G5fL4TWGCaVCMd42oJ?=
 =?us-ascii?Q?7fGuPA+0ewzM1LmpqkbHviS+mzU7p8KFpBWa/DznjOSNH16pzPWkkoI2muBL?=
 =?us-ascii?Q?4aRQ4FkZlyAsUd4r/IyFUQEPACSDyRaRAuCXyaMIihT7KtEil41wfVYK/Pkh?=
 =?us-ascii?Q?ujUMoNoZbDdbpZI6Mtrb0vnKLhH5ZuXjhZlSfc7860PPDFPTbkx9W4by9bLZ?=
 =?us-ascii?Q?1nxFka+JydGGUBA5mO7dt4Q81zVOHE/Tpt0oBtS2t58/KHd32rrxGxZcmtAJ?=
 =?us-ascii?Q?4s4wHr7lWZw1jMxeXHp2aLJfFzib0RQcYlt3gwRiRl5/hQvIzC10ekcdCc87?=
 =?us-ascii?Q?OAn6Oe7Di2eJmsdRYR75ihqOSRxEDL5gBKB/fvt/oVtCDpMHYbrTr9rq6P69?=
 =?us-ascii?Q?pbucD0A7gpHiCvhJ97Y6+yYL1nn1dU3cQaDKnGzchGGe1OYpoDkRPtPJCma3?=
 =?us-ascii?Q?vihDbS0w63oW+7ksmzVksl5Rcas63HcEy5MIzUYJX9mVTNuHhwnf8qecA1nw?=
 =?us-ascii?Q?s2xGgUlcsrTtMWj2so82GBW/fbRZYOshwP2FAWDdMaiET6rE/FvTz8yY4+kp?=
 =?us-ascii?Q?wmMzsMUViw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1e608c-6e1b-4906-4581-08da3766d89c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:06:48.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Lmq0JNZ2zAeMAGTpK3b7FFfF6ndkrz8yQuOpZRIbxH0d3NIF8HRbmUSnOG53bHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:22AM +0800, Lu Baolu wrote:
> This header file is private to the Intel IOMMU driver. Move it to the
> driver folder.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h | 0
>  drivers/iommu/intel/trace.h                                | 3 ++-
>  drivers/iommu/intel/cap_audit.c                            | 2 +-
>  drivers/iommu/intel/debugfs.c                              | 2 +-
>  drivers/iommu/intel/dmar.c                                 | 2 +-
>  drivers/iommu/intel/iommu.c                                | 2 +-
>  drivers/iommu/intel/irq_remapping.c                        | 2 +-
>  drivers/iommu/intel/pasid.c                                | 2 +-
>  drivers/iommu/intel/perf.c                                 | 2 +-
>  drivers/iommu/intel/svm.c                                  | 2 +-
>  MAINTAINERS                                                | 1 -
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (100%)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
