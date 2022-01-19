Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F4493EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356290AbiASRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:02:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57028 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354529AbiASRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:02:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JGTurZ032601;
        Wed, 19 Jan 2022 17:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Siu5qx+CMGNCFeDLkZ/YG0t4YiutwRmmBm7tph1YsZA=;
 b=MMZ3L2v58zRHcZd0AvxjCFKMlnaUw36VmJHIS4Z92ndmclJUULChYN2ZhWyu7foemt0d
 fi33OFBLvzgufT68o7tLEOXP3RE3+lV86n749Oftqu+e6f4DZy48TOgJ9CfLvEvObIlD
 ZUsW71JZE/bem2ACXAplkxtzYTeSEatcdl48eH5esovFg72gYgIlufk02MPTiLbf4I3O
 Gq2ifa2WNWvAggAAj3LD4129Jm/4WvoU1bWPDi3IZmGBM0KsuKZKPc7HO8JsRrpy4TW6
 PJ6Ndoi/BXCBz2Yr1TIKyCQldyRYnfvOMnoiD2+KLMkwqtD4QVCfy373XNSU47gUKIt2 +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q5tfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:02:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JH07rZ138389;
        Wed, 19 Jan 2022 17:02:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 3dkqqqqn97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvkvx65cxpYEXAZw6rkXPKW49TfUL5aZUgdUVjaciFnUhTxBzsHZlJOsAdWXKXDCZawYRSpr41F5vF8I1VX7xyHkZi/70OtPd4SKS+DrEGVINOsc9Jq3+la7X3sF6s7E34u1C6Kah3G7jaLt++lNpmUWTc9XyBXcezYlNZ7jQeE1qU0u8ZWvLCR/bur2jvU+vd1nM43dmfSFICxLO0CjBErMoh1fyN1x+aRg0lyH8Es7MhOeSGck585XY5+g9iH8ZsTCK/kkXttTFX/09DrYbwwIFMMFalJ7/bGMD3S7WYCCrx/nl6ddW8fWrd4tg8Fx/n14vEkKHgaVVenQRV10jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Siu5qx+CMGNCFeDLkZ/YG0t4YiutwRmmBm7tph1YsZA=;
 b=JznhDXUYpS+Kc/R7TuZZ/mdiwPixNrqNmAce3gJ1UENXhSQUMKxRXdHT7G/3Uwm7k1kwGLp2KLXbIcrrq6NDTmyfViHwz4SbyXVxe7WpDJGCDEP5p27kme8X5YvFyB+DImo/73eqCry5N/7GJBCKJ/jjE0nXvbpHA4xOIT3qdyPqzWiERSoAIOHBoc+7kY+TBqScuURe07EvdgISgqKjGIsvj/8ZTa/r1qJY6gyGLdDduK/2pin/JnwRMrJIxok5KFz4ZgiczFSO65tEskskHJC1UOHaFEzz//7ro+8N4zTJp+5o4BdgrG7FVZEfd5irMpQ6vUSNElRyGg69eqcvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siu5qx+CMGNCFeDLkZ/YG0t4YiutwRmmBm7tph1YsZA=;
 b=ZE7oLgE6wM6/MfKXlXcNwai/2R/Z55jEjd7whd1zekOnOOUok7PXHFij56pQJn4JQYaUK/73g7TPo0J1sukJicudatnixUvafDKtHEr65S6z2On3hV5BqUnsJMCPNihNX96Ctno1GqEcMyfHZ3BIE2fLTsrIdQojgv84sGcDFpE=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 17:02:26 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 17:02:26 +0000
