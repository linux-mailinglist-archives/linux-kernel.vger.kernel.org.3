Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A434A78BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbiBBTco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:32:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48992 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240428AbiBBTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:32:43 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212JE8A4031068;
        Wed, 2 Feb 2022 19:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QUm1qg5xgnJ9iSvSimoEM0BrdANv+/L7VGkkgEC7tSY=;
 b=kI6fLx0uNI+e8s/D+O2DzTVmG7kpSKtbpU3qLyKoAZ99a6pRa5j4tYX6mzOjn3Q+11l6
 2rX1AknPhRjpKlHl/h5NpyX8e73K10CG4NfgGEhFWuYoAR4Ms80Mjg1lSUjgOwcTJX8d
 YWoUECnQdG2i2IkQXSIz55VWRP0TChQi3nBuUQzMIBe199NqiVof/xb6PdLF9Rvq72de
 kRBhIxkwSUUp5E1wDCXuB573fs/UFN1lqz6P3pG1hPaAj/s+WPWtqlElIqOkdsDJcBlM
 MH9ZoiKUp6QpjfG7pZJzjE+SGf9OTVMSLuQCrO+ttLGob7I5rgIlJm1BoEA0dJMXJdOj 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac728u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 19:32:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212JFVD7042197;
        Wed, 2 Feb 2022 19:32:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8u3hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 19:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckY3oXN0PAvVm4y1hh5hOalw7vJWFW6uCYgNGlNbhGkRkzOHFZvIfflqNIT8hlpJ+He343aC4amDNWv1O1Cl2kx54+UgDW3ZYZp1xBC2qHifDQw73pPTWlqr43HseDETGcmlovseBW5NVN3WJABR/8Zn7PavSshRiXs98eaY30XYh9POlld0kW0qKENWtYGD83+splURQQeTLx7xJ969FLx3LORS58DjIOlqEGDiF5m4JiCoQ65njjcd8yFsnlIMJthnrJxWW7bR5rR9knElfEuUJhiPiAQjc0kUPpvDE3w9rhSd1mk6fYPpu8OkclwuspAPTuMv2ZFkPDc/R0RSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUm1qg5xgnJ9iSvSimoEM0BrdANv+/L7VGkkgEC7tSY=;
 b=Nq90k/0Re9cq7NBBIySPSz5idNpyLnjvxxckTy38fpqsGnWJDV1CP0eNBrzEZ5U1qpQ9Nwy1vtagcHtCPgPXFglJWnOaUdZuzx5bvMulDZOrjnpyHkhSIJMXzb4qh08w0eS6chnmWaRMIgcXIVCropeyvN2RId3uqVzdY+qLgfp9T83WBxWIgNaotpMKARf+bELCm1m4WsJ1nWWrMAe9zN64T9RsLKz3omislWcBV8oI8QyvKjcPQ6dkNtvy5bPyEtkv9ijfaybtH3uE5nSTlkQw9rVz5yvW6d4qppyww1K/VvnPaIylGdmRbudT9WKIH6mhk8+tzonBmtCB+JQKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUm1qg5xgnJ9iSvSimoEM0BrdANv+/L7VGkkgEC7tSY=;
 b=bH2KFPM8QHK61GP2VUM2wqFB5EkveNrBXVSE+/0KMUC7t/S9deOZ9Z7rmnAw6ZUINCvjPAZXLyRXmaCyF+beb2fjc0CXN3w8NujjhLvtAlirhSibTxQxpwvlUu5YC6OICwGefXoeCsY4Kw4l/5rG+rPzm3CCi2uBkD6plKK7Qvo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 19:32:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 19:32:26 +0000
