Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FA5312D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiEWPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiEWPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:49:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09B3EBBD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=licN+6f/3vdruR9xJ/wUdOPZ9Wjx4XPw5yRFBqYz9/CgkqNJscR3TNY2vd1IgjcAsoC+aJryVhyOHFYP1iyl2JQicGjJ+cbSpx/EuL3p0YriDKqvGCczAvMpOw2SPtVWIKe713dATA0dRnnlIsZA6koYxlY5KyJXRMyEC+wGgknQgTNXKfPzOLvxX5v3yD9H6SgcFC9Dlr8B5wjrpvwS1PY3y8ooB5aPdRNbQjBi0z1vWlOdlOLG43VdJIdHqwojttoA6zyoLiYWfM/l/BHp6wisYOqJ/3gL2GczJkvsa9TcYYoMp9frqAU/8DKulgrP9MU4qWbtxiveeSXP9RULMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cf3Dq1DM7KKXdwPbloDRjYQ7LEcmTCQBN30hoMr0e4=;
 b=G+pMNixjBR6/AhJ61M9reoas0FX2DxyjYYtpR8xHF8Sh7c6D5KYwHNJomNtCRWthzoOXj1zywNYI5DjkPLdNUfHa5ZdJ8QaShwWS/uBMCc8MoMzMzrEMEqEgBlQ6vMb/bLrpCT3qGEv6l4PwGuA8fUSpGxLxJ4Zc3t/YyrP1aZEDUMxKAPu69Oe33/gOIXq2MzRssJy1i+fzHjcheJ86XDN0kfOqsTqYJ4xvtPbSVwtEL2oMQRO3qLZDg8CzrdEkMRLX2VPfbfDMtJgEOmWvZmu+sSXQ1tbIYZNXW06Y6rJ7eot41tD5fguljxa+STy57D35mgfsvrUFZ9u6jHGz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cf3Dq1DM7KKXdwPbloDRjYQ7LEcmTCQBN30hoMr0e4=;
 b=JnHkLckry7UVGd5ulwzWuEOH2vSfRcn5ERCtX+3EJWPk/yOtE16pUZHMgTAYoLHrdy+zYfWmoHBtSuqY5+Vh2hhozj6ltiSfTIV/PK6pV7FMsdDqhMXUNv/HWooOVBsD2+NsOCIFoaFibgJmTJv71zcKKlcduoEMgZ4RlFLriNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 15:49:41 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f%6]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 15:49:41 +0000
Message-ID: <f1872469-8a4d-5300-2367-0f56fafcb0de@amd.com>
Date:   Mon, 23 May 2022 21:19:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
 <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
 <b1c9fd6c-9f00-9662-d590-b52ce26d0aca@intel.com>
 <410f36ccecb36644e196d71fef6e46bdc186b409.camel@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <410f36ccecb36644e196d71fef6e46bdc186b409.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bb4a0cd-e6a6-4794-4952-08da3cd3d991
