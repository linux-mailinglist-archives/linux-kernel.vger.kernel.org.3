Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229035668D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGELCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGELCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:02:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E392AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8qiKw36X4HNoVASbHpuYgOUjigMd6FpueDc8l8b6QGyAGMEbmlNpQmY0gF9j7JmYdCRyY2hcJ4PKB/z5yE8rAWkHr+e9bJu5Sufbg00FxcDcAwzA2LjAiV7DpATzD/oEL4pn+tJHYnVVTX2ttj7ma/0bqiKDYvBLx52AVd67u1PDZQArDV12W3l9EqwIZkJZlkA8VP+4geSJvRoi/+mIfKAWImnFkyIeuZNRQqimeu/SgBbwuCgKjRzRhuxrMbJTQKfglR10bw6F9LzlBUdxCvNWzqZjagLfkDwA5HOBtw8621TZRXqxXAxgQ0N3qiwUJpOb7VebfZ9rMKiiTkylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYH1xbiMFY1SnMBh6dliIztJ1za5epjTdSfp6gjPJvY=;
 b=P6ASlxXDZmqMv9buIcJWkMTBlZX+NaD59M6I/gUnyWxGU04HE/mdNlLyNbYb7Bb6DOPHCzo1V3gCt/UBfuX+icEUzveGQ9G2cRV5tISuHk0O3BSM+E0KfHQrNGRFyZ6M10HFGEkyXAd1bDKsfJEt8iXklNGAOvl+nK8a4wFtTkLmta1QzBtWdPAPVVy490gcXu2o+lBS0B3xMgEuOpVv7XcM7HDyMO40XU7eEcAul6UZ4i8xSMgCsEVEIfHAElnjp5+b6H4S4dRBRRSk+tXTSbMRZ+4wngoFrGT931HLj67ChVs3p8zP5A+i1o1qlufj/4dYagrxhuvFo6NDVKWS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYH1xbiMFY1SnMBh6dliIztJ1za5epjTdSfp6gjPJvY=;
 b=qBChq/9HRGZlOAmRSO10GEnRPMA3vbTl+mLSGsoG3fwD4SAbLk30FbDNLqQYj0BP85rmKcWvzacQ3+DWiiZpDNBRUXUhr0K+uDU5oKt2JbYEqasIVg2+tYfZSFEhQziUQYdlTIcg42zc30o9ENO/knV6p3ZdT4jY2ZYpdTewtvTJOy51AS5vA7t0jtc1JODgAYIJZjDrgFQUj528A2RJbOr5fxOxpz2viGSVFjPtWHpwGEJNXLZL200ijS8piaykBAdnMfCE8UM1GSNJ6DOI6u9YoAuQk8jX0oa4WH494yvGJR59FSTswGgRqL3pS/dKdmvoTVrlZeFipAMF+uoiwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 11:02:10 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:02:10 +0000
Message-ID: <b350e874-62eb-7ecc-0cf7-b7ce62e65db3@suse.com>
Date:   Tue, 5 Jul 2022 13:02:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
 <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
 <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
 <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::19) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4b6885-7796-421f-2b01-08da5e75cf26
