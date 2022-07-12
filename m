Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3157218F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiGLRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGLRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:08:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B713CFB;
        Tue, 12 Jul 2022 10:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojd9yS88Hj4Vn5J0NTKOPWV+2v8WgXWJa43RGzpzPdBj39/84II1GW+QM5zxO0i890rqHkBApVbPdh3lsO5UaNsWb/bE5UYAom0TftZNAWhWmjH07HTrbvdC6Eu0ZAU/tJm1oT+LS3iwt/WcyI6ZCWhngtnFYCherfKQv/a+ZXOjoAe6V2zIQLOoXrVp6T5wuU07+pL/+S1LP8O2QPmGclpWovckkkQvNkkhW6ODMMDFFH8WatDgq5SXn6TLM0H23zhYU3KLdK97pCSPQGO0PLokmgxvt6e269Tagt0lXPy5xNz5OIOpP4rCgLJoEsMRAY76eUsMLzCp5mhu9z0now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKYPj2x32OhTQlts7qB12ypHjKxKv0v9rfovJqQFo9Q=;
 b=PHhebnHMbHa4cDNZrGkHMR30SOBYHVbNRnFF4/XjuXxmjGUBfDUx9CGm2hnYc5hrM9C3HkpGaRRR/A43+jQMgRp1U0gvpNmmYdAm4yyloHTmrnGSifXpr2ID9leBZGttgnTUPBQgpDerQ5QEDSkx/xZulvd97/SQXr42sW5dRXWP+8+IedRLGv7WCZw5Dq69olLkCrzFW+qWnodqb3cRA6WzBNJY+cFO6etUpT/VV+ljLIPusFC2rPweXETGc9/O8RI2Fj0vV9aUuT3YKFKNr3X50DKxOPDgGlSJRAP5y3MRXy2NSIIX87ZvlT2AGTsrGdKa6l/qv8A+wczT9UNdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKYPj2x32OhTQlts7qB12ypHjKxKv0v9rfovJqQFo9Q=;
 b=gHOaKgqslq+TAw3qdCcE/VQNyq9Uetx2VdTqyT+frNXKPRv4JEYkKV/LhDNVONtiPww08STUziKt1+iJ5RkKzRXDr/DRSWJzxq3wrC0pe/B+evaDDnJ4vHS4DJkBv8kfqvjOroD8pw6NFMj5W681IToecabCpen9Ebu8bZIkwmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 17:08:46 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:08:46 +0000
Message-ID: <5209dc5a-fc36-3771-29d5-8f89d5e20417@amd.com>
Date:   Tue, 12 Jul 2022 12:08:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 02/14] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Content-Language: en-US
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220709141739.834950-1-Perry.Yuan@amd.com>
 <39717316-281a-6c3a-4228-54210e5320dd@amd.com>
 <DM4PR12MB527807833BAE794396B4B6149C869@DM4PR12MB5278.namprd12.prod.outlook.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <DM4PR12MB527807833BAE794396B4B6149C869@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35f72d22-c871-430b-9f7f-08da64292e4c
