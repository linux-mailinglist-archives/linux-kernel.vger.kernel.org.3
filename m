Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5A52D03A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiESKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiESKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:14:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19927A5AB5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcT1B5tRRaZOoFa7ixzq8ivwPdF3NREkF69IEkbyMjrUO0k3hUql6J/GEtF9cxqKZ89hJMVarB+qKL6a//+U2MfNgLJE9l3mcMQPzMR96C7LalYeI8kTJd/mB8EWokDd09/q8kldMhrUCl38uUiBzg7p8KXRzQ/7/MZ5PQw1+WBmlmJfAxgMLrYa7SeoqoOmCByks895p+m3EDHALbv6MXyKr+DyIt/4Z6Mi69+Vg7mMBCgSDbZGyKHbMKvWu8WPZAWCh4Z2NMZOXo5aYHoKJOYQKVzk83i2TvRUaBio+mmCRZeC8yimwEHoL+Z22Lt4rC0ZjrvglVsDb8kfJVaN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaUc3Y2h4qrAHPWxhc7uqhhWVsFGBpPDr8Oj8SAjjcM=;
 b=NNmAY7UYMXdZu95Yb0IIXth/IYFX4BfIWQfpE4ZXpJdZLt2pUjvV7nWhuxYuEMyzfTj5CsFoLJ6ZeW3isaFpLDVwt8f9LWoJwxZ8flRgNP4pZCZp9jrWupw23F5BWKSPGpfT1YGGblP6eOnecCWdPUO4H1RrMT9AIWPlw+Nsd8dJ5EscwdmChnbZuuoa+Dkf2v+iPF+RBFRWIDmtb81CKXYp0/2ElUX0y+QeC0JO5Qf7pVI7kjyaCSerXVAWxEj+HcCVFi6Q7uT/WBrZEkvOQvTcH8laLIO8vaUVEDGb2r2IGidTgHx5KICJLPfktA1f+nCGqGCKZENhaldF9inF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaUc3Y2h4qrAHPWxhc7uqhhWVsFGBpPDr8Oj8SAjjcM=;
 b=ox6VOb/1OWfIQi9lfD6qBawu3enbZP0yDjXK2s57Jqetj9O4v2z0cOwrKA5UmT7sUuNCLOFokZG2avyD9xAVTelizA9UGfhgp17y8zw9cMzYtfXgNGQgkWLKqAuUDGFDAtYUCnl01VD/5oSTDh2AD1LxVwtqioXcbjZkO77kb/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 10:14:01 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f%6]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 10:14:01 +0000
