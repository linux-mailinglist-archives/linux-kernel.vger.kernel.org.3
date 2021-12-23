Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF847DD92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbhLWCDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:03:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19914 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhLWCDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:03:06 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN1eACK004417;
        Wed, 22 Dec 2021 18:03:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LaNMM/eCGgELL1HohBN0JpSzFlY696pGNZ0MsS+1vho=;
 b=Bp/8WhKim/7wCYWccH6RiEPiDKd7aosE/oFnktUw98h8lkTQprvjCbJjV6pcVn9cRM1W
 bY7FocZnXATMryH97PUKWYid6LVXsToes9WSvP8xgZRlwRvom9G6aSF0p/j/XwTBzmSv
 uiJMeb1WrAjv4FoOhQzri/RQmllbW7n4Sb0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d4fnbr2ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Dec 2021 18:03:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 18:02:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLpFZddXNnlSAnFVhTwuMXPyYYen7ghS9w3zI8UwJ5Nl0vpGSta4eRjuE91w7aZZuQUdHG5jICQks+JIQA5sYMqDMWKl05lERRx66PXhF/fnRLfwy2FKqr2IzwCQRc3Y/fQT/0aFsiWzeok0tJI7Biq2jm9Q/s+rkL4f9QC2qL4ZqqeLdmBqrK2U4C2TD7Lwc3AgkPIJK5hiOshm98CWMeosfFs5P1Rrw/wScZmoSN1KXbmziRVMdAO/7KSa44rolM/h0jNpd4A0rd1KtAqedLfa7Pu0aVfFj+QCQuW40tOis9JjXANFiOaCZNNU3UJ+jy8wGCl7kFLLzbEe8dbCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaNMM/eCGgELL1HohBN0JpSzFlY696pGNZ0MsS+1vho=;
 b=giom88XExBtSw/tIeCUUuctIfAy+8WSjg0bQI98xPsoXxVIOzR13pqfODXI9iY+r6GhgP+fl2Uj8pH5gNSKoenjg9ojI6tijxbduS0MBz9ECySb70YSX7H8MmQ2HBobCQEvHiDcW3oxFMN2mPnbmIdWwnPtBmOxedQHEAqLGDx0lnias7AUd358gwTygFt9sJvqQLx5DUNgAButIKWSlA/UDSNWfdUQgF/kEZRKDyLz5CO1lUwP+1v3SOPA14m1xZG/jzqZp5NhsmXDqOreLDOcu+yc9cjw52w9whavS7EVhhg5Qn9f3Sy2sz3Fqu1imO/UEJfXqBAcI61zgqGUlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2599.namprd15.prod.outlook.com (2603:10b6:a03:15a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Thu, 23 Dec
 2021 02:02:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c5a5:cda4:d961:323a]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c5a5:cda4:d961:323a%7]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 02:02:58 +0000
