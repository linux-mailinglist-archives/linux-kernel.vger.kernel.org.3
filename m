Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592350FBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiDZL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349518AbiDZL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:28:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BD186C0;
        Tue, 26 Apr 2022 04:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1/4/hQS4sXldL1jepFZqAUQxTZhthwzJdz6gy97K3imUEE9SAtHPVMb1pey5VzKkCJ9nc0hj1mPgnpEHES9AwaWN+NueePbUx/A8yDMzPVuVZAiK08jgvwwtE5feJ0LlnPjNZpqS8KxVpyOUsaRFCiN/C9ULLktOqQGTYHSoSzbiRTNSTMpDovBKS4dLKolBol37tpVV7fh/2GuV2iSTxnNajln3lPI130+2fsoukafjVtSVrPUbBNuLq3KxZCagr5CSebGfmsyueFSnAqs1BPvx6X9lISd6GsNTl+VkVXg4q9Lw1vG17/oB1GqBaddWo2dIY/OFiieNohMDxMJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8usP10kxeViq4RbZg9i8IcxZ+DrLK+tm60yvU1/kmg=;
 b=YHWihfyHaJga4lVqAe9RPFEuWnqmey7ri2R3oomUWhxppjooHv1M2jdC7Kia06JJRyaaGtV5GdzM36hqQb566oKRoC0lIG30vJb78e5DoL2qFJ3LAW8sYhLw4KYgJQXPCgR9FCBPAgUnv/x1TJE+zkC3MUM9uYeIOMItRIgu9syxZCgPobBwr73S2+NyxEubjEMUHoznl6BeKBZfqSvraxud3gef71YpH52ULfrLarKrB2fTGY+tBChvwvGrd5Q9/pM4jc7kCi9zAKq3bAm8yIa2GloP9HqrU3xSqTTBSoWSNys0RPH4sRyxxr563oCDOjDJHBr6NM/IWhrwx2Z6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8usP10kxeViq4RbZg9i8IcxZ+DrLK+tm60yvU1/kmg=;
 b=gFhEPnPyZaiNtD6gc1WZ4PLat5KGOrpcnnbHQOwxuPWpZFKkGn7iP49xkZkt/iBXqjGju3+6wCcJQcyQrPMyeMD7YDxdxNwnPuy0J/HEtxcdzbx+SzXQh1woESEDCOPBihhnLCB9PLRpxrULXjzv3bUpAkqSTDg56s0/jOOuIAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 11:25:40 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::6807:1261:8f60:2449%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:25:40 +0000
