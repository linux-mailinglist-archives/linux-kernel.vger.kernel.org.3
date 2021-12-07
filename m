Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9746B1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhLGD5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:57:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhLGD5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:57:08 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5DwW012491;
        Tue, 7 Dec 2021 03:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kOUbqREajgD3V0GK4Mvgd/pzi+KH8opCf869peGt9WU=;
 b=OxRm4Jl+TNZS39MZkVpMhknATfKwVuSV4xSKsIBBlg6qliGTOfOZFP6sZFz4GhehJ2Dv
 rT9jMcLzv3AfGKUxER6BuiRfu4OvdTYIxXqohCOWkdKRQJ7LMrKjVYg5BmZNPOS9s/Hz
 og2aQCOdjst/3xcHIXxOFjzgbf0ThhC5eyEmXqBv9jO2GTeuOvHDH0UOXvQsZMjH+5Ly
 GnnXbAxaCvYgen5rYS2LJiylmZqIrnwT/CMgM9q1xGA5LoqcbcrXSjlb2+dcWiHNd9VL
 gc6h0s1LX06pDdJcLSCuDjnjAubr9vXRjhEjxaYRncrloCplCm5z5g9mBfSJLXwMXjGa rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72c5pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73pCEc112963;
        Tue, 7 Dec 2021 03:53:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by aserp3030.oracle.com with ESMTP id 3csc4sq5ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj3ErHptfgTff+BPY3+iNb8FSTqmEU6sL5x6zVel+lqm1sy15oEB+UX/vFNcV37Cn9Ggs0YAXEcqEJ7vSpsIhaGJmExoIucTKrB7CVWmJzmtgPcci0rBP33AOaw8XRUvmkt+0u+X3x3vHC4NqBQ2HQVuAGRDH7J7BxLLaI5VRZm16vA61DrD5uS0KCRzNQ299zd20wtbZQMVVU1Zsb6/WOFRzM7YpS64mHqdJdbA8txywn+ElpAxc8PKNrI7nH2ONAthMhHPQ1AssSYdvRyLK5kyiZHBltXMYnh7za0BrMgyeccjXhAsQzT4AHbGZjh+33Qud5ZParVoXi1ZwyvbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOUbqREajgD3V0GK4Mvgd/pzi+KH8opCf869peGt9WU=;
 b=fAJCQBDKUIZSiiY+/sfVkFtEIislYmbiJRkDzb7FHzReXfcH64r++eVpyB7JXKTEWzZybLFDimPJnhhHn5wzvcnVH27LF/VolNMFIILHUJCtsT3+TGFsZlFpChDHVPXCo0XYhSAzM6WdWEQafDgnwFGHe+lGtYW3j90MTSLq40rL3Pew1TlRt2pctBaOXobkk4ifMZIvykF37KyueST4zZrLCOi6gpcSYmjmbI3fcFy8bPqIdvjrJhHDCx24IAwOBMvc8gI19KgxKuAVbPw00xWoevA2mQu35MPpN8QZuVGu4OM+016+QhTvoLNgY1ZiGIHFu+lTiOSJ7MZ+Bgbvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOUbqREajgD3V0GK4Mvgd/pzi+KH8opCf869peGt9WU=;
 b=Sh/OsRGvmjGLWIuUA410XZHcWvv6+pDyVPCBN9jw/cxeNEZqYoerzg6bn9sGpTo0wVzUV4+0ro2iIhtTZVhleGMymEKL51gfH8sAgkoc2FhZePczXRsPmofQnX9a/qklHt1jUpPNeNtG2/yRkz4JfD1zevpH9E/C2+INd21cidc=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 03:53:09 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:53:09 +0000
