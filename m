Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FB50A08A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiDUNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDUNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:17:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511862BF3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7QwiIPI2e+Cycic6NR+/ndf2/tvO5BK+iDcaM51Zrtrn7WcBQNeYFpFABthbmNAOuF5q4oXzX2mVrK9tCiE1XeLLRtEFd/fGy6U6t9xlCFlu+RiVoFsFe48JZNm0zfs5ouR5hifR1Gj+Oa1G7KURjr2++Lm6eNiCOEOQ/rEQ96uaweTT5nfSy7+IiO6k1jLImFZhXkV9Pi1OZrS6/g4oXDLhwqQtRCKsg8cYZZzZB4zcTLn1ENTVVKQ8cTgxHwoUjw+V3gINzCpVjAcms02JGNqKPebJD8/w2gQDWtvNrF2OJTiiockT5hXao8MzzBl69LvH2dN/e9L2//8rlZcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRQn0dgBP5sM1QNKK1D+MOvlpEqxFiAjTN7Dx3EFuM8=;
 b=Y0JI94c7H2JP/CEQpRc4TL3vjvO+eabOk4Lu9DeUPrkz9zt1h0Tt6TkNpjwa41id0fX6xDFAj/yxJ4vuzdmI/8WdFAqwJidGz/xHHDic9gSaipXSWHhwnuvmcXTJ6wzZ1MXvVAJqVksiZvtVY05+2nxiH8XDaW71XkJYg4wRUlyGNHl1ahpR7K+dELjiujvnpj2oREVSFzUKNOH6fYiPGjjQloJ9un6Qs4aTww1DiVY6ToP1zteSCdD/aGSrogc1Hhh4IwK26arKKC1NJtoMLMQGS8BfjOZxJludfHfEqhdmDHMr6lJlbzSf9bGjpi7mLguuB5JOYRNqcu6+JYcPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRQn0dgBP5sM1QNKK1D+MOvlpEqxFiAjTN7Dx3EFuM8=;
 b=S/Izomt1bpLcREStPoKeGBq63IoT+5MxXL385r6bUWLaxGfiCeQGSko0R7+T4g44TpaZYJcrsIv9I+TJ3Z5t0OPfH31A3P/j3R2XnYCIqPyoPEDQ4KV5UkJCS2yjXv58Q/9xwcMBlpb4iB4N1fVEVIgdD+WVfcLlBNfjfUO56r4H7T0XF98fM8pSaJ08RQLpbruGKjBhDY438qhXotWM6I71Cf4arSBHa30KQOMW8zs+xYjzrKM20aU/zUE6z+p0agdgJAS/kMYXwHXlfdECXnMLeYCak4eAxzDYlERXvjqZiYUtS62R+08FvMJASWc8J9+zfF7iDXysokHlnDbAzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 13:14:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 13:14:56 +0000
Date:   Thu, 21 Apr 2022 10:14:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com,
        jhubbard@nvidia.com, rcampbell@nvidia.com
Subject: Re: [PATCH v2] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Message-ID: <20220421131454.GG2120790@nvidia.com>
References: <20220420043734.476348-1-apopple@nvidia.com>
 <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
