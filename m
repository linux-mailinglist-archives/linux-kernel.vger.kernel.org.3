Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560244D94DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbiCOGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiCOGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:51:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB948286DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNLe6OywPwEVSNWk0OkhyHvkL7MKPhv5eeV39ui9HN88sdEXFmbmDhtlv1jQ3uXIO7b5JsVdWQITcZAklf9hwPYqkGSGaFbiT+7UFjvdAgmzECRqIaK9X9MZ96hYmt+duNHqJvWpqygUWC3fqVLozI9GjhuQAoCplZTpICmXv8wWVtAX9/1tyA1pdkVuSW71g0sTMNJAijDn5nZ4i32HVlCmCSB3YvC6tKMpCC/92M7LMQgPfzSGd7w/KboGIzsZKRjBwWluT5rNuBqNjQREMnkNOIauXR3xMvOTn9OA1AFtS+EtirpE5aRJpgXMZkdVsRWNzQOMLG7rA8ijqv6q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCQk0rao5f8n40A+ieLN7vrk0CoAwhXKujBNife/1hw=;
 b=fnqjcIa9UTgtaepX9TS0Qk/4TPpNGUXMxVHKRGjH4QcB3VIaJF5IjHalKGVqhLtvMZvYJVT0xdPjZtmxuZBhz5s07BG3Q5A9/ImiQx9XrbCpEsYfgwsxe4CDKWx4txPPUvyxEidsDUz91n8QVFOY+T1CghmcisWYVBczQWEbzsN9x/hNNYZg/2BFbWxYB7Imhi1HNZF3cuBUuR54JxlG/Q6VM0SKrg3EN4t9EMH5dGAOeH4jkIVwcO8kbnHjOhCn+9Q0tPcyp+YgrwCYuj37O1wfhPdeEkRfr6f9wBjdkTVckvQI5jamXrjTmzgtlxtT8ODnyGhRfT/F5p6y+rWuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCQk0rao5f8n40A+ieLN7vrk0CoAwhXKujBNife/1hw=;
 b=SH5LgBmdGBuuD3UQMpdEo1iP1A+qYb9mK17dOHnGf9Dg0mAUMijghGhxuDZeOTX3/lqwpAJJKtsenCQnJO41e5m9SonqVvdG75/scm9R7el9yH1Pxel5RikPmsvVezB753/opXVfBv8uWJEPqzwnpVK8bDOEobVZExMoHe7yJs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 06:49:50 +0000