Message-ID: <31e002fd-e796-06a0-4a21-1dc02411d8b7@oracle.com>
Date:   Mon, 6 Dec 2021 21:53:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 1/5] docs: kernel-parameters: Update to reflect
 the current default size of atomic pool
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-2-bhe@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 03:53:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9b4d6e-3754-4d44-001b-08d9b9351551
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4514D8343507A5B5CDAC6359C76E9@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wAWGpH6JyogHIG7/kf4wUhkO6tb3/E6RMFlaeqXSXKkzKZc5klK0cPJV/D0yYSA+ouChesaCQ+eA2sdjae7ErOoLiM/feHAPT3Tvf+uadWo2uggfgVMWdUW140zcSV+9tUAHbSGeIHQXn5/7kuLxzfPLepEVbL//NDUislH6Cdef3tgES0bn0bqAJndXA+Bud/f4fxVz8TWZCBTyF2hS+Jnmm2i9O5haL7dHqhrVWP4sQWaVadqmonNVUfAu49fhkK3Ms870Ziko434sOCURlVmEXrlG+1ij5wZH7ggJ9VYz3CFnFsTIEt5bBhPoCycsZXU8UCUJlXEFENz7YSnY1cMys/Yfg8bslAtHl0gqrzf159GibMdKj5+fTQYaBDS33e2oLrUsEEY3DJTLVr1TpKgSKiP+JYqBu6ljEpYToDISZG2189Ho1LDZdXqHXAHm5DjCemyMPN82w4slXbib8NdSt3YA59gHj/WZcr+9TI8f5gNMWhJY/OH/u/7JmTQfgDSeL1b3VDKCF41fs53iUiq3WHavAzDuZydBHSFySZBos5x3aWltGDfEykGRo1YpV39CBst2sJzoTtJ7JF+yD854bMYhV2NyjelEzMsz+elP0i7YH7c5rbV8DMVWWdPQmFMj//BAtYxoUUvXAH58krPIqbr5/tHC9wuFeGODRJCdQpWQF+0k5Au3VTuUvJDXqpXUOIpTnlW/5OYYX5gPvUlU4LkpInIEgQAwoqqnUIQcE1sc5uEUokyoluEghT/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(8676002)(6486002)(15650500001)(53546011)(5660300002)(8936002)(956004)(2616005)(38100700002)(2906002)(26005)(66556008)(86362001)(7416002)(83380400001)(31696002)(16576012)(36756003)(186003)(4326008)(66476007)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2tIMkZGa2JnK0c4K2J3QVp5aHpsQk1yZjRkWVA2Tzl6WVFBTm5nbDJ2dzJt?=
 =?utf-8?B?V2JKNzRpNjk5dGNhQjhkK0JNRkt1UG1TaTJYMGZ1c042SWRjc0Qxb0hJWXd1?=
 =?utf-8?B?VElsMWJDQnF2M3NObXNPeTFqN3BpTlJ1di94U2FWWHAvWXhhcGR4SW9NcUMx?=
 =?utf-8?B?Z0YzTVBOZndhZk1tMi90UEpBWjdKUmFheVp2VFV4dlFOYW02Vll2TlV3S3V4?=
 =?utf-8?B?RGU1eUgzbGZUQXdPTklHRys0QzU5akJxSmN1QzM3ZGRULzVqQXRiL292WG11?=
 =?utf-8?B?Y2FyR3gyZ2trNExrM1Z3UHVTUHdVeWlnK3hQLy9aYlZpQnVta09yMnVic3o2?=
 =?utf-8?B?dGk5WWRQbUN5Q0h6TXFXNlJpbUhXSlZYS2cwdm5mc2lraFFDa0dvVlcyRUVV?=
 =?utf-8?B?N21XdXlMZzkvK0wzVW1ZZzl2NGx0cm1WYkFJd0QzZ1dMUlRjdFhZcUEzU2V4?=
 =?utf-8?B?OUlxQngrYzlrc21JS1duaTV3ZlNsN1VkZHg0U0l1OEFTekhXMFFrUUZaalNp?=
 =?utf-8?B?SFV1VGd6blZWc0tDaHVnVHhDZFFiMlBydFR3eVBPWEZsYkwvK1Bia3BrRjl4?=
 =?utf-8?B?MDY1NTJMUCsxMWY5M09CcG95anZMdjE1OU5GQkM0WjZDdXpMbitqczdSbFA3?=
 =?utf-8?B?RHVEOGwraHJyZjIvNDhOSUxmNWc1Q280dlBYQWp2THB0ejBYbzN3MmZzelJP?=
 =?utf-8?B?Z2Z5Zk9nR29CcHhLWjhZRXZTQnJPMlhJMDBrTDlTQUFqUTRLbDViYk9lbno4?=
 =?utf-8?B?RVI0TitBdy9JdEJaMmhmK2hQOVMvdE0yRUF3eWdXNXNLTnZHNHZUMnJvcDZD?=
 =?utf-8?B?aXRzVXN3SE11ek0yM3dybUJoWTZUTDF1MVZPb3Z6K1QvM2hhSGMwZTJVdEJt?=
 =?utf-8?B?VFJlM0d1QTFwT3hKTFZPV3FSNFpqT1FwUUV6WVUwK3d6ZkdjQm1wZzl2NXdI?=
 =?utf-8?B?U3QyRUN5U3YzQWRLekFFSnNKZDkrQktTQllpUjVFVFVmaVBabU9LcVBPSVdl?=
 =?utf-8?B?emYwOEVkV3lXclN2VVh0dXFoYkJ3UVFIOFR1U2c5L3RSVS9UR25ybmpHcW5R?=
 =?utf-8?B?WHRaMXJvNUluTExWMzRpcWpVaGxBTS9GcG9WMlh3SUlGYStwQk1BblF4Z1Iw?=
 =?utf-8?B?OEk2TFl2SjNlQ1p4d2piNlNqekpmUEk0L1JJSC9qckxFYlZYRnJDeGh4MUkz?=
 =?utf-8?B?b1R6Z0NQNi9ESEs1NE1ld2toM2JMMkdLUnNNeDYzRUlwTEJzM2t2cDg4aHlh?=
 =?utf-8?B?Z3ROdmwzKzVYd21HcjZPZHpUSnpGbElBVlFjNW4vblFvZEY2aW9mUms3a01F?=
 =?utf-8?B?WjYwSjBlRysxdmdubVRtY0RLa3Z3M0hJOFh6QkRjdTNzaitTT3VkMG9GTDlW?=
 =?utf-8?B?SGdjcFJHWTNpS0V6cmplOXlBWW5YRHAzK3hLYUNQak5UalY5aHhPM1BnSW5R?=
 =?utf-8?B?MGhvMVNyaEcyWmc2RVZZcktRb0NZVlVDUnREVXJrODdZNzUrSHA4dnUxalJz?=
 =?utf-8?B?aUdVV3NMRlVwSmpOU0dZN0lGenZ2N1h5b1ZDMlh2VE44NDMzeG5Nc3kzbDBG?=
 =?utf-8?B?Q2FmVG9HajZZOVIvOGpNd0ZvUDBKS3BuTk45OWRRUC9FdUhhb1NTaitPMmVM?=
 =?utf-8?B?c250UURndndRNnlSbGRrZ1Vtem8ybEoyL2JHaThQSnpib1czSSsxa0l0YklE?=
 =?utf-8?B?R0ZyTDQ0QlNKMVN1dThyN0IzVWt4V2xBb0hsMEhMZ2tBZWgwVWEvYlVRS3F3?=
 =?utf-8?B?ZzNNajdkM2RHSHFLdkdnQmZxT2lMeisrSzc3bEZpcW5PZC9DUkJOdndjQ05i?=
 =?utf-8?B?NVRvejExemEyRGZZc0VtdEVZcFc3YTIzVnYzUFZ4ZVphWGVlc1VVWWZidng5?=
 =?utf-8?B?MEpDWXg1bngvc0NPYTByaklwb2hnV3ZJUnBuc3JlcVBHOVYxQUVMMEdWTnNX?=
 =?utf-8?B?dEJ1cFoya2NrWmg0Qng2akp3NnJNQ05ZVzFSYjU4UUdSMEpKNTkvWURPTm4x?=
 =?utf-8?B?T0M1Tlg5WDZ1a0MwaGNZUUxZdE1LTnlGK1JJK1VYRmI2OXE5Yks2Tm9WZjc3?=
 =?utf-8?B?ak9LSVFiY0pnRHMza0xWSTZhMVV3UWlySytUdE9HSFA4S1dHQzg4aGlqN2Z2?=
 =?utf-8?B?RnhLY05pOEJUSllZemVFNlBpOUJ3TWQwMUQ1Tyt0WlBTaXpLenpZRDVRSDdD?=
 =?utf-8?B?UHhRblZuWW1GOVhTeU9mMXlvT01WcUlhSHcyTXYrUTdMMHA1eTV1YzF4ZVND?=
 =?utf-8?Q?aHxRANYmeKLyf8tKJZa37U2Q6Db/LqWHrJNcnDCrYU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9b4d6e-3754-4d44-001b-08d9b9351551
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:53:09.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovgRhNSCYHI2Eq7yZDuxat2fqrmHn5jHFhI8gvrCdkz0X/Ndm9saApfvY5fFskN1iZzkdzMX7PKGN+pgHXgLUwOtsjcsBN0Yiz3vf6Tkd58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070022
X-Proofpoint-ORIG-GUID: G9N4F3exYOPuJvsTZmieebkBRWLwawXB
X-Proofpoint-GUID: G9N4F3exYOPuJvsTZmieebkBRWLwawXB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:07 PM, Baoquan He wrote:
> Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
> size with memory capacity"), the default size of atomic pool has been
> changed to take by scaling with system memory capacity. So update the
> document in kerenl-parameter.txt accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>


> ---
>   Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..ec4d25e854a8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,9 @@
>   
>   	coherent_pool=nn[KMG]	[ARM,KNL]
>   			Sets the size of memory pool for coherent, atomic dma
> -			allocations, by default set to 256K.
> +			allocations. Otherwise the default size will be scaled
> +			with memory capacity, while clamped between 128K and
> +			1 << (PAGE_SHIFT + MAX_ORDER-1).
>   
>   	com20020=	[HW,NET] ARCnet - COM20020 chipset
>   			Format:
> 