Message-ID: <142c0f46-7408-e5ce-713c-34aa80f80960@amd.com>
Date:   Thu, 19 May 2022 15:43:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/3] x86: Prefer MWAIT over HLT on AMD processors
Content-Language: en-US
From:   Wyes Karny <wyes.karny@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
In-Reply-To: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1045b81b-efa4-4e05-625e-08da39804b9a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB167761D5D8FE9A25B514DE3384D09@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEou/cRN24tIcADNFDDzTQT6UO9ezw1YvyNFYkkUDMBBJhVY8WtRd2apRifFLA4u5CkEjtOgkO3Xkv9sJ4JXlQ8CQj2nClgxWSyHKo5OeWdsIQrPRXCv4pArmTYx5+8/jFMdKhd+95J4Fo3uinVNZYLMi7ZU6cvUptWoW22h8Z3aSWc7AqoCd99zrOUvi3V0TY8f+K4eq26yqJcG3N/BlSMy3EGzZjuEIqQUoZIb9fdCy7Fj5O8EQ8mbawnMxY7TW/a2h7yFm4V6HgZSiUWc/Wd0K97HyomCQxPXR8YddHnH1+zsK3bwZciFx7wUCcduMsn2MLqXFnEsdG42Ij8ww8M0E9h2mQWIgwPZBLUZGpZc8KNheVraU/+QW6I2wLbYE0cHk7f4ZJP3aM05JhzXHpbeD4DwFYkRzGCBHFReXkmODiulgHx9vbXtwe1/PoT/mKeKtv2MGAbx3HAReN9tt4lOXcBm0S87CJc2wxanQFeCd0A3thoG969dzL2ZmnLNMNbHt9AP74bPK7esdaw+rh4SZ/F+XEaaCiSkBTue1Xg8/n2WMXKnYv2CjNfaQlz9NlldvzyQRjw/CEapXn1blJVz8fDgyPjtFXtbApsvAOjrYirjiV7NGo3VLx3/xe4wT+mD332KQWGGgEBSkGnrPqRynB/7jmfsiGLuA28gPbjWpyqEtsvXiZ2F2Xx1vw65YUvUJWMSPZxPMZlY3q4UJA9nAF3Rn5dWSOO7kcFw6hVYgofLPrSTVGU258NKLUZnOEQ3MnHeGqd2HbtgWfygIOFK1/DZGvG0BmM8a+Kod4Jj8VI6qJc6YdF98izOxj03FRAyI3RrWMJwkgjFCFa0EtXUqxgAGONeii5lsg7oVhRFAjkUb15+ftjwk0WLYlRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(8936002)(31686004)(7416002)(186003)(6506007)(8676002)(316002)(53546011)(5660300002)(31696002)(44832011)(2616005)(36756003)(66476007)(38100700002)(66556008)(4326008)(966005)(508600001)(6486002)(2906002)(6512007)(66946007)(26005)(6666004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHR2djlLUG9INEdUcnB6aGNUTWhRN3VlZ2JtcUhGS3RTTnpDRlZYWVM5VFg1?=
 =?utf-8?B?dE50Q1J4VUhxM0VTdEFpT0VFbmxVNU9HZWdocTNCTlVQK3pZaENsOTJCZ1Rh?=
 =?utf-8?B?ZDEzV2ZsQWNJRFpkZkxrVjd0S09Lb3dqSVZ0ZC9KeHhVZ2hNZzVJcmVubzdu?=
 =?utf-8?B?c3JhK0FRMWZaY3M0WDBpaHhJbUZvYmNmN0kzRHlJZXpWeUN4d1Q4cjlJTE00?=
 =?utf-8?B?a2hscmZNVjFQMHovWFgzTlM2RE92Vml0Q2VPUlg0anpRZzBkN1RxMUcyOE1j?=
 =?utf-8?B?V1FSNklSNXdERlk4N01YNWtDRmdubmhhTUs2WTJBZ2lDUnZMMmFXRS9WTXZU?=
 =?utf-8?B?ME45YmZNaEJSSWl4T003YkZLUjczejNuU0l4R3pjMUs5bzJaNjRXMUtXRG9q?=
 =?utf-8?B?cnVOZ0w0V0xlV29jQk95eXFvaitYdWUwV1hqdTdFMzNTckhmZ3dick5lZ1Qx?=
 =?utf-8?B?Qks2THRnbEZOSERVcGZsbHh5S2p5RHR5ZTRSWEl4K3pyQnhxZFFtV3N4VzI2?=
 =?utf-8?B?SlViWmtPQlNaV0locExkNnhTamRTQjYvcGVLQmsxR0pzcXBUSUVuWklnbHlr?=
 =?utf-8?B?M2dxcE80OW9US0Y1L3lqd2M3NHJaTTJpRWViSWhWVm5JR1BJOU5GeFlwSUx2?=
 =?utf-8?B?M0srR3ZSV2RyREhXR25jdXZnMndwZkFCdzBlVG0razBhdkVvM3laR3prNDhy?=
 =?utf-8?B?U0dLYkxHQ2duNFg0TTFES3VWT0F6Y0xtS3Fyc2xLV1VEQUJ1eW1JN2g4Vjds?=
 =?utf-8?B?WWorbnZWb20rbUlBbXpXVEl4NjR4NENlMzVhTW1hL0hyQXg0SllQK3Mzck5E?=
 =?utf-8?B?Um0zSUJJY0NpSTBFOVNZNHdEVjd5N1MyRUUvQmFVRDVTYXlFT0tkck5yYVBv?=
 =?utf-8?B?d2J6cVVMVEdWSm9LNURPNFloanUyZVFkQklQR2lSVU56YjZHaVlhdU5HL2lG?=
 =?utf-8?B?dDN2TWJrS01Vc3dHcjAxVjQyY1pFUjlaSm0zZlhuVXc5dUxyR3oweUlBT1lw?=
 =?utf-8?B?dnZOTnplOGhWOU42S24xV3YwNXZNQnZnNXRXTUt2UmZYOG52S1UzVmhzZDNy?=
 =?utf-8?B?Q0s4U3pPeGs2aTRoSjFDWUwyNkdaRWlyT0lvWjhiWGQ0VnYva2FnT2gvVzVv?=
 =?utf-8?B?Tmk5aGZlclVOSUJBeENwUzNZbHJhWmdoQmdmNjBoMC9FY0hxdTVuNzZ2Tk9N?=
 =?utf-8?B?TXlldmlzN09CSE9RcFRXVkRKMUtFb3UvMzBJY3FoelFGRlJCRE5laUpINWV1?=
 =?utf-8?B?WVBKa3hsNzU1TXNVa3VLYUlMUkc2K0duQzNja0N3cUtwL08wVG9TTi9LSmIw?=
 =?utf-8?B?Yko2NGFHVXFmZ2czbC9QR3c2QUZTcmJDdUZydlZmMG9vQzU4VFBxOWphOHov?=
 =?utf-8?B?YWY2a2FWbGRYNk81N3Y0VTErMlRrKzROcXNkR3BLSlV6OEJzenhKcVRuY1dN?=
 =?utf-8?B?TEJKK1RmYmFDMkk1K2xVVW9VYUhiMDFoQmRJS0hPcFU4R1lxZUIwbVRCSEFu?=
 =?utf-8?B?ZWRtTXVHNXZHb3FpYVBjM1lTT1RyWFZvNmVJNHF5ZVhLdDgyUDBLeDczYUU3?=
 =?utf-8?B?MU9udlUya1Y0b28xM3hoK2JMNzBFbUFNWXhSVzlaRSs5NVhOMGhNaFlaaVJu?=
 =?utf-8?B?OXJTRGFRUmNrWVpTNVg1SHIzUk05M3JPcFRHeUhndDNvTno5YlE5ZGt0ZHlC?=
 =?utf-8?B?NHRvd2lFb29VRUYzd1YzSUR4VWpjWklIMG8rT1RkdXp6d0dDVWM4T0duZFdq?=
 =?utf-8?B?dWg2S1lrNkpJdUNSZ01IdzVBQzFzUzRtdUdTcTh5YllLbkZZTUxBdk80QXh0?=
 =?utf-8?B?NkxTVUtLWUV2ZGN6S1JkalYzdUN2eXo3V0pNYTc5Z3ZDdEYrMGZBZlFmZURj?=
 =?utf-8?B?QWFIYVJQaHRDeVg2RGRZNHFITnc4cUhzTFJYKzhrdzdvTjBRc3QzVlpVRVVz?=
 =?utf-8?B?K2NXcmI0N2xYQ09IbWd2aG9ta1pNdDYxbmN1L3ZSUXlNZE5Cc3dKNFFsaVBs?=
 =?utf-8?B?L3FxaWVEZnByclpxcHRUQUUrWWhrM3hwUXlUdUx3eDFUTWVJZGtZRnM3UExR?=
 =?utf-8?B?ejNScVJ4bTJ0NGN5ZnV3aFF1azNnSmdsY2pDZGFsZXlZcER4a3Y1UkV6UnBD?=
 =?utf-8?B?Z3lqREhTcURTeFIwTEUzQ3FCQ2cvNUV5Slh5TWkrczNXNXlHcm15MFJwSVRE?=
 =?utf-8?B?TWpmTm9Qek9HaGs5RG1ybS85UnkzZHdwMEFaYjdPOEhHaW1DQ3hTODNkREZP?=
 =?utf-8?B?Q3o3TjV6STB3eFUxUjVIczJlSkdmU2xPN21SY3d1U3EralNwaFBuZE9Ca2Fm?=
 =?utf-8?B?TTV3dlVEVS9VSENjWE12RkpMSFdSY2NrN2dONytLVkY5QkgxRDUwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1045b81b-efa4-4e05-625e-08da39804b9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:14:01.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 778+UL/bEwvduYiya9cKPG88vfaDjtMdT1wA86mmaRR9RxV1TyvH9q493Y2r4nkkDZEP4Rnpp9czXxLG36zFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

Is there any feedback for this patchset?


On 5/10/2022 3:48 PM, Wyes Karny wrote:
> This is a version 3 of the patchset to "Prefer MWAIT over HLT on AMD
> processors"
> 
> The previous versions are
> v2: https://lore.kernel.org/lkml/20220505104856.452311-1-wyes.karny@amd.com/
> v1: https://lore.kernel.org/lkml/20220405130021.557880-1-wyes.karny@amd.com/
> 
> The change between v2 --> v3 is
> - Update some text in commit messages
> - Update the documentation around idle=nomwait
> - Remove unnecessary CPUID level check from prefer_mwait_c1_over_halt function
> 
> Background
> ==========
> 
> Currently in the absence of the cpuidle driver (eg: when global C-States are
> disabled in the BIOS or when cpuidle is driver is not compiled in), the default
> idle state on AMD Zen processors uses the HLT instruction even though there is
> support for MWAIT instruction which is more efficient than HLT.
> 
> HPC customers who want to optimize for lower latency are known to disable
> Global C-States in the BIOS. Some vendors allow choosing a BIOS 'performance'
> profile which explicitly disables C-States. In this scenario, the cpuidle
> driver will not be loaded and the kernel will continue with the default idle
> state chosen at boot time. On AMD systems currently the default idle state is
> HLT which has a higher exit latency compared to MWAIT.
> 
> The reason for the choice of HLT over MWAIT on AMD systems is:
> 
> 1. Families prior to 10h didn't support MWAIT
> 2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
>    preferable to use HLT as the default state on these systems.
> 
> However, AMD Family 17h onwards supports MWAIT as well as MWAIT C1. And it is
> preferable to use MWAIT as the default idle state on these systems, as it has
> lower exit latencies.
> 
> The below table represents the exit latency for HLT and MWAIT on AMD Zen 3
> system. Exit latency is measured by issuing a wakeup (IPI) to other CPU and
> measuring how many clock cycles it took to wakeup.  Each iteration measures 10K
> wakeups by pinning source and destination.
> 
> HLT:
> 
> 25.0000th percentile  :      1900 ns
> 50.0000th percentile  :      2000 ns
> 75.0000th percentile  :      2300 ns
> 90.0000th percentile  :      2500 ns
> 95.0000th percentile  :      2600 ns
> 99.0000th percentile  :      2800 ns
> 99.5000th percentile  :      3000 ns
> 99.9000th percentile  :      3400 ns
> 99.9500th percentile  :      3600 ns
> 99.9900th percentile  :      5900 ns
>   Min latency         :      1700 ns
>   Max latency         :      5900 ns
> Total Samples      9999
> 
> MWAIT:
> 
> 25.0000th percentile  :      1400 ns
> 50.0000th percentile  :      1500 ns
> 75.0000th percentile  :      1700 ns
> 90.0000th percentile  :      1800 ns
> 95.0000th percentile  :      1900 ns
> 99.0000th percentile  :      2300 ns
> 99.5000th percentile  :      2500 ns
> 99.9000th percentile  :      3200 ns
> 99.9500th percentile  :      3500 ns
> 99.9900th percentile  :      4600 ns
>   Min latency         :      1200 ns
>   Max latency         :      4600 ns
> Total Samples      9997
> 
> Improvement (99th percentile): 21.74%
> 
> Below is another result for context_switch2 micro-benchmark, which brings out
> the impact of improved wakeup latency through increased context-switches per
> second.
> 
> Link: https://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> with HLT:
> -------------------------------
> 50.0000th percentile  :  190184
> 75.0000th percentile  :  191032
> 90.0000th percentile  :  192314
> 95.0000th percentile  :  192520
> 99.0000th percentile  :  192844
> MIN  :  190148
> MAX  :  192852
> 
> with MWAIT:
> -------------------------------
> 50.0000th percentile  :  277444
> 75.0000th percentile  :  278268
> 90.0000th percentile  :  278888
> 95.0000th percentile  :  279164
> 99.0000th percentile  :  280504
> MIN  :  273278
> MAX  :  281410
> 
> Improvement(99th percentile): ~ 45.46%
> 
> A similar trend is observed on older Zen processors also.
> 
> Here we enable MWAIT instruction as the default idle call for AMD Zen
> processors which support MWAIT. We retain the existing behaviour for older
> processors which depend on HLT.
> 
> This patchset restores the decision tree that was present in the kernel earlier
> due to Thomas Gleixner's patch: commit 09fd4b4ef5bc ("x86: use cpuid to check
> MWAIT support for C1")
> 
> NOTE: This change only impacts the default idle behaviour in the absence of
> cpuidle driver. If the cpuidle driver is present, it controls the processor
> idle behaviour.
> 
> Fixes: commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot hangs, to improve power savings and to improve performance")
> 
> Changelog:
> v3:
> - Update documentation around idle=nomwait
> - Remove unnecessary CPUID check from prefer_mwait_c1_over_halt function
> v2:
> - Remove vendor checks, fix idle=nomwait condition, fix documentation
> 
> Wyes Karny (3):
>   x86: Use HLT in default_idle when idle=nomwait cmdline arg is passed
>   x86: Remove vendor checks from prefer_mwait_c1_over_halt
>   x86: Fix comment for X86_FEATURE_ZEN
> 
>  Documentation/admin-guide/pm/cpuidle.rst | 15 ++++++----
>  arch/x86/include/asm/cpufeatures.h       |  2 +-
>  arch/x86/include/asm/mwait.h             |  1 +-
>  arch/x86/kernel/process.c                | 39 ++++++++++++++++++-------
>  4 files changed, 40 insertions(+), 17 deletions(-)
> 
> base-commit: d70522fc541224b8351ac26f4765f2c6268f8d72

Thanks,
Wyes