X-ClientProxiedBy: BLAPR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:208:32e::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ede226-091f-4cff-0088-08da2398edce
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0057:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0057E27EE953820F327BC222C2F49@DM5PR1201MB0057.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v9ODD9wOB8mGoNWzclZUcut1XjrirCk/rzALuJ4TJv8yiws2RbJ+oVG/YuKMjYY5fXfCFjMD7Fbgq2z5tLPcwpzkTwb9qHJ+3xyJz0hzgpjnBT9FFuoLaFeKUrqieeBxi/OvLINqgI9je17LG01dzHSH3KX/1usACKtRcSOUjX3bqDUQYIdsBqcRpxYe65woHO9eJJpqU2ehvwj5qx2tIcYnXb9LKCeqNNkkDPbRQXIKYnnjo7CF0NW9ck4cHwjwL4zITdUYzPoW3v8LdorQRMymmfSBz11jph2tFLJniZ0ehGaS2Pt+SjiWy3ni5FKQfAt+uowzZBZ7GGjjstcGRhbjNHnussaKjH+a7GZdjsBNYh6gAjMEKvjfJWJbFRmEsBNhPfMLOnEHVEmcKndfVm/Z1W5rMwW0E1NK6mQYwmck1mwxeaua6kZnSkd6Rb3YzrVERJJmbfVoij7quj2mSfhQvQYrMd8AhKowq6hdyptqAh2MgjDqtXIy77JaS+19j/ClDFl9tWE/6WZyjdwHxlbrV2lGSqbiE5jsdXyCNAOdaPtN91VGVsZiyUJUUoMpxK8B8qL92dI6HZ6fE3A+Sp2UMLIANNNo05SU0Z0fv9fCxPL8+HzBuKW/ajbp3mBVR2ytybrRcDzSdLwcE21tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2616005)(6486002)(186003)(107886003)(508600001)(26005)(1076003)(66556008)(66476007)(86362001)(66946007)(8676002)(4326008)(6512007)(6916009)(2906002)(316002)(38100700002)(33656002)(5660300002)(36756003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKjiTAoGvn+0QNKyI2GVfA0mod5ks4Z+ABMKX0zUZVBTQ6EWbCLuo+7Hg16Z?=
 =?us-ascii?Q?iLj2A4dk/2FJkloxDVbZUbVhj/P/nibn/WuTaEuDi0jD8z3l21cyi8EKDQOO?=
 =?us-ascii?Q?CgvCpwIL62fcIE3tGQ+nuhZFA7njqUeJu5JsKzz8OVQOKGdfX6tyVL4TS9aa?=
 =?us-ascii?Q?B5jwEGv2ZlRJuefHXHGmaj2Po05V1wzG2CDJq7aj43qFc0rVt38JKnFlFoSh?=
 =?us-ascii?Q?jox5/IA7BmlGjC4wNITDEGWt33XS5VeOeDd259sBeq6sfuM3ZVaP+S4jWIOl?=
 =?us-ascii?Q?JSYGDUu6eMjgFaDSfS5CHwTD9KbpDIK7tuzodkTN2qp/XEDGxefDa23VEnPz?=
 =?us-ascii?Q?llw9mJTBxUukYe1Oxyc2ySnUJXirxvvNFQkdfjDTjgEbASRNuuxHF8TFpnBK?=
 =?us-ascii?Q?Qo/VNFLt43qga3l4G2g/SCsh62P4PQulONWOCt7xO3+1WaS2aSKML1zVfrwV?=
 =?us-ascii?Q?4XqlVC2S7hZyYUGe1YAEJXXD0so8okVl8ZMqFG37VWLcmzCzV056MVZcKAgV?=
 =?us-ascii?Q?U9U2wYHNaSUuN0KewQnYa6T/JkFC68ZZHVJ7VIOMlBtq88AnAprC+NyGPGmr?=
 =?us-ascii?Q?ihXQsVPHAMxCWBjMfAdhedbfag2klAK2vi7+2YIpyRozjGglrRy5Px3DCYZP?=
 =?us-ascii?Q?CU+jAKWd92Dbp9fSQIbyj3msyNE0+jVImwAsb5ByqG/Hw1+hhSNy6mlmjA2E?=
 =?us-ascii?Q?icgVTME8vzbIrjkb28hJ8dov+ZiEd3FIJrCnu19nOZ/DwPR7LJW1Q9TLX71K?=
 =?us-ascii?Q?/gN/xlmSDNoMjdq/qnuJJBicFHJtoR14d5odEa4HhKy/vGDXdLuu7rHDUCNM?=
 =?us-ascii?Q?2qJRlsK00H5FEKDIsr5uK4Wx0WpwAeKwT5KLjDryLAqSxC3Gd95mHVPlI4Yb?=
 =?us-ascii?Q?TEO4PSqc1/A4rJbgTHE6WNmUC8ABEnubFfEDWErepL9pvwuwibkxKL7PzrWC?=
 =?us-ascii?Q?NJN/LpZ3pzSL/faqvGRjbEkyc9HWCg6yQjp+ughSTk6VlCOStfwmG3gWhw27?=
 =?us-ascii?Q?FeL15Z7/o9OOWv5Jo7AVhr8qJBDFvLwmja9aqKTNbxwGgODJPjJ7z17kArNk?=
 =?us-ascii?Q?Q7HiyiYKsNQotWkt+bIeAUyynIoX3uuzBgY2wDIva4YQoFD60KvgGzgxon7m?=
 =?us-ascii?Q?zAbikMnZ5VnNCAD7p+HgrM4YQ0+1UShZZpOia0zJ312ay9nd+YKviAPa42JL?=
 =?us-ascii?Q?cyWz8gUc+PTa4mjmioVGWbp5HOWEk+t0ja90KmY+O3VteLowlXkLaI81r6WU?=
 =?us-ascii?Q?TGtcPelevGIi7Ckplm5OJUrNlhWv2NJ9iSYokpXI39gclzr54o0g4fI/nk9A?=
 =?us-ascii?Q?o9diMNwfVeyBEZm4tkyPXexX7nasTFX2BktUblToqKBNjtVyT/reBdKDE9AM?=
 =?us-ascii?Q?sBi2V+tgxcRiPv3uKI30+YAyQLZV0Qru7Ncn2Vpj9nUnp8smYUWhEy1Peepm?=
 =?us-ascii?Q?oSnvKMuN+Q7wxXJ10ruJCWogfLLkRGP12g2FXAobQ1vxIACMEysN4wpKaz8n?=
 =?us-ascii?Q?g0F1nQjouN4eqUUVRBYtBtjg7K73pV9Orsrw07CxPkTzhEU2n6mnlnNd73h3?=
 =?us-ascii?Q?dTUQ1QcyEsb2aZ05XGNKG4Kjfo2BX5/dXsCYDKMLsHtH57UyZGGP4us0Rr07?=
 =?us-ascii?Q?FSS0vpEE6knd5OchPKLHTH7Ez8kd/8+kf1QfsdCwsFN5fycNOHGZetgJBqrE?=
 =?us-ascii?Q?HaVjhrj0ljjVFYYjievIVFayzzC8Dtf76NaQbzpEPhS5vanRH1vmB0uB7UAO?=
 =?us-ascii?Q?H85TCFIzkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ede226-091f-4cff-0088-08da2398edce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 13:14:56.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tufWCMuSBCm0T3xuux+KkXdM+8fAjtX7EpdV3ZnAZn0MR+keD/16AZuNBt0ckL8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0057
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:11:42PM -0700, Andrew Morton wrote:
> On Wed, 20 Apr 2022 14:37:34 +1000 Alistair Popple <apopple@nvidia.com> wrote:
> 
> > In some cases it is possible for mmu_interval_notifier_remove() to race
> > with mn_tree_inv_end() allowing it to return while the notifier data
> > structure is still in use. Consider the following sequence:
> > 
> > CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
> >                                     spin_lock(subscriptions->lock);
> >                                     seq = subscriptions->invalidate_seq;
> > spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
> > subscriptions->invalidate_seq++;
> >                                     wait_event(invalidate_seq != seq);
> >                                     return;
> > interval_tree_remove(interval_sub); kfree(interval_sub);
> > spin_unlock(subscriptions->lock);
> > wake_up_all();
> > 
> > As the wait_event() condition is true it will return immediately. This
> > can lead to use-after-free type errors if the caller frees the data
> > structure containing the interval notifier subscription while it is
> > still on a deferred list. Fix this by taking the appropriate lock when
> > reading invalidate_seq to ensure proper synchronisation.
> > 
> > ...
> >
> > Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
> 
> Do you think fix this should be backported into older kernels?

I think it should be tagged stable, yes

Jason
