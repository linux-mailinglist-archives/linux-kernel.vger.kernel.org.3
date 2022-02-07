Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA04AC35D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbiBGPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiBGPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:15:02 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBDC0401CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlp7PJ7trw0mI9CIb5J+PiaXz75cSicov9rbosYHbYY8l1PucLMXT0TQDEJPSxG8b/6rg2C2PtschKIBAr7fFWmiy6dbM+GkH5Qi13wdbr1/7mfvEs4sD02aEzdQg1XSGZAsNJ/6TprAjNYWrJGi511aB64LiB4eQ2j26F0HsywOf3ub65LP58kGu256ejMl4kpky5jxW2HDuBHqSRv8kFNZR6wVNYOIvpa9D3SJ8yD2eIqa7YWQvZpi931dZV1eEoPz+cGPUG8+scsjgz9Ti8bArz1cv5qqPluEDpULlJZa1LqIVk2me/AzzFMFKWYG6YgfvCCjs9VmoFQijB+Zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWq5Ivu1vvt7LXD30krMpU7fMxOlcKzH9TyejkD1/24=;
 b=VRAJ2TAT6K6cLsHRgZhUvX62p97xHnk+hY10OLsnXZPzrtGibv3OueSoWClLEZ3d+znjDbxeDLOwCgpVWOR5Duimjv+iFbxjjFc5r6I8+vdshCwHntujqGoGqWmKSZHz+bDlS/WlS+44Ql2z6AOHHJVHTpJgwm5O/KeB8JAOebPgBZhnikAhcmTPhrIG4ymexWNvxUGzUdgUDIF3lJGpvB4T4vH03hfuNMKyy2vpMhMERunpJzDdhGQaQaDkKDmwFTVQsHNyACddD1uYXnc6rHFke2hOuCxkuFYGzWBBe6hxsEHwFjRXN0WZlde0HlFS01OsIqnmwe9iO5AAcKFV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWq5Ivu1vvt7LXD30krMpU7fMxOlcKzH9TyejkD1/24=;
 b=cOBvQq4PNFV8353+lvUjFlP8ep7l5nsmLINeGXT5e+c90JAtpLbPX97LlCMC3jIrRYPiCWcBAnFNp6DN6Fvpm9gVHKGkS7XawhWR/6TWXgHs5i5CEO5sJBsa7fhB4Y/ea7RoJ/sb3tn01ksKdcxPvb0x+otoqokV9tVS3Xgl2w0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by MN2PR12MB3168.namprd12.prod.outlook.com (2603:10b6:208:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 15:14:36 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::88e7:cc12:9082:743c%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 15:14:36 +0000
Date:   Mon, 7 Feb 2022 20:44:22 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <YgE3TrBrB0psljDk@BLR-5CG11610CF.amd.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com>
 <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com>
 <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com>
 <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com>
 <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f93f001-5d10-4218-f17d-08d9ea4c8d2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3168:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB316862012AECB88CB80B4C41962C9@MN2PR12MB3168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbE7Vmy36DdWMbFdPAGA6FwKPLkgRJP8xUZR3TUxx9i9NdUcQkFuZk402sUQ2V3xbMuE6R0JjxjZPvMNxkCm3w/RGS22XCw15Cfp/JPuwUJLoLOT6pBSDEQHoOMUmBIHHWqQGpbH9qK2AYWrcXOnkNHwbG6ZBpKv5ig6L5+w5C+0w4ax8vF+qoWEmYCZL+Lpq7TIOfQBKGgdyVCEJboaVgeB7LLI1KrqJcv6cZkBF5lQKhNjh407RvwyOjqwkpQLypq9rmvjUOJF+W/b9NA1TJBLr7XteaahsEJWcEfVytm+pv/NYUDk2XuicavINJmZ0x1JYXr67G5urQuz9nBuW56NCnf0LB0YOSD1yn58zsnPIIk6koTWWvkseJdgOX3nD8+UpwA2rf8PWomjGXKn4CZbV2Wnz0WIMlvBy4tcD1pr3U1dA70UJvs4GYeCecFVcSbzZq3RahPO5PyXFA14hrBdrlFasBrcySLRFhBs+RT4VOZvMH+BW8KTDa7owOLN9oVnEp+ch/SBNGdbfh2FcAbnKdwjcvjnRqd9GyqBXRz7/RonGu9mqW+IGZCdT7Xxk4wqeLU++KXp9JFAjGe05k/8Bl5jJNqksChxmDWCT/RIhMGh7VBgO96jgFZTIwajgYRm+BLK6/p8lh4yPwi8vH0aVn0767ew99fsBIiCcSQbXiPjQfyycn3jvnct2Uf5hs9hFDICC3WanKwspNsHrajdaz0eoZfDOqZ29ZN3PdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2906002)(86362001)(6486002)(186003)(5660300002)(83380400001)(66476007)(66556008)(4326008)(6506007)(8676002)(8936002)(6666004)(6512007)(66946007)(316002)(6916009)(54906003)(26005)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkxEb+fZ/LeWQJzKqEjkX0fkTCh8MI2BYxgvo8CvEmRP47ecUKcQ/d3U9elj?=
 =?us-ascii?Q?Z7eqUlN9LhJUAWrXoLQeuOel2AeBwQc5vYCsG+W9ng1qreUQLzFut631afKY?=
 =?us-ascii?Q?7n2AT6wPeiVFnI0QtYDgcIWjOpRiAnqYtjM8YhEA2msk+MZPBEHSBXOFNpCZ?=
 =?us-ascii?Q?uTFR+4fQAwJrW4C06/z78ijBBZn8uD52blBLK/14IIRckPW9ibVa2md8mRV6?=
 =?us-ascii?Q?Hsujh8WQ4DAJ6Gj8FR6yEW5Ur4ftdWqh7bOmpd3YDS9JLaI+e1tLHI+pvQ4/?=
 =?us-ascii?Q?xPn8MtIbn6RYpOLSCjVJJ4VpeaO1KopTyNySgukcuVmNqRtTOunAfp1RsR7C?=
 =?us-ascii?Q?9JIjQe5njlZgP5Z8Wewn6CmCovb9sv72uL6TWoAp0a5iIaeDFKeRhXXofVrA?=
 =?us-ascii?Q?HTG6mKrsn3BEptRU3QAVVGDr03B3QHffdX8jE63NJ6spoDYU0e9aCqbG8VYi?=
 =?us-ascii?Q?hB8JXgBZimtqWqV9gYoYLQrykTQlMIr19y/L2loPfxDIODxvWgBceiXCA2Qh?=
 =?us-ascii?Q?TMixxPy+5z2dEX+zdxLbd3DQcYvUPAgGcg1dWc2uRN+azKQWsfe1ZmaX8TQI?=
 =?us-ascii?Q?MDhb6cY+SJnpooVHXYasCR0FncdevgwKoodjO0J6VaRieUBDEjeb5A7vXf+j?=
 =?us-ascii?Q?bHxPgPJvfDaImYpOuZF6XRwezHpyBWivC9dbRGIA2/erRDd2cjNGxRKgIqUG?=
 =?us-ascii?Q?WGEuXWY/Um99I7qaVBlT8Ns8sgePJQP7LyspL8UTN0bwB0Xi3v/Ae7lUtMUF?=
 =?us-ascii?Q?vzsDlunyznN4ywela9/fRoTAfAmPZyU+6SXVlJABrdOGtPUVCG/IA5HLUgqv?=
 =?us-ascii?Q?mn9yidNgDL0axApqG8TxZ+0zWaOAFYixaoIeduLhfm/PbOPwQEPJhaig8z9Z?=
 =?us-ascii?Q?um2qnwulz7sReLh2iZWd10XpNurqJfrTjFeg266MPjWiC9cEwDDH8cg7Zh6R?=
 =?us-ascii?Q?YBqK/8d1vPnwxFZrN8f+eeo0WQo31hk4RBY3Q0K0ulKd5L3Ubm7IUZDL619M?=
 =?us-ascii?Q?jhhOPF7ANQ3wnMa9lqKA/lsPLca+xtenrlGFS/A9JKPMQKmWBLMQOfqJIU1Q?=
 =?us-ascii?Q?LvJy0kLy+jhZDiy+FbtQeFTwfCtDxr3IeHztB6HioHVpSoFHBgE1xEUcPUF+?=
 =?us-ascii?Q?lyxS52PyBUgqt514wlZYICoxOiZCngY5awqtEI3cSew2gvkkxvaAhIVX4l/y?=
 =?us-ascii?Q?9ffUn1DZTtAjR+Vnyw3ygdeB2G08OtzDLNfP+A3zQ1EBpA6CMl0FkUaMQq9g?=
 =?us-ascii?Q?0nBhl+UiUe52CFcvYlK14sbU7mO0fGL5wR7EuFqRJOyN2HElrcAwjQhpULIw?=
 =?us-ascii?Q?6D14JyedH6spxFTn9uSUovD5Xu1RoXONhF/8oHoC3O2eyVbdPwFKQ/bL4ipK?=
 =?us-ascii?Q?iccWf6IpITmle5aUatys7zgn5XbN7vQRveZfHntwI6p/sWIQ8uN7jKjpACTK?=
 =?us-ascii?Q?eGepzMp5Cuq6aVtdzb5BUcipsVJnYFV+gSnSXS1Wlk0zpmIc/OxYWT7TFY9D?=
 =?us-ascii?Q?5lXrauxuduClbqvUSqe9xTufq5+GorhItBMkdYOVe5yxsVGMPX3/1Z8M9ViS?=
 =?us-ascii?Q?AMTrAaKEtk09Knb/1THF6CRPhp6i7S1xKrCrGe4ctO5V1vSENe6/Z3/2i5wO?=
 =?us-ascii?Q?mONlmDPlJ+E4KHbB5lK/NNg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f93f001-5d10-4218-f17d-08d9ea4c8d2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:14:36.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NycS+uXuwMTLQBiJvqn6MpCyR1DkkvVXd6HMB6FgUSqLEPyyvepeaX503LzyEPjO+gFkJqJ8y803+KUVJMFkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Feb 04, 2022 at 11:28:25PM +1300, Barry Song wrote:

