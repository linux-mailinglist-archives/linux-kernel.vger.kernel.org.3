Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DC595432
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiHPH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiHPHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC345E55F;
        Mon, 15 Aug 2022 22:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLPWxSxrjEbpxv7/k010/OCD6Vi0RxCRm/dnzLrbKKxndV1OORHPtkgtx7IwEZe6pLppnnsTGAru85MUSNU+9x8XL17HI0KS1Ogy+fhLQlP6Qxn9awvKhJ5Hsv3QQOuQmTEyBG32x+WQqLaa/Y3iAOwMFu2vCNuxrazuCoucvkPm4aLOBYLCDZKOfj/JIePWN9uoeTo0GlT97wRFCxDLziMbTxlGPSIJQ7Z+Imh7saoCl+QpBC/LHtrDQETJqq4ekTFL4v9cs9rxg+ksqbPlZe8ryK0cBI7nqvvbH740Y4M3sIYkKjO6o7gFC/vPZQM9jb3ByKu1IXigU2iWon2opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVD+zR0tPhGsUpjOjU4Nxzjx2a68RWsu60hEKZa06g4=;
 b=Bcpupy6lwSjlC3bh4ECe/Y+0ouaief6OmGJIM9knxJuG3Tiuub7Y402KuKaPkrwhgT4qb8LtbO0Am/tXOktudg2wiCwZRYrLgDDulyPBzrhlBiEFkpZ2biI2dwlSOSK/gN+DNoYOe8HLpmglDudvwn/zhfg6uP0XSbAAqrdQELpOAnRu5avog3VqUjFX5/aY6kWQBBQ3ZgJC7HjXXlbnfshSlts13EJet+Pb6bROneQpFDH0T9u0UjfraB/wvXfcdV3pYPeAOo3eecASRTkUYMCbv5VpDkwwqLHJB+EYegBHcyWiqYVOsK78Ri8WVpEGb18NG2hR3GJsNJMYMfjbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVD+zR0tPhGsUpjOjU4Nxzjx2a68RWsu60hEKZa06g4=;
 b=QE6df/ulV73wQr6SprIbBdvXHB3UzMXU7qNPL3x7tij/jbbbjPW9uoB2KPBW23IgUJa3REnxbbjrj7h84wikQNraD2pRSRBlYMQvgrWJ75uWso4ipnMcTraIMVKeTux0mqi+DtVdlNRPtETrYcgGgky0J1imWtTUBVama+3vDSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 05:10:33 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::e459:32ff:cdfc:fc8b%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 05:10:33 +0000