Message-ID: <ef356f12-5eef-a92e-a816-ab853f2d369a@oracle.com>
Date:   Wed, 19 Jan 2022 10:02:21 -0700
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
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CANe_+UhrcQO0mwB2KJtm69+MDVJuD-r5Cbyqt8AkWdtfY55CCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3a13d67-92fa-44ce-4e7a-08d9db6d77f9
X-MS-TrafficTypeDiagnostic: BN0PR10MB5014:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB50140278AC1B4DBB259E6B5786599@BN0PR10MB5014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYglamTWJ0AQ25PPqUa/esF9qD9GbGWw7wiYc8dq4OrgZqjOYJHeXOmgDTFv+R9sjvgDxXj9GtlY6WnXOWZAn/3kRLQWlqVC5WkOWv+lzR77vdKmh1oVcRn8LkZeeRHmeMXO92hmNGyoKMeVnzytedm1F8pYwzW8cQ9kPJwQ9IDO4Bg0kxsncEBw4zvXQxfj3qEiu0Yuzgxg/ITTHWw09vdxsS2Xjym8ynTVRB/vx1BQ70pdNw44eFBGj3aVpCUqIoXPIKhxWvOTYT1HiICJHLkm28OF+F5xwVZODQ5/ErSv6AqN7MaJa8kyOxmrMQtg7mPXhm79KtHu7vFA89ybYae1vPSBtE+9kgX6rfIYYmGT2lZP4sWOgdfbD4zqI8VIZUT6UNLZj6uL1c0tLFHT4PxTvCIZV9yLFkX8dn1nXnxOIGGfGGaECAXgiSPyttZBa6SNLojIKJNTgSTrILYGNm/hVZQQcpEdSfsoYyYpXb3wsqIKM7vVbVe/HERnRvBmp0iG8MtQu7kvviJ+z8ozgO3QaBuWUx0hCzJbi0yOb3/zjy7aQ0Ja3OwZ5CEBT4OVv6xxqbwFiuhvtrctXZEDvWKamWnFWb0KKxPjE6Ng7zwQJcNTWeryT2E3D5a5Pu8BXKni8UpGhxrsDR8YlEzUE0ZvZJgNkPYUzEpsBu7/wBSYx2aiBpsh0bhdJ+pBLj9XQ+fmfxHhxDl/2CXiw2zTXZp/dZvUa1BMALzafY6lGDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(86362001)(8936002)(66556008)(66476007)(36756003)(6486002)(6666004)(31696002)(38100700002)(2906002)(8676002)(186003)(6512007)(508600001)(2616005)(54906003)(6916009)(31686004)(7416002)(83380400001)(6506007)(53546011)(316002)(44832011)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VCa2V2elg2VFNVR2RHUmpGQit2RWNpS1VxZzk2VTlYY0V1bFFrSnpDenVp?=
 =?utf-8?B?OWpxMUwvb0Zhdm12RE5nOHlXTU1LRHlsK3lLdEJVejNUTTFkN2ZKVS9EL01E?=
 =?utf-8?B?ejRML2t6dDV2bWJLVmpDckNtd01Rdm9jL3lOTzV1bDMraURtZmlMeHE0L3ZD?=
 =?utf-8?B?bE44ejIzQVZSSUNmSS9hRUtydlA4NU5aSWYva3FOelR3bU1obHk4aFhGYWhI?=
 =?utf-8?B?RWwyRHIrTElaSFpucXJNK2d6bmNiaW8wZFViamQvK0V3MDZtNXNRSEtVWVd4?=
 =?utf-8?B?akZWSVEzQlVjSFpMRzg0NnFGZTAwYkVhVEhLREpoc3g5dkg0N0JOSHd2Tkhj?=
 =?utf-8?B?Q1BXSXFaUWxXOEhPNWlrMmhSUllGbThIWm9yZGU4WEp2RGJVOXFCUHRGR2VN?=
 =?utf-8?B?Z21XOUlFRHpBYklHVjQ4QXpzbTlmZGJqbWd1MDZTQzdERGd5cmgrbGhJM2o5?=
 =?utf-8?B?YUNUT3lWRGdFRDZzWk5KM002Q3h6VXBvd0VFLzh2REFIUGVDZzhxNFkzbEY5?=
 =?utf-8?B?c3FKUUl0QTB5WUo1SkQ2cDRrS3NvOXV6azF2REFvUFNBaGhTNFdPdHczU1Ix?=
 =?utf-8?B?eWdUVHFDQVdnTmZ5c0hJT25ma0k0Tkx5WXB6QzBGa2NPWkhaQnF3VERXVnNI?=
 =?utf-8?B?aEs1am9YUU8yMzN4dEJuMEt1SDF1SE5zODM5bXArR2VFaVlDU0U0NHdCczdR?=
 =?utf-8?B?TzlPNCtTMVpMaHdlWWkxdENtcHNQSndtT0pGQ05ZYXNSV0ZwenZjNlRNL2w1?=
 =?utf-8?B?dHloaU83UmdUMFhTNUVrR2hqMnZ5dUhoOFNQV0N2NFd3RG9QZjZJSEFiVkJZ?=
 =?utf-8?B?NEc1bjVyUmVhS2ZlWnM5dUFTa09XaE5YVmtpVHlSdGdZSStVbW5DZVRYUzdP?=
 =?utf-8?B?dXZEOEo3dFlVMGo4VElndFNLeEhVTDVOS0xSM095ZEk1T3VWY3I2N0xDRHJj?=
 =?utf-8?B?KzAzNjF4cjhiVHRpVmVWSGQ1TGVPRWpkZUw3Wkl3QlpvL0xMQm1LN0d5NlRH?=
 =?utf-8?B?c3JqYUF2MjV1a1JwRHBMNGtLVWxEU1FOQjdyV3NDYUg1bTBMbUJ3TmlmMlpJ?=
 =?utf-8?B?SmwxSjJ2Qm9IMHhtQ3pEMG5KcTN3VjVvQUgrMnh0MngxVGp6UHJreUJ6SWNS?=
 =?utf-8?B?b1ljRklkLzQ1UXE4YmsxZzRQdVpjdXp2dGRJSTFTYWJwVWxmV3EyU1IvTmRu?=
 =?utf-8?B?akIwVk1CQTFQK2QxWXlXK1pyaUdEa1JnZDRJU3VtZWFaRE9JVjM1dnRCQ1Ez?=
 =?utf-8?B?THFxQ1ZQeXUybU9OdjlVSEJDTlNPa2xqb0s3RlVRVXJNTFlNTzhJQS94UzNj?=
 =?utf-8?B?MlY2aytMYktEbEdaK05FUEFHZHUwVjVRbVZGbEx2VVZXNGFxbUthNE82WU96?=
 =?utf-8?B?NWFTcHVzTUFTWVBCREtXTk5EQy82K0VuWktIaDlrWFloUXM5c3lJNERBYUhB?=
 =?utf-8?B?ZEplK0NhYmIvSndhMll0RHVPN3A3UkRvbmZLRmNqMDFBTlFPU2hsd3ZXYUto?=
 =?utf-8?B?a2Y5VFlPVHhCRTBBdHRNUzBCSS9hQldEbDZjd1Vya1JIQjVTTmpEQWRHTURr?=
 =?utf-8?B?MlAvdFE4NTNzN1BNY3l4WWFkMEZqWm5kemRPVUI2amJ5UXBlcXdFaTNmcHFW?=
 =?utf-8?B?ams5TlRNU3VFZWxxZUEwYldEVHlld3VZVkFhdGNoSEJIZXdIdzl0OVV4VUdC?=
 =?utf-8?B?QzJVTWJxNWZJTHNqYkc0Z1pHQmNpbFdrUVhoZXhaeTNpTDE1VEFyM21GejVN?=
 =?utf-8?B?QlAzc1BQUVVDVWs1ZVdKd2h4VW5RWDZzNzRieFp5YzN4UzUycVRBaGV3Q2dq?=
 =?utf-8?B?aythVEdvU1pOeUlMS3hNN3hzTXV5NkVUQUFVNjVVZ01kOXc0VUFDQUpvU1Ur?=
 =?utf-8?B?THd5a3hVY2xwZWJNMnFoaEFlYlVERDd1MDRySVFtRjQxRXBaaHlPZ09QUldm?=
 =?utf-8?B?Sjg3TlF5MFc4L01ld1BTSmx0RUNHN0dJM0NTdUNTb2x0WGhhM1o2S3E1Wi9R?=
 =?utf-8?B?elFwOG5OSThEbU5QTS9pbStXMFpETHFZVVZvVVlKYlRXb0kyUGNiZEFPUFZa?=
 =?utf-8?B?bGplNGVRalRFc1Q5blN2SVRSWGV6dUR0bXJsZ3ZETmFGVE9XcjZRdElEUnY0?=
 =?utf-8?B?eFd1MWl0QTlSR205QUZtUE9iRGNLYVM4UVRzWU5saHN4bUFHQ0RXSnM0dWNv?=
 =?utf-8?Q?CuFg5oYr34sH6MFymEUvqC+WVKnYZ7m4kphrvS+cs+9d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a13d67-92fa-44ce-4e7a-08d9db6d77f9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 17:02:26.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxZCZMGKxm5q47soFRFhna79+JRF4lh6gdY3esktVDnZP6r2NWDIw35vFScYorZsISiVe3HBYgtKcpSB3pTnHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190096
