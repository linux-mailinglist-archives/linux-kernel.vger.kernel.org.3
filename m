Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8858E472EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhLMOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:21:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234716AbhLMOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:21:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDD0Kn0018029;
        Mon, 13 Dec 2021 14:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J/jRZuBKaiejz/jccfltGY1DBSe+XYgrK96py1DRDcs=;
 b=rH4yuptHOlM59XhqQfcev7eyj4J3Wdrs/lC2hWH6BhVvTab7vTrLMSCUjG/vphSdSSDn
 BCPC3cvJGXJQhv1eQiCpgMT2yrbqphfMU6BT9yWzMThPYvYBj/8eioNXy38A1U/g8QnE
 OSYAHL3rtxPfBLcMgBzhU/MKBMrS+5K9fiyrYoGQlTAzyD2y5PVbrYZlj+Og8ebVhuLt
 VmV4HWF0f7tZpVLM5q6Vvi8wzbl9aWhwEJTyc+SdjKKNyKuMZqAndVASnbpobYiCnTak
 bg3WlNFEID+UCFxlV1PwgNP1HJiGbZGWrEbE3LaGGVMTk36A/b3RqY/t4eBtSxOEjToX 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrrn3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:21:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEBVLI154895;
        Mon, 13 Dec 2021 14:21:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 3cvh3vhvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs87glNUVLjX7YeVDZtayCXecWWjGLuJJg4aDXhHBpYEymRxAGxd3uOw4CITdfahFmc8krWk66pQ7Q66mRE9Xn0HnLNMIdkY5YNHQHz205s6IygHlGC9dw481gLlVIpgJgWA1uPJ1wl1Dj0uJ5h090gbwQhxxaABAoKHnUzPnjTycrhr5uyZqnrMzqRmnUvEf3Jbcl8Q1fMWXfug1Kf91dqICsyCKEF8RbMrRqCLGI4qhhHdfxC+SzA7ZIIALQLKWG7JCbFfHyaJdhSRRrQXZmZ6RO58m95Qw2mEUeu377OLkH5Til4u44vXXCFlRSRevDBoDk0+2eyjjbesMiOKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/jRZuBKaiejz/jccfltGY1DBSe+XYgrK96py1DRDcs=;
 b=SgOIoC31P3VzGvXk8LlAnGECQg8YKeSVSmW89eChq8sIV7f4KMV5Qgy4QtrrTvE1jonjRgOo/joPNZQQSrpr7O1P8Y0uHI/3Hh0jlFBX2gkHvJ0zevfDitQCL24DR5p6PB8mnQ+YBQs7wkZSd/eh5OECUz7dvvxarncUjzk+kh1O33v6JBscslw0VRHg3Ev0HVrcuuYMemtgAKLSn4jv3Rdz14XLuk+r80GtIfcrYPnJAuQI2VEyvXCgqoHINq+UN8lmvaeJtceDbOVQNFSbA0OFl3VhtMWCZ3FQLTh7MmEi3TCEgD8P6dqveTp/NRQ0OXGqs8dsziOngym8ZZWrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/jRZuBKaiejz/jccfltGY1DBSe+XYgrK96py1DRDcs=;
 b=0MUz6hUjMvVDzricdq215qh98oSAnw6OJ2bikNT9ggO65CvToAsmTkeMewjEPyOgZGUbSO909G/2D50hiG+lUuPgblzVrWUMzDc7GkwAMdA/jUTVQLn1F3tzlkiRiD3W324gu/mpxXXJiILu2aBeii2z7BpgWZWFVt0DBd3Nb9Y=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:19b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Mon, 13 Dec
 2021 14:21:33 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:21:33 +0000