Message-ID: <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
Date:   Wed, 2 Feb 2022 11:32:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:104:5::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c436a627-521f-42c0-ad81-08d9e682bdf8
X-MS-TrafficTypeDiagnostic: CH0PR10MB5083:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB50839C592683E431271AAE7FE2279@CH0PR10MB5083.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29usCzMx0X5+hLKtRijYhEilwi31FZp6iknI5r43L8JD9vtMliktb9BuFKF7fFt3SQJpyMUxvzWAo+qZ+55tVF12PIyqJY3Mh5bfl2Aua+r7xOY2DQ+XNN5YZzfKBVZm5MdPnYtyNlNRpNPCOYigUE3O5AzhtWC9kD9HzYmhomuPq4LaLWYVC4erHAI0veRj4IglDz0Aqyf0/2YtDihv6NCA1HpEtEZY/ogudS2kRFAdGVdgr2tCzu4rWlkrkJtuwjBdAT1dmusXwZwCHKIFjecIUgxlyGawqFMzcjyE9ljQwZQMgxnZ89A8rSMYwvBd86ZdF1AXceXiiDD8ipKcbrmbJCO09/+ONKJ7UrBduvWUsTKBS56onubDhi2C6e2NJYAeXfeMfl9/WwBv/IW+0fEORKQ/scVvcLoos0ddwxR8h+5K4i6OzXRDAoge/vLQ8PH65WHwRcCkbw7TxzI5lbqn7g48UUdbnKI1EtafowcF4Z2dEAZA7KibUB4LeHp6XLV4tvd0CV0tLSpwYuHZtUyMqF47rbNmrMPHuTyXekGMFQOVtkmfziCCeyivtWn89gmD7GxOMyI2qO8aVLI0XOWnR3bOPWh9sKeULs3ZGVp49MVkQC1OphduYrQ4e3MRGRtD8uSbMIdYDJs8Sr66g+t1J10CVjms4wNLHcNXAb1RzOP6eeSBkkMXZGn0qnIax3FRsxbNBDpFWslmtuGBP2ph/4PuMypS8Y73B1fbIo5yT0J+DMqRQ0aQ8W8yn3F/JOx2Ko0CbSu1A1lG9FBiNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(44832011)(6666004)(53546011)(2906002)(2616005)(7416002)(5660300002)(186003)(26005)(6512007)(31696002)(38350700002)(38100700002)(83380400001)(86362001)(66476007)(66556008)(66946007)(508600001)(54906003)(31686004)(316002)(6486002)(36756003)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9FeG1nRnNmWXluWHV2Ykt4Vjc2bHNGSnJlWHIrL2lFdDNzZDEwRXdtaktY?=
 =?utf-8?B?VGloVk0rQkpjWGxpOXBVbnNJYUxHUkZHOE1ocWZFY2VDNDJWZHBZdlFlUURF?=
 =?utf-8?B?azdwUklRZEx0S084Sk9vZ1orN3NoS3pWMEk1d1lhMXhFOGI3YktQUTcxZlZo?=
 =?utf-8?B?aTdXeEVROGREbUZUSHFXOGxaN1o1Rm9lRkQreFlXaHhHOTNIRDlia1hjMUQ4?=
 =?utf-8?B?VzA0T0tnR3N1TmZHOWFEWkNPWTJPWXM3N2p6aFlyY2xwMWpEa1k5eVROREdn?=
 =?utf-8?B?QzQ5blAxYXk4ZG84eTUzdWNXTnFwSWRkRFQyVTUra0pLem9TK2ZMbGRaMEZy?=
 =?utf-8?B?QnV3SmphVHRjQUgvaEFEUHEzbW5wWXFDVGVPOGpCbjhBQ0lCNVRGaFptNnRL?=
 =?utf-8?B?dmNDMVdPTHovejZoZ254QmRPeE1MM0NFT0Jydyt5Q1BaMk1iSWNxKzI2RDNX?=
 =?utf-8?B?THRvS1REQkNJaUxEYVBRZEZYRStLNmpXeWZLNi9YQTlYR2J0b3VaU1FqS1Jy?=
 =?utf-8?B?cVAwVTh0SjhIRHlYNUxmbnhhbDBoS1J0Sk1lVmRJVm1YWFhGdXRtNkthRlJi?=
 =?utf-8?B?K21mWWwzbEhMdlNFbG5tTU56WGNlclhUUGtVdFNmSGxoUEl4ZnkwYzFMRzRV?=
 =?utf-8?B?MVhnaGVwMjRpRnZScGJ2TzI2WVpCaDdUeU15NVhLaXAxZXQ0T3F5WksvRFlI?=
 =?utf-8?B?YXRValRvYTg4bjFiMzl5N2V1QjhDNVNJTE1nZTlNMDZEL0lmNHlpOXZYRUNh?=
 =?utf-8?B?SW1tMzUzeHAySnM4WUhlOTIxZFR0TG03NzZKalVvc01GZHNZenVhNUxJL0FG?=
 =?utf-8?B?MmIzKzJPaTUrcC9xUXlxOENPUUQwSGJUVlJXZTVmWkhUdU44elhGREJrSW9O?=
 =?utf-8?B?WXJQbUNhSEFUTzdsekxyT0hpSm9kMHhrKzJCNVZnYm1TSUNhY25VOGhIYlB6?=
 =?utf-8?B?Um55bzZjNDByMkZtQXBzRGFWaFlReTdQV1ZnTktQNUNPOE42ZGJQbmZnSkhs?=
 =?utf-8?B?dGptMFRYUVFKbnBSVWVZU2h4Q2lnRXY0QzZZL3dpVklzc09OU2wyRm4rN3ZR?=
 =?utf-8?B?QlRoWDJlV3hRUWNVbzA2VWRjRXRQbGZZZ0dHVDh3cHU5TnFieVRDN1RjTWJz?=
 =?utf-8?B?U2xGaXNSUUpMbjBEMWdURmZ2aDZDQWU1a1dFU0JtRXU4dFhEZi9XVlorZkt2?=
 =?utf-8?B?NHYrVnNXS1FMUVFPNmJEbnNnbFM1ZDkzbmhEdVZtTmp4QS9TWGRPK1YyaDhk?=
 =?utf-8?B?M3ZuVVBiaWdDU1F3cUNoSm81ZkVIYTFGQUZ4Y3dsUDhXdFpFbVc0N1ZxN0M2?=
 =?utf-8?B?aGFMQXJZZXBWck9EY3F0c2FNZ1QxK2dFNXRSZHowNjBIaWhvdTRibVNDcGky?=
 =?utf-8?B?S3gyTmkxVksxVXE3eG1Cdmw5UVl6bTkxY2k0RDZwVndCSHF5a3hYVHg0NXFq?=
 =?utf-8?B?RHhaYys3T1BzOXhXeUo4WnBqenE3ZzJPMkNKRldaK3JSUnpWWXQ2ZWJ1eCs1?=
 =?utf-8?B?OXlFM3gvWVNheC9JWitFTGV3TzhYTnBsRGNjN2hpTVk0cDYrMVNWQlBzdER6?=
 =?utf-8?B?TkVkcUZhWlNOYW50RWpieXVqdjFmK3puSzhxZ0ZPODBSbFpISjQ5QjJKWWt0?=
 =?utf-8?B?NlAxL3EwNFJEZHFOTXo1WHNyQ1pzc3Q2anN6elBjbHJHRmdkaHJseFlZK1lh?=
 =?utf-8?B?eVRvampDalFMRTluOWJzd2ppWkVQYVZkSDhpbFVzSzNMTUNkRGJBdkovQ1Ix?=
 =?utf-8?B?Yzlvd0lhR25DWm1DYkhkcW0wY0JVVUU5RGl4S2t2blN4eVVGK0JGZEUzNGpR?=
 =?utf-8?B?d2IyNUJZQ0tsdmx3Q2xUYzhoKytmRzBFanB0ZWJDWkVkbEovTVpIMWlMeTRm?=
 =?utf-8?B?LzRSY2VqRVZKV3pheWdGRHRheGVvMnNmNFpyMXhDblJCLzY3aXZEMTlIcnl2?=
 =?utf-8?B?T1lpell4OXVESHhuZXV2dTJTWW92MTBDQTJsUVpFbi9OMjd4a2hjWWduVFVz?=
 =?utf-8?B?RDR1ODhGMlo2WTRCZ2ZKWXkyWGttVmtPZHdWemZmanFOUTRmOGJHSFk5M3VB?=
 =?utf-8?B?d3EwbE9qeldJYlhQNy8rVlE1RFJYWUNKOXhkYjdUR0MyTndaQUZGR255U3Zs?=
 =?utf-8?B?R1BFaXc1T3p5TFd6UDlLN0hDZm56VjlwWGtyR1dXOXhyK2Q0U0E2M013cm1Q?=
 =?utf-8?Q?Ytksku03cm7RfIDZ4aNpzXI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c436a627-521f-42c0-ad81-08d9e682bdf8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 19:32:25.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSaVrrBxtpYCJKu6M7buIYVPQ0avH/PqVgNQCavOVaXNt/bGHZhiPE3rdNJHT9jH0Qk7HhaCRFBaI/C3aLiWnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020107
