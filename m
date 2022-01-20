Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718294954C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbiATTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:16:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11208 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243610AbiATTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:16:08 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KITqof027763;
        Thu, 20 Jan 2022 19:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2oIRwSxkCrX5a3HPdaISfIdTCLgr0KqouCqjFEoAsd0=;
 b=fyjobxIe8LpaDKCWFdMEUjfDsjWVLFfEv4ueSCF9lSNmA4W9gZX3/io2yOAxK14oC5OB
 XoiypUOHuWkfpCZp9rJdM8OkKyK6ky0/XTqSYVzcJzNvy7LR2KYH9I3b20oHi+UvTsWO
 CmrXU/vWrhjg56hEipW6tVKuRQ1XUtvac5KyOyUfm4aVlzhr8CG7wh4D1q7+Uy5D56+/
 Tz/yFd9lKQ53JdBAexdXOE4isap3+x/5fSFIQolXZMdzhqMB2HzcJQes0Cv/b1gdhpfA
 3bRcEROFfGL4qnkF91Z6ftg6HtywY11X+90ZwMklroBZHUioSbX0MzBN9hMvlFkmSmsL yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqamb8km0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 19:15:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20KJ50rX122946;
        Thu, 20 Jan 2022 19:15:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3dpvj2j01m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 19:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLkUjgrWUQdPqOZ/HJm9YCMlap6utewIWdJVfRUotSVQ7nTvV1hjOgRYQAWvLX+KuEpEQnXgKqB4N8N53QluSnHQ2LlhYRIi74x0BXteEbZt/cqDh4dj7LgTgfn36Oz3Mph1xjFvkKSkSziKZg+oOu0tfbu5opyRU4AWEPxRysPmV6VylHLIQdCComOTxA7zxRmqAnmjPWrhfsAIhWoFodxazzx8WrLNJYc9fIJZH5gbAnp0iw3nU3r3oCMHeBS7Xh6i2+yLHmbXuQiMQGL5PGO0Wlj5rjIFTgLuA1GuAieIu/0Rsmex0pCMO88bZNwUbW7lSEOimx/SfnkjSSEjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oIRwSxkCrX5a3HPdaISfIdTCLgr0KqouCqjFEoAsd0=;
 b=QlGuqo7Ks8lw7WJTi8TY9Ixr6ifvoiUlA/BKu9cFXmcEt0LE8bToSgFfsbjg6ACERD3mA+vFkdxp3afZ6w0wAwG4dyEgGudLu3w0oQ07Lm4NfdVvy2wYuvs/G8Z5ELOxsGfneCL/UGSW87hIKswYqEV5Kg3YGYzqxzNsgChRzZC2Dblx40YG9d6p1XIXPFJq0SUa7Empbh18B7FEoxfwS5cevLgWMkLhi9Hsu6YUomPGE50Tvoj0l42U/FBBtB1Z77LGYphTtxnhtuLofeYsGXwzwtwBf+3Oe7qj0Sat/pE1nYl/dsZzlG7kUgsxM71bShlSbdWNWdz2jd2Aw8KCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oIRwSxkCrX5a3HPdaISfIdTCLgr0KqouCqjFEoAsd0=;
 b=Fcap22/pEMH6qAugB8HcPgBpNnDwZ282GEYj+36rk66kMjIKpmPaVrlO88VWcrzIzqqvIsw/5pUMn3LeR+YQuDFR/af55W3hT5hvoZAaNzyfQGdbGdJBPqgeDhqbolZnzlYOW4/ryCZVeCSdJu17uNvXZq36k0D0Vtrw1W0ew2c=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM6PR10MB2955.namprd10.prod.outlook.com (2603:10b6:5:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 19:15:35 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 19:15:35 +0000
Message-ID: <f0939948-51c4-eacb-0b20-dd31e0a8b92c@oracle.com>
Date:   Thu, 20 Jan 2022 12:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Mark Hemment <markhemm@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <CANe_+UhrcQO0mwB2KJtm69+MDVJuD-r5Cbyqt8AkWdtfY55CCQ@mail.gmail.com>
 <ef356f12-5eef-a92e-a816-ab853f2d369a@oracle.com>
 <CANe_+Ui4x7xz_QtG1iXr6J3dbKyja3-T=2tTTg+yqsacrTUYNw@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CANe_+Ui4x7xz_QtG1iXr6J3dbKyja3-T=2tTTg+yqsacrTUYNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311d8a66-e7a9-49df-6155-08d9dc493c4c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2955:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB295580363A55E318CCFA61A0865A9@DM6PR10MB2955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tE0sRO3fDYszOxz2E/8axTTw9EaN1DyXSNB5OPlfqtnswEGLZ3Uf32Fm9/HEQC6NVDIghdNBkhrRR7v+SY8dORedScBe7ZHQ8D3OUF2nQNVU+GtVw6Kh2J13y74wntOnFxk855NoPVnyC1SxgQi8wjqYpSWEc2Wfj3uhhyaVadsYzAka5RWHNhmAMLtmOXCW18vAMNwpjY5J5CtAwFx0wgLTGwGFYbohvm/9H1kGFgBcFqspG0WODh3YepREaq3F5zjU8o5gpX0L/wjIyDjd3/49bSghlYlBzmK4+pN8PtIds9tld5jiNz38JtS2TQ5KObOcptA0czJUKpPm7pLlsKGVEy/x4oVON73qd9PDPs8kgJwkPGGg4cYnKb9Igj0o47sMXNseAJaBcl2QNQ+NJx8Md8nhAek7ueGWfKiwqKXzPMMpamd54vFSSLp0nLPkcIUuTefbb9B2F7WSa2u4f4NYFy7REvYDyvKjivi7ttyVUK4a6ET3rqWo+m4+iTm+flsKvnD7Xoyzch+kQ0FQcO7gxwM5IvRJ//PjIrr6zHz7+l66zGFLENIOZeGlLo4peE6UW0dT20st6op4VU+gnu1UuDs2/MIrjm1g1kEZypd1QOzBP7wxAjOhjViUFcrIu2vozi2nrjk586g75N0SLrxZUsHodyZg8OXGPp00PIM6AMDSMuqxdVXFM3nxmGwejTqK2xgMMAjfbpikuT2NjREDdIAqlGpOhCSDpKlcq9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(316002)(66476007)(6916009)(8676002)(4326008)(6506007)(53546011)(38100700002)(6666004)(31696002)(83380400001)(44832011)(186003)(508600001)(54906003)(36756003)(31686004)(2616005)(30864003)(66556008)(6486002)(5660300002)(86362001)(7416002)(6512007)(2906002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FDMFhSTmRHdlFpd1FkRHY2SXNaeUNXa2FKcVdNT3lNc2xMUXVuWGEySSt4?=
 =?utf-8?B?TitNT2llRjl4OEw0ci83ZFhQMFNqQTdheTUvNGphN3lnQ3hLRXErcXJhckZJ?=
 =?utf-8?B?YkthQ1BtNVNTTWNtZ3ZuUGk3V3Y5MzB4Z3ZLTll5VlpmV0JFdXlvZGc4NTBp?=
 =?utf-8?B?bGtETjFrQUYwUEkxeEQ4eTdleTQybjZCUVBHNmtaWVc2dGtxRUliRkhaMVFB?=
 =?utf-8?B?dGJwUWFKTVI1VGV0RXE2VkZLT1ZLMEdxbEZMbmhlUHp1T0FIRkRrNXA1Zld2?=
 =?utf-8?B?QVlOazZUQlpOQk5XdzZrNlRsMzNNTEFoa2tqUnVqbHJUV1ZuYzBiM1phZ212?=
 =?utf-8?B?M1g1S0VqRDlmVHgyNVFCVnV4QnJJRVBLdnRpL2MvaUN6b1VveXBtdkZRRUVR?=
 =?utf-8?B?YzdackdudERUNmp1aWs4cW5HLzRXNzhBQ3ZvVXphU3Z5Y1RBam9qQWk4U0Fk?=
 =?utf-8?B?eFVDZEpOWE1XUUt1RnJoOWV0UlIyR2ExeVdvWjJDY0xZT2o4cnRkaXNPUkpq?=
 =?utf-8?B?TFpIU000VnhOREs0RUlkczNFb3RyR0FSQ1U2MDJrMk1JZVBUbjZwT2huNnZj?=
 =?utf-8?B?dWVuWlBPSzBhcEhLaExKNUJmdDlkSThaWkx0VWdBcTdXT1Rqd2d4azZGTnF4?=
 =?utf-8?B?bE8vRXVOYW96LzdkaHdXSXV2TDU3Y29nVG1tTG5rcjdTZDBvRFhzL0tuSXVh?=
 =?utf-8?B?MUFORFh3elNYb3gxc05VeXFzRzhoZWNlUEluZWYycGlnR1YxRzBXaDlSQldq?=
 =?utf-8?B?VFE4Tm96a0pIenRyeHE0dFFoZks4VzZwZ3IxMXFjdWxBV1ZpT0RiN2F1QW1k?=
 =?utf-8?B?ck9PWTVpdktMR2Y3SjlLOVJ2RFZmSGlwUEkvMWlzTEZkZi90U0N2MnNoRysz?=
 =?utf-8?B?aG84UlZyQ1RRMmdORExuU0NKUGw5MUVBb2FIUWhIVEpob20wTFFFbkJKVTZa?=
 =?utf-8?B?Tm1LYVFMY2tTY2JKU29SRkNTTTNjQ09SemM0TlUvTTBvaFBSTnhXWlYrc2Iy?=
 =?utf-8?B?RTJ2Rnd0U1FNSmdHeWplTmxtZFc1VEhDRTNmZG1YU2VHTWFMd0h3TWw0QUc1?=
 =?utf-8?B?MCtDNXRacjF0UG91L3Nub0p0RnFjbWNDNWsxemVKcGw1NmdTc2llcWVCZVUw?=
 =?utf-8?B?RHEwVVArUFBmQ1BtL1dmZ2VVWEFJZm5oSjVITWQybDVJckdyeGlvUVdrVTFO?=
 =?utf-8?B?WlFCM01yTU0rdEtBZHFuWDI0STR5Zks4WTIxM292bUVhcDh3cm9BSGgzcjR2?=
 =?utf-8?B?Y2hHMElCVWM5T2tHdnFsRi9HeTc5YkgwMkdkVWxsc0MwcE5NUFpzVjNqeSta?=
 =?utf-8?B?NWFkZzgzNUNNTUF4RHhnU0ZjOU0yQTFacmlYRHhQUnYvVGdPUlZVTDl1bFhz?=
 =?utf-8?B?L0RyQ0xtRGROZ3dKSlV5ZWtHNi9mUlovcStsOC9JOGFzeFFtbHNOZlExTlUv?=
 =?utf-8?B?bHM0RlRjQ2xBWGVGT3Y2ZmZKMDY3THdBTE1sejZsNERMZDVoUUQzb1FkNTY5?=
 =?utf-8?B?UkJsL2ZWd0hqbHp5K2RSN0tjRkV5WDRLTGtLSklwbnp1NmlvRndxNHFRalNE?=
 =?utf-8?B?OWxwTm1CczFxMTQxcEc1a3A5WTFBcnBkREtvTTJOc3c2VURGY2lPN21LanQ2?=
 =?utf-8?B?b2ovQ2thR29MeSthZXR5NGlJUGZ4dlZFcVcwWDhyNnZZT1dxRVZ1dGlsSEJM?=
 =?utf-8?B?cDFUenlVbTB4NlVGazN0RXc5NVVKZytUZVdHemY5b0o1M2FqUSs2enE1eTh0?=
 =?utf-8?B?K2ZrUnBFWldYUlo4YjJuZHFxRTNoSEk2R1F3dUdlczhZWFNQQUZxMkpNNnNM?=
 =?utf-8?B?MDYvdlAvYjBlQlhId3E4emVxRkNyQ2syQXJvUktFQnhJRDdXS3lzWmNWc0ZT?=
 =?utf-8?B?cm1QMVBWdjFhUUJzRlkyU0dNQmNJV2xLOWtIOXpzLzhJQk04V0hGUklwdk9E?=
 =?utf-8?B?eW1CYTc2c2VVNmhGbzkxZ2laNkprOC81K2NHeWEzUXhHeC9mV2Y0TDJTenc1?=
 =?utf-8?B?WERlT3NzZ2RVR1V3MXNtYXZ1alB0TnBZMzFBZVJHeVJVdlZEcHNCZ0NmZHBm?=
 =?utf-8?B?b1lBNEJmd21BV3RMSG1BTmJPNHpLdlAxVG5ocjZBNmZUL1M4VCtMVGxIaDBq?=
 =?utf-8?B?Nm9RZGdwcnM0a2ZXUm9TY2ZwdDRDL0t3SDFKMkR3cXY0KytHbmJuMHZFL1FM?=
 =?utf-8?Q?eVDJhVArQ2U28fLoOmSrjSBkuFrGMazku1ykiJAlfW5K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311d8a66-e7a9-49df-6155-08d9dc493c4c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 19:15:35.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swYmpcNnvYw/X1jL0z6vSGucr7YdVA57CTij7O9ZhmSvm//8D3HFw0HFyrz4gptNrNnWHR57YPT+0y3LF+o+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200096
X-Proofpoint-ORIG-GUID: raHSKtMy9g1GW5oIVepyJRoz2UmupmCY
X-Proofpoint-GUID: raHSKtMy9g1GW5oIVepyJRoz2UmupmCY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 05:49, Mark Hemment wrote:
> On Wed, 19 Jan 2022 at 17:02, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> On 1/19/22 04:38, Mark Hemment wrote:
>>> On Tue, 18 Jan 2022 at 21:20, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>
>>>> Page tables in kernel consume some of the memory and as long as
>>>> number of mappings being maintained is small enough, this space
>>>> consumed by page tables is not objectionable. When very few memory
>>>> pages are shared between processes, the number of page table entries
>>>> (PTEs) to maintain is mostly constrained by the number of pages of
>>>> memory on the system. As the number of shared pages and the number
>>>> of times pages are shared goes up, amount of memory consumed by page
>>>> tables starts to become significant.
>>>>
>>>> Some of the field deployments commonly see memory pages shared
>>>> across 1000s of processes. On x86_64, each page requires a PTE that
>>>> is only 8 bytes long which is very small compared to the 4K page
>>>> size. When 2000 processes map the same page in their address space,
>>>> each one of them requires 8 bytes for its PTE and together that adds
>>>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>>>> database server with 300GB SGA, a system carsh was seen with
>>>> out-of-memory condition when 1500+ clients tried to share this SGA
>>>> even though the system had 512GB of memory. On this server, in the
>>>> worst case scenario of all 1500 processes mapping every page from
>>>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>>>> could be shared, amount of memory saved is very significant.
>>>>
>>>> This is a proposal to implement a mechanism in kernel to allow
>>>> userspace processes to opt into sharing PTEs. The proposal is to add
>>>> a new system call - mshare(), which can be used by a process to
>>>> create a region (we will call it mshare'd region) which can be used
>>>> by other processes to map same pages using shared PTEs. Other
>>>> process(es), assuming they have the right permissions, can then make
>>>> the mashare() system call to map the shared pages into their address
>>>> space using the shared PTEs.  When a process is done using this
>>>> mshare'd region, it makes a mshare_unlink() system call to end its
>>>> access. When the last process accessing mshare'd region calls
>>>> mshare_unlink(), the mshare'd region is torn down and memory used by
>>>> it is freed.
>>>>
>>>>
>>>> API Proposal
>>>> ============
>>>>
>>>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>>>
>>>> --
>>>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>>>
>>>> mshare() creates and opens a new, or opens an existing mshare'd
>>>> region that will be shared at PTE level. "name" refers to shared object
>>>> name that exists under /sys/fs/mshare. "addr" is the starting address
>>>> of this shared memory area and length is the size of this area.
>>>> oflags can be one of:
>>>>
>>>> - O_RDONLY opens shared memory area for read only access by everyone
>>>> - O_RDWR opens shared memory area for read and write access
>>>> - O_CREAT creates the named shared memory area if it does not exist
>>>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>>>     exists with that name, return an error.
>>>>
>>>> mode represents the creation mode for the shared object under
>>>> /sys/fs/mshare.
>>>>
>>>> mshare() returns an error code if it fails, otherwise it returns 0.
>>>>
>>>> PTEs are shared at pgdir level and hence it imposes following
>>>> requirements on the address and size given to the mshare():
>>>>
>>>> - Starting address must be aligned to pgdir size (512GB on x86_64)
>>>> - Size must be a multiple of pgdir size
>>>> - Any mappings created in this address range at any time become
>>>>     shared automatically
>>>> - Shared address range can have unmapped addresses in it. Any access
>>>>     to unmapped address will result in SIGBUS
>>>>
>>>> Mappings within this address range behave as if they were shared
>>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>>> page which is shared between all the sharers. The first process that
>>>> declares an address range mshare'd can continue to map objects in
>>>> the shared area. All other processes that want mshare'd access to
>>>> this memory area can do so by calling mshare(). After this call, the
>>>> address range given by mshare becomes a shared range in its address
>>>> space. Anonymous mappings will be shared and not COWed.
>>>>
>>>> A file under /sys/fs/mshare can be opened and read from. A read from
>>>> this file returns two long values - (1) starting address, and (2)
>>>> size of the mshare'd region.
>>>>
>>>> --
>>>> int mshare_unlink(char *name)
>>>>
>>>> A shared address range created by mshare() can be destroyed using
>>>> mshare_unlink() which removes the  shared named object. Once all
>>>> processes have unmapped the shared object, the shared address range
>>>> references are de-allocated and destroyed.
>>>>
>>>> mshare_unlink() returns 0 on success or -1 on error.
>>>>
>>>>
>>>> Example Code
>>>> ============
>>>>
>>>> Snippet of the code that a donor process would run looks like below:
>>>>
>>>> -----------------
>>>>           addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>>>                           MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>>>           if (addr == MAP_FAILED)
>>>>                   perror("ERROR: mmap failed");
>>>>
>>>>           err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>>>                           GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>>>           if (err < 0) {
>>>>                   perror("mshare() syscall failed");
>>>>                   exit(1);
>>>>           }
>>>>
>>>>           strncpy(addr, "Some random shared text",
>>>>                           sizeof("Some random shared text"));
>>>> -----------------
>>>>
>>>> Snippet of code that a consumer process would execute looks like:
>>>>
>>>> -----------------
>>>>           fd = open("testregion", O_RDONLY);
>>>>           if (fd < 0) {
>>>>                   perror("open failed");
>>>>                   exit(1);
>>>>           }
>>>>
>>>>           if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>>>                   printf("INFO: %ld bytes shared at addr %lx \n",
>>>>                                   mshare_info[1], mshare_info[0]);
>>>>           else
>>>>                   perror("read failed");
>>>>
>>>>           close(fd);
>>>>
>>>>           addr = (char *)mshare_info[0];
>>>>           err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
>>>>                           mshare_info[1], O_RDWR, 600);
>>>>           if (err < 0) {
>>>>                   perror("mshare() syscall failed");
>>>>                   exit(1);
>>>>           }
>>>>
>>>>           printf("Guest mmap at %px:\n", addr);
>>>>           printf("%s\n", addr);
>>>>           printf("\nDone\n");
>>>>
>>>>           err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>>>           if (err < 0) {
>>>>                   perror("mshare_unlink() failed");
>>>>                   exit(1);
>>>>           }
>>>> -----------------
>>> ...
>>> Hi Khalid,
>>>
>>> The proposed mshare() appears to be similar to POSIX shared memory,
>>> but with two extra (related) attributes;
>>> a) Internally, uses shared page tables.
>>> b) Shared memory is mapped at same address for all users.
>>
>> Hi Mark,
>>
>> You are right there are a few similarities with POSIX shm but there is one key difference - unlike shm, shared region
>> access does not go through a filesystem. msharefs exists to query mshare'd regions and enforce access restrictions.
>> mshare is meant to allow sharing any existing regions that might map a file, may be anonymous or map any other object.
>> Any consumer process can use the same PTEs to access whatever might be mapped in that region which is quite different
>> from what shm does. Because of the similarities between the two, I had started a prototype using POSIX shm API to
>> leverage that code but I found myself special casing mshare often enough in shm code that it made sense to go with a
>> separate implementation.
> 
> Ah, I jumped in assuming this was only for anon memory.
> 
>> I considered an API very much like POSIX shm but a simple mshare() syscall at any time to share
>> a range of addresses that may be fully or partially mapped in is a simpler and more versatile API.
> 
> So possible you have already considered the below...which does make
> the API a little more POSIX shm like.
> 
> The mshare() syscall does two operations;
> 1) create/open mshare object
> 2) export/import the given memory region
> 
> Would it be better if these were seperate operations?  That is,
> mshare_open() (say) creates/opens the object returning a file
> descriptor.  The fd used as the identifier for the export/import after
> mmap(2); eg.
> addr = mshare_op(EXPORT, fd, addr, size);
> addr = mshare_op(IMPORT, fd, NULL, 0);
> (Not sure about export/import terms..)
> 
> The benefit of the the separate ops is the file descriptor.  This
> could be used for fstat(2) (and fchown(2)?), although not sure how
> much value this would add.