Message-ID: <89c24193-5826-d956-a6ec-17e18c329547@oracle.com>
Date:   Mon, 13 Dec 2021 08:21:29 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/5] dma-pool: allow user to disable atomic pool
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-3-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211213122712.23805-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1fd4ec2-6c66-435e-e655-08d9be43dcf9
X-MS-TrafficTypeDiagnostic: MW5PR10MB5875:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58754FD4089944FF544C1077C7749@MW5PR10MB5875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5w6zA7ftHa6x/m+ys+kyuT6T/7/TA39CZudwIS4DyY1umcIYggG08puCoadOHX9YUIktfDb3MG4UwyNRTpoWctPJPnSNtCFqhOY63JIV0KZ71JJK2mHAgc9ugzhdyZ8CwNVHVumBkm9MyEEv6/6acy82FLe6tLdC3IBTq5oGzwjjX3sfKI13qu3QyZOtgGnT3YcsxG7W+zEnsylPOcIgliaOHuXa8vHVF8W3Ax50MzQEJ2asQCdBzDZBY7+gldyKkTuyVC1Kwjj5dvw/ES1TTzLPg1pThM00TVhmc2iNr28OkkIOLBW6QfMHd1JofzV5HN4jfm0OzqMk5gcyIlb17nlWMHpa3o5ajbbAscDLL+b+31jGLoDCDxTgmg9snl8hf8lCTkdWzn+MFZ+FHm2vtXTiiYUNR+c+rb/7c9cLWRpAoV87gOA+fvMRG0Y5JOpRqbVAxp7jt+ocLtPRh00grWdgZ9k4MpEyGn+Rr3Kvz2AKLs2sVj0dg5J6kPyiNxBO3+53utSloCePzJZfG6s4tZfwSYajuDxRTUtDFv7mBvylBpEwKl5Tc3LuzWuo/0V/UwRkmny1fobBX1pfmyM5RderjeVulbFWv806zmy7GztNcQ3jOmUG+GK+CA8Z52Pu3x1c3HFO/B4OtAQWXVZ8UbXBaxF/KpT/vZwIoz3IZTAmwnCN5qzXI5hjLFqy3Gt6xh68coq7aZZbue9D3MUBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(8936002)(31686004)(316002)(83380400001)(53546011)(186003)(6486002)(2906002)(508600001)(6506007)(6666004)(38100700002)(2616005)(31696002)(8676002)(6512007)(66946007)(9686003)(66476007)(66556008)(4326008)(26005)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERYU0Y5K2JPS05PaXVRcGhBV1F4WVJWcUZnbmIrQW1BL2c5N3FqemZMbHBU?=
 =?utf-8?B?U1dybjFhY2NNS1BHaWlaMWtnQy9vamRKcE5sT0IwejFoUlZjY2dsbmUwSUJD?=
 =?utf-8?B?MVQ4RXl5UnZUbWhHYmRpbmpVY2grbnJYRS8yZTZBUkJuUHlEalp3OVVmd0pR?=
 =?utf-8?B?Y0JPbDRUQ2pZRjFoR0lxUlZENVdsNnlpOHFobjQyZzF6L1EzSURqUDkwdHhV?=
 =?utf-8?B?ZjN1NHNpY3hQMGFkcXVSWnVWSVE0c3ROZm5DZnRCMDkrbUs3K0s3YytaOVJm?=
 =?utf-8?B?Q1hzSEZLc2lZT3Z1U09Wdzhxbi9OUzN2WWFZeFdkNGdwZ2M2UVdabjZUQjRk?=
 =?utf-8?B?cktTdEpBVi83RStqNHJhWWZnc0xpNXMwV3dmbU5IODFXREFteElHeWkxdkh3?=
 =?utf-8?B?QUw1VWZBN2hSK3ZlTmt0Z1dNdUZJNkNseU9CMFRiRVRVaFp3TytKdHI3YzRU?=
 =?utf-8?B?WGhCaWtDZnVLMTlHYU5MVm9KeEFONlF4SEF1Z0RCYVRFSWNRcisrMkZncmsy?=
 =?utf-8?B?VUVOWEZwK0xWSUN3M3dVYWMxeHVpa1Rwc0xySlduTmc5Rnc3RTl3My9GaFZY?=
 =?utf-8?B?RXFCeGVaTkJQMk8xYUw1UWJtVkJOa011MGpDUGp1a3F1ckNCcytjQkJoQk12?=
 =?utf-8?B?VDQrWmQyM2xBaUJRRG1LT290ZVVIRTZVQS9EemtaaWdVbzBMMjB6dnkvcmdJ?=
 =?utf-8?B?MTlZekF4NE5TUW9Bb3VJQmYzQmI5Z1I4TTJIb2J0TDI1aC9LejVNNk5xUGlr?=
 =?utf-8?B?bTArTzc1SURxSmVtbDBEeCtxRkFtQW1UTUF2SkdUSHNLbDVEMlFxRUhwQWdY?=
 =?utf-8?B?aVMrUFV0bU0wbTI1dzVEUDlHWGgvZ2Z0WFBteGZYemhJUTRjbEJqaHppT3pw?=
 =?utf-8?B?a0R5cUtPcGtQWElnSmlzazJUZXRXM2JPQmVYWU9NaW9jMlAyK3NPZFVzV25U?=
 =?utf-8?B?M3JEUjJmKzRhOG5wU2VORDRnVkFiZTRLeUkzUm8rdzlSc2tjN0FwQ293cExx?=
 =?utf-8?B?ajIyeTBJdjBNUkVaY2JaYUp5dWwwUnIwanJqQjZYdGVNaHpMd1c3MmRCRW9x?=
 =?utf-8?B?NzYrOXNqV1pRNFBjaXVpUml4UzhFQmZOQTRIYkttdDdXVGQ2N3FwQzJ5aldI?=
 =?utf-8?B?c2lhWnJ4cTBMQnlsbFdQZmdqdTFoUjBTMEV1NUhYQ3JiWVJQaUNZanZVbito?=
 =?utf-8?B?WnFzZEhxMlpSSEVjazBHd1pGRmJLcDRSaXJCejVSN08vNFQ1cThyQWpRNHIx?=
 =?utf-8?B?Y0lXVlVjSG53eUJ1RXVEMERNNU45MENyRStzWjN5b0RQTnFjQWQyN1BHUkRw?=
 =?utf-8?B?TjFTVHV6WVZsd3dsdXh0QWlCcVpnWHo1elBFTWx1UGoyWUpoeVhwZVAxSW83?=
 =?utf-8?B?WTJ1bmZBR1BncDkrMjJjUXNDcjhCdXI1ZER0SURDVUVrbG1qUlB2YjIrNDRE?=
 =?utf-8?B?ekNIdFU4ZVBvTklrRGlvdVdzQ2ZyZTN6NjgySHdod0NGaTMyLzVzaTRPZ0dR?=
 =?utf-8?B?MmNrOVZ1VGlmeGRSSGE0ZnNwYXJNdHg1MWFoQ2tlbFNDeGlkRUhqRmwzMk00?=
 =?utf-8?B?L2NJYmpuTU5WcDVtWEZsaExINzh3K2JBNGMyc3lQeVhOazd3MkNmUVB3MTNR?=
 =?utf-8?B?YWg1UXAyazlHNVdYdnBoVkx2UVErNGs4VWpVc3VlNVlwYVN0TS82ZXB2STcy?=
 =?utf-8?B?S3MyemhFUFcxc21yblJJM0FtQmR4Y2NjM3pkUzlYUVBXdmwzZElIZDdjcGZv?=
 =?utf-8?B?cDM4RXZCdC9DL3BMdnpqZjQ5RDVOL2NZbHd1OEJ3M1BOOFRnUERtQlRPUFhF?=
 =?utf-8?B?Z0lqZnF4ZVpDVHEwa093S2ZHQVBjWjQrTTJvK0FTbVh6cmZ3Z2IvK1I1T0lY?=
 =?utf-8?B?dG9xMi91cExHdGVIcTFuV0JoTXpJejVML2tOb3I0ZVRwMXFrKzRpbUMrRWFk?=
 =?utf-8?B?enQ5YXgxODkwQ0JuK3djODYvZm5KY3hKWG5vVDZHV1hEckdTZ1pjZTkyM0dC?=
 =?utf-8?B?R0ZQSnJCTzJ2SzhrMFMxc1ZpZndlb1Z0NkhTQmRZOHZDUzBBMm5NRTBjQnp0?=
 =?utf-8?B?eksvQmZqWi8rL2V0bm9uUW9OVHVKQlY1ZjZaRUJFY1dSR2xhbTZld3hpaStK?=
 =?utf-8?B?UUxaU3FGT2hHWk9nRkhtb1VhSnJvYkdUOEhyVlpUVG9iY3BvbkkrWENWSG1q?=
 =?utf-8?B?cytTZmJhNU5JS3gra3VpaFBNVVlaUTdReFNOK2hNODlNeWxDVm05Myt2WGpl?=
 =?utf-8?B?OTN6Ynl1U0tSU0YwWFg5blBYSmN3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd4ec2-6c66-435e-e655-08d9be43dcf9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:21:33.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTFm+EYa8EeoMkmt0qU5tLiC0NUNtGiG3cuwf94YQaxLkRvMGGZ5WC964Vywpf+zALMhiten++6sQ9RASan4VR5lTIoaMJsa8Lyb4qOX/Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130091
