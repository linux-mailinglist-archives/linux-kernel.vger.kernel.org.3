Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DE59DB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353480AbiHWKLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352138AbiHWKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:04:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA1A262C;
        Tue, 23 Aug 2022 01:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjrZ/vSQzbuW4EJeWAauRW3mjb/1nAMp0yF73L/IdyBtxpEhmKqnQ6iw7xpdAM0lZnDW2T+eIH5OPXwpyA0TrMcMo5lA7yA7ukoi3HLhXuzQf77upt/gQa8eeUz8b6yZZXR9m0PEt5785e3WrnVat2m1h/5I4nVxlXwSM6uuHX2XNDeVqY9lQYYHrRakxWrfe4/pjpY09wU2LFI2kOHdWb6SVbBtGz9eG88n2uw80QS4xj/mwJj1Hh84Ysc+F8m+DiJHb0AHoWi360pxzX4FHxThwX44OnUZlDlg/8P/D4qpTP1xc+asQZQJkmyUyVCkE+ZcZ9xNAkh521QhZ4KB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHwPl4b0vD4T7mKkMsu7560cfg05msydghxUHFq2dTU=;
 b=fC/Pe6XxtCXiUjH8hQZz2KO6qBKOJiRtlTYopLL76ZAJE5GysFonrIN29a6RBkyLYr3hfXpqe6vxnTAGUTAIDdwbxgyrhysmWdyLbFZ0RbIE/SYXhSL2OC9BZzQujPZu6EzErV274JqHAra2h9REOw3tPrlJiP18SDb9p1kkBlafAw42qQ8neodwfCSUPo/K6pgGN7sz5KJeHawzsu/en2asUyjseYNWJpeqgRnRb6GBhjwdCL4qVZsmj17x2yPJik4IqK8rhrpcgHjpDyHo2yr4zGZ9AMosYQzRR9kmgB4gWWqTDavdKmOpupfjwAW2vR4RrzqnQzSSn9egX9DKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHwPl4b0vD4T7mKkMsu7560cfg05msydghxUHFq2dTU=;
 b=2eVJrDyzRQtueaF022XHdS+bTiZaLu74IAJFcfpmE3H9TlhrPXzPus9N8EhjHcws6OAJZuAgcBr5SqtRNDhWlK4iMaiZicZAXZH0rZhKICe8Rrp8WzKamzLSU+PiGem6ModSezOdLWTR0lu7iNZn21CY4Vsri51S1BPARa5m538=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 08:51:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b%9]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 08:51:22 +0000
