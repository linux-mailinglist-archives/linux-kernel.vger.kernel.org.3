Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A680051FD06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiEIMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiEIMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:40:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5242A1339E5;
        Mon,  9 May 2022 05:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA09SYmNKsm+hzN4kCRs/0s7zaHNGpn0J9zoXcY6Szd6f0AnS0z7rINQIUowPu2/moad4rK1PwEQWtuxDj3R3zbo5GM42MygLnN6P8HDT8Psoujw1Asbp3ikKwFWiQJY6R7fvZua5hCjMqz/dMUV3u8Ap6Z3jnTCYF2MxyAAc8iDQobUVBu9a/u5BZn8PsW9iHyc8whbfBiRnApJhiMxC4wwEVLlxXlTEx8nl+BYxEOpQU3wAzA+FhNnXqbuNXW5kSXaGvkS5GXCVDP3v5BGHe46lzjzyhQm/xAjbyhRssC8ItFzMQTFRx8LJjKu9ZTL+wQdOcd3gSeKjzqA3lgblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFC06cdCOcsevNrKgxDODcYCDMdMJW3SwSQlXgJCslE=;
 b=MgpdA6197VKEsx0RobdUCAyaUBB88+xEu4bybVLC4lPA1aR8zosI7G0LFq1Dbk8RKWLgEOsjX22xciaffpE5BvmwALKV7qnxKD+8nuag1sLEgcyE/QQwq/93Ew6uNzB1uzmLY7YQ7NwRAOMxnhM6WgzMdSyuUvyUbM0COgdvUl6PCrFuYfi9kP4KnE2lRFu7CSbuNDB3icR/9lPwSQy+QLDW/U81x1hn2Gl/QffDLDMrtmHCe7QAQNATWgLly/fJzQBj/psloyxfpKhpjS0ZGRDIqGoNG+7Aq63hfL0qr9JBum0KQ3platnDZs303/0vdJtuV8oiHrmQ8iXf+8furQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFC06cdCOcsevNrKgxDODcYCDMdMJW3SwSQlXgJCslE=;
 b=w2+1hFDClQ7ab3r6yp9AIoxJ8Sugt/OCBD5bDUktK3Y6irJWULOzKUbTR+g5rXh+bL7xycczDGwnljpOLnZcz/99s5r7jVTabNAATXVunQTuHOprVcCVJWLr2+1baGWs5OeYWXul9FQjvZTNeZPznboazw37bFvSVynUGW5/RP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 12:36:05 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::1520:5b27:a811:e3d8]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::1520:5b27:a811:e3d8%3]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:36:05 +0000
