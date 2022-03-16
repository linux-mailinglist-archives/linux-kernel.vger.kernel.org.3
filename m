Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B664DAEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiCPLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352041AbiCPLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:18:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF660654B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxTIK4GAhXi5QFzwuFPSe/A1h2p1z6OvooVFRahRaRfyvhrH8yvlbpeE/8E8upb/YuUn8LfADCXF9BBYlCORku7VbG4dFdQVZJacu4m6ZF3FJ1+p5nGRJtTvZgOKd5Y8dc+9sj07E3rUF2kUpHv+gSsndCnDefDV93E+te1OZgxEbQ6nCUXPjR7LdWrM36BBRhCc9EIPncBIJJhryjzciCICYarjylU1TQOgmpB3iW093wINQXq67lZMBdh4SfC4X2BI4RQhpREueTwEO69ggz8aDT4tLuEgtL5J35fRP+5Ffd97yVa6Sw19iAFIL3p/0xWoQ6nIdQtd3LDG2AQPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP9FQrc22gZLoGJNWx4okDUdifZNCMBLp+pcdy2OTLI=;
 b=huYHwFtJuv8pIRFPDLqAbh3wMAFY+syf7Mz/wAsH77V8r1uefAya4M45/lsjRCOZ4WbNXEKhFVIcZYH8hRMbLIp9J15dHFpHQbhOLIQJv4bKofxmLdFw5kaUFGIXkxE1K11dvm+BH7b0javYoRXDpuu61osy/45ZNak1xk1nMbGEWBJFXwFoWGm4IIDfEZ0Pvr2xIA0etJwQV11w7lbfjMJiAgtY3l86xTSnJgyDisxxdEXgXLX1O8Jr8e//0MMvfzlbSg01/Ba2nWLBjU1jZE5rY0wWqC/Mj0Izbhy4jFVj6RbYpESocczIRdqL9HRSoQE3CPTY/4BGAJNH4KPIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP9FQrc22gZLoGJNWx4okDUdifZNCMBLp+pcdy2OTLI=;
 b=lKk80P0t9G/+XNk6zC3K0aiSeQaqdvJ0JHyQHW9NZkX78d9TYc+q1KlxxSEmEXITCN859UJv+53+Vi1GnnSi4SG42W2yhVTF9VCWYyDFPKkawnN0IroZb0o29YhuqeH1B9p6ccJUSC2IIQCKBYPw23dRJExW7kE13N7QnnzA7+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3051.namprd12.prod.outlook.com (2603:10b6:5:119::29)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 11:17:10 +0000
