Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C950FF28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbiDZNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351028AbiDZNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:38:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4407245BC;
        Tue, 26 Apr 2022 06:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpxws5yPHhKtG+2xU8S4VemUvWGUy54yOwO/8aPTwPzDckKI0ctPAsaLBh63p5tZ1+v6+BnziuYAiHL9mSAdaFjOGj2fN3Iy84drqT3OcQlTouNxLkPMW/3OuOV084yLSIscl/9WGJh2hhBFbyeF75WAomXME/YOXFoneUY0uCecJWlEX21Mem32uM2QNpQB5PLSfJjVvRRdEI3p6LfhNBCUsNbMsRloiwNi9uPfwKis04TjKrROLPENxJIphkxXqlkWulgO1O7n5JJ0X0JbDbE14LMwLb4btYLW8ventVCQYGp9I+drbLG8yrjhntCYVEbDykjWdi1kVBE5z35ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1J3W3wMYB2rvKkujRKoXf8jkLDH55OmBK2fzAeArl0=;
 b=IgOZb1iiiE3Vk9y8bIScppO/gCij3SnNzt6qcrqCeNlRDmgdarqHBBOkzEx9zdKbBMAgGYLU7WPwq7j8YTWegD4hb2cQhTxRJK8JBK1Ez2Pvq0laQt5VYFDzVXI5SQhFsaRXqNaEiX/xKAhGtKBHs9htyUI9gfhuTTHgkU3u6fxqPDYonQf4hTddb9U2dy4IqeLvSI05dLzZazqS7UpfchPitOKCxfne9ytiVidtnhWHh09u+YXz3IoKjazyWqe1+uS+gEdMg2UPYO18135gUv4HNObpSUl7kLWCb7DtjOkbj60DpyX8aPAg60uzgNAfFDC3bgpMs6nGR/RmmG95qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1J3W3wMYB2rvKkujRKoXf8jkLDH55OmBK2fzAeArl0=;
 b=IyWkDHQmVgdiolXJUuB/6PPeKJcpDgcjtMO7r2fQsevcmX21FND8kmucIPftl+81a0TfejfqmDk2Xb9WIiUL5aFqhUTeHX+3wIH7Og4GdLQwp2IfwOl+MH3BxmkSfKOPomu3BsryNUqc49GWajMyIHiMAYmOPO3ms616MFFv1+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 13:35:11 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:35:11 +0000