Received: from MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b]) by MN2PR12MB3053.namprd12.prod.outlook.com
 ([fe80::9117:ca88:805a:6d5b%4]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:49:50 +0000
Message-ID: <069404c1-3c37-4ace-ebcf-8db5b3ac0080@amd.com>
Date:   Tue, 15 Mar 2022 12:19:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-11-eranian@google.com> <YgPiItRLaEJ75dUU@kernel.org>
Content-Language: en-US
In-Reply-To: <YgPiItRLaEJ75dUU@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::22) To MN2PR12MB3053.namprd12.prod.outlook.com
 (2603:10b6:208:c7::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 905f923d-2170-4ff2-b15e-08da06500065
X-MS-TrafficTypeDiagnostic: MN2PR12MB2878:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2878B148004686D569EB5DACE0109@MN2PR12MB2878.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i00yOR3KF/M6+9XbeyPwVYyJ0iHZhpuxSQFvJJ4CN6smsSfhfSwesxnCFtijcEJSrs1gCZA8Tx1wr7jAMKykEe0Z4KEmiCPKhEa9jwb/SFlbYFdZvnbXKEFZnZpcQ42NmNE02ejfSSb3Ve+yYLmmc4DAQI45HOaXyMZBnCR8Dq4ed0Wcl3yyq0uKA8KN7IZ/ifTvNsmYZiNsMJxdeL/8Fkz4ZqpuRfXI4iNN2CpOeSaukXtxFkX3ip2I9MZuC8b8X369tc4+ROVZovhTumlEIAcIaMpN35JX6Cvi77Xo4CQJpGgCGK1LIixz55OB+90Q6aDaUMrssGW2n+Ww09vDF/sjdx1prZeoNG5TBx3yMpMbar0K1eotNzKTHx0A8g3wXLTuoHuRt53ksTuCZf64l+rXkR4smop4oVf5NMDj2ZQbrGEuy22eA86GVWf2dKgfNzeiUG771yplyNr7hD8xc3Dba1s8bJWihc7TZL3RYG0mAZs82gJUtDMKqG8WcWw5XHmjfilxRY783JM+gJFmCrlHE3pti9cqZRJjq8nPKbjxlHxaxWmcWzHcFBn/z68wMTyrIfSlo1QFKvJbgj6k7eL6SrNmBT/F2S7zAL/4HLTR492MZcnBNsVP76Fpn9Hqq4LzMZzoJPcW0u9QYFoGJ3XMMg636WU414zkIzxTT8CtqhEjFKggMKk16JDXwOqeyH9dwtZdVBxOSjIIX4JQpQaPypZy9QYKFt7s7UP6BZMl4Qu1kKc/MBeKUZQmcqKQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(8936002)(38100700002)(66946007)(66556008)(508600001)(66476007)(6506007)(53546011)(36756003)(31686004)(186003)(26005)(5660300002)(6512007)(6916009)(44832011)(6486002)(54906003)(316002)(2906002)(31696002)(4326008)(83380400001)(8676002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJud2FrU1J2VG92ZU02L0FlTXBsU200bHN4Zml3OHJXTWZINytKTHJ5Vk9U?=
 =?utf-8?B?S0tYcmppWkxkbkxUNE1sUWRNdjcrQ1JVM1BNVDRrcTV4UXZlTHdoajlnaVd0?=
 =?utf-8?B?QVhlbFpkUTJiZ2NXRS9Ed0VTcG9LUkJhUlIvUXVNOUNOL2VSNzlhY2ZoWnBn?=
 =?utf-8?B?MEJvbmVSSmlVRGJwUFFQc2s0d2VQUG1BcEZoQlYvVG5HV0RqK0xtaXEyc2Uz?=
 =?utf-8?B?VkFLNlpkbjdKdHpVTHpKeVdhMHI1UlVqL1FkaTA5NHRIVXFJbVlXZGZrclVv?=
 =?utf-8?B?RTh0bXRPZjFtRGQwYnBTMmlSNjFRU2FkOFZsUnlQbjBSZXBkMXltaUhTOG0z?=
 =?utf-8?B?eUUxdUV5RnFwK25sWkhxNFdhWFRuVVJaNHF6N3R4OEJXNlJuekREd29zeWtJ?=
 =?utf-8?B?WEVKNUNzczZFaUFBQXB4V1RVanNrRjNoTkxHa1B2TVdORXE4SnJvMVFYbHN1?=
 =?utf-8?B?WFZjeEtvM0FwTG5IQmwxdWFNeDdxSk0rc290MmZTNElSam1GWW45UmFJUHFw?=
 =?utf-8?B?enhDeDFYNGtSN1FrZVZmUEFEdFFPbmEydDZlZytlWXdRdnI3TFNxOHBSRE1L?=
 =?utf-8?B?Z2FsNW1XTXQ3dytib2Z2UmRKVGxKY2pYWEk1NWtORXk1anRyQzlBSkFkbjhX?=
 =?utf-8?B?ZFVrU09HOVg2ZHR5MUlDbEo1L2pEYWI0eWdXS1cvaHdtOVJKSUpHdUxGN1Jn?=
 =?utf-8?B?T3FYb0VLd0VhM2dtUSthendZT29xYU5iYTk2ZnpDY0lmMWJFa2FsQlFKYWRM?=
 =?utf-8?B?MGxPZUpWL1F2Uyszb3BLRDlJT09SMDh3aEgyQzNTYU5BZDNCTGdHcEdGM1NT?=
 =?utf-8?B?eUdYT2s4WUpmZFlNSDFDQjg5TW13Q21UQ3krUDJYNjFDdmVYQ2pzdldHS05O?=
 =?utf-8?B?RlBxanY3NTBKR2IxMmNqV2RWUWUwam9nRGdadzJWRHA4NnZOVXBBZXE1bjhr?=
 =?utf-8?B?ZWZMR0NrTWRjc051ZndYVnRrT0c2WkN5UWNoTnhOTjU4UlBlYUpRaHBEd1cw?=
 =?utf-8?B?VVJ5TzErendnTmE4OVBqRG9FRzAyb24ybXd2UTB5R0U0WmI3RFlnaTJQMmhH?=
 =?utf-8?B?MENlVi9GaWhSMlhRVHFUYm5VVGpEWE1scElnak15c2lEQmtLVFVvMmxvQ2s2?=
 =?utf-8?B?ZjFiOUc2Rk1Gc1JzOGlGTmtMdjV6N2lIV3ZTbm9TTW5sbEJMQmo0ZGhBS3p4?=
 =?utf-8?B?dXdZejlYV1kxYWZ4dWVaS0EvNFErWTBuNFFBcWhVNXFqVmx2K2JmZDFtek9R?=
 =?utf-8?B?RWZuNzR4Mlhpb1hremtMQWo0a3JXdnBYc01CMnBhOTQ4enBVRVlXbHdjVUZC?=
 =?utf-8?B?dVY4N3lHekxmNncvVFhrdnZVdFAxSFNBMVVHazdqeU0wZXk0RnVTUWZ0b0lo?=
 =?utf-8?B?dlhyMFFLcHhyS2hiT0IrYnorM3hUS3VGbU1iNGJjQXlBeWRvYkNpeTNpMG1V?=
 =?utf-8?B?dXcvODhCUERKSlgxQkJWRUpXa2drc01RSU5BQU41MWNDOWRSQkFBYWp1NUR5?=
 =?utf-8?B?V1dOVGoyb0pmNFgwcFl0L1RjZmRvY3lJaStmNitIdUorV2tHbGlObEVVbXRW?=
 =?utf-8?B?SkRkMEZjbEh1eXFDWTlVQVBCVmswckY0aSt4MllwOWJ4Slk5Q1RiSERtbjJW?=
 =?utf-8?B?NTJiMEZ6R1dyT29XOUszTGxLVTQxOU8xbnZWYXpxdmhyaVFiUWwzODgvdmxa?=
 =?utf-8?B?VFVVdy9MSHBEN0VsZzZyRy9IRTVWUHhqbnlCY1NSWG1FTGpENFZSTE1sSFVR?=
 =?utf-8?B?SHNwdW1WbUdyL1d5MXZ1b0k4N08vNjNTdHlOcXlFWHJzcVRRMitmbnFYbHZJ?=
 =?utf-8?B?b1VQNloyQk92b0pUSkl6OHhuN3FRVzVFWHk3QnVJSXBYSkZ5c3UzTXl3Z01z?=
 =?utf-8?B?bnNLL2FSblA4MitJUmZOMXdDcUpEVXNRYVJPR0tSTGxyYkwyLy8zN2FDZWJQ?=
 =?utf-8?Q?hv3fEJDTXN3yO1H3Ui+FL7pLipa4d4VO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905f923d-2170-4ff2-b15e-08da06500065
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:49:50.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7ElcTKwpKAflgOJGh70vsAiTasY3kJe2XAiAuONgeZs61dcU4Hfba1uxBA6z4Ji2PRneO9L8+4MWHTphkP/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On 09-Feb-22 9:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 08, 2022 at 01:16:35PM -0800, Stephane Eranian escreveu:
>> From: Kim Phillips <kim.phillips@amd.com>
>>
>> improve the error message returned on failed perf_event_open() on AMD when
>> using IBS.
>>
>> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
>>
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
>> /bin/dmesg | grep -i perf may provide additional information.
> 
> Humm, here on a
> 
>   $ grep -m1 'model name' /proc/cpuinfo
>   model name	: AMD Ryzen 9 5950X 16-Core Processor
>   $ ls -la /sys/devices/ibs_op
>   total 0
>   drwxr-xr-x.  4 root root    0 Feb  9 07:12 .
>   drwxr-xr-x. 21 root root    0 Feb  9 07:12 ..
>   drwxr-xr-x.  2 root root    0 Feb  9 12:17 format
>   -rw-r--r--.  1 root root 4096 Feb  9 12:21 perf_event_mux_interval_ms
>   drwxr-xr-x.  2 root root    0 Feb  9 12:21 power
>   lrwxrwxrwx.  1 root root    0 Feb  9 07:12 subsystem -> ../../bus/event_source
>   -r--r--r--.  1 root root 4096 Feb  9 12:17 type
>   -rw-r--r--.  1 root root 4096 Feb  9 07:12 uevent
>   $ cat /sys/devices/ibs_op/type
>   9
>   $
> 
> Running without this patch:
> 
>   $ uname -a
>   Linux five 5.15.14-100.fc34.x86_64 #1 SMP Tue Jan 11 16:53:51 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
>   $
> 
>   $ cat /etc/redhat-release
>   Fedora release 34 (Thirty Four)
>   $
> 
>   $ perf record -e ibs_op// true
>   Error:
>   Invalid event (ibs_op//u) in per-thread mode, enable system wide with '-a'.
>   $
> 
> Trying with system wide:
> 
>   $ perf record -a -e ibs_op// true
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//u).
>   /bin/dmesg | grep -i perf may provide additional information.
>   
>   $
> 
> So you're missing -a in all examples? Am I missing something?

AMD IBS does not support per-thread monitoring because it's configured
as uncore pmu (perf_invalid_context).

Thanks,
Ravi
