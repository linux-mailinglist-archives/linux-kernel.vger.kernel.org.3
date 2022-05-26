Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B410534DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiEZK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEZK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:59:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B0CEB89;
        Thu, 26 May 2022 03:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjLzlJZRVPOk/r3Jufor2LeodWpdC4MwgdpIGGoH1eiO2AWf66peEainLfKGYYamTPa5Uj4QmF2S6be6KQHB6toGa5wgNFx28EKCuxi6ajCNywsbyDOvLv39hKC262J96XLXiCXRtj92q6L8hbUjbDNtf4IbLZzWGC3E+ynJn/IrpoIXdppZNZcm9W+Xg4Wav64dxpADOfymLhbdMzKJ/S7+e3cIHao4FHTqpPgqlMoWd2KEr4GFWuIk3GKPmakdzBh6uRQbL6FblDynGeGMQBTyaucq7WH1cl2lbqKr5Hiy6hM57kNj/1D/gj5v7ApL9/v132wCnG2cuZAYeqs4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEsc8esdP83yXDd7OMBc3izlF+PC3AIs42cybMsFN3s=;
 b=ehtcJ3S8Z5VOs5PZnlqtn8zUUGCHvwUf2X44pYog/+8ES58GN60O11EXEW+X0SL+a12+W5CB687fMprs6urPITdK//ofy9aihUAyqh3twHn3SzkuYaY1Nxpc0PYc20+yznGM+NJ656M5F6AedS71TPVl3ceIn9kkENUVZh7H+6W7qmb5+dmQGie39UgN1mRZ1bWougxI07d5AgldpJTDEj9MqGURMyh7MpXZrXvKhzXGHlvIEAE8vdpVUOeptZujLbImWnA33qtwkEw3vyYKpTBCEVlGuzQNB7ZXBe2zzCBCyXQVMTnLts8rkumEoz9r9Y58zpxwzWA7Wgw6CDVI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEsc8esdP83yXDd7OMBc3izlF+PC3AIs42cybMsFN3s=;
 b=fkHM3xoTTm57EsW6nVHtnVoSo/+1JKEnbdZk0dmB9qgwqQ2aWTge5UdkyBcC4JKKfvTYmmonWoPYF5ZypCWGhqU613sBXICP4KNp5AWzJmLQCOhN93lNbBcv3070RCxQomfTnWrmxAOtKwDs27sKSvYVyB14ov6Iv0kRZ1vsQMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY4PR1201MB0117.namprd12.prod.outlook.com (2603:10b6:910:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Thu, 26 May
 2022 10:59:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 10:59:42 +0000
Message-ID: <91e7651e-6937-ab20-2b1c-01f8be7933e1@amd.com>
Date:   Thu, 26 May 2022 16:29:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 06/13] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR using
 IBS_DC_PHYSADDR
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        eranian@google.com, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-7-ravi.bangoria@amd.com>
 <Yo4RSY2L80N5muJ9@hirez.programming.kicks-ass.net>
 <e10c3d1b-90a9-2f14-987b-9c0d2471ee53@amd.com>
 <20220526095633.GO2578@worktop.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220526095633.GO2578@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ab6a2d-579f-4d96-fc50-08da3f06d5ee
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0117:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0117BA9203DC036381A1214FE0D99@CY4PR1201MB0117.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5qpRCKi6lYH5kZTzHSI62t/eeSTW6d39IVVMmmRM/1iLC24u5Rkk4Vxj4vztq3Q8HA0XD7YxOXeEHq4YDJSSlmj5Y6LU/lTIOWJtoCOtelGYOi/rfMOZIv1ciWiVEoo/HUOpmasCcCvpFX++NGpZ5Gx2mqCSt5jQXPqB3vEiHCnaur6XnyYcnh07366EO67EC2cuaolkQv2hRgqa5iZNF27m3wLKQ1HqO3FjdzvSX+rZXmWaTwBwQ2q9Ao5kIO3DHjgwYC7or6tQBRditVc7rkbNH6OhxEbRREnz0NwS5b1OyprTCoLhDRuJ1xWeJrSBGXRacrLIM4bCB94YPuTcLCuDd/MGC0276DEFcBOXptB4GiuNJsW81b3m/abii6c8v/izdjAU2xCmqymEWVnOkYn0IlxRAfJUQTa6BzlMH4+2NFij7CfZU2n6Hw0K9MPpTtFsCmb1Vhj2qm9lLgRYJNCZ6ktNWmmwX4L3UH/X9vdXPQyRUZ80WeI6pahaoZPOg8gZhyJRIq4l5pDDiGegkF50br62zK5REnaIajyS4KmLk1W2qgCOuCzDbw7h6soaBBmuUi4i1NtA0AmWGjWPoY/iu9jqW5vmGxLcBY2DYEKpnlcdZ/IxXFs7n7QE4TNDK4sgA9X7LIVKTCkZpLUW0fE/H/YZJhPZRB6zo1O2IQQaJgjy8Wn7VpCYRM6+snxXVySB8xC8oD2FLncs5L6B+29DMglKsaNArCUT8kwyY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(6512007)(7416002)(316002)(38100700002)(8676002)(186003)(36756003)(66946007)(66476007)(66556008)(31686004)(6916009)(2616005)(6486002)(6666004)(83380400001)(6506007)(31696002)(4326008)(86362001)(8936002)(508600001)(2906002)(53546011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlE1OUNSMkpQNzNRUnpJblNpU2llSkNvYjByZEVsUTUwVnRQRjljanVIV2RS?=
 =?utf-8?B?QjZXcGRGUnV1d09sNVZGSHhCMWtoMnc5WURpbnJ4M2oyL2FPWUdBZi94azJ2?=
 =?utf-8?B?T3JrRitSYkIyQlV2eGdXRGVQVXR0TGw5RXBKNFlLV1F2Rlo4N2pLRy9KSUEy?=
 =?utf-8?B?b0pPZ0Fjc3JKUVdkQVBRaUJUeVNXREtKY0lxcVE0U3hJZmJSMCs3bzdkbFQ2?=
 =?utf-8?B?K1BRVzFKMUQwUlFSeHZ1dzV5MVU0TnVoQ3FiUUxzZ0Q4eUtIeFgvUHFSUHVM?=
 =?utf-8?B?V2pIb0RSR3VBUkkweU1OdFE0REIyRVMzNEw0MnJMTjNwZENkSFg0d1pydTNS?=
 =?utf-8?B?WlZpZk1SK2lremE1eHdXMCsyUVJGWUIzMURtR3lHeWVJUHJCNFRGWjN1N2ta?=
 =?utf-8?B?cEFtb0hMSlNWL21qazhiOEZqbFAvNWJ5SGtMT0FnK3hpTW84alF3YjVnZFc1?=
 =?utf-8?B?REVzSlhsMkdIaGtXNzNyaDl6eXUwaFlyaWR6REVVbGliVysvdFB6SmpJR0RF?=
 =?utf-8?B?QjljNEVJRzN0Z1dhaFdCOG1KZVhpaEhQWFMydkIwUFE5blhKc0hKWFEwYkVj?=
 =?utf-8?B?OEVlOXhZaWg0clRLK1g5ekFESFNWYVpFVVN0UjNZaW5CbjhVRjIrd0NaUVRs?=
 =?utf-8?B?V2xROTNpdDBkQmxuSGJFWUR3OXg3cXhHVGMrZHZNa3o4NHRPbkdBL3BBckE4?=
 =?utf-8?B?VVVBeHR4eEg5aFA0WmNON2dkTG1sem9lU1A5UHdHdS9Wbll6ak4xdDRMVDZN?=
 =?utf-8?B?dVh5dTJieUoyRWE5eGJaUTVJdzBvK1ZucWhyd0xLOEMvSGF5VDVyUTgyWHAv?=
 =?utf-8?B?ak4yK2hZcHNtOE9NRitJeHpxcExTMjF6SFAyMmtkWkpmWU13M1l6VnlyRVJx?=
 =?utf-8?B?NDFDaWhmSlBHa2EyL0RYb01ReEE3K0kvSHJaTU5jMm1DTEp1R1lacGloL21s?=
 =?utf-8?B?bEZ0MEI4U09mdFBDNEZCZWZ6N3VUOFVaOE9KMnhhNTZobG8wL2NLZ2JQaGsx?=
 =?utf-8?B?eVZhcmhTelpyalpFSWhTSzNEbWgrMmFPa2VIMmxJbktvL0gxWE5PTlA0SlVM?=
 =?utf-8?B?aVZnOGs2NGt2dkpIQ3J4S1ZEZ1dBajRWYTZlTkJIeit0YlQ1L2tqMnYvSk80?=
 =?utf-8?B?b1dyeGU5SXZlbzFKOEpUTnYzWW52Q1Jrbmc1c3NnUmIydTJjUndYYyszYmdq?=
 =?utf-8?B?RTZpenN0L3ZLWDh3YnJJcTQzWk1LUVk2cWhEd045QU5WWGs0SDJWak5KK1Z1?=
 =?utf-8?B?MnJrQTNTYjRkVCs2Q1VqaU10Tyt6Z1ptYkNEc3NmdE5SU2VIVlptQlJPUnhM?=
 =?utf-8?B?Z29VNDZDS2RIc2V5TFdYdVlLZzZ5aHJQc0RZSDZGVXV5dVBpVURzVVd2Y2RF?=
 =?utf-8?B?TUxrMHpiZHZZODIzcDNDM2pFUFhSUUk4YThIS0Ixc1hWbzhxTDIrTUJqdWVY?=
 =?utf-8?B?M2dFQnh4WmdkRG5ZS1JFTmpseENKSlp2WnJtd3d2SGNVK2R6K3VFT2RiajB2?=
 =?utf-8?B?c21zVjYwSEVPczNwT1czbGx3d3BXd0M5RG8xRis1cS9hNUZmMVNlZmVYeHBB?=
 =?utf-8?B?RlBoY3J3Q08rSGZMK0RNQlhveURIZms2WUVUL1JHbW14K1k1dnF0emxodXEz?=
 =?utf-8?B?ZDV4TzFHMGJ4T3lxdEEvMWNQRVVJd3phSkwrakNHOFBXb3pQeDQrMHJCV0ww?=
 =?utf-8?B?YzhiL0JiUEpuSDBmcUREYUY1UWFIV0EwNlhzTFBBS215dzhsUStzUGJURGxp?=
 =?utf-8?B?dFA3c1pGcUZHMnVFeWc5KzBkd05WT0N3MDBuY21oMFhqQkJBRnFYUjFPQVk1?=
 =?utf-8?B?UFBENDg2ZmhoWHM5S0JyOVlWMzlNYWVQNDEwTU1LRWtBcWVPQkVvTXR1MmFO?=
 =?utf-8?B?b2J2eUR6U0tnRzRpWFpWd1dyMGhzL0JJZ3Y2Q2FRRHB4Wk44T2RuZzZET0dO?=
 =?utf-8?B?U1E5dTM2cFdYNWRpMGt6WDZEMFl1YzJDNkJPcFhxRWNjZnVRdFMyeHdtSFBM?=
 =?utf-8?B?OE9OL3FUWHFJdENrU0RsdzZoZlNKSUxVODRtQjd4c2QrRlEzOUFNOUo2YStS?=
 =?utf-8?B?YTg0TGY0a2hPaEtBQnlmbGVBeWEwNUZVQjJFWWVRc0ozQnphSkdGNi9OUU80?=
 =?utf-8?B?SWFtd3dxMzR4V2lJWlg0eis2aDQ0S1RVRHJINUpZbm5aNTZOK3dtWkk4MGJz?=
 =?utf-8?B?aS8wZ1pVYXlqMDZTZktSNkVjZUcxOEd2OXZjeW9HSTA1NDFQbEFkNGd5T1V5?=
 =?utf-8?B?Q3g2am5aR0tNWURrMDAvNGQ2dkJnVjNobHEvb2FzRURIMGt6YzVxRjNEODN4?=
 =?utf-8?B?SHFhUHdBSjh3bDBrRitWazRCakNZenczNElSMHh1Mm1XMVdpNFlHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab6a2d-579f-4d96-fc50-08da3f06d5ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 10:59:42.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHlxyRe99A+xgEz2EdDolXzb/AX8N9uD2NASBrAcfgzZiRaKUTJdADO89nvoZohiML3fBgp9AtXJyQLrEPzWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0117
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-May-22 3:26 PM, Peter Zijlstra wrote:
> On Thu, May 26, 2022 at 02:16:28PM +0530, Ravi Bangoria wrote:
>> On 25-May-22 4:51 PM, Peter Zijlstra wrote:
>>> On Wed, May 25, 2022 at 03:09:31PM +0530, Ravi Bangoria wrote:
>>>> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
>>>> store operation. Populate perf sample physical address using it.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>> ---
>>>>  arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
>>>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>>>> index b57736357e25..c719020c0e83 100644
>>>> --- a/arch/x86/events/amd/ibs.c
>>>> +++ b/arch/x86/events/amd/ibs.c
>>>> @@ -986,13 +986,35 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
>>>>  	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
>>>>  }
>>>>  
>>>> +static void perf_ibs_get_phy_addr(struct perf_event *event,
>>>> +				  struct perf_ibs_data *ibs_data,
>>>> +				  struct perf_sample_data *data)
>>>> +{
>>>> +	union perf_mem_data_src *data_src = &data->data_src;
>>>> +	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
>>>> +	u64 phy_addr_valid = op_data3 & IBS_DC_PHY_ADDR_VALID_MASK;
>>>> +
>>>> +	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
>>>> +		perf_ibs_get_mem_op(op_data3, data);
>>>> +
>>>> +	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
>>>> +	    data_src->mem_op != PERF_MEM_OP_STORE) ||
>>>> +	    !phy_addr_valid) {
>>>> +		data->phys_addr = 0x0;
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
>>>> +}
>>>
>>> perf_prepare_sample() will unconditionally overwrite data->phys_addr.
>>> There is currently no facility to let the driver set this field.
>>
>> Thanks for pointing it Peter. Would you mind if I add:
> 
> I think it's best if you extend/mimic the __PERF_SAMPLE_CALLCHAIN_EARLY
> hack. It's more or less the same problem and then at least the solution
> is consistent.

I've one more identical optimization in my list. IBS_OP_DATA3[IbsDcPgSz]
can provide PERF_SAMPLE_DATA_PAGE_SIZE. I hope consuming two more bits
for internal purpose is okay.

Thanks,
Ravi