Received: from DM6PR12MB3051.namprd12.prod.outlook.com
 ([fe80::7166:2b70:c084:359f]) by DM6PR12MB3051.namprd12.prod.outlook.com
 ([fe80::7166:2b70:c084:359f%4]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 11:17:10 +0000
Message-ID: <ec3ce0b5-00bf-6deb-1b71-7a215104099d@amd.com>
Date:   Wed, 16 Mar 2022 16:46:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-11-eranian@google.com>
 <aa641092-98e6-114d-b423-13e0bff248fa@amd.com>
 <CABPqkBQZRVqWPFG0Dvc6HGxNcDDb0raaRw4Ur27CvR5O8vwALg@mail.gmail.com>
 <d32a5a9f-f634-ea3e-d68e-b07c9bab9add@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <d32a5a9f-f634-ea3e-d68e-b07c9bab9add@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To DM6PR12MB3051.namprd12.prod.outlook.com
 (2603:10b6:5:119::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac0bf4e-7721-495e-6d3f-08da073e8380
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25843D054E8220485C8863EDE0119@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTcZKUbuyi89+uSedUGR4p4oEv2XHS0v1PBwTDvVhueyDs8F5+PN8QoV3ZkjCmxUnI5kjlV5r6nCPGpRmn7kxcCGUCQkkGzi9sqV3vcqT8Ow+9qVjr4dYTSbhw1LlsFFi4ogRGlblPpSngwSQsdUbwJFOEPVF+0aKwaAWZqls/H/YH2csK9Q8e75z9sQbsZ7YOb6GwQB6cmg5JbzSmSjFx86e1+e3D4RkQMrBY/JTqTb6eULYqpzvaFPceHjInsLPtsfAAmFhcZzq0HX715dicpHnGKoNk2MfLnlmD+FvN7C7SmuSI8SiHY9Xh6z2bHA3X6Mb4xLB0ieKPC2dyAqBUSyC4iYs64MNnJm3J2dWAukmiHYAuhEkI0i39jh8qyI9/4MkbMQTxvcSfgh2h1K4aqnP60ytPx1f0lFWuE6bPOdK1vG60a3DD8kchp5N33eaNLhmvJ8RSo/au2hsXFP9cXzGtDfG73Hg86VzjcHqy59Iv36Mb2Fqu3tchOzr2xr9p0iqWhhaaQwGDACt9EVkpkvexOmSWMKhCOVwDSiB2kt0men9Sl84BpqZbi+Cgnxm9ntobMNKR+9FXnTAlJs3Ss0OC80pVzRwGzo06PHpqhD7THHFrMhHoqWg/leiXihlLQ6WGXmJTX5qG63UmgHQrndDMUE9rCm4nFIFSxLFdzS/IXST4ROAPPG56G28N4kkFQ4F+y37PsIaEn2XxVIjsJXWMT7XWFodUHl3I/TagSHpJEv+AKoaip9a9tFqleT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(316002)(26005)(83380400001)(186003)(4326008)(6916009)(6512007)(38100700002)(86362001)(6486002)(6666004)(44832011)(5660300002)(53546011)(31686004)(66946007)(6506007)(66476007)(66556008)(508600001)(2906002)(8936002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhVWUpSWTBPSGdGcW9idHBQRHc3VkN3TzAyTExocmZneXEzSHlaakowQVQ3?=
 =?utf-8?B?TE1VRjR6SVdHZytPMDlablpzTEpUOXZJWWVKY0EyaXhHQzJVVHVpUm9MNU1C?=
 =?utf-8?B?S3V2WjNDZE03d1VCSHhQdjg0Ym1zczRod1V5aVdMaXgwWE9OZmpXNXNvbVZN?=
 =?utf-8?B?Vmk1VklBUXhMQ3JuNnhySkpLMFp2cUJKYk9ZSGlJZU9ObkhKVkVmU3IyWU90?=
 =?utf-8?B?dzRjRlFKcXpOUllJRlo1UnovL2N6VG5zaWZ0OGYxNlVEUzl0L2ZYaE9ON09S?=
 =?utf-8?B?aFVpYTZwcEk3VmRTd2k4anpCSTFCSFRBcWRhaGwxdjg5eWNlM0RPZEtVdlYw?=
 =?utf-8?B?V21mYUc4Q0VQOU1zeTQ0Lzl4azlPYmt2NzRmVVNPZjJUajlnNkgwQ3ZkanFv?=
 =?utf-8?B?YTJKNERkSGRIL1R2MXJybGsxcUVOSDBRVVdyemdUNjFZUVZpN21BR2cwVjhM?=
 =?utf-8?B?dHdDNHJMKzZtUzg5bERjRFIwM0Znd1hCRDhGUmxFNEtIUVRQcFZFZ3lsQUdj?=
 =?utf-8?B?QXo4N1BEZlNDaU5sc0VrYWpWb2RPQ3JNTmVzS29ERW40Vkt5dHRncHVJR3VC?=
 =?utf-8?B?YjBDbFBMM3NkVlZtYTZGL3hHajAzME9Pb1EzRm42bG1LajZNU3pGU3hyMXVz?=
 =?utf-8?B?TnVscFdxRnI1UlRtTGUyWFZXWk93STRnZHNQdjZHZk5QaklrKzNkZDBOQmlR?=
 =?utf-8?B?cnRSSjliVzR5aDgyazdpNHQvSFhBRkpqT0NDZHF3cTdCRFdMY0pURkNZQjIv?=
 =?utf-8?B?MklDUEp2Q3YzV0VYS05OYmZpNWJPeTgxZVVnT0taTW92THArOTNtL1owcFRF?=
 =?utf-8?B?azM3ZEtCUnRNM2NlLytvdUNsdzFUWDNBdHYrZU1hbzhlb2k2RG9NdFNIUC9I?=
 =?utf-8?B?Q3lIUXcweC9DWldWVDh5K1F2K1k5TkN1WUkyR2x3Undtais1MW1ORklON0VR?=
 =?utf-8?B?UHFOWkhWRGxCQ1g1REhybkxtb0tVWlpUM2ZDalZXTVZlZnQ1YzdjZi9wMzlk?=
 =?utf-8?B?RzVraStSYjdMVXhNS1dwZE0xTXNVeFI3ZzRhZjZheTNjeWkxOTlaS3hybFhL?=
 =?utf-8?B?QnpIOXZGM3NSMTc1N3FLa1hDKzVHeWFNcDNqWGJJdnMvcVE4LzRuRGlqNjVH?=
 =?utf-8?B?L3FZTUtMRXkxQW5NaVlLVndzTDJGczJkZmR4aUg2elFJWDFNNDRRLzNiVHk1?=
 =?utf-8?B?K2JvOHlWcE10Q0NuNWJKdjJ0V2Vqb2pBWFV4NEFQUjlSY3Y3RThzd1VIOGhn?=
 =?utf-8?B?SGtiSXljYTZZN3lwTE1kR0g1QzF4bmZLZjVCRWNyUVpYdG56c2JUNG9oOVJ4?=
 =?utf-8?B?ZDZ6R0ZvM3dWM1ljbXVLVUltdWE2MStLeDBKSENIRGhJVEhpZmZhU01jNVl1?=
 =?utf-8?B?WEYyVmJDM1Zza1FzaUlsWHc4dlF0c3pGc3JYb3JzMTBzOW15SW1aNnFWTVNK?=
 =?utf-8?B?MFNkWVdLTGxqTVdOWEo4c3Z1SFFydStYZE1xS0ZMdzVqU3ZjOFNRVHlwYzl2?=
 =?utf-8?B?QWZ6dTNtSUNGY1FEa1pjbVRzTUZ5ak9qcFlmT3NtdmovY0tveDlYTTNCQWxL?=
 =?utf-8?B?Wko4SEU4SWFCbjBXeTFpMjhWQ0I5SGo1Z2dhQ282eTFXUkhkVHI0Y3hndGd4?=
 =?utf-8?B?ZHR0cnpOc0hMb3REby8ybzVwSTdwVERzNy9BZHZlUldHUXU2NE1nbHdiZlJC?=
 =?utf-8?B?REtiS2dDQk9KZUJLSlJ1dGUyMkprUVdqMnF2YzlubmlQQjlhdkp2blAwRCtI?=
 =?utf-8?B?WkdMRG5CNy9lNHgvWHNya2FFMVVkbmh0aU5nb0l4WTcwN0swUEFZQlVJWHMx?=
 =?utf-8?B?YkZTK05QZkZNM0JVdWJEQk9LOUFDQzljdC9TdVRHRUtpb1dPNktQbUdDN1Qz?=
 =?utf-8?B?RkhRbGoycFJ5K2s1TVdMTVAxZW9obkRWRDgwclBwb2w4MERhbHovLzFPdDJI?=
 =?utf-8?Q?FNyARCtQgvNvpPBIR9AlmDNSzbSpVS7X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac0bf4e-7721-495e-6d3f-08da073e8380
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 11:17:10.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkFq+d8bn1yN5BF1it5v9z7ux14O61ggo51CVgV4bLAf35iXr5onlhtu/hnfCVO4rhNsQFJ93TehMCPbYr1Tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16-Mar-22 4:37 PM, Ravi Bangoria wrote:
> Stephane,
> 
> On 16-Mar-22 5:33 AM, Stephane Eranian wrote:
>> On Tue, Mar 15, 2022 at 12:46 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>
>>> Stephane,
>>>
>>> On 09-Feb-22 2:46 AM, Stephane Eranian wrote:
>>>> From: Kim Phillips <kim.phillips@amd.com>
>>>>
>>>> improve the error message returned on failed perf_event_open() on AMD when
>>>> using IBS.
>>>>
>>>> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
>>>>
>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>
>>>> Output after:
>>>>
>>>> AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
>>>>
>>>> Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
>>>>
>>>> Error:
>>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
>>>> /bin/dmesg | grep -i perf may provide additional information.
>>>>
>>>> Output after:
>>>>
>>>> Error:
>>>> AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
>>>
>>> This patch seems to be causing regression to perf python test.
>>>
>>> Without this patch:
>>>
>>>   $ sudo ./perf test -vvv 19
>>>    19: 'import perf' in python                                         :
>>>   --- start ---
>>>   test child forked, pid 145391
>>>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>>>   test child finished with 0
>>>   ---- end ----
>>>   'import perf' in python: Ok
>>>
>>> With this patch:
>>>
>>>   $ sudo ./perf test -vvv 19
>>>    19: 'import perf' in python                                         :
>>>   --- start ---
>>>   test child forked, pid 144415
>>>   python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
>>>   Traceback (most recent call last):
>>>     File "<stdin>", line 1, in <module>
>>>   ImportError: python/perf.so: undefined symbol: perf_env__cpuid
>>>   test child finished with -1
>>>   ---- end ----
>>>   'import perf' in python: FAILED!
>>>
>>
>> The fix I sent you is just to prevent a potential SEGFAULT in
>> is_amd_ibs(). I bet the test fails some perf_event_open()
>> and ends up in strerror function and from there I don't see how the
>> patch could impact the test, given you'd segfault
>> otherwise.
>>
>> I tried on my side and with or without this patch this test fails. I
>> think this looks like an unrelated issue.
> 
> That's strange. IIUC, python/perf.so needs to know about util/evsel.c

I meant util/env.c not util/evsel.c

> which can be done by adding an entry in util/python-ext-sources.
> 
> In any case, do we really need this patch now? For both the example given
> in description, I see no difference with or without patch:
> 
> Without patch:
> 
>   $ sudo ./perf record -e ibs_op// true
>   Error:
>   Invalid event (ibs_op//) in per-thread mode, enable system wide with '-a'.
> 
>   $ ./perf record -e ibs_op// true
>   Error:
>   Invalid event (ibs_op//u) in per-thread mode, enable system wide with '-a'.
> 
> Same o/p with the patch as well.
> 
> Thanks,
> Ravi
