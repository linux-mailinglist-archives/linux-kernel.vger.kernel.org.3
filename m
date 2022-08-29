Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E766E5A41AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2EBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH2EBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:01:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC96EE20
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3YkuCwaEXzgaFuSBVhxTtqbcFc9BeX/xsKjs15oawVO7HmnlrlYdACs/K7K5H/ERBnfak2iPIAvHllX6kABpEI3w1NvVNAx5Mb5qP1pMmoIe90WsKAASbOp1ezmY80unKFzqAJ3eiZBc06ybrvShbvUPiWoPgqjiFcqvNKhSBYpZWlhz3fcUw0B89oVdFgTX/Xu/HN25ZvlN8q8/82uTQge//06Zi0NviWHh3PLNdmDZSJjfDLRo9KUW71EwDxnClZHpts73oAYv88hJS3VOp7WPLR71Dj26hPJ9fKCR7UlhzRNndunkYKDP31Co0fSFDMCCksZps0tjkTXGWdL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCQBPXYAAnlmJfa/btEnSc4E6sVXHNRxWxwM1Uu1+tA=;
 b=ce/xbbntU6AflhU4XAlTu8RCPShX/7M+nB/D1uVri7hLbLdsxRe2q7rLIfpnb1NHbas3f2NLdC6d5n8j/I312pcpsfIp6Kkz7uTLltOlqBPC5mSKbpEjUHH+LJjfrbEVfFnwjinsZrb3ua6fyUJtARk+wZh3/BohBlHhiIP0JDO8LskPp7USOTpA7QmoN4MAi7ZDe4aLujNRbJT9jOxlxvzJu5VeqeqMpjNKFpoo0aGEMwaDIa2/DgnctUol8SeBA9wz9eGV1PK+p2kmUiSm/NmLAygngZc5Tukdtm/rfksF4n2w5gUY0hW3mjhd0qKGP1RBXYI+lmq/Us+Pkvcz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCQBPXYAAnlmJfa/btEnSc4E6sVXHNRxWxwM1Uu1+tA=;
 b=WOjlqIJagi3TjAZiE7bjvzdB8grmar/v3oZIpeD0ADl4gIxC3rr2WR1H65L6Z6zyrfRH8JyZr9C43xEAKN/hViQjOQ6K3BeBkRHklAD6Tt8Vzr1HIGgKPfN47QMsnBmquh82kGYKKeqV4KUvkfWeftJ/P1Ak17c/FdTdRB5cWHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY4PR12MB1447.namprd12.prod.outlook.com (2603:10b6:910:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 04:01:04 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 04:01:04 +0000
Message-ID: <8d91528b-e830-6ad0-8a92-621ce9f944ca@amd.com>
Date:   Mon, 29 Aug 2022 09:30:50 +0530
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
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58230e0b-9b5e-413f-e6be-08da897317ac
X-MS-TrafficTypeDiagnostic: CY4PR12MB1447:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7riKbI1QNcjF+bgZe58eNMKTBqh/HIeaLPt7vJs/SpvuyIklJCezazAA90R/JZYxh55WPYd5I2pDK9mgSXVK3FXHDKkDCk7tPK6PhzWWTY5am09Bib3U0MReO+ndzHkCHya5mPxnVfBCDpFzl5rAVdjAusuUlP4+5JdPrt3Uidm9FVOlKBANudH4MdWF4b7/biVH0mP+IJ+bo7Z5xYnltJfHNkaDjBuke1qd4ZmlDhpkP53e3Gj2DWgELFjqC3eZoO7RvOzaI5hqaOrSStdf8+vIkK5paPdBkplFTBDEAp8xReI1FN+xBoXBpseiijmR8ck6TsrFknk5zqD5EYtZny04leyDUdLDfLA1GaWOjskGJMi8k5vlvK8W5G/y2y81W7PeH+eTDsQ7Q/ccqj2qOhecs03sCA/huWMBZjtvUgb89dB4xEg5gE482h2aKXB36SRod4VQu0MAA9OPm2KnWDNmC82Qry5YO2P1g6mGhubJUGr7jGGXNWyt+RSbacbM7+1woN4UHv5wvHegAcDT0RMGPEBWvyIOf1iyjYOGErBUWTe7QZh0r1KEchmEUUWFbKCIpVvqet7sQ/yk7ARQFun2yzGjmFtAJyru8vf6LZdsLh82dV1EDm8QLS39Fv5A97g/UzoB51D2vrChouFLnFxK825S3wnvYXNLDU37uhRyLCnBbrnVhiJiBsyE75gqHHJelZPB+HcGWYVRkt+FPhs/34iNFZm+ZDP18X2cQRenXyO1SgVRkWkv3yZkoPH4rDMiMKrVjFbjSCs4NxTe3TiJuvZ38FGSgvU6G9CNws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(31696002)(86362001)(83380400001)(186003)(2616005)(44832011)(38100700002)(36756003)(5660300002)(7416002)(4326008)(8676002)(66556008)(66476007)(66946007)(31686004)(2906002)(26005)(478600001)(6486002)(41300700001)(45080400002)(6666004)(6512007)(6506007)(8936002)(316002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU40RGxMTTJ3RHE5NDlPWTlFc3BXYjgwZTJDc3lrQ2NObnR2dFY0YW1Kc1pU?=
 =?utf-8?B?UWMxemdtb3RxMmFOdTlPSFk0cU90eXpYeE9jbUVpVTlWamYxVG1ISXZ3N1hK?=
 =?utf-8?B?TmRZTFlMU0lrdGhaaThkWVF1cHVTNnFnZG91ckZmdHY5L0pGcythWWVTRlUr?=
 =?utf-8?B?UFpnL3h0Nm13L0RkR1hzb29wSWJienNTNHVRNjBuQ1RUUHduVzMzUkhaTTFY?=
 =?utf-8?B?aFUvbFllZUpLNlNrR2NhS3RnZ01idzcvbmhqSjJUNEpmRUNjVU93YVBlcHJL?=
 =?utf-8?B?ck55c2tUaTkxaG9zckVEbWdHOTN0azBycUtKMkZ5Unc3T0FIU3NFT2h2Y2sy?=
 =?utf-8?B?UWlsdDJsUGhVblVZcGhZYVphR2RIdExJVEZPK3BONVR5cTdvaXhCemFvdjFm?=
 =?utf-8?B?L3NqVGFoZ09BbFFhcXZ0aUlXU0FUdllrMzg0Zkd5Q3AyelhsTlVKMmliQ1hH?=
 =?utf-8?B?cWJVa245RUN4dmZLMEpuZmk0aFBmVWxYVjl4N3NNMTBjM0FOZ3BjNXhVT0RX?=
 =?utf-8?B?V2s0c0NuOTVLZ2FwNUFrb2NoTStZTFNiM2ZoWnZVYTExZElUMlp4d2NBWERt?=
 =?utf-8?B?MHJnN1ZwTlFTU2dqSElnM2lkY3J1clNoa25kOWwyblR0cWxFVklTY1R2S1dD?=
 =?utf-8?B?WmFGRTVRS1BXQzdnbVNNQWg4YU0xU0IwVVptRzFJc2NTV0FWcWkrS21tYm9z?=
 =?utf-8?B?bEFqK0NiVHpvOUZORmVldnJPSVJxYzdYVlFvQ2xXb1hLN2R6VGdDY3IxeDQ5?=
 =?utf-8?B?MTJSVEVxY0JYRW1DMWx1eFdZbk9CTnhoSXl3L3QyOFoxOGVPa0xNbFBaOXBs?=
 =?utf-8?B?SkQzcGZkRTk4SWFmeituRlZhbi9IVVZIaUd2eEJhRitLR284dTlXTkh3YjBi?=
 =?utf-8?B?MU4vZTBHLzBQTXVVWHNiMXdOR1B6ZHBYeFBIbzhXdHdkVndKTXJHOHBrOS9Q?=
 =?utf-8?B?NjZySXlhYXVaYklNb1VsZ2dmWVdGRURvckt5aDIzVjgwMWtWeUZSeFo5dmNF?=
 =?utf-8?B?WFZBZCtzRWRDVW1HMTFxbUt6M2JKR2YxS2JCYlR6czFvRVBveDFDd0o2TzZi?=
 =?utf-8?B?M1YyOGxaQ1NiRWNhZXdDZ1NuMHFmUDI1OG1xYjNiZjAwN1JGaURSdFJMd29Q?=
 =?utf-8?B?eWRUa3hsUkN0amh6MWlHN0xKYVFtcjRTV0JZZ1YrVE9rMFllOHVEam5JS0p2?=
 =?utf-8?B?WW1kS1NtZ2RMOGt3UW5PSEVTSnJ0K2ZNTzg3VHpyWUVPSHNWNWNBS2VQRlFB?=
 =?utf-8?B?T3lvaWxvVkdNbndHTE13cHlOam1nSVZINElMa1VYdkdrdjdlRU5yMWlLYUps?=
 =?utf-8?B?Tms2MTA3cTZQc21WZWxBSTFKc1pRdXZjcVMyUFpmTVhBdHRaTGxtREErMXZM?=
 =?utf-8?B?aWtFZzJTNlUxZU9NMElrRTQ4RGJZREJBZnZFVGtHRlFqSjJBTUhuWkpwSzl3?=
 =?utf-8?B?TEhRU2ZaaWsyMzRqN0ZIT2RYUVZkSXBic2k1K05jem9Zd0FCWTNMSGlEYnRn?=
 =?utf-8?B?SUtaaHhBc0NsWW5yV2VIQ0dMS1FHdFBWNjZrWU1xOVpBVWYzbUl2ZWMxSjZm?=
 =?utf-8?B?NEtlcmpVZjR0cGZEbUVZbVZPeEx6cXNwMitBa2R6RzJGb2xWRTZXRmNnZlYx?=
 =?utf-8?B?Vm1TUGRwU2dweEVzeUVqS01jZ2dTOTdTZE1vKzRMbTVucXdFMlUyQ3laNU5C?=
 =?utf-8?B?MDVIYXgwSjcyNnNXd3h0bGk1U2QyMTlXZHNpSnZaazJid1VwWXo1TERaWG90?=
 =?utf-8?B?UVdSRk5zVzRpVisxcENLQ05MZlh3Q3RUZk5ka3hMSSszTEE3YjJwOURKY1Uz?=
 =?utf-8?B?WlBaKzRiVlRKSkNSeHV5RnNqMVJMSVpNRmRSbmFldC9rNWlUSHZIN0tGOHFp?=
 =?utf-8?B?Ri9IUmZHRXlsNHdLNitjMUlZRGJVUFIwT1FKUFA1ZUxUQW1hUkw4aTBnb1Ev?=
 =?utf-8?B?WG05cHlqNGFpMFk0VTN6SmtVTmUycElMNXUrS1N1ZCs3U2JaYWNlaUo0QUs0?=
 =?utf-8?B?am1xSS9mVXYvaElwaGNOY2REMUdSZ042R01rSjlsN1NyeEg2Qk0wU3Q2eEpR?=
 =?utf-8?B?cEwxR2tNK3hudlorWkdSRjJnT0lZSmJxbFhJME94c1YwRE5TWmpnUGM2UXNy?=
 =?utf-8?Q?q6CpOghLJK2Yf8uB8wFbyS7Yx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58230e0b-9b5e-413f-e6be-08da897317ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 04:01:04.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk+FVziPhTJRTkzoc6LkJvwy7edTzDb/ZtZ2Xyhj8Tm/W/Gs/5+ik9OGKRt+Q5eolPyUCn63YvvYkSZ34c2gtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
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

I also ran fuzzer on Intel machine over the weekend. I see only one WARN_ON()
hit. Otherwise system is running normal. FWIW, I was running fuzzer as normal
user with perf_event_paranoid=0.

  WARNING: CPU: 3 PID: 2840537 at arch/x86/events/core.c:1606 x86_pmu_stop+0xd0/0x100
  Modules linked in: ipmi_ssif intel_rapl_msr intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel wmi_bmof kvm rapl intel_cstate input_leds ee1004 joydev mei_me mei intel_pch_thermal ie31200_edac acpi_ipmi wmi ipmi_si mac_hid acpi_pad acpi_power_meter acpi_tad tcp_westwood sch_fq_codel dm_multipath scsi_dh_rdac bonding scsi_dh_emc tls scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0 multipath linear hid_generic uas usbhid cdc_ether hid usb_storage usbnet mii i915 ast drm_vram_helper drm_ttm_helper i2c_algo_bit drm_buddy drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core ttm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd i2c_i801 drm i40e cryptd
   i2c_smbus ahci xhci_pci libahci xhci_pci_renesas video pinctrl_cannonlake
  CPU: 3 PID: 2840537 Comm: perf_fuzzer Not tainted 6.0.0-rc2+ #3
  Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./E3C246D4I-NL, BIOS L2.09C 09/23/2020
  RIP: 0010:x86_pmu_stop+0xd0/0x100
  Code: c8 01 41 89 84 24 d8 01 00 00 eb 9f 4c 89 e7 e8 76 fe ff ff 5b 41 83 8c 24 d8 01 00 00 02 41 5c 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b eb d1 4c 89 f6 48 c7 c7 00 86 03 b1 e8 cd 18 76 00 e9 48 ff
  RSP: 0000:ffffbda8c818fbd0 EFLAGS: 00010002
  RAX: 0000000000000003 RBX: ffff97b71de19c60 RCX: 0000000000000188
  RDX: 0000000000000000 RSI: 00000000001382d0 RDI: 0000000000000188
  RBP: ffffbda8c818fbf0 R08: ffffffffb1039100 R09: 0000000000000005
  R10: ffff97b71de1a388 R11: 0000000000000004 R12: ffff97b069c19d40
  R13: 0000000000000004 R14: 0000000000000002 R15: ffff97b71de00000
  FS:  00007fbf787c6740(0000) GS:ffff97b71de00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000563033ec5010 CR3: 00000001ab91c002 CR4: 00000000003707e0
  DR0: 0000000000000000 DR1: 000000000000ffff DR2: 0000000081008000
  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
  Call Trace:
   <TASK>
   x86_pmu_del+0x8e/0x2d0
   ? debug_smp_processor_id+0x17/0x20
   event_sched_out+0x10b/0x2b0
   ? x86_pmu_del+0x5c/0x2d0
   merge_sched_in+0x39f/0x410
   visit_groups_merge.constprop.0.isra.0+0x207/0x670
   ctx_flexible_sched_in+0xb8/0xd0
   ctx_sched_in+0x10a/0x290
   ctx_resched+0x97/0x100
   __perf_event_enable+0x21b/0x310
   event_function+0xb3/0x120
   ? perf_duration_warn+0x30/0x30
   remote_function+0x52/0x70
   __flush_smp_call_function_queue+0xc4/0x510
   generic_smp_call_function_single_interrupt+0x1a/0xb0
   __sysvec_call_function_single+0x48/0x1f0
   sysvec_call_function_single+0x56/0xd0
   asm_sysvec_call_function_single+0x1b/0x20
  RIP: 0033:0x563033ec501b
  Code: 0f 1e fa 48 89 d1 31 c0 48 89 f2 89 fe bf 41 01 00 00 e9 48 f7 fe ff 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 31 c9 b9 1f a1 07 00 <ff> c9 75 fc 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3
  RSP: 002b:00007ffd7b16aaf8 EFLAGS: 00000202
  RAX: 0000000000002303 RBX: 0000000000000000 RCX: 000000000006c1b6
  RDX: 00007fbf787c6a00 RSI: 0000000000000000 RDI: 0000000000000001
  RBP: 00007ffd7b16ab10 R08: 0000000000000000 R09: 00007fbf787c6740
  R10: 00007fbf7880d0c8 R11: 0000000000000246 R12: 00007ffd7b16cf28
  R13: 0000563033eb527a R14: 0000563033ed1b68 R15: 00007fbf7880c040
   </TASK>
  irq event stamp: 0
  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
  hardirqs last disabled at (0): [<ffffffffaf0bfef8>] copy_process+0xa38/0x1f80
  softirqs last  enabled at (0): [<ffffffffaf0bfef8>] copy_process+0xa38/0x1f80
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  ---[ end trace 0000000000000000 ]---