Date:   Wed, 22 Dec 2021 18:02:55 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
Message-ID: <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
References: <20211222052457.1960701-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211222052457.1960701-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:300:39::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf9c4231-5817-4f33-4f3f-08d9c5b857b2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2599CFCD975886CD63A9E6CFBE7E9@BYAPR15MB2599.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xouQoL1JVpi0zuZcKqnS4kUbXzuOLMwVG5upQNen0FTHuzgy7SaYngTs9OSSAsk8ESYaj9HN2AiWO+85qV7NlRnRSAS7gI+5OnC+8dXt/TK5M8WI/vqFai51nCaBm1NfmhJpTD1SpWINMKMoAOfHQ5CiWcEnS8+RGQtmc2PZRlULHTMNaFRQaEMmuXj58gqxVhbYwSWYLGll5L3XyXQdp8VaMHGDcZf64xABaz9QcbTFbD3Ze1enUGlyY+BEugRSpcAN7aVq4tve1+8K99bJklUASMLcgoMiENxIq32YdRC/FHGEEsqwZOWvwyEBv/ppfJBAYBo0sYiQhBsTtuGn+Aa604V0amK8msatbuUG9dFTLb1fa14TP/rNVwDESGY2ods86mWNnDZFw+nPHquPBWKwk6+D48lJDt7ygcA+qJ+r+bqDCmax4HYI+F0Z1qYAzr8eVoE3qOWUq0FxAVsjvduitbIuN70I6iaFCUc7n+HX0n9q8XjmGzQmyh4xA/iyEMBvzEQNQ+ChDPj19gJix1Rp1jLHW9j+9M2Eb4gM+g/oI3niY7844jOGQ99GZ6jmQuVH0sl47gsSamaf3BjoBxaroNHnNALtl9Sqniiu4sE8qJ7pRCR2JnUqank0Aov+IGSycft7saz4bGExntgNlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8676002)(316002)(83380400001)(66556008)(6486002)(86362001)(66476007)(6666004)(66946007)(2906002)(6512007)(5660300002)(508600001)(9686003)(4326008)(6916009)(186003)(38100700002)(8936002)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sLDQat7Jvi4PIH8S+e4iOti4TGjVqur17Rwx0UbgEf8J4XZZkKTXQbWs6OhB?=
 =?us-ascii?Q?cBgeSuM3vAZWrOb80alPap+q999xCTR/N5ZFKEUENJOsUm8Y03tz05eqUq8j?=
 =?us-ascii?Q?4P+BTLjhdOTQrHh+VbvVvMLOqHFQEK8cLAWuxirbyCogQbkT4TggXDWpyhdE?=
 =?us-ascii?Q?bqCCJgqv242Vj2x115yhpIwhXJg3BdlXxECc2g9uiEHku+X2ZNNkZR2AkMoO?=
 =?us-ascii?Q?ci1RVkrhZTxi5jXLTa+Hg54ETfQQFBgzjWmd6CBj33Cm2XFvA4e2LV5ejgVM?=
 =?us-ascii?Q?QhbrH7ranm5vBw5Z0ayqlNYbWPsa9dyvT4BffT8PE8T4yaPPEV4dOg3gGcOF?=
 =?us-ascii?Q?6BMunOlmAxTMwsWhk5PJ3ydJqwbeCV6ttUDf15xDnfKdqQWtuilnz+zH0bWo?=
 =?us-ascii?Q?m+2lXud9JV3D/DVAtuov0qqoS61ME7pUe2wkiYRgaxSdKOr+vQRMvaRWa379?=
 =?us-ascii?Q?Kes1/1TsQWmQ+1uNdQk58eUySoZaVkW0G8Rn0iM2kjSE6ExXz+ecHkYXnbry?=
 =?us-ascii?Q?g8txH27v6zzmuj9iQncc48ApVXB4ipCS0ZeNyQJ04y0VH5Ov2t/3ICnyuhvt?=
 =?us-ascii?Q?nNY+UIR/u4mAvq0ryey3kWlhAstHSQhysDdC35pRxswSLTyqlkSv2fblA8bC?=
 =?us-ascii?Q?b8qdLmGWp43/gT/WO9NH8IUTJFNp80JhJhVklGY7DNtxfCdfmNP/lDH2gj6x?=
 =?us-ascii?Q?vMCJR5tUPccZ+EPZnWbH7+FRdbyG36dTyqZ6eB81SyKjnyYmDJ9lrODi0jDW?=
 =?us-ascii?Q?/lcFYQ+HfwFMYOzQA3TKFPMRs0wm7gMxaZ5tRErE868VH4d6eIS9HdfxZ7av?=
 =?us-ascii?Q?bw+zhSbXwWC8oGS4wjR5RErk4g7z4smQBx/SQsPLT/UKxmBtqfnhNrML9xah?=
 =?us-ascii?Q?cXp3itiupWXxh7V2UJK24b3KmqbseCko0AJTwhlQ1qgmFqvT6yG+mxZOYA/x?=
 =?us-ascii?Q?kO9N84h1Kj75C9wiZzkwql185XDrp5qJE4nJujOpvI4pXbI0yd8luAZOTep4?=
 =?us-ascii?Q?6PZefa2L7HZIIlklit7f4CaMxzk8jPdhmCgRQR+NDVcDsOw7zSqTNGjcCo3K?=
 =?us-ascii?Q?6YzHDDRyCzFxoau7MxEO7+xwLuBaJ1MtyJ6HzGrXe1qpbrs1lWyXk8HOnAfM?=
 =?us-ascii?Q?ASA77ssf/63dMKp0cHVIPWKEMIi3ZPFmKaEVib6bqfrb6oXTGamo6ejB9NcO?=
 =?us-ascii?Q?vYSTNWquLNted5ZNBv/aDXR9RG5p5ZQW/onVYv6wFwurNKKnFszWkzjf0VMm?=
 =?us-ascii?Q?jLbrLHOuQcINIFdsWZ0gaoAeCFVKJVCrJENPIlsoozpJ7bz2FvdJ1C2MPEHc?=
 =?us-ascii?Q?yNLGWoAHO6JbQyBUOqUY/RJHZ7UkZSNbifY7Js0aGSyAoWTfX5VCWl14DqWD?=
 =?us-ascii?Q?HALHBVjFqm3qMltuJX2Cggj54DGE7DPq717jr5etp/pIwfLFEQvgT7oodwVK?=
 =?us-ascii?Q?ozT3xg16cT5c3irV6NCi4pVFAgZm+OmbVk6Dp2Qxo+eeIiuPE75rMrh7OhLf?=
 =?us-ascii?Q?OcXqkIAwyKgmM5IajYeF237gR0XTW51YfoWFIKMp8CMtYvt2/JQIasRehfPR?=
 =?us-ascii?Q?J2tJh3Q6B/581eIwYEIXV3S5NIfrV8yAts6ydj/9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c4231-5817-4f33-4f3f-08d9c5b857b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 02:02:58.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RhUX/2gADZh7RlVCp9lKYAED+P98/ICYKQMqOvhK34kQYS3EuNxaDh7mhyG5EUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2599
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -YoweW0LxYsVG9ybcLc_7-WsrF4d70iz
X-Proofpoint-GUID: -YoweW0LxYsVG9ybcLc_7-WsrF4d70iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=939 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:24:57PM -0800, Shakeel Butt wrote:
> The kvmalloc* allocation functions can fallback to vmalloc allocations
> and more often on long running machines. In addition the kernel does
> have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> the memory.stat does not tell the complete picture which type of memory
> is charged to the memcg. So add a per-memcg vmalloc stat.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 
> ---
> Changelog since v1:
> - page_memcg() within rcu lock as suggested by Muchun.
> 
>  Documentation/admin-guide/cgroup-v2.rst |  3 +++
>  include/linux/memcontrol.h              | 21 +++++++++++++++++++++
>  mm/memcontrol.c                         |  1 +
>  mm/vmalloc.c                            |  5 +++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 82c8dc91b2be..5aa368d165da 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
>  	  sock (npn)
>  		Amount of memory used in network transmission buffers
>  
> +	  vmalloc (npn)
> +		Amount of memory used for vmap backed memory.
> +

It's a bid sad that this counter will partially intersect with others
(e.g. percpu and stack), but I don't see how it can be easily fixed.

But I agree that the counter is useful and worth adding.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
