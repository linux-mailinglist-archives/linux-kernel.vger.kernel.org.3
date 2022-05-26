Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EC53513A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347862AbiEZPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:09:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458771DA66;
        Thu, 26 May 2022 08:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOoaoCMc49Wlw+EpHZfk0/hcrx8rNcYovIM7OW7pmhEK6E1GM5khBYVr7KJ9lxU8FJ6ZkoRNfekHZpxDuINzfVApA9zRgPKSB/MffgN9yRj1bYvJiIHdjXZ3C86ioKfTump8WwVBvmq96FlSV0YmWawc8WSWJZ7S9TjvBFGzbJaaojFZ4+Rtv7F9Fdn9J0kJP+4EFgQDX/eGhGWg8oLvSjc/jIgR1jZ4TT3pNwzbjoqw1pI6usBgvCSGIe3kH/WLNMrkeBOQ+P5BX2+W+JUmAwuNWvbr3NHDTMZVF7KqF3B56QEXp2IgE2zSW+Ss16xnJoq3CpxxZse95jQQWMhSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAv7r5HrNCPMiIOB0KUQ+3UU6QDBNkTQvvtIA1gFOuY=;
 b=mZC7zL2l+BSUujqcNaxhxxPW9aWhD59olQJSnMH4RNzSWb8C4kiB1zel621Oj+ZlbzHVRb7I9P82GHC6M8HNsNYv/3b8jbgHfGF+sGv6hhMsr77zReobrZ+wd22sEKF+28QMpefyVkQTuREgHrVC5gAnV76s3Y1FVSc9oWLaXiEOL4o0cMIUwgTeNe1DV8SV9b54qlcbyn/NRJ7qD+qIY6pHOTHxEygpxOSbmyY42GyfPCBDVpbMIVYyJH49l+k8VFYFr67ce7yYu/ZuLA+63wOAQznlXOucbCRBjHE1XZ2i1eJTgk9D5krqntRiqhbP0dWgvgBWThu9At9HNFQFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAv7r5HrNCPMiIOB0KUQ+3UU6QDBNkTQvvtIA1gFOuY=;
 b=fGTSP6HwUETzjfQgbpfXKtRSSl0DBObfzUNZ31H7E9g4YEKeE8au2h6DB3SQ5PCoIsYBBMDQHrZuGimi+HLQTwsmYs2Gzit3/cCl97hyCtXyu7LeEHYqJkSt6ioroUBWd9MA9gFy6uxLFzoPg6/FlxfnsHNuzVw+1UyNQSOp7AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 15:08:58 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::1127:b300:ae99:655d]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::1127:b300:ae99:655d%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 15:08:58 +0000
