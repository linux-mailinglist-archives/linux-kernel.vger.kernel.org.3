Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0878B49BDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiAYVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:24:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10514 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233025AbiAYVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:24:27 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJDdTM024951;
        Tue, 25 Jan 2022 21:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E+Ed8MxiCd2g9LueBfaDHpmPn4GCLK4v5TkmR5+xNSs=;
 b=HpchLYFbEL8CwIGeEQIK4tgecO0i/LXpdGAarlVugsNCQuvc78yGLNBWXhLqSeFKh84E
 HkWm9cA3AXYfamZrREqMzYzDVxZ6M1IsOQib6JsWGnAKj9cnlNOFFVyVH7rz8DB2TisG
 q9H32s5Oo0oOfDJZzb1HHwDNjKVE0id4J0zMG3NBGc4Dq3ZiO1chOXGDm7FCNL2/63Qe
 NiK/GB9cBW0dJvrcCs0Ai534Cc6E1alqI4dvJGMObighGqoZa/A8qbK6hk4OgcSBAsmX
 cShDc7sOYDnQs9GCVuUz/X4ocgbF6zofW24CUlpX3b2AY+xpJaNXNhqy/Nh8mWV/5IsY wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7avffw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:24:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PLAVL6051686;
        Tue, 25 Jan 2022 21:24:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3020.oracle.com with ESMTP id 3drbcprxbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Koxjk+HRduuK45VNaylIZHwqUK/lh+q5Y7bsPCTe6y2T5lcLYpv4YMBvqDHAiPleDXp731CILgLt2vxqZqQXNrmPkL/eiQMlWVcY4+ZzwVqSr7k1FAX5RYKcw3VkQuQsyoV1JSmcXrDJYwlbBPvnl26sTxnbGdTO9DrmbheZHzPcZJCYDYVBWWqFiFhnxeGU8DSHN55oQuWYQoV/1IRRVO+9MRbWzK1uOfxx05cVNyFKNVjXPJh+AjSAn1Iww3GFaaQl9j4K8gnud1R1uTQ1e/mGoTxjusf6X7tCYWpxTJ3cOaEB57O4+sv2IWoI5IuAJoatccOgr2woPBUzym3yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Ed8MxiCd2g9LueBfaDHpmPn4GCLK4v5TkmR5+xNSs=;
 b=ll5vrsY8kHJPI6xMjZeP4X7QzT/FINLyXaO3R7tX7/PECHpy/VhVoRDuhp55vZLGW4HYc30UpQG/gzxRxWo4TD5y9guEeBg7NJ8+LI2MGPe2A6P/+lE1v9UJtiZSyGimV35rW+weqg5nZBMBo7A7TvRN8EJhv30/SiiBQk87JIAbW6jpxcGyZm3eG12wPKkjqWKsRr3fj6rQgVDYLcc6RrVGG4JYX1UNuvqsUJ+4yBrFKswjmt3ZGTVA51o3kf8CR8WLcyYJLs53f+APz9Ir/rfNLYiKI5+0VMC4T4R+p+pynUIlc5zO6BN+UiN19juS0smXIz0yWX8afBRZhlZCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Ed8MxiCd2g9LueBfaDHpmPn4GCLK4v5TkmR5+xNSs=;
 b=Zic/J4wy3J5vK61qPf2Q4ApVpamF9oJGOYqXT7WL8P0F0pGJPMJx/JZy8qHlihKSPFMGu74JJiLy6caOwZN7vM+OcIfjQ+31h0XC1CqIYWPIhyfM+Nlzm17EcbM8VHT+V7hyhYp0IDt6USdITM2HutQJL4kF1uuWyeuHy3rIi30=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 21:24:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 21:24:09 +0000
