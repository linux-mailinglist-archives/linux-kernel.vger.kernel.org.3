Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E452EABF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiETL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiETL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:27:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CADE5B895
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzIqA3L/dLyahNUhOkVzgMAuoD4j+oqq+OV9LE8B1SNuEbyZJ84oi5rkI6VqpuXvgeF+SGzcW/07Gmrq09pOR06aVnQC6g8qz8tWWv6/Uiy70HRuXupxowiesVn0nenLnJB1jOYvjsTUHyezlvvRM2oetSL/uBalp3T+Iy3LpmJhIJAPIiGmCBRIGrzjMHCdigemETdSNIULMI9Czze+eNk9d2p3vh3lJYO5Tz+cqfVwRf3vipQVfbAMtmqn5c3cCnCXKXrs8k5e99uMaf/O1p28mwE5LMMm6R7ntuDCoooE9F4uhMRgJoU/cUA3oci1/2ts7CYMDf0oXaeM51UW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3y5dRCZ8tS2cZMGls2lZDcDfLamxY/fbRbU1EO+Tjg=;
 b=bYI9JNMKMxFxfGQ4hRMGPEK7T+6rfpfMzA3rKamyE56PnYv/RzYkd2xiRNd9mYGiY6FeAl4yjrEvddEH5VZthgbPNafjgDubuIHPswsYoU5qQbTXl6d2NlKBDrFYn/+CyxtY1Ww5fdmPbdE+k0r6n+TknSZMeooun0KW4hP4SyA/CQVF7tBAGbIPoVADODzhWpn+liWLwAp1CQ484ZESXKognuGEHN3oriXsPUMwKEQk9vogWyJt45cpe3+Ta8t5t97k2Nbw0t9uXmpTAYKr9EJLXziz6gZxj5PO8ewonpGw0eeSezvYCzgBuFmecUU9pvxWbelGb1nJBktuoDJR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3y5dRCZ8tS2cZMGls2lZDcDfLamxY/fbRbU1EO+Tjg=;
 b=QfNRcHf0NXmjg6JXbPe6/5270gkkVHdRA+CgmOKIb6U5Nth9/dr5bhLDfaFvT6V0Pp3bdZOGdYgzof9RWe8C1e3pJ7Q3Y5mV673UDJozLyXpl4u+CURmXOl7PokdSeVxBKg84pS2Y9hx2djSy4Z5c6NJMwYcNXKmjAPhZ1rsJOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 11:27:25 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f%6]) with mapi id 15.20.5273.016; Fri, 20 May 2022
 11:27:25 +0000