Message-ID: <365af18b-552e-bdcc-20ee-c6ce6e172500@amd.com>
Date:   Thu, 26 May 2022 10:08:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/13] perf/x86/amd: Add IBS OP_DATA2/3 register bit
 definitions
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-3-ravi.bangoria@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20220525093938.4101-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 684f3f33-04e0-4f9c-be96-08da3f29a8a2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44638AFDEB23EEDDF149722787D99@SA0PR12MB4463.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx74luhwxm3TMW3R3m4gKhusjToIP3IeVXju2iBFoxgDlgKZK4TVuyhdarg3/w9QH1E0YKf/gwkdpsTFGLbpu5NIUB8Af29TfM9qHR+0U2wm2MTsO2ZTgjIzA3StYOr3LLSy39UfR7hnJAkCXUgIkadjAeS7rWOvFbudtAug9AxOeKOM5vfU6eheoLpNku7YwQdSMt/YzpespeIFcvEl+VKU6HmZ9mPI1q1TyriB0h0mvsQ5kIWMDJHfZEusIbwLdyUW7Ero6IsgXfNPKqeXSKcQAOnPO4wdtOud13fbF3USZixpuxVGRCUH8Wzqu5Pzy2utLwR1v+C6HcjpBQRzNWJK+cd/Y4ZnDegaYHJapny4pmArd7GmxQhK068rL35tF8UTjCqZyz+moNLIaTkinto1k4GFutm238+Y4tcwVjEQ0Ig/nb19dclUoy2aSy2PQsBIp0QmqUDTwv8JLcwPvAVADhmvRZwE6pVW4w1MBX3zUP8rQr1iettLfTMUsghJc81aeARUARYbWxKG1Uc42GfaeLdFBL/RQUEGxhbfEPgPRqQ3xrMsFgkKA30g3N8+MJtpSO4YZA3eoiC6GlcsBSg58FZlpQT9M4jzp9scOWAH43s17shz+mTl7jKiiiM08oSIvCChpt0ZwT1eVvnI5g634xLwuk9ZrNNZ5eUMa96wSU3D8r4AzUGw1CZ6UiVcgJziklk37C8BqgDpbU1oaGtmPpmMJil+lb0bpKij5yA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(31686004)(5660300002)(2616005)(86362001)(26005)(6512007)(83380400001)(6666004)(186003)(36756003)(2906002)(316002)(4326008)(66946007)(44832011)(66556008)(66476007)(8676002)(31696002)(6506007)(7416002)(6486002)(53546011)(8936002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2ZKOUk1T1ZnQ256Q3JTN2VsWkpaeFpWWGF1Rk1RTkZkNkFaUS95Q3VxaUVI?=
 =?utf-8?B?SVFkL2pDRENZaVAvTTIxQkg2Mk1BR21ZZjdwbDlXOTZ4TUlOOEJLN3MzQnBG?=
 =?utf-8?B?ajUwOXZnTGFhNHJ5OEVkVHRHMDRYTjNUWHZXYnhGaVdUTDNwaTA2SVlFNGRB?=
 =?utf-8?B?S2lCMmVvMUdMQ2JvS2dVVCswdzdZd05zZDlKVzY1WE9jeW1OSExXSS9Td2Vs?=
 =?utf-8?B?RStsQ2s3QlpDZXUrK0ZkNGpMem44VzVlZXZDdy9kRE15a3I5R2xVUmxmYVhG?=
 =?utf-8?B?M0xCRGNYVUxKbmJ6a0lTdjdGVTNubk1XVVJDQ0NZU1JBTmZCSzVZVm9pL2FQ?=
 =?utf-8?B?TW9vSWJFaWFQUXA0S1Q2UWZQN2cxdWNiYXVyc3Rrc3BWelVCaHR2SFBXc0dO?=
 =?utf-8?B?UWZmbXdlU3Y2VEg5M29tdXZaR2NGbVUxZVluUTJBcGhHMzZFOU56NHQ3Q3JM?=
 =?utf-8?B?eG00MnRVZWdITXhwTU5XUG8xQW9GNElBOUZiOHF2aFBMWlNYSEN3LzhOSkVw?=
 =?utf-8?B?WkRCRGJyYnl4a3BCblNFeWFxNllpdEFTTktKd2N1R3VrRTY2ZW5QWVN2REtQ?=
 =?utf-8?B?b09qdytEWGg5Wkk0bE8xaGZDZko0TGhEU1JpdjQyTVNtaGwwVzBkZkxKd0Vp?=
 =?utf-8?B?Vi9TMUVWUWZXaDZoRm1CQW0zcHJ4MllMOGovOUZNV1V6WVRxdGRlVldEMGFX?=
 =?utf-8?B?ajVGS1Flam5RSTJab3h4eW1TZHBsc0s5aUhSK1hiU3JlbVBpdWlvMExFN3pF?=
 =?utf-8?B?WTlkUUtWRW1kVVdoVUs1OVlKSzl3d1VOSFlIMk1IRWZwWmp6ZXBvRGw4K2cv?=
 =?utf-8?B?Z3NQZC8yYXp4ampicWJLMU8xT1Fzd1dqQ1VqTGtNaWp1TUpOTnBTYTA1MTMz?=
 =?utf-8?B?eWxPYXNET2JXbXNuYmwrN0h6T2tiSHhOT1hFYWFFSWJCcmQ4SnovMENya3VV?=
 =?utf-8?B?MS83bW1uRFI4cU5ZbjRUc0tXVWt1QlFCK2tYb0UzNFUrbVhwVWoyZ1hncnpL?=
 =?utf-8?B?YzVHeFRocWVhdGVZeDl6RGt0TTdHV3QxT08yZmFTWlp0aWw4V0tCVEp3MVFl?=
 =?utf-8?B?ckJyeTM5T0xQaUwwQ254aktaOC9qdVp5Vkd1ZmxrNStoZTFqZDFLa2wrZWh5?=
 =?utf-8?B?WFNEeHI0QzNKakhSR2F1SGh6S2sveHVYR04xM0VKSUl4YjZXOVhJZCtJMStk?=
 =?utf-8?B?Mk5jeS9Kd1lYOVdHZ2t3NHIvZ0l5Z29rYlJwd1lrZUlOaEpPOU5uRjIxeGFG?=
 =?utf-8?B?OTBMZ3NqbXZxOUswdS9kbXpCLzBLVmZmV0dDZjNIZE9yWTArVk05OWNTcWRu?=
 =?utf-8?B?RWN0QTUvcTZLK3BPL09KTWxQWUZyUnZTSnhxR3l1bTRLRjJtRnpKdXJhRzJ2?=
 =?utf-8?B?VXp2QmtCanpjbjZRc1ZwUEFFNG12ZTFicSs3b2VhOWVTcDU4TGQrbnBxcExP?=
 =?utf-8?B?eUtlK3V5OWZBc2tNcXVnSmlLWGtBVXd5aEJwcjZ6MFJsNDNqZFpJcFp5U0sw?=
 =?utf-8?B?NlJOSndsMmlzK2NsemxPRGhWbUtqaWc2RHNIQytITmx4LzJtRVFBbnBmVlhF?=
 =?utf-8?B?bnU5RklEaEJaWHVwRENPYkJPNTBUTHg3eE5ZY1VINWdoQnpWNG5DVTFHQmow?=
 =?utf-8?B?RzBEV0oxbE1BazFqeXlTd2N4KzF2ajU4aTM5eVJVZHUrUmZzRkxVcEx0V0kv?=
 =?utf-8?B?TTkwcGxLck42aVordnZVeVlSNEpmbTBtcmFCYkhwMFFjNEsreWlaVEhhT3dt?=
 =?utf-8?B?REJkOXdZMVlLL3FlTk1sL2M3cXZKVVZ6bXRSL0w1OWszRTFna1ltL0Z1QUpq?=
 =?utf-8?B?QnFRTkFTQW04dnFDNm42d0RyakxZMmNVVEJQT09KVzNRby8yKzd1R3hYUXQw?=
 =?utf-8?B?dmkrdGJtSkdkQlhacWZHc0JnMmRTUU5kVWxiS3JpUmtaaU9XUmlqcXVtVWRG?=
 =?utf-8?B?Rnl6NzBmbW9xUWxHM3g4bjRkbnY4MzYxVmFmRCtRV2hYQXphWlZpNWMxV1BV?=
 =?utf-8?B?WHl0L0RNTE03aEhuZEtOWEJMTWg0bkpPM1dLRkRsSGtxZXB2S0xOSUZlQkcv?=
 =?utf-8?B?c3lGcTF5azZhblJWVDNabHFUaWNwdnY4RHFrK09FQ0piaUkzWkVNQTNENkNm?=
 =?utf-8?B?b2VGanlMMXNOUUlRSmtJZjF1WS9pZFF4eS9rVXFvTUNQd2k4UjdFTSt2NlZn?=
 =?utf-8?B?azU3Yzd6S2xnYldxai9UTjRQcVNwOWtqWnBrUlcwUFdPS01LSXZOcmpBTm5z?=
 =?utf-8?B?SWtjL1hlQU5JY00vOWVBRjVxTzk0YmpjS0xyTkVuOTdZSFZ2aHdvdXk4dDhu?=
 =?utf-8?B?OXFBb0p0ZGMvYUY3RHd0c0M5UXFwekYraXl1SnE3Uk54L2FYeGxKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684f3f33-04e0-4f9c-be96-08da3f29a8a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 15:08:58.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9NSTliPb8smGPOE+AUO6YUWtIv6zwLCB1x/FlG4O78vjmbCU+BwqBY5hniIKiIkkhQHzy/ogX3mCpSIn398jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 4:39 AM, Ravi Bangoria wrote:

Hi Ravi,

> AMD IBS OP_DATA2 and OP_DATA3 provides detail about tagged load/store
> ops. Add definitions for these registers into header file. In addition
> to those, IBS_OP_DATA2 DataSrc provides detail about location of the
> data being accessed from by load ops. Define macros for legacy and
> extended DataSrc values.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>   arch/x86/include/asm/amd-ibs.h | 76 ++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> index aabdbb5ab920..22184fe20cf0 100644
> --- a/arch/x86/include/asm/amd-ibs.h
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -6,6 +6,82 @@
>   
>   #include <asm/msr-index.h>
>   
> +/* IBS_OP_DATA2 Bits */
> +#define IBS_DATA_SRC_HI_SHIFT			6
> +#define IBS_DATA_SRC_HI_MASK			(0x3ULL << IBS_DATA_SRC_HI_SHIFT)

Is there a reason we're not using the existing bitfield
definitions?  E.g., data_src_hi for the case above.

Thanks,

Kim
