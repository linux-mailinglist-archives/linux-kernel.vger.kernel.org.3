Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38053EACA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiFFJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiFFJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:13:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5523BD8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hdn3tE/Z547Pkuyhukwbg+xdTHJ+OMeWaTz3+f2KcD9S8oI1WKP960DWPxQ5v/jfaE0Pl27SiDt9zmA3+pxEIvfxtCk/lhNyE9wS2tqdRFrnHP8Uzq5pVJoPyAl3Q1t0W7hA6vg1hKVjqgeuV6v71/3AkaPFtMkVl3buUw5yyHTiNMXKrfhs2UZ5xZjMUQcuDGBZvhW4eajVYIhyKlyCtIdX5oqB4W9jdSCkxhQjXQJcaJjAwbQFaT30AcMS40Hc8/wLm8fTUnGntCJqNd3nUe1sgkcvUK0zA6C92HRQEwtgVquSIHgoUlJBS1yIQ+1XQhpt/HHeIgWj0qf5ObxnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/+HOIo0IqhE9831f8bx1m8gJElstabVvMdgVprak/w=;
 b=LkPEfBEqsgntwp40NhnzGMqenUx6J8wPwaqG8CN+NCElcjEz8LrCMbE4A7aIp61IEOmAF6vwVzwLOXcRRhbn1oOkOePk2vFdKuPn56txrP6rv4WjuxmFCjx8YCUzmQsrBs3ORzipq1SSWfUrT7TebGzlye9HiOu01Ql2nxIl8tjh4G8UeLD+HDTEEAiqfntpov0ukarLC0ai9MtEQzg7WqG1btUV94kbDCYgyc8D6gpFzDDJwo0XBWLyKmUopvyPXJmntBjVNTysuEYjEQUm/RO0iV2eHeVaybvDh0FF9C3vEEqgcajOF51UsGeQ55T+WVhycNaYrGa24oNz3VxX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/+HOIo0IqhE9831f8bx1m8gJElstabVvMdgVprak/w=;
 b=D3QNeobUb3bXYLsWOmwGjZvj3ghD/LXVNW6OsnGTta7H41texXGEXIPaX+EYppabvwdxZ47XLGcsAG7kS0s/BAN35MHVZaxpETLEocKyj4PTl+7Otyw1OY9MsHboz56oIB1BAbmxII1q3OyNCSIm6VSdCDEwZ6gtJc99xZaHKU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MW2PR12MB2476.namprd12.prod.outlook.com (2603:10b6:907:c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 09:13:30 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::e404:887d:96a4:2868]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::e404:887d:96a4:2868%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:13:30 +0000
Message-ID: <27f2b265-8c5e-5fb9-dfa5-f96f98a2ab53@amd.com>
Date:   Mon, 6 Jun 2022 14:43:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/3] x86: Handle idle=nomwait cmdline properly for
 x86_idle
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
 <7e5a66c4d383652c89a0b5ec0f57e0a95902f810.1653324016.git-series.wyes.karny@amd.com>
 <9dde86ab8773ddf3f9d88a85ed9ee010cdcf50a8.camel@intel.com>
 <f0e481c0-809b-a78a-6cbb-187e27bb9197@amd.com>
 <a1cf42aeb221a857661abc7ac6833bfcedfd7873.camel@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <a1cf42aeb221a857661abc7ac6833bfcedfd7873.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ebbf40-bad1-429a-f42e-08da479cd204
