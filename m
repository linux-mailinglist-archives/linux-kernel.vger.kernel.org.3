Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61174868F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbiAFRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:44:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25314 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242265AbiAFRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:44:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTCSY016714;
        Thu, 6 Jan 2022 17:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EpjLRx8cAcBNqzvVXNUQn4an0o4tj4AGarIxvzn8c8A=;
 b=WBcSlvGiQK4SClDAoW/9OzN2zrSSKXHUgCRnyAVVXhRKtsD/ybcKTEiq6RUKMpXPErs/
 0XQ4fsYifxDeUFnpvn5KVs1IKhIJxt1EV29JUFKZfOjJsjvWKW2ELsHOhoM8pjVybbd5
 iXa1jshlZKaVUBnBoc7JDPdwfiljYuePr8dEhWRBtdkNuNYs56HgIrZlyNTTbzmwE3jg
 y/ecft/a9wGNcJWOW1ybzwGe+Ff6tT1PJnaQ+b/y3ufPbgrFc2vCy2vdwdIFsokHJu39
 jnxyozNeTY+As94izCB1fwrXy6ghmhbkyfwYL20t1enEHvaOx+j7SMYPIDIzs6tNsvD6 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v88175-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 17:43:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206HTtwa167659;
        Thu, 6 Jan 2022 17:43:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 3de4vm0p5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 17:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPJNZ0ul6jl4sfNpFUa/vj5MusX/2dWQFu1LjIwVepAKPvQUHUH4X7qC5/ZSFBwMlfDfwwePL/JZ38QuSaNS5Gfm7GR8YAX9fsm0zxuvF29mWIQkVORQDeQq8CHc08SCidW0+YZ6dBlC/6FWLOGaigCsK5JGyhYB62G0mJSE+phhmZ/KpUb1iqQy31MDvbuniGdIlLE9POwc9T8QFdlczfTVZkPnsPLJSbjxpiN70UJuMceTXDXIPNJiaLuNlm8kevmplnfe4XBhFyMXWewZLx7FNqOcsV6OiW2/nVM3zdgqY0ZXVv5U9FqwDiemU6gdn8E1+AEFK86tophwQ2K9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpjLRx8cAcBNqzvVXNUQn4an0o4tj4AGarIxvzn8c8A=;
 b=oMQv94ml2w9tBWd7WtYrZUswailkhFVfN2zdoz9L3FUvI5To9AiJW43zTuTLjhXwI3ddG5lJiqLd1rElpAXYA+vcJz1BJ9DsskzGfaSvhc6fPY4BiOOmcyVixvVjcTIKZ8tJS6Nm9zzyQnPZmcHA5Dqu/YMNOUtaLDrZCuI/F8PkjkuoaS+1LKvJNJQUX8C5G2PTtIfWrVK+uPzBD1s9Z66Br3qtc0FdKT8EnBPN5TErX/dNBAtTBGyvaaa+BL7N2ZT+LOrN8dsXdsePcV4BkBR6gbtzBdYimmgOt6t34KmI+lPYmkWHxuQ8winjltBEF6jCLVAJzZR2x+gb1DveRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpjLRx8cAcBNqzvVXNUQn4an0o4tj4AGarIxvzn8c8A=;
 b=mbcq63R7fsUzi2n9s+KVbtcdXGfcpxBj2y1GSquRDhO0Dx4u83QWHBeC6gAz9zxZPvtVdhwG+cL66QrU+U/cImtb0fRttmssia33tolqcamd0+IfWs+U1YUErI3MuZ0mU2OR7p8fhov/1ruPf8AZrnhOepFV/aD0j+Pon3mbfs0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 17:43:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 17:43:48 +0000
