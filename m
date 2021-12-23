Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31547E8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbhLWU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:27:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234114AbhLWU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:27:50 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BN9SFPa016623;
        Thu, 23 Dec 2021 12:27:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FpexdmaoHak9eKjCnFQAcdEQG29X1255GulVhOIzR/s=;
 b=nZ1Z7rG386MpQw659dlcvong772zSqSnwO5/ZcnkFgdN0wTJxCUFPjeYSi0s7yiIDhOY
 JPoAwb2fwIdH1NJW4A75CPFjxG+ODkVkwIDyLeBJq+z2qKhjddw7ywL+k0J9+fuoFgjT
 I6vyAiuU6WGBbUHou4STYLklWZkS/AnG8Fs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3d42p2u743-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Dec 2021 12:27:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 12:27:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VonlCdBao0q1d7cQ9OBkaYcoBl4Wo8JsGcjIF4Q9vDeaSr2YWKhQDeA6A/a8bR+gFhG8v3uEnX6O/G1TRd3/26Sh+355GRZoytcQvTl2Oet3rF9u1QW1mLSQzxA+0SC+ihtoDwQo9Ntwe+St3i39rynBDyzO+XmVtR+ro4WXOTGG6hb6bJwV2n+4NY9Cc49gEFpwMnm9uiLNMC1KvnZFY+/PbEOzv8xJpJyUAPuMBgncDF0tPYV317/owWE3XXYFkLVskrOnW8dTVT8BAk9CHcwS7csvcNtMtaEuiho7Y3D34p+zNZdLpzvLR34wWXVe/v1gtsEc7X6ZG2k1VK/asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpexdmaoHak9eKjCnFQAcdEQG29X1255GulVhOIzR/s=;
 b=AUOIMS6djFvL9gT4+8tg2dkkL8SG9ZBD8SVwyQhKmesmhzJvKjjk1cIy2G3aMiyVf68nkFvn3JJvbiVbqo9MFZc8zHd1XTE6Oqk/klAhvit7gIAyrXGPD44GCayhfIMgDdo2cOEgFuc4B5jZRiMHmkHPkHvfb05g1xEHC32YtKUi1Gz7isjBfjZeVUe0Kd/tvPFvGa9c8hCdJ/IlXkDDbEWkSqVIdJnGJX/WWbBzheAJ5BauyA7ZHTj+QoW5JLdT1v63lZvOdRZyArj1m4uKqKlgFZ81LdiPQjgopx8hSVao7i4fMuzTFNTTH3qoT0db9S2jJlx3yuFYi7L4t8KZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3221.namprd15.prod.outlook.com (2603:10b6:a03:102::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 20:27:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c56b:a9a2:acd3:635c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c56b:a9a2:acd3:635c%3]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 20:27:41 +0000