X-MS-TrafficTypeDiagnostic: IA1PR12MB6412:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB641240A651BD1F01D7A60F8D84D49@IA1PR12MB6412.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWMLsD/AmhMFgRNfaJXijwb3hbcu97yIwNZvWu2I/61a4Dd0U0iTFqOrPLwu2/1O/mBvxuuwepJmDBWZ62dsGvMxBaCb3g5qof+VQSxXecML6An9MlSEqrEmBy7S6xZl2tZSm6kqk9qsMNOLmszVAhOT4fH0pmEiUwFavq8YnvSepqyl9CVUoHH7t8cghAIUjXMwpfgtu2H1zRxpzXxtYx0/PNljmaykLYP/ztjpBtIPEI+XIFaKiLpSjOdXGtqC0S93/Xupyk3HneRW1nTnjeVts6nHzI4zUM8AZ+xEfknxb66hA6MimHlHAdzMTkeRtRfLH6VXekfcfZNik4BP0BUy5HPHqu+o5lO2bt9DxR3v/+a3RAnrpZmtdoNeb80OJqfbFuZujceiLqZnSv/apuxV7COgJ8HSMIw86R7izoxF3jhzXIpzWO+IHQF7C54mp+yH9iQEHcRjIBR9tyIEJYDoH+VJyrVfFue4Yeku6V4M+mefUvfQJ/8+mUGnUSEwxwYZARlRChxuyoCEtlDO3enkTv2LE/Hyhjfca0WjAjZ5zqJ3h9DW/2TCNqhMA3drxkxpsQnK9C1w9OPkv6TXircDCMhfkTQPAmKUM+OhTkpqqbrHwhpCoQFnSQOoA/4cjCo2r+WqomTJwJf5qnkomxfRutkoZNvE4pZhs2x72yPE2Fv8Oiz/zCOs4lwTfziqhSQqEK2M9j/n0GblXgBZzqgpczHUfdA2ETXiLV+YCWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6666004)(6486002)(6506007)(26005)(53546011)(508600001)(186003)(2616005)(38100700002)(5660300002)(110136005)(7416002)(8936002)(44832011)(4326008)(66476007)(8676002)(66556008)(31686004)(36756003)(2906002)(83380400001)(66946007)(316002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmsrMWdMZ1cwZFMwVTc3UGg1S2JGQ2cvYkd1VS9UY1BJbk1CbnJ5K3J3eFgw?=
 =?utf-8?B?dEFacUlUaUl2ZE9UTTcyT0xxSWNDb2ZreW81bnJDOGlCU3dsNytrMkxrd2xq?=
 =?utf-8?B?azNnT2FZUFUycGhhM0psZU5ES1NnV1c0ZmVOem5rYXkyUmxVcUNLV3NURytS?=
 =?utf-8?B?a1p1ZTZkbWc1RHJvQXROSDBQNkQ5QW9IYVpNbTJyblVYVzNCaXpZN1pOU0dV?=
 =?utf-8?B?Qzd6U0w1OGpCd2FzS3gzU01leVV0RUxJQWFJeDMwODdZSzFxSUlzV01LUzRv?=
 =?utf-8?B?aExQQ2U0YnJnSEdoTUFSYXhJek42cUd6Tlp0bVpZaXlOS2I4WUwzLytVZ3h0?=
 =?utf-8?B?TXNPUUd4R2R1QVVGWU5mVDM0eHpMT2l1RHpkMnBvb1BkZVVLVm1Eais1VUg3?=
 =?utf-8?B?UUhxYWNnS0QrVlRxNVFFTWtGdG9nOUtaOXg3aW5qSmpqY3A5cDl2aUczY3BZ?=
 =?utf-8?B?cGRGV0RyWkpBa2xNcnRFZXBMajIxZk5UKzhuSWxYOE1EbjFwWk0rQnYyK0xD?=
 =?utf-8?B?U0RSaGwrY2wxVlFYdHg1YS96bG8xTjlOdnp5cThjc3pzaitBV1YwaTZjbmRq?=
 =?utf-8?B?dktlcENWSnBLR3poOVJQM3hEb0lzckdDOGVUam5SaHJydmg0cy91eHVDR2Va?=
 =?utf-8?B?dk9kcEE5ekhpVFhyVi9WZit4Ykt5TEQ0ZHhpci96QVBjcllUNHI4cTVCZ3Z0?=
 =?utf-8?B?WkM1OXpwRGpYZFN5U2djOG9UMU95OFUvdEVla1BJczR4OTFndm82aUtXcXcx?=
 =?utf-8?B?WHBaU1BwcEtNRGZoRmt1REFsaC9ZTlhnZG9oc2xNbCtMS2huUjU1Q2FQb2Jq?=
 =?utf-8?B?RXhpNkNjNVNtQ0x5ajJGOS9IbWppais3WGEvaVpxMjBDRk96cGxJQS9mRW50?=
 =?utf-8?B?bUVEL1hhdHIvMDlqd0FtcnRzdU94SDhHTkVtN0E3ZmNsdmIwM0hVZU81Wisy?=
 =?utf-8?B?K0ZuUEZBZVhJTmtCQSt6cHBqUkVuZy96OVh6RUFZNEJBK3pHRStQSFdjdkNt?=
 =?utf-8?B?V2NENVg4ZUFxSmVCK0J4WThNMnU0RUdPZHNZVGNlNkxuQVI1RjJQOGE1bVl4?=
 =?utf-8?B?bzBmb0sxbi9CWmtRbWVBcXdSd1ZmbGtpVFhYZ0NCM0dubmlKU0VnZk1QTklY?=
 =?utf-8?B?eXA3K2hiUmxhQmN3Rzd3RlllM0JlT0hqQzYwaFRGcG1LbFBSajFJVmVTVFE1?=
 =?utf-8?B?bWdvRXQxQ2REeHVEVTdDaDNkY014QnZ6NEp5NVlqMmh4N2NIYy93Sm5YMm9S?=
 =?utf-8?B?ZkVJc05vbEdQZDNJdUpJNlVrTGljdzU1R1ozTlJqcFRpcm9admpXeDlHMW5s?=
 =?utf-8?B?c0h6VW14WG9kbGRjMjBoa0sxenFubG1NTHBrNFFGR3VFajVVNzQwM0EvZmM3?=
 =?utf-8?B?VHFmcjBUK3RiRnpLbCt4ZnFlMWRiK2h1QVZyQm1aRVl2WDBIVldwMkV2c1lo?=
 =?utf-8?B?RDN6WnR0MFZiWFNseVpPUVQ4aWRTcitTaVhERUUyYXNIVUZ1dU96NzhhRXU4?=
 =?utf-8?B?enVnckFGcXkySTlUZWhNTU0wZjdEUTVJNjNMZ2NiaE9xcTZpbVY2cXFFaE9a?=
 =?utf-8?B?NmVxTFBiamVwU1NuU2w5N3JuYVFSaWRlbEY0SENUZDk3SVR5OVBLOU9zUkth?=
 =?utf-8?B?WkpwNDBHUGpQQ3NOYzY4bldyOEk5REc4OFB1TWMrY1RjSlFBWEVkQTVmQmFO?=
 =?utf-8?B?dWJKbWQza2hnR2Jqd3RGMWFsR1N2SlpGUXl2bW9wMHJmeXRCTXRLUEpiaE01?=
 =?utf-8?B?YlltcitZNVFmd2pNQStveHpoMHU0dWFXMkhreWNUTGwwZlg0Q3hkVDJmV1RX?=
 =?utf-8?B?SFl6VStKMUk1dGxOQWF0MktER1BVdkh2Ymdtd29CTCtXcG5JcHU0N3VhZXUz?=
 =?utf-8?B?MG9pWGNGSVJsejEvNHlUbkxkREdCL05OeHY1QWJSQXFuZWxmVm0rSG1CR25T?=
 =?utf-8?B?TEpoY09VMzhJQitWZjVlSTkxcUw1SDNtcHJMK2s3Z09zbm8yZ29mT3VUZEpn?=
 =?utf-8?B?Y1p2NnMrMTRYeUJ2SGpSWCt1WUk5ckQ5TzVtc2Jmdm8xaHlLTVBrODVmeDFl?=
 =?utf-8?B?eW12Vjh4OUpaMGRGL1FZK0hLUUc5MjVwa0YxYmduMXEycG1aWmtPbS9RTUN5?=
 =?utf-8?B?dkFDekEyUUpwMjJxajRiT2lubGxGWlNwY3BiSk1wYW9rK0dxbHpnZGhPbUdE?=
 =?utf-8?B?M0dEektyYzRSWG5OZzJRTzZ2bEtycHpQUVdtNzFCcTdRUFQ2ME5Eb0lleVFa?=
 =?utf-8?B?anhYd0NEbjc3VTl3V3A4WFZkZEVQUjFOWkZKMFlSMkpGKzBiUmRYdUtiRDNy?=
 =?utf-8?B?Z04yTlRWeDdpTXJXVmNpSTlmSHdpNStxeGE1SHBzTFJnUitHR256dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb4a0cd-e6a6-4794-4952-08da3cd3d991
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:49:41.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBAobdthASoirzS5FSD1zrUUPO2pl2U+mJ3taLl6uTsw+CKYcHIP5Tz1DB56PWxfBF5XIVgjfZzuzwkIu6f74g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

On 5/20/2022 7:13 PM, Zhang Rui wrote:
> On Thu, 2022-05-19 at 09:00 -0700, Dave Hansen wrote:
>> On 5/10/22 03:18, Wyes Karny wrote:
>>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>>  {
>>> +	u32 eax, ebx, ecx, edx;
>>> +
>>>  	/* User has disallowed the use of MWAIT. Fallback to HALT */
>>>  	if (boot_option_idle_override == IDLE_NOMWAIT)
>>>  		return 0;
>>>  
>>> -	if (c->x86_vendor != X86_VENDOR_INTEL)
>>> +	/* MWAIT is not supported on this platform. Fallback to HALT */
>>> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
>>>  		return 0;
> 
> I'm new to x86 code, a dumb question, what about the other vendors?
> with this patch, prefer_mwait_c1_over_halt() can return 1 for other
> vendors as well?

This decision tree is based on cpuid features, so if the processor
advertises MWAIT C1 support we would be choosing MWAIT.
If any vendor wants to avoid choosing MWAIT (even cpuid shows MWAIT C1
support), they can explicitly mention. Will add exceptions form them.

> 
>>>  
>>> -	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
>>> boot_cpu_has_bug(X86_BUG_MONITOR))
>>> +	/* Monitor has a bug. Fallback to HALT */
>>> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>>>  		return 0;
>>
>> So, before, we pretty much just assume that all Intel CPUs with MWAIT
>> should use MWAIT C1.
>>
>>> -	return 1;
>>> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>>> +
>>> +	/*
>>> +	 * If MWAIT extensions are not available, it is safe to use
>>> MWAIT
>>> +	 * with EAX=0, ECX=0.
>>> +	 */
>>> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
>>> +		return 1;
>>> +
>>> +	/*
>>> +	 * If MWAIT extensions are available, there should be least one
>>> +	 * MWAIT C1 substate present.
>>> +	 */
>>> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
>>>  }
>>
>> So, I guess the "If MWAIT extensions are not available" check is
>> consistent with the "always use it on Intel" behavior.
>>
>> But, this would change the behavior on Intel systems that both have
>> CPUID5_ECX_EXTENSIONS_SUPPORTED and do not set bits in
>> MWAIT_C1_SUBSTATE_MASK.
>>
>> Is that a problem or an improvement?
> 
> At least Intel processors since Nehalem have MWAIT C1 support.
> For elder ones, need to confirm with Len.
> 
> When no bits set in MWAIT_C1_SUBSTATE_MASK, it means MWAIT C1 is not
> available for some reason, let me check if I can make this happen or
> not in real life.
> 
> thanks,
> rui
> 

