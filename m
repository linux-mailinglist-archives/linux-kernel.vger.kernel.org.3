Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4F48C83B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355139AbiALQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:26:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16400 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240810AbiALQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:26:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CGJBdf009449;
        Wed, 12 Jan 2022 16:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=r+BRAvQ+EacLzDQ+DLDkT4Apok5dtIpCCzldhfY0IDs=;
 b=wuR35Dz2BtnBpivXHKZd07W281Ydw0t8gwPdPb6Ptp1Lest15OJaDzrQPbDVHSkyhNEr
 gCHClap5rHkpq0N7sf2RNkxnrXzUph7ocYACkQLPUlD5eOs9jf40Ue2gC4gU/w3pPXIc
 +JeibpLeJxfAJ8+d00iPgkCczYU08Y3sxgc9y6bnKUr91kpPzGEGDHH3kYy5H7BgUu91
 TOBNRaqySAYoyYAU9c7nmT2KDFvy7fbnMJ4jrHvnCL1eG07qgNpD2NytHYTG6EmRxXwB
 A2M+1NM3MdO0q7qJx/VJQ8i3yeJ9Gr7QGnK4ax7v0fbsaS2nhfiiuOru45NL2/l956Dz 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74eme5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 16:26:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CGKJhd160995;
        Wed, 12 Jan 2022 16:25:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by aserp3020.oracle.com with ESMTP id 3df2e6g7yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 16:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4f71ildg/WWd++6CrHbKcX2Ww2rv6bEAvk5fEytoumjH6qn83WQGNg+nDcplBndgwcseAwvFGvesf7YskW/dY1d8G2+aNG5Ica5XnmbkRdH3kp4soEea1i5Nk5gephdKin57IPwtSItqnj4qlHhij7fZVQinHl/Mv5IQAhaL7PTmTOKDTXCnq9AkPdZhSZpnpGw9JFxPF5vIEWK5Iqz04u1QgACQwLenMKP67q5L966CEH6YbbXonJhKiSuHpc9kN7obBI9h3//e6FzCbrkfU6Sf0UXWDNqiWYqR6BO1j0vlB5ddUK1kmRDSxCyigPtcQFdNYq1c/Rk4sSu955g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+BRAvQ+EacLzDQ+DLDkT4Apok5dtIpCCzldhfY0IDs=;
 b=H0S+bCjmp6u+U0m6TBjK4thWbMauYLZmQnmi+m6CQxc+qp3F/2fFDKYofIW1qRsLRmVMZnO2d3fCo47t1vbsNDVXmjKaYL7GwV2VR/zMWxyXjR+31QLy+FB/HpvRqsabgpDoHEGG0tWr8F+mqgMEb2yy6j5hNmxGAstg3leyIhWy1fgVaVGNjK+rZg7JC04S9zuGsoqOTyE8EQ8bsD+mqiXY198LxuaOBkaV33TwuzgOjBo2iGOrB/7aP6zbHZWDoiwVvivwkbE3ul8ZjenJtKf2vAtjkyTzMVeSCuq9PANe8PQSyfCcs22kxf7nZsbK7uZZWPf7qPbb3Kvq8zZdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+BRAvQ+EacLzDQ+DLDkT4Apok5dtIpCCzldhfY0IDs=;
 b=yG5vCs9ou7ub0WI7kxVmiOwKFersT1blvXqEZls2Psj8yelAg0gV8yw8mX6Sa3PIOQEvFhDcIvUb83o1nrD0VNoewV1uM6T+GPhewYQZEnPJCjb+fjehU6XjBGK5oeKImmiasQj3eXojg6gvkpKj93H83TMZJOECN/BmWLf8uOo=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 16:25:56 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 16:25:56 +0000
Message-ID: <57939078-f292-305a-b16d-6ab497ef2edd@oracle.com>
Date:   Wed, 12 Jan 2022 10:25:42 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v4 0/3] Handle warning of allocation failure on DMA zone
 w/o managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, kexec@lists.infradead.org, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de