Message-ID: <66d766e6-2bd2-55a9-5d08-2335b44c0886@amd.com>
Date:   Tue, 26 Apr 2022 19:04:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 5/6] perf/tool/amd/ibs: Support new IBS bits in raw trace
 dump
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        irogers@google.com, yao.jin@linux.intel.com, james.clark@arm.com,
        leo.yan@linaro.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>,
        acme@kernel.org, jolsa@kernel.org
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-6-ravi.bangoria@amd.com>
 <YmfXC9KrsM0xTqY9@rric.localdomain>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YmfXC9KrsM0xTqY9@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::33) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc80e17-14ce-49a2-3af6-08da278995f9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25201EFE6773FBC80BF28790E0FB9@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsKJKLiEsoZi+nb2sx/dLLsFkV0fDIqu1ym9a6QtExGbP42nxjUEL206Jf2Pd+ecRTYAhuz4u923Q1QNNVwjPLsnArnAz9zfGx2VCZMqThVpQLoUIgs6tt4FBdrzOoBxwCxY5X2W4i3qFcV0LRIGCONz24YMANikulIrEBc5MyTT/nzaLyu/zNgfR2HbjtKCzFR6bf9GxpXI4eh2QtR1qWHBVwnIx2qCrIhUDwj3g+2WqgNhKnAIDeCsiLkti7Xer8GPSkfNHB5+EYDcFN/rAboBNktd60CbX8BxgJdUBoBpqDfscTTIfl/W9bCzcSDEzTZZg1LtLwuZvMqo3Jy8pxVcSBOqlScggFlgVPAZozMMsvD95y99P+460MMsBZmzQKm7b38xbgg8HE34Yk46JJslVhb0nhHwGrz7hJ116oEFHWYLoLLplKQLsM1LDRP8m8Ck6f20Xe/eaFZfvUAGt/xPZoZ5t+jCXm8DhzLP/ETnqTdVGwH/0NTIiv6pfzXy6RTiFQyogxbLAgY4Rywfpjzg5HpCnvLsR9naltGVA7SQd6p9vKz1o7lu7qglVJv1sgjkRCsZmH2bxszm0gvrjmrjj2XLcFUeqO0HWMxbOQVCu7MJDKEW9w91kdlx2RwpiliyLqh8K8uHkO0TNdCEoENe9TxOdBJa9PpAczGSJElRIceOOqbC9PIlDIeQW/FQJAu4gks0jCErsIfgVLnpqHVfoUrvPGUywdn66GTO7dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(26005)(186003)(37006003)(6636002)(6506007)(6512007)(36756003)(31686004)(6486002)(508600001)(2616005)(5660300002)(86362001)(31696002)(316002)(38100700002)(2906002)(7416002)(6666004)(66946007)(6862004)(8676002)(66476007)(4326008)(8936002)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1UwT2R5TFdzZzI5M1dMVDVlSkdqdTRmS1p3UzBDUlk2YllyZVlWU3FRcFVX?=
 =?utf-8?B?dzBKN0lnbVpDcUtTS3NOdysreEFwaE9Cc2ljVjAvTlhReEYzK21hRUxndWEr?=
 =?utf-8?B?SHhGbWRnOEh5ZUpPMUVFcXlxLzNvVURrUXR5dFhlb2JQbUdtZW51VExSdEJp?=
 =?utf-8?B?WWM2YVdwKysxOHlSWnRXSHVqUUtwUXpFRG1IUExRWUZPODZQZVptTWV1ZVlk?=
 =?utf-8?B?ejBMd1JkZnV1L1RVMUR5UlV4RFZFR0VSbTNpTFlUT1dwVGRDckxmaHRBUnhS?=
 =?utf-8?B?VUVFWEhGNklrZFpjcWlmeUs2enYzSWZrbFJ5WXhnRnYzR1VJQ0FwRUdvdGhh?=
 =?utf-8?B?SUFQenhZQVpQcEFNeHZNUTY4V0pVTENWZXFVSlRjdTZDY0pjWVhOcjVkRWRv?=
 =?utf-8?B?RTFvT1RySUZmaVFhZWtXMEgybTlEOFVGdlo5WXIwcktSeEJERGtoemNrdXp4?=
 =?utf-8?B?WmNHVnBrQytrU3Noa1BWSjkwaExOSWVLUHZ0RU9ZNC9ObThLeDhzUEZwNzkv?=
 =?utf-8?B?aXIrYnlwVnpoVjdxTlZVVXYyeGN1bGp6cEVsaklIK25WOWlTeEl5OFcwaGww?=
 =?utf-8?B?dkxwV3l2b25Tam94UVhaT2Q2NkFXQkliY29CYUZJVlF6bDNjTDhTeERuUHRr?=
 =?utf-8?B?cGw0b0x1dUNmeStyK0ZIbTRHam5sdURZSVBTQVV5TXJIL0xxOHA2RExuYUxN?=
 =?utf-8?B?WktPeHVCT0FjRzd0dWtVSzZRUXZydVNWTTFtTmZHQXpnaFhOeThUdkNxWmF5?=
 =?utf-8?B?SjY1ZVZzMUg3WkwweU9McGJkMFJpUUdpNGxDcWRkVkl6UTB6a1YxU3RUbWhs?=
 =?utf-8?B?Q0JVeWZaNjFEWEpMU2xOR2crWGM0dEpOcGpaNmphSlMyNmNPV0F3bnQyTUJz?=
 =?utf-8?B?WHFzRHU5SU55V0hDQTQrbDkzWHg2TDBWSVJLeGhrbjA1TXNwbDhDSWdpdFlI?=
 =?utf-8?B?NHZ3WnJsSlFZWjdzVzE5T09NK0NTWk9yMUN3RGd2QmxWZGxZdDNiNTVwUkx3?=
 =?utf-8?B?R2VpYmxZNzBsY050RDZiM2luR1pSbm5IWkxsNGhLekZqeGpqYlM0V3BiWFdx?=
 =?utf-8?B?RGRYSUdaTk5pMHRTc1U1cjZvb0xKSUhhOUxOanNFVEhITWwwdk9QZG41dTVs?=
 =?utf-8?B?cjVaWmU5TjBjekM0NS9jZWJCSGNmcjNBZjd4SE5tUi9vN1NCVTEzVXMvY2RY?=
 =?utf-8?B?T3JsL2pQUG0wMzAzUVdCK0tCYVhGVlJOakN3OWN2dDdzaFJUdjR6bk5uUGVa?=
 =?utf-8?B?Tk02NUgxamRMZjBSemp3MHJmUTd4bHdPRUp5Z25DOHhLQXVNUE9aU25GaFEx?=
 =?utf-8?B?QmlFRTdTbTA0bm5uTlhiNS9uVHZmakJ6dnhPSlB6YklEQXZVSVg0Z1lPaWQ5?=
 =?utf-8?B?cEltLzRsNkhTWURwS1IycHdVckZPVS9FV0RxZHV2UVk3VzJZN2F6RGlUS0NM?=
 =?utf-8?B?VGhvNVBkQ1I1cTVlbFBFTmF1RTduc0JoZVZzdG4zT3pBWnNaOTB6aFlwOURl?=
 =?utf-8?B?NnNRMTU1U09tNlZvYU9OR3VLSkhob0ZGcHJHNGpYVWIvemllQkIwcDlkSGlM?=
 =?utf-8?B?SVhCNW80K0xyU0hjNlhuUEI2K29tRGdncU50V3dxVVZrT2l4dGo1YW5pNDUy?=
 =?utf-8?B?UmZKZmZOd1FlaDYyNkRIcFJWSHNTQ1JwOXFzMUF6TUYxdlF4YTMzdHNzdDFN?=
 =?utf-8?B?NDZHVjZpc1N2VnF4d1N4dnNERUF5TzBOV1IwV0Z6MENSTmVPRHRZRGZpaXo3?=
 =?utf-8?B?b1Y0VDIzLzNLTWpDbUxzU0xJcHd1RkE5dUp5VUFFS09NTnhTc3VYbEFuRU96?=
 =?utf-8?B?Vm9pZDY4NnJEaVo4cXUyNEhGdUVPT3J4d1g5L2VjNzU0SUl6S3VuUHNleEhx?=
 =?utf-8?B?VjY2THExRjJyRXpYQnFQdGlBU25ISzZzNVZIeUFWTDQ2bmh1YlZSSlJEUExx?=
 =?utf-8?B?RzZPSE1FaDVJQVorUFRhNVJhajgvem5KcVl1SnpjOGxnR056RGVRMFN2SlU3?=
 =?utf-8?B?ajFBSGVoNlFGU1NFbGdrejNkV3U2T1BhTnAyN2FISS92b2kvOExhOWJnbUZ2?=
 =?utf-8?B?WmdxdEpsZ2tlRmc4VXJ6ZjhXWklWL3F1TXJFMnU5WFZINUxoZ0tuNFc0T3RH?=
 =?utf-8?B?QzVtWmZ6eldIaWxnd3Nkc2hBV2pnaEg5Q1N2VUQ3a0h2Sjg1TEdqYTUvdURD?=
 =?utf-8?B?eHVFcW1lTlhKRmdweWF6ZlIyTmJ4anNBa0tDdEhFcEoyajVKOW9lKzdUUzAx?=
 =?utf-8?B?cGlNUlhkdWpnQTZqV1E2Y3lyZkNZUkdSWHROekF3V2dQSUZ0cjd6Z1dCbzd5?=
 =?utf-8?B?dnZ3SjBIcDlGY0xqME5ubk9Jc3lqSlVBT0hQVlZNa0hMbUE0ODh4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc80e17-14ce-49a2-3af6-08da278995f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:35:11.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9USBUKWvM78uXMQ52uwV780Yczf7wQgnkcZJRIhB2euBs4vYfBl2t5tSS/RGzytAEqdyJ5McvJl2IBUfs3IcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 4:57 PM, Robert Richter wrote:
> On 25.04.22 10:13:22, Ravi Bangoria wrote:
> 
>> @@ -71,11 +74,12 @@ union ibs_op_data {
>>  union ibs_op_data2 {
>>  	__u64 val;
>>  	struct {
>> -		__u64	data_src:3,	/* 0-2: data source */
>> +		__u64	data_src_lo:3,	/* 0-2: data source low */
>>  			reserved0:1,	/* 3: reserved */
>>  			rmt_node:1,	/* 4: destination node */
>>  			cache_hit_st:1,	/* 5: cache hit state */
>> -			reserved1:57;	/* 5-63: reserved */
>> +			data_src_hi:2,	/* 6-7: data source high */
>> +			reserved1:56;	/* 8-63: reserved */
> 
> Good catch, bit 63 was not defined before.

Thanks!

> 
>>  	};
>>  };
> 
>> @@ -279,6 +328,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
>>  		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
>>  	}
>>  
>> +	if (perf_env__find_pmu_cap(env, 0, "ibs_op", "zen4_ibs_extensions"))
>> +		zen4_ibs_extensions = 1;
>> +
> 
> This caps check should be moved to ibs_op and ibs_fetch pmu specific
> code. Use the env of the specific pmu respectively in the sample
> decoding.

IIRC, we don't populate perf_pmu at 'perf report' time as we might not be
running 'perf report' on the same machine or even same arch.

Thanks for the review,
Ravi