Hi Mark,

That is the question here - what would be the value of fd to mshare_op? The file in msharefs can be opened like a 
regular file and supports fstat, fchown etc which can be used to query/set permissions for the mshare'd region.

> 
> The 'importer' would use the address/size of the memory region as
> exported (and stored in msharefs), so no need for /sys file (except
> for human readable info).

I think we still need /sys/fs/msharefs files, right? Since you said msharefs stores information about address and size, 
I assume you are not proposing eliminating msharefs.

> 
> If the set-up operations are split in two, then would it make sense to
> also split the teardown as well?  Say, mshare_op(DROP, fd) and
> mshare_unlink(fd)?

A single op is simpler. Every process can call mshare_unlink() and if last reference is dropped, kernel should take care 
of cleaning up mshare'd region by itself. One of my goals is for mshare to continue to work even if the process that 
created the mshare region dies. In a database context, such mshare'd regions can live for very long time. As a result I 
would rather not make any process be responsible for cleaning up the mshare'd region. It should be as simple as the 
mshare'd region disappearing on its own when all references to it are dropped.

Thanks,
Khalid

> 
>>
>> Does that rationale sound reasonable?
> 
> It doesn't sound unreasonable.  As msharefs is providing a namespace
> and perms, it doesn't need much flexibility.  Being able to modifying
> the perms post namespace creation (fchown(2)), before exporting the
> memory region, might be useful in some cases - but as I don't have any
> usecases I'm not claiming it is essential.
> 
>>
>> Thanks,
>> Khalid
> 
> Cheers,
> Mark
>>
>>>
>>> Rather than introduce two new system calls, along with /sys/ file to
>>> communicate global addresses, could mshare() be built on top of shmem
>>> API?  Thinking of something like the below;
>>> 1) For shm_open(3), add a new oflag to indicate the properties needed
>>> for mshare() (say, O_SHARED_PTE - better name?)
>>> 2) For ftruncate(2), objects created with O_SHARED_PTE are constrained
>>> in the sizes which can be set.
>>> 3) For mmap(2), NULL is always passed as the address for O_SHARED_PTE
>>> objects.  On first mmap()ing an appropiate address is assigned,
>>> otherwise the current 'global' address is used.
>>> 4) shm_unlink(3) destroys the object when last reference is dropped.
>>>
>>> For 3), might be able to weaken the NULL requirement and validate a
>>> given address on first mapping to ensure it is correctly aligned.
>>> shm_open(3) sets FD_CLOEXEC on the file descriptor, which might not be
>>> the default behaviour you require.
>>>
>>> Internally, the handling of mshare()/O_SHARED_PTE memory might be
>>> sufficiently different to shmem that there is not much code sharing
>>> between the two (I haven't thought this through, but the object
>>> naming/refcounting should be similiar), but using shmem would be a
>>> familiar API.
>>>
>>> Any thoughts?
>>>
>>> Cheers,
>>> Mark
>>>
>>