X-Proofpoint-GUID: aKqtlkQuW0nd9s5M0qMGYpOvPnr2mHaC
X-Proofpoint-ORIG-GUID: aKqtlkQuW0nd9s5M0qMGYpOvPnr2mHaC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 04:38, Mark Hemment wrote:
> On Tue, 18 Jan 2022 at 21:20, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> Page tables in kernel consume some of the memory and as long as
>> number of mappings being maintained is small enough, this space
>> consumed by page tables is not objectionable. When very few memory
>> pages are shared between processes, the number of page table entries
>> (PTEs) to maintain is mostly constrained by the number of pages of
>> memory on the system. As the number of shared pages and the number
>> of times pages are shared goes up, amount of memory consumed by page
>> tables starts to become significant.
>>
>> Some of the field deployments commonly see memory pages shared
>> across 1000s of processes. On x86_64, each page requires a PTE that
>> is only 8 bytes long which is very small compared to the 4K page
>> size. When 2000 processes map the same page in their address space,
>> each one of them requires 8 bytes for its PTE and together that adds
>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>> database server with 300GB SGA, a system carsh was seen with
>> out-of-memory condition when 1500+ clients tried to share this SGA
>> even though the system had 512GB of memory. On this server, in the
>> worst case scenario of all 1500 processes mapping every page from
>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>> could be shared, amount of memory saved is very significant.
>>
>> This is a proposal to implement a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. The proposal is to add
>> a new system call - mshare(), which can be used by a process to
>> create a region (we will call it mshare'd region) which can be used
>> by other processes to map same pages using shared PTEs. Other
>> process(es), assuming they have the right permissions, can then make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.  When a process is done using this
>> mshare'd region, it makes a mshare_unlink() system call to end its
>> access. When the last process accessing mshare'd region calls
>> mshare_unlink(), the mshare'd region is torn down and memory used by
>> it is freed.
>>
>>
>> API Proposal
>> ============
>>
>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>
>> --
>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>
>> mshare() creates and opens a new, or opens an existing mshare'd
>> region that will be shared at PTE level. "name" refers to shared object
>> name that exists under /sys/fs/mshare. "addr" is the starting address
>> of this shared memory area and length is the size of this area.
>> oflags can be one of:
>>
>> - O_RDONLY opens shared memory area for read only access by everyone
>> - O_RDWR opens shared memory area for read and write access
>> - O_CREAT creates the named shared memory area if it does not exist
>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>    exists with that name, return an error.
>>
>> mode represents the creation mode for the shared object under
>> /sys/fs/mshare.
>>
>> mshare() returns an error code if it fails, otherwise it returns 0.
>>
>> PTEs are shared at pgdir level and hence it imposes following
>> requirements on the address and size given to the mshare():
>>
>> - Starting address must be aligned to pgdir size (512GB on x86_64)
>> - Size must be a multiple of pgdir size
>> - Any mappings created in this address range at any time become
>>    shared automatically
>> - Shared address range can have unmapped addresses in it. Any access
>>    to unmapped address will result in SIGBUS
>>
>> Mappings within this address range behave as if they were shared
>> between threads, so a write to a MAP_PRIVATE mapping will create a
>> page which is shared between all the sharers. The first process that
>> declares an address range mshare'd can continue to map objects in
>> the shared area. All other processes that want mshare'd access to
>> this memory area can do so by calling mshare(). After this call, the
>> address range given by mshare becomes a shared range in its address
>> space. Anonymous mappings will be shared and not COWed.
>>
>> A file under /sys/fs/mshare can be opened and read from. A read from
>> this file returns two long values - (1) starting address, and (2)
>> size of the mshare'd region.
>>
>> --
>> int mshare_unlink(char *name)
>>
>> A shared address range created by mshare() can be destroyed using
>> mshare_unlink() which removes the  shared named object. Once all
>> processes have unmapped the shared object, the shared address range
>> references are de-allocated and destroyed.
>>
>> mshare_unlink() returns 0 on success or -1 on error.
>>
>>
>> Example Code
>> ============
>>
>> Snippet of the code that a donor process would run looks like below:
>>
>> -----------------
>>          addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>                          MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>          if (addr == MAP_FAILED)
>>                  perror("ERROR: mmap failed");
>>
>>          err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>                          GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>          if (err < 0) {
>>                  perror("mshare() syscall failed");
>>                  exit(1);
>>          }
>>
>>          strncpy(addr, "Some random shared text",
>>                          sizeof("Some random shared text"));
>> -----------------
>>
>> Snippet of code that a consumer process would execute looks like:
>>
>> -----------------
>>          fd = open("testregion", O_RDONLY);
>>          if (fd < 0) {
>>                  perror("open failed");
>>                  exit(1);
>>          }
>>
>>          if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>                  printf("INFO: %ld bytes shared at addr %lx \n",
>>                                  mshare_info[1], mshare_info[0]);
>>          else
>>                  perror("read failed");
>>
>>          close(fd);
>>
>>          addr = (char *)mshare_info[0];
>>          err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
>>                          mshare_info[1], O_RDWR, 600);
>>          if (err < 0) {
>>                  perror("mshare() syscall failed");
>>                  exit(1);
>>          }
>>
>>          printf("Guest mmap at %px:\n", addr);
>>          printf("%s\n", addr);
>>          printf("\nDone\n");
>>
>>          err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>          if (err < 0) {
>>                  perror("mshare_unlink() failed");
>>                  exit(1);
>>          }
>> -----------------
> ...
> Hi Khalid,
> 
> The proposed mshare() appears to be similar to POSIX shared memory,
> but with two extra (related) attributes;
> a) Internally, uses shared page tables.
> b) Shared memory is mapped at same address for all users.

