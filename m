Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93328508F36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381455AbiDTSSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381464AbiDTSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:18:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C34756B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L06kqM+trVZOmftWfDANtJWRoqrx429//C1URT2ZZf38LaYSfL1XBrpoB3JnVNLxIgIZAtWf0av4GzsFiGk1oiwQ1KdjD3FGkYXUbVPKIN13ObNhveapyxhv9SGksb6UIY4VK8RG3poBoM0G8YzRDAtmbFOEHNMzo2UJrc2HgegY+ss4fEvHHP5X6wP6XPGdUTkbPAvihh45avr+4dVaIePF58fGHCBXaeJH+/YosUSwOmeyx5qNRgrhZTGqNHp6NfvwQiI33yw56af/H/XCIuGpwqtFKGj8RoMuI1zkOK9KDFnNrk2peyhbn/3eD0maGIWAxhZogf4XnPOdLrA8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra2HmmFNfVc3oAUxnhGLpv1mKu8U6S1nh0RNVQxwdkc=;
 b=m5yH1ZHFrqYk10vXnxrrmykyffpTb6XEHeRWytYdtlcZw4C7NLnUOgNaGkGmX8dTJ+zfUuBa49D/7EXVc5fxT96XNfkfdLlbBBDbqPVjtFJD/AxqM1MTPsO6xHIPDIo1gJP0VKj7hd9ugme5tJeDQeLt/omOXzQ3QryyM77uxZUTm/8Ym7Cw6yyTI6wWaHnwctAEaNcbnBBvShjWlJkRo4f75vLdtJ7q7K/59+N7wNrfB2gXNWC/lgvBuuk2vTTGHPz8zooxhXdihkyWfuNvU2iU5hFKVlWqJ33maI9uVemWALbd/Q1hnAV9vUPfMEqsZuRbAA5Pu1Du0diHvQjgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra2HmmFNfVc3oAUxnhGLpv1mKu8U6S1nh0RNVQxwdkc=;
 b=rU6nZXP2MrPrD0BYOKoWGEMF/rGu/S1FXWO5r+6JsMIs7TNBPzImXYcWsequKGbJPw+hIlZ/M4Yd9NvINHN/b/Adx/f0rmFwUu8qHlTyKVCU5XSZThNS4hgMBGZtzzVXlUeUTJA1/fAA57pOJr644bf3AUuCf+60I8w1+93fT90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 18:15:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 18:15:17 +0000