Message-ID: <039a9107-756e-bc0a-6e72-fbe08408de38@oracle.com>
Date:   Tue, 25 Jan 2022 13:24:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of
 THP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, Zi Yan <ziy@nvidia.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com>
 <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
 <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
 <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com>
 <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:300:16::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44229e2-da4c-4c32-0123-08d9e049062e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3112:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB31129216D2B333210A18D889E25F9@BYAPR10MB3112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eehCGzq1Zk0d30NDGfCbQt/vbmj/PN1fYmdEPh3w15Ga5gT+bpG6n9VxPObkBuye9YgZniAHpublgSVIOKBaLBd2cjkBEnJG7yXWBvNkGzlA0Mvyzax8WjIM7OCNzRusRobwzx9YbYYQE61v2hXvx91y+lGECfBMdbLJy1q32iLlFT/VeH/oCTwfxQ7MAd++QWiBU91c629Sg8AMyad41sKADZv73/8QK4Xy9WAWlobUTTcAqow1sBVehAAAnb7zNz/18Zpp7P7HWJMBiV1dZujJE7Epu//BjEBG+2ch8j2EDsloLWyNTru6nMxU7Z+fmXdoPKKreYrwCwjorgjoNPmjv9mjZ2O/vaoDuK4C51md7EuduyKW5+sQ44E2w9WOMXTftGD7dNZBGiISWsLtRg0oL9P6mKA9F3N85Uvc2HCkz4qr9i/tzS1SgtsmoXYt2WE/R/OZbluRMj3xBjTvo4un54U2BiUN4zfe1airKdFdORRQUMdJM6vuDsaKbg17k/xHGFivzMrCyuc/AuyDhCFUbrQkBy8vRifP+yHAYFaAH6JK13bkvhyX02vqBF++ac7Z9aw5BccTnoqrzh/2juQI3x8+mf6U/gEjFlhSTYFo9uYCf8P+7PEeqFoefQjdDdmfd+HvR4dIDdD8yXVoPECNdudiv1lmqU9qj9mmLjin60lAY//V1yXfSy3sC30RFiZzmuhaL0flfrQedWoO9dhKPxU5hIMKQKSiJprhi0RkMEOvFbnHAMpGhsjWUKTdfVWZz8HKt1JCP+3z9rbw5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(53546011)(6486002)(6666004)(54906003)(316002)(86362001)(110136005)(8936002)(31686004)(6506007)(8676002)(44832011)(36756003)(26005)(2906002)(66946007)(31696002)(2616005)(52116002)(38100700002)(38350700002)(66556008)(4326008)(508600001)(5660300002)(6512007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2w0dEdmcWVvK3A3dUo3b3FtMFQxN2pNOGNIN0JHVEJCRmFWQTZyUGUwMGc0?=
 =?utf-8?B?TUlsSkJmaTRrNnQ1MzFsaVJZL24vWjlFYW50akNRQ1RHT1I5b0JMV0REV0M5?=
 =?utf-8?B?UU9QRzZOWTkyZkRMbjRORjkyaEdNTTBvekc1OG9jLzZqWGVFOEF1aXc3VWxL?=
 =?utf-8?B?ZkF1OW9PK0hlVHVBWllrdk1oWVNMQnVqMlFvM0ExMC90NVFXY2F0aXNpRjJL?=
 =?utf-8?B?eGFZbjBsYjhJODM2K3dUYjhPcWg0MVB5V2s5QkJxUWFlbklIQzY1RExGQnN6?=
 =?utf-8?B?SFBQUXJLL1ZhTmZ6emlRTnNqYVp6ampyK0VKejkzakVidDdFaWV6TkFDL3Qw?=
 =?utf-8?B?cUtHbU1QSkZZVlFDaGZIRURWOHNWdG9lVTQxSVl1WmxkU1BPaThFT3oyUFdE?=
 =?utf-8?B?eWc3ZkZob1dxV05SZmpxY3JOQWd2U2dkQXBmOWsxZlVvQ3NIc0YwY05aSnVD?=
 =?utf-8?B?WDFjZFJXYjZGZDRSWFRyR2RtRzBWWjNYNmNnQjdZWURaWGMzM0VnZVBBZCt6?=
 =?utf-8?B?VlNRMmVkQjlPcDlCWVBQOHhSTmVtRWdidjRCZ3ZiMjFtYjE2MStWRVpaTnJE?=
 =?utf-8?B?Tkd2YnJtQlMyZzV0UXlxKytkVnZoMmJvNjVyUUR4c3BKQXlaYnRtMGFMT2dY?=
 =?utf-8?B?T3VEM3RLKzVKREFKUzl5amZHWU9lcEhJenY3UXB4LzArOExDMlpzUUZqazc5?=
 =?utf-8?B?VG40NlF3WkRMaktPL1ljNU42YlpXS2dWdkNyaGZCemdzMHZkMTdhM1R6SWE3?=
 =?utf-8?B?L0ZiUnA3eWFPbEtQNHdsUjk1d3UvZGJHTE9zaTJWSzNBQzl0aVhMMGx1MktS?=
 =?utf-8?B?UEEyeGdwWTdKK0Y4UmZPNmVBZzhKbkVLY2FGd0tPcGFyVzA5YmlpZjFWVGNE?=
 =?utf-8?B?eHZId296Z0JxS1JWN3U1aDZrVk5uYkNST2hGV3FXMnNPRFFyTkozWkZGQ1R1?=
 =?utf-8?B?bFoxenI5bmdPSTNVUHhFSWdRQitJaG81blRoR0xtU0FrWUgyZGZyRHErcDZp?=
 =?utf-8?B?Z0RRNHlSRlhsWkJyakFxci9KQ0p2eHQwc1c4QVZ1U2ZOZm02d3RjSkRwbkZF?=
 =?utf-8?B?SVRMM2Y3TG4wSDdqbXd0N3RmSjhzSDMzWThFTzFST3hzQy91dE5QL2NCcmRK?=
 =?utf-8?B?ZHlkVFgyb01pcEJzQUI2Mlo2MkFvWnlHUTlONXluOHJvb0hXY05wckJlc3dl?=
 =?utf-8?B?UVBwY1R1TzdEQ3FiK2xwa09vK21ub2N1TUFZVjRFZHZtL0g4ZzFDYi91NWZF?=
 =?utf-8?B?SHVCY3RFbjdVVkpCdWl1S0VFN3pPUGUzRERzU0l0MnhXOTlQWnBFNG5QSVpa?=
 =?utf-8?B?Y1E2MmN0MGhCZ25tRGY3bE5VVEpEWC93b1dUSmhQV3ZHVDk0d25jOHc5OEM5?=
 =?utf-8?B?a1VnMFFOTVd2dmptNlY5M05NM1pobklPYnFCdTh4QytGM1psMlVNamNURk5C?=
 =?utf-8?B?WnB5YlltKy9Bck14ZFlXejBPeWszMTJqUmV1OFVrMENNSE5aY1cvbUtNTzl3?=
 =?utf-8?B?eWdVcUQ1MHBDU0FaRlg2bEdtbVhGUUpaN3hjdTMrclIwQkdKSnFPckpZMVNN?=
 =?utf-8?B?SG1ORmtHd3h1cjRxendTNkdFVUNrZGtTTTh2M1VsWVJpazRNRVgydnJmUmVR?=
 =?utf-8?B?MjlBZnpFZDBSYnhjNm1KZWtweS9SWkRhV3puWFR2TjhLaE1mbXVaSUF3c3M5?=
 =?utf-8?B?Ti9DZFRHWlM1MHlBclVNODJPOThUNjJ4UW0ybnJnY2xyZUZvcjliaDFXR1c1?=
 =?utf-8?B?TUFCNXM3akxIQ0k2UzE5Q3orK1JjK2dGWWhESDBYRkFnMk5DKzN2dFBnTy9I?=
 =?utf-8?B?QjQrbXRKcWppMkwxUGd6OGcyTzVBMFM1SjNoa2FVK1NNZllOWGtmQ2Q1dWI4?=
 =?utf-8?B?Rmt2bWkzT1I1Q2xLQnhER2d4dUgyS1U2dVR1RWZHYUoyUVVKUThFQ2Znd2p4?=
 =?utf-8?B?MnpCNlcwdFVDcGg3QVZoYmlhcVVYcVJzL21OWGlpcmxqUWJOTjVWS3VTZEtS?=
 =?utf-8?B?NTRvKzdRRVZmVVY0NWFPVEh3ZExaNk9xSTQrakFWTE1kcnZXbEViT1BBTGd0?=
 =?utf-8?B?QVU1RW53OHl6UzA5clk0blRpMURzbktuYXJ2UFFLbHBxUlZ3czJSTDBTVnRO?=
 =?utf-8?B?MGxOUkJibTROcGowM00xazhEM1pHSjZ5QkpzeVZjWmg2T1BrcjVibHNoSlV3?=
 =?utf-8?Q?6WgjzGLZA5PGDem4ogf8jgA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44229e2-da4c-4c32-0123-08d9e049062e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 21:24:09.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNjy35nu98rowh9JEgv/cXkjaFTuNW8IPJo6/vreexQd2lXQadXEY3YfCn947Eg1Eta6ERsPA3ogmEMaz2urEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250127
