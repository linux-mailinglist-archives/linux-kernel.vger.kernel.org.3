Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF47572BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiGMDKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGMDKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:10:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93EBBD25
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkINM+crORaMKlTk0PE2qAhS8zpJxV0sXQ5z2+D2FkT8x+nqp5RO0GXzWhLTb2uu9UAAmmWJheUPHP3lU4d07CpLlSE11P7ERGI3jJfnW6q5NQsZJpfpqxoUwqL+Q8+S65J7NmUEAQ0q7pE8Tb3NiPFS+eBOCUyjVJ9wR833E8A1sN+H/cfSl9qT45beUrVS8HygbsWSQVKCaGYRftS3xWK7CtV4Cygr647bZxexn6FWKZ1R+gWOeEHBHto2ypesdlpSdeRdKlmdp6mk4xQmcDeyxSfZPGEV8sbdHY6s7tVNX+tWjtaG93lRpHFWHOH0w0i3cxHdJpVH+Y/wtiWSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qdkUWrCPNBKbWvuxCCvy3iwSECjwUyVfCcZ/NuZXCA=;
 b=ecWm8YdxJ7tjgEuu4Ecp5nCJ+IckhLdQo7Mm0cd/aBsCVN+KmMuo0uEFSPQ2fHsAR4W47sNdfnJi5Es846ZUCATQ1e0+l/nqBiLWrv+bIw4ijsqUmh+xMi2hmgBS79O4xwDQboPY8KkvN2Yp8zktZUtTkZY9G4uyYpC2YNF0mNNFPHQ6YmvXMNWNQivCFuNAQbzHuXNeqODMs1AP1Wzw3bIvs4pNDEBASkUYl3eGTUCSyhs3ko7hw2hpLhKvL+906hl7Ms72cjyrYdFV9v57Rn7csYtGnS9uMGi2fzsjc26ePLekvl4Dhafd8D7qIhi9H2Tud0PXG+KSMSxiNfNPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qdkUWrCPNBKbWvuxCCvy3iwSECjwUyVfCcZ/NuZXCA=;
 b=K4DRCTa3ScqmPuHhMFRjloSnvOxtUQsZy2VOriMQsY0vboStHo4hxLt2qk+SJ49CsTy4QKsO1zIqru3jpGbv0v/41QSDZOV84ir0uF7a414kTXTYH29Gar/Iwz9L/lhjbfahCdJOXYdl2RhC8RZE4LKH2F7C1+9J88YT8Ahv3Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 03:10:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 03:10:07 +0000
