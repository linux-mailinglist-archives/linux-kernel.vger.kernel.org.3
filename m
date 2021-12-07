Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1946B1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhLGD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:58:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54482 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhLGD6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:58:38 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5UIf016363;
        Tue, 7 Dec 2021 03:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mv9ZnNlklTLgiD11r0DRmQv/RLyVnD4u1iYjUoTCieI=;
 b=LWRNd9OOvdVLJkwiQwiLW9r2Fg5yxUNfWlFTOsflyBcENm0RIWXXMqRkjrnwYnkr8W1P
 t0zcLRNh5lXI9DOcnLJi8xiux4EwGPxESvHBt1q8v1ihdconq3Kvo12u9RxdyktMuTTG
 oO2Kb7SfvSMwJSvOML1Iisrn3Jc84DsR3+GTRIh2szEnt24/1WuS0B77JfenTlwT+fiC
 w9KYbAerxlWcSZb0YHnpBp14ejzu+HS6coUlLBEkkW1SDcC7uYcCTUIBzF74es2at+gu
 kR2e2Yv9st3F5JdxmHSikg+Kg54Kik7Su2jvyVC/NnNV5B0tZ5MLT8zsCHoJvkK2lmUq cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwm637-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:54:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73pD52003735;
        Tue, 7 Dec 2021 03:54:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by userp3030.oracle.com with ESMTP id 3cqwex0r2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDC8gX9Zd3rjL9b7x+xfdTutwc8FqCUC/2uRb/sUJZ6DCBDF//e1YYvy1WYxhcBksWOhQUZAQ9SL/SiKSKNO1vTCu87hJcMJ2Hb+4mU6zVYi0CXRFkIMMGZIuEjeMOA/7jS5cSbyzD5iADDIdOBIXy8V6pG3rOhnIoCyEy3SxQrRI08TNede/dYfAV6N3H8a27DAbNfXAT3d0mcCc+w0JV8wBhB1lU0z+Cmz7qgcBKBt2EE7bAPh7ovf/WbAaSk4nhMTVi2reAMNBLLoemwIFDvNjyXh/1evdDdSmm+AmEkI+u3CmJk5tqAV0CCI4wXAxlPF9eLttWL7+zwbUvdgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv9ZnNlklTLgiD11r0DRmQv/RLyVnD4u1iYjUoTCieI=;
 b=Cv9VoS6hk0dCPCwVAoRBWpyE3kA9sPfJSoshh36JiPwavZAsdSB+4YPh2XSoefJhr2vpxewG7cmSduOqncqmx6eLpXLHlaGk3REvx9qFEnQq7tQAy2Le6H9lXj0nM8JfvT8DVEezJfzs3ZHwzJCQEo1d8jhHFsv6YxVQ4l1vk1uDzlnbzdyEg+kREBqHFW03ZvhHZCIaGYI+hcr0vtxuoN6iY3V0Ge8JjGNjpnzCD7WKwKRu42fgqSuh0hpETb8NoTqPdjsHPTv4oAn7r6VT/yfuXymiDXOjiflFGARS/DZbDVclj47gB8x377dbJOBJMruh0DpR1H0aajbJtrIFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv9ZnNlklTLgiD11r0DRmQv/RLyVnD4u1iYjUoTCieI=;
 b=dI+oS4cT7KF9SnxmklgrexUXTldMoja+rao1oFrvfghh9JgahRf6BDWutLzjv/6v6/rtDHVwpuuU2bF7++pC1Wt3eaD5xZvUZZzs8mWKNH8WZRDfA91BY4/r0LWfCKfg+/IHHHPATkwNiZTqIEc9qmKro6g+++nBeh7YcFtO5jM=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 03:54:31 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:54:31 +0000
