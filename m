Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7974EF97D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350972AbiDASFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbiDASFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:05:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2105.outbound.protection.outlook.com [40.107.102.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4EA190;
        Fri,  1 Apr 2022 11:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQNdwQmdhWhVF5LEZvUMrAo/31kOUAO4RXmjLuLxntBGhMwuT6q2ReYmkL9bPHsuN0RwIbuRrBIZvJZoilO031qe/17n2JiTYtsMnOLfljPzbkCHE4edVonRznEOx5Ebel1gnnQ7hlxH0ZButCuNqUt89R5v1hvuhyi7+ZR7DVWwsiJ1ovKficFrJDm2bQaUyby1nV5rts+zxxHrRitZhpuKiJgYA8yLHOzPv8qIFHQ9PAl9HBXN3odPxxjY4P4B4xYB4W3KTBvczrqYjjmROZmKj7uralv1Di4dvE5wBGxYJPq43Xn7BiJLO1tE1fkM131m/YSr2Q/RBJ116EOcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCuYbSVcNnph4oNpJqeLTPFMBZHrvvW34OFMBwmIoYU=;
 b=kVyfYAZ8BVzAw5ej0QZtYCJctqUrHCK7xW4kCKjaDfRUmK1WpHyDFZtWEgFBwkiDiyfk9aZWIzQvNU9NEtKn7gX5RPHVBJ6T1c+MYMEnxiFczaUxTRuE1Koc9j06WcWb7qqCiVYh7hVr0iK64RgBrplZ4EEChZrV794YcOTDeavPbsVzrznr4cOGzraLEz+65/wClDB84y3PFhYaL1H0eL1sAVfB7/hTkm7k2PsyqCKcPfFfJ718XiHFfeRKsfLjZPnvmfTdtbxsHJY+wR2Ct+h+Q90aifXxIXIUFV9OIt3C0vJmNlUTDO7bJla9wD+vIaiVro+WY6JIW9Ns8/1g8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCuYbSVcNnph4oNpJqeLTPFMBZHrvvW34OFMBwmIoYU=;
 b=ZQI+D67oTOvSkYaNeczkZkztzuUuqwCsUlK3iOK5l2rfMsH772ucb+lJugV3vrpWwowxz/qH85LVXZ/Erpk/nqKX2mBfa6G/JVGDIKLU6DgOau79HR2H0KRoXhj+gOXRSM5sDW6+FwWatHyIlimze6WB3h0YVSXpv7IhPPVdJ2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB3915.prod.exchangelabs.com (2603:10b6:5:8d::28) by
 BL0PR01MB5169.prod.exchangelabs.com (2603:10b6:208:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Fri, 1 Apr 2022 18:03:32 +0000
Received: from DM6PR01MB3915.prod.exchangelabs.com
 ([fe80::cc44:99d1:f22a:b3c4]) by DM6PR01MB3915.prod.exchangelabs.com
 ([fe80::cc44:99d1:f22a:b3c4%3]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 18:03:31 +0000
Message-ID: <60ee55d4-3485-ad20-da01-a3464d5b9799@os.amperecomputing.com>
Date:   Fri, 1 Apr 2022 11:03:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
From:   doug rady OS <dcrady@os.amperecomputing.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Henry Willard <henry.willard@oracle.com>
Cc:     James Morse <James.Morse@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <20200317165409.469013-1-colin.king@canonical.com>
 <20200320131951.GA6555@lakrids.cambridge.arm.com>
 <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
 <88DFC1B9-D444-4D44-963F-34D0F5B9EC01@oracle.com>
 <Yh5DOz/u2hf3Eu5Z@lpieralisi>
 <345c99af-4f65-6776-fb21-f9fe8662566c@os.amperecomputing.com>
In-Reply-To: <345c99af-4f65-6776-fb21-f9fe8662566c@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To DM6PR01MB3915.prod.exchangelabs.com
 (2603:10b6:5:8d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62f9fc95-cb3e-4bf2-4f9a-08da1409ee9e
X-MS-TrafficTypeDiagnostic: BL0PR01MB5169:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB5169995B0F8259F80CF0B3E2F0E09@BL0PR01MB5169.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ft38GaMuG1svtRB9C7Hr/LxNEuvFuEEFJsYrkT3cvn56D6iMKwaZmkWU/j1+0QRqaGYFLGbHlpLO3yk/5U56csv3kRCC9SEHFYjbR4uNWELxe0leOdx58QKQNeLGrdgn1ZNmrv0c9Y9HiGpUVzK9lrsqh5HRJDA8v5mdPmZ9/tOjLYU57gda3Nh4oqHVjFA8AGiCDQQQADWBJmHPcvoh5FqOmYDB5IPifvMup7UVgu0/ucOF9AAwuilJwK3C7k+Nkv77I3OJgNmtwiQV95tJCFZl2fHgrSlStYuYzfxMxbQe0A21nnPk+6ATDVAxaARsSdG0q1Gx/ugUA60+H9U9gXOsplPhE8hOGgWySViFKxnJV8t9kkZo5G1rnslUtkggbpOg+5YOILz2XhybW+yFycmT9DtxibktyJKU1nUYL0/SdAsDyUmBy1c2AvUirgnQjGNleGLs2GLKNg5CmP5hU3GHlATgI6kYX6dIoOFmn6esxE1oC4seeelY/TTJJhcm6XWdXTno9HWtzRA8WeTqGqG02VxQXT18GEHdUDhU0xYyQFymlUWtSsmSyxZfD8fVqVIJU1z6BhKUHIM1IkwKLIp3HKhVKiOKJCnBCocFbhRjZ9VeISjRLCwZHaDNOPJRBW6Is5HBItWMIW2WmrJo+iBLGkKFX3ccwQHWzEUIoU6r13fBkMApy6oifqIBDQg3nen1rgRAFDlv+yk+JKQ2WwatO9BRmPdqxE0pDhf1FU8puhHD6CmRQCAi0tmwQqOKVm5Bcv8t0q7R6o6iVS/DuvVKpTv6aHWctMVRuuype638k8a1FzevN9AXBhC67CXY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB3915.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(52116002)(5660300002)(38100700002)(86362001)(31686004)(110136005)(7416002)(54906003)(6506007)(6486002)(966005)(316002)(38350700002)(66476007)(66946007)(4326008)(8676002)(6512007)(508600001)(83380400001)(8936002)(66556008)(6666004)(31696002)(2906002)(26005)(186003)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1SWVJUcmdLQUgwS2MzSkwyQ3dvUE4yOEFLL1BiQU1NMVBNYk5zN2MxN0JO?=
 =?utf-8?B?VEk3MmEvSXVESm52dVhSOGgveWkreVY3N3Q1YkN5OGc4eWJnSHUxbVRydnZl?=
 =?utf-8?B?am80TkJrb3pMdjlvQ29UNS9JQzhDT0dBMlVvS09lTHJpalU0VEpTUWgzcmE4?=
 =?utf-8?B?WXZpOVNKaEtNU0ZjaFdOM1ZTWk56Mm5HTTh4MWlsemJEVU1lZWhNa1huejhv?=
 =?utf-8?B?Q2hzdWFoRG5KQjhBVnh3TFdyUU40RlVJeG94aXQ1cFBOckdITHJ4R0xEUFVS?=
 =?utf-8?B?ckEvR2RvNGxWa3F1V2ZQWTN2a0V5VmZKaVUxczh1S29EbmJDT1JCUUhudTA2?=
 =?utf-8?B?Vm4yanFqNURZeUJ1d09GZ1l3SXRqbE0ydXo0OEtRSFphekZtQVl2Vi95bzU1?=
 =?utf-8?B?UWJWTUx2L3NPL3NUZUpXMCtqWFE0Z204eHdhYnhhM1ZSb290R2xqVVhRT003?=
 =?utf-8?B?SWNiSVlwVkxNNUR6a0l1clowSDFXVWtIbllVWFhaNDJBR1NwVlBIRkdDUElh?=
 =?utf-8?B?UFpTbXIyZm1QOU9IcW9qTUxDSkE4ZVJ4aUJzTWFpVk5XclBIWWs0S1VONlFC?=
 =?utf-8?B?QnN2UE5XVk9yTlVzdjdxMVltVlAzeXhPaHdHSU1XWmxpdkhIZUZENWZ1OVVk?=
 =?utf-8?B?WFd5amk5QUR5M3hXYmE0UkRWWjRwUnQvUWJHQnZzMkRKK1NxYjE5eC9HTk9j?=
 =?utf-8?B?MDN2NzlmaXBDelhjWnMyK0thVllUSU5UY1IwVUd6cjZidHlnRVJMY01uaG5Z?=
 =?utf-8?B?VGs4a3I1aFdQVGN6TXM0TUtIMkY5V3JEQUdJSTNyL2tWRVMvM0UxYXd5OVJv?=
 =?utf-8?B?WU55TXBCUUtlZWR3dlZ1SnBlR2lnaHhpS2pBSlpKWitNajA1NFp3OFRHdDF6?=
 =?utf-8?B?eTBxajJDN3Y3Tm40bTl2aCtUbmNYd3UreVI2S0VZY1RSaFZidG4zS3dpQXMv?=
 =?utf-8?B?aWJ1Q3MrdXpCNllyZ1lLODFwOFhVck1nVFBKZWpxRjZoV1FvdW9OL0pZUU9Q?=
 =?utf-8?B?alZVMEFScFlSYTNUOWp2VjM5MVVjd0dCemo5WnlLclA1MUtLY3hhL3dVbzRt?=
 =?utf-8?B?Z0ZSODRDMFVGK1A3RFBJZlgrTjBxY1d6V0dza0R5bGlNYTRNcnkwTzFpSlBn?=
 =?utf-8?B?R051eTBadjFnSXY0Z0dCUTYrakd6RWl0SVA2T2I0WmdKQU9yRktPS1gxNlMr?=
 =?utf-8?B?dVVEcXVkNUxiTHFlNGovMVpWanR0aTB5SE1Bbm1tOWVnNTk3OVI5S2o4bjlB?=
 =?utf-8?B?SVZWbnVqVE51TVFncTJ2MTNpY3cxVFE2MnpVN1JaS01LVUx3VDN4N1pxemhs?=
 =?utf-8?B?bUxTbEQ3VFlZNi9uMmZYVVozOHk1cC9BODJsbDR4MG55elVvOU9KTFhyV21Y?=
 =?utf-8?B?VVpCei8yVUpaTlM2MFF0R3Y1UTE2Z2NibVBKd2hKWVNpM0FPR29YMHo4YVJ2?=
 =?utf-8?B?elRYMlhtc1Z0aTBORzlSdThIVEp6dEJMdmFKNHM1NFhXc3o0NVk2RnNnNUVG?=
 =?utf-8?B?bnJLZ1lBcTd2bkQ0amhVWS9RSGFoRm83QnNScytIRVhXZnNDZWFUVmFQaHFo?=
 =?utf-8?B?L1lEQjBpTVJNN29mdlR2bmYvdFd4ODhuMGxYVWxza3BoTVJVWmJLL3gxNGNZ?=
 =?utf-8?B?Rm4zaEZRMk9HVitDd0hsbnBhdlBKdER3YzVtMlRnWjFaZW1xRWNSYjdPaldj?=
 =?utf-8?B?eHRxTXUxdU94djhrbHVUZ2NFeEV1YWJSNzVhTDhZandBT05NZEU5azFwMHA0?=
 =?utf-8?B?bjZFYVdaR3NTZktqLzViM3pDN2ZhVUJiWTRHTUdxOFpvRUpWZ3RyVHovTlE2?=
 =?utf-8?B?TWpnV3Yyc0IwdU9HVmQyVmIxS3hpeEI2Y1V3SXA5a2ovTk1KWjJzV0NKYTli?=
 =?utf-8?B?WHpUWEc0QzhHL1k0VHA4WEhFaFVCNnpmTjVqcHRrTnlwNEY2dzYralNudVZM?=
 =?utf-8?B?cVRwY3VjVHVSMmQyMmNUd1E4YXBZNEIrWGxNL2RpdVdhRTNVQTNRN0F4NXlQ?=
 =?utf-8?B?dW12WUF2MWIxQWcvdDdBekZIQ09OOVcwVlZ6YkZhT0w0NzNxaEwxRzB5VTRr?=
 =?utf-8?B?SUlsTzFrbXZwVXA4d2prdmsxUWNHMXB1dU41UWUybFQvMTZvYnNjRGRFUW40?=
 =?utf-8?B?Z05veFN2UkZVd280UzNwWkRPajJqVG5qRitFTHY1OEh1ZEdmbVozRlNGc09M?=
 =?utf-8?B?L3BVNWc1Qnl5VnpyaWpoZUM3RlBwcy8vTkRkQUVGL0lKMlNTZk5zVVZNd2FU?=
 =?utf-8?B?TTBqZFJUR25CT0c5UWhDS1Q2KzN3L3k1MmJ3Y0ZlRU9kNjhqejYva1A3bkpB?=
 =?utf-8?B?M0VOam9zUDROY25DaVN2blQ5eHJJb0lhQ1Q2UVRCYm03WXVZekdJVEExNHZn?=
 =?utf-8?Q?gbe8qnbpPkHD92b99uO4qZkiOA+0KBRvj6Q8q?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f9fc95-cb3e-4bf2-4f9a-08da1409ee9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB3915.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:03:31.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZrcSTcv78sGxEYnYQfV1u8aS+4PfWVSuQfZ1Vc2VGSXnDK+GNydbEykIExQSGZxUwV7K62pXL6W8AVOrv4+GzfbIqlUiiRKo+6LUT3nMV+0VGjG41oTGilUMV/ZyKDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Just checking the status on this patch?
Are you planning to submit for Rafael to pull?

It is more important now that the below has gone into 5.18:
'[PATCH] ACPI/APEI: Limit printable size of BERT table data'
https://lore.kernel.org/lkml/CAJZ5v0gMh2ed+ZWOnd-t_uTrZtm=AUfxOAkAKWT7WQK3=gf+7w@mail.gmail.com/

Thank you!
doug


On 22-03-07 13:22, doug rady OS wrote:
> On 22-03-01 08:00, Lorenzo Pieralisi wrote:
>> On Mon, Feb 28, 2022 at 11:51:23PM +0000, Henry Willard wrote:
>>>
>>>
>>>> On Apr 1, 2020, at 5:44 AM, James Morse <james.morse@arm.com> wrote:
>>>>
>>>> Hello!
>>>>
>>>> On 3/20/20 1:19 PM, Mark Rutland wrote:
>>>>> [adding James and Lorenzo]
>>>>
>>>> (but not actually...)
>>>>
>>>>
>>>>> On Tue, Mar 17, 2020 at 04:54:09PM +0000, Colin King wrote:
>>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>>
>>>>>> Reading ACPI data on ARM64 at a non-aligned offset from
>>>>>> /sys/firmware/acpi/tables/data/BERT will cause a splat because
>>>>>> the data is I/O memory mapped
>>>>
>>>> On your platform, on someone else's it may be in memory.
>>>>
>>>> Which platform is this on?
>>>> (I've never seen one generate a BERT!)
>>>
>>> I have seen this on several platforms. The latest is an Altra based machine. It shows up in the Linux Test Project: ltp test "read_all -d /sys -q -r 10”.
>>>>
>>>>
>>>>>> and being read with just a memcpy.
>>>>>> Fix this by introducing an I/O variant of memory_read_from_buffer
>>>>>> and using I/O memory mapped copies instead.
>>>>
>>>>> Just to check, is that correct is it correct to map those tables with
>>>>> Device attributes in the first place, or should we be mapping the tables
>>>>> with Normal Cacheable attributes with memremap()?
>>>>>
>>>>> If the FW placed those into memory using cacheavble attributes, reading
>>>>> them using Device attributes could result in stale values, which could
>>>>> be garbage.
>>>>
>>>> Yes. The BERT code should be using arch_apei_get_mem_attribute() to use the
>>>> correct attributes. See ghes_map() for an example. bert_init() will need to use
>>>> a version of ioremap() that takes the pgprot_t.
>>>>
>>>> Always using ioremap_cache() means you get a cacheable mapping, regardless of
>>>> how firmware described this region in the UEFI memory map. This doesn't explain
>>>> why you got an alignment fault.
>>>
>>> The BERT error region doesn’t appear in the UEFI memory map on any of the systems I have looked at. This means that acpi_os_map_memory() will always map the area  as PROT_DEVICE_nGnRnE, which results in an alignment fault on an unaligned access. For some reason this does not fail on some implementations.
>>>
>>> It isn’t clear to me from the ACPI spec whether this can be in anything other than normal memory as bert_init() seems to assume it is.
>>>
>>> We have used this patch to resolve this problem on the assumption it
>>> will eventually make it into the mainline kernel. Is there any chance
>>> this will happen?
>>
>> Yes this should be fixed. I put together a patch that I needed to post,
>> below.
>>
>> -- >8 --
>> Subject: [PATCH] ACPI: osl: Fix BERT error region memory mapping
> 
> I hit this read issue while debugging something else and this addressed
> the problem for me on Ampere Altra and AltraMax systems. Previously I
> could only read the BERT file using dd with BS of 1-4.
> With this patch, now I can 'cp' the  BERT file.
> 
> Tested-by: Doug Rady <dcrady@os.amperecomputing.com>
> 
> 
>>
>> Currently the sysfs interface maps the BERT error region as "memory"
>> (through acpi_os_map_memory()) in order to copy the error records into
>> memory buffers through memory operations (eg memory_read_from_buffer()).
>>
>> The OS system cannot detect whether the BERT error region is part of
>> system RAM or it is "device memory" (eg BMC memory) and therefore it
>> cannot detect which memory attributes the bus to memory support (and
>> corresponding kernel mapping, unless firmware provides the required
>> information).
>>
>> The acpi_os_map_memory() arch backend implementation determines the
>> mapping attributes. On arm64, if the BERT error region is not present in
>> the EFI memory map, the error region is mapped as device-nGnRnE; this
>> triggers alignment faults since memcpy unaligned accesses are not
>> allowed in device-nGnRnE regions.
>>
>> The ACPI sysfs code cannot therefore map by default the BERT error
>> region with memory semantics but should use a safer default.
>>
>> Change the sysfs code to map the BERT error region as MMIO (through
>> acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
>> error region into the kernel buffer.
>>
>> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
>> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Hanjun Guo <guohanjun@huawei.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> ---
>>    drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
>>    1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
>> index a4b638bea6f1..cc2fe0618178 100644
>> --- a/drivers/acpi/sysfs.c
>> +++ b/drivers/acpi/sysfs.c
>> @@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>>    			      loff_t offset, size_t count)
>>    {
>>    	struct acpi_data_attr *data_attr;
>> -	void *base;
>> -	ssize_t rc;
>> +	void __iomem *base;
>> +	ssize_t size;
>>    
>>    	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
>> +	size = data_attr->attr.size;
>> +
>> +	if (offset < 0)
>> +		return -EINVAL;
>> +
>> +	if (offset >= size)
>> +		return 0;
>>    
>> -	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
>> +	if (count > size - offset)
>> +		count = size - offset;
>> +
>> +	base = acpi_os_map_iomem(data_attr->addr, size);
>>    	if (!base)
>>    		return -ENOMEM;
>> -	rc = memory_read_from_buffer(buf, count, &offset, base,
>> -				     data_attr->attr.size);
>> -	acpi_os_unmap_memory(base, data_attr->attr.size);
>>    
>> -	return rc;
>> +	memcpy_fromio(buf, base + offset, count);
>> +
>> +	acpi_os_unmap_iomem(base, size);
>> +
>> +	return count;
>>    }
>>    
>>    static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
> 