Message-ID: <92ad1cf1-cd73-c3f8-44b6-6eb917b94693@oracle.com>
Date:   Thu, 6 Jan 2022 09:43:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220104021729.111006-1-mike.kravetz@oracle.com>
 <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
 <20220105155613.45d7dcb81e19bd42deefab79@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220105155613.45d7dcb81e19bd42deefab79@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:300:12a::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5103af56-1a31-413d-4b67-08d9d13c185f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5632:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56327791E5F0156DEB45A4CCE24C9@SJ0PR10MB5632.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /paTHbWyi3D2W18IcxdOjZpEI4Ay0ZqAIo1x8ZRPHBPFHcC/Dflr9Q31S97e9ftCUrTKFkoXRk65bRxY0awaKSugtOmJoYIyK3RoxMqE3Zva7iK2CihYj9Z1UuDq8U+B07HIHeruDC35DhwPOQXuQELtcDprRLcxVVBBIotwEV9PaV6lyIxzQjg3rnvzQ29/XMkim+j5zmoFtKpw7dohIzjVB9O4icb1hskjpG2dH64MNoRmbbIJqskuhUdgbY34e2TT30gUw3eH3MCdzpVU1RjukzWrYVx9cbd4RHktFgA/ycMWqMggh1KlAL03nfnu54Q8lk2AuY/9CP0EjCasd79/6f6w/S1IDAIsP64UlDo6ny88TfceOrt38tnVhP8qKFvqg6z88UNXRRGhzv7lHh0gfXtOeSnbW75BdvDosLPTpgc6zSHLIuKaRBMiAMI/FSWc3bD0x3B7Q6H3egT7qLoY6C/pL9Ljq9WXNHnznmRrS1HDoAcc9V0sotV1fEXGq60RhYyDIDpRAWxLmbkRyrKTVVS0MtRJX2xIy845ocw4UiZlm9/9VTlJcZ2yosMGLmt0LRyW8qo8lmQZoEDNw7Xyho0cd3LGAKkvOcNb+YVZOkqbXokUioaVTFbAuqFsuqog8kN9C2e72Bv4wmHRSmt9XhsN+6jJqKwDfomYv79TepAupROs2R31bskrxkI1Rv6pInSJa1Yi+Czp3UXkl44NrMtEgC7l2e+dXuvU2IEjG9CUanQIG+lNrX/vt6/greQRmOBW8sD+MTAhAzC3hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(4326008)(6506007)(53546011)(66476007)(6512007)(316002)(66946007)(66556008)(44832011)(110136005)(186003)(54906003)(26005)(508600001)(38100700002)(6486002)(2616005)(38350700002)(52116002)(83380400001)(36756003)(2906002)(31696002)(8676002)(86362001)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alMwbGdjMUJyemdtb00vdkk2VWUxcTVoRUE1WjVOSW1pY2ZhL1pSR1FEN2Fr?=
 =?utf-8?B?c1R6QmE1bG5iM2FlTDhXMDV3U1hmL2F1N2Y2UlA5YVFXa25TUkxwRlBhRkph?=
 =?utf-8?B?WkVab3cvTHFJaUF3VVR3SlNRVkQ1cE1LK3Z4MmV6UFR0QVJPQ2YrZ0kwZmxC?=
 =?utf-8?B?SHVOZ05wdzVGVU5nWTRUMWlzUTVoRTBCUDRTZ2dobFZlNlVONkJJa1FKUmlB?=
 =?utf-8?B?NUx0M1hqTUp4eWhQWHluZm9lejFnZGQyRFpxQUNCZ0NxQkRDRGV3aWt6aE5v?=
 =?utf-8?B?Slk4eXZpOGhVUHlCSzZoYXJmaFdKTlJ6dlZxWCtHbEovc1VNdFhndTk3bldC?=
 =?utf-8?B?Yll4YWZBS2FmWnI0K3h4cWgydXlZN2czZE5wYjRORXo1M2sycnJBU0Z5WmlP?=
 =?utf-8?B?bkdTWktxaCtIN0QwcTF4b3pLSkVudTZpQnlqeGthSFpxZXFtWmpUMW1GKzF0?=
 =?utf-8?B?UnJPaklGVExmaFdWNkN3WlhNaVVlWVN2YXA3eHZYQmJka1h2emFYS29Cd2VK?=
 =?utf-8?B?ek9qaHRNSStsOVphM3V1WEpRRVY4OXN5VTVna2diU3EvcjRsKzg3VXdKd2t0?=
 =?utf-8?B?L0l3TVovYlFOUm9ka2tVV1ljTEFiUUpUZE85N0NzZHgxeHRxblg5cHVWaXB1?=
 =?utf-8?B?R2tETGtPUE82TFY5bUlROTdCVjgwcUNXS3MwM0pCL1gwZTRwbEpCUFc4K0U0?=
 =?utf-8?B?dzlGNjhQbWNKMG9JUlNtNDNYQWFOWVU3bEpWSGxNaWxZMEsxTW1ydjNlenAz?=
 =?utf-8?B?S2crUmxydDdDNXJNN2RNbFJGTlVkbjRHd3QvMVRodTJnYUFNSnRZU0RwOUdG?=
 =?utf-8?B?b3ZXcW5hUjc5OVdENVJvVktwWEVjSkwram83L1RMejNiNE5HWnV4TmcyVnRX?=
 =?utf-8?B?cWczdjJmb0M2NGR1NnhqOHdpSWlJeUEyaEZ6L3ZkS01SdEgweGNFZlZ4Vy9n?=
 =?utf-8?B?OXhwSFU5bmFVdFNacVpkVU9haGlwSHFiZWtraUNIRk84V1kxRUtBNG8rSDl2?=
 =?utf-8?B?enRLdWo2V0VqUUxweHhGVFlPMzBweC80clVxcm9INlVZWTBoUW5GTnFtVWlB?=
 =?utf-8?B?L3BTSE5iRVlCNENDb1JHcDFNWUVwNkM4L0NaSWdxU0svUG5GTDBwd3lyTjI1?=
 =?utf-8?B?VjNsRjF3M0J3VzdTZ1ZDLzlGQU82S3lYc2cxaGZMQ1FqeVlSem9DNDNrbVUv?=
 =?utf-8?B?TXJ4aDZST2VuejJhRG9aK3RmdzljcEpqcTZTYk9Sdk5NTTZoSTVrYmRVbWtW?=
 =?utf-8?B?ZHU5czlkMHBTa1dTTDRDWU9jaWZZS3VpZ1VsVnFHQ040Q2JmUURpdDNzNnVH?=
 =?utf-8?B?NmtsejlSRUJURUExUWs1S0pETjkwa2V2R2FCM1lIdHlua1U3M3g0akR6NC83?=
 =?utf-8?B?NFYzZ1N4U0h4WFpZUWZ3bmZDaWluYngrbVA0TnNPZWdjN2xXQTlFTzNXQXZ4?=
 =?utf-8?B?Y3o4aVRsOVlVRXJBL0s0bWphTHpRT1ZXQnI1RXJoajN2V2UrNzZ4NEhGMTZI?=
 =?utf-8?B?M1RtNkxwRDFXekZxWW05UkpsSDBHV2s5eVc4cXkxRUdXdWgvRllabEVsZ0sx?=
 =?utf-8?B?OGsycUczeXlWaGxxelNieEl2Z2cwZlBsZ0tlejY2OTkzRmN6ZW9aQTR0SU1q?=
 =?utf-8?B?SUI0YVRudkt3VXlvR0J3dkMyaVBzTFdXVFZ3VW5GeDZjTk1ZaGZZWVJYU1I1?=
 =?utf-8?B?THVJdG5WNi9DejcrUWpNb3dqOHovMHZ6YlV0N2J0WGZHd1JFcjB0MTNidXM1?=
 =?utf-8?B?V1ZkbDJtenFkaW40aUhTcHlMQjR4ZmZzekR2Rlo0LzBZNFJYTXFWZ3NRSDJX?=
 =?utf-8?B?UW9rdk1RLzNNaFFxNGVmYU94VEg0RW9mU2lqblQvZ1I5LzhlQ3RRSmdoZW8r?=
 =?utf-8?B?R3htcGt4am5DVFZOSk5ubWdxcW5yMFQ4YmhJWnErYkt6bmZrNG0wODRhSkpY?=
 =?utf-8?B?NGNpY1Z4YUUvbmRpRWxjVVVsM1NpVFRKT0dweTdJeGl0eTJ5QkwrQVhKNVVF?=
 =?utf-8?B?OUd2MWVTMjZFRW04MDNXdFkwYWNsNkNYR2pEQ29hazVNQjBqdGxEZnpVdDZr?=
 =?utf-8?B?OUE4dEFTUUNDQWpnVkR6K0JYODJiakJpWklRYmZTR1A1Y1Y2SU5vTkFjemNM?=
 =?utf-8?B?L3dJY291S0VmeXYyWmk5N2U2UlRJcE5CSWFtS1Z1VEhkVnc4Wk0wSi9wampw?=
 =?utf-8?Q?wf637UJAnRoKMDfWPa5CuAU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5103af56-1a31-413d-4b67-08d9d13c185f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:43:48.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq0He851StN1a2UuGPwQdx2T8RsH0MLXab5tu/ODux2atWZ+PEylKsLPxMniyQe1vWqGTnsDEg29aUvFLI1LjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201060118