Message-ID: <d4486cd1-e4dc-3120-97ec-dad922bd8430@amd.com>
Date:   Mon, 9 May 2022 18:05:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/8] perf/amd/ibs: Add support for L3 miss filtering
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-4-ravi.bangoria@amd.com>
 <YnkDfRIRyztvXv6o@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YnkDfRIRyztvXv6o@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d87f3f7-df60-4ead-a3a0-08da31b87c19
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3604C87026E62E913D386011E0C69@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/9w1XX5c1E7yDeviZ0pVlFdKIswVsDeXMKRaqOjnF1PMBoCoVnB+Fo6BQe+LWmg6/QiezQ5fSrUMlrhv9t30LK8t9vTcKJORMolxjoWFdE/ibPqI+UhN73V/0q6BlJwCmOuU3ADb36I/YJscr5JyDAzp4et26H4JQLB1r6WO4eUCVnCaOux1MwIAw/WeIJcX38o98qGSpJ+9UsADLHyfW/yXyDnY8ev08yZUNK8H1w/Uva/94ViMjcyuVf+nTa19IMVDMTPYH2DLyM0nO6aItkGtP3YyQresdVSKEaYiiSAoNHLDtU4VidB2VKLo7XolXIQjlKWsPX4xuuxJjf0uBVbIh/lE/q/AG39WypZ8W/35q4AcwxMhMq5dksNqGIqPFBB5RJJe+3m0Honj2SJ5zyC4bCcQK8Ny/yC9MZuLzg8KPFKu0UyCHVekstLGO6Ymdr4D3eHXVvBKdfJMaafnQ1ad1Eii8Zb7JON6eTqD7aCiQgkMlV8P+qNmhGdKxJpZ3klu0WgXY44AiXTe/+K89B3D7/dijv6f4JjJCfkrEkGMXy5NglbCC7c3GcAhxCgU1q5/FWa4ekC7RkTo/nwzu1c0AHxTW6tW6mulmmQgAYIq/ZKPvue7FuPP1CRxi62j6Yi4ijbF0j7w82CkQsMUoh0WNRdEN1B/LcK1tIlp0M97io7kosYGEAPUJVx8cKeENi0MvgrKfOwfK+L2pvky3vx86iN3SPQQjUVBJymX7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(508600001)(8676002)(2616005)(66476007)(6916009)(66556008)(66946007)(7416002)(31696002)(6486002)(316002)(5660300002)(36756003)(31686004)(53546011)(8936002)(2906002)(6666004)(44832011)(6506007)(6512007)(186003)(4744005)(26005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmprV2lVNTEySlBBUkYveCtwTzZsa2F1dDFuK3RueXNyZUI5MWpsM2xOb1ZT?=
 =?utf-8?B?TzAwL1BVR2tHbkVJWWN3OTc1VHlPVWhSQlN1OUkzQkxHbGk2WDNRSHVJTDZO?=
 =?utf-8?B?S284YWw2NXZSb0R3aW4vMlUxMGpGQkVaTTIrMlRpbTdyVnJrNHE0MVo2OE04?=
 =?utf-8?B?RmhLOHo0Z3VENVZURDkxY3pLRTZOVlFXdmdUSy9KWGdlVE5PYW8raUl4RWVm?=
 =?utf-8?B?RTZhYkREY2RXZ1p0Y3ZFTTEyTEJxandSVWhwWXZnckNPU0tPczJwTkRLODVa?=
 =?utf-8?B?dWlSZ2dsOEt0NWlnTXBwZ3JsV3pDSStBYS9BLzFvanB3cG9vK0xCZ0FzYzFX?=
 =?utf-8?B?SkI3OUJTMjFmeGc0aUF4RHdGdDVmYVBWQ1lSb2VDZ3BieTE1bXN2MnRia2Rz?=
 =?utf-8?B?M3R4Mm92YXUycnhWK3d4OTBtQ2t4SS9ReGJSL3R4d3dsaGg5czMrMXFkZXFk?=
 =?utf-8?B?WFZzYUxVMHAwUWhNVHVkYS9ZSDZFK05pZkgyUnI5azVBNHFGeUxNY1Z4aG5Z?=
 =?utf-8?B?Wm52d0tZcVRZaFN3Rk5pYTZhTHp5c1RkWU5yUzVmMjR1VmZrbCtYNk1DZnVm?=
 =?utf-8?B?NTRsTE5iT2hmZUdmcnJrbFNtc20xRkdaanNXeXlDOFlxQ25rUURlMFhLdk1m?=
 =?utf-8?B?ZWgvK2pQem0zaVBpTUpaZFFvd04xTlp5Y3hkWnZRNGpMaXZXZi9wWm9VaFhB?=
 =?utf-8?B?Y1VOY3N4SmhEWjFEakZieEdldzRJaXM0MGEzeVB2eTNYUHpSN3p3SW43TWxC?=
 =?utf-8?B?WURVYUlwOTBuSnFqcmJDU05LblQvb003SzdtQmdjcTJ5UGNtd3p1OCt0TENs?=
 =?utf-8?B?K3EzTFhOMmlhem1sTHVmVS8rc3M2b0NObENjUXBVUi9NMmpYbGprY0FKQXp0?=
 =?utf-8?B?WkxRZkpTQmlGSVNYdnBGWEMzQmlHNzFoMnJiUVdqQnR0OHkzOUN1WW1QM2ZR?=
 =?utf-8?B?MXdRRW1zT0Y0MFE3ZzZ3Ump1ZVVrOXR1UkhRR08xREs4MXJ0RHp0bFl0WlVj?=
 =?utf-8?B?SGRvalpKMFJjM0xUZ1piTklPcmhsbk9kTFlVR3hQMEphaFczNU80eks3bFZl?=
 =?utf-8?B?ZVJpcW9ZWkZIR3BpMzdJZk5jVTRIK2pxVXppT3pjb1k5bWY3Uk5ILzJDbDBD?=
 =?utf-8?B?bTMrMy8vTmlGRFNPaWNSSVhFSXBEMUYxZjBvNkd0N2JBbjZiQVlrMjRySHUv?=
 =?utf-8?B?ek5yOGdxODQ2eHg0ejMwZ1pLSHhoSityV0IrOWJldXVKcHhjd2tTTEpvNUxP?=
 =?utf-8?B?UlBFb1NoRlVSZWFpN2E2aDdXZ0htc1FJZVlnUUpObEJmMTNaclN1Q3hQR2lE?=
 =?utf-8?B?U3RUKzQwNHdURVpOc0FkZW9talh6K0R3MWl4WWVLRFdWN29QV241RmJpVW8y?=
 =?utf-8?B?c0dTWGViTFhpNlI1N2ZPVnB0czVnT2JHR0VlRnFwVWdiazFMUHNEbVlUS1Rj?=
 =?utf-8?B?UGQxUGRlUEdnN216WVV6WGljZzFTcGdGRkUyU1F5NUFOK3A5M0ZJdnowNWNi?=
 =?utf-8?B?bFNJaUFCNlZhTGs2SmNWcGdEN1o5bTYxeUZwWXlWbTNaTTFrNGxWUUNHajJM?=
 =?utf-8?B?alVxN0FiSm1PdlVVL1ZYUHdHQmZjZlg2TjI0QjFIQ1hZaGQ0U2JaSVRVSGtF?=
 =?utf-8?B?VnJQTDRRMUh5dDhUS0xFdWRZTTJoNWpMRkV1SEtFNnNxdGVRQnR0QzlGTGdX?=
 =?utf-8?B?YVVGaVpYRkM2KzBNNVpUdmtFaGpRSEJNcFgrOGNvb0tTYTFmUzJxQVBEVlJr?=
 =?utf-8?B?d25BRFVqczI0aTlpejJYT2trcnFIWWJLOHFZb3FKcytEQys0aFZnZm5zRS90?=
 =?utf-8?B?OFRFdlc4UU9hQVFDZjljOW1NczA0MW8vNkJFY0NSWVd6N21iSWxnMTdJNGZq?=
 =?utf-8?B?WXM1TEY2SGlscG9mMTFxbWR0NmthNldYeXJ6NGJxWDdzcWZrc2hzRnJwbVVm?=
 =?utf-8?B?dy9EbENIcm1GcWl5L2pPL05yZmg1M3NPQktnVlRVRkVKZk12bTJBY0hseGVp?=
 =?utf-8?B?WVhHaThvT2F2S00vWjZDUlFvR0ROYVNSZTRNdHBSeTVSdEZzcTRwUFlleVVn?=
 =?utf-8?B?Um5xNGs4eExoQUdGZG1WK0hWa20vSlpwQzh5REN2ZWx0RGh5TXRkZnFwdERn?=
 =?utf-8?B?NEVFNjU5YTY2bFpqUWZuYzBkS3gvZVJSbnEyNDYxQW5jTWVMQ01CdlRoWXN4?=
 =?utf-8?B?elZGcjlsTDFtU0x2S2xQd3czS2RwOGxBRThiNXlneXZEaVRJODhEaDlQUVNK?=
 =?utf-8?B?ZHJ2L3VaK3hma29Qbk5yRG5sK2RES3hEOU5LN2Qwa1cyVTc3cnYzTVEyaWFl?=
 =?utf-8?B?Z2NYclNDS0pBckRjQUcxQk9uT3gyYnloQ3hwYTFXLzAxdjU0RkpaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d87f3f7-df60-4ead-a3a0-08da31b87c19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:36:05.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BByypt2WUbeMkmkDjQ1zHO227J5jU1DAgstz9x7PFE7Ek79cCqC5+NOEaV44cFp2GfmJodyag7KsXMJkr80VoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-May-22 5:35 PM, Peter Zijlstra wrote:
> On Mon, May 09, 2022 at 10:19:09AM +0530, Ravi Bangoria wrote:
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index b06e4c573add..a24b637a6e1d 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -391,6 +391,7 @@ struct pebs_xmm {
>>  #define IBS_CAPS_OPBRNFUSE		(1U<<8)
>>  #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
>>  #define IBS_CAPS_OPDATA4		(1U<<10)
>> +#define IBS_CAPS_ZEN4IBSEXTENSIONS	(1U<<11)
>>  
>>  #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
>>  					 | IBS_CAPS_FETCHSAM	\
> 
> Would you mind terribly if I do:
> 
>   's/IBS_CAPS_ZEN4IBSEXTENSIONS/IBS_CAPS_ZEN4/'
> 
> on it? Per the IBS_ suffix, we're already talking about IBS, per the
> CAPS thing we're talking about capabilities and I'm thinking that makes
> EXTENTION somewhat redundant, which then leaves:
> 
>   IBS_CAPS_ZEN4

Yeah, IBS_CAPS_ZEN4 is better. Let me know if you want me to respin.

Thanks,
Ravi