Message-ID: <c4798418-9530-bc4c-2218-313d3e99bfa0@amd.com>
Date:   Tue, 16 Aug 2022 10:40:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] tools headers x86: Sync msr-index.h with kernel
 sources
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        peterz@infradead.org, bp@alien8.de, namhyung@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1660217326.git.sandipan.das@amd.com>
 <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
 <YvYQQr5VenglbpWM@krava> <94f483f5-c541-2a1e-87f6-a4105c30a045@amd.com>
 <Yvasg/P0v23ymrDo@kernel.org>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <Yvasg/P0v23ymrDo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81c1113b-09e3-44d2-b76b-08da7f45a579
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPpO5P/m6pOPmnAXDbj8t9kxYl5uho8Cnd5L5WNu4iDFHUkCcD8fOo6gg43QpVFMmWLvC1Dl9LGYbaX9JitrxpKw+MaE1FXIQepE1olJjeVT+oWvTxd0xLNKW6Y5DAJn4PMF8SNK2ISX8ozuV7AkO4oA4U43n6cVtpW3RkZZ1oTwfyU6VDrxlwyAm8GmlMzIoeRs2A1+o7U42EqvfCAK03JEjK9a4AmHe6SS20AbFKVO2cpKcqy2/KbaQ2gNyU7F/rHFIL79rHcWlbJtogC4+TDTTJJRiPHO7BRaa2WG/aDobug77kHImVLwyfa99g/5/pyG7n+vlntsBvJDbI1TOIoNaYrr73R6r5QdQ1uuR5RnnOwymRw1/82EDxTe2B0sKi7LD/fH6DydoT8PyVWbRUTGxXRDBXZfISGAXpwsnLqudpucVYeQLiofa8Hfv2RX9BVhYdu2dgRkOT9uoCj9yL2QfMK5fkF4jzj7bZwq1OoSL+HjoZlTiSKa0RDNq7AC7OYZ8h/vjgPIN7a9hCFUOm5HHGbEfg4YYLok4Mlydk3O/k5eow872jtZBoxaa2Gd48Wu64wR/vsZ6uY8WxPqnb1GXXzYeRq9hG2/GKys8LejcTpjLTZR+tnqbR/g/PN7ZfYWaGbyp8RcrQ+4ximpoAP95Dwu/x7l5YcyVUQUNQLgF1mcdeTkhUpgAU3gWs7hDr+p1WqvDezm3e0oXBd5VCv6VliQhMJklHoraD2wi37PjX500tWfcYClwCa+bmG2HpN8eLPBdXIbmRIsA6rfZis/eBpuP41/0Xo+aQZhCMvZM8Jzp+X1R3nfSR/DzMQyF2cIo3IOa31LzLR00FtxtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(6916009)(38100700002)(31696002)(86362001)(83380400001)(31686004)(6486002)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(36756003)(5660300002)(8936002)(2906002)(6512007)(53546011)(2616005)(6506007)(26005)(6666004)(41300700001)(478600001)(7416002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3I2elBlemRzdVFpbnNPZkRFelZSaWNENWx3QXYxNjVFcDJ0bjA3RFUrem9O?=
 =?utf-8?B?eERYU1Faam5nNThmZ3ZPOTFpdmlFemY2M0xSMVNqdFAyYkRpdHhUL3pVZWx6?=
 =?utf-8?B?NmErcUNyL1o5ZTBmMFlhSVEvdGM3NTNSSGdOZm01Rm80V3BTM0hlYTNKQzY3?=
 =?utf-8?B?eGRoTmlBSEoxSmptYmZGNEl3NGVEUEduVjRkdG1PdFFXRzFxNWp5bUFLbFNv?=
 =?utf-8?B?YWlFSlpzOWs4VXpsQWVSYnJVRWh4QTlaODFUdXdFUWFUemNUTm9HYXpVL3hX?=
 =?utf-8?B?NWV1U3RJT1BsOFk4NWt6a1VTcUROTksxVDV1eHp2dGFURGRtMDRxL001S2lL?=
 =?utf-8?B?dm1mUDNtVE5wMHpscklNUG8zRGJPSTZac3Fwb3B0MXoxYXFaeExxaGNYa3JI?=
 =?utf-8?B?TjBIRlJBRC83bDJ0YzJ4UFFadFpGMGxYR3gzVDlTMXh6ZWFDbzUyTlBSbjVZ?=
 =?utf-8?B?MmxFaHllZVJydEhDd1lKZWJ5L3RTZytKSFA3Uk9UUWNjUGlRR2UyNUt5MUtx?=
 =?utf-8?B?anEzQTJWQ1ZtQmZOVWphWXIxaTVCWU9qTHRkckVMb3Vraml4V1F6SWhCYUZ5?=
 =?utf-8?B?elhGWkIxZEF0M3IrMUg3UWROMmhUK01LdzVENGtuUTk5MEdacjFzM0VNbVUw?=
 =?utf-8?B?cnN5V09YREsyWWx2VGpNMmlzNWtpdm1QenRNMEhCUlM0YWNoRE5mQXgyU1lr?=
 =?utf-8?B?M1lFcGNUYXd3d05zb0EwaFowRExmc3ErcGdodVd3blRvM1BmUTM5dUxGYmwx?=
 =?utf-8?B?Z0hWN3dXQU9MOUxUUU5yZlR3ckgyckR6Nk5Ndm5EeEsxL01WSjFYNHNUWHNt?=
 =?utf-8?B?Z1YwdlFJcWpJVUhmMUdsSVAwV2xEOXcrNDdvWGh5RWZRd2tWbW8vc0F1UlN6?=
 =?utf-8?B?VDdkcVFsQVRCWDFseFhNQ3FycUFyQlYzaFlRTktaSzdvWGFUUkFxR1JhVTJI?=
 =?utf-8?B?TStOQTB4WWNrWDB3MmtNN2tDL0tMNmR5cG5FeDVWMXhTeUJNQVMzbXFwTmhF?=
 =?utf-8?B?clZ5RXFaQUFJRk42MjhocEtkZmNiZ1Z6ZnltYktNUzA3ejhlQ2VXcUVUUWFq?=
 =?utf-8?B?dnYvVGZFdnU0Mzloc0xjNlN6OWtIK1dUbjZta0o0czNoMVJKUzV2cVhpbEhP?=
 =?utf-8?B?eENWY0J6bUNiVWVaWWdRejJQTll4VUhhelpNaGt0SU5SL3dZWWdPemVpRTh4?=
 =?utf-8?B?TWJjZUQyNG81MC9TSnNJSDhTNUVFWWp3MVRqS0tId2JHWTdzSnYzWlA3R3dR?=
 =?utf-8?B?Qzg5MDN5Yi9DZk1hZUpIeW5RTlZVM0RRS2dRUGpVVERhOXJLVUQ2bVhsUTE4?=
 =?utf-8?B?UDB2bWZhdnZpVDNGbVJyVHFJTlduVmdzZlkvcHh1WDZLVkZjT0RMOWZPNmpq?=
 =?utf-8?B?WXVHV0ladTNudHd6OTVsZlRHM25LZENrcDBSUmVhbU1uN2IwY2lyaHlEeXJG?=
 =?utf-8?B?cXBwVmh0L2h3RGJXZ2M4Z0NPQ0dVdG9KMkEvTTh6NytDUDl0UFR4Wmx4RVcx?=
 =?utf-8?B?aGMxKzA2R09lQkFad2E1YjNLUVQ1d1R3WmpVcEZTRlI2NlAzUkp3U0dXVlY0?=
 =?utf-8?B?cklWVEhGVVhFcis4VWR6SGREY04rMFNTMlZRR2VQZEZQaWt5ZmRreTdSQmRS?=
 =?utf-8?B?R3B3ajVwTDk3VzE2RUE1WWpyeHdad2J5YVo1ZkdNU2FPTWRpR0ZRTitueU1q?=
 =?utf-8?B?R2pIbEdLV3JqWld1b0VyZGpLYm5xNW5lbExyeXZTUWU4R3FZZUU4UlZWYzkz?=
 =?utf-8?B?VzAxRVhwK1FVbzVZalJ0enVxS0JWdkZKRU9PU0p1ZGdrQnQ1T0oycW9lYkVo?=
 =?utf-8?B?MERUeE85SDdzVmNZWjNVSmhhWEI3dy9mcVdoOWlYZFZ5dFBXaXJORnNIQ0h5?=
 =?utf-8?B?eWE2dzF3T291T3N0Wi9vZ0h3NENXcTU1SGUrYUY3MGZ4Mzh6NE16dUNoejZS?=
 =?utf-8?B?S0J0R2VQVnIvYzg4bFdoeEt0M0c0VnMwRXA4aitOQTV3YUZHVUsyUXc3QWQv?=
 =?utf-8?B?alpZQkIzT25IYkdWTHZDcUpmT1hPd3FxSEVKaXBBOVpWU3JhR2hDeTlXMFBL?=
 =?utf-8?B?ajVGaVF0RUJkcTNtcjNxakhQZWVkMWEvMC9aekZ0V3ZKVXkzcXB6QUZVTjhP?=
 =?utf-8?Q?m0E4Mz4bvDXc/H54uvJqErlnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c1113b-09e3-44d2-b76b-08da7f45a579
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 05:10:33.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ax4lBTI7aFaRMWKSBBTy761owDEcc116kVMO/NcfUWtTJrkyuf4MB/wnB5rkqrWVch6C0zD/dbmAjp22G8CEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 8/13/2022 1:09 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 12, 2022 at 02:33:46PM +0530, Sandipan Das escreveu:
>> Hi Jiri,
>>
>> On 8/12/2022 2:03 PM, Jiri Olsa wrote:
>>> On Thu, Aug 11, 2022 at 06:16:47PM +0530, Sandipan Das wrote:
>>>> Sync msr-index.h with the kernel sources by adding the new AMD Last Branch
>>>> Record Extension Version 2 (LbrExtV2) MSRs.
>>>>
>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>> ---
>>>>  tools/arch/x86/include/asm/msr-index.h | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
>>>> index cc615be27a54..7f9eaf497947 100644
>>>> --- a/tools/arch/x86/include/asm/msr-index.h
>>>> +++ b/tools/arch/x86/include/asm/msr-index.h
>>>> @@ -574,6 +574,9 @@
>>>>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>>>>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>>>>  
>>>> +/* AMD Last Branch Record MSRs */
>>>> +#define MSR_AMD64_LBR_SELECT			0xc000010e
>>>
>>> curious do we actualy use this in tools somewhere?
>>>
>>> jirka
>>>
>>
>> Commit 9dde6cadb92b ("tools arch x86: Sync the msr-index.h copy with the kernel sources")
>> from Arnaldo says that adding these new MSR definitions in the tools headers allows the
>> beautification scripts to pick up new entries which can be used for filtering MSR access
>> traces.
>>
>> E.g. one can trace the hardware LBR branch filter bits getting written to the LBR_SELECT
>> MSR while recording branches.
>>
>> $ perf record -j any,u true
>> $ perf record -j any_call,u true
>>
>> $ sudo perf trace -e msr:write_msr/max-stack=32/ --filter="msr == AMD64_LBR_SELECT"
>>
>> [...]
>> 224568.130 perf/9093 msr:write_msr(msr: AMD64_LBR_SELECT, val: 1)
>>                                        do_trace_write_msr ([kernel.kallsyms])
>>                                        do_trace_write_msr ([kernel.kallsyms])
>>                                        native_write_msr ([kernel.kallsyms])
>>                                        amd_pmu_lbr_enable_all ([kernel.kallsyms])
>>                                        amd_pmu_v2_enable_all ([kernel.kallsyms])
>>                                        x86_pmu_enable ([kernel.kallsyms])
>>                                        ctx_resched ([kernel.kallsyms])
>>                                        perf_event_exec ([kernel.kallsyms])
>>                                        begin_new_exec ([kernel.kallsyms])
>>                                        load_elf_binary ([kernel.kallsyms])
>>                                        bprm_execve ([kernel.kallsyms])
>>                                        do_execveat_common.isra.0 ([kernel.kallsyms])
>>                                        __x64_sys_execve ([kernel.kallsyms])
>>                                        do_syscall_64 ([kernel.kallsyms])
>>                                        entry_SYSCALL_64 ([kernel.kallsyms])
>>                                        execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
>> [...]
>> 302748.439 perf/9126 msr:write_msr(msr: AMD64_LBR_SELECT, val: 229)
>>                                        do_trace_write_msr ([kernel.kallsyms])
>>                                        do_trace_write_msr ([kernel.kallsyms])
>>                                        native_write_msr ([kernel.kallsyms])
>>                                        amd_pmu_lbr_enable_all ([kernel.kallsyms])
>>                                        amd_pmu_v2_enable_all ([kernel.kallsyms])
>>                                        x86_pmu_enable ([kernel.kallsyms])
>>                                        ctx_resched ([kernel.kallsyms])
>>                                        perf_event_exec ([kernel.kallsyms])
>>                                        begin_new_exec ([kernel.kallsyms])
>>                                        load_elf_binary ([kernel.kallsyms])
>>                                        bprm_execve ([kernel.kallsyms])
>>                                        do_execveat_common.isra.0 ([kernel.kallsyms])
>>                                        __x64_sys_execve ([kernel.kallsyms])
>>                                        do_syscall_64 ([kernel.kallsyms])
>>                                        entry_SYSCALL_64 ([kernel.kallsyms])
>>                                        execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
>> [...]
>>
>> I can add this example to the commit message in the next revision.
> 
> Right, you can reuse something from my messages updating this file or,
> better, show an example like you did above, for the thing that you are
> working at that moment :-)
> 
> One of the things we need to do is:
> 
> perf trace -e msr:write_msr/max-stack=32/ --filter-help
> 
> And then it should look what are the strings that can be used for that
> specific msr:write_msr tracepoint.
> 
> Also have tab expansion in the --filter= part :-)
> 

Thanks for the suggestions. Will incorporate them in the next revision.

- Sandipan