Message-ID: <5c77d242-2b03-d9b9-7208-b1d4fdc8796a@amd.com>
Date:   Tue, 12 Jul 2022 22:10:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [REGRESSION] amd-pstate doesn't work since v5.18.11
Content-Language: en-US
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <3559249.JlDtxWtqDm@natalenko.name>
 <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB6101ECFEFBBDBB65CA75F1C3E2869@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2414945.NDPYyZybsh@natalenko.name>
 <4c9e3a4c-40b2-3ce9-da88-ad507769658b@amd.com>
 <DM4PR12MB5278A45B6DD497ADD85DD5399C899@DM4PR12MB5278.namprd12.prod.outlook.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DM4PR12MB5278A45B6DD497ADD85DD5399C899@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee1e29f-ac8d-4504-043a-08da647d3060
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiQTzDK2gT00/tZ+VmapUjnJ7fpbaafHRBbhWlwmDYOOYkPq8TsS44g+KBvojvDZJZ3+c/3TK4qS1nSYkbVClPDoC0iF7RRXa7xhJ8XKyZMxn8r1rbGZ+F5prycWG0Yet/tINj8BzZ9gMNWtR74aEDmAudd9Z2204E8gLPupwbyI0m3wDzTyIh4mnJp1Kc6hStu0Sp4oZFQkL9IFYaydahfQhrYyWnKX9IseGDj1+nY0G6HDWkp2tAFT4EIbw/PFsfz8+m9KdOqhLlr4IuB5TgPtygmyOHmyPmujHGCtVPtHRnKWWDXk6o1WRc0a/4Fx9A3YtP2/W7/j5mRYLfS3frWSUnCTLAloiufY6rgWfqXBlrXzT8d1T2K4gGt69CRg4oqV2vtUYGltyl4zz/jfNVPifSnFbSdHz0h61YoQzab3EUkPKO+wHdQZGkHGLTqYAaZp9wH/XE0YH8PZIuKGSXjMWeRyHkTjdFzJtSRb8NoaTQTSWaeZNCbps8qIvcSBAoKoay5+psMWfcMmS7bcyvrT/rR0Xc0zEAsLDZf0OkBXiyfSsU06S1t/Hi9thGu1LlUXN0eAzAxF3hRwFP+gAx/e2j15F3ZzMUF7Dr2rIRHoc5FtfOOgzcOyHUhNGaITo+UNbqAo8wU2VRsrqC3Twc7gVikgZzW7j1Y6sEkq6JKxQr5fFTa2MvdPB/eLSTZEpmHZIffMAXU8eWc19zxvl8YvKnnkEJKg88JHhl9htVX3ysdKQWc3EoQDkXvC/yur2RJESNcAn5t2adE0Ek5a3Wb62G0rYPN4nIAVs9jldSnEpAIdDSCjkjjWuOBsG++3Qdo9KMNtruH1dNtBMJlyX5ve9fJC4AeMHc4pLe7yicaItiH+MVoVf/cG/PQudnNdm0A4xvGZ/VbLOH0K5TACuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(86362001)(36756003)(6506007)(8936002)(5660300002)(38100700002)(6486002)(31696002)(66574015)(45080400002)(6512007)(66946007)(53546011)(2616005)(66476007)(186003)(6636002)(54906003)(4326008)(110136005)(66556008)(41300700001)(31686004)(83380400001)(2906002)(316002)(44832011)(478600001)(8676002)(6666004)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZDU3dwYTNFa0IreGp6VUx5MUdacEdud2pUVzdLZjU0d01vVDBsWlNFVmg5?=
 =?utf-8?B?NFRNd2sxOHUvak9IREpFSFFEbHAyMnZkbVZKSjJDWERXcUlwZXJ3MVloTHNM?=
 =?utf-8?B?WTFCTy9scktRd2NNV3RWL2ZMN3FMaXBORjBwTjFhUEsxU1hhRmlOWGNNYUt5?=
 =?utf-8?B?VmVMNUJZcjhmMEFuUTMyeW4xR2poQ2tUUjdLUjNYY3c3REIxb3NxbFl4S3Fh?=
 =?utf-8?B?UUNiUk50OVVmd09NRkRQTDQ1R2I0WjhMckxpTDV1QTBpMjJJNWZmYzhTd2w0?=
 =?utf-8?B?SGVXZ3ExNlo0b2ZQK25nbS9tQ3h6QWhrRjk1MFRGN3hUYlMzZG1RTUlIaUhM?=
 =?utf-8?B?RVVKYVpsSjBqZXY1aHlkcWJZT29BOTRHVnpZY3FuZlVEZHFVOEE4TnVtZHla?=
 =?utf-8?B?eWxLNmdDTC9NKzArR0ZuU2VPWDdnN0R4aGpHZms4OW40VkJva21RR21iQ09h?=
 =?utf-8?B?LzI1VjRLdlpxM2dlcGVOM3Y2eVlXU1F1a0xrSTZpbnBSUmh0azdFSm9uMkt6?=
 =?utf-8?B?QlhoUXFvcHp6b0huRlFkMUVIdzB1dUIvdmNjNkJHUE1UZG42YzR3bnZLZnBY?=
 =?utf-8?B?T3dkZThGWEUzeDJ3Y0xVVjdMQnBFbGk0SGYvYmV4QS9MRjh6MVFiNHlRZXBX?=
 =?utf-8?B?eVJDdnNndXFTNzhHR2dDZnJyVUZISXBPaGkwTndHMi9XRjl0VjdMdVVMU0tH?=
 =?utf-8?B?K2xwR1lxVlBnWmQyYnhZbDlLVE96bkJSS1FMelV0RnM5M2NWV20vZGhva1BE?=
 =?utf-8?B?MDVNR2RkNGNTMkpwV2hGWS9WQ0RJVEJSbzR3b1BRUktCa3R5UEs4Uk5pbTh4?=
 =?utf-8?B?eEFoN0FGMUw1dkpGdnJGWlcvN3VFMnh4WG9wY25ORWdFbXNLY2hMZVQxREU2?=
 =?utf-8?B?aWNleVpmUlFGNzhnVGNaWWFMSUVEcE1FbE02TDV1ZlNBRWIzSVEvR2NtOXk2?=
 =?utf-8?B?RUF6eUJNTCs2MTRUdURDN0JtcitxMDIxcFlCQlpCTVlqd0R6WVpMdUsxWTFH?=
 =?utf-8?B?T3J6ZzVjV0VzQXJGb3E3SStJQzQrWnd1SU5oZitpb3VtTkhTL0RWenl4VmJ4?=
 =?utf-8?B?WndLUUMzNzhoS2FlZ2lBWHNjN0pTYmtiekFyUmw0R2VVQlltYUdWQjhYanZx?=
 =?utf-8?B?N21DeUc1akl1VFkwQnM2cit2bTNUdzJ0Z1ovcG1tREdua1N0WlhiTWUwbitU?=
 =?utf-8?B?OW8xNmVxd0crZGdUWnY1NGowcWNTYnN2eUdWeVg4bldlZ1NPWlhKdEVGTkxI?=
 =?utf-8?B?aU1uYWd5dTVOdE0wYXRsM29tTmZzVG5JTTJHbDhFWjhLNmxMaDVRYjd0WWMz?=
 =?utf-8?B?cTBIMTF2U3JDN0hVYVdkU1hudEx0cHA0WERDdXhJRHFOZXBkTXRVZHFsU3pT?=
 =?utf-8?B?TVhVd3ZWZzVISmVOdlB3ZzNsblBQQm1nclMreUhxZ1ZLKzZwMk1oSU1wNEla?=
 =?utf-8?B?ZU5ybW9KdXNJeFJrdlMvZWxuYWU5M2gveks4RHNMMEVpTmphcFprK2dnU2xy?=
 =?utf-8?B?WXJ1dWZKN3JUWHhyejE1WnY4VkpoSEhkRGg1ckdjSFFacG5wS0hSRXZzQTZX?=
 =?utf-8?B?c3FLYWlQRnZkWGRDc01OUE5Edmd2elo5T1VReWNMVWk4TVdFbkxvMnluWEJi?=
 =?utf-8?B?SkgvMGxvNjk4WlJsZTVNUXVGdjNrd2xZUFRWTTBkTXBBRjBrbUd3b0NIY0Rz?=
 =?utf-8?B?YXVLamVyd2tldmo2eGFibjE2bmZKeWlTR3pPblNJbnc0SUhqUFdpWmJjQkVS?=
 =?utf-8?B?Z3N1SExEZCt3dERsc0RUZ3FqUHh1TVIrcFN6NS85ZEtDWldOeXh4aGU4QVhF?=
 =?utf-8?B?eFQyRFlGUjFJMWpDZCtTbDVmcGRkdkwzZ3F5VjVQNmxPNFN1SjE1blBPK0Rn?=
 =?utf-8?B?RXhkUkxodmxuZnRaTnZzMHM4T0lyVnQxZnJDN1hXUWl2S0JvNzFWcENtWDly?=
 =?utf-8?B?M2psT0JabTFVTWNGcERUWGs4T0ZiUWZtbGJNUWd1QzNHdS9XcUtLY2l6aks4?=
 =?utf-8?B?SU4xN0NzZ0lZRlBqOXYya3ZyR2llVHZ0OTRnQ3VVdFNwK01DMFdGWnh4SGd3?=
 =?utf-8?B?SEp1UWk5RUltUmFjWVhTK3h0b2JHenRHM09ybmNaL3ZDUUxiR0llVGVZZ1JD?=
 =?utf-8?B?MGRkaWtnRWNDVFBSZ3pWb2JFZHhwWTl1M0VlUi95WEpDSDd3UVpFTldRL2M3?=
 =?utf-8?Q?jXb3MlEqqnjQL9+39rBDrbq6feyg1gdZZ5Dr3LrCy/z+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee1e29f-ac8d-4504-043a-08da647d3060
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:10:07.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/msGyA++RhpC+sIugJPFO+Mi4S4ccctj62K5IN3g4Ib4+CjpPMkZv+fCJgF/z85FXU8lTZvok9V+1PhZCozyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 21:40, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> Hi Mario.
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Wednesday, July 13, 2022 4:07 AM
>> To: Oleksandr Natalenko <oleksandr@natalenko.name>; Yuan, Perry
>> <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; Huang, Ray
>> <Ray.Huang@amd.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
>> <sashal@kernel.org>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>;
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Subject: Re: [REGRESSION] amd-pstate doesn't work since v5.18.11
>>
>> On 7/12/2022 12:54, Oleksandr Natalenko wrote:
>>> Hello.
>>>
>>> On úterý 12. července 2022 19:50:33 CEST Limonciello, Mario wrote:
>>>> [Public]
>>>>
>>>> + Ray
>>>>
>>>>> -----Original Message-----
>>>>> From: Yuan, Perry <Perry.Yuan@amd.com>
>>>>> Sent: Tuesday, July 12, 2022 12:50
>>>>> To: Oleksandr Natalenko <oleksandr@natalenko.name>; Limonciello,
>>>>> Mario <Mario.Limonciello@amd.com>; linux-kernel@vger.kernel.org
>>>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
>>>>> <sashal@kernel.org>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>;
>>>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
>>>>>
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Hi Oleksandr:
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>>>> Sent: Wednesday, July 13, 2022 1:40 AM
>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
>>>>>> kernel@vger.kernel.org
>>>>>> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Rafael J. Wysocki
>>>>>> <rafael.j.wysocki@intel.com>; Sasha Levin <sashal@kernel.org>;
>>>>>> x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Greg Kroah-Hartman
>>>>>> <gregkh@linuxfoundation.org>
>>>>>> Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
>>>>>>
>>>>>> [CAUTION: External Email]
>>>>>>
>>>>>> Hello Mario.
>>>>>>
>>>>>> The following commits were pulled into v5.18.11:
>>>>>>
>>>>>> ```
>>>>>> $ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
>>>>>> 2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
>>>>>> supported
>>>>>> 3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
>>>>>> 8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when
>>>>>> CPPC_LIB is supported
>>>>>> 13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space ```
>>>>>>
>>>>>> and now this happens:
>>>>>>
>>>>>> ```
>>>>>> $ sudo modprobe amd-pstate shared_mem=1
>>>>>> modprobe: ERROR: could not insert 'amd_pstate': No such device ```
>>>>>>
>>>>>> With v5.18.10 this worked just fine.
>>>>>>
>>>>>> In your upstream commit
>> 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
>>>>>> you write:
>>>>>>
>>>>>> ```
>>>>>> If there is additional breakage on the shared memory designs also
>>>>>> missing this _OSC, additional follow up changes may be needed.
>>>>>> ```
>>>>>>
>>>>>> So the question is what else should be pulled into the stable tree
>>>>>> to unbreak amd-pstate?
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> --
>>>>>> Oleksandr Natalenko (post-factum)
>>>>>>
>>>>>
>>>>> Could you share the lscpu output ?
>>>
>>> Here's my `lscpu`:
>>>
>>> ```
>>> Architecture:                    x86_64
>>> CPU op-mode(s):                  32-bit, 64-bit
>>> Address sizes:                   43 bits physical, 48 bits virtual
>>> Byte Order:                      Little Endian
>>> CPU(s):                          24
>>> On-line CPU(s) list:             0-23
>>> Vendor ID:                       AuthenticAMD
>>> Model name:                      AMD Ryzen 9 3900XT 12-Core Processor
>>> CPU family:                      23
>>> Model:                           113
>>> Thread(s) per core:              2
>>> Core(s) per socket:              12
>>> Socket(s):                       1
>>> Stepping:                        0
>>> Frequency boost:                 enabled
>>> CPU(s) scaling MHz:              59%
>>> CPU max MHz:                     3800,0000
>>> CPU min MHz:                     2200,0000
>>> BogoMIPS:                        7589.71
>>> Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid
>> aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic
>> movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
>> cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
>> topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3
>> hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm
>> rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves
>> cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf
>> xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale
>> vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
>> v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca
>> sev sev_es
>>> Virtualization:                  AMD-V
>>> L1d cache:                       384 KiB (12 instances)
>>> L1i cache:                       384 KiB (12 instances)
>>> L2 cache:                        6 MiB (12 instances)
>>> L3 cache:                        64 MiB (4 instances)
>>> NUMA node(s):                    1
>>> NUMA node0 CPU(s):               0-23
>>> Vulnerability Itlb multihit:     Not affected
>>> Vulnerability L1tf:              Not affected
>>> Vulnerability Mds:               Not affected
>>> Vulnerability Meltdown:          Not affected
>>> Vulnerability Mmio stale data:   Not affected
>>> Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass
>> disabled via prctl
>>> Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and
>> __user pointer sanitization
>>> Vulnerability Spectre v2:        Mitigation; Retpolines, IBPB conditional, STIBP
>> conditional, RSB filling
>>> Vulnerability Srbds:             Not affected
>>> Vulnerability Tsx async abort:   Not affected
>>>
>>> ```
>>>
>>>>> Perry.
>>>>
>>>> Thanks this is the sort of thing I was worried might happen as a
>>>> result of requiring the _OSC.  It was introduced as part of that commit
>> 8beb71759cc8.
>>>>
>>>> To solve it I think we need to add more things to
>>>> cpc_supported_by_cpu
>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
>>>>
>> thub.com%2Ftorvalds%2Flinux%2Fblob%2F525496a030de4ae64bb9e1d6bfc8
>> 8eec
>>>>
>> 6f5fe6e2%2Farch%2Fx86%2Fkernel%2Facpi%2Fcppc.c%23L19&amp;data=05
>> %7C01
>>>> %7CMario.Limonciello%40amd.com%7C96addaab0edc4e22779908da642f
>> 84ac%7C3
>>>>
>> dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637932453099304670
>> %7CUnknow
>>>>
>> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiL
>>>>
>> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4KHD3UUlfDJEmpTpqDC
>> muV1x%2F7n
>>>> j%2F0iuhwdnhJqtQeU%3D&amp;reserved=0)
>>>>
>>>> The question is how do we safely detect the shared memory designs?
>>>> These are a fixed quantity as newer designs /should/ be using the MSR.
>>>>
>>>> I am tending to thing that unfortunately we need to have an
>>>> allow-list of shared memory design here unless someone has other ideas.
>>>
>>> Happy to test any patches as needed.
>>>
>>
>> See if this helps out:
>>
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c index
>> 734b96454896..88a81e6b9228 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -16,6 +16,13 @@ bool cpc_supported_by_cpu(void)
>>           switch (boot_cpu_data.x86_vendor) {
>>           case X86_VENDOR_AMD:
>>           case X86_VENDOR_HYGON:
>> +               if (boot_cpu_data.x86 == 0x19 &&
>> +                   ((boot_cpu_data.x86_model >= 0x00 &&
>> boot_cpu_data.x86_model <= 0x0f) ||
>> +                   (boot_cpu_data.x86_model >= 0x20 &&
>> boot_cpu_data.x86_model <= 0x2f)))
>> +                       return true;
>> +               else if (boot_cpu_data.x86 == 0x17 &&
>> +                        boot_cpu_data.x86_model >= 0x70 &&
>> boot_cpu_data.x86_model <= 0x7f)
>> +                       return true;
>>                   return boot_cpu_has(X86_FEATURE_CPPC);
>>           }
>>           return false;
>>
>> If that works and no one has a better idea how to do it for these systems I'll
>> send out a proper proper patch tomorrow.
> 
> This could be a short-term solution, I would prefer to add CPU Ids check and we can maintain that list for
> all the model info including MSRs and Shared mem types.

What's longer term solution when it comes to shared mem?  It seems like 
it's either a list of IDs or a heuristic.  Given it's a fixed list and 
new designs take MSR, I would think the list of IDs is preferable.

Furthermore; I would argue that if there was another design introduced 
for some reason that takes shared mem instead of MSR it should be using 
_OSC to indicate CPPCv2 support not this list.  This list only needs to 
exist because the requirement for CPPC support in the _OSC is very 
recent to the kernel.

Regarding MSR -
boot_cpu_has(X86_FEATURE_CPPC) indicates the MSR support.  There 
shouldn't be any need to maintain a list in this _OSC override check here.

> 
> Meanwhile I have the similar issues concern for the coming EPP driver, some systems don`t support EPP and we cannot identify that without IDs list.

That will be localized into the EPP driver source at least.

> 
> Perry.
>   