Message-ID: <09b211c1-97d7-aac7-591d-347405c7998c@amd.com>
Date:   Tue, 26 Apr 2022 16:55:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/6] perf/amd/ibs: Add support for L3 miss filtering
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
 <20220425044323.2830-2-ravi.bangoria@amd.com>
 <Yme40JIJzdVTsC1h@rric.localdomain>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Yme40JIJzdVTsC1h@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 815a4f09-99db-4b7a-c638-08da27777e34
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021718E4854740311751CC18E0FB9@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWd21vvRi0Y9tq0iKTxJ0/s3i4Q2ezTsOXo2cms7ibC9F2l6k/7OuwZJ1OUmOyKO2Mm1B9UeqUnJ4NsiGfjKcPVqEjELX8kJeRlfByHe+xEpc+iLlI+hzJil1vsuxm2S4pPPyHt+Kc07tmt/55GzfStFjDOHxc7Wb9rNT0nzovuXCm7WXAE7OjAjl3vU68L6hJj1rkuauNCXGB5shpqlXUttJrcHMoh7YPvAB6syy/U68Gi+BzGnrP5JwVNPlMJglW+zxYZeeTkFrtJoRkujtr+oSo9eB2pKLAURzN1TxrZJoJsgrWmFBypcxB07PkmBAjaswbw+jbi1+VWw7xwCIxoAKy0y3G4iWJ9M72MGTjO1UCH4nK/gU/jpG4SIeX4Dc1XN83qluf5+xmxEi1WR9TFtHdelPkVJlVCpDh1DmQIb2VXLmvnC3gxvQbwGndLXDm/RSyP63e62Tvg4fe5kBkBRLwR3zhd1bZ8IZTQIZhIGGIywU+mV5o9fefFRSVe/U0iBa6qdSFIHyl+SVA7bR//jWozhaPPDU9s50Z8Dq94Tcr3mZatGGHdMMP4zSyRGre0KmSmdktrPr1uSBYgX8My/kSttC6DNhPYUm+H3CE6s+hv/WObVKj5DBSFrP85jUR7CuHd9OgbduoQU6ZlTP2OhRnZLHXnB1uA9CBgB5mxbwTvN7xOPI0bEORYKIvyUirl4yZcKPviNQBWXo9eDlpBgrhCiPF8hRE9orMf4GvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(6636002)(6506007)(2616005)(53546011)(37006003)(66946007)(8676002)(7416002)(6862004)(316002)(4326008)(5660300002)(44832011)(8936002)(31686004)(36756003)(66476007)(66556008)(6486002)(6666004)(6512007)(26005)(38100700002)(83380400001)(31696002)(508600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpHTzlCTThVOUVJVTBlWUlsZnBncC9mL2FhYmVWeUxnMGk3ZUt2QXhyT2Nx?=
 =?utf-8?B?b2xGbXhzT3hsNzEzZkVTVndCRDhvZEtScHhDblc2dXYra1dMcFVraDZmZTh5?=
 =?utf-8?B?ZUs5N3pQZHB5K3JwaUkxV3RXREcyQ1prM1BUcW5jTXFCeUtwNFJ6WU4yY2FB?=
 =?utf-8?B?QTd4WE1WQUhabWRvaGZZL0xyck5OZzZWTTR3dVJaV3pjSlpyN0JoUmpZQjcz?=
 =?utf-8?B?SWM3MkE3VTN2UkZIazNzK1NWamFJSGNVVjhwTDBkY1ZMV3ZqZHhWSUlDbmt3?=
 =?utf-8?B?b01sa3N4WnJicTZlZm9xTWFHL1l0ZlU1RjhYUXorSDMxUk5Edk91cldHVnY1?=
 =?utf-8?B?anMyemZCSWlBNVc0L0tRWCtPSzFPbmk3cXlTVjRSSWgramNIRDN0eVpPZVNX?=
 =?utf-8?B?RWdRKzZRV3kwK1dUQncydWRXeHA4L1hnVHRFU1RZYU42WnZTMk9RUmpWZzVH?=
 =?utf-8?B?YVNQR0FRcVM1bmt2ZGE0VDZLWElLZ2dWclZPdEc4QTRVcXEybC9JV3ZWak5p?=
 =?utf-8?B?VUY1dkxxK2Y0dE1tTjQ1UER0Q1VmRmdiZzNUdUxVUHRBUVFXRUNHU3B1S1BK?=
 =?utf-8?B?b29DNHhEdUxrSU9VYnRVUmFmeFlJeks5dXZKdFdSWXRsbm9DV1IzMGV2M2Za?=
 =?utf-8?B?SmZndStNWW5sYlJvT29RODJsbkRPdzBPRUJBQUdsa1dyNTJJSWZTeGk0bCtq?=
 =?utf-8?B?R1RTcWU5ajNUMlNpK3dOL3Z6T1ByaFRqb0dQbGJ6RTNWdjNYTitCTS9FQ2t6?=
 =?utf-8?B?TjVHaG1ZUTJKOVFsd2NaQnVZZ3ozeElUeDdPVmIybG9GYjVKTXc5Z29Pakkw?=
 =?utf-8?B?aENiVUF3c1R6YVloS0ZtakxqSGY3QUpWYmFSS2U1eCt2V2lWQXdNUitlNU5i?=
 =?utf-8?B?cUswWXkxR3VNQ3AxQnV1UURsTnVzejhERkJPcURBZ1hRN2FtK2MzOEVjUlow?=
 =?utf-8?B?c0d1ZjZaalBCalRlYTZNN3VBUE9zRFd3NEM2VnVRMGhGR010RDcwTHBwdG91?=
 =?utf-8?B?ejlXQzJ2QWZKdytmbFNjU0hxbWFvYUZzRUtFY0VOLzN3a1VLQ0lwa3N5VU03?=
 =?utf-8?B?TnM1WG1QbTRIbEpJeU9HVVErbnN6WXE5M084b04wd2lWVFZsREFiWGR1S09F?=
 =?utf-8?B?aGpJY0c4SHEydkFUNzZMTkJxRU10NGhublFsdnlDUk53RGlWc25GdHFydnAx?=
 =?utf-8?B?MEI2VCtIc1JiclpXMzNrbS9wTUVqcDcyTTliZ1BET015SnZlQ0RqYkM3NjNQ?=
 =?utf-8?B?T0tDalU1NEZjK2JhUHZxbjh2QjA0R1YzRTlVaTRNb2hMdFhoVFNmbmhtdWx5?=
 =?utf-8?B?OGVzTDIvZTlvczRNcmgxQWxvSGJjU0dCcGhFTkZGOGlJSlltUFJhWEFqZXB6?=
 =?utf-8?B?dlptaG9ZdGIwcHYyYVFtNml3WWh0R3ZUUmN4eUFGOWVSMXpsYkM2TUZjVWZv?=
 =?utf-8?B?YTBaMURCNzVEa0RwWHFpVHM3OTlPVWR2aFcwRy9LcXRQWjhaaHdOazRoMUpM?=
 =?utf-8?B?TCtyT0FDOEVDNThjb2Q0YTJPUklrTEhyb1BkNis5YlAwREpCVVkwZXFmQU85?=
 =?utf-8?B?Q0N6N29QSFRyRUtaVWMrb3BrRFJVMDNzNnFoWkZUY1hUUDNrSnl4WmZUMXFl?=
 =?utf-8?B?TE5pYWNZd3dOb09ya3lZTlhnTG1UZGVTaiszMU5NSGI0SVhFNlhiSnhzd29y?=
 =?utf-8?B?SUxXRWw1dVJaUmlyZXBjT3VCbktMZGRDWGN0QURLWEZmU0EzR3M5czBncnVQ?=
 =?utf-8?B?d3BPejZidGRMdlVON2xqU01obEFTRVJNUzhaZVllV3dhZjBMZjZzVkdLZ2t0?=
 =?utf-8?B?QWR2ZWo4b1pmL3dIazArNUFucjIvZkFxVDNoMWovQk9HNWM5UTFzamdNTEZT?=
 =?utf-8?B?ZEs4TG5ONkkzZEFXQVgwWDhhZDczQmZ6RnVmNzhNUGpkTDFvOGRURG9iWGt4?=
 =?utf-8?B?TkhGYkhWMnh4L1lFQzdIV3pNY2RlTzFkYmFnb29BVlBLbTJJS2F4NXV4bjlT?=
 =?utf-8?B?OHNjSFlQQWk1bm5WLzNIazJ0Ti8xdkR1dmhqY2pCZjFmMDRQQTRDK0hJWlV4?=
 =?utf-8?B?NEVRYWdtR1gwSGZya2RoTFpkYmhuN2g0MEdGZ0FacjRldldIL0JtK2syMWVp?=
 =?utf-8?B?YmtpdmU0RE9SRFJhN3ZtV2xnWVN5VENhN05DTEl2T0dmMEhyY2ZSbmxiTkJm?=
 =?utf-8?B?QjFwaldkcHA4QmtmUk1VSjlBVFVKRkVzZTVFaHlHSGRYR3BjOW55UUp0Ri92?=
 =?utf-8?B?OERWdUlBN0VUM0hXaHIxM0Vyak9vMThaL3l6VERYR01PeWdtUzhqTm1pcEk0?=
 =?utf-8?B?akJCOVFNWlRwWmlBUGVLeTBLWWdNVmJnRjUra1I2REJMaHF6dzExUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a4f09-99db-4b7a-c638-08da27777e34
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:25:40.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXaTdR/yjKKgAx6N5T4pD/Om21lS0JSOR9qVqQgib287CVIyIAUCnSTU0jG59v9OzyC6qEU2F4sr6wEY9mMvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26-Apr-22 2:48 PM, Robert Richter wrote:
> On 25.04.22 10:13:18, Ravi Bangoria wrote:
>> IBS L3 miss filtering works by tagging an instruction on IBS counter
>> overflow and generating an NMI if the tagged instruction causes an L3
>> miss. Samples without an L3 miss are discarded and counter is reset
>> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
>> This helps in reducing sampling overhead when user is interested only
>> in such samples. One of the use case of such filtered samples is to
>> feed data to page-migration daemon in tiered memory systems.
>>
>> Add support for L3 miss filtering in IBS driver via new pmu attribute
>> "l3missonly". Example usage:
>>
>>   # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++---------
>>  arch/x86/include/asm/perf_event.h |  3 +++
>>  2 files changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index 9739019d4b67..a5303d62060c 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -520,16 +520,12 @@ static void perf_ibs_read(struct perf_event *event) { }
>>  
>>  PMU_FORMAT_ATTR(rand_en,	"config:57");
>>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
>> +PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
>> +PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
>>  
>> -static struct attribute *ibs_fetch_format_attrs[] = {
>> -	&format_attr_rand_en.attr,
>> -	NULL,
>> -};
>> -
>> -static struct attribute *ibs_op_format_attrs[] = {
>> -	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
>> -	NULL,
>> -};
>> +/* size = nr attrs plus NULL at the end */
>> +static struct attribute *ibs_fetch_format_attrs[3];
>> +static struct attribute *ibs_op_format_attrs[3];
> 
> Define a macro for the array size.