Message-ID: <91cc5c2b-75d9-1b2a-9ad0-a94a60ee72c2@amd.com>
Date:   Tue, 23 Aug 2022 14:21:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, acme@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, like.xu.linux@gmail.com,
        Stephane Eranian <eranian@google.com>, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
 <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
 <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
 <YwOEIESeDSuekmf8@worktop.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <YwOEIESeDSuekmf8@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::33) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04ba582e-1c84-4d3e-b7f0-08da84e4a6f9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h90+fyCNyRc86hAYVRqG3KnhWSVpP001ZpV+dnycn/YQ8xdWlWlKbE+s1uGfhlTrvHiyjiMYy8Mpzn4rmoCWguH+LiL8p83x3DbGxAJbQ+p8g/INAsGcL3oKbd4obdt7HY2eSM4qeVQ/monvj/qc4I47k3dx+N5/mF38XXAuC4rbTC+O0mBpI+Pw5AOJ+AEHLoD2YS+WJkqHRycemQOLq81YMc7q/meumSWAILbyzntKKBJ8Z8RgO3gGisRT8P4U5Ya+hAf8nfrEixcwQvJCm70Xvut3SZvslJb8Rifu9vantVIAhPbzD1dQj6MHoxYUx5+njWUnGdpRBj5m6u4dGINS6ZtRUTbUelvpuIZu12N+pUvZSVbUQrD2yqbBv8xB4Gnfo8BoESwJkoG8puSfsmcw6901olty3cNl17lYRNY6DJKoQ/u6Uemk82aLBA6XiSMkDhX8trB1rFP+hVcgLap9SNN/fockuM4/I1HNtB2/yf0lYHUYMxLxhwYDCVL8FbcoCtdCFOHT209MDDtFmMDqhTXaLnv4x9mRrteOPyVRfV00rBfFZ1kR5H8m2hKo9rFGTQhfB59BVXuZmA3l0o1hXxDPLlazMx4//+xJWHFIc5AvFCmz6hSI7LzsxxcNjn3kzSU9622l/CmTqsQtKyA5y//vcHYs4F3GoXA6ZNiM0NP66lqyj6g4xfy14GoZWeM6YwU+7WX6QlyDsPVzSrndHTMxgP01UX3oP2iRFLr/PIkws0oYNyojGW9EVqAW6xpqXnYQauolgVRnVra/fHoyrJJGvmzTficwOqZ95BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(26005)(6506007)(6512007)(186003)(2616005)(8936002)(6666004)(7416002)(6916009)(44832011)(86362001)(31686004)(31696002)(53546011)(41300700001)(5660300002)(36756003)(316002)(66946007)(66556008)(66476007)(478600001)(4326008)(6486002)(2906002)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRlVndIOEExK3RWVDBkZkZJaFVRbjkzYUQ1cU9WdzE0L0R1RDkwZGFpelZh?=
 =?utf-8?B?UnpnaWE5UVBPcFBTM2FmQjU3dWROT1RSM0EyNFVidmN3ZUVmeTN5SWhyTlJP?=
 =?utf-8?B?Q3BaczZaVzJQMWU5UmVjOFVWcTA3UmlqR2lzcXo2dXVpOTFjSUxScjN0dExI?=
 =?utf-8?B?ZFRXSi91Tll5WkxUSWpaaXlXV3pwZmFmaDJkRWtKV1IyQ282U0VpbWFtaU10?=
 =?utf-8?B?ZWZVYy85OWV4L01sVnUraGxaSUxCNW5YTVhra3VqVjc1OXB3aVlWcktZWXFz?=
 =?utf-8?B?YlBYK3BTRkExL2tWWVdZYUxFbHZFZEFaT0c0RytJUVEwbjBpVGJQdTY3WXps?=
 =?utf-8?B?UmE1MncwV09Pak9pb1RzTzhjS2hBTlRycmtuaVNOa3UwZmNUVlRXWnllRDhR?=
 =?utf-8?B?TlNORENrMXljZmdYR21GdkNEa0x0cUl4Szg3bms1dHFoSkVnaCtMRkxLZXFH?=
 =?utf-8?B?UHVUbHp6NHZGcVVpZTZVNlBHQW90bzFSaFlxOS9Vb0RuVzdNNHRnVk1QeVUr?=
 =?utf-8?B?UzVtNVBqUmw0LzFBbkgxVnRXV0pNMnU1akg1eFVnNElQUWZydURLb1ZtUEo5?=
 =?utf-8?B?cDhPWWtYb0NhTnI2a0JMdFIzRFFQc240VmdUZzlLM0F0OFM0RHlCeG12NFpq?=
 =?utf-8?B?cHFYMGNoQ2NycG5qMitqRXpuN21zWDhsNlJsZFZlZDVNdnhiRW0vZnBPZy9O?=
 =?utf-8?B?aHJDUElXTFgrTUczaHV0MU9uOHRKV1o5aElCV295YmhhWkkrZERJdmxzK09E?=
 =?utf-8?B?WmlZVmg5TUlBYkRDRDdGWnhnUzJHRjJWOW9YOE9VK1hNMDZPNFpscFNwSTdK?=
 =?utf-8?B?V2c1Mys1RmxpTEtjbEZhemFYNDI5eitvdFJDSzBrYjdMVTVlNmV3TndVckFn?=
 =?utf-8?B?RTdjNkdQZkNPVzV6RFFWTzBOTnF4WnJ3ZVJabXRhM2xMSHVCSmhXdVYzNUVh?=
 =?utf-8?B?STR1dXN0NktkSXBGL2Jjd0RlNnpiVEZDY1hEZlpsK2ovSjk3cG5INGIvay8r?=
 =?utf-8?B?WVlKemV1emZ0ckZjU0h3Qjc3NHJ1NVYvcnJINTFNWHFsK3ZRRTJzb05Oa3Nl?=
 =?utf-8?B?b3VUdjErWSttbHVSS1FnVVN2dGJFWE9Ba0lQRGcrRDVwRzlwM0ZZa1ZRWDdN?=
 =?utf-8?B?ZjFBcXFtdTJtTVNSYkpSc0VsSmhUbzd4U25nb0xrbGZvSnRKaXhPRHVFTnVK?=
 =?utf-8?B?ZVFxSEhYVTVjTEtlVmZYV2tFdzlCNHBGMHR1NU5jZzBoU3EvVnJEckppL2E5?=
 =?utf-8?B?V2JPWnhQMmtDRkt5Ujd4ajVsd3QvNnhEaVQrS2s3NWF0THBRL0g3OExiZXp5?=
 =?utf-8?B?NU8yUURQMXlpVTJPSyt4RHpMWEhjei9wSXJXRXhsTis3YTI3ZS90ZUpYNWJi?=
 =?utf-8?B?QmxCWTMwUjJFU09NZ1JyRFBIY3I0Z29CaUVNWGtjcFA4QXZxV09Vekh5aDNX?=
 =?utf-8?B?UlVGbk8zOEZodG1hV3dKN2tTbkZKY2F4WTN3cHlmNVZhc2N3NUZjV3ZaQnJ0?=
 =?utf-8?B?OGVzQ05SdllxZVhPR1llTTZXQkxpeTNlKzRTU3MrZS8rd2w5YUh0RXJBYjJj?=
 =?utf-8?B?Q0dkYUF5TEFHWW9FMlY5TmYyME5IQXU3VkRkNnE3aU4za1lZTHM1eUVXQ0xE?=
 =?utf-8?B?VGd2WVNBKzZ4UDlrbkRpdFNKQjZXbXFQRUpocVI4cUtEU2xXaEp5WmdzdmFx?=
 =?utf-8?B?MTliUk1TT2NhWU1MR0NXVHBrRjdoWEhVY2tTSktsYmlGVDVVbnNlQ2FsUjZO?=
 =?utf-8?B?ZlBtZDE2TkJqcldFa0dZVDBBSGtDYUp0V1ltZHkxc0NZMGE4TFhmdlM4aExX?=
 =?utf-8?B?MFJudlpaZGE2b29rR2UydlF0NERyUFlKb3g1cjcyclIxaERXU25BK2hKYlN1?=
 =?utf-8?B?TXRjNWhlR21QWkw5b2VhUjRXM0wxZWNTbkVvaGRoTFEvdVo2K3RqMzlqUTVP?=
 =?utf-8?B?RGZ4b2tBcjhQSktFOGdtNVZaRjY4cTVUQTFYRjZGa0JaeUc0aExicHcvcVp0?=
 =?utf-8?B?dFlLbWJsUTd1bzJqWGVIWnFWOXVQZVBOZzVOSWE5am12MEdlcmpkNnRCU1ZS?=
 =?utf-8?B?QXBvVHR1L3E2U09IWmFEdHcrbldGdEptWTRPSjRJbitqUm9tUUM3TVR2QUFL?=
 =?utf-8?Q?O2db+sW8H78FBWCBn5Fu2gi38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba582e-1c84-4d3e-b7f0-08da84e4a6f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 08:51:21.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/6mlsoAjR9t4OTQIp3BguKE7f4iSM3CWGl+7dbS6oG81Z0pWRl/7a0IgqbAvH5gvrCfKsYJXWsI4+3IXcOfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/22/2022 6:56 PM, Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 06:22:25PM +0530, Sandipan Das wrote:
>> AMD LbrExtV2 is similar to Intel LBR. Unlike BRS, LbrExtV2 does not rely on
> 
> LbrExtV2 must be the most terrible name ever, please stop using it. Heck
> your own code calls it lbr_v2 wherever it can.
> 
> So can we please just kill that name entirely?
> 
> $ quilt diff --combine - | grep -i lbrext_v2
> +       if (x86_pmu.version < 2 || !boot_cpu_has(X86_FEATURE_LBREXT_V2))
> +#define X86_FEATURE_LBREXT_V2          ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> +       { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },
> 
> Is the complete usage of this silly name.
> 

I don't have any reservations about the name :) Its the name of the feature
bit from CPUID 0x80000022 EAX as mentioned in the processor manuals.

Unlike BRS, LBRv2 (if I may call it so) is an architected feature starting
with Zen4. BRS is model-specific and available only on Zen3. LBRv2 supersedes
it and from an architectural perspective, future platforms are slated to have
LBRv2 and not BRS. As Stephane alluded to earlier on this thread, AMD's legacy
LBR is 1-entry deep. We want to be able to differentiate from that as well as
BRS. For these reasons, and also to keep it disjoint from Intel's LBR, if you
so prefer, I can rename this feature to AMD_LBR_V2.

>> interrupt holding. The branch records are "frozen" at the time of counter
>> overflow.
> 
> Yes, I get all that. It is also significantly different from Intel LBR
> in all details and shares not a single line of code, so also calling it
> LBR is confusing at best.
> 
> The MSRs are called AMD_SAMPL_BR, so why not call the thing BRS_V2 ?

Sorry for the confusion with the register names. Since the SAMP_BR_FROM
and SAMP_BR_TO registers used by BRS have the same addresses as that of
the LBR_TO_V2 and LBR_FROM_V2 registers, I chose to reuse the definitions.

It it helps and considering LBRv2 is an architected feature, I can rename
AMD_SAMP_BR_* to AMD_LBR_V2_* or have these MSR definitions duplicated with
different names.

- Sandipan