Message-ID: <60e5a4d1-df7c-d3bd-2730-e528cd75c351@amd.com>
Date:   Wed, 20 Apr 2022 13:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
 <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com> <87ee1t9oka.ffs@tglx>
 <878rs0vkd2.ffs@tglx>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <878rs0vkd2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e151ba33-90df-477c-041d-08da22f9b90a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0208CD86E098AB4D0B9D9641ECF59@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1IrkFQSjls6xgAwCkwX4gJir2+NezrPyUwB93J/kk3r/j5kq1G+LEK567TiMBTkh35OohpnxN/EfRW6DuEUupfNIR9/Iv5NOBrzA5Up5zHOjTO4K4fu3XlvW/C4nowtUYvKuqpS6dJt9mLlMPwRHguEf12oUOQvbeOm6ELeNo7GliriQjECzgKd5PzAjuefh79Ib/CxydkdeXKiqn6wxJwoX6qamZU/mJ9imjLjF78I4ZMeFEx5nTe0eVLosh5SjYHnNYwHj3cH4r9muFN4snD4FRmarxVAaVsfmD88lMuZgNp1QIP1FZec9dVuJXAl7auMk7fVSAn/d/Y6mL6M6c6J7fXQXJnwaO9xCDkd6aJk3grt5uP0IHAMrC7xAwCtkSuYl+/ihxAEuxCbsv/Wr61fpHERjNxbXGhwlx/L32z8cNDBQ5SW5HffgkUr1xhbpl+kj0jVsXbGqPt2zqOXGNzEBE/ihxUrajgp5jG7tMHEnNuD1tu6ZXvRJiu8JCZLg/6E8UA6FlPf7ozcqrm3yv378oZpBH9upMO+O/8lY+zEXUdohhFYfWxpHNL2BhoOhv+TKviQPsuRr0tQTmvz3N2S9kOJnxpeS+d3fwlcT0qQElr/vTP/9p/VWPJspiSiU4PAdgCHiXm6/4cPM0s0sYztbW6VsnFXM2jQLfzWUHZI2Zgfjjlnx+MRNxFRzWOlNX8rErKMJhwX6ywmujUoxtlDH3MYe0yXos1Yzc4Stt8F2BafOH4Q8UqT4ddtVY2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(31686004)(53546011)(38100700002)(316002)(6666004)(54906003)(2616005)(5660300002)(36756003)(83380400001)(110136005)(6506007)(8936002)(186003)(2906002)(66946007)(508600001)(31696002)(8676002)(66476007)(66556008)(4326008)(86362001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5pZVBwN3JJMkJKVCt1RDhSc2tKZnpBejkvZzQwVmI0ZjNQZVdtNU84R3NQ?=
 =?utf-8?B?b1FURG1uM0dSeDZ2UnhWMmdJRGRkc3ZBVnZybzRSNDI0NlEvcytFeTE3RWVh?=
 =?utf-8?B?NVJudnBpQXN0ak05by9Ua0FCVy9jR1BhUHg2OExteTZnSmdrTW9vU2laUEV6?=
 =?utf-8?B?bjViYjZEaDhORXJwc1hMOWIzQUc1VHA3YUhEbEFuYWg4MExWQlF2SHhzLzg4?=
 =?utf-8?B?TmJ0RmdlVW9BZ2xMYUVDWjNVUkVpNTNBeUhUd2tmTG10N1F3NjcweERtd2hZ?=
 =?utf-8?B?dER3b29GcG1HY2FyWkd4NDJQYmpCTlhnOXU0NndaWEkxaHdiZ0RIYTNEZXRK?=
 =?utf-8?B?RDVST01JRVB6S3VycFFxRTV3OE9wd2VnNXBybk1WMlE3cTBqVythVmJCNk9p?=
 =?utf-8?B?Tk5iM2c0aUdxS3BST0djT3BaQ0tTYUdMcE1vdGZray9pR21uVWNqNXpuRG9x?=
 =?utf-8?B?aXhEWjRJZDByZnV0OCtneTJnNmMyajlxb3pscTA4aTRwaEZYS0xKQitmL1ND?=
 =?utf-8?B?Q09FQkZVYlhlL2o3YXZraFlpbTd6cDBrTmZOVVhDZFVVam54Nys4YTZFSXUv?=
 =?utf-8?B?WHhhRXdENmp2dlhjMnhXTmFpbWxhVmF0ckxZWmdkdFhpT3dHL2F2dlJOL0Y1?=
 =?utf-8?B?VHcxWkVoVWdlZFREYmdzUmY0YlZBWSthZHgrb2ZEU2xMaU9JVnNVU3VkR2RD?=
 =?utf-8?B?emdUbzNOQ1Qyem1RUXpBbmUrNHdjLzNUUkJFbVNGTWNHSExiNDB3N3cvV1RG?=
 =?utf-8?B?L2lTSjNkbDg4Y2N4ZUxrNjZNL1BjWVR5RTZiOUlpb2tyWndwUHordEpmZDYv?=
 =?utf-8?B?WnpaRjg1UnhKYWFmRjM1OWlQRGduS0NwOFRBd2NEalh4Uk1vQUwrOTRxWE96?=
 =?utf-8?B?MmMrZ2dRSU41dlloYjF1MW84eFhZcUU2UGhQOUpVOHFKMjRtV1h3bnhwM3Az?=
 =?utf-8?B?Tk5DQnYwMGVneHBtRVp1NldlUk93d2JrREFueVhEZXpJMGJIS0c1UFZ4NXpz?=
 =?utf-8?B?N0wwVVpQeENXeFhFUDkveDk1ZGN3N05SNEhvYTJ2QjlhWkFpUTFCRTZrYnBS?=
 =?utf-8?B?OXRQd3hRaDdEbEtaaXdaOTgzTDRIVXdVUk1DZ2tMMjB1SkpuTWsxQ05PN1lk?=
 =?utf-8?B?UFVUQjY0Vlh6TTlMUUZxUDNvUVRhbjFHMWUrNG5xYmtrNXVvOUdIdGlZRDIv?=
 =?utf-8?B?OFVQWUEwU2xwVUZyclo4OHpzbjNPUUdCbkVlOHpJaTBsVjRGVk1BVitlaCt2?=
 =?utf-8?B?Tm8rRUZYOWRVOFJianM2L09vZmFtOG5UdzZYY1ZBanJyVG1uTFhucCsraEpJ?=
 =?utf-8?B?NjU1aUJJUFA4T1RpL1VNZmIrTXp4WHBtdGoxdTVxbTc4RDFabWxsYXFxL2lC?=
 =?utf-8?B?eFQ0a0xRM2phelV1ZFdxQkpPYnZMTUpKRldZWk85Z1o2aUxqaGVDRkordE1Z?=
 =?utf-8?B?Y1ZlTHd5cVlVSFYxeWl0dUg5SXFPeEMva1h5VWUzQ2cvaG1UWWZOMDBhUGty?=
 =?utf-8?B?RlNoaGErNTVsL2tOZ1hGbVBmOGFQdkhVVjdPRWVKQ2JIWStibzR5OE5FRnRT?=
 =?utf-8?B?d0xyYjdheElZM013YnQrSzNUa3JFOGREM054Tyt0L2dydlNGM015K2t3TGdB?=
 =?utf-8?B?QXN4eHBQWXBEcXo5ZWI3T0E5Y1o5QWZtTXdNZlVOVkRmSzR4ZFpYQXR1QVM1?=
 =?utf-8?B?UFJrZXByS2J0RUFwakFWbzZYa0gwclFTWm91bEEyeDM4RXBIekFWNjJoRlpP?=
 =?utf-8?B?cDMzUXBPblgwYS9hSEFOVVB6SGZPUTNKT3BvUURkcGR5eW0ySWpEY0R1VHVl?=
 =?utf-8?B?QVZLWGVMWWI4emdLRTlaUDlGSi9oanAvOG1KZ3JoeEdtTGtGZHRQYzA5MG1F?=
 =?utf-8?B?eUlJTzdtNmQyeStPMXJiVkdDNUxHQkhPWm90YTFQL1dlR2gyUm4rNFlxR1gx?=
 =?utf-8?B?UXBYT0EvZjJXK2M3NUMrVmEvT0s0amg2anhuWFgyK2hGNEZ4MldOTzFTdy94?=
 =?utf-8?B?K2x6anZuZDBadHcvMVVXeUtyV3gxa0h4cEtYVTdmaGpOa1pxbi8zK0Irdmd3?=
 =?utf-8?B?K24rcVNJaW9wSmdCcGJpd1FtU3EyUW0rZ3lSSFhiWS9UcWlvMi9CWVIycW4v?=
 =?utf-8?B?UTdYZk9vdWNZNmR5aVFTM3pZK3drZzdsMmptMVBCenk2VzhuWUpJblhIMzN4?=
 =?utf-8?B?S0IyMEZHL0xobTdTNmo5NUVwd1BMVk54Tjk2bmZyUUM5aWdTcGVZRnc4K0cx?=
 =?utf-8?B?SnhuRzBsSDI5ZkhIMlo3UjdIaW1lVnlkT1lFYWVBQkRTT2RyZU1xcWQvcDFy?=
 =?utf-8?B?R1dXY1BtRURYMVZ1UEFmcEx0enNxQU5FdXhqdHNpbE5Zdzc5Vnl6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e151ba33-90df-477c-041d-08da22f9b90a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 18:15:17.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRxGTHDZmsgXpoiEdJJaoWDWPJbED53GHM4i21fwAHnlBEH1tTJzboSG4hctBGKeqosn87lWtXPwzT+SC0HQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 16:22, Thomas Gleixner wrote:
> On Tue, Apr 19 2022 at 15:43, Thomas Gleixner wrote:
>> On Thu, Apr 14 2022 at 10:24, Dave Hansen wrote:
>>> On 4/4/22 05:11, Thomas Gleixner wrote:
>>>> which is suboptimal. Prefetch works better when the access is linear. But
>>>> what's worse is that PKRU can be located in a different page which
>>>> obviously affects dTLB.
>>>
>>> The numbers don't lie, but I'm still surprised by this.  Was this in a
>>> VM that isn't backed with large pages?  task_struct.thread.fpu is
>>> kmem_cache_alloc()'d and is in the direct map, which should be 2M/1G
>>> pages almost all the time.
>>
>> Hmm. Indeed, that's weird.
>>
>> That was bare metal and I just checked that this was a production config
>> and not some weird debug muck which breaks large pages. I'll look deeper
>> into that.
> 
> I can't find any reasonable explanation. The pages are definitely large
> pages, so yes the dTLB miss count does not make sense, but it's
> consistently faster and it's always the dTLB miss count which makes the
> big difference according to perf.
> 
> For enhanced fun, I ran the lot on a AMD Zen3 machine and with the same
> test case (hackbench -l 10000) repeated 10 times by perf stat this is
> consistently slower than the non optimized variant. There is at least an
> explanation for that. A tight loop of 1 Mio xgetbv(1) invocations takes
> 9 Mio cycles on a SKL-X and 50 Mio cycles on a AMD Zen3.

I'll take a look into this and see what I find. Might be interesting to 
see if the actual XSAVES is slower or quicker, too, based on the input mask.

If the performance slowdown shows up in real world benchmarks, we might 
want to consider not using the xgetbv() call on AMD.

Thanks,
Tom

> 
> XSAVE is wonderful, isn't it?
> 
> Thanks,
> 
>          tglx
