Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94BE53BBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiFBPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiFBPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:42:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDB2FFF4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLcQW266ua44ubMYwhvrochsznX2m3ccOOrYQEVHY9aOGh3FthH5yijzpNJdCVc4FZpTTc8L895poMSQjjSOg9rj0tCe7TJeGD6R8Ga11ETlfaeqtPyvfsXC3aDSVb9TDrgK+l9zse5Cz+BU5HOw0EWH5sWiTVTMKQI7ExlFHF0wJu5IweNzKNha4/E3CBNDErSKiJKoOTnGeV5XozMY4vP8Yiz4RyTDp/ATSvfApm3epSqKt1gxEKVBsaazqqqe7FGpbrRcp50tiFrq+bMj0gs1UXx8hzN0yf2hr3R3YZwxN8kHGq7km6RJIzU+SSLq6hSQHyrNHEk5Ew+RK2hkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6jhxlJ+okAskUNg+gLNkkzl9Z53PzHQkEzKNIHMuUI=;
 b=jzwRV6LvKgBjglpOJAhvvkg+oGdUxIq9/VjyvKNqwjZrXzmyZbj1sYYgqG51Lv3BAnB1Uk0Bw4hpwyIzA64dm8uKQ3DrIkkPTIBsD7Pz2QRS4s1MbkI3Mp9TLxrFlS6aSyXH5dms3SujPyLGljbje/APinsgeEThfi4O1Yd09lRbo1A+ShpeAbEwHveX/x3sBFqDLSomaI1BEHp3UjvHZzofJXwosB3muEy0feT7NAM+8Kv5mefhpVoAJLB6UYbtYunaEwrvjkj60Xl4KqhlhMqAt/vpvbOVB3VM1wXwnxdog/HagamMmuESfBh7TAwrasGn+13Q1zxXWehh/1vIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6jhxlJ+okAskUNg+gLNkkzl9Z53PzHQkEzKNIHMuUI=;
 b=ZRPyfrL/pTHHbNa+SqZqgdHytXY0Es9BKL4gMklIrVZ7r+Qdo7o+LABGvumAQWZxQwZzoeVzJcixhY25L/CfHwuwKxvuGOHN/E9lhzkzrGdul1AVr+FQU503aT46ZLEHH0u8wzGHmGUiCkRV00RRirFwXkDduNoB4WXbKiEMBKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BN6PR1201MB0193.namprd12.prod.outlook.com (2603:10b6:405:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 15:42:03 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::e404:887d:96a4:2868]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::e404:887d:96a4:2868%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 15:42:03 +0000
