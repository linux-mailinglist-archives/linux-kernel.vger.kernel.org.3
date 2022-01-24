Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47CC49A0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848696AbiAXXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:23:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33032 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1589161AbiAXWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:35:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OL9DwZ019198;
        Mon, 24 Jan 2022 22:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c2eDhJP5IN4mumC4Xrl+J+XeEZLwUrT6qeHzxyK9QEs=;
 b=nC7UDBe5MHKY76pp6xn6Q5T3LVFz+86qxu7QatUIYa0W6t5w2l/Bfio5DruGgGz+3aLI
 5pEKMn1VNgPQP92Ft7UBgfeDmtBrCrG2n04RSI4mvFF0XfC0NPIetKazW3htJi3kwcFQ
 gQ6v4+HnfaEI5Fh1EFoLlTry3jCpaJjz3Y5aY3owBgnPIfBLzB3cz6IOtSX1e8ZBhxmH
 guCxunAUAo2Gp5cPA1RRKuJif2RI8nAx0lsmXhlh72/fWITj2XtxgdbqAQJraLiFS0/5
 5uz9h3w9q+bQK5vvGbjlPlTEJm+qBlttzgwkoUZCmUamzDsaJyT4tbpkPB9z/miH+sBZ 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7as4yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 22:34:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OMUie4068687;
        Mon, 24 Jan 2022 22:34:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by aserp3020.oracle.com with ESMTP id 3dr9r4vsuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 22:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acRGxfgeMFXvcdlbT5hgpAh+V2jtsXshLkNqGZOaUk79JLj/8crmINdOtKYHrY1t9O3Yqu1S47/5ujKLh383erA4xOUyyD/MIau8yxGMfWHxEGVy8dppe1THMeYjxUm/WX6wDOEl0kWqZsGE+uiRB7SOE65FEOD5IJnrX9cCjeB/IH/UEkUDEB5iiqKf03p5d+e82KVDzwl3KRdB1aLAyDRJe5fMFvl3d22mLmKV6AFAW4pzXQAu/7EjmNRsfVCNTLghJCvEv+YZW9WOqQ1FVu6cy1zZgD2dG8ECqvaF4QiNg8phoDt8DUBucyh3Wg4mAxave1fCbMPf0ppbmeTa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2eDhJP5IN4mumC4Xrl+J+XeEZLwUrT6qeHzxyK9QEs=;
 b=h1Vxyjy2RMHnusVF9pi7BTl+5WuKjzbf4qybE4lA4BqDa987j2JbyUd/hUaySPV+5+9wMIETdKH2FrJDjpqI8dYN7wa6BzrpqBeoqOwRRj4e39BDHCtGb/Iq9i68F+zYuT7V4koP0Iktdt+nsEa0c9QfLJ7mDmV5VpmVxw/kb34jtSXAEo9oyA5aALJx9w17pp+mIED9g4vQYyRZGNqrh/UMQponnJdOy2PSJeDh3sTLDeic1IoAvU4IxAO77F8ne6eUI2PsoHSlei6dz1iALEXsoLgzlH5Na8geCR0U7Qey8qdqRTIAa+C9c6d837olm9h7H9dSnVcqJGH16tLlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2eDhJP5IN4mumC4Xrl+J+XeEZLwUrT6qeHzxyK9QEs=;
 b=cQbtdS9lZs6BmCwxYhcRB1zludAbiIaOk80QdYjg/A3K3fNZph7e72GHRLQibX6w6x+GEl2ul4UUzlybiuHMzrMTwW+3hF6hjcWU41D2n27tr6s3Ieu83unfu4gLmWDhBsKxWOIQTNXra67eND/Key7kNWwZqfoWU3gQn4AOv1Q=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 22:34:47 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 22:34:47 +0000