Hi Mark,

You are right there are a few similarities with POSIX shm but there is one key difference - unlike shm, shared region 
access does not go through a filesystem. msharefs exists to query mshare'd regions and enforce access restrictions. 
mshare is meant to allow sharing any existing regions that might map a file, may be anonymous or map any other object. 
Any consumer process can use the same PTEs to access whatever might be mapped in that region which is quite different 
from what shm does. Because of the similarities between the two, I had started a prototype using POSIX shm API to 
leverage that code but I found myself special casing mshare often enough in shm code that it made sense to go with a 
separate implementation. I considered an API very much like POSIX shm but a simple mshare() syscall at any time to share 
a range of addresses that may be fully or partially mapped in is a simpler and more versatile API.

Does that rationale sound reasonable?

Thanks,
Khalid

> 
> Rather than introduce two new system calls, along with /sys/ file to
> communicate global addresses, could mshare() be built on top of shmem
> API?  Thinking of something like the below;
> 1) For shm_open(3), add a new oflag to indicate the properties needed
> for mshare() (say, O_SHARED_PTE - better name?)
> 2) For ftruncate(2), objects created with O_SHARED_PTE are constrained
> in the sizes which can be set.
> 3) For mmap(2), NULL is always passed as the address for O_SHARED_PTE
> objects.  On first mmap()ing an appropiate address is assigned,
> otherwise the current 'global' address is used.
> 4) shm_unlink(3) destroys the object when last reference is dropped.
> 
> For 3), might be able to weaken the NULL requirement and validate a
> given address on first mapping to ensure it is correctly aligned.
> shm_open(3) sets FD_CLOEXEC on the file descriptor, which might not be
> the default behaviour you require.
> 
> Internally, the handling of mshare()/O_SHARED_PTE memory might be
> sufficiently different to shmem that there is not much code sharing
> between the two (I haven't thought this through, but the object
> naming/refcounting should be similiar), but using shmem would be a
> familiar API.
> 
> Any thoughts?
> 
> Cheers,
> Mark
> 