X-Proofpoint-ORIG-GUID: R902dI5tdxmk_2dbK5Z7RIoJYfwwSh20
X-Proofpoint-GUID: R902dI5tdxmk_2dbK5Z7RIoJYfwwSh20
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 6:27 AM, Baoquan He wrote:
> In the current code, three atomic memory pools are always created,
> atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> specified in kernel command line. In fact, atomic pool is only
> necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> which are needed on few ARCHes.
> 
> So change code to allow user to disable atomic pool by specifying
> 'coherent_pool=0'.
> 
> Meanwhile, update the relevant document in kernel-parameter.txt.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
 >
  Acked-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>   kernel/dma/pool.c                               | 7 +++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ec4d25e854a8..d7015309614b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,8 @@
>   
>   	coherent_pool=nn[KMG]	[ARM,KNL]
>   			Sets the size of memory pool for coherent, atomic dma
> -			allocations. Otherwise the default size will be scaled
> +			allocations. A value of 0 disables the three atomic
> +			memory pool. Otherwise the default size will be scaled
>   			with memory capacity, while clamped between 128K and
>   			1 << (PAGE_SHIFT + MAX_ORDER-1).
>   
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5f84e6cdb78e..5a85804b5beb 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
>   static unsigned long pool_size_kernel;
>   
>   /* Size can be defined by the coherent_pool command line */
> -static size_t atomic_pool_size;
> +static unsigned long atomic_pool_size = -1;
>   
>   /* Dynamic background expansion when the atomic pool is near capacity */
>   static struct work_struct atomic_pool_work;
> @@ -188,11 +188,14 @@ static int __init dma_atomic_pool_init(void)
>   {
>   	int ret = 0;
>   
> +	if (!atomic_pool_size)
> +		return 0;
> +
>   	/*
>   	 * If coherent_pool was not used on the command line, default the pool
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>   	 */
> -	if (!atomic_pool_size) {
> +	if (atomic_pool_size == -1) {
>   		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
>   		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
>   		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);