Message-ID: <e26d2bfd-adbf-16ab-76d4-949f0ebb86cf@oracle.com>
Date:   Mon, 24 Jan 2022 15:30:23 -0700
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
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CALCETrVNrcsLvFwTER8LmgZZdy0Mye7EJXyuOaS5yVQvB5UNpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:20::23) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dd7d56-a59e-4f9e-224d-08d9df89b9f6
X-MS-TrafficTypeDiagnostic: BY5PR10MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4145C53C1CBFC1DF4D176D41865E9@BY5PR10MB4145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QRclPJ79Jnd4P6bw+XiUISzqEysZvP4dJya0aSLZviXwPu/zOXmrjWPNw/uj3FC7UK3ML0RwMkvAay+EwOb+oJagUOJFYop1yTt3zvfvZGF2b9gh5IouP0FxZS1s4IkzP8zYBP6Z+wXkSXmrovjGaNOT8U63NSY0poE5x6qNwG1nVv7wpZzZs9iDPCn02wXMmXWUIhVaiqyYpinBUeqj2cmIbHvwvAd0yV6erK9KFd7xtPlF5KlN7kmB9Gc1rqLY2ocJa99B1z+e31PY6knawE4zAYBnLoqMN/oY1VMLbCDzutltoSKgqoYbJEvU3E6UajyGd79Yrt1rKxO2HBWwMW2vmepDq7bSnJeGkn0RYTDd31VEF3nk2EDYHh324I9N2zyRtg3LgSMrXD66cLHZWEMo7kBRMFBEbYCAwsLNxoCbUkcAjyp1kCk2ieunX6YnMgghK3IS2465VV+l/7hPTTaGCY7RV/j9itRr+6rfeAkvOvk4NNcbNC48HnfX64I+DO38xA5+/hoUYLJIsus6/Z2BByrPVzt9OJdQ7vEH2EjqR+s1sVS/QdqOG63S/YY/WTwUj3qHlb85/346fKtM77nBSf3JW7LDuu4P8Q8GVqhH4prA9q0NH1eyx9PMfxUSo6LWaHvwGHadMafJlrYMsQFgsCTRcxyoMACzmFgIE0FJlM1HmTvPhQ/b9NTs7Fp1t4jXAd/3HTpqzPwY8/moLaQB6+yA6Fo+tAL/AAuat0kbQeKxFd/0+pKwDjZWAra
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8676002)(4326008)(38100700002)(508600001)(66946007)(31686004)(6506007)(6666004)(186003)(316002)(5660300002)(83380400001)(26005)(36756003)(8936002)(53546011)(6916009)(2906002)(66476007)(6512007)(6486002)(31696002)(2616005)(86362001)(66556008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9pMkxIUTRqNDFmY3o0andBMlhNU1NaT3ozUGdQSXhmdFByTW1sSXByL0sx?=
 =?utf-8?B?U2RKNFJkd3ZjQVhSQ1R5QlFwNnlwbVMzRC9TN2c0cHZ4emdPNU5LeSsybzBS?=
 =?utf-8?B?WWNJcjMwQmFSUjd1RklMVG5kZHpHQ3BqYjNYTngrVFNpbUZtaVIxN2lJc1Jm?=
 =?utf-8?B?NlVocGJTMFhwUnRQSXFtVHJyRG4vUUtOUVdsLy85RitmeGlwY1I2WEJaUE55?=
 =?utf-8?B?cTQ4UmwwcXEwSFBMN1lCWjlOWUdkSGJidkxrcVRkMU1pVTI4elVUREpYNDZQ?=
 =?utf-8?B?ODQrOXZEVU56clVGL2xZbE45R0paTW01ekNNeXZ5ZFQyWDBaUGlpRHcycm44?=
 =?utf-8?B?R0gxMVZraE5WTE02cjlVOVI1Z1R3cjE5eU00aXFTYzFFN0Z3K1JtSDhvOXRw?=
 =?utf-8?B?U2FRUXdoTTB6Vlg5UWN5c3k1Z3F1ZHUvMHRBWHBwTVBreHIrbmlRbmtyZG15?=
 =?utf-8?B?OGFERi9pV3J0VVg5OEhOWDdDZmt6OEkrUlJzNnQxRjNXMURzd1FJREJkQkpQ?=
 =?utf-8?B?RmJyZW9DVk0zTzlMQ3BISlBOcW82OEh6RlRRdTFqaDNwREl6b25jaFE5UGZk?=
 =?utf-8?B?T0ZNWjJiYmRQME83QXlnNyszcGkrYlhta25GbHNnenlvbWZqLzUrRDZTMit1?=
 =?utf-8?B?azFTbVhDUjg5VE14eldNOW9mRnlxU1RjN2xteForTHRkL3Jqd095bzZqbFVR?=
 =?utf-8?B?YXQzQnB5bGxYTVRPRGM4VXZxOUZzcEloSzRmRGVhSVRQVmNvRU1ZVFZzZEpD?=
 =?utf-8?B?MWFTazVMVldWZGNtcjdWUkFHVWdWSWprK2R0QzQ0TDMwa09lbkpVR3FPSG1M?=
 =?utf-8?B?djloSFQ2R3l4SVpSOFphM05zcFg4WGpoMHZQM3JWVFl2MG5HUC9TR0dKQWpD?=
 =?utf-8?B?dVZkVUZDZUw1Z1hOTFNaNDEyRnZ5YlA5YjliV21RYmN4SGlXVG9sSy94NjJW?=
 =?utf-8?B?WVltM2VxMm5zWTJOblBrS2tmVmk2M2VCQ2hIb3I5SFFzREpIdTdJZUVJT1Bh?=
 =?utf-8?B?Q1JQS1ZCeTVQQW1VNGx3Z1hCUzFTQlRTL0tJd1RXQ1lVWWxUbGVJbTczaFVz?=
 =?utf-8?B?TnY0MlBqVDcrWURsUDN4WS9lMVl3cnA1STdZaWZTaVhFTm5wbnBnU3ZwL0Rx?=
 =?utf-8?B?bW1uOUh6MzdhTkFoQXNoVGsrOGdlbURhTk9zbjg3VXQxcVBEd2RRWUcyZEM4?=
 =?utf-8?B?Z1paYkxJTFZnVWZRODBzbm9ORUE2dWJ1cVN4dXVrazk0U0UyK0RneGZxNGY2?=
 =?utf-8?B?T3RyeVdwd1I4Ykc3Q2VrTy9sSGJsc2ZBNjFodTZXcW1HMmtIQXlPU0NhSnZ5?=
 =?utf-8?B?VWdNVWczVVZqeG5WbEhrVmFpSHQwdi9OTTgvZ2FZQlBGWUZoNmtSZWs2K2t4?=
 =?utf-8?B?d1lJSVZrcUlqR0duQmwza0JJemR3RS9DcVMyM3kyeDFFdHpiS3NBU1JxNUJ1?=
 =?utf-8?B?dEZWUjNaTHZHN256bW1LWFExOWxMSWpobmNLUG8rM2RIb2c4Wkl3MGhsU2Rw?=
 =?utf-8?B?TnVwVzBpSnV5NVUyaDRLdmR0VTdOZnBzV2k4Q2R2WW10aHBZNGljKzNKUVVY?=
 =?utf-8?B?N1MyaGxESENHbEw2eEduNnoxNnRBai9rc0xkMUY4cGVpaEROTGQxYTdVMW5D?=
 =?utf-8?B?dGM0ZzZVZG1jcG15TkNDRlV0akRrT0ZLWGdpUU5odFU0WUkzSnRheFdQS25Q?=
 =?utf-8?B?ZHNWR3E1YjkvdlZWTVlEQTZpMUY5K3JqQ2I0STdpR1pLT1JXMm5EenQyWUNa?=
 =?utf-8?B?U1FZQllxcDhOYlRocWhhT3J5RFluQTc2VUNIK1NOZnQ2NUp1RUFwYzFYb0Ez?=
 =?utf-8?B?cmFHWElFMHE5VHl2RnlNR0ZWY1ZidFJNem0rMjBVdmlDVmlpcmNWUUkyZ1Y1?=
 =?utf-8?B?S1JFaTdnVUZ2SHc1NzVVdU5BbG5Ncmh2ZlZyWXp4K2Y1QlBYNjdRbXgzRFU1?=
 =?utf-8?B?S2xYdVFPYTdyZHVCYkhocXorQVZSOExSRCtEK25idXJTY0tkUTZNODkreTlk?=
 =?utf-8?B?b0RuMHU1NnZXcjdsd2xvNUw5ZkkvNWJJYUpBbjNBZTlpV2RyV0NjR1pHbk1I?=
 =?utf-8?B?VlVUOGFKSEt2NzNxekdHWEI0eitOU3ptdHpnWkl6MDZqaG1hYTlYaTNISHpB?=
 =?utf-8?B?OU0vSjR0bEo2VWVYbnNtZFlRR1I4em1GVElzeWJrVXdKNjB6eWZ4YjBaTi9C?=
 =?utf-8?Q?HSAk3kRPQ2uacHakae4/BTY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd7d56-a59e-4f9e-224d-08d9df89b9f6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 22:34:47.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfeHvR2YsKMk50R82i2ZAZr8tkEWQYYxG3TssRq3XTgaNDqSIKtZ0gLXL+WHSOx2lJEXX0bpxaWOirTixTJEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240145
X-Proofpoint-GUID: FNP4-dLSPsDPkma2tSP5ts96th_m3gCP
X-Proofpoint-ORIG-GUID: FNP4-dLSPsDPkma2tSP5ts96th_m3gCP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 12:45, Andy Lutomirski wrote:
> On Mon, Jan 24, 2022 at 10:54 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> On 1/22/22 04:31, Mike Rapoport wrote:
>>> (added linux-api)
>>>
>>> On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
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
>>>
>>> Did you consider returning a file descriptor from mshare() system call?
>>> Then there would be no need in mshare_unlink() as close(fd) would work.
>>
>> That is an interesting idea. It could work and eliminates the need for a new system call. It could be confusing though
>> for application writers. A close() call with a side-effect of deleting shared mapping would be odd. One of the use cases
>> for having files for mshare'd regions is to allow for orphaned mshare'd regions to be cleaned up by calling
>> mshare_unlink() with region name. This can require calling mshare_unlink() multiple times in current implementation to
>> bring the refcount for mshare'd region to 0 when mshare_unlink() finally cleans up the region. This would be problematic
>> with a close() semantics though unless there was another way to force refcount to 0. Right?
>>
> 
> I'm not sure I understand the problem.  If you're sharing a portion of
> an mm and the mm goes away, then all that should be left are some
> struct files that are no longer useful.  They'll go away when their
> refcount goes to zero.
> 
> --Andy
> 

The mm that holds shared PTEs is a separate mm not tied to a task. I started out by sharing portion of the donor process 
initially but that necessitated keeping the donor process alive. If the donor process dies, its mm and the mshare'd 
portion go away.

One of the requirements I have is the process that creates mshare'd region can terminate, possibly involuntarily, but 
the mshare'd region persists and rest of the consumer processes continue without hiccup. So I create a separate mm to 
hold shared PTEs and that mm is cleaned up when all references to mshare'd region go away. Each call to mshare() 
increments the refcount and each call to mshare_unlink() decrements the refcount.

--
Khalid