X-MS-TrafficTypeDiagnostic: MW2PR12MB2476:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2476C841A50E94004A9F510284A29@MW2PR12MB2476.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wo8wYCC0QEdBh10Pf8sjz5FR1Qt0TSdMBfNtotTiFQ/NaDqU3tTN9MSiwsgIL3z9RjfJ5krim1a+pZ/3VlMenKbEz5E+R/xGdQkwPqBzkeg+Oaiz69s1DGzAylFz0NSGvalV8Hlb1igHtyW7Kiz+j24OEohq8AT7I7T1BVYHgn9F0X0pTCC457TMNEo/rBDqnWow8VeqsXZaWUiZJORi8qxSWhzqr9xavtVlbAY5G8as5iyW8Hukiy8ZgtSq7oRJse5vsObZpT+qK38aFsfTUSYJs8qDAvCyfHrA/8HO6C9dL5VYIoE7WU93iRBg5hzKmzrxfhltp+Iq2U0i5c0g2ElUn7fxjmgD0ZL3b95+OWEhx2DGR/HLhwWOALK5uRu5DTTEZ04TOtxHTULHFImYfsPjjvJZGx2oUls/e3nh5jjE6ejSPywBUyqG/ivqV2qs9ELVlKnhrrDg8bUTXPTzQMfiKBizcvrQZ28+p8ADgWRjG79fDQm3mMhtpvhTTScJf60uu9J5Ic0sd8T85f/KRjusIP3IIJVvZbbRK61ZckuZkVJw+QsSg/+4U6+YrHx/HhYRNX95Rk5fnC7bO4cDuukJ4ZPGLEjWpJ0zw+oVHZn2MXHcKntYmI2OT1qRCWNdG+DvToecpWI7bBTewcCYgNCUp3wd7yteJqnvFnzy82ZFKgZBxwvEnT2gc0MQDBfdVgsQn2Dggqlfgg2ZJHGtRlmavngN/nEurjmZeibPC8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(44832011)(5660300002)(8936002)(7416002)(26005)(6512007)(6506007)(31686004)(53546011)(508600001)(83380400001)(6486002)(6666004)(66946007)(36756003)(86362001)(38100700002)(31696002)(316002)(8676002)(4326008)(66556008)(66476007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1dIbE5Samw1S251RVUyWFkwRXR3S3RPay9Ga0RCUXFCVzFldWVpUlVwWXFT?=
 =?utf-8?B?b011cXZINFJkaGk0cytWTFdOYkhuL3ZSTVlvOHRqdkZzUG5heFFlcmtvSUxo?=
 =?utf-8?B?QUZCRjk4eUYrYmhMbW9jNG43RVVDalAwcUUxWTRBSzhQS2ZKNUd5enVzZS9E?=
 =?utf-8?B?Q0lsWkxHcUFPSkZlUkd3SzdsQzBmV0VZeWROOENBWGliTE9ZM2RTK0swdjVm?=
 =?utf-8?B?UjZlZ1ZyQVZ2ZGM0R3Y5ZDF0cUdjQkMvTGVpeFJxSVhveGc2bXpmTTJTRC8v?=
 =?utf-8?B?MmJ1eTlvSGxBa2QvQUJmNlVjY0xHd0YvbGZRWWdIK2x5VW9SSGgwTURyV0pX?=
 =?utf-8?B?dVdvck41ZTgyd0VVcjJsdkFWUy8zSi8rMDRyWmRQbGdmZjEzSzhBNGFDZG0x?=
 =?utf-8?B?c3VveVZlSnhqN2tOcG1nRDI1dG5jVldadDQxWFlLS0FoZExVMFA1bGpiMUxU?=
 =?utf-8?B?STdEZDVzMit5endiMzlaaDJxd2tjVHpEcUNaVUthdXQ1L2VRQ3pjb2h2MzNu?=
 =?utf-8?B?dFhScjlrcVEvTFE4c1hsR3Y4ZjZtblFjVU5NelRQOU1LOWNkZ2JmaWxJQWtv?=
 =?utf-8?B?M2QxdHpKQ3M4bFdVeFF5VHQ4M0I0TlRPRHoxSGduUHB4aU15NEhJYjBCUDk5?=
 =?utf-8?B?SkxFNnFsRnE3VnV3TW9TU1gvaVBXVUtTUUQ1ZHdhRFV5TXdZTFo4enlHZS9Q?=
 =?utf-8?B?cVpIODQyczdHVmZIRUJjU3RVRGtvajVlSXY0alRXWVdjR0NDVHo2dGMwTXov?=
 =?utf-8?B?UCtpd3pZc09HN3VQNUlhcDhvRk4wNjJWdFZRWDU5WnNDR3VucTlpR3plTStv?=
 =?utf-8?B?SFRFTHpjNDhRNjR3SWwzMktMMWV2dy9aYU5mSXBxK1NCK1Rqa3NiSVFaMmFs?=
 =?utf-8?B?bEpldkVaWGN1QWtqY2tnQ1crY293WXBrQ1Q5cjVPaTBZT0NuUUlHRlNmREZp?=
 =?utf-8?B?U2JzTitLYTQyQW9wcW1sWEVCNGkxRFJITkVDVUpUbUs0cDE5WU9wSmFzOXI5?=
 =?utf-8?B?V2l0RWtnRzZudE1wZzE3N09OUExoWWI3Vk9HamV6QVhVK0dNM0RoQmhuTWpk?=
 =?utf-8?B?bnRmQzF1bzl2dFV5R2dqQ1FWRENCdVBHd3hsaUxxTzVtRXBHcnRFK2tMeFhs?=
 =?utf-8?B?b2VpVWtTNGl3cHVJRkpWNERVaXhGMVJTMjhWUXBQbDk4NExqTnpQL3JZd0du?=
 =?utf-8?B?cDMyS3F2U1dKMzkzSFFUdWNuRGVnOWJUcXBtOTRqbitaak5Qa2REK0tXbVF5?=
 =?utf-8?B?N1JMUnI3TFdTa0Fya2FjWGVjVlNWNCtsSVp1UU5ob21QMW9vMnE3Rzd6NFZ3?=
 =?utf-8?B?eUNzWGw4OGkyVFU0VjJnNW05dlB3VFNUbks2d2hDQ1poSTVWK0pYczg4NVY0?=
 =?utf-8?B?ZmxRZWRGVjBnMzZtLzk2N3h2cHJISmFjNDFkTjJKRzhaWERyVTgxZ05HNTY5?=
 =?utf-8?B?QnV0M2t3T3dYVUdRSW5WRVExSGg5OXFMRGE4Z3FDZlArS1pVeHQvSDhaOWV1?=
 =?utf-8?B?MGZJU1BaQXB0L0ZmRHhNSmlMQll1TndwYlFwRVlTT1BnWExwOWtIQkQ5aGoy?=
 =?utf-8?B?MU45UmF2dFlaeldsS09jNGZIWG1YUHJKemF1OHFFYTNHR1VEOVd1cE9ZckZQ?=
 =?utf-8?B?ZHVablIybjJyeDdMaGZvZVoraHd4T1o5Z1ZuTUJYUHpNRXJuNHhEMWE4VVpk?=
 =?utf-8?B?Si80OWhKZFRDcmtRTjBDaFdQcGJyK2dMaVM2U3ZHK3ljZTRwN09KT042dFgz?=
 =?utf-8?B?K2JrbTkrYW9yWFQrREtYcFBTcVg0Y1psTTBxT1dWUXl3Z0ZOdUIxOGRRNFd2?=
 =?utf-8?B?cmVaVXFJazRqKzVmUzZGQ3VNS2lOWnpzNUUyODc2VWJKNERQVHlNd2tJek0v?=
 =?utf-8?B?bHdmR3k5d3l1WStNU0R4dFl5K25LZWpmNWJXWitGRXFNWElZRFZjbjdZOXVG?=
 =?utf-8?B?dTdzU0ptd29kSllRT3FSb01DZDZZMXNhQzZVaHAvajNZUHd2TFc5WnlFa3Zx?=
 =?utf-8?B?NFdIRVY0TnZEWS9XaVdWL1RnMkE1cnNIdk5idWF0VWEwOHBPclM1cTBFUWw5?=
 =?utf-8?B?NW5XT0IvemJtWDdqc0M1bFdhazdUVnlhdW1pdlpPT3AzNDQ5Sk5qYkxHb2lV?=
 =?utf-8?B?WjBGampxUERIWGJWM1F0TUpnWnRjQXVobFAwNDVRWGtTMWZRTmNrdEdWbHBi?=
 =?utf-8?B?MFdBbHlEd0wrMzFLUnQyRW83YVcrbGoydVVjQkRXMFh0TDdMdFE0YW9BVC8r?=
 =?utf-8?B?dWlzQ3FQTXJZMmR6YzRva2NjU24vR0JUUVhnbGxZRmFLZ0RPZjNKUTJuSG42?=
 =?utf-8?B?Y1dBUEs0YTFBMWZxRUt3NkhLQWNNcVJzckpBUmdsR1pIZ2hkMWZnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ebbf40-bad1-429a-f42e-08da479cd204
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:13:29.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErnriSV15OkfoWAGQo3UGsMonEZTiZ2LCdKxGYXWb7MGP+jjN+EH4nxknkFjZpGg9YCNtNsZD0YWyZlrVWAZtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2476
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

On 6/5/2022 6:02 PM, Zhang Rui wrote:
> On Thu, 2022-06-02 at 21:11 +0530, Wyes Karny wrote:
>>>
>>
>> Hi Rui,
>>
>> On 5/25/2022 1:36 PM, Zhang Rui wrote:
>>> On Mon, 2022-05-23 at 22:25 +0530, Wyes Karny wrote:
>>>> When kernel is booted with idle=nomwait do not use MWAIT as the
>>>> default idle state.
>>>>
>>>> If the user boots the kernel with idle=nomwait, it is a clear
>>>> direction to not use mwait as the default idle state.
>>>> However, the current code does not take this into consideration
>>>> while selecting the default idle state on x86.
>>>>
>>>> This patch fixes it by checking for the idle=nomwait boot option
>>>> in
>>>> prefer_mwait_c1_over_halt().
>>>>
>>>> Also update the documentation around idle=nomwait appropriately.
>>>>
>>>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>>>> ---
>>>> Changes in v4:
>>>> - Update documentation around idle=nomwait
>>>> - Rename patch subject
>>>>
>>>>  Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
>>>>  arch/x86/kernel/process.c                |  6 +++++-
>>>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/pm/cpuidle.rst
>>>> b/Documentation/admin-guide/pm/cpuidle.rst
>>>> index aec2cd2aaea7..19754beb5a4e 100644
>>>> --- a/Documentation/admin-guide/pm/cpuidle.rst
>>>> +++ b/Documentation/admin-guide/pm/cpuidle.rst
>>>> @@ -612,8 +612,8 @@ the ``menu`` governor to be used on the
>>>> systems
>>>> that use the ``ladder`` governor
>>>>  by default this way, for example.
>>>>  
>>>>  The other kernel command line parameters controlling CPU idle
>>>> time
>>>> management
>>>> -described below are only relevant for the *x86* architecture and
>>>> some of
>>>> -them affect Intel processors only.
>>>> +described below are only relevant for the *x86* architecture and
>>>> references
>>>> +to ``intel_idle`` affect Intel processors only.
>>>>  
>>>>  The *x86* architecture support code recognizes three kernel
>>>> command
>>>> line
>>>>  options related to CPU idle time management: ``idle=poll``,
>>>> ``idle=halt``,
>>>> @@ -635,10 +635,13 @@ idle, so it very well may hurt single-
>>>> thread
>>>> computations performance as well as
>>>>  energy-efficiency.  Thus using it for performance reasons may
>>>> not be
>>>> a good idea
>>>>  at all.]
>>>>  
>>>> -The ``idle=nomwait`` option disables the ``intel_idle`` driver
>>>> and
>>>> causes
>>>> -``acpi_idle`` to be used (as long as all of the information
>>>> needed
>>>> by it is
>>>> -there in the system's ACPI tables), but it is not allowed to use
>>>> the
>>>> -``MWAIT`` instruction of the CPUs to ask the hardware to enter
>>>> idle
>>>> states.
>>>> +The ``idle=nomwait`` option prevents the use of ``MWAIT``
>>>> instruction of
>>>> +the CPU to enter idle states. When this option is used, the
>>>> ``acpi_idle``
>>>> +driver will use the ``HLT`` instruction instead of ``MWAIT``. On
>>>> systems
>>>> +running Intel processors, this option disables the
>>>> ``intel_idle``
>>>> driver
>>>> +and forces the use of the ``acpi_idle`` driver instead. Note
>>>> that in
>>>> either
>>>> +case, ``acpi_idle`` driver will function only if all the
>>>> information
>>>> needed
>>>> +by it is in the system's ACPI tables.
>>>>  
>>>>  In addition to the architecture-level kernel command line
>>>> options
>>>> affecting CPU
>>>>  idle time management, there are parameters affecting individual
>>>> ``CPUIdle``
>>>> diff --git a/arch/x86/kernel/process.c
>>>> b/arch/x86/kernel/process.c
>>>> index b370767f5b19..4e0178b066c5 100644
>>>> --- a/arch/x86/kernel/process.c
>>>> +++ b/arch/x86/kernel/process.c
>>>> @@ -824,6 +824,10 @@ static void amd_e400_idle(void)
>>>>   */
>>>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86
>>>> *c)
>>>>  {
>>>> +	/* User has disallowed the use of MWAIT. Fallback to HALT */
>>>> +	if (boot_option_idle_override == IDLE_NOMWAIT)
>>>> +		return 0;
>>>> +
>>>>  	if (c->x86_vendor != X86_VENDOR_INTEL)
>>>>  		return 0;
>>>>  
>>>> @@ -932,7 +936,7 @@ static int __init idle_setup(char *str)
>>>>  	} else if (!strcmp(str, "nomwait")) {
>>>>  		/*
>>>>  		 * If the boot option of "idle=nomwait" is added,
>>>> -		 * it means that mwait will be disabled for CPU C2/C3
>>>> +		 * it means that mwait will be disabled for CPU
>>>> C1/C2/C3
>>>>  		 * states. In such case it won't touch the variable
>>>>  		 * of boot_option_idle_override.
>>>
>>> the code didn't change boot_option_idle_override when it was
>>> introduced, but this has changed since commit d18960494f65 ("ACPI,
>>> intel_idle: Cleanup idle= internal variables")
>>
>> Could you please clarify bit more why the commit you mentioned is
>> related to this patch?
>>
> 
> The comment "In such case it won't touch the variable of
> boot_option_idle_override." has been broken for some time, it is not
> related with this patch. But given that this patch "Also update the
> documentation around idle=nomwait appropriately", so my suggestion is
> to update it altogether, by deleting the last sentence.

Sure, will do. Thanks!

> 
> thanks,
> rui
> 

