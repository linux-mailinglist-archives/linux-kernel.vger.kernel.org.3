Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0634649A5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3410717AbiAYAaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:30:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53080 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2363726AbiAXXpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:45:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ONMVOT005953;
        Mon, 24 Jan 2022 23:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L4C5qhfaMMTASqujO/CQtNHiV1Se+XECAYWfkUybK0M=;
 b=WJn79ug53ejhAnqlbJdefNf+ixHG21q4pOIfhS77eJCgOammgdVCbD8aCLMWfkLzuybk
 CLTNNlv/G9bNmoiKQIUnYl8F3tMkaDjI/VF31nSbnZ74PfnTmyokSHvK8trDvqCKpi/a
 k250/zkMarj5Qf7EOXJuADW3RbG6n+UPFmOCdL+p+0P8/FJzwym/KIlraRsWpWvn98Om
 BiPlb8o8VbjfT3EJezGQ5qAXQ96CQkzZygcTx0qkCdzCINBGkJp8dj7o9hziEVUkB9Ai
 1Y0rk/X+KlAkS5NLwYs5T1pQA/S10KHxm+2inKMnhNAL72IQ9vUZnMDjaV9o1M+2G6Jd +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaa9fav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 23:45:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ONiu9a180677;
        Mon, 24 Jan 2022 23:44:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3dr71wjwve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 23:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEo9Q1BwUD9lSO4LqeNACmFKkcKaJu+v2IzxooW9rmAf9HcKLGrrmEXJduBNSd61NFjYWk7lKUYcnS9oi7ZTUEf6DR23CNbGCmjmS3Z/XUw1EZcqEQyIa2ttDEz9xQAPHoQGam7hf+IUyTAz03P13L5NQbSnAV8mQLGWVtNOA5yLaU+CTb/ecjWUODN4CINsR9yu4PYzH7FbwLrWFyGGj+lsV9LrthO6j/I9EeHpGA7WO4uy3BT/kIuPfiKu933lveZYgjTb+NYaMEsjFoqI2MoCWr/mT6JEtit3nbmmiCqP0T3T2+YCk4jAfnanMm5bB69zIX+AOYrMVwLkYSJIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4C5qhfaMMTASqujO/CQtNHiV1Se+XECAYWfkUybK0M=;
 b=iSLGk8jIYNRpm0h3YVjO5ucPU9vP1ae/2P9G0uA/1gLJmaHk1i+R6cGIyhA0VurcELHeC6kxm4pzQvpbYqw5XoB96TvJIqjpRkrBZIdS2Z1h+09Wufbo0ZJjXHvuEqmPAVOBbIM5ayHwi8lVmVsIObO3otI1qCVMu+8fCwC9zSrnc+1F4JqT41i/uv+0M+VelNd9kwW3e14jBsqyxdJMozE8/lKp+Ok3pqi5SyH6kv8niNP6FE3cA/IORCFYWqAN5Xd6L4JkryqT3nkSt7iFaKE6XaEKxZyeQKEDEfLNEs1uNKlHJOURBRwYxl0Uv/Q7iqKtisvp56Y7nKytFywSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4C5qhfaMMTASqujO/CQtNHiV1Se+XECAYWfkUybK0M=;
 b=rJs1aIwAI4wW+DMBVeGtGkYhg4UxcUYZv90Wmd+yAUEolfemq7+1s4SkmJzMDddqoCUy8RspP+GFtvhRZBw0N/3wwOhGt5h0smdA7Xhh18yPp+kZeqxX5KnOSJoGXCQa/uaha1XsEGYpeLq7YR/KkLEw0Z+jPN051ItAw7Ex0IU=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SJ0PR10MB5472.namprd10.prod.outlook.com (2603:10b6:a03:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 23:44:56 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 23:44:56 +0000
Message-ID: <a19f492d-6027-3e9b-9816-63b2f24c759a@oracle.com>
Date:   Mon, 24 Jan 2022 16:44:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <YevrGs3WE7ywB+lH@kernel.org>
 <4d333527-391f-fe6b-eb2d-123d67242d2c@oracle.com>
 <CALCETrVNrcsLvFwTER8LmgZZdy0Mye7EJXyuOaS5yVQvB5UNpA@mail.gmail.com>
 <e26d2bfd-adbf-16ab-76d4-949f0ebb86cf@oracle.com>
 <CALCETrXjxoEmhyPdtkankPPaKp0r=oYqhnzL1A7rnQEj6xWSig@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CALCETrXjxoEmhyPdtkankPPaKp0r=oYqhnzL1A7rnQEj6xWSig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:910:5e::31) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc42036-d989-4977-c299-08d9df9386c0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5472:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5472C8B73A4B9BFF9F16F79A865E9@SJ0PR10MB5472.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDqlS2qaHxVMdLmPq6M+rkM7xMOFn8Jg+ZLM3H+QaKXt1Oz1HQLoZ8b4fcIDpl/ZlFAGlKZz3DjWrKLSYD36Nrsb9KebaXD3No0bzIUNxC9w3VfwVclJTkcBtLvKSAlOytQdAZSx8VDRDtmWgB48oswFyaoHc0cfbL4/qm8OHFgw2L1+5Odc8FdEw6SljR4z2YTC/TjdixWuCiWhH9uQa8Y4AO0jRIzkTEG+TcEwJPj25hKqzeYhIRIiISdc6fUBWJMCILlEuNYesALP+I0DxHpeweuHop+BTb2aTzlnIWpwGxmxAzxtnKq48YhWC5XyoCzNuzwxD88qB0JRiLSTmW88/rRCQxP4ExxAbnjwDnpFZDfNhwHQ9iJvYDmKMFcc2pKHSoUYFCFzIxOrjSnV5sQmLuaoMutfyJk+vyA6NAcgQfqY07bs5oHfC9K403uFXfcWN760iNunABa/doAojlkmW4TUjtmxVk3i48xc5sluAoxqYls15lwj2UEkgh7KZn5TbVGJMiDSHWa+CcyxhGWrYmYB1+HyQ559QYBI3NZhXJs57k3MlVuQYpGpZ8M/mzneEtkk211tTMAYz9guvp6rJKKBHkdBQtR8I0zcQEa3af06lzZxLR0Mpb4MctYJkX+EyU/FISHI0koZjkpgCIJf+9TXLVxnpuCBNE4+caLuL3ANvaHY7SLHZHtTRt9iDVlv66Ym0RdlwZzDL4rBCShx65R0Mc8U8cjjm2zjJtywa2NECVX6sqLLV5xVcltd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(316002)(186003)(8936002)(6666004)(2906002)(6916009)(6506007)(53546011)(508600001)(66946007)(4326008)(38100700002)(66476007)(31696002)(44832011)(36756003)(86362001)(6486002)(6512007)(83380400001)(31686004)(66556008)(5660300002)(7416002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJXN3BXTXczZEluOWJrTElzcTB1TDd3d2hyMUpxVFJsWE4ycWZoMXg1N29H?=
 =?utf-8?B?UGxIK2M5T3BPZXVucDhXMXJyK2t0T0RISGdNYmtXZWNhL3pmdkxyZmxjY3Nh?=
 =?utf-8?B?NHZhL05HSUh5R01saGViWTQ5bGJuY2xFL25BUFRZWTRtcW9JdCtqbENQMW1l?=
 =?utf-8?B?QXNTK045SjBkaTE3YkxQZThCU3Vya3M0a3RmejZsVTRlNmwwN1ErMEpxdFRt?=
 =?utf-8?B?cVg5OTY2UTVqOFpMc2wwMnNNcG5MaGNyajF1RVk0dUlwNDdzc3R6OVd4QjhF?=
 =?utf-8?B?S2xVMmY1MXBjcmRLMGtOV0RLRE45RFFBM2RFR21mOG5Eb1FNRDNvb0NvbTdh?=
 =?utf-8?B?TGpRMXZRODZJQU1UVkVrLzlLcDRaTStTTE9vQTV1aDk2c0xpTlhLYzBFZGJU?=
 =?utf-8?B?UVNsb3RhQ3NOVXAyZERKTkgydVZ2eHk0TDZZZSs2ZDJ2MXBpVStzcFRpUnk0?=
 =?utf-8?B?eFhnK2dCMEtCUkFOemNFKzF2dkI1WTBtSnZRRVhoZlFEckxGemM5SXpEcUpQ?=
 =?utf-8?B?T0RDdzZ3bW5qdmRnQWdoU3BidlFRQzVHc0o3dmNtWUprSDdUVjhIaFZCdHA0?=
 =?utf-8?B?bnFpVEpRYXpUUTFvdFFKbjhPcUd2djJKVExabzBpczhTQ2U3c0djYStSTTA4?=
 =?utf-8?B?Q2FzbGRyYk5nbS9ZblZ2aE9CSkdzMG5vWFY2b1R1MStObEN6VTRFVDBNMEl1?=
 =?utf-8?B?Kzg4WTNOZmR4SFg5RXk0VHhaZUVERDJkMzVqTmh1K2ZicnFXdWdtcVpoM3VY?=
 =?utf-8?B?K3FuMHVuWDFYb2thSXo4UnpXUEZMR1dPeENZTnZPcmVUNnFSb0VQQW9ScEFR?=
 =?utf-8?B?U0MzRXF3MmMwbzhWblZ1WUVJT0svVDhTT3pHSk5tdkdoZjhiSlViZXNoY08x?=
 =?utf-8?B?QWJQUEplNnhMNCtWcHJGaVUzZGs2MnFmSDBaMXVrNEIrZllvNE1LeFE4bi84?=
 =?utf-8?B?WVp5NWF1bkJiWEhUU1JBU0QvRCtPbzdsOWR1eUlvYnhUTC8vSmNSUWVSbkh1?=
 =?utf-8?B?VExmSmxPQUlVMkRWWE5sYnBpV1k0WmpoQk02RDlnUzFwTUVndlc5dWhZLzc3?=
 =?utf-8?B?ZXBNYm56RXJ5MUFEY2hLZTJLSG93VnpTZ3hoSmxEbi9KNWZnREx1a3liRVFz?=
 =?utf-8?B?dmF6b1U0Rll2SDZPbHhic3NYaktHRGtwU1lqQTVvYTc2ekVOY01PMktFYXl6?=
 =?utf-8?B?VWRwMlF6NHd1SzBJS3dQSFZSVmNGbFVhU0FXREFGb1NJWm5GT2NzRGZtdnhz?=
 =?utf-8?B?V0JKcWlvbVVNZmNtWnhjS1RrdXFYalFQQ2hLV0VjdnROL0o3R2Z2Wm1Kd0Ns?=
 =?utf-8?B?QmlqTDhpTVRyd3Q5M0pUV3lucWZHTXRwYVZqL1loYlNaVGd0S0ZJU1JkRWRr?=
 =?utf-8?B?ZkVzcnYyZjVXQTZpdmpzSjVOVmNPSEJGSmZka0RvTVdLQWd1ZzBXaFZqRW9s?=
 =?utf-8?B?U2JqNklpRmxaK0RWejVtYnIrOFBtL2t5MHRrWGtvTVlJRUdFS1kzR1NvNGVQ?=
 =?utf-8?B?YStXRXQ2VXdJWG50dUhuS2x2blBmTHR5TGZaSTlQdnd6NUFqU2RpazBCNTRD?=
 =?utf-8?B?REUvTDBUK0d3OG5lZmxLMFNYSkcwaDI0TEFub3VEbVBWeElvUHlUMFB5Rzdr?=
 =?utf-8?B?MDVFY2RkNllJVUJwSE9SNXVVNkFZWFBuNGZKY0VZZWtyZ0xYSmdMdW5Va2xU?=
 =?utf-8?B?Tkl2THcvanA0c2dGSFE4SGxObmdDWGZWYjFKdUx3dnNJdCtNenA5bytqQlln?=
 =?utf-8?B?QXl4RWxGakZrS25HZUNpKzdoY0pUbU1ROWVRWEhIYndJWVEybTRqMy9mcjVG?=
 =?utf-8?B?bmdVdDBSWWJJZG9sTUl3UUhHUWNIRkFGNDBITlRKdlFBUFlDN1d3aSsxOFlE?=
 =?utf-8?B?ZDcxd2lFSHczK3lXMFBZZ2JFdytMeDZKT1J5c3ZicjdLTFVkekt1bG1rdU5h?=
 =?utf-8?B?aXJ6UGRuU09jaFB4OXRaV3dFSmt5elQzY2Y3d2FVK3N6N01nUEVRMkdxdjRZ?=
 =?utf-8?B?UmF5L2NzZGFBNDdMaExxWW9aK1E3RndUT1ZEUFpOeDdkV3lXNENnR3FaRmpK?=
 =?utf-8?B?MVNBWUM0M0pSL21OTmZ3WWdsamFKQWNNUE1xTkllMXl3RDJ3MWxUNkl1TmY2?=
 =?utf-8?B?ZWJPMmlpMnVrc05sY3JSVmpGcnp6K0dZSm1obWk3SjVVU2d2d3diTW16WmNE?=
 =?utf-8?B?a0FTMHVVM2M3aXlIRVRiMkVJT3AvQitVUkh0UWlPWStteUEzakJMWVU3YjQ5?=
 =?utf-8?B?cElQeU5lQ1JEMXFCby9sM3p6NnVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc42036-d989-4977-c299-08d9df9386c0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 23:44:56.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMu0b1q2tIy0pC12XBZg9trsqP+LnW4VloYoJCZdCW7G8E+WUPUkg0gwUxTMTEhM/nvvPmv4zc135XazQWj74Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240152
X-Proofpoint-GUID: aPxCy0L35Uz5OjiH3r1PbdJVymiz7DDN
X-Proofpoint-ORIG-GUID: aPxCy0L35Uz5OjiH3r1PbdJVymiz7DDN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 16:16, Andy Lutomirski wrote:
> On Mon, Jan 24, 2022 at 2:34 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> On 1/24/22 12:45, Andy Lutomirski wrote:
>>> On Mon, Jan 24, 2022 at 10:54 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>
>>>> On 1/22/22 04:31, Mike Rapoport wrote:
>>>>> (added linux-api)
>>>>>
>>>>> On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
>>>>>> Page tables in kernel consume some of the memory and as long as
>>>>>> number of mappings being maintained is small enough, this space
>>>>>> consumed by page tables is not objectionable. When very few memory
>>>>>> pages are shared between processes, the number of page table entries
>>>>>> (PTEs) to maintain is mostly constrained by the number of pages of
>>>>>> memory on the system. As the number of shared pages and the number
>>>>>> of times pages are shared goes up, amount of memory consumed by page
>>>>>> tables starts to become significant.
>>>>>>
>>>>>> Some of the field deployments commonly see memory pages shared
>>>>>> across 1000s of processes. On x86_64, each page requires a PTE that
>>>>>> is only 8 bytes long which is very small compared to the 4K page
>>>>>> size. When 2000 processes map the same page in their address space,
>>>>>> each one of them requires 8 bytes for its PTE and together that adds
>>>>>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>>>>>> database server with 300GB SGA, a system carsh was seen with
>>>>>> out-of-memory condition when 1500+ clients tried to share this SGA
>>>>>> even though the system had 512GB of memory. On this server, in the
>>>>>> worst case scenario of all 1500 processes mapping every page from
>>>>>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>>>>>> could be shared, amount of memory saved is very significant.
>>>>>>
>>>>>> This is a proposal to implement a mechanism in kernel to allow
>>>>>> userspace processes to opt into sharing PTEs. The proposal is to add
>>>>>> a new system call - mshare(), which can be used by a process to
>>>>>> create a region (we will call it mshare'd region) which can be used
>>>>>> by other processes to map same pages using shared PTEs. Other
>>>>>> process(es), assuming they have the right permissions, can then make
>>>>>> the mashare() system call to map the shared pages into their address
>>>>>> space using the shared PTEs.  When a process is done using this
>>>>>> mshare'd region, it makes a mshare_unlink() system call to end its
>>>>>> access. When the last process accessing mshare'd region calls
>>>>>> mshare_unlink(), the mshare'd region is torn down and memory used by
>>>>>> it is freed.
>>>>>>
>>>>>>
>>>>>> API Proposal
>>>>>> ============
>>>>>>
>>>>>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>>>>>
>>>>>> --
>>>>>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>>>>>
>>>>>> mshare() creates and opens a new, or opens an existing mshare'd
>>>>>> region that will be shared at PTE level. "name" refers to shared object
>>>>>> name that exists under /sys/fs/mshare. "addr" is the starting address
>>>>>> of this shared memory area and length is the size of this area.
>>>>>> oflags can be one of:
>>>>>>
>>>>>> - O_RDONLY opens shared memory area for read only access by everyone
>>>>>> - O_RDWR opens shared memory area for read and write access
>>>>>> - O_CREAT creates the named shared memory area if it does not exist
>>>>>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>>>>>      exists with that name, return an error.
>>>>>>
>>>>>> mode represents the creation mode for the shared object under
>>>>>> /sys/fs/mshare.
>>>>>>
>>>>>> mshare() returns an error code if it fails, otherwise it returns 0.
>>>>>
>>>>> Did you consider returning a file descriptor from mshare() system call?
>>>>> Then there would be no need in mshare_unlink() as close(fd) would work.
>>>>
>>>> That is an interesting idea. It could work and eliminates the need for a new system call. It could be confusing though
>>>> for application writers. A close() call with a side-effect of deleting shared mapping would be odd. One of the use cases
>>>> for having files for mshare'd regions is to allow for orphaned mshare'd regions to be cleaned up by calling
>>>> mshare_unlink() with region name. This can require calling mshare_unlink() multiple times in current implementation to
>>>> bring the refcount for mshare'd region to 0 when mshare_unlink() finally cleans up the region. This would be problematic
>>>> with a close() semantics though unless there was another way to force refcount to 0. Right?
>>>>
>>>
>>> I'm not sure I understand the problem.  If you're sharing a portion of
>>> an mm and the mm goes away, then all that should be left are some
>>> struct files that are no longer useful.  They'll go away when their
>>> refcount goes to zero.
>>>
>>> --Andy
>>>
>>
>> The mm that holds shared PTEs is a separate mm not tied to a task. I started out by sharing portion of the donor process
>> initially but that necessitated keeping the donor process alive. If the donor process dies, its mm and the mshare'd
>> portion go away.
>>
>> One of the requirements I have is the process that creates mshare'd region can terminate, possibly involuntarily, but
>> the mshare'd region persists and rest of the consumer processes continue without hiccup. So I create a separate mm to
>> hold shared PTEs and that mm is cleaned up when all references to mshare'd region go away. Each call to mshare()
>> increments the refcount and each call to mshare_unlink() decrements the refcount.
> 
> In general, objects which are kept alive by name tend to be quite
> awkward. Things like network namespaces essentially have to work that
> way and end up with awkward APIs.  Things like shared memory don't
> actually have to be kept alive by name, and the cases that do keep
> them alive by name (tmpfs, shmget) can end up being so awkward that
> people invent nameless variants like memfd.
> 
> So I would strongly suggest you see how the design works out with no
> names and no external keep-alive mechanism.  Either have the continued
> existence of *any* fd keep the whole thing alive or make it be a pair
> of struct files, one that controls the region (and can map things into
> it, etc) and one that can map it.  SCM_RIGHTS is pretty good for
> passing objects like this around.
> 
> --Andy
> 

These are certainly good ideas to simplify this feature. My very first implementation of mshare did not have msharefs, 
was based on fd where fd could be passed to any other process using SCM_RIGHTS and required the process creating mshare 
region to stay alive for the region to exist. That certainly made life simpler in terms of implementation. Feedback from 
my customers of this feature (DB developers and people deploying DB systems) was this imposes a hard dependency on a 
server process that creates the mshare'd region and passes fd to other processes needing access to this region. This 
dependency creates a weak link in system reliability that is too risky. If the server process dies for any reason, the 
entire system becomes unavailable. They requested a more robust implementation that they can depend upon. I then went 
through the process of implementing this using shmfs since POSIX shm has those attributes. That turned out to be more 
kludgy than a clean implementation using a separate in-memory msharefs. That brought me to the RFC implementation I sent 
out.

I do agree with you that name based persistent object makes the implementation more complex (maintaining a separate mm 
not tied to a process requires quite a bit of work to keep things consistent and clean mm up properly as users of this 
shared mm terminate) but I see the reliability point of view. Does that logic resonate with you?

Thanks,
Khalid