X-Proofpoint-GUID: vYhrjc6dtXK-PTzhOfomyKoFTEjvd76l
X-Proofpoint-ORIG-GUID: vYhrjc6dtXK-PTzhOfomyKoFTEjvd76l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 00:14, David Hildenbrand wrote:
> On 02.02.22 02:40, Mike Kravetz wrote:
>> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
>> certainly makes sense in shared file mappings as the pagecache maintains
>> a reference to the page and it will never be freed.  However, it could
>> be useful to unmap and free pages in private mappings.
>>
>> The only thing preventing MADV_DONTNEED from working on hugetlb mappings
>> is a check in can_madv_lru_vma().  To allow support for hugetlb mappings
>> create and use a new routine madvise_dontneed_free_valid_vma() that will
>> allow hugetlb mappings.  Also, before calling zap_page_range in the
>> DONTNEED case align start and size to huge page size for hugetlb vmas.
>> madvise only requires PAGE_SIZE alignment, but the hugetlb unmap routine
>> requires huge page size alignment.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/madvise.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 5604064df464..7ae891e030a4 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -796,10 +796,30 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>>  static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>>  					unsigned long start, unsigned long end)
>>  {
>> +	/*
>> +	 * start and size (end - start) must be huge page size aligned
>> +	 * for hugetlb vmas.
>> +	 */
>> +	if (is_vm_hugetlb_page(vma)) {
>> +		struct hstate *h = hstate_vma(vma);
>> +
>> +		start = ALIGN_DOWN(start, huge_page_size(h));
>> +		end = ALIGN(end, huge_page_size(h));
> 
> So you effectively extend the range silently. IIUC, if someone would zap
> a 4k range you would implicitly zap a whole 2M page and effectively zero
> out more data than requested.
> 
> 
> Looking at do_madvise(), we:
> (1) reject start addresses that are not page-aligned
> (2) shrink lengths that are not page-aligned and refuse if it turns 0

I believe length is extended (rounded up) by this line:
	len = PAGE_ALIGN(len_in);

but, I see your point.

> The man page documents (1) but doesn't really document (2).
> 
> Naturally I'd have assume that we apply the same logic to huge page
> sizes and documenting it in the man page accordingly.
> 
> 
> Why did you decide to extend the range? I'd assume MADV_REMOVE behaves
> like FALLOC_FL_PUNCH_HOLE:
>   "Within the specified range, partial filesystem blocks are zeroed, and
>    whole filesystem blocks are removed from the file.  After a
>    successful call, subsequent reads from  this  range will return
>    zeros."
> So we don't "discard more than requested".

Well.  hugetlbfs does not follow the man page. :(  It does not zero
partial blocks.  I assume a filesystem block would be a huge page.
Instead it does,

        /*
         * For hole punch round up the beginning offset of the hole and
         * round down the end.
         */
        hole_start = round_up(offset, hpage_size);
        hole_end = round_down(offset + len, hpage_size);

So, not only is this patch not following the man page.  It is not even
following the existing MADV_REMOVE hugetlb code.  Thanks for pointing
that out.  Part of my reason for adding this functionality was to make
hugetlb be more like 'normal' memory.  I clearly failed.

Related comment about madvise man page for PAGE_SIZE MADV_REMOVE.  The man
page says.

       MADV_REMOVE (since Linux 2.6.16)
              Free up a given range of pages and its associated backing store.
              This is equivalent to punching a hole in the corresponding  byte
              range  of  the backing store (see fallocate(2)).  Subsequent ac‐
              cesses in the specified address range will see bytes  containing
              zero.

This may need some clarification.  It says it will free pages.  We know
madvise only operates on pages (PAGE_ALIGN(len)).  Yet, the statement about
equivalent to a fallocate byte range may lead one to believe that length is
treated the same in madvise and fallocate.

> I see the following possible alternatives:
> (a) Fail if the range is not aligned
> -> Clear semantics
> (b) Fail if the start is not aligned, shrink the end if required
> -> Same rules as for PAGE_SIZE
> (c) Zero out the requested part
> -> Same semantics as FALLOC_FL_PUNCH_HOLE.
> 
> My preference would be a), properly documenting it in the man page.

However, a) would make hugetlb behave differently than other memory as
len does not need to be aligned.

I would prefer b) as it is more in line with PAGE_SIZE.  But, that does
make it different than MADV_REMOVE hugetlb alignment.

I thought this was simple. :)
-- 
Mike Kravetz
