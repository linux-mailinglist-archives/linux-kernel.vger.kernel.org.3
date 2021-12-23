Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84647E54B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbhLWPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:01:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36156 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239868AbhLWPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:01:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEhwlR009768;
        Thu, 23 Dec 2021 15:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vVnTi/iXDY5PXUa7Qy5P+OrybF9tAw5kPBoyCrmkXsQ=;
 b=X6FynO9fr6el/tM5R7ZAEz4ULZOtj7FU+r/P7Mndp17mD3jLAa5rqlbzwnULP1EcB+iK
 vS7diJc7tM7s7TuLhQyJiHTQdwscBynCgIWaE2MQvkfobZKZgGFBrZBnYMtTs1ie6HYm
 4i3QPuWPNnqLM+4j8fbCFvmY02B+8MG976TfdEWRhj5UbUkGGQLJQ2odzsBTHpeWDigi
 UGXmL0/6mijWOHKLODu1SZ6GULfz/mxUkpZXBmaTOfHf+PfT1PR5eFGXdUMNt+BmRTLH
 DR68/o46fKxsv2Sii91mzfs2m+krh5KYgSKRn+0HKAlahP/ez+9f2xXN9piht2RIuakr Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn35yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:01:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEv30K179169;
        Thu, 23 Dec 2021 15:01:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3030.oracle.com with ESMTP id 3d14s07t51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0PAQgUZ4/S/5e+QZJSQg+E8B03ZM9gtoLg3xFSLLQWKNJpeLlnZEtrtaNl63oOW1FJysdzCxQcalXp3jRJUyUvU36tI0us5zqh0iwCZfzmu/YBOVk2d2/1a3A5RJAMEGMiRV2AbNvEYUkyCn8hUFUVOWfKPKiCKgcESXlCVU0NVWBPV0mpV7PFU9x+vgzoKwXo9GYJbH8+oSewqgaQ6w0KH0DDIgxgPeh6vaRWQA2C4cdSSguIiILZ934wtUSYBe864sH10nRbEeXO8VrPAvfA0+O7T3Hvm0sHRvpTVjwODUjzfD2xwjgXr1TyIvMG/ot3qBIF/wjvWwdEwpD8Shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnTi/iXDY5PXUa7Qy5P+OrybF9tAw5kPBoyCrmkXsQ=;
 b=a0MKHf/6Pjg2rZqzPwZbK8mE3Zi/NfRU4ElJWnGL7pbIzW9twdMiLaaU5yy/QVykkP+smhVj2vJyWJjhqj1XUh5CxeuuLdW2QUNvUkESsGkLJLR7s9xXxsMMLv7C0Ii2ugIibjwte/8z+FnR6J8Iky87ILn+gNC5jPfNAsCMtbIlm7pCaOM6CV9595ZQO+bjXDZPoeqkFws+CRRTvxDxVvfdCkTwT13O5+qT3Ia7pNiVytTdrfWcyR94CLKTArvUUm65LTvPuD67Om6c8CaoiXoi5GcpCrQnNs1DtVAXNAiBp1cJw39uRSsP80VuNFqnTGJL8IpHKp9ai8H419Qz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnTi/iXDY5PXUa7Qy5P+OrybF9tAw5kPBoyCrmkXsQ=;
 b=rg+lgHPP4Caxh2xnqYcPTa9nFvzpMrcfR+Cbx7f3nvzVbhjdG1tD3SQjQy7DvfOfK5NMcXcrdFxAtTYTs5LJ1suuN2o3upSX+AJ6Z5H5/E9zM9iWf6MzHEXGLMTJp7P+5Dq8uPS2S8VblLwdWTYrSfuQZzMcadt9U0MgJEIM4JE=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1806.namprd10.prod.outlook.com (2603:10b6:300:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Thu, 23 Dec
 2021 15:01:13 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 15:01:13 +0000
Message-ID: <27af5964-6f5f-93f5-4db1-d4ecefff2c1e@oracle.com>
Date:   Thu, 23 Dec 2021 09:01:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/3] dma/pool: create dma atomic pool only if dma zone
 has managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, kexec@lists.infradead.org, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-3-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211223094435.248523-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0351.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::14) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77f8283-afc2-409d-1d0d-08d9c6250fba