References: <20211223094435.248523-1-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211223094435.248523-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e4cd0b-f338-49d1-f9ad-08d9d5e835b0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4722B887B4F3E507EFDDEF3EC7529@CO1PR10MB4722.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZKGlIKx1VKr3F5QOADLmtWFyqFT8hnZfxOuWqxmiMP0ICtSyUvJrAO0dcEHqWzfBUSnKinNuZI3gfpjWJRr58SPx/eT9mZF0GGUIAGYQmF3pHZxw9b24ZzhRs0nXeVogCT9w0UhbtB/FCy3axTSrYasvXIh9+rBOCQf2en59cIRIRG9zpUS2ldRcW0d7N/NwJ0V1WQlq0zBk/+f8ANj7Isy9SN3H9hDfMKXz5UjrK8N6aerGxA81GzBWRqaxgAHigphSaYRpy2QdmDodWB6Vun8yBIEYjOkccK/QDjXCSzMHw8GDF+T7GDSF1cvirMhmZFGKiJRIU0ZYc6wwfNVNEyS1/j4XZraYs4Pmwt3OUfekJk7bpY8MgyaL66HSyvpJsKYS8xifynIw3+D2/AYpYv9PT6V1W33Ho4Ba6zmqzUZw8YCAtkE09VCTOSg29lApYPLUaFAoQ09deeslGox3/9cSn5tJUgDClUf4KK4VOblmudNWXP/kkFfJHyskO/iMEWU3O5Zw+oqSW5sTNYzMTeOesrYi2g2Dl72IhRgT7A5sL/pDvTy0EnTdqLC0tMliVIAc2HkgrI6hkhHrh6a8EKYUMF/xrGO4JDqBDwUgFLWOYAmhjBuIabpwO9ooz33APRKJNPQAmP9oEaWk8WmjDJUPdUXOW2qY9PJFysE41BXmq0FuYdLzrGz5vPjNEd3AW0mDc2V/S8iOzfnbag8nam3KQq9M/RvSYOf3x4re8jvQNheDZ9rN1fdnFJKhGW0c8nr2NGpM799vHSzgm0AhGIE2N6RbQMfV3BUaAf1cnMACx7yU6lYIwdRWrifhhQNcSKjvWZW7SSEkhQBSggG0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(53546011)(86362001)(186003)(7416002)(2906002)(5660300002)(31696002)(8936002)(6486002)(26005)(31686004)(6666004)(9686003)(36756003)(966005)(66556008)(6512007)(4326008)(83380400001)(316002)(38100700002)(2616005)(66946007)(66476007)(508600001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWt0MXFSOXNGd3BQRkRrVS9rN3ovaVlyOVV0alNhcDdta0JEV0dmRXlkZWR5?=
 =?utf-8?B?dzBPZlZaenpVeUViR1hENzlueFpHYy9MRDgxZTcvWkZkeVlJVUFEWWhKV1F4?=
 =?utf-8?B?anBUVVRUdGlhUUtORzh2dGIzdFRMRTNTZlQ3eUp0cUxadUlLM3FkdDd0MS8y?=
 =?utf-8?B?WDZNT25YT0NhVjc1WWNLVU9GU2Y4Zk9reFBzL0VIanMwS0VPTnFTSTVwNm9L?=
 =?utf-8?B?WGZPOGVTaFJCRTd1OVhZSTJGMTlwWmFKb0xBaUphWFdQU1liZ3ZEV2ZhdzJq?=
 =?utf-8?B?UFM5OWxneFgxK0xzQ3pqeE5HcXd0c3ZzbWd3aWY3MmdqbFNXbThwZXJZSHNG?=
 =?utf-8?B?NmZrUWZDNGdQdDlXUHVhYjlsME5GbHJCQmlsTGpGM2xaa05LWTcvbW5nMTBE?=
 =?utf-8?B?NlJ6NWRqOXdaU0J2aU4vaExyV212S09Ld3h0d2xzYW83ZHc5dXZXKzlZS21F?=
 =?utf-8?B?c3Z2d21KYUJIOVVvekxELy9GeW5ZUkNKczgwR2doMWlJMHRYTUN2THV0K3p4?=
 =?utf-8?B?WE9GUnNFM1NRMCt6RkoxYWczdUpoY1FPN3JFWmM1TnE2b051WUVwWkpsR3RQ?=
 =?utf-8?B?Wk5obWZkdjNpZnhucnV1cGxXb1J3eENZQlJiM29MRzlJMzJHTDJVbzBDMEtu?=
 =?utf-8?B?M0xwbmNIMWp6R3BsZEgvR1BSZlpNY1hKL2IzZFVVbkR2VERGa2tsL1owaFVW?=
 =?utf-8?B?V0lOcEVyWnZUMnVacTRFZFBZQi9DRkxRN2k4TEJJM0ZVTGZqZXEyVHpuT3li?=
 =?utf-8?B?WUg3TXB6Y05xc0xPenpSM0djNkp4KzByKy9Ba05wT3plSEw0MEtyRUtpRjg2?=
 =?utf-8?B?eFJ5MDNiREtUTnVrK0kyNjNNbDZyK1VzcFRncVpQLytvSDJ3YjJRZm0xN0p5?=
 =?utf-8?B?WlpIbkRiWEdFYVNOVGRsc1lXNnZ4S0YwdXdaakVqWlU1RmEvdVZoS1loeTFa?=
 =?utf-8?B?YVdoS1dxQ3JFaDhBazhvUUFRZURFZmNHM1hyRjJmV3NFRWo4NHZwdFFlNXZN?=
 =?utf-8?B?T1hkNEc4U0VDZER6SkllNlZmRDBLWVVPMFZkVXZ6djJLY3FtYzJBK2duVkFz?=
 =?utf-8?B?WG1VVTd1YXZTZGtCb0dVbEhlbDNxMm9ZQU9jb3c3empJWml3YUJTZWJYall0?=
 =?utf-8?B?d0ZKNXZlTCtMZldUUmRZWndWS2JMQjhpVldHdml4M01YeEtMcGJiNTFTVjhY?=
 =?utf-8?B?OTAvejJ3dWlvbVhadkJoSEVxVzA3b3MvMHdtQWhndXRKeTVEcXN6dUM1RG1Q?=
 =?utf-8?B?UTR3eSsvRVBBNkRuZHJpYzVmVzlCQjBydVdQbFZBY3gyYzcyMmRlMUJDT1V1?=
 =?utf-8?B?S2RoMmljMXpVVWhqRTd1M2dydjZlUGNBVmhDZmg3bDJHL0Q5Q05DVTFrUHBM?=
 =?utf-8?B?V1pnWDdVeU1zMFVBOEJRQ09XbTJRQkltR05DSjhGdnhzTStLOUdTU1c2bTI0?=
 =?utf-8?B?bng2ZEx1N2NkWG5Wa3pXVGdNc3pJci9wV3NmTXgxM01kVkFXbzFkcWxaeldq?=
 =?utf-8?B?azRPeWNXNEJDK3h5MDR4NlRaOCtoRzRqaG5CZlg0SEdHWGd4TUNTRGQycDlm?=
 =?utf-8?B?T3VXNmhoT1ZheGJTcTU0dXBCVGhVZUZNWDNoS3ZpMVlhQ1I0MWxpMlpNQlpJ?=
 =?utf-8?B?RzM4ZXQvNmxiY3BsYmtpV0RmRG1QUGlnNStLSG8zTk42UUl5dm9HZllLZW9m?=
 =?utf-8?B?MlQ3aWozeXRqckpzUnBYMVBMNHUrQVN2aGcrbW9zb0hFVGptS1c1WkxpdEdK?=
 =?utf-8?B?V200aDNlbzVMaFRKbXoyMGZ2WGlDb1dtWCtZeVB2cVJuVnp4eG5mcm40RUMz?=
 =?utf-8?B?dkkxcDhjK1ptdEVpM2drT1RFVEpUTzFGK3paZU1GVkxpOEUyc1FHc3AwTTRL?=
 =?utf-8?B?dC90UkkzR1EvRXpaSUVNZk5NZ08vSlluZ2xmdnV5dEZ2OXM5K01nbkh5MENJ?=
 =?utf-8?B?dHdRNFdKV3pCRzM0anNhRGR0VjFCV3hCM2pWMEhvSjBidTAzaEVQWjJUMzZp?=
 =?utf-8?B?QXphWjFUY3N1YVRyM21SNUhLbFd1U21rL3F1TVJwUnZoNjBUTkFCcUtOY0NP?=
 =?utf-8?B?ZFV2ZDlKdTJNMXBsamphSUpqNUtxYnBJaTJVN255UFhnT2tIakNxUUFtOExY?=
 =?utf-8?B?R29YdWJ2Tzh1V2VGVDFVZE9XMkNLeDBCVFBiNEdQN3piR1R0cDM5L3JkeCt6?=
 =?utf-8?B?Y2dyUFhqci9Pb2NpRnVZYkp4TXhsaDBHVEkyVzFRdDhxakhWQ1Y0RG9KbEZF?=
 =?utf-8?B?RHNVYjNKN2VNS29ZNTk5OHpCTnlRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e4cd0b-f338-49d1-f9ad-08d9d5e835b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:25:56.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i79Han8ZljEYuGp5MQj5FdY+COIo3Vg2ojOQUHQIaP0FqUWLtSL402caM1LSJEcjgSammg0K1jrUNRsYnXWkAEKO/yEZUcRcpE1Scxn11s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120104
X-Proofpoint-ORIG-GUID: 6gc_rJzR0WTMgpHTXF-mMB3ktcmhWBVA
X-Proofpoint-GUID: 6gc_rJzR0WTMgpHTXF-mMB3ktcmhWBVA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 3:44 AM, Baoquan He wrote:
> **Problem observed:
> On x86_64, when crash is triggered and entering into kdump kernel, page
> allocation failure can always be seen.
> 
>   ---------------------------------
>   DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>   swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   CPU: 0 PID: 1 Comm: swapper/0
>   Call Trace:
>    dump_stack+0x7f/0xa1
>    warn_alloc.cold+0x72/0xd6
>    ......
>    __alloc_pages+0x24d/0x2c0
>    ......
>    dma_atomic_pool_init+0xdb/0x176
>    do_one_initcall+0x67/0x320
>    ? rcu_read_lock_sched_held+0x3f/0x80
>    kernel_init_freeable+0x290/0x2dc
>    ? rest_init+0x24f/0x24f
>    kernel_init+0xa/0x111
>    ret_from_fork+0x22/0x30
>   Mem-Info:
>   ------------------------------------
> 
> ***Root cause:
> In the current kernel, it assumes that DMA zone must have managed pages
> and try to request pages if CONFIG_ZONE_DMA is enabled. While this is not
> always true. E.g in kdump kernel of x86_64, only low 1M is presented and
> locked down at very early stage of boot, so that this low 1M won't be
> added into buddy allocator to become managed pages of DMA zone. This
> exception will always cause page allocation failure if page is requested
> from DMA zone.
> 
> ***Investigation:
> This failure happens since below commit merged into linus's tree.
>    1a6a9044b967 x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options
>    23721c8e92f7 x86/crash: Remove crash_reserve_low_1M()
>    f1d4d47c5851 x86/setup: Always reserve the first 1M of RAM
>    7c321eb2b843 x86/kdump: Remove the backup region handling
>    6f599d84231f x86/kdump: Always reserve the low 1M when the crashkernel option is specified
> 
> Before them, on x86_64, the low 640K area will be reused by kdump kernel.
> So in kdump kernel, the content of low 640K area is copied into a backup
> region for dumping before jumping into kdump. Then except of those firmware
> reserved region in [0, 640K], the left area will be added into buddy
> allocator to become available managed pages of DMA zone.
> 
> However, after above commits applied, in kdump kernel of x86_64, the low
> 1M is reserved by memblock, but not released to buddy allocator. So any
> later page allocation requested from DMA zone will fail.
> 
> At the beginning, if crashkernel is reserved, the low 1M need be locked
> down because AMD SME encrypts memory making the old backup region
> mechanims impossible when switching into kdump kernel.
> 
> Later, it was also observed that there are BIOSes corrupting memory
> under 1M. To solve this, in commit f1d4d47c5851, the entire region of
> low 1M is always reserved after the real mode trampoline is allocated.
> 
> Besides, recently, Intel engineer mentioned their TDX (Trusted domain
> extensions) which is under development in kernel also needs to lock down
> the low 1M. So we can't simply revert above commits to fix the page allocation
> failure from DMA zone as someone suggested.
> 
> ***Solution:
> Currently, only DMA atomic pool and dma-kmalloc will initialize and
> request page allocation with GFP_DMA during bootup.
> 
> So only initializ DMA atomic pool when DMA zone has available managed
> pages, otherwise just skip the initialization.
> 
> For dma-kmalloc(), for the time being, let's mute the warning of
> allocation failure if requesting pages from DMA zone while no manged
> pages. Meanwhile, change code to use dma_alloc_xx/dma_map_xx API to
> replace kmalloc(GFP_DMA), or do not use GFP_DMA when calling kmalloc()
> if not necessary. Christoph is posting patches to fix those under
> drivers/scsi/. Finally, we can remove the need of dma-kmalloc() as
> people suggested.
> 
> Changelog:
> v3->v4:
>   - Split the old v3 into two separate patchset. The first two clean
>     up/improvement patches in v3 have been sent out in a independent
>     patchset. The fixes patchs are adapted and sent in this patchset.
>   - Do not change dma-kmalloc(), mute the warning of allocation failure
>     instead if it's requesting page from DMA zone which has no managed
>     pages.
> 
> v2-Resend -> v3:
>   - Re-implement has_managed_dma() according to David's suggestion.
>   - Add Fixes tag and cc stable.
> 
> v2->v2 RESEND:
>   - John pinged to push the repost of this patchset. So fix one typo of
>     suject of patch 3/5; Fix a building error caused by mix declaration in
>     patch 5/5. Both of them are found by John from his testing.
>   - Rewrite cover letter to add more information.
> 
> v1->v2:
>   Change to check if managed DMA zone exists. If DMA zone has managed
>   pages, go further to request page from DMA zone to initialize. Otherwise,
>   just skip to initialize stuffs which need pages from DMA zone.
> 
> v3:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211213122712.23805-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpS2Y0ecPm$
> 
> V2 RESEND post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpSzZmH18k$
> 
> v2 post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20210810094835.13402-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpS0Fbih0f$
> 
> v1 post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20210624052010.5676-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpSwc3nQBz$
> 
> 
> 
> Baoquan He (3):
>    mm_zone: add function to check if managed dma zone exists
>    dma/pool: create dma atomic pool only if dma zone has managed pages
>    mm/page_alloc.c: do not warn allocation failure on zone DMA if no
>      managed pages
> 
>   include/linux/mmzone.h |  9 +++++++++
>   kernel/dma/pool.c      |  4 ++--
>   mm/page_alloc.c        | 18 +++++++++++++++++-
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 


Tested-by: John Donnelly

I don't see GFP malloc failures when the CD-ROM is enumerated anymore 
either when kdump kernel is started.

tested on 5.15.13.





