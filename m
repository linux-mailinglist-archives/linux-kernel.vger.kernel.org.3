Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1359CFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiHWEUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHWEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:20:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3AC5E320
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk7WREgyK312vYFSUa8I8JhCOJhIZmVa4uF48TjtQ9dYqaz7A7I4Zswza1ea5h8dm4bVvjlFw7ZkHwE7iskOWitZUSd/yCZor3h2cMTPy9xkCzlURkdgr3zrwKsP2dySQ7Zb3/mIkWJZQw+R3EZNNMEr4xUrN73MrSeFVO7/BHpOEK8lH5Fw7v4MrA+cNjnlDWyAa+bDL3yQH/VzoN9cFm5tpPTprSo67HMj1ndhz2BBhxA/EFAUzPcGZsfidg3VLgwETgOy3kqfrA3K4a3AcQkb5wLfM1AXgk4WP+KClRIPcOS+Y1x9Byjr2LXt8/jq+PkDIV1UnckjtsUrntEHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgx3rSX495SQmiWLZFKFwoPja4nkE4cf4sQVYcDfnhI=;
 b=KWwh54zKwI+dSUslYZBbSOf4j2uGXoWjrMahu1avLgEmoA1VOKgGn+eXR5GH//Z7VtkkcLq4OooIUxdWbvY8m/rkoUlWJkOCKN3vTZgyDwRE+ty0VCmbdqncCuuTgiIvn4rvcQ1Lj1UallVxFAhIvXiNA08IN3Jut64Cs75kncaIN9tHAQon7KBCok9DBjH/itgU2/S29VsunBQAurotGXk3OK2EqqxmjmCmm4CtZip+PahsnyEv45Voy9dsBPoA6A1c9iGrjOKX8kIUazemkzdLzc5C0JD1+tAxc1qLCts1h/OxZwhs4njzWpBC+OevSqgLCgf1ZqLvgOXGvplRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgx3rSX495SQmiWLZFKFwoPja4nkE4cf4sQVYcDfnhI=;
 b=0mba+wjIIlGhGl+D6ChtKW5ud2ZJDQXQYWd7/fdIpWr1Nd8xVvphNlBfPl//Yvwx4uELXOTiYpAhpZBO4YrL8YZ+9ZO5LjG0GUXAMkwpu9ksO3HY0GCs2gg29vYs+H8V0O08uRgmEiV4s80rIf3Ii5tix1NTCKhh8tHP0tq/hjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 04:20:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:20:46 +0000
Message-ID: <c43751d6-8e85-28af-2cc5-4b90afea855a@amd.com>
Date:   Tue, 23 Aug 2022 09:50:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
 <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
 <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f800e30-8f38-48f5-1ba9-08da84beda05
