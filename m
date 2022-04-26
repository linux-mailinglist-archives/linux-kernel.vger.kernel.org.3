Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5250FC53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349715AbiDZL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349707AbiDZL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:57:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A950E71A3E;
        Tue, 26 Apr 2022 04:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0ma7MQByHD5WRgJUCcL9iaMxL+38RBbjn/TCvM5vAwxwNOBesiFQFriybuAaAzGg9TvN0p42Q7L6Pev11l2RFJw34W9pU84zvC45jEp9Vz/mFKJ5ssfi5M99+odfUODqyCg8Tig3lG0Non3Rxath5t9JVe1hbRLwtITv8lvKluOzedYCtfAUcRRgWdIr9v4DbqtABAt0+DhU7NnO2H/PeYfTiKRB+aN73OajRSWVKVz+9Lt4LqClLgSmaYiSsNhSFKgM4clLPW1VlFuGRMEzFpTWJ4eeUfKmDj8wFgkd1EyZvcG36ObJTZvs02s7p2WRQCJLSCeKNU+mWN9TRXkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28I+JFMP55pT7M4/SZoCZQ6qT/lOEt7VxR25MZezPD0=;
 b=mVxPo8hSkeqaafW0OKUWd2pSxKalBqPq59aiytRdrMRwsM0xp/v62aNMs4DyJheOaAz18AvlGbaiyAfenXFC7+INUzsGhLBXFJv+mRCBVuYNrkrSkipdCtt0xnPU6OgWYI2ZNnCgN4N9nqTmvs/nziiec2SN/dfcfyV0A6C6wwWeLOY4G3o5fO46gB+AZNKpd0T2lGi5mz/oplMlAxDQARUdmlnYVZO/kYF5FUEUU9icoMQ+so9lI0IJvepDwltsoJ9iT8qAIf7w6bq5/zVKMTLQcWJFJESpWjYvLD0n63UYkwupIuwJ0GnB/uYMxF49nUMAHOui97KiniI2KAku7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28I+JFMP55pT7M4/SZoCZQ6qT/lOEt7VxR25MZezPD0=;
 b=bjQooRxJsnYJhZR3PmfNqlYZX+m0M0CbrTR8aUkrATi2gXTN5dDZhC9Pk8pqkkPzqjGw/H2Sq97EpNNrmlCqAbXydJJ/Sr7HLeCs8PEFnviU9de/sVvRLiKsN6S3r9Oe0jnElNLBRnzPp11fyWtenL0JiHKFTZQf5B1FZOpzB9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 11:53:56 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:53:56 +0000