X-MS-TrafficTypeDiagnostic: AS8PR04MB7688:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5jBSMg+jY3GH6Y2BfxaUTk10LCMT6sU3J8XiiIVc1RyRf2rDWsW97iCp81jNQN0xOSH8jd2TWrWCVk7tkCTP6gwaExnQaCWZWsBdemWjnHW2KrkUgCqaT0BOO6+//qmsxNCW69gsiTG9/h3xAGwgodbKwVP08Rht/GFX25BEnFqZXT/HWMjAHDsh/SOb6k9Un+rygaaXwJDRV9miBhAz7ZlbhyOs9vg9igA2QQpfQyvbRjtXW4snAlRF3kL+Khd2T4zcPTwgbAaEdlJ7EpHwPIL4TlfoXnanDaAXIKdtTYCC8QCah/O1lttozhIbbRs/t1LTWkf8Cy164Itn+n1iVBiWmewlR9saVlyFd/8ZldkkSP+DTGEwJiErzNPBiCpI57CnDw7PCToHUDnTP6Luw50mhqiDnmerv5Ak3ssjPwRmmbWbdKwYOpKVoVh36P1dHj3J5JxQu/0yCTriYL+AU/WRkOYKdG9kaqmwFOq9wp/z5i4ca/CqXzURXsD2ttxJPXYBXdju9Co0jwljuJA4ob9wBggTg7yvyFwuSWJMvRrt8UklHIhWqY1Y/yUFtYwEaSImwB9XbyPoM//r+AzFD58vdk14ZRRx1IrT/cldEyMTMLmNmhvYxb5t6HArbDgxSTL4cJrtYgza+PDRiYYxKYMi5+xaDD2zyOAkzP8D1JkM4wRe57zdzXHdEOfWH9Umu5VoKoKVMWw1Lul9nE+HvRtW3h1jQTG6mveHd7G33nufHv428b2K57YYHE+8kJ2eY986P81mOvneYiphNnKZ8pP3fTa0cu0cliZHvJBVpzsjQum9ocON+CjkcIKO+6hHNJ7f1CIyvU//c8qANRzTO9bOp/xWwAEs+YKkyfwkWAcUMiZhxYoeXW0561nnwlFXIsa6XLuPs+scOrweU5fqX+D5A9uj2ZiYORfPCwY+tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(136003)(366004)(86362001)(31696002)(38100700002)(5660300002)(2906002)(41300700001)(7416002)(316002)(966005)(6486002)(8936002)(26005)(66476007)(66946007)(66556008)(186003)(54906003)(478600001)(6506007)(83380400001)(53546011)(107886003)(4326008)(6512007)(2616005)(6916009)(8676002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtRWjdzY25uYlQ0NVJqakxDcWtnbktUVVlaNVByTVc1VXhzelBWUER1WmFy?=
 =?utf-8?B?RkczY0pvVmZxNTBKVVZVc0RhcTh6QjFZWWFJVHlOdGtnZmdhUkdGT3NXY05W?=
 =?utf-8?B?clRuWmdCTmhpZlNZdzJtOVRJNlJ0d2VSMmxkeVZUZ2QvUmRTR0ZYNE45R3Ew?=
 =?utf-8?B?SUZDR0FPSTd2S3NvT1BqdE92YWV6SFI4a0t1aG00N3VjTEJaWW0rNDBsVlIw?=
 =?utf-8?B?aU5MNm10R01jeHJVOUNtUS9OSG11M1B4M1J6KzRrV3BWdmptMk5SNi9HaFlq?=
 =?utf-8?B?czhuTE1VeEYzdDZuTkdYbFRWeGJKMW12K1IwMnpRakdxS1ZqbmhaeUFPSDJR?=
 =?utf-8?B?OG9jWTBYbW9Bcm9jWUF6ZWxMbHFnWmh4aE9ac3lVM3ZPeXVtcW4xdzlrZmtr?=
 =?utf-8?B?QzNxT1Q1ZkthUG5DMFJGOUhFK1pmQndNWWMzaEpFN2h2bEIyS2I0dmp6TFcv?=
 =?utf-8?B?WVhvMmhXQXpyQ0gvempyeEhzRE9ucFRmRWtjOUxYbWhnajZlajJRMFJ0a01Q?=
 =?utf-8?B?RXh0WGJodm5nd3kvM1cxUVJQOHY5OC9iZVJlTDR1Qk81SFUwNGlSaTllc3Z2?=
 =?utf-8?B?YUEzUkZHd3VQM2Z6eGcxOW51Lzk5Z00rbTZ1a2l3VHpxZFpybHRxb1JDTEFr?=
 =?utf-8?B?U3dBZkJBQ2xXTFlRTFBsbVQzNy9XMWpOY0ZnQ1N0VUFOUjUzSzRlZXVQZVJV?=
 =?utf-8?B?aDRDVlpUb3pVcUxKeDQzTkEzbjREK2xaMUN5ZEI5MHoyUjFTelBtYkpaL1R4?=
 =?utf-8?B?LzhTb25ubkRic2VQQmdBc3JDbzVtUzh1bVlYY1A5Q2NUbzQxbEMwd0sxKzFW?=
 =?utf-8?B?ZitrQ0ZVZGsrc0t1QTZuN3ZRZ2xPUFdrQXN5T1E5VUh2dzV0ODlYM2EreWRi?=
 =?utf-8?B?UGhRRk1oeXgvUUZ4OHk5aDFMMjI1T1QvOEhQL2dBQjkvWTJkclFmckxuY2FI?=
 =?utf-8?B?WWQxTEZnR1YzMlFCb3JqV1FZUWxXVzFOY3Q0RDhXZ3ZnZkRiRnRFNTdFMlJh?=
 =?utf-8?B?M1o5bFhYY3hvd0N2RHpGNnVVVmMzNktqWlRxRXRWNHFOdVBBaEZHaFR2SHlL?=
 =?utf-8?B?VFA4M2Z3Qi8vWVhiaVFITFNLYWFubXBaT2JyZmo0aVdOQS80OGN0R1lOTDNy?=
 =?utf-8?B?MTFXek05alRXMGo2UHEzUHVXci9mNmtkQjJlbFJOVnJNNk9OaHZYVk16MnNt?=
 =?utf-8?B?dnppQXdhUXRrRmNid1Zqc2ozdC8yKy9wNjNBeDZYWG1PR090L24yWnhPa3hh?=
 =?utf-8?B?eEYyaG9jTzd4K3pLUWZ0S084QWNtRFRZUjRuTW54dTdIUWdENlZTcmU3QlVn?=
 =?utf-8?B?UHJhMTFBeTR1aGM5SzhBRkJFeUdWa1JubGIvZG9TN1JYSUR2OVovSDhUTERz?=
 =?utf-8?B?c2hpalVvZVBGeUlJVUVXMmdOREFMVnBqZVpEN3lXZy9UVFlIZlFGZlNQd0tv?=
 =?utf-8?B?MkFWeGVTTmlFMEFac0RqVGVEazQ3M25ZdGZmVU5RRHBRelVJRmpHK3lUWjJy?=
 =?utf-8?B?MmZYaHZVZWVXMm5tdllEdDg5V1pFL0pSUVN3Q1VudnZOV2FFcXRwSXVCOUI0?=
 =?utf-8?B?WnBsZE1iTVRJY2xVUEV2eUM1R2ZGRjd4aXR3MHZxWkNxV3g4eUgyR1NWdzMr?=
 =?utf-8?B?M3d0T2UxTlFzSFZ2UXVvMDlHTHFxN3lWd3B5UFdrSnM3U21aY2F5SVJDNnpV?=
 =?utf-8?B?S3ExQkNRSUVHbTJUNnNHeVVGQitYQ0cycktibHFXY2xMYXV2ZUgxRDl6Lzg3?=
 =?utf-8?B?NVVaNHBPODFkQ0xtWkRGRURXczFHMFVKSHYzdmIxakorem5CQjVaRXJteXJh?=
 =?utf-8?B?a2tnN3hKUHVSRjg4elRsTzhaOWU2NmFRYjZrUHllSXdva1pNeEtqQ3VQUVd6?=
 =?utf-8?B?eVZaYS9IanZDWG01TlRjZnF4SnlWL3huR1ErSVhlOXBQTlBvdWdxRHRlY3hZ?=
 =?utf-8?B?WGRsTlBCOWtuVmJVaXpSNlhpWGVqSHlZbUJqWWVremRKMHNDWTVKWTZVZEow?=
 =?utf-8?B?Tmt3Q3ZZaDR0OFV6cThMM3pXbnRtY3MzdDNaN0Y2aHJZQ3Y5T3p2UUcxaW9V?=
 =?utf-8?B?TlNVbTNCdjdEekg3SGxUL2YxMXBVNnJUVS8xSHZsSkl4SElVS2JZbHNIZ0VT?=
 =?utf-8?Q?/7Dy0FWpOFnIyMKMkuCv4ddKa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4b6885-7796-421f-2b01-08da5e75cf26
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 11:02:10.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci2xg1HmWvDqFGPynUi1IphCiUmHvckIAiu3D8AuwtmUt0m2wGpthU4UKbdGUoKFJvZoFXzOPRMd5JhsPiKYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2022 12:57, Thorsten Leemhuis wrote:
> [CCing tglx, mingo, Boris and Juergen]
> 
> On 04.07.22 14:26, Jan Beulich wrote:
>> On 04.07.2022 13:58, Thorsten Leemhuis wrote:
>>> On 25.05.22 10:55, Jan Beulich wrote:
>>>> On 28.04.2022 16:50, Jan Beulich wrote:
>>>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
>>>>> with pat_enabled()") pat_enabled() returning false (because of PAT
>>>>> initialization being suppressed in the absence of MTRRs being announced
>>>>> to be available) has become a problem: The i915 driver now fails to
>>>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
>>>>> located the induced failure), and its error handling is flaky enough to
>>>>> (at least sometimes) result in a hung system.
>>>>>
>>>>> Yet even beyond that problem the keying of the use of WC mappings to
>>>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
>>>>> graphics frame buffer accesses would have been quite a bit less
>>>>> performant than possible.
>>>>>
>>>>> Arrange for the function to return true in such environments, without
>>>>> undermining the rest of PAT MSR management logic considering PAT to be
>>>>> disabled: Specifically, no writes to the PAT MSR should occur.
>>>>>
>>>>> For the new boolean to live in .init.data, init_cache_modes() also needs
>>>>> moving to .init.text (where it could/should have lived already before).
>>>>>
>>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>>
>>>> The Linux kernel regression tracker is pestering me because things are
>>>> taking so long (effectively quoting him), and alternative proposals
>>>> made so far look to have more severe downsides.
>>>
>>> Has any progress been made with this patch? It afaics is meant to fix
>>> this regression, which ideally should have been fixed weeks ago (btw:
>>> adding a "Link:" tag pointing to it would be good):
>>> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
>>>
>>> According to Juergen it's still needed:
>>> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
>>>
>>> Or was a different solution found to fix that regression?
>>
>> No progress and no alternatives I'm aware of.
> 
> Getting closer to the point where I need to bring this to Linus
> attention. I hope this mail can help avoiding this.
> 
> Jan, I didn't follow this closely, but do you have any idea why Dave,
> Luto, and Peter are ignoring this?

No, I don't.

> Is reverting bdd8b6c98239 a option to get the regression fixed?

No, that change is warranted.

> Would a repost maybe help getting this rolling again?

No idea, but it doesn't seem very likely - there have been ample pings
and alike.

Jan
