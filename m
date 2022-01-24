Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9A49A0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384670AbiAXXRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:17:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61370 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1585978AbiAXWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:25:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OLISkE001281;
        Mon, 24 Jan 2022 22:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VsrNDlZfHSl1V4bAz4stBS3r7VCg72Mge7kqw8NiLEs=;
 b=Iao+Q8JL0fbLMbzJe8871TLGnTexN3zVAuklNdODXkprvvZ3BWEuPbaJ9YoWSIg8TDoe
 /Yx6cwZOSHLXna1dVok/zHIx7yEy1pEuqV2Nz4XmtJ9SOk243DgQlDCwea/ZqTZLZ3t5
 uHA2kTDltAJTxCxLxvwPb51G7xP1VnvRrPKli9cn9OqnYDngCViPd0hAkKzRqjpHDzlC
 Y5yUsOVOiCnGRkAe9DXKRGT8103QeV0nrDrUYQq/h0swG6W2Ach2gGxjlMOOagwTdbq6
 3Bnzzde9KzMyNJhP8WkHKfHnmG/Dc0UJmrX0uKu3WBJOVK/GfSbWYlctD30o2ydAic3T 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s1448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 22:25:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OMBDF3105272;
        Mon, 24 Jan 2022 22:25:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3030.oracle.com with ESMTP id 3dr7yenqvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 22:25:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPQm5sZ0jfq6f/fLRiliwYo6m0QjjywJR+xo2dQqu/z2+64jsg+4aE46WkLZfgHTOq0Rm+ganW1QiuAaO4O5f2b+SP6uc+msN4xxH4eJQUZ/mhhvaFR7YB4meAWthzJYA5ts0XpdRbIjaeT92jOgsqc+GGNEWon1Vq0BybS6BwlxSrYR0apG9jEolRmIyQRFg8UxhyPVEjEnMSZvJfaC48aZwZCpDxfjtXeS8gmC0d6NYwD/iGm0sZxyug8yd/t+gGnNBBcl/sI5G+GNFqWe5iEhltJKPV9DucFYJkzKMfo4H+DkTA9azokAmDKJO2tCUIV/sLsvkZTUZkQTIgu+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsrNDlZfHSl1V4bAz4stBS3r7VCg72Mge7kqw8NiLEs=;
 b=YALjr2fRM8GyacM9CAVTjU2OkW3/qhJeicNVqW2X4it6YN1FOyBiRdyN7fj/TYpTGsdmMP6l2GGBOsV1SK7h/+umUUrdUoP9SLcr6cYjdoEglIpWnpDySXGQg22T7qZ+URKGGZkXWoG06yc0ccpaiOq8NPvsrP20z3LCaqww7QG5Dr5F3v7jZTwQvqD23jhcTbjhuLPb/9AtGZpTm9Ns0CjdV92L3w/jpw4OyLmiP7w+xkIUr+py/qVoVsSnVry9sgrypM3E6APiUSpVnUXQmdxIKmkA8bNOPJ1UpeKLe1bnziDGyzgO1cZgxPKpL0m6p+51GWyn3oNzgik02g8ibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsrNDlZfHSl1V4bAz4stBS3r7VCg72Mge7kqw8NiLEs=;
 b=ivX2mrP/38yXD14udE35M1AslH4fkRo0mpkjaz5h0VCU17eopRh4UyS9pCZnkmDk0Um+vMHF+5DtV+zvrdIST/umYB0Oq8YaXrsWHEL2Yt7EXB4xuSyg6gGHriYl12mxQsZIgdaz5Tn2gEa9UU58y5Niti5gF98LF7T5huGEthI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BL0PR10MB2819.namprd10.prod.outlook.com (2603:10b6:208:74::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 22:25:06 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 22:25:06 +0000
Message-ID: <306da7e0-8129-27fc-f025-4e51240cd0ed@oracle.com>
Date:   Mon, 24 Jan 2022 15:20:42 -0700
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
 <ef356f12-5eef-a92e-a816-ab853f2d369a@oracle.com>
 <CANe_+Ui4x7xz_QtG1iXr6J3dbKyja3-T=2tTTg+yqsacrTUYNw@mail.gmail.com>
 <f0939948-51c4-eacb-0b20-dd31e0a8b92c@oracle.com>
 <CANe_+Uiw1mSnFFBW3n5qBJ+V9EDaqY1PAEXFTXF9mkwM73x0-Q@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CANe_+Uiw1mSnFFBW3n5qBJ+V9EDaqY1PAEXFTXF9mkwM73x0-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00556f42-6961-4ecd-73df-08d9df885f72
X-MS-TrafficTypeDiagnostic: BL0PR10MB2819:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB281969C43C4CD102625201DE865E9@BL0PR10MB2819.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wToUNykxbCPvgyhmWJFBjBa5FVfRpPVKv/MarqyBZM0juROG8CqoFUNrHfPopb2m62D71zsdRbQEn21Hs1oFzP3/PS7RU7YDZemHrVwDo6Q2GGeTUXhry2k/4w5T6zQhCzcrD9RX2xwvGsDdosfvNKTtSYByMbGFpjA3p2s9cVJpUbaVBAxDlUB5NfBX4uJTMKOmHp8fCz2tgO/46MQ/C0DuzpDlTYM+Xv5X9TkpbM7F5rawLzZJymcbno5CApVVUe/+fQK1/uBCqG1MWQ/bbRC0xZzKbdgqi008zULdPAyWTJGOAcm0RidzCl6riuPPShvFJ5yKnLbMsi8aU8lVEJumw97dzDn+eVhzTgbSx1VAzErCjwvGziT4FQvVnp0xmfkAMEUDWxdFs3/0xSgoVtRekQWjmYG2jdhzbwq2loyo1HDH1cXLmiMaAGuVOctsbVmExTWuWL2TTfmWWQbXpXmXt7Jvp4x/GMrsFbugFU6/rsX6+rl2tZuGhBhhEz9levh3iEFCEFFxM6+SPPRWM+3KETPL95HwQD2kdj/Yz9v7YMDWuPahjIHUC2u9/JkdXmlh/U/cpCWZFNRedN2tUjlS/sEsE8MOHaDpoug9bDNz0eXXljGYhQ8CS4PKPbNtqlLyC/kZKgVoe+R647mhy2m5cS+K9G7iJfi93Jg5Lv9BpJ+xm9N0JDKzUDjuHNVSaUgtKtuJZ0F0cdzM4nrptD6X8XykKXnH6hqhpUr7u8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(2616005)(4326008)(6512007)(5660300002)(30864003)(54906003)(508600001)(2906002)(6666004)(66946007)(38100700002)(26005)(66556008)(8676002)(6486002)(8936002)(83380400001)(6916009)(31686004)(53546011)(36756003)(186003)(6506007)(31696002)(86362001)(44832011)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JjdnpZeDQvOWE5bVBtRVZYOU5tdTZvb0pCSjNtMUhWQ3dQWW80QXRmT1Jj?=
 =?utf-8?B?ZjJpbEE1MERGT1BXYnRSQjhPMngyNi96OVhqQmNHUWJURG9wdkYxTXl5ZVk3?=
 =?utf-8?B?WmYyOGtsYi8yZXhRZmRERlN4ODBnaGZTdFBnZU45TGFJTkg0N2c3MG1NYjYx?=
 =?utf-8?B?R1RNMVg4Znp4czZJbjdMMXMxOGdnVnN1d1VPVnhibzVzVVM5SFd5bEdFT05P?=
 =?utf-8?B?UlI1b2lDYU5KblZ4RklGMzl4MGtnRXJsMElhTSsxczVKYkpKdXYwazZGZ0RE?=
 =?utf-8?B?TW9mNzVpOE1Wbjd4TjlaL21JWnd6SjdtMk1LbWJkSjRwdlVKRlFLNmVjekNa?=
 =?utf-8?B?OE8rMGQwdTkzbUZqTkdNNUZldk1Ja01GZkNKMVY1cFFqNGw0L0ZxVTh2eC9u?=
 =?utf-8?B?b0UvcTRCZ2lIemtwMnIvb2RnWU8ybGhSc3BEeDZBaDBHQjkzaldQYjVMZ1pN?=
 =?utf-8?B?VVJDT3cydk84YjJrSnYrZjZLMEFNOEJ2UVBIZjNjVVNYcmRzQ2ZROXFvQ3d6?=
 =?utf-8?B?RGxRdTdxUjlSRFBiU0NEeFBPL085VUs1TDNGQTNxdlZhY0ZKUVJJdStVRCt0?=
 =?utf-8?B?ZVNEOEVBMnk2bjllNzhRMnJvTVpsTmVXUTQzVUV4L1MvVVZVeHp2bG1pd2hI?=
 =?utf-8?B?RDMzTUY4QlJxaGxmcDB6ZGE2bmJGMzN6QmQ3ZTBObGRWbXlYM2ZYVGNzaXZH?=
 =?utf-8?B?WE5MNnQwREF4di9BMEpocVlQT2s1OUVJZUlIaUVqbHVKLytJOFc3WDFvT3o4?=
 =?utf-8?B?YW9vLzl4UGR3VnEvRGhIeE1KWGNVNGEzOU8wR3VocC9yTjBoWkkrdE0xcUJ4?=
 =?utf-8?B?aitxVjhWTDhORTdnWENFbGU4eU1HUWh6OVRHN1FpcnBqNnZSdXZMenUwNGdI?=
 =?utf-8?B?Ymc0UjJ6YVZtbXIwVFE0aDdtRTFXOER6UmdDb3IyWVdsMS9Mak40N1hmdUZj?=
 =?utf-8?B?ZFFUQlcwYXkrMEhWYVpHQjM1bUhkOEZBWmltYnM5TVZxc21xS25tY3NLQ2hN?=
 =?utf-8?B?VC90a3dNVkYzblNLdEJzQk5YODJSbm5nQXRtMFdYdEs1OEErZjZMQlVXcEt5?=
 =?utf-8?B?SWtjNjQyNTNhemtEbjhRZmxCK3pDazJUNXpvd3IwbklqVmIxZHpwZEN6dnVo?=
 =?utf-8?B?Nk9ZZ25pR015MGJBU2liaGwrS2hHbm01RTJ5akVHOUZxNktoM2gvT296N1pj?=
 =?utf-8?B?bndkdmROK3BuaDArUHR0SFd0bWFhNnhYMTlxSWJ6ankzaitOVWFaNUlnR0o4?=
 =?utf-8?B?M01qUEpaZThCMG1sYmp1eC9KQzlNeXdHTkxsTnBxMnhLbVNpWmJhMk1ZNEMx?=
 =?utf-8?B?bnFDdGhNQi9kRnN0QWpuT3NQRUtKTzRMazdjMzZsOXdPRGpFN2FYcktMdWFK?=
 =?utf-8?B?djRKeW93ZVVtUWhUN2RGZ3F0V3JKSVUwQVF6clNLMHNwWmhJRmZ0RUd1cjdD?=
 =?utf-8?B?aXBaQllhUFFhRXhPcmxrL0VJN3hnU0hPaDBMSStaUlZHWWpZZjFxKy9qWHlQ?=
 =?utf-8?B?SzArbnNoWFJPbVZFTXVSNEFBeml0U1h6QVkyUDQwNW1UbThJMXVhQUV5SWdo?=
 =?utf-8?B?Q1ltODVuWDEwdGloVXlLSEtUQVh5RUR1cjVOM1NYaHVMY3JzRXk0TjJKSDE2?=
 =?utf-8?B?RmVMSys1QjdOd0pUckNLNTQyODh1bVpHMFpjVFNWVmZDZWN3MGFkV1lrOXRs?=
 =?utf-8?B?ZnUyRjBKWkM3MnV2ZnF5STFOTXdOc2d4eHhqVmxPbUxKQjhGbS9IZE9VSDZo?=
 =?utf-8?B?OWhnN0xiSXA3b3VaN24xU2JoWmFseFpzMnF0VUVkQ2pnSXdLWjlQTUF1VE50?=
 =?utf-8?B?K1lKR01tOFNWKzIyQ3MxSmwyWGFkNC9iNFROUG44NmNvWjhyR29yYkNHakJC?=
 =?utf-8?B?ZHNabmJGQjFNRFkwc296UVo2S0ZFK1M2L2kvNjgrVFFmOGRTSE9nRDR2MlRu?=
 =?utf-8?B?TWlHOXNOQlcyK05NMXZDNXdiTUpWcFl2QzZVbkJjNFVyOG9uS0hKZ3ZXNjhG?=
 =?utf-8?B?ZHFsa3o1N0VNWWdJYTljbjRFN0hZYTkrSHd1T2pPOWI3YlhCN2g4Wjc0WDM2?=
 =?utf-8?B?WndFN3NFQlh2OHNObVpIQWZCOTRvOThCeVB1TmZ5aDFPcTd4RnhZR1FRcGRW?=
 =?utf-8?B?dFVtSmRocTZYbTR5YlpZUVFnaXJNU1dLdFljK0VKRWNzMFdRaVJRMlBINU5k?=
 =?utf-8?Q?wMrqGia9NDo7fI9D042RQio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00556f42-6961-4ecd-73df-08d9df885f72
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 22:25:06.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHZFIXKQlNryfsVsHMTCF+ZAjauliXqNfy85Tw3I7ET9uCZVDTtqQlSy0GbLY3REEwuNVEluBCbsZ7hdXG6+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2819
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240144
X-Proofpoint-GUID: SEGQbHjY-GsKfSBJO1XYU7t4cZvFAZpE
X-Proofpoint-ORIG-GUID: SEGQbHjY-GsKfSBJO1XYU7t4cZvFAZpE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 08:15, Mark Hemment wrote:
> On Thu, 20 Jan 2022 at 19:15, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> On 1/20/22 05:49, Mark Hemment wrote:
>>> On Wed, 19 Jan 2022 at 17:02, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>
>>>> On 1/19/22 04:38, Mark Hemment wrote:
>>>>> On Tue, 18 Jan 2022 at 21:20, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>>>>
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
>>>>>>
>>>>>> PTEs are shared at pgdir level and hence it imposes following
>>>>>> requirements on the address and size given to the mshare():
>>>>>>
>>>>>> - Starting address must be aligned to pgdir size (512GB on x86_64)
>>>>>> - Size must be a multiple of pgdir size
>>>>>> - Any mappings created in this address range at any time become
>>>>>>      shared automatically
>>>>>> - Shared address range can have unmapped addresses in it. Any access
>>>>>>      to unmapped address will result in SIGBUS
>>>>>>
>>>>>> Mappings within this address range behave as if they were shared
>>>>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>>>>> page which is shared between all the sharers. The first process that
>>>>>> declares an address range mshare'd can continue to map objects in
>>>>>> the shared area. All other processes that want mshare'd access to
>>>>>> this memory area can do so by calling mshare(). After this call, the
>>>>>> address range given by mshare becomes a shared range in its address
>>>>>> space. Anonymous mappings will be shared and not COWed.
>>>>>>
>>>>>> A file under /sys/fs/mshare can be opened and read from. A read from
>>>>>> this file returns two long values - (1) starting address, and (2)
>>>>>> size of the mshare'd region.
>>>>>>
>>>>>> --
>>>>>> int mshare_unlink(char *name)
>>>>>>
>>>>>> A shared address range created by mshare() can be destroyed using
>>>>>> mshare_unlink() which removes the  shared named object. Once all
>>>>>> processes have unmapped the shared object, the shared address range
>>>>>> references are de-allocated and destroyed.
>>>>>>
>>>>>> mshare_unlink() returns 0 on success or -1 on error.
>>>>>>
>>>>>>
>>>>>> Example Code
>>>>>> ============
>>>>>>
>>>>>> Snippet of the code that a donor process would run looks like below:
>>>>>>
>>>>>> -----------------
>>>>>>            addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>>>>>                            MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>>>>>            if (addr == MAP_FAILED)
>>>>>>                    perror("ERROR: mmap failed");
>>>>>>
>>>>>>            err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>>>>>                            GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>>>>>            if (err < 0) {
>>>>>>                    perror("mshare() syscall failed");
>>>>>>                    exit(1);
>>>>>>            }
>>>>>>
>>>>>>            strncpy(addr, "Some random shared text",
>>>>>>                            sizeof("Some random shared text"));
>>>>>> -----------------
>>>>>>
>>>>>> Snippet of code that a consumer process would execute looks like:
>>>>>>
>>>>>> -----------------
>>>>>>            fd = open("testregion", O_RDONLY);
>>>>>>            if (fd < 0) {
>>>>>>                    perror("open failed");
>>>>>>                    exit(1);
>>>>>>            }
>>>>>>
>>>>>>            if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>>>>>                    printf("INFO: %ld bytes shared at addr %lx \n",
>>>>>>                                    mshare_info[1], mshare_info[0]);
>>>>>>            else
>>>>>>                    perror("read failed");
>>>>>>
>>>>>>            close(fd);
>>>>>>
>>>>>>            addr = (char *)mshare_info[0];
>>>>>>            err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
>>>>>>                            mshare_info[1], O_RDWR, 600);
>>>>>>            if (err < 0) {
>>>>>>                    perror("mshare() syscall failed");
>>>>>>                    exit(1);
>>>>>>            }
>>>>>>
>>>>>>            printf("Guest mmap at %px:\n", addr);
>>>>>>            printf("%s\n", addr);
>>>>>>            printf("\nDone\n");
>>>>>>
>>>>>>            err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>>>>>            if (err < 0) {
>>>>>>                    perror("mshare_unlink() failed");
>>>>>>                    exit(1);
>>>>>>            }
>>>>>> -----------------
>>>>> ...
>>>>> Hi Khalid,
>>>>>
>>>>> The proposed mshare() appears to be similar to POSIX shared memory,
>>>>> but with two extra (related) attributes;
>>>>> a) Internally, uses shared page tables.
>>>>> b) Shared memory is mapped at same address for all users.
>>>>
>>>> Hi Mark,
>>>>
>>>> You are right there are a few similarities with POSIX shm but there is one key difference - unlike shm, shared region
>>>> access does not go through a filesystem. msharefs exists to query mshare'd regions and enforce access restrictions.
>>>> mshare is meant to allow sharing any existing regions that might map a file, may be anonymous or map any other object.
>>>> Any consumer process can use the same PTEs to access whatever might be mapped in that region which is quite different
>>>> from what shm does. Because of the similarities between the two, I had started a prototype using POSIX shm API to
>>>> leverage that code but I found myself special casing mshare often enough in shm code that it made sense to go with a
>>>> separate implementation.
>>>
>>> Ah, I jumped in assuming this was only for anon memory.
>>>
>>>> I considered an API very much like POSIX shm but a simple mshare() syscall at any time to share
>>>> a range of addresses that may be fully or partially mapped in is a simpler and more versatile API.
>>>
>>> So possible you have already considered the below...which does make
>>> the API a little more POSIX shm like.
>>>
>>> The mshare() syscall does two operations;
>>> 1) create/open mshare object
>>> 2) export/import the given memory region
>>>
>>> Would it be better if these were seperate operations?  That is,
>>> mshare_open() (say) creates/opens the object returning a file
>>> descriptor.  The fd used as the identifier for the export/import after
>>> mmap(2); eg.
>>> addr = mshare_op(EXPORT, fd, addr, size);
>>> addr = mshare_op(IMPORT, fd, NULL, 0);
>>> (Not sure about export/import terms..)
>>>
>>> The benefit of the the separate ops is the file descriptor.  This
>>> could be used for fstat(2) (and fchown(2)?), although not sure how
>>> much value this would add.
>>
>> Hi Mark,
>>
>> That is the question here - what would be the value of fd to mshare_op? The file in msharefs can be opened like a
>> regular file and supports fstat, fchown etc which can be used to query/set permissions for the mshare'd region.
> 
> Hi Khalid,
> 
> In your proposed API, the 'importer' of the mshared region does not
> open the mshared backing object (when a file being mapped) instead it
> does an open on the msharefs file.
>  From the code sample in your initial email (simplified), where a
> process attaches to the mshared region;
>      fd = open("testregion", O_RDONLY);
>      read(fd, &mshare_info, sizeof (mshare_info));
>      mshare("testregion", addr, len, RDWR, 0600);
> 
> Open permission checks are done by the mshare() system call against
> the msharefs file ("testregion").
> 
>  From the code sample in your initial email (simplified), where a
> process creates a msharefs file with the anonymous mmap()ed region to
> be shared;
>      addr = mmap(RDWR, ANON);
>      mshare("testregion", addr, len, CREAT|RDWR|EXCL, 0600);
> 
> Now, consider the case where the mmap() is named (that is, against a
> file).  I believe this is the usecase for Oracle's SGA.
> My (simplified) code for msharing a named file ("SGA") using your
> proposed API (does not matter if the mapping is PRIVATE or SHARED);
>      fd = open("SGA", RDWR);
>      addr = mmap(RDWR, ..., fd);
>      mshare("SGA-region", addr, len, CREAT|RDWR|EXCL, 0600);
> 
> If the permissions (usr/grp+perms+ACL) between the "SGA" file and the
> "SGA-region" msharefs are different, then it is very likely a serious
> security issue.
> That is, a user who could not open(2) the "SGA" file might be able to
> open the "SGA-region" msharefs file, and so gain at least read
> permission on the file.