Except defining size of the above arrays, there is no use of such
macros. So I don't feel the need of it.

> 
>>  
>>  static struct perf_ibs perf_ibs_fetch = {
>>  	.pmu = {
>> @@ -759,9 +755,9 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>>  	return ret;
>>  }
>>  
>> -static __init void perf_event_ibs_init(void)
>> +static __init void perf_ibs_fetch_prepare(void)
> 
> Since this actually initializes the pmu, let's call that
> perf_ibs_fetch_init().

Sure

> 
> For low level init functions it would be good to keep track of the
> return code even if it is later not evaluated. So these kind of
> function should return an error code.

Sure

> 
>>  {
>> -	struct attribute **attr = ibs_op_format_attrs;
>> +	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
> 
> I think we could keep this short here with 'attr'.
> 
>>  
>>  	/*
>>  	 * Some chips fail to reset the fetch count when it is written; instead
>> @@ -773,11 +769,22 @@ static __init void perf_event_ibs_init(void)
>>  	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
>>  		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
>>  
>> +	*format_attrs++ = &format_attr_rand_en.attr;
>> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>> +		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
>> +		*format_attrs++ = &fetch_l3missonly.attr.attr;
>> +	}
> 
> You should also write the terminating NULL pointer here, though the
> mem is preinitialized zero.

That seems unnecessary

> 
>> +
>>  	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
>> +}
>> +
>> +static __init void perf_ibs_op_prepare(void)
>> +{
>> +	struct attribute **format_attrs = perf_ibs_op.format_attrs;
>>  
>>  	if (ibs_caps & IBS_CAPS_OPCNT) {
>>  		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
>> -		*attr++ = &format_attr_cnt_ctl.attr;
>> +		*format_attrs++ = &format_attr_cnt_ctl.attr;
>>  	}
>>  
>>  	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
>> @@ -786,7 +793,18 @@ static __init void perf_event_ibs_init(void)
>>  		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
>>  	}
>>  
>> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>> +		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
>> +		*format_attrs++ = &op_l3missonly.attr.attr;
>> +	}
>> +
>>  	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
>> +}
> 
> Same for this function: *_init(), error code, attrs, terminating NULL.
> 
>> +
>> +static __init void perf_event_ibs_init(void)
>> +{
>> +	perf_ibs_fetch_prepare();
>> +	perf_ibs_op_prepare();
>>  
>>  	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
>>  	pr_info("perf: AMD IBS detected (0x%08x)\n", ibs_caps);
> 
> The function is now small enough to be squashed into amd_ibs_init().

It's small enough but it still make sense to keep this function, as there is
an empty version of it when (CONFIG_PERF_EVENTS=n && CONFIG_CPU_SUP_AMD=n).

Thanks for the review,
Ravi