X-Proofpoint-ORIG-GUID: IOfDa_dslMI3fXM5xWYobuJBshcEdY4q
X-Proofpoint-GUID: IOfDa_dslMI3fXM5xWYobuJBshcEdY4q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 15:56, Andrew Morton wrote:
> On Tue, 4 Jan 2022 14:35:34 -0800 Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
>> On Mon, Jan 3, 2022 at 6:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> The message for commit f5c73297181c ("userfaultfd/selftests: fix hugetlb
>>> area allocations") says there is no need to create a hugetlb file in the
>>> non-shared testing case.  However, the commit did not actually change
>>> the code to prevent creation of the file.
>>>
>>> While it is technically true that there is no need to create and use a
>>> hugetlb file in the case of non-shared-testing, it is useful.  This is
>>> because 'hole punching' of a hugetlb file has the potentially incorrect
>>> side effect of also removing pages from private mappings.  The
>>> userfaultfd test relies on this side effect for removing pages from the
>>> destination buffer during rounds of stress testing.
>>>
>>> Remove the incomplete code that was added to deal with no hugetlb file.
>>> Just keep the code that prevents reserves from being created for the
>>> destination area.
>>>
>>>         *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
>>> -                          map_shared ? MAP_SHARED :
>>> -                          MAP_PRIVATE | MAP_HUGETLB |
>>> +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
>>> +                          MAP_HUGETLB |
>>>                            (*alloc_area == area_src ? 0 : MAP_NORESERVE),
>>> -                          huge_fd,
>>> -                          *alloc_area == area_src ? 0 : nr_pages * page_size);
>>> +                          huge_fd, *alloc_area == area_src ? 0 :
>>> +                          nr_pages * page_size);
>>
>> Sorry to nitpick, but I think it was slightly more readable when the
>> ternary was all on one line.
> 
> When you have that many arguments I think it's clearer to put one per
> line, viz.
> 
> 	*alloc_area = mmap(NULL,
> 			   nr_pages * page_size,
> 			   PROT_READ | PROT_WRITE,
> 			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> 			   	MAP_HUGETLB |
> 			   	(*alloc_area == area_src ? 0 : MAP_NORESERVE),
> 			   huge_fd,
> 			   *alloc_area == area_src ? 0 : nr_pages * page_size);
> 
> 
> But whatever...
I agree, and also agree with Axel's comment about keeping the ternary all on
one line.  However, there are examples of breaking both these conventions throughout the file.

My intention here was just to clean up the mess I created with the previous
patch.  As such, I would prefer to leave this patch as is.  If someone really
wants this modified, I will.  However, IMO if we make this one call easier
to read, we should use the same convention throughout the file.  I can do that
as well, but would prefer to first try to enable using mremap with hugetlb
within the test.
-- 
Mike Kravetz