If an app creates an mshare'd region and gives wider access permissions than the on the objects it has mapped in or maps 
in in future, I would read it as app intends to do that. mshare'd region can cover any mapped object besides files. It 
could be anonymous memory holding data supplied by an application user, or could be data captured over network. How 
would one validate intended permissions in those cases? A uniform check would be to ensure access given to mshare'd 
region is compliant with the permissions on the region iteself as given by the file under msharefs. Those permission 
checks are not implemented yet in this initial prototype but definitely planned as continuing work.

> 
> This is why I was proposing a file descriptor, so the msharefs file
> could be set to have the same permissions as the backing file it is
> exporting (but I got this wrong).
> This would still leave a window between the msharefs file being
> creating and the permissions being set, where a rogue process could
> attach to a region when they should not have the permission (this
> could be closed by failing a non-creating mshare() if the region is of
> zero len - nothing yet shared - until permission are set and the
> region shared).
> But relying on userspace to always set the correct permissions on the
> msharefs file is dangerous - likely to get it wrong on occasion - and
> isn't sufficient.  The msharefs API needs to be bullet proof.
> 
> Looking at the patches, I cannot see where extra validation is being
> done for a named mapping to ensure any 'importer' has the necessary
> permission against the backing file.
> The 'struct file' (->vm_file, and associated inode) in the VMA is
> sufficient to perform required access checks against the file's perms
> - the posted patches do not check this (but they are for an RFC, so
> don't expect all cases to be handled).  But what about a full path
> permission check?  That is, the 'importer' has necessary permissions
> on the backing file, but would not be able to find this file due to
> directory permissions?  msharefs would bypass the directory checks.
>  >
>>>
>>> The 'importer' would use the address/size of the memory region as
>>> exported (and stored in msharefs), so no need for /sys file (except
>>> for human readable info).
>>
>> I think we still need /sys/fs/msharefs files, right? Since you said msharefs stores information about address and size,
>> I assume you are not proposing eliminating msharefs.
> 
> The 'exporter' of the mshared region specifies the address and length,
> and is therefore is known by the mshare code.
> An 'import' needs to only pass NULL/0 for addr/len and is told by
> mshare where the region has been attached in its address-space.  With
> this, the /sys file is no longer part of the API.

This would require every importer map the entire mshare'd range. Should we allow mapping a subset of the region, in 
which case importer needs to supply starting address and length? It is possibly simpler to only allow mapping the entire 
region but if there is a use case for partial mapping, designing that flexibility in is useful.

Thanks,
Khalid

> 
> 
>>>
>>> If the set-up operations are split in two, then would it make sense to
>>> also split the teardown as well?  Say, mshare_op(DROP, fd) and
>>> mshare_unlink(fd)?
>>
>> A single op is simpler. Every process can call mshare_unlink() and if last reference is dropped, kernel should take care
>> of cleaning up mshare'd region by itself. One of my goals is for mshare to continue to work even if the process that
>> created the mshare region dies. In a database context, such mshare'd regions can live for very long time. As a result I
>> would rather not make any process be responsible for cleaning up the mshare'd region. It should be as simple as the
>> mshare'd region disappearing on its own when all references to it are dropped.
>>
>> Thanks,
>> Khalid
> 
> Cheers,
> Mark
> 
>>
>>>
>>>>
>>>> Does that rationale sound reasonable?
>>>
>>> It doesn't sound unreasonable.  As msharefs is providing a namespace
>>> and perms, it doesn't need much flexibility.  Being able to modifying
>>> the perms post namespace creation (fchown(2)), before exporting the
>>> memory region, might be useful in some cases - but as I don't have any
>>> usecases I'm not claiming it is essential.
>>>
>>>>
>>>> Thanks,
>>>> Khalid
>>>
>>> Cheers,
>>> Mark
>>>>
>>>>>
>>>>> Rather than introduce two new system calls, along with /sys/ file to
>>>>> communicate global addresses, could mshare() be built on top of shmem
>>>>> API?  Thinking of something like the below;
>>>>> 1) For shm_open(3), add a new oflag to indicate the properties needed
>>>>> for mshare() (say, O_SHARED_PTE - better name?)
>>>>> 2) For ftruncate(2), objects created with O_SHARED_PTE are constrained
>>>>> in the sizes which can be set.
>>>>> 3) For mmap(2), NULL is always passed as the address for O_SHARED_PTE
>>>>> objects.  On first mmap()ing an appropiate address is assigned,
>>>>> otherwise the current 'global' address is used.
>>>>> 4) shm_unlink(3) destroys the object when last reference is dropped.
>>>>>
>>>>> For 3), might be able to weaken the NULL requirement and validate a
>>>>> given address on first mapping to ensure it is correctly aligned.
>>>>> shm_open(3) sets FD_CLOEXEC on the file descriptor, which might not be
>>>>> the default behaviour you require.
>>>>>
>>>>> Internally, the handling of mshare()/O_SHARED_PTE memory might be
>>>>> sufficiently different to shmem that there is not much code sharing
>>>>> between the two (I haven't thought this through, but the object
>>>>> naming/refcounting should be similiar), but using shmem would be a
>>>>> familiar API.
>>>>>
>>>>> Any thoughts?
>>>>>
>>>>> Cheers,
>>>>> Mark
>>>>>
>>>>
>>