Date:   Thu, 23 Dec 2021 12:27:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
Message-ID: <YcTbuaNqd+ILLTe+@carbon.dhcp.thefacebook.com>
References: <20211222052457.1960701-1-shakeelb@google.com>
 <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
 <CALvZod4HWG2+8WF6=OVwst1S205Z_3gB=AtbvnQ7jDpmFt0iZg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4HWG2+8WF6=OVwst1S205Z_3gB=AtbvnQ7jDpmFt0iZg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e735fcd4-567b-4904-7af0-08d9c652ab6a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3221:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB32210CFD9A58D3BBEF2D175BBE7E9@BYAPR15MB3221.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyvorNDPv9S4HfH84QHSKbbM5pmF0ZSMMMGuXEYEJhWdDbD2gCfyuViasSz681tx/ZvfIermQgQ/TsoAvwu3TUvDjgGMhUZ9M0SCVGoBCWjWYBIk9uvnc8mGcHYm+ykb7+7cSaCZTN9mblapyVBBENHDQ9vR+v4kIXKZolXma5Zp54B7ZX32vkrdFjAnVW04PDk9azx0pioAnWFmH6t3eDk9CkL8QWLR1T7KvHSW351ohHEVd499vR5JTmblcncHeoN/GH5KfXBPDdKsa3jqIQkHFyJpHiwNOwtZLoKTvqbnP1oIvTGAA1WpHFSc9DIs6hDeZ7pVtMbtirR2dcgIXfaUTWHLcnObMd3iR6YpYfYqKKGduQ4ZnXvqOSYAmv0poUk177/7G/qaN7ujc4umgbBZakMbzqvJqvylarRJuuv+tDfnzL5CBnXjgw6vDdDPcFsKKjKu/+NYY8QKFWUxzFrcNtmi4DQw8JMH+gzkOk/wsIUh7xxNCouGok/xjU7G6bWVj5AL0vzs648igdVnnNFesHoXV66fAuBasK8lVfnwz2qS4R7cn3MfRrqK/BujnATAvqjnrKfHVfETM7Mua7LEqFS0xOMm56Vrs2GlScOiwaayHVCZRHn0CmWKSVD7tGgEMe93XcdJv6t8Sqx1BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(4326008)(83380400001)(5660300002)(6512007)(9686003)(2906002)(6486002)(66476007)(66556008)(66946007)(186003)(6666004)(53546011)(6506007)(52116002)(8936002)(54906003)(8676002)(316002)(86362001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqTROVqDBD/Gc1RgDDJvVWQl8u6scMOdtKqaAPDi0PN+m52mf4GvsYMRgjdH?=
 =?us-ascii?Q?t7v+Jk1CxlXYPgLO2u4cAGfXTuKCIqp39kAEBZ8JFUVknfIcwLuj0RGFY8od?=
 =?us-ascii?Q?5nOPeOrlHYe2fDU4hUDUAPSzonyRpKIx1fe8zr7M+RqJMcsM5GNA5SAT8ehy?=
 =?us-ascii?Q?AjB0QmWardfNupVkvgTOm00JqIyHua/Qj+xf2quCkpbVxZIVlDRGHPBlBXht?=
 =?us-ascii?Q?Kfp5BW3w/3wU5gT6ad+ZsGwt0egT1RTZVGfQeWeg3xznnVI5YGpj22rViC0N?=
 =?us-ascii?Q?oxDggnRA483CubxHThTKEowA8Axgg9TdO0sPMpqmGHQXjhuU7T6/IXBlniYE?=
 =?us-ascii?Q?SFtMcq7Yk+ECDrTKL1iWHpTqTqeuLYPOQU6nqE01TrSqePTEro7bXB2lo4f6?=
 =?us-ascii?Q?SAXLEI/bTJ+oasWBDDqXLwwDUty7J95RV0cqow+lIoE1sj/KL185tdoRK5YV?=
 =?us-ascii?Q?WC76tPDZ2oDaee3dPWJded/ajwebU6Ze6lOpDBM59Tipr+ucH2zScSdFES/N?=
 =?us-ascii?Q?5+Lgm0YhedwMMU14r8krDgCaS203VzHCPVRl3BcYcKqsowOrij3OaC+BCLlo?=
 =?us-ascii?Q?IlmQOnkfPVvjWkqzSpYLiA0kYaAQAQA5Zdwn5wKXcYuq13SlJFlM3Wj9tLFQ?=
 =?us-ascii?Q?9iLwQlJGftIixSEX8QAOY/k3iSUb0qVJ5IKHcAhPNPFsrjT+97xMMVAc7ocr?=
 =?us-ascii?Q?8FfpDla+SoyUGYbIDdbfFjDBD/v67k8SCWSuAgw8pjHxiUvoW630me4qaXLx?=
 =?us-ascii?Q?hiaEIZAlRptleHuXEnHFC5mBEazj0P+VhjUvNp72O6IdMwL5998VcmYk3uAy?=
 =?us-ascii?Q?9o6jgqlD7RGEWDr5uJpN7U4zeNqqZ9Dnwd4S1v5pBh23dVLstx5LSRAQ1dva?=
 =?us-ascii?Q?4bdjlgkdC60SbY4G1qBlRa64G3NDIkUi8mFwlby8Ayfr/RjBKuItU7wzEflF?=
 =?us-ascii?Q?314wQOxjzIQFG6Y98apc+/NUh5yZjNkYOh1z4al7tSoeIDhf/59gVM/y6I81?=
 =?us-ascii?Q?mR1FWbtjLNvMV24KR0xXk9b33M1dyeLFmY8WdLJMhj9T0MoriKicfqfihr9L?=
 =?us-ascii?Q?KDVtuTzCY9+td5Pac7BQm325eHMpHeF5ZbLEvYERGkRbQtLJ36Ju/O9I+p7e?=
 =?us-ascii?Q?Ci9lR9AjtkvuMn3pQyf2gcsSfbSAafcUZk9VWH8RNBSVRxBeBBaTljkPFc0c?=
 =?us-ascii?Q?/v+5yjvDf94dmZGLmwL4sZad44q7IosVNwpSlIaYQKdaZty0ok0Pmq3+cZDt?=
 =?us-ascii?Q?QxaTxoVNeIiqySjPx0gQr8Ge0ogaz1r0wspqT1EXlCVIwF83Or2cC0VU1YxQ?=
 =?us-ascii?Q?Fja83RgAW8raxz4NNnsW5QSgInFRsBgEu5L//ZaVtChQw0M7LMZPsEx6Yczg?=
 =?us-ascii?Q?MW3dzW+mKp48zhYI40ybpaOf9XIKqPSVbZ3d5pF0au3ksu9FNOjHN0nki+xu?=
 =?us-ascii?Q?32Kdg5RciHzQtB1GG3Gnnu4gQqqCN+0mq1Rzr6IqHAW1yxpSp2V8DZF9ZbkI?=
 =?us-ascii?Q?SspcFstThHWEWsVKhVNKR1m+8wT3KY/DY7uz+ZW3vq1IPO8Io5E9vuY/0aTE?=
 =?us-ascii?Q?nLyQD+y1UjB48ZEvbRn69gynlm8k6VOT1EKNdA6L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e735fcd4-567b-4904-7af0-08d9c652ab6a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 20:27:41.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF5OmAb5Xvv0v0M92jPFsV3UB8Vvd2+ZW7zcj7XGrq+pwlgiV591DBA8EEZvHlNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TJdLYB16QxRe0cDNXsrwrO-7bXScvdD6
X-Proofpoint-ORIG-GUID: TJdLYB16QxRe0cDNXsrwrO-7bXScvdD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_04,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=908 phishscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 09:44:26AM -0800, Shakeel Butt wrote:
> On Wed, Dec 22, 2021 at 6:03 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Dec 21, 2021 at 09:24:57PM -0800, Shakeel Butt wrote:
> > > The kvmalloc* allocation functions can fallback to vmalloc allocations
> > > and more often on long running machines. In addition the kernel does
> > > have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> > > the memory.stat does not tell the complete picture which type of memory
> > > is charged to the memcg. So add a per-memcg vmalloc stat.
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > >
> > > ---
> > > Changelog since v1:
> > > - page_memcg() within rcu lock as suggested by Muchun.
> > >
> > >  Documentation/admin-guide/cgroup-v2.rst |  3 +++
> > >  include/linux/memcontrol.h              | 21 +++++++++++++++++++++
> > >  mm/memcontrol.c                         |  1 +
> > >  mm/vmalloc.c                            |  5 +++++
> > >  4 files changed, 30 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 82c8dc91b2be..5aa368d165da 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
> > >         sock (npn)
> > >               Amount of memory used in network transmission buffers
> > >
> > > +       vmalloc (npn)
> > > +             Amount of memory used for vmap backed memory.
> > > +
> >
> > It's a bid sad that this counter will partially intersect with others
> > (e.g. percpu and stack), but I don't see how it can be easily fixed.
> 
> I checked those again. For vmap based stack we do vmalloc() without
> __GFP_ACCOUNT and charge the stack page afterwards with
> memcg_kmem_charge_page() interface.
> 
> I think we do the same for percpu as well i.e. not use GFP_ACCOUNT for
> underlying memory but later use objcg infrastructure to charge at
> finer grain.
> 
> So, I think at least percpu and stack should not intersect with
> vmalloc per-memcg stat.

Ah, ok then, thanks for checking!

In general, it seems that if an allocation is backed by multiple layers
of mm code (e.g. percpu on top of vmalloc), we choose one layer to do
both memcg statistics and accounting. This makes total sense.

Thanks!