X-MS-TrafficTypeDiagnostic: BN9PR12MB5338:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NKB7zfjOwRohYeOQsy6HzKb45kqft/FcQOB6/WXKjGX9babWcVXAk+BdjJx0tJNmt5i55/x/jkZtd09BhGjZqm6tIpt9fGuLL3uvrh2W1Vj3r8paV6J49rgAQAMImpayEScpLnyblnADJJDgiHvNalkxeTYMQC0nG1mQFPR4IbUdNTrzgmDUUatA4PZgzZvEon4eJmyNqtf6/lCyekGgJy8IBJ2YetPtG7SZDSlczb7p0h6I/SYUnsQjAOJohWXBAz0i/TbI765g72V1D7CFuQghxxh3Yst6IKUcU6aRPMe4OrIFtqBXEfG0SlswLTF6V1l79HeGkDbT/Q/6nfrGGVOlzlSd1GlrGy5gkXjWjjQExw9g/JEZKxtCfWH70lCf83ft+kGbWADRLTrd+t/0AaFVGVRbhWXagHobOG+YFqcGjWKaYbBSC4baT0YIahNrlDOy/nHnZZZXMoOWN6LHlqIn/qyfddyH60+K7Mj5Xl0dxC3CuWyIwlU+kBqRjX/3plyIy0cQZSWc2YLpSOkvNptQmclfTocVRew+1fa3jMW1PHIbDizgpexCOhwpDNnzQ0i+/5QXlhEUaE6jUDfsbnqUqJzcySkOiKJouZ7Q7X5xO5h3jNG7Z/ldlHBM+oNf/82xwo8z6HvEOVeYy1pOJe7nIM9mBrdfV8pukqoaqPFyie0051lU3RpN+Ok5MY2duqss3vdGGG2blPQkScyPli6Y7cfCDYTsUVSZJ7i2varyph3OotTUBT7As0W6iEg0Mo9kpTutR5XSYD3AOY/kcuQX1Pz4m0lH8NaVgPXD3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(4326008)(31696002)(2616005)(86362001)(186003)(38100700002)(83380400001)(8936002)(5660300002)(8676002)(66946007)(66556008)(66476007)(31686004)(7416002)(2906002)(44832011)(36756003)(41300700001)(6486002)(478600001)(6512007)(6666004)(6506007)(26005)(6916009)(45080400002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MSt4Skd1d0VRNlFtcEJDbFdqMXpJcFRFZGlmVy84MW94N3JHMktVK052a0xI?=
 =?utf-8?B?WnJEbjlhczhlZlNVdHNJem5GRy83M093cXpYQTZJbzR3ZlBRTHZ0ZG9VUlZC?=
 =?utf-8?B?MVlGOXJEc3JNWHdoRnBjZWM4eFdxV2UvMlFuL3VIa095cHRnK3FmVDMxS0ZP?=
 =?utf-8?B?c01ndmtHTndFeTcrbnRRMitIWVdMUWZRUUpiT1BUbEEwVnF4eEhYQ1o3VmpJ?=
 =?utf-8?B?Q3ROLzRPMzJ2Z1VuL1ZkZnJmbmtMb3l5dDlDNDk2Sk5MMEp4WnpXS05vSHZt?=
 =?utf-8?B?QThZWEc0V2d0UFBWbnVsZ2hwZHhWdlN4NU1EZmp1NkljeWErTDBHR2pVSWRX?=
 =?utf-8?B?UkhRWGR4T1lLUjdlbDR3YWVPVzFYdGRRZ3RYeXZXMjhUYTVEV3NTb2lCT0Fq?=
 =?utf-8?B?UEFtRjJNK3dxL0RORTc0eFMwRWRndFhndEpRdU11bjM0Qzg1YWpYMWlQV3dS?=
 =?utf-8?B?K0o5M0kvcDVpRis1ejllY1RKRzBUbXVqcE9mdnVuWStqSk1PMWlyVzBPckpI?=
 =?utf-8?B?TGN1WjhxWFhRSnRnZnhNRktQNXhMR0FmTXBWNjYzd3NrSHZuZG9MMURJNGt6?=
 =?utf-8?B?VHhVQWVyVWxVWWF5Z0Z4b3pMNVJpL3VaUFNpMmtkZzR3ZlpTL2VMSnVtMVc0?=
 =?utf-8?B?Q2dsdlprOWdjUVFFYk4xZUNUQXNYTmFNTG1JaEFta1V5V1lwZ0pGSGx2cmcr?=
 =?utf-8?B?blhDbmJRQ1FpVUhieHF0bnVBa2RaYWo3WVhVR2NoWGdraUI4KzFyd2tpMmlN?=
 =?utf-8?B?K1RkNVBEaGhBd1A4VXNQOHM3YWMxRlZLYUp5bGtkcGRJVUhnSlBlQ3dxUFVT?=
 =?utf-8?B?clc2UGxiKzkwRGwvK2s5U0E3Vkhzck1IUkJGMi90R3R3SHYyTURLZTBjdWRp?=
 =?utf-8?B?bHRrb1JqdFhibkFMZTVycUhwenVnZDhLU0VMTmxsRnZiek9wNHZ1S2dSTExz?=
 =?utf-8?B?eEtzTjgxTTkrN01vOWhVRGJsRzlXaFdHU2xJK2d4N0pvS1hSL1RWa0l4WVNz?=
 =?utf-8?B?bVR0eHR3TW94Tjd6Wk41MEF6emNtS0ZnTXZwcndoOGt4YU94NE9NTGRyNjhZ?=
 =?utf-8?B?TEQvMFVsQndudGkvUU1YV1Q5N3JmM2lZUlNUN2cwOXJhR1BONlNZQmxUbTA4?=
 =?utf-8?B?ZXpqZEd6WWlsc2dVOStaNE9nZXNmSlE1NEE4ZTRkdFpDbStzdTVhL3J0S0do?=
 =?utf-8?B?T1dxVnJjRkhuNTRCN3k1WWdhczJnbDF3MXJDckhIcGNFaGtFWFNmSkV2M3pn?=
 =?utf-8?B?M2pYKy9rN1FFMWZLZXJ2bFhZekhlc0NMci81emZkTnc1N0hXa1FCeE5jMzVn?=
 =?utf-8?B?OElqQjBSMlZVSGQ0Mzh5dXcwT2hJNDhLb2ROSWtjNUxYRlVkTzRtaGh1UFI4?=
 =?utf-8?B?SXNEb2R5WGdQbHpwd3pZT29KdkY4QVJzVDgreUdjVWdITFh6QzdHVHJSSFVW?=
 =?utf-8?B?clRqZUhsczhBOWY0ZE1TKzd3a3BsNjEwSHhVcjNZZ1drN0VSenVyYTJXTmFC?=
 =?utf-8?B?MDdqQTREdHBQdDRGd3VCVy9LWm1hMHRkS09YeVJxVHhGSWU5azdTemsybnFJ?=
 =?utf-8?B?M3B5M2lacUhpSUNWc3AvSTRUenhpaHJBcEFGQ0x2bXVQNWduSUF4dllLT0dU?=
 =?utf-8?B?aU9KOFlKSFlOMDk5ZXhFR0RaM25qNUlWaVc3YWhEYWEzNHFmRzZXVFJGTSto?=
 =?utf-8?B?NkppSE1EZFRrZ2M3UUxVTG5LOFB0SjIvQkZheGhyMjNwdXhqQlFoWkV1SXZq?=
 =?utf-8?B?VGtVcldHb3QrSEd3ZFB5WGxoOUR0ZGYxSFc0R3ZUVmtUSElEK3RYejcydWUr?=
 =?utf-8?B?SGNxSFcxNEI5RlNrRFFjT2hqb0oyWmFsVG5kZVVaSUd1TXJsWWY2WnZia2cz?=
 =?utf-8?B?S1JMa21ha1NvQ3h3UExIUFBVeHRwYzAwUEx3VVNNQk10TEJJeTdlalU5MmhL?=
 =?utf-8?B?dnkwMU50TTZPYzJqVDRqUWppQWRLK3AxM0FaN0d6THBjV0hOOXUrbk1USlNM?=
 =?utf-8?B?UUE5UkJVcE16azlkMStPb3QvWE5NMXoxSnVzSFYwckVBNS93eHdUY3VKVFJn?=
 =?utf-8?B?c1RhOGRvS29BNGZ0Ti9LTWJUeWVWUnNSMXdCUDAwSzNrZkpyaHFzazVkZnVv?=
 =?utf-8?Q?/uioPUMmzh3y3zkUt1tgw6jpR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f800e30-8f38-48f5-1ba9-08da84beda05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:20:46.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvwqE4r9bq4s4ZVZxX+hcD+01XnqBIswYN658TzHkpkEkvIHYqfw4Y0/D3RNuAwga8SpyGrKP61Dv5gFb3yiyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> With this, I can run 'perf test' and perf_event_tests without any error in
> dmesg. I'll run perf fuzzer over night and see if it reports any issue.

I hit kernel crash with fuzzer. I'm yet to debug it. Here is the trace:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 48 PID: 0 Comm: swapper/48 Not tainted 6.0.0-rc1-perf-event-context-peter-queue+ #153
  Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.7.3 03/31/2022
  RIP: 0010:x86_pmu_enable_event+0x3c/0x120
  Code: a0 63 82 e8 26 7c cd 00 65 8b 05 4f 29 01 7f 85 c0 75 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 c7 c7 84 a0 63 82 e8 04 7c cd 00 <8b> 8b 98 01 00 00 65 48 8b 2d 2e 3a 01 7f 85 c9 0f 85 9a 00 00 00
  RSP: 0018:ffffc900004e7d78 EFLAGS: 00010002
  RAX: 0000000000000030 RBX: 0000000000000000 RCX: 00000000c0010200
  RDX: 0000000000000000 RSI: ffffffff8263a084 RDI: ffffffff825d5466
  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000006 R11: ffffc900004e7ba0 R12: ffff88bff6019c60
  R13: ffff88bff6019e60 R14: ffffffff82c35220 R15: ffffc9003ca83d38
  FS:  0000000000000000(0000) GS:ffff88bff6000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000198 CR3: 000000407be26003 CR4: 0000000000770ee0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
  PKRU: 55555554
  Call Trace:
   <TASK>
   amd_pmu_enable_all+0x68/0xb0
   ctx_resched+0xd9/0x150
   event_function+0xb8/0x130
   ? hrtimer_start_range_ns+0x141/0x4a0
   ? perf_duration_warn+0x30/0x30
   remote_function+0x4d/0x60
   __flush_smp_call_function_queue+0xc4/0x500
   flush_smp_call_function_queue+0x11d/0x1b0
   do_idle+0x18f/0x2d0
   cpu_startup_entry+0x19/0x20
   start_secondary+0x121/0x160
   secondary_startup_64_no_verify+0xe5/0xeb
   </TASK>
  Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables libcrc32c n$netlink intel_rapl_msr intel_rapl_common kvm_amd kvm ipmi_ssif wmi_bmof irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sp5100_tco rapl pcspkr acpi_ipmi ccp k10temp i2c_piix4 wmi ipmi_si acpi_power_meter vfat fat ext4 mbcache
  g200 i2c_algo_bit drm_shmem_helper drm_kms_helper sg syscopyarea nvme sysfillrect sysimgblt fb_sys_fops nvme_core ahci libahci t10_pi drm crc32c_intel tg3 crc64_rocksoft libata crc64 megaraid_sas ipmi_devintf ipmi_msghandl$r fuse
  CR2: 0000000000000198
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:x86_pmu_enable_event+0x3c/0x120
  Code: a0 63 82 e8 26 7c cd 00 65 8b 05 4f 29 01 7f 85 c0 75 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 c7 c7 84 a0 63 82 e8 04 7c cd 00 <8b> 8b 98 01 00 00 65 48 8b 2d 2e 3a 01 7f 85 c9 0f 85 9a 00 00 00
  RSP: 0018:ffffc900004e7d78 EFLAGS: 00010002
  RAX: 0000000000000030 RBX: 0000000000000000 RCX: 00000000c0010200
  RDX: 0000000000000000 RSI: ffffffff8263a084 RDI: ffffffff825d5466
  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000006 R11: ffffc900004e7ba0 R12: ffff88bff6019c60
  R13: ffff88bff6019e60 R14: ffffffff82c35220 R15: ffffc9003ca83d38
  FS:  0000000000000000(0000) GS:ffff88bff6000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000198 CR3: 000000407be26003 CR4: 0000000000770ee0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
  PKRU: 55555554
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled
  ---[ end Kernel panic - not syncing: Fatal exception ]---