Message-ID: <ea09b245-cd9e-7fef-71ee-a694dac4b645@amd.com>
Date:   Fri, 20 May 2022 16:57:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        len.brown@intel.com
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
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <b1c9fd6c-9f00-9662-d590-b52ce26d0aca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c7ea4e0-2acc-444b-5ee0-08da3a53b6a0
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6165CBF8159832C1862594F584D39@DS7PR12MB6165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wX0YPY52TL8gkIq6nlT87nxZ4+BgUMolP4S2nOucnGIMCSMArYugksITrjeoIzaO8xSONjJPB603OrcQkf8djNOGnU3rg3lJXogOUAmOPtGpGJ3fBCxYG2ExyzcEdfmvRY/em2Cgpioi9Y3EdsHU38qcpNx2094lmukZb8VJpfS9+NaFFPYaVvl+0c83eIIfuo0lYxHIa8uZr/URjmr8BDJlhXWPFzIi2cl4C4DY5HcHxEA8iS5RPho5580dRoyoLPEysm8Xnd2TWA6cwh2IHaMeuhyEeV54cdEtPdQ5+hR62SK2qEk16pPGRZIjlSi6sAsylMLJcejheroujBi2ECTtkpGe1/FPd7GTvHobVuu86Lqz5HCuIIvnhZhW9T34b8+Qg74jtAslktzPrjn/egv/STla7pJneuMoVsugXx6P6HeuNPdOV5o1lWNBGLeL4j2PO5VMKAvh3RwGDlJkeQaDXX7orea7nNAXjZFwaITDyUqIrAqT2Qjo51jTRmA/slHuy2k2YO8KaLWy1q6rkMLQCuhmtTE8JlKIJg8uUi5wGwcJueFhzHfmjcTni+N77OjXdN+ty/AF3AoWGfARsqWKYhCB+49E3yP9tt6CHg0R/cSgAwXdYRqaPk1Pvk0PLq7WZ6Ahh8sfPA/94D3TXCyXdSQDb+M27ZfSm0pXAB5A109AEvOWQI7PJ6WS0I/XX7HLRLd27lQGEsFeJ3X3lQJrhZbqH56BxAFoa+3xNio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(38100700002)(186003)(86362001)(2616005)(83380400001)(6512007)(5660300002)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(36756003)(7416002)(44832011)(2906002)(508600001)(6486002)(53546011)(6506007)(6666004)(31686004)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFOazc5RktxT2p3cWVMeTRqRHFXRTVIVHRuT1VHa05LdWNWMnMyZmM3Y25S?=
 =?utf-8?B?ak5ETm5TcXBPZVIzK01FdnJ4ZWhIVTdtSmJOclZIUDEvU0gxMzdJU2VxRzZC?=
 =?utf-8?B?WFUvdUMydDhBSWtyTXJiWlhGUGhPOXlBaFZnTXJxMnUwNXRUNkhXa2QyQkw0?=
 =?utf-8?B?RHNQMlNaVlZhdU52cmovOVQxdXRLOElnN2preFB4UFc3WkJ0NGdkOXJ5ODhw?=
 =?utf-8?B?RmNiTTNRaTU1aktnSnBVUklLZFpWSzVYVXRabS9mNjVMSEFsR0hGTlpCODVN?=
 =?utf-8?B?YUZUcFdRYTlWVGkvdlFyMHU2UW9QbE9NWXRDaDcxWGV6OHBpWCtzY1NLTWU0?=
 =?utf-8?B?RmdqcVZIN3FzMit5UW42MWNIaGh1b0tzYjJYbU1ZUk5qajZtaFdpYnFMcHgw?=
 =?utf-8?B?Y09vRlkyZlJ2OVY5UEdLU1RsUElPdEVxZE1PbXQ1aU1zWHBYVlhJVC9aZlA0?=
 =?utf-8?B?VnduLzhVallzSy91UndwUksrQUZSd3ZvdGVQbyswY3RHVkNPK040RVBWc2dE?=
 =?utf-8?B?Y1UrQnFQdGZ6TFBWYjhydU1SVnpJRXNWZ2tCd0h4UlM4aWFGY1NyNlNILzRO?=
 =?utf-8?B?dnhNSlhSRkhCcXkya0ZtV3VlQmtTcUh2VTl3WGhxZ1dqMWFrUFYyVjVjUHlI?=
 =?utf-8?B?VTNHaDF5Yys1V1QwUDA5VG5UVXpDbWVlUkJpdW55R3BBaGRzNHZPRmt1TmZa?=
 =?utf-8?B?bXMyNXFmemtsMldoV1VhOU9Rem5pTFgzUThORXdzRXd6UVRhUW5tMnRISWxp?=
 =?utf-8?B?SzEwM2Zpbk11R1ZIVFZqWEwzcHdVZnB0bnBla0RpdlRjWUtaK3FaRStuN3dn?=
 =?utf-8?B?THlGaVRLZ1FFOXdnMGdMU2N2R1pyRHVMZzRiSnVWWUJGMVpMdStPQWIxSHRy?=
 =?utf-8?B?R1IzTEUvVlJlVWw5dVNoUjdZSEhUcFkrN3h1cE1pUXFwMEVpbTlPeW1UK1JT?=
 =?utf-8?B?dkcwQVplcFFPbEtkK0gwZEhvN3ZXdjRRRGhpbUJpYytYTGtUeG15Q1hwNkFK?=
 =?utf-8?B?V2xRNEZ5RjJ4VWtKOGdLNkFMMlRYd2VaUFo1bGlvazU1WmMwTTg3cFhOYjJK?=
 =?utf-8?B?VlU3UnVIalZ1czJXZnROL0xCZ0dWVldvTmdqVlBnUnJ4REJIc1lTazZiVE80?=
 =?utf-8?B?MytEalY3Q1c3bjhIczZQU3pTZkYzU2lSZ3pnOUpURkZ5WkkweEp2TWNObVdF?=
 =?utf-8?B?dG1SN2w5RmRkc1ZTb3htSjhLQkgvMFY5QmpkNXJkNDdwc0tlU1d4Ky81NGVh?=
 =?utf-8?B?R0pubFVTTyttQ2xLTHFHYkg2S3lrU0pRR0FHTzRNWENRTm15WUlVaDlqREFF?=
 =?utf-8?B?NlNsc0NNeVJYcFo3OXhmSTZiWWZXR1hpa1FKRkM0SkxpOXpYMFkzZXhQREQy?=
 =?utf-8?B?bFp0dllnL3pBL1AvZ2xoOURDREZlL1lOZWIxS1kzUmpRQTB4MG1ORFFGdmpo?=
 =?utf-8?B?T0RxdVR4cldvaFQ4Z0Q0ZXBiWlgyZjAyN1NkMi9GSENiSUZUZlVLak9pZ0ta?=
 =?utf-8?B?aGtwNWYwcUhXVlFUdk9YTk1XVmJEL2xDeU5zbjZHenBIUFJwVFpETXAva3BG?=
 =?utf-8?B?OHQxVFVJK1NLTkp1NTFPYnZIa3dUakF6YlRzRzFMdkp0MWx3QyszTFE5RGRo?=
 =?utf-8?B?SzFwNHFhRWU2Q1ZpeW11VWFKeFFyZGZmd1FscHVNQktyNGZYN09ENHgyVGlF?=
 =?utf-8?B?ZjNPckJuQkt0NGhIZ1B1TG9LYjFFcGN2Sm5RN0VvZ05LQjVzd1ArSGc3N3g0?=
 =?utf-8?B?MjB6TzRLdHRhMUJPd3FJdVdtTFhXaVVBSnZRYTVIRCtBSEJURVE3MW55TUNi?=
 =?utf-8?B?aWVML1RUNkNUUmEwMVJJZGMvZGtUQjFvRHByUGl2NjZicWZiejRFMUtrZURt?=
 =?utf-8?B?VmxkNkpkZ0NYcElHbGZmUkFBT2pLamJvNVVvYUtrQTdOTXdmVDR0aGpseEE0?=
 =?utf-8?B?Y041R29ZeTRPbXVnREl0WGVxSjV2S2pwMlZqc0prMlJJTEZTd2V6TkU1VTlQ?=
 =?utf-8?B?aFNJSGl6VEJ2V1FnOEwvVklXeHdHRVVYVVRNZG5raXlLYkM1SitJa2E2QTdK?=
 =?utf-8?B?aU9oc1B4ZG5ITUhMcTd4UXRtdEpwRTNld3lsV09IZUJPaEY4WUhuRFI0Vm5j?=
 =?utf-8?B?bkRpZlBac0JoMy9leW03eXozZW51czFaZjNYTHFwbkxqQU9RcWI5WmFYc3Fo?=
 =?utf-8?B?aGhyUXFCS3J6bHhsZzAya3ZEZ3BJbTVJZEo3T1J1VDhGNWtnZ05ESEJoeUh2?=
 =?utf-8?B?VVQ2NjFTNW1CMURzTzQ1c2wzMFRpUEtGcE1YUVhpek9iY2Z2NEduN1Myb1h4?=
 =?utf-8?B?enBYWWhwVHBLWFprU1lnN1g1MHNUOTJHeTJpMEtCc25ZMGFXaFJYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ea4e0-2acc-444b-5ee0-08da3a53b6a0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 11:27:25.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQYiA7IhF7IXJKhX1vCtkZoiWHBnlfeQvR4uJ+zmNKj0Pe9Lhj15pauoAk/o4Y21pkptKJxTds6ujmyx9IPWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On 5/19/2022 9:30 PM, Dave Hansen wrote:
> On 5/10/22 03:18, Wyes Karny wrote:
>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>  {
>> +	u32 eax, ebx, ecx, edx;
>> +
>>  	/* User has disallowed the use of MWAIT. Fallback to HALT */
>>  	if (boot_option_idle_override == IDLE_NOMWAIT)
>>  		return 0;
>>  
>> -	if (c->x86_vendor != X86_VENDOR_INTEL)
>> +	/* MWAIT is not supported on this platform. Fallback to HALT */
>> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
>>  		return 0;
>>  
>> -	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
>> +	/* Monitor has a bug. Fallback to HALT */
>> +	if (boot_cpu_has_bug(X86_BUG_MONITOR))
>>  		return 0;
> 
> So, before, we pretty much just assume that all Intel CPUs with MWAIT
> should use MWAIT C1.
> 
>> -	return 1;
>> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>> +
>> +	/*
>> +	 * If MWAIT extensions are not available, it is safe to use MWAIT
>> +	 * with EAX=0, ECX=0.
>> +	 */
>> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
>> +		return 1;
>> +
>> +	/*
>> +	 * If MWAIT extensions are available, there should be least one
>> +	 * MWAIT C1 substate present.
>> +	 */
>> +	return (edx & MWAIT_C1_SUBSTATE_MASK);
>>  }
> So, I guess the "If MWAIT extensions are not available" check is
> consistent with the "always use it on Intel" behavior.
> 
> But, this would change the behavior on Intel systems that both have
> CPUID5_ECX_EXTENSIONS_SUPPORTED and do not set bits in
> MWAIT_C1_SUBSTATE_MASK.
> 
> Is that a problem or an improvement?

Prior to commit 69fb3676df3 ("x86 idle: remove mwait_idle() and "idle=mwait" cmdline param")
the decision tree only allowed MWAIT to be the preferred idle state even on Intel CPUs only
when C1 substates were present. It was unconditionally allowed on Intel CPUs only after the
commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot hangs caused by the 
removal of mwait_idle(). Are there any subsequent Intel processors which have MWAIT but 
no C1 substates ? And is MWAIT preferred to be the default idle state on those CPUs ?


Thanks,
Wyes