X-Proofpoint-GUID: v9MJolAaPBGbmcoPrQ0WfgURf3NWRYgk
X-Proofpoint-ORIG-GUID: v9MJolAaPBGbmcoPrQ0WfgURf3NWRYgk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 22:01, Muchun Song wrote:
> On Tue, Jan 25, 2022 at 10:42 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 24 Jan 2022, at 20:55, Muchun Song wrote:
>>
>>> On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On 24 Jan 2022, at 13:11, David Rientjes wrote:
>>>>
>>>>> On Mon, 24 Jan 2022, Muchun Song wrote:
>>>>>
>>>>>> The D-cache maintenance inside move_to_new_page() only consider one page,
>>>>>> there is still D-cache maintenance issue for tail pages of THP. Fix this
>>>>>> by not using flush_dcache_folio() since it is not backportable.
>>>>>>
>>>>>
>>>>> The mention of being backportable suggests that we should backport this,
>>>>> likely to 4.14+.  So should it be marked as stable?
>>>>
>>>> Hmm, after more digging, I am not sure if the bug exists. For THP migration,
>>>> flush_cache_range() is used in remove_migration_pmd(). The flush_dcache_page()
>>>> was added by Lars Persson (cc’d) to solve the data corruption on MIPS[1],
>>>> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.
>>>
>>> I only mention the THP case. After some more thinking, I think the HugeTLB
>>> should also be considered, Right? The HugeTLB is enabled on arm, arm64,
>>> mips, parisc, powerpc, riscv, s390 and sh.
>>>
>>
>> +Mike for HugeTLB
>>
>> If HugeTLB page migration also misses flush_dcache_page() on its tail pages,
>> you will need a different patch for the commit introducing hugetlb page migration.
> 
> Agree. I think arm (see the following commit) has handled this issue, while most
> others do not.
> 
>   commit 0b19f93351dd ("ARM: mm: Add support for flushing HugeTLB pages.")
> 
> But I do not have any real devices to test if this issue exists on other archs.
> In theory, it exists.
> 

Thanks for adding me to the discussion.

I agree that this issue exists at least in theory for hugetlb pages as well.
This made me look at other places with similar code for hugetlb.  i.e.
Allocating a new page, copying data to new page and then establishing a
mapping (pte) to the new page.

- hugetlb_cow calls copy_user_huge_page() which ends up calling
  copy_user_highpage that includes dcache flushing of the target for some
  architectures, but not all.
- userfaultfd calls copy_huge_page_from_user which does not appear to do
  any dcache flushing for the target page.

Do you think these code paths have the same potential issue?
-- 
Mike Kravetz