> > We already figured out that there are no idle CPUs in this cluster. So dont
> > we gain performance by picking a idle CPU/core in the neighbouring cluster.
> > If there are no idle CPU/core in the neighbouring cluster, then it does make
> > sense to fallback on the current cluster.
> 
> What you suggested is exactly the approach we have tried at the first beginning
> during debugging. but we didn't gain performance according to benchmark, we
> were actually losing. that is why we added this line to stop ping-pong:
>          /* Don't ping-pong tasks in and out cluster frequently */
>          if (cpus_share_resources(target, prev_cpu))
>             return target;
> 
> If we delete this, we are seeing a big loss of tbench while system
> load is medium
> and above.

Thanks for clarifying this Barry. Indeed, if the workload is sensitive
to data ping-ponging across L2 clusters, this heuristic makes sense. I
was thinking of workloads that require lower tail latency, in which
case exploring the larger LLC would have made more sense, assuming
that the larger LLC has an idle core/CPU.

In the absence of any hints from the workload, like something that
Peter had previous suggested
(https://lore.kernel.org/lkml/YVwnsrZWrnWHaoqN@hirez.programming.kicks-ass.net/),
optimizing for cache-access seems to be the right thing to do.


> 
> Thanks
> Barry

--
Thanks and Regards
gautham.
