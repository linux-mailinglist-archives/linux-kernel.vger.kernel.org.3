Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCD4D948C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbiCOGYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiCOGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:24:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218065F54
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoEfG+kzfTj+iM4CY7G0q/WiLf0pKqMLTSGsGotdVn8Qq29Q+nl1qjbKFN3QWip4KIbjMwZF1OXDpigjRXSOVuSI0NyI/G2wwYqv6U6jzgGKLVuvPI+45uUEJRRcZnbHvvjs+FC7WUW8B0dowWcBoz62itR0ZNiO7/0OYbQXwxKnBaY6HdWeGFpSrIGox+mgTWM1QMShNRHtLM46QWQDZzmbhq8w9AK5Uj0OX+j+zOFKxUxB1gEZqibBuXCYzPI8JdQ/TwIH49legQfHtvbu9TmnpHmLzuyIVd/1wxCPwo1E51zBe8QB+GvQJRgR5Dl76IWAmVYUy7524I/3N88uZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RagZtozCL/hS/I0QMAow08fyByRDGF14wqvHAtvPUc=;
 b=Rk03K294eIFS7/1uHX958JP87yO11bJc8+LcEl26O9aPkBkuuFAtB9P/MyeJ65UmO7SlxxwzOR6doi+KNPQL0keYEVysxTg5VMTPiUhsyVLffIBgc8gMa/JPHh0+CvEX1k0TWaPYaM3cFTgvHMunH72Nz8LnzHQkNR5ekryQpb1yomCYCRQjgT2qeI+pkDaBd4XQWz7rHFcx9FlrFZnkciGew8PZXtd1skHTICQgzFh2GwySFloq6bizuhR/m48EjC1i0xcSRIuJaZTSBnohVZY/Wo1RUGibe5cVya/UEKn7k5IPPjYPf2plQlddCD18itgDNXPmzVGWO1kKL6sxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RagZtozCL/hS/I0QMAow08fyByRDGF14wqvHAtvPUc=;
 b=btY8eV43ZAuPa9V6rdYeO4U+H7ok9it0k3i0zaOkCWe/+f3+7IzpBJ6x1eUXe3XMTPGC6mg76rhfSqvrEoNkG6X+WHh24MY+4fHIWW57pXe21Mu6bu9QhYB6Nq4wKWu62jnkA+Li+5LY/xvtQ016eesyMdtTzg0jbmm2vOFK1LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by BN8PR12MB2996.namprd12.prod.outlook.com (2603:10b6:408:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 06:23:40 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b%4]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:23:39 +0000
Message-ID: <5609a43a-afbe-7629-b84d-75ace62da4fe@amd.com>
Date:   Tue, 15 Mar 2022 11:53:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-11-eranian@google.com>
 <CABPqkBSzc167wNbJpWu7msfZ-KrGu-nMtFdw-naN+M7Q0py-vA@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CABPqkBSzc167wNbJpWu7msfZ-KrGu-nMtFdw-naN+M7Q0py-vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::22)
 To MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe2902b-a792-4697-7560-08da064c5828