Message-ID: <5fbcc127-cad7-1f8e-31a8-bf71f6f17e13@amd.com>
Date:   Tue, 26 Apr 2022 17:23:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/6] perf/tool: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-5-ravi.bangoria@amd.com>
 <YmfLU/VMQI0g0Ck0@rric.localdomain>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YmfLU/VMQI0g0Ck0@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 499b6b5a-271d-4682-5377-08da277b712b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32933C0C74F449DF684071D7E0FB9@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4BaDCjspTsvk+iCp92uNgJaIMXR8wRixnRxwTZM1y9Q/Nt2XXnDXqAhxgkhQXTtu6dMfGDhjm57NRx7C/hQ5dJt35ilSCUW0I7R7zdHdFfk3pz++IzdTbC7SroAN3MuiDOl+zrRDEAIpQLvsJ0VROYTTXi5pCTLGNC4Okvq7ia9ebT+Ig810Q65I2fduxXsJHG2AVkEVrgce+3t5M9j8DVyum/RY/jUJGp77JrBybVBcOxmqJTcCHhsmlBnaLIz6S8YTnp/LHxhRxrvcM3W/4JIkOGNpraqlr87qmceqkuy2vuqUTooyCX9uyOGU064/oxGYaID/cOvdufgdKo33BEAFmnVYxPWVqqKflAk4xPBSK3v8UVK4k8S8PRna6fkI9lpy8lK6mX0GrQRu0nbj4sp/CHBKJy/MAburs00xuNg0qD90Z+iizTo+ux79VEOXyZynctlgVc7I6slets5w/IQcJMA27XZxcRZoQjDFLgwUAukSc88BUp2RCuoT8IjltJo7HFrC/ysMsoTO4gCegNF3gPHRInH23gI7Ok5U+PTVZyAv816NTRYf+3c6EykoIpie8Ri3LPvgWRkKxEKhP/paBACeXU+0LRwXbcSQUtDYw9S8q+3u6P8MVsCwy3TYQOLUvn9//gjE+AbRcpCcVQBjPKSFbSzOPxWqdsM8RYsuB0k3kD96nYuGTVIBPGUHCqWMmYMq7XFJsjmF9YQM1eUr/ZdzEYuKjO5H11O3ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(508600001)(44832011)(8676002)(2906002)(66946007)(2616005)(66556008)(66476007)(31686004)(4326008)(36756003)(6512007)(6862004)(26005)(6666004)(38100700002)(316002)(7416002)(5660300002)(37006003)(6486002)(6636002)(31696002)(186003)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGlxZTR2YmVsazVNNjV0cHh2dDZRYllUb1YyZU9YUFhHalhjdTZIaDFhRXJ2?=
 =?utf-8?B?c29SWmVoMnFld3QzRjhUa0tBcE5qQ3FFVU5SdmRCYml0dC9YRThFSVpkVW1o?=
 =?utf-8?B?cWtwSVZkZE1PcktOUUgrb2RVL3J2NXNQS3VOTUFHL1BxUmRnVDFCTkd5YVRj?=
 =?utf-8?B?RVVHQUd3eDUvdlNWOXVMd1F4Yk9sSWJOWm5pZXlNbENDM1VPRE1RUXhTLzFC?=
 =?utf-8?B?SjNHMmppSUc5SnptQkRyWEJ4SjhERDJFTkRaQnYyangwMFpvUWhHS3RwNHQ5?=
 =?utf-8?B?NEdhMitxZmIrOS8vVTJ4MjZLKzdYTDBpQnQyNmZlSk0zdEdVa3R0Qi9nbXRj?=
 =?utf-8?B?MkxHeWlKUFFBaG0xOE0wSWt0ZUlscEdOZWJ0MXlWSTdOZXJtL0F6MVZVMEZJ?=
 =?utf-8?B?ekVZRGg1bzA5bHBuQ1diU3RWbkxCTTVzRDZjdGtLdGhpWTg4R25lc2RYTGRT?=
 =?utf-8?B?ekZtbTYzK3FtRXJ6SGp0VDNhc0xyRnBITXZ1ZjU3b0g5emZmVGxGdDY0a3hr?=
 =?utf-8?B?QW5zYnRYbm9RTjVDVzlUc0Rva3V5ektOTlVMbWV2cFYrU25iN29JUUZmcjhJ?=
 =?utf-8?B?QmtDTXNwUGxQRTRLRS9MSGc1bjNRR3h0S044RElQdXdsT29KYVo5R1QxUnFh?=
 =?utf-8?B?cmpwOGNKc3BWdXlqZm5ZK3Q5TUZBY0dQYVJZRlRqNFVlSy9NbmJmeWpaeDlJ?=
 =?utf-8?B?U0o0aXR0c01RT28xOUFCTUp3QmxxaVBHR0RuRGZsQ2tSamVkaituOVV5SGhk?=
 =?utf-8?B?ZlRPWDdRSE1EcGZHMy9CamxCSTRnbHAzVmpMRnVmOFhZYnpuVVBJUUV0M05W?=
 =?utf-8?B?RTRaVjkrVTRBSngzU1NKWkxFbXdjOFA2eFlJSkkyQzhuTXlsc01FN2wvTm5x?=
 =?utf-8?B?UEN0QUMrVHVIakhINHlhTkdORU9zVTNhUCtDVHNiQmdocHpXR0hvMERVdUN3?=
 =?utf-8?B?YlF6cVhtejM4bmpLUjBQMzFnUUJTalJPaERKekNXNlQxN3Rxbzg3anVkbEVz?=
 =?utf-8?B?VS9lNEYrNTAzbURxaUZ4b3lTMGgxb1NjUlVpWFZtVEhKTTVwQjN0OERhZkd5?=
 =?utf-8?B?eVlrNUxNMUZkVHFaTW1Db0tNQjU2b1AvV0ZJUUZpb3QrM240RWNGN2M5c3JL?=
 =?utf-8?B?TklQMUJvaEpaTEl0b21zZnhjTDNITXRKUE1FMzg1ejFHQ040NkI3QUxJRmxU?=
 =?utf-8?B?a200SkhtYkw0WGtzVFdhZFVBd05EMUc1VS9wNExMMkdJSjU2c29mWHljSG9N?=
 =?utf-8?B?eGVQNEg2MGFXSW9CZkxuVjRuZ1g0M0l0cVRvYU5JOTRlTS9na25WaUVPRyth?=
 =?utf-8?B?bk1EaWJ3ODl5NmcrYUc2Q2praUJESUpnQkREeFExZFdBcm1WRVhBcmFvckpC?=
 =?utf-8?B?aitIRGRkSXMrL1UyYXFnWENXYlErZmsvc2JwM0Zid0RjRW5zS05KdFJPMk1R?=
 =?utf-8?B?VlJqNDdkaUE4eElkQTR6VWtUb2p5aldIRVA0RVgwNllvK0ZjcTVYOHEyUlND?=
 =?utf-8?B?Q1kwYWhWc0ZiQVdzSXY3Zmh1N2tRQWtYU0M1ZGpDRnExcFlHNisyVTRLUmpl?=
 =?utf-8?B?Z09rS3BoVHJCVzlZdGpKMXRzLzl2YmM0b3RveVpHclc4dTF6b1ZGbnNpZkNs?=
 =?utf-8?B?OU9JWm9iTGJkb0NvM0FXK3F3azNpMnZaUEYyWEpSMmlqeDVrNmJuSVNLSzFz?=
 =?utf-8?B?MitKczVvMURpV2o5M1JmdHNsMjVCQm5VdFRXZmZDNkkrQzR4ckpqdlBiNVRQ?=
 =?utf-8?B?Vzc1YW1ZWEdqVUMrT0FPcWxYNlg0Ykg0V3ZER3JIMXBhb01Gb0ZsOCtUbllT?=
 =?utf-8?B?VzBCaFR3NGd1Ym1DaGlhK0hrNmFtZkQwcWpObVpDT2Q5YW10b1YyVkhuVWk2?=
 =?utf-8?B?NHRibWYxaS9DSHVBdnZGTnBYcWxtd0I1V3NrV25ScEVLemkzVmxYZ0VtSzZD?=
 =?utf-8?B?aE9TcisxbDNFRUd4MGhWbklaYTVXSENJbVd3R2VMeVhOQTdhL3FIckFCbjhY?=
 =?utf-8?B?OVVmZVJhcVF0ZzRaRWdldXZJOFRXUSt6RFRidGI0OVBHZmgxNXlvdE12SkpM?=
 =?utf-8?B?MmNPNHc3MDR5Z0dWaGxNYm0xS2c0OERDTTE0bWtpdTVSWFhMS1FlUVVqSnlp?=
 =?utf-8?B?V2RRZ2dEbGp2OXUxMzh6TC9UTWRtc1c5QXVtWHJ5Y0k5OE4zcHI0WWhRUnF5?=
 =?utf-8?B?THJ5ZTlGU0w2Y3gzdUs0YkxCUC9rbDVtQ2FpbjVCYzl0YnV4bDY1ZkxZc2hB?=
 =?utf-8?B?YzE5L3ZTY3dEZEVoZ1FMR3lzcHBtdU5mdFNqdEtRRFBwSXlTSGJ6TmNJbnFI?=
 =?utf-8?B?RVpJeFRUTjkxZXRQQ2lWbFVqUWRzalZvcUVkT3JiUlZxbG1aejBDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b6b5a-271d-4682-5377-08da277b712b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:53:56.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHgEE0e4cTw6qLfzgqTAXl7HlWdXVv4M9WXCBxR9IxomO2/eKrZSINfDSxnu4hOViUWtXx7WMAklzY4r6AnYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-22 4:07 PM, Robert Richter wrote:
> On 25.04.22 10:13:21, Ravi Bangoria wrote:
> 
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index f56d0e0fbff6..dea3acb36558 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -435,6 +435,24 @@ struct {
>>  	} [nr_pmu];
>>  };
>>  
>> +	HEADER_PMU_CAPS = 32,
>> +
>> +	List of pmu capabilities (except cpu pmu which is already
>> +	covered by HEADER_CPU_PMU_CAPS)
>> +
>> +struct {
>> +	u32 nr_pmus;
>> +	struct {
>> +		u8 core_type;	/* For hybrid topology */
>> +		char pmu_name[];
>> +		u16 nr_caps;
>> +		struct {
>> +			char name[];
>> +			char value[];
>> +		} [nr_caps];
>> +	} [nr_pmus];
>> +};
>> +
> 
> This looks quite a bit complex and special.
> 
> Why not just reusing struct nr_cpu_pmu_caps (id 28)? Rename it and
> introduce macros for backwards compatability if needed.

No. HEADER_CPU_PMU_CAPS (id 28) is designed only for CPU pmu and can
not save more than one pmu data. A designed proposed in this patch
is generic and can be used to save capabilities of multiple pmus
within single header. Something like:

struct {
    nr_pmus=2,

    [0] = struct {
          core_type = 0,
          pmu_name = "ibs_fetch"
          nr_caps = 2,
          [0] = { .name = "cap1", .value = "value1" }
          [1] = { .name = "cap2", .value = "value2" }
    },

    [1] = struct {
          core_type = 0,
          pmu_name = "ibs_op"
          nr_caps = 3,
          [0] = { .name = "cap1", .value = "value1" }
          [1] = { .name = "cap2", .value = "value2" }
          [2] = { .name = "cap3", .value = "value3" }
    },
}

> 
> pmu_name is already encoded in sysfs and core_type could be a caps
> value?

pmu_name is needed to map capability with pmu. And core_type is needed
when same pmu is supported by multiple core types (like P-core / E-core
on Intel platform) but has different capabilities.

Thanks,
Ravi