Message-ID: <73cd623e-93cc-4109-710f-f9f4559b2eab@oracle.com>
Date:   Mon, 6 Dec 2021 21:54:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 4/5] dma/pool: create dma atomic pool only if
 dma zone has managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-5-bhe@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-5-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::18) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 03:54:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49ca8ce6-d93d-43ac-5d31-08d9b93545fc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45143E7A2CA7A7E4823EA59CC76E9@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2n6Hxae9EscD9tcCUa2aIHBzvTL6KiPt6+Z4FJ6pbgqUm6PE+ymzKQ+NCAUStCmkxvE2ykd0f/fhb44Dke4xTR9y4tb/IMS1i24GrOAAOQVhrQby0RPORgc5nbA9/I5EMj97JEx7d/Et1g4WIbOyTmE2nEfVap7TnFPcuFNqDpomHoE+XNGZ+0HdSevDqqixuIT0Xsn2no0Je2pEKu2NC4duC/0EQBXXZ39O54gowXBsYn+ABcfRdFGVbh4bxVQjFS8ZqmbiWoVgNgiX7cY4gfdmgL2fugQyMlvMsg9nw3pw7Suz9nY1qR72eiiPXD4ZYVjQBbRdMehShUYE4KdUf6Bf3FePpRVuEiv0EvZ7Ai++YgsgclTRPvSSGG8X017lhiuM6jzEwvJuVDj7ezWIumSH4ba4NjYMwvT8TPuNoCrrVw8YFvA1ULVmLl89TD97SRB6cEFzE1CcQVB2j1QQCKz+s6duLJhYIrVlm9jGteJWZzPSnh3OzsRkoZcZmTycA6CHBox3m5nNn+h4wBs+GhpRv7QcqbIqQhwA5mFUTLAdJs2NG/HsstiLicP1pyYry8J6jSm3hkqWb3AS+dLoFKJRY2Rb26acZSv+vhnfcWA+oX/SSYcFIOxG+/ji8Qn0dtlPEAVa0BR/Io1Zg2oiGdUmZQVBr6xOuv1jRBd1EGIu3i7amLJkcahj1h3Mu3pcqhVYHcUpYzbNwvR/RpzK2qzGRjLecKonrHsGW1iCHsAzaxUam3YgC3i+LJ3vH3U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(8676002)(6486002)(53546011)(5660300002)(8936002)(956004)(2616005)(38100700002)(2906002)(26005)(66556008)(86362001)(7416002)(83380400001)(31696002)(16576012)(36756003)(186003)(4326008)(66476007)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitMYnlGQ3RUampFOUhzSkQwVkhjWUFQamE3ajI5RVRMWG1LZnpKcXhhNHNX?=
 =?utf-8?B?VThrM0gwTmhOU2E0ZFJEOFE1VW5UV1NvS3EvVDlwcFBxdzBsbE83Nm91RWN6?=
 =?utf-8?B?ZXdRQ2V0KzhWME43UzVmdS9RVjFYVldPanBVdkRnei9tcEc4ek1vTjVJQUlw?=
 =?utf-8?B?cWUyZzVPc1pyc05LWFhGNEtXOGdSRGpnNHhYZXhsdGhEUnRaZFNBaWtrbWdY?=
 =?utf-8?B?UVlFK2JpNHliZjU0aGFreFhla015ci9rZ2diL2YwVzd2bmtyTlByVW05bytT?=
 =?utf-8?B?VTlJa29QZDExZzNybUFuZ2tBRHN6dWh3YURiWlpxV1p5M3VIcHFMdTRIdkRp?=
 =?utf-8?B?T1kxODZvcThFbXpBU1I5N1lYY0xVWjV1emhKbUd6WExWUjZXSUxVZ21uWmJO?=
 =?utf-8?B?bTJqUllwQW9QV2hTTVM2MEV6RXVmcEdlVTBjcHpScE9UbFpZeFV4Y2ZoamRo?=
 =?utf-8?B?Y0taaUg0WWtiT2pqZHhMU3dCd1BwVmNQVlBZQjZBVjZMbkpLYlluaTk0NGU3?=
 =?utf-8?B?cldDQU5sNGIwWlkraDh2RzVBdnFCN25UV1F5UUNPNkNyRFFsZHJRQUJ4dlJZ?=
 =?utf-8?B?RDNTbGtpZVh2R2dpczh6SENWdFZpQlV3Y2hkNWtmUWQxc0gwNU91Q2lyL1Z4?=
 =?utf-8?B?cDRHblVBTGowV2NvYVJ0U3I4TnBodW8yT090OEZLUlBFTWFTMTBMUExkaks4?=
 =?utf-8?B?U1R3T0lzb1czS2Q2eno5Y0gwdldDM09nU09rdjBhY1lZU1o3NERUelpoZTFp?=
 =?utf-8?B?VDNRRjBOWXNzZmwxNU9iVnRwUEZNeVhSRU40UllYUHNKeDIxVVpnRkY5MVp6?=
 =?utf-8?B?NFRKaWdhTnRvYnc1cGVEZGNRZFBFakw1VHVHZTBsVWpBRTc5RDVyMFlKN2cv?=
 =?utf-8?B?T25paTBOTnJTdS8yL0I0V2F6SHpkVXBaL2ljelc4L21OUG9aZFcvbFJxOXFS?=
 =?utf-8?B?aXUxa1VWTGF5eDZVcFpaMkZJVVNNdkZWWXVuT3NQSFpKdkxFQ1c0c0dwTzl4?=
 =?utf-8?B?R0l2aEwxY25Ubm5aRUlGZ2VGMVVyYXBpR1B2MFo4T0M5Uzd1QnExNmZveHJS?=
 =?utf-8?B?WFhBNnQvcnBlYkhJMnhjWitSdXIwMXA4cFVQMEZzL0U2YkFOaGM1dWsweHJI?=
 =?utf-8?B?SnVMRzZJdEFudFdoTGZ1K0ZVZ2hyWGNKYW42MjUxQTJMdzBsd0h6UmhwSXN5?=
 =?utf-8?B?TCs0dkVvUlNldzg0enhEbUt0ZVBjbjJrbkNySDJMWi94OGpsTmQyYkxOWEtz?=
 =?utf-8?B?SWZhdU84WEtFcVR6WEtsNHNoZXRRN2dNYzEvbElzbktFYTJZS3dTVElSSGR0?=
 =?utf-8?B?ZUQ1cFBpZjlpMitnYUlqdmFWSU1wUjBIU3YwZUdmRVByUU1lR2g4cUd6QWpM?=
 =?utf-8?B?MG1BT1NOTTVmRHQ3aElSSGZYSFVRWGZrOWhLUkNiOGI1STFmZmx6bGZFamJv?=
 =?utf-8?B?MThBTkJtYWVYaXNvSmNzdlpIdzVqV2cxeHlHK0hxNlhVZFdEeFltQzJBSjMx?=
 =?utf-8?B?M3FQTzhJYlFxZytVWlB6aDhrcEU1RkgvTEIvRDNRTjBmaVpSSTFKVDNLWGZr?=
 =?utf-8?B?cllIcnlwT2JBRVRZN1dXdW42ZThLd2Y5UWhheEtzMGZENHZGNnhnU042d1Zy?=
 =?utf-8?B?ZDBpNzlTRHpVUm1mdW00djlGU1VxWllqbFdqQ3VoeGYydkpwSzZOaWdvcmFW?=
 =?utf-8?B?T21BQUIwSmZXQ0I1SUV3eW5ZbVc1SkVUTnFLV0pvVWtmSVhMZmxaYmg1K2Zz?=
 =?utf-8?B?dURFRnF5ZmRvblhJd2lsdE4wQVpLN0ZOZnpiS1ErQUltTUxpVXNHQ0ZzUWI2?=
 =?utf-8?B?SDFnNEFwbzJPbXA5QVJWa1VueE1RdlJ4cUdtR3d1Rjd0M3Y4R1NqZmJNWjY3?=
 =?utf-8?B?WnRYUGM2aEtDSyt4NzVOdll3aS9qTnUyWnphOTQwaHFJVTNJYXcxZDBTdU9G?=
 =?utf-8?B?dUxvWUw0S0U1Y3hIMGZraTVPTXA3T0N6Y2YvU3FRbW9FT3dqeUcySDg0c3Mr?=
 =?utf-8?B?UHB0eTIxYjhRZmVWZ0Z3cU4wbmhpNUdUWXlyZklwcUErQTAvSW9sdVc4d01s?=
 =?utf-8?B?ZitSU2Q2Qm1TaTNFZDltMTI3MHVKUy9yZ3JhS29ySHRoQkN1aFZ6RGdzR0pP?=
 =?utf-8?B?cDJRalZqZUlydEx5TVBSTHZTdndIRkhvRGRSM2x1WlBJODc5UFMvNForb2k4?=
 =?utf-8?B?bTlhbFFOMjl1K254a00xd29lYmxneFBNT0JoUDUwOFlMSUNZNXFac3RpYkdo?=
 =?utf-8?Q?YojWUHNqbGfOMCAWtAnkluqXlN+f7S2/iCXadcuEGs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ca8ce6-d93d-43ac-5d31-08d9b93545fc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:54:30.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOiDtOLzijvtIt6VYJXaP7QR1gs3in55kG1vkFflKeHnKtHeVG9NkbHgnnJal7hYErhPtPFDNjUIhs/mAcgT4gUM2KQ6KL0PcJWAqxfXM+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070022
X-Proofpoint-ORIG-GUID: CUK3o-6tpORcrz9LcYHbuLWCLMS3EojI
X-Proofpoint-GUID: CUK3o-6tpORcrz9LcYHbuLWCLMS3EojI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:07 PM, Baoquan He wrote:
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
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc3+ #1
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
> Signed-off-by: Baoquan He <bhe@redhat.com>
  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>


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
> 