X-MS-TrafficTypeDiagnostic: BN8PR12MB2996:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29964EF8CF8FC6BAE51FD45CE0109@BN8PR12MB2996.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SkLmoTsyA2rtgod8O6TLedhh7Ee1Ygr6ZTGXat06VqnzTlV8T8xWc1Mcplll1Lq+mYjeU3t5E7H5y56nhxWl98MvjQs1a3BkJjnW68js5hDkwCVnL6Jmox+AXlc2pryTyH4xcD6hb9J2XK6w7JbKfuL4I4SYr5G7rVjxoBLWOcamML3+aM2gPGFyuZbtyQQEV83w2L5zKROjjtpv+QjhYjxD2yWwoh77Y56U5/2jCniBNEVcTC2V+ZqWGLrfdxJNb0LAyBmZWUph0gDlQBVstwnCCScu3VDMenha+KXM5ty8Mp0tF6e5B3pd/RWAPFc8aZESgPjuDoqceeJiyQQHWD55/3UQo9AxOZR8d/wEO/i9Vfy2soSH8G7LKh9RHav7iQYetNXCxBK3throIw2TIpZ/QK/TNKcXVCVauoqpuZnlnUSewd9UAlqDRMYlEg8VxlPIOuwQDxgMPCl9n71ymWlrOsCCRaOgIZd4+Dyd7bLqSD2jrF5O9UmPB71dDnyUbbkF62/Mheh/OcbphcjHAAc3MGoxJlcNIhRS4WtmTuGpSfDpP8UlVm2uubvxl/pt4DC9wshK8AKSHq33pufuHz5vOT+O69EIX26YkuLT3q/979a0wRdvhBfkqTCW3JkD1lTdjWBQtaSBg7v7qDD3qWf+v/KWTuGUVtRbKqGC7qllSZ1V6VCxcnh6E0Vq9nUqMnB3xmalryu5VR4Ac7c4XHaLb4zrDVL2HAKSmnp254=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(66556008)(4326008)(2906002)(44832011)(6512007)(2616005)(66946007)(6506007)(6916009)(31686004)(26005)(186003)(36756003)(316002)(31696002)(6666004)(86362001)(38100700002)(508600001)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNwYWE3MVoza1JwTW1uUk0waDZCYWJXVi9KakpCTi9QMDlBMWNtSjIxRGFY?=
 =?utf-8?B?aENUcUF4cHUxUEtnL0ZBb09iOVlxRmZMM0xWNXdYZUd5K3FXbFRGZ0ZRZlFs?=
 =?utf-8?B?VTZOMmVLeGIwd05tZk10ZEdmMHoyMkZjWWZBL1UxNm5BQWU0ZVdQR3k1UXlM?=
 =?utf-8?B?dm1yY2xTNC8rL2puUDBmdGdPQkRKdVp0Rll2T1JlRXl1aEdvb3QxL2hwUkU1?=
 =?utf-8?B?WEFQYzZrMTg5LzFmRmRJMVZqV0FRWXBWRXZxbGlSaXdhT0NCWklIZjIvaG8z?=
 =?utf-8?B?amxMWmhMMjdxWkxaTm92SmRnNkMzeVlBZTZsWkhDbnBTNnFCWGduVk5LdWJS?=
 =?utf-8?B?WFlmZ09vRitUM3ZWRGx0SkRURDdlN2JWMkFSd05PbDRkRENkdThFMzhmcFBY?=
 =?utf-8?B?S05MN29ZNE40TXFSanJabUJqQUdWOGdqdVNqZmJHRFViTll1dVM3TUE3akMv?=
 =?utf-8?B?YWp3UDRVZWhudkRJUzhjMjFCYnBKMFBIcFR6dmF3dC9DeFRDZnNsek8yZExq?=
 =?utf-8?B?T3haLzJuTTNTRFBBYnlMNk1ZU3JEYk9Zd0UvVHk1YXBPVGVWR0RpMzJhUVFn?=
 =?utf-8?B?b25NZyswZ05zaUVQSG54ZTkwbGV3OUFOSC9UWloycERXOEd3TDVoZTlFY1d2?=
 =?utf-8?B?dWZUZ1hWQnlDK2psQ2V2TUlSemFaWjJKUmdVdEZlRVBnK0R5aTkvSHQ3dFdr?=
 =?utf-8?B?cUVzYkhDeHpxdC9WYXR2R0xKV0ZPZVhSaXJWdjc1TUZPNk5IZW5rcUI0bWZI?=
 =?utf-8?B?Mm94L1NRYnduVHJJV1BSMnhJQ1Q4bElvQ0tla1NUb0pzRjMvQTF6UnNIeEZI?=
 =?utf-8?B?R3JNYkZFZHppeHg5SjV4M2ZlVEthOUxIcUdybE5Bc3FwQTE4ZmhrbkNKZWhP?=
 =?utf-8?B?WTZRR1hOQWF6ODR5alJ3VWt5NjZIK2MwOEdYaDRRVCtGc2pNWWU1M2tqc1Vs?=
 =?utf-8?B?TUJ3WldnV0Mzb1BRQS90NGczUkZXRHBxTTlaNVdub3N3TmoyMGcwWXF4ZEdR?=
 =?utf-8?B?bXYyRUNFTlgzTUZ1NE9rVHNTQlJjQi94di8yNGJvSmxaVWlaWFA3SXUyL1N5?=
 =?utf-8?B?a2Y1UmJwbktLN1owMlFWRXQ1TXIvak9FWUxncTlTZE8wQjVOOEhjUWJIZ2tS?=
 =?utf-8?B?R2ZHTEYxUUFobVdyYUI0RDlWMG1wOVZuakZUUTBXT2ZpTWNtRXpLVmlGU0kr?=
 =?utf-8?B?UHhjUlRYcFdBTXpiUjVBVXVCSWFzWHN6RW5Ia1A1bVdLZ0FHUFd3eUl6SHFP?=
 =?utf-8?B?clpZRW1EQzd4Z1QycllGZ3Jza05wbEd3RE9ENWRiNWcxdHQzUFBqMUlOS0Zu?=
 =?utf-8?B?M2tjYm1VaS9YQmNaMlMvd3FBbkNXdUhTOG5XVFlEU2ZZNFNNMDhwSWs4M1hy?=
 =?utf-8?B?Uk1GVFdKUGdnVDIxckNpU1NReDBrMUNHdmdZeENxVGVCeTVGY3NKVnpYQ0l1?=
 =?utf-8?B?U0cxL3IyL3BlQkpNUGFuSmFVMXBWcS9Yb09uSXJ1Umd5V3g4dGllRHRudHhi?=
 =?utf-8?B?cU1naGFyNlVFRy9WcTNKc243MGIyci9KU0EwRGpZOHJDMlpzbk81Ky9VQU9C?=
 =?utf-8?B?dlRqOEdseUR3MTNqMkFEMUJuWGhqVjNURGxZRW9tWVNvWjU4OGYwejg5ZmZJ?=
 =?utf-8?B?R0lPZmFaQW8reGE5b0NuUWRvd1NQOCtOcTZNWnZzZC9zMVZheUphVHhZbk1P?=
 =?utf-8?B?TkgyaGJaeHhWQ2dMWGFQVjRqY3dsN0JXT3NRcjVRZUdaaEg1bEhuY3lSVlVB?=
 =?utf-8?B?L2FNYlhuUGdaZWh6d1UwbGtnUWlKalVEQy9RV3BSUS9FR0NJYXlEQWwva2FJ?=
 =?utf-8?B?dWJmSXpvSjNkQWFSMUlWTmMxY3dSRy9rRVBUeUdBRGNtZ3A5bExvdTFxVmVa?=
 =?utf-8?B?QWFNdGZ3Zm1DTjRtYWZEdEQxRXRYWnZZbjNSb3FSSTRQV3Awa1JpcW5mL243?=
 =?utf-8?Q?dZdha84KW4D9PcrY/bhImxS2b/b4cIJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe2902b-a792-4697-7560-08da064c5828
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:23:39.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FxxOZmu4uG+xQhWpLq55IyOcHa6SZ5P6gfoSEkrnxE2JXqb8RMMZeApnZefnfPPhRrYp2mGdymhZtpj/oJCxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static bool is_amd(const char *arch, const char *cpuid)
>> +{
>> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
>> +}
>> +
>> +static bool is_amd_ibs(struct evsel *evsel)
>> +{
>> +       return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
>> +}
>> +
>>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>                          int err, char *msg, size_t size)
>>  {
>> +       struct perf_env *env = evsel__env(evsel);
>> +       const char *arch = perf_env__arch(env);
>> +       const char *cpuid = perf_env__cpuid(env);
> 
> 
> This code dies for me on the latest tip.git because env = NULL and
> perf_env_cpuid() is broken for NULL argument.
> I don't quite know where this env global variable is set but I hope
> there is a better way of doing this, maybe using
> the evsel__env() function in the same util/evsel.c file.
> 
> Similarly, the is_amd_ibs() suffers from a NULL pointer dereference
> because evsel->pmu_name maybe NULL:
> 
> $ perf record -e rc2 .....
> 
> causes a NULL pmu_name.

This should fix the issue:

@@ -2965,7 +2989,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,

 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist)
+	if (evsel && evsel->evlist && evsel->evlist->env)
 		return evsel->evlist->env;
 	return &perf_env;
 }

Thanks,
Ravi