X-MS-TrafficTypeDiagnostic: DM4PR12MB6111:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7/0L23yZTGamV+3Emwxv2EOI2TJjcoV0z0Tn+TfKYAeRi2Em6zzzrLMZbAb0QLCpCV12aA1iEIuBJJcYSzfM7Et51iBkSm664fnoDEZb5v6Jz2r7uEo0YPxIOkoOeu2VpGAs77RebO9uT8XrALGKZNI8lXBffcza1lI7OjdfXH49W5UEFUPqbflY5zQ6uDxl9bNyI+0k14sCNDUVmhsBNsI0My2s+LmSTNm8GZiM1N016MnsUIMl/o0aUrFQQPWpddHsAjFZpqu1KB/FPXVJUyoeAjNUQpjssRJiDW3Axt7wNfssYw1/hrAs9oaT8E/SC4sJQKjnewCBLwVzNtbSl2iqMio3U3rq40ms9SE+fSg9Br24ydTKa1fA7swYI67x5MD0bsg0hf9k7qraD/Q8CRguT9iNvA3M2Eg52fXLAg7Ep+nKnb2khG9/QnhUURDnYoDZiciBEMJLJPQAVPpUMlz+Yg/RObBI3+TEl4duGylHq3XyO6QUZjf0/RCtmUIO+g6GM9t0whfIVhMvPoDPyJopYhjaoN0vrifvfXzXMRrdUDLd8InPeCRupE/20omq2JRa+aVz1/ieTPqLu1KXx5x0BNzvuxl1FCmVGSaXZSHZAKDijwicVyAAxcN2H8wUCr6pHXrn1Uf75jyEzsWnJ+gDtSPHixBG/Fqrht63VOImChrKQBIX60VvdAMWlJVczCz70PvXeWwpiZApxB7KkzEbQMGfh6ZlWrAwarOaFZ6vLgTDfSD21XaA9zN7oyY2/jgps5ew6ABqAFbJTsUjloIuX3JVemB6ZrmZqcBZ+PcqtdwLFmvvvPRwCW2swayb5yU/zn27jKq4mVGbk6KCfYLMrCc8AKATL06J3/fHYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38100700002)(66476007)(316002)(4326008)(8676002)(66556008)(8936002)(41300700001)(5660300002)(2906002)(6486002)(2616005)(31696002)(110136005)(186003)(66946007)(83380400001)(478600001)(6506007)(6666004)(31686004)(36756003)(6512007)(6636002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdIcmFQVWNGYkhWcmRIL3RLU3BaMXF4TnhsZWZqNWhFcDQ5ZFB4OTY4cnZt?=
 =?utf-8?B?emR6ZUttTnc3VTlYeFlsbzBiS1lyMjJUcldHSjBrRXRsRHE0VXZaSU5BYjg0?=
 =?utf-8?B?cXMzTWxNbDdzc2N0dWtpRXIwMkxvT2pQQTVrV3lUanJLYUhvc0VXUUFkQVls?=
 =?utf-8?B?NjRnRHFaWDEwaHFlclk1a3E4a2ljWUYyT3lIMnJFSStiV0ZSRTFWVEwwT2FP?=
 =?utf-8?B?eDU1U2VNb2tIUThHeDhlTGo4ekdxb1RGeGN4VW5lQ3o1d3RZRnM2L0xFeTNm?=
 =?utf-8?B?YVY1Q2dNaDJnblJ4V3BPSkZ1M0JPNDI0NmVxeis3R28yV1NnNGpwVVB2ZjRv?=
 =?utf-8?B?REk0bi9FVXBIUHZTMzhtbjdabHFMTTJoQ3RzNDZMS2FtVExRWG52bGFQUUdW?=
 =?utf-8?B?QXNKbmV2WnNHb2RkSHBJK1ZsUGVNUGwySWNDangxcFVmUEYwTWtKV1hTVk9t?=
 =?utf-8?B?U0lLS0JZS2Fxa0h3RUtkRjRxU1BOY2VsdU9HejdnNTRMWWpMY0ZSdmRoRmov?=
 =?utf-8?B?SVNEc1pxTEhrQ3VROTNVZWlYQVhiTFdQYnU5OU8rME1qZTVZK2wxcVllWFY0?=
 =?utf-8?B?ZHkxZDhCM29Icm1OZk9WQ2pwZ0tqb2Iva2ZFSmpYMnlMZS9iN3lKaDJmVWRD?=
 =?utf-8?B?MXVDdU9CRGN2WmtGejhtSlgwKzBKeDM3OGVDbVh3TFE0NDc1cGk4TGEyNkNW?=
 =?utf-8?B?cTBXMXA3TVFIa0RIRjFWRUtxdEM4OEZTU3YvamFUc0J4Y21mMnUvd05Sd2Ez?=
 =?utf-8?B?U3k2ZU50bnEwOHR0cjBCM0Y2OFgzSVdBK1pVTEdaQlpjYVlQNGEyMGl5RHlQ?=
 =?utf-8?B?L1VCYi9nTWdzMkk4Yi9GUUZDZ1BUY2I2amxJbGJFaDFja3BCRHJVQ25ISXRi?=
 =?utf-8?B?TStuS3hrMTgrUWxXQktVZVJkTHNkeTE1Z1RhTjMvRnRtQXFMcGovYkp6ZFFV?=
 =?utf-8?B?Mjh4aS9iL3g0VDlPOXRJOTZIZkRuL2FlMXZmZU82N2lKS2RwcVpmcEFHNUh5?=
 =?utf-8?B?bnlHMnl0bEp1T2hHeWZRZW9yN09HYjRtaWVLdEV4UzFjOFNaSFBXbXJ3eDZ0?=
 =?utf-8?B?Q3NIZzNpcWdySUN5SVdaakJDYzlvZFFtNUVMZGU2WGkvckFrTm9TNVJCV3hC?=
 =?utf-8?B?aTZldU9DZmNRUDFVQ09LaVNqT1JOUjExVXlyTUpFUW4yYTd1OEJTd2o5bjBD?=
 =?utf-8?B?cDRpdkdMa3IzZXFMUWdnMjZaSWpmUXVPdlkxT0x4MmhuUUJMY1g5YXJ3NEpr?=
 =?utf-8?B?bkUwNnU1MUNZSkY2S1ZhWmZTb1B5OW5JZ2Z3Q0ErNHpQMHk4emRIb3Q4UTV3?=
 =?utf-8?B?ZnpEY0RlbkRTK1pHTlVQNlRCMHhTQUk2c096TEdtcWFCU1dIU2RNWWFHaTNl?=
 =?utf-8?B?Z0hkMkNWMU1hNW5oeTEwN3pkTXpwZWpoeFBoc2UwcUN1RGNPVzZpSEtVK0Jq?=
 =?utf-8?B?aWhORG5uSDB1SUlSSnlzeFNhc09kM2xGODRVb0IzRWVCck4xcGhkRTBzeEFZ?=
 =?utf-8?B?QWlEdHQvZXE4SkgwMDRsV2FkTVVJQU9qSEREUS9zOHpnVUVFWjR5R2ZuZUpl?=
 =?utf-8?B?dGJPVVlKckhmaWEwdnRvekhURGVlQlU0MXV2M1JQUVdCa0FYamR0VTNuMGtk?=
 =?utf-8?B?czgzaVA2dTdINWtkaTZCRVhGaEcvemE1NzIwdzV5M2xLdnhYcnNDak45dDFK?=
 =?utf-8?B?ZE50eXF2M1BPN3JqVHJNRy9OZGVZOVV2N1h1SzEvZExTWWRoVWtFcGlPZ0kz?=
 =?utf-8?B?K1l6em16bEtvc2FQcno3RDdBWTQvLzdMeTE1NVc4cWMvNUZDZ0lKSnN4bkdx?=
 =?utf-8?B?NmRycXFvbk9Dbk13ZUNJVWdYZnM1RmJPLys3bTEzOWF6cG9Cd0poSi9WTXRl?=
 =?utf-8?B?aFlVUTNOYUxOZHlmZ0l4L0xJdmp3Y3hBYU5Td1hVNGdKYzVjTGIxMWJSUkVV?=
 =?utf-8?B?TzhVWG15aU83UkZFZkwyN3puNjNvblhQakw0Q285dGVoWDdwTVRpQmoxVC9p?=
 =?utf-8?B?Y2dRUWlzZGpoV2dkeERTdzk1Njhna1puVXVSWWxqaXZmSkQ4dS9OVlNXUzJr?=
 =?utf-8?B?T05tTVJMd2M1VkNzZUtwSEJvV2NDc25hU3JDZGJmeHFqb1FRemY0eUk4aitS?=
 =?utf-8?B?ZWlhOWtpOG1qemJYRW0zSFhoNHJ4U2VIaEtXcEZpSkFLZTlaRXFvSU9TTVlB?=
 =?utf-8?Q?oKQducuibA+UWvikf2MDYWsDhG5qv6wuX1Y9BvkOoMhW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f72d22-c871-430b-9f7f-08da64292e4c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:08:46.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9ItvfY2X8XT3joXo4lu7qeCsUk0pMq/CmT13OVeyUI22dH5kpBTMKVyEf/aG+7Tjz22rdgIEWsUzDUuvAK+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 23:15, Yuan, Perry wrote:>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -122,6 +122,7 @@ struct amd_cpudata {
>>>
>>>  	u64 freq;
>>>  	bool	boost_supported;
>>> +	u64 	cppc_hw_conf_cached;
>>>  };
>>>
>>>  static inline int pstate_enable(bool enable) @@ -438,18 +439,27 @@
>>> static int amd_pstate_set_boost(struct cpufreq_policy *policy, int
>>> state)  {
>>>  	struct amd_cpudata *cpudata = policy->driver_data;
>>>  	int ret;
>>> +	u64 value;
>>>
>>>  	if (!cpudata->boost_supported) {
>>>  		pr_err("Boost mode is not supported by this processor or
>> SBIOS\n");
>>>  		return -EINVAL;
>>>  	}
>>>
>>> -	if (state)
>>> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL,
>> &value);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (state) {
>>> +		value |= AMD_CPPC_PRECISION_BOOST_ENABLED;
>>>  		policy->cpuinfo.max_freq = cpudata->max_freq;
>>> -	else
>>> +	} else {
>>> +		value &= ~AMD_CPPC_PRECISION_BOOST_ENABLED;
>>>  		policy->cpuinfo.max_freq = cpudata->nominal_freq;
>>> -
>>> +	}
>>>  	policy->max = policy->cpuinfo.max_freq;
>>> +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
>>
>> Does the entire MSR value need to be cached? We only care about the
>> boost enabled bit so it may be better to just cache that.
>>
>> -Nathan
> 
> I think the whole MSR value should be cached, because it has no bad impact to the hardware or driver .
> And it is simple to do that, when we need to check other bits in the hardware configuration MSR in future, we can still use this cached value as well.
> Dose it make sense ?
> 
> Perry.
> 

The MSR controls much more than boost enabling, my concern is someone else starting to update
bits in the MSR and now we have a stale MSR value. Just caching the boost enabled bit is really
aimed at possible future bug prevention.

-Nathan