Message-ID: <f0e481c0-809b-a78a-6cbb-187e27bb9197@amd.com>
Date:   Thu, 2 Jun 2022 21:11:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/3] x86: Handle idle=nomwait cmdline properly for
 x86_idle
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
 <7e5a66c4d383652c89a0b5ec0f57e0a95902f810.1653324016.git-series.wyes.karny@amd.com>
 <9dde86ab8773ddf3f9d88a85ed9ee010cdcf50a8.camel@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <9dde86ab8773ddf3f9d88a85ed9ee010cdcf50a8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90dd1a51-f510-4a30-efd3-08da44ae7062
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0193:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB019357B59CFDF036B2205FC984DE9@BN6PR1201MB0193.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvNnnizwtPj16DAIN8ajznW/Hx4tHsq2tBbwjwmj9n9jSh98WIKrCN5FxZCM/TGZ8+D/KlxNACSEVhTFyfOQweZMdNMIaw6Xo2ydhrFlFAH9Q+LZIhvfcjCm4zWEWCQL8DOQlpW2c+JzoUCCU4GiuZ/1zo+uuWxr+ijocaBJ/XLt21G2ZDDCSPFEJFW7zUKtnxXF4BwGl6hMn3KX3S5aNp8RBoPxm2kdfpJC6qx2wHBbZQAMSBRMy+Taf3r03l+tinLczqdJLKid+YnXsvO8Nc3rR3jTaw/DkopLDT/VclW62kCa9yNhJWwaHC+lSBywH4imxR+86Eh72HBF0jTZ1QGp6xR4vh5p/HbykSPkb62cMNq1gD8NqlbQOlMbRwNQF+4ofbsz0GFr6WWxn5WQlzFVUv9ROmG2gChXojVrb4u3ua1l6UJqeSXInuOJ9A19KZGx1xbMHRlWk5jxh92DXF8mQfQkiDgxxF5rim9vcy65Zwl6HikjqwO0fPEQOQQ3eEqbbO+IGmCGywydd09gluVpbDrL0fj/lE0NoBpgH4X5J213VrCSUoOTphYgHejgsC07lE1iCQa4z6Ychqrwqkh5LWuLOQ0NhdoV3OoJUnfL/hNAvP8eO8xo+dcQRWXw6rP/yv+qtq2wBD8baJlEfWZjtMZ7sV/RWPIy86RaVyAZjyTQomyXvEEI5IGWsBPGzYAguiY8yMil2XyE7sbFRDSWFxhKSPZbR+i/TmIFJ1DjRou1qdUs7VUwi1SSRTyY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(6666004)(2906002)(186003)(53546011)(36756003)(316002)(8936002)(6506007)(2616005)(8676002)(86362001)(6512007)(26005)(66946007)(508600001)(6486002)(31696002)(31686004)(66476007)(7416002)(4326008)(83380400001)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdhZFdCSUlYZGVOSnA1YisxYW1SMVcxNkdVdkdXUnNqVS9XWllVWldZNUtq?=
 =?utf-8?B?clA5UHYrOFVweGJXbEdvbXpyQUpyOXhtcUZTU3IzWGg3eTdHbGVMbm5lYmRp?=
 =?utf-8?B?RXlXSEp6dWVxVjJFK0Q3M1BiQ0luN2dVQ0tOdUIyM3VnMlpTTlorTEY2VXM4?=
 =?utf-8?B?THVwUTNtZHlQd09hc01WdTBFcURrR0JXaENxdUZnMWhJcXVobGRTMnFYNzRK?=
 =?utf-8?B?OTIva0hsUTFTaEY4NjVuRXg2WnFWQll3K2Y4dVg3TjgxcnhCbnlIRU5XeFRT?=
 =?utf-8?B?bmhRdnRPZDRHcEdRbWVoQWdUN0pub09VYTg1YXQ3aXpTL1pnOUtXbXkxaDBB?=
 =?utf-8?B?RXpoZ1Z2eFpMUWJzbkdEQjQxdWxmQ0MvVldrZ1BJK0NrR3liZ2pSaHBUOUNO?=
 =?utf-8?B?eHZtOHViOC81WFdyRUJ1MHVnTUozL2RSanlhWTB1Q0puZVVlbGxZbnFaWFVa?=
 =?utf-8?B?bGcyaFlJV05QSW9BWkUvY3V3eTRhWTl5ZDlJL3N6Z0RlVVNGTGVLTC9uZTF4?=
 =?utf-8?B?Ykl5RERQYUZIMStyODBCZHNGRkhkOUl5M2hsOFoyUXFtWm4xU0lGL3QwQzZy?=
 =?utf-8?B?K1NSUzlBSGJsamdvMUlaTVMrQU1VOGpNRW42Q1E2NlRkcy9jWUFFbnBWaEJR?=
 =?utf-8?B?QUxBbmlmVWdZRXBCK1BGd0ZBcWtKUGhLejhrbXhjVGRnS2RMeFlick1CWHNp?=
 =?utf-8?B?a0l5WFhWb2VEV2lieUw1amlwQ09JekRNdnBOVG16djY2aTJCK0hDUk9XZHA3?=
 =?utf-8?B?akwvNFFlMlZpVUc5QWhDUFR2ekxVcEJjWjFHNFh3UmhLQmRZU1BEVjIxZ0h3?=
 =?utf-8?B?M2xLNHFLTDhWWFZSZ21yQnBqeVppK0hRVXpXVHZzb0ZRMFBEQkhzaGQzblJC?=
 =?utf-8?B?MzVpNEtaOHhsY3RySUVVT2xJdWdFazBJcHlpZmkwazF3TmxyVGlBYVRHeklH?=
 =?utf-8?B?RkpmSmNGdjNjMnIvMzgzNWJObFhUQlRVWTRBdGU4WDNqMU5VOUR6RDJxV3pk?=
 =?utf-8?B?aG5kdjJIUHdTeHNnWWlZSDd3ckEyNjdwNHdJbTA4QzhVOGJqcGdnK0VURU1V?=
 =?utf-8?B?Tm9oVGc0ZVhXZUY2VXE2M2JyVk90bUFLYlRhVkNiejFZL3M1NmlPZ1I3SzBW?=
 =?utf-8?B?MGdmYTFDY2grQkMyY2hjUGRqWFhXaTlZMXNYWFk5R2IxVjJGWUlHeHp0UGFh?=
 =?utf-8?B?WTBYbUNaWVMxK2RocUMvZjZhdUJPOEFwcUMrSGloQnpJY1FlS21kOENQeTdS?=
 =?utf-8?B?UjhIaVQzdW9veTdmRjRJRE1VM2pRL1lqei9GNnlxSTltZUtmaVNxNDV3MThs?=
 =?utf-8?B?OW5IQWt6aG5tOGRZOUhTdGFtRjdpM2ZHeUplb0tzMmZlbEllYytrNUwxSlRz?=
 =?utf-8?B?TVB0OFBTdkZUQzIzM2IxdWZja0F4dEErV1NBbWUwTFA0WDZmT2hoQnZnUGl5?=
 =?utf-8?B?eVZ0OStiQldlb256TUFqWlhGeEhkcXZOS01kZ2Z5YXhXOXZ6a09jVC9tNkFW?=
 =?utf-8?B?MENVMG5LNzZLZmlMS3IxN0xzdjJmVy9kNWlPQkhqd3o4QlptcDRkUmxoK0Rq?=
 =?utf-8?B?N2VueGlHWVBhclFvZTdXQkJmVEFwUVJhTjJuSXZKRk9UTlAzQnIvTm5hdW8x?=
 =?utf-8?B?cDhOckFCUDNvZCtWRC9vc0ZESThqYXh6TUpuWGRxZ1gxMEc4dk9vR3VOWnpq?=
 =?utf-8?B?eFZnUFQzQ3h3bGlUbWorYTg1bENxK3J1UmJuMnBGSVVLcUVmNldsMmxlTnFQ?=
 =?utf-8?B?dUltYnJLK0x4SFk3WENGa1dmM2JSc0xYTFR6ZjdwbjN0MDRic1ptSjlxMCtn?=
 =?utf-8?B?c1lmVDN6dmVQZVREdHB2Ui94dndYY3FyRHRZZUNIQVQ0SXp1Y2VtWnd3bGwx?=
 =?utf-8?B?N2FPUDZQVmdqZmNXRUFaTnJoMGFDN1lEZi9xQTFnZzNpOVdsUFdVSGs2bWRX?=
 =?utf-8?B?Smw0aWJxNFRxczRIaTlFeWIxWDRLQW9pcTBoOGtFOWg3NEYvVWlzK0dlZ2t1?=
 =?utf-8?B?MXpxMkMwZEJLTkpqWVV4bVNVcXlzbFZHd2VxWTFtTFlJRXVYWEorclFMb3FW?=
 =?utf-8?B?Q0VBRTRRM1o4T0M2SVNtWGNuaSszaE5TdHQ5TVprUEhDUG9yOFR4RTYxYjBW?=
 =?utf-8?B?K0REWGtkbkczbHg4YndFRHU0ZmFKVUROMG1ldXNURm9jQlphUDUvd2hlMmFa?=
 =?utf-8?B?cWgwOUFtK0pmVG9Jb2RXSzNXZHUxdDI2dkVYb25FMGFweFZSdG5QOEN6UGYv?=
 =?utf-8?B?SE9GVzlxaUk0RHRMUnUyMGRIR3MxOUswSTVoQWlNOVVXY3Zpc253MUk1QTMw?=
 =?utf-8?B?bjF2emtuM2swUFFPeENZcEpVTnc1bEpyclk3ajZ3Y0JCUUphbHlFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd1a51-f510-4a30-efd3-08da44ae7062
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 15:42:03.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFrPYcPDwEZUumAVhfzjnwakUD3ql+M/PQzzCHuLRLapdtbqDydne0IgCZm1Du4edG+W8UsLGzdLvw98ok4eQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0193
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 5/25/2022 1:36 PM, Zhang Rui wrote:
> On Mon, 2022-05-23 at 22:25 +0530, Wyes Karny wrote:
>> When kernel is booted with idle=nomwait do not use MWAIT as the
>> default idle state.
>>
>> If the user boots the kernel with idle=nomwait, it is a clear
>> direction to not use mwait as the default idle state.
>> However, the current code does not take this into consideration
>> while selecting the default idle state on x86.
>>
>> This patch fixes it by checking for the idle=nomwait boot option in
>> prefer_mwait_c1_over_halt().
>>
>> Also update the documentation around idle=nomwait appropriately.
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>> Changes in v4:
>> - Update documentation around idle=nomwait
>> - Rename patch subject
>>
>>  Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
>>  arch/x86/kernel/process.c                |  6 +++++-
>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpuidle.rst
>> b/Documentation/admin-guide/pm/cpuidle.rst
>> index aec2cd2aaea7..19754beb5a4e 100644
>> --- a/Documentation/admin-guide/pm/cpuidle.rst
>> +++ b/Documentation/admin-guide/pm/cpuidle.rst
>> @@ -612,8 +612,8 @@ the ``menu`` governor to be used on the systems
>> that use the ``ladder`` governor
>>  by default this way, for example.
>>  
>>  The other kernel command line parameters controlling CPU idle time
>> management
>> -described below are only relevant for the *x86* architecture and
>> some of
>> -them affect Intel processors only.
>> +described below are only relevant for the *x86* architecture and
>> references
>> +to ``intel_idle`` affect Intel processors only.
>>  
>>  The *x86* architecture support code recognizes three kernel command
>> line
>>  options related to CPU idle time management: ``idle=poll``,
>> ``idle=halt``,
>> @@ -635,10 +635,13 @@ idle, so it very well may hurt single-thread
>> computations performance as well as
>>  energy-efficiency.  Thus using it for performance reasons may not be
>> a good idea
>>  at all.]
>>  
>> -The ``idle=nomwait`` option disables the ``intel_idle`` driver and
>> causes
>> -``acpi_idle`` to be used (as long as all of the information needed
>> by it is
>> -there in the system's ACPI tables), but it is not allowed to use the
>> -``MWAIT`` instruction of the CPUs to ask the hardware to enter idle
>> states.
>> +The ``idle=nomwait`` option prevents the use of ``MWAIT``
>> instruction of
>> +the CPU to enter idle states. When this option is used, the
>> ``acpi_idle``
>> +driver will use the ``HLT`` instruction instead of ``MWAIT``. On
>> systems
>> +running Intel processors, this option disables the ``intel_idle``
>> driver
>> +and forces the use of the ``acpi_idle`` driver instead. Note that in
>> either
>> +case, ``acpi_idle`` driver will function only if all the information
>> needed
>> +by it is in the system's ACPI tables.
>>  
>>  In addition to the architecture-level kernel command line options
>> affecting CPU
>>  idle time management, there are parameters affecting individual
>> ``CPUIdle``
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index b370767f5b19..4e0178b066c5 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -824,6 +824,10 @@ static void amd_e400_idle(void)
>>   */
>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>  {
>> +	/* User has disallowed the use of MWAIT. Fallback to HALT */
>> +	if (boot_option_idle_override == IDLE_NOMWAIT)
>> +		return 0;
>> +
>>  	if (c->x86_vendor != X86_VENDOR_INTEL)
>>  		return 0;
>>  
>> @@ -932,7 +936,7 @@ static int __init idle_setup(char *str)
>>  	} else if (!strcmp(str, "nomwait")) {
>>  		/*
>>  		 * If the boot option of "idle=nomwait" is added,
>> -		 * it means that mwait will be disabled for CPU C2/C3
>> +		 * it means that mwait will be disabled for CPU
>> C1/C2/C3
>>  		 * states. In such case it won't touch the variable
>>  		 * of boot_option_idle_override.
> 
> the code didn't change boot_option_idle_override when it was
> introduced, but this has changed since commit d18960494f65 ("ACPI,
> intel_idle: Cleanup idle= internal variables")

Could you please clarify bit more why the commit you mentioned is
related to this patch?

> 
> thanks,
> rui
> 