X-MS-TrafficTypeDiagnostic: MWHPR10MB1806:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1806EC8C0732C233A5BCFD11C77E9@MWHPR10MB1806.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWt+fGuC4oG/Tb5yosC5lzOTN+qd/Oi+3cjIzZowbPD7UkTGdjqiyccMMQTvkBrGtj02LHjnVj4nvHUOz1J1i1Wt3TQBCdmp/XVDm5kTDOzFVbFlhK/zYQCoea8UMSZXLNcbP+pdcf5JRRNHpGBmSrynwPcgaD7hrjF0lC3MutJ1JYgc3eKTiF6KFi9zTRyKtnE94AlwzXNteltb9QyhzR4G53cYjYhnCzVhZmoEatNdE0bYJ26OzliQVJA+LP+vw5QNUs4HY2SUsVRCa78TAu1v+nE5xb3LR3LhZA05z2grWGZ1X3fXC4dSO3Sd6KUDL9bHDA0Q1wbgXG1/8aOmsBNQ87DwFyZKvND0T2TH2rv7l/lJotFXeHn1OElg/N3piphZv4Nn+/WTXUqMkFBoKZDE3NJ6N4taskPEG4fvDe4jziwPra2g8zZO3xl7APs+MuT1c2zrVWMLETZJL2VGJQbyUK1T3Kc+ltKjaiwk1Ik2xo3Aq9PGfN9vyn06HF+7ogg1k4/zIA/e1r1eTJMbTwCxDJ67vJZuYhE1NKuvCMWyQkiMvZXRfSUGE1WxgoncX4BPSkuLfuwes8jjBSDe24tZxnQBoh+OPTbKD/J6paKUa61f1EMIpZ4zpgWrYgrjaXKd7TrsUCZoO+2YU8tMngWEv4cqltpNfTjBDuNcn09IAa6pgKRTJqfhjuhboNUOpL+6o9SodKaHcADwwpvUhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66946007)(5660300002)(66476007)(6666004)(31696002)(316002)(66556008)(86362001)(8936002)(9686003)(26005)(31686004)(38100700002)(6512007)(4326008)(8676002)(36756003)(6506007)(107886003)(6486002)(186003)(2906002)(53546011)(508600001)(7416002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdVUDcrMTN2Y3BLbW05d1F6TnM5Q0xoM21yeEozV1BPaVVJeHhLS2pJb3F5?=
 =?utf-8?B?akUvTUFPaW43TWFoRXRacktXQ2sxOW1YZVZlL0hJMnFHaUJMbHNucElobmkw?=
 =?utf-8?B?YUpjMWYwWkVqQkV0REozV2ZKTlJyUHBZRnNlK3BSOElUKzAydEdWNWoyMnY1?=
 =?utf-8?B?SDJQZUlNVTFqa3J5WjRnVmdmWTk0alFkK1NnUmhBNGowYVBIV3QxMHhEYnZl?=
 =?utf-8?B?WHlTbWlCZjY2Ung3WnNGNC9UNis0N0FkRjdjZWR4TXh1b2ZFbk5MM0VWSHFJ?=
 =?utf-8?B?RVc3Z0J5NXdwUloya2R2VEN0dUQ5dVVGbzV1L3Z5akhuV2oxaEJMd1RhdEtE?=
 =?utf-8?B?MUtNa09aekowNFNITlZRYmJUbWx2NkJJdXN0T2RxS3hyTkdEak55ZVN2RUNo?=
 =?utf-8?B?Q1c2ckcyUVlDQ3NxZGFIbkE4eE5zVnh2Z01rcHg4dzZRbVRFeVJBSm5sVGhp?=
 =?utf-8?B?WUZUUEJVUkJHeVdHM0t1ZW56M2hnQlE2TXJVVGxBUW1YelhUd0lqYit4NE5T?=
 =?utf-8?B?Rm84V1NSS0lSem9mUFdORmY4NVpFVk56U0gxclM5TUlBSDduT2h0eDkwcERF?=
 =?utf-8?B?eEdMSXUxeHh4U05KWUQvOStsT3BBRElVQ0xKZHdvTnRkTk5FVTZPRnhyc0tz?=
 =?utf-8?B?SHYxOE50UGdXNkhqRHI4REJCKzRvdTZPN2gvRE1lVHNmSkdOVVVocWdCL2xP?=
 =?utf-8?B?QXYvcmJ2SHg4WE5nc0VnZ3p6T0twQURHV3hSU1U2TVI4ZktuMkpEM3RLaGNn?=
 =?utf-8?B?aWt4RkFCdUlpOG85dFVidjB0bEtXOTBId1IxdXF2RHIwaHlnU0Z2dmRCUDJV?=
 =?utf-8?B?NXZtd3FHZDB2TFBqbm1OdjBYaEJjV0JlQnBxVEhuT2w4bEJjT2lzN0NTay9w?=
 =?utf-8?B?OUY4RE14WEE5RGlZK2hnbCt4K0NZWlA3Qll6L1YweW9JZlNjZXJHNi9VNEFB?=
 =?utf-8?B?OXNXOU1aRkhiSUZGVjZZTmVvWGp3elZzTlR1am5EalRnMTFtMGZCa2JXeEsw?=
 =?utf-8?B?TFppSVoxYVEzSDI4NkNJSEpaMTF6Y082VVNMSWE1U0lOelFFd0g4NGw5eVAy?=
 =?utf-8?B?VjZnU3I2QXdOZmhPbkFvQ09ycjJCaE53eGd5dXV6aTNxTkJMbk1QeGt2SUJa?=
 =?utf-8?B?TU14YzE0MVFxRndDWWoxQldWVXRncFNEbFlKcVkzVUJWSDc3alJSZXRqQkFL?=
 =?utf-8?B?Q0FHdkhuZlFIRmcySjZTeFd1R0NBSHgzNHhWaTI3ZU4vN05uUCtONUErRmpo?=
 =?utf-8?B?TlFjdC80elpXR0FEbFdVWXZCOW1Hc1RDcXNWcnl3OU9ER0xpZGYzNnhCVmdS?=
 =?utf-8?B?OXhpdWI0YUNBQWdmSnFqUHFMYU4yUVRNb3pUMFB4cm0wU2xmbVRaNFJiaTVK?=
 =?utf-8?B?Z2FHampvWjRpNm9YcjdRaTZpT2NoMVE3VythYTlpdmtvK2lLbVY4VHNxUzM5?=
 =?utf-8?B?ZnByTnZlWndVWTdIU0YzWlVEc2xZQWRpMWxPbHJ6YU5vb1d2MjZLdkx6OVVa?=
 =?utf-8?B?c2R0L3VzbXB6MklQczd2Z2pYZnJMN3F2bEp0RitNbmlBakpuUE05QU5yZzlj?=
 =?utf-8?B?ZE5JTGRNc2RFalZ5VlFraTBySFJjdkxidXFYSWhSclJKbXFFZnNXRFZrNzc0?=
 =?utf-8?B?NE0wckhkRnVnK21jZVNnUGY4RU9nTUJTZDkwTjVZbFZvVFdhOE5HTHIrb05v?=
 =?utf-8?B?MlRLUlpGK2JCb0FkOEUxek1JK3d2S0dyUk9GWXVxSmJ4L0ttditoUk1kNGQ0?=
 =?utf-8?B?VWNUOWNaVzVnaFZlcFhtRWFlTkxVV245ZjByMnVJZEcxMlczOVhKeTZhUGVB?=
 =?utf-8?B?SU9lZkxOSWlnK2JGeU9ETDRuRExYY00wd1hnRDVrdVVEMHU5RnBRQnY2cmZB?=
 =?utf-8?B?UHRlVkdmK1ZESFUrQ0RvSUF0ZjdCajExdDZ1SWQwZVVSUndYM3FrWS9WWWd1?=
 =?utf-8?B?Z3QxUjRZTjEyUWhXOTdNb3lmT0R6TlQ0eEhYQ1ZicnpCeUtSRDFlL1Baa1Yr?=
 =?utf-8?B?N0NRS0Z0aFRnQ1M5TUxyZEIzanIreFRENDc4VXkwcEl3M3c0VUdFbmU2QUxa?=
 =?utf-8?B?dmZyblJ5Nm5zL3BPaFdRNzRkRXVhTTB0NDBqdyszaktSMGJuQ2xvb1hJeWlu?=
 =?utf-8?B?S1dJUG9zMWxFc251ak5CR3RZUUNiMHJBR3lzVXhIWUx5NFFpanNRWWRCNWV5?=
 =?utf-8?B?YmNRU3lURlhiNHVYVzJGK1ZYei9PSXJEZGN1bGhLL2JleTZ2Y0xIZjM2b0N6?=
 =?utf-8?B?dWQwNk1ta1pxeE1VZ1ZHZFJBUG1nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77f8283-afc2-409d-1d0d-08d9c6250fba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 15:01:13.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fD064+Yc7HQaP9CAgbIrJK80tLvZ5ofbP8bgOS1YkFkaILJysrVDXfKihXO6d/IE2SeSp8DNQgQrH3Afave5moPmvgkvtdlXa2VK/iNrmx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230081
X-Proofpoint-ORIG-GUID: E6Iwo1hsSW4kjCxJdzXvMgE_Njd7S-vk
X-Proofpoint-GUID: E6Iwo1hsSW4kjCxJdzXvMgE_Njd7S-vk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 3:44 AM, Baoquan He wrote:
> Currently three dma atomic pools are initialized as long as the relevant
> kernel codes are built in. While in kdump kernel of x86_64, this is not
> right when trying to create atomic_pool_dma, because there's no managed
> pages in DMA zone. In the case, DMA zone only has low 1M memory presented
> and locked down by memblock allocator. So no pages are added into buddy
> of DMA zone. Please check commit f1d4d47c5851 ("x86/setup: Always reserve
> the first 1M of RAM").
> 
> Then in kdump kernel of x86_64, it always prints below failure message:
> 
>   DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>   swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-0.rc5.20210611git929d931f2b40.42.fc35.x86_64 #1
>   Hardware name: Dell Inc. PowerEdge R910/0P658H, BIOS 2.12.0 06/04/2018
>   Call Trace:
>    dump_stack+0x7f/0xa1
>    warn_alloc.cold+0x72/0xd6
>    ? _raw_spin_unlock_irq+0x24/0x40
>    ? __alloc_pages_direct_compact+0x90/0x1b0
>    __alloc_pages_slowpath.constprop.0+0xf29/0xf50
>    ? __cond_resched+0x16/0x50
>    ? prepare_alloc_pages.constprop.0+0x19d/0x1b0
>    __alloc_pages+0x24d/0x2c0
>    ? __dma_atomic_pool_init+0x93/0x93
>    alloc_page_interleave+0x13/0xb0
>    atomic_pool_expand+0x118/0x210
>    ? __dma_atomic_pool_init+0x93/0x93
>    __dma_atomic_pool_init+0x45/0x93
>    dma_atomic_pool_init+0xdb/0x176
>    do_one_initcall+0x67/0x320
>    ? rcu_read_lock_sched_held+0x3f/0x80
>    kernel_init_freeable+0x290/0x2dc
>    ? rest_init+0x24f/0x24f
>    kernel_init+0xa/0x111
>    ret_from_fork+0x22/0x30
>   Mem-Info:
>   ......
>   DMA: failed to allocate 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocation
>   DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> 
> Here, let's check if DMA zone has managed pages, then create atomic_pool_dma
> if yes. Otherwise just skip it.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>   kernel/dma/pool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5a85804b5beb..00df3edd6c5d 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -206,7 +206,7 @@ static int __init dma_atomic_pool_init(void)
>   						    GFP_KERNEL);
>   	if (!atomic_pool_kernel)
>   		ret = -ENOMEM;
> -	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> +	if (has_managed_dma()) {
>   		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
>   						GFP_KERNEL | GFP_DMA);
>   		if (!atomic_pool_dma)
> @@ -229,7 +229,7 @@ static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
>   	if (prev == NULL) {
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>   			return atomic_pool_dma32;
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> +		if (atomic_pool_dma && (gfp & GFP_DMA))
>   			return atomic_pool_dma;
>   		return atomic_pool_kernel;
>   	}

