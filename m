Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEC49675B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiAUVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:34:55 -0500
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:2656
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229782AbiAUVey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:34:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtFunr9P7jcg+x1lYlPpXQw0uNHg86RtdJHsNir30N2Mk0/8wvEUh4rpnOuNDl3oJckXfjUxYUcIhPqP9oSdCIbVnSRbbU/6dV+aM2rRwsmKOhKem1XUSCnx1VeiTtWnxX3Zp47QNJ19YENPLmxSIsbcGU+ILHL2nWkYY4ohOFt32GklMDQXH9/WSM+Vo9k/GidAvUKJgMXU5tWzSPEcKInI/kUcRpy+4ofIbMQgc0FYYu0djrL1jje461/H4cWe91+f4DsIwIp7xkxeaW0bVBG1e4EJfDfc1MtGAnqa5pZK4H39wVGFnM5rwYMYX+Q8QWiOMjAhYdYWKWsLCkaS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lujwMvU00A5+AXxlTaEEmBMT+k/SowVi+5+Yw6GbTwA=;
 b=JeRXfqQEp5P+1qjmmCcTvfftrZE0vfdBEER1RIIPdeHBNiJTwAoxPmEXv4DDER4gkq+w3Z6+9L524+ouwhZa0xPOhscoUgq9chOHzt/uEmZKdJ0PzS71WYzdq92465Qu8SIJHGLP0ThZiho49Qpo6EIUDr5Gn38dLSWrQiXTgn4wveN4j2zrQNdbAjUwN8cVlO6EjhywF4CEIyeewUqLfPXmduGjZeN0CEUHTHawP3X1tMtYNfn5ko7ehQ7prl5Ns7PsewiFvdm/o/nel+16xYVnHi30g0DfleE9/MGl3NmcS40wvqMFeoNurV9be6Vf4jTHhjmFQrJzMise3Zl97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lujwMvU00A5+AXxlTaEEmBMT+k/SowVi+5+Yw6GbTwA=;
 b=A3l1q1h4ujkiMIkLfOVGjFivit92IjsYPvHa5u5WIJvjlgt67TmEwAHqjRPisOygAu9MEta8lXk3PonHaRcE8A8KIaE8I9gHsVqXximEGRMzAtjys/Q5wmOy8vl3GDO5WLFJxzHiVd0FTgfH+AJlT0cmtJ+Q1G3CwwjfRHrqa3dl3OsqLaaPPqTbYx7goF4LIYMgVUKFauVpoWUjKCtnrAu0vXI/RFayHm13yCKaFSJYCwbdYhFCqLO5oFmB77eYzET98TBb0FqSfJV7X+WT7hQhAw0f2pp4LuCfKUfnufdO/C/8bsKPFq6yR8bT3LKFlXsDAJgcXsfIr1z/MgXAMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5195.eurprd03.prod.outlook.com (2603:10a6:101:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 21:34:51 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%5]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 21:34:51 +0000
Subject: Re: [PATCH v12 2/2] pwm: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     michal.simek@xilinx.com, Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211217233015.67664-1-sean.anderson@seco.com>
 <20211217233015.67664-2-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <f9adf970-aea8-1fed-d02d-c7d47491e993@seco.com>
Date:   Fri, 21 Jan 2022 16:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211217233015.67664-2-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0093.namprd02.prod.outlook.com
 (2603:10b6:208:51::34) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535ef8b4-44fa-4553-2d41-08d9dd25db46
X-MS-TrafficTypeDiagnostic: PR2PR03MB5195:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB519590E72F6D9283F65DB17F965B9@PR2PR03MB5195.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMWAQMVMpINfobKRjcFcQyl9cseDSE/bKgnZaEG+ASX+2zTIlshDM9Pbr5KwFyTu8NdAVd+vQy5zw7x3BlCZmmEcGDeDWrtNrH1o3thXeQzmunKE2v4qsHmYkOnkQoRuAVpvt4pBtvXg1a4dQd+zVVDSj3s9ZfV+yFgt1J1eFlS08nqzDrze6n/OIX/Zx3IJGNyejV2+AMAWBV8xVmKq76hq1+pychcIdBYzZ5JonUisO4x/5252fc23rc68+CpMPIYQGBZ2/NuTceR7az7GoVlZSs3pU8aKRz3LfGKM5HdqlSozCvF0s613H4YyTMFQW1yxNG5gFVWB/9yN+Wyv80b6R/YGFxMcmUE4chW9mzgWxAWHIbDjl5H3txc8t3PCNvUXVKpx3rue2XlEOsydENERDRmr0geOT9noxXVZxw8LoCSbZVDJ4IEkHmaUGUkl9D9AqPErXU5JkO7Dm7KYMuiHIIeAvt+gAUwom1yZk2FYd8wVJ7hezfq18b6N+JnHZ4t6l7aNmNm/Pc9pqLdzN1r/0z303Q2wtLsZnH+goifLSbBBYg91myuKdfzqkt2XT22ImocQxw0D81sbet48owjJMejPNP+AKVXiH+8oW619rVw50wLVj5CJeLLBggKU//KOg/u1Dk0iizmAOjH2j9IKWAB6LigKjuBH7TQtWjtgQ5i+q7AyPzGYi6bZCM70vhueHQln8t4xwI0z9mVYn7Kab9jPxHERGDwnQxrKeFHuCMZPIDJpyokjIIbBGof2goqXSD7ZL5TO3t2oksa0xTD7fNhTccyBvZXQ1CxnVoSmbgyLe0PJIdsq/jsMqTvBIZCxHzpb7nWEN3lGDfvyPlQYzthHfY8ta/wt0Ig0S6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8936002)(26005)(2616005)(6512007)(8676002)(86362001)(186003)(31686004)(54906003)(2906002)(83380400001)(31696002)(316002)(6486002)(38350700002)(38100700002)(4326008)(30864003)(6916009)(7416002)(66556008)(66476007)(36756003)(66946007)(6666004)(966005)(52116002)(508600001)(5660300002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FBbzJtV0JXS3E3UDZnVHIvN3RVYWhMMEgwMERXTUJLUGpjRDU4Q1FDaWZY?=
 =?utf-8?B?SDBaYVBjRkRCQ2hFYjNaZXdYNGtYQW9pUWdZWStBWUdJcW40RG5XY25zYm9m?=
 =?utf-8?B?RS9hajVndzloVkt4MW1zWit0YmE3cVI4NlFSQkh1WTlZWjMveFRicVdjTE1j?=
 =?utf-8?B?S2ZadmlUcVZjdmpIclFYei9PdVIrdGVrRjNQZTVnbUx5OXdoQ2libjdzWlRk?=
 =?utf-8?B?UFBtYS91VDRsa3N4Ri9ZSTE1ZmNDNlBSMXR1SEN2eUpmWENYR0hPZjhsU0RX?=
 =?utf-8?B?d3hwcDVsa0FhRFBxZnpmWHdSa0JHWDdjQ090SUx3OThZWlNZcEp1a2JTdlgw?=
 =?utf-8?B?ZXV1cGdpcmFCcEJOVVNyL0pJb1VGcHZ5bnJ1blJYUTNsYXNnSXllZDR6emVI?=
 =?utf-8?B?U2x2SDB6cXAwVWxON3JYaXJMakh6eG1nMmZ1WWpuUG0vejdXNTNMZFBjcE4y?=
 =?utf-8?B?VTdobXpCdUFRa1JqWjZ2bVdaUkhyRU1OUkZzeEF5b0VDRi9sT0xndWpwUXZU?=
 =?utf-8?B?WEJNVFREVTAyQ3EvdFVKVEpFZGFGRUdnVGk0M2pPZitsWWQ2dGZPUjNwc0Iw?=
 =?utf-8?B?QVBETXF3cUpmWW5ZM1J1aUY0aVlGTHExWWFja1drbWQ4eWNPMTBzazYxMWI2?=
 =?utf-8?B?cUhDMzJXK1NQcm5VK0pTNGtpVktsbnpVM3MyNzZiSUpRVE5aWitFeDcwbzFQ?=
 =?utf-8?B?Y2tGUStHdG9XbXpRckU4WkxqcHpmSnlOQk1VSTloU25QOENPZHB2S01qNC9P?=
 =?utf-8?B?OWVIRmxHRkFhNmMvd21uSXBFQ3VsTWlJUjNxQ2xDdEtnNUdReVJwSmdDODdi?=
 =?utf-8?B?eWhGS290a0VvTWJReWcrdWdyRm1NVHlmNENEZGNLeTZKQWEvRHhPR215MzY3?=
 =?utf-8?B?bGNXb3VhMHNZZUlEL21UNU5hOERpNEtRVEIxekg2TjRnc1ZCeXZMajlnckdk?=
 =?utf-8?B?ODBCd1BkVEErQ21wTHIzbkJHenh4VEVWRXRPL1Z5NHJMN29YNE1sYlFvOGRD?=
 =?utf-8?B?NWE2VXU1QUQ0QkM5ZG1DWkNsLzhiV2UxaW5HMXN1WFBSN3ZIR0F4dkFEaEZY?=
 =?utf-8?B?Vmh0SUJMT21jNjR6U1BqbjNnS1pkcHJUTW1ESHQ0aHczaXdlTWZ3RnZrVGIx?=
 =?utf-8?B?eW5RRVdCSkZoUGdOaHJ1VFByT2NSTmFRS1RUa1hlTHVVR0hGT0lnVjVzK2hl?=
 =?utf-8?B?cWlKbHJablN1QlFSUFM4a1FOVW92YWNCeXZZYWd5WGtMRXFEczBuQ2hDaDlY?=
 =?utf-8?B?YlNWSG55Y1ZBSXVSckNvRVMwTkdRYlVjOVg0cE85d1ltdTFjZkp6Vk5scVNX?=
 =?utf-8?B?Qzd5b0tiT0RiMDI3ZURtNDZEbG1mK0ovSUFmS1FuOXNNMGlmdHhNTnBHMHNr?=
 =?utf-8?B?QmUrZnBkdEU4OURJY0xxc1NZQThnV2J6K0x1NWJjVVlTVWxrelMxV0g1Smpz?=
 =?utf-8?B?cjEva0xSK3FwbXZJSnhuRkFTM21aaXNVY3NhNWM2TGhXWDdzTlh4Z1gvRmNC?=
 =?utf-8?B?OWx1cnNPSEpXM2pmUFJ1YmlKVkdDUlIwOVZNenhZemw3N2dETVh0VGhIVzZ0?=
 =?utf-8?B?NXpzb0pLNXpjbHZwVGZiNmFrd2k2QlRwQ2xqVGVWUkVBNFEzWlZERlVQMmxT?=
 =?utf-8?B?KzhNV25EWk80Z0J3Yi9kbS9UMUtwRVBnaURnL2ZyVkVQQjRoZXpiTXdhL1I2?=
 =?utf-8?B?eUN5Z3AyWUsraUxVY2lhYStjby9IUkQyWjMzT2ZLak00NHRsMzhyMVhCZDE4?=
 =?utf-8?B?T2lHbUpDYTBRNmRma25OQVFtd1gzK3dSUUtTQ0lpVytDTWF0MldBSEQza1Fn?=
 =?utf-8?B?MDdBWHRTKzJJR2xqSFFFeHBLVDZHc1prcU5kNEZya0UxcTVxajcraHZCOXVu?=
 =?utf-8?B?b3ByTGs5OEQ0OW10S3ROL0IwbHhiTjR1MDk3OGJWcjNNNjR6RFM1N1h3UENG?=
 =?utf-8?B?N0FsZzVHUG0xUjN3TFlCYXo3VlgwMUVEV1luVzcvcy9kL3Ywb3QvT2F0enJK?=
 =?utf-8?B?RzFUOW1PMlorUHVBeXliQmI2L3FqU1hPcjVLeTNINDBzQXJVQXNoSE5TbjRN?=
 =?utf-8?B?aWRpWGw5alBacmNaWlFBZ1VlUGlPL2VWYXNUVjdkRVVRTHpUV1Z3NGVCc3k0?=
 =?utf-8?B?ckR1RTJBQlFiR3hBcnloMGdyS09XdmpiWjdJQW5jODlnaWNrRXBGeWNmQ3g3?=
 =?utf-8?Q?lHCD78bjk9YysT6D7AkdzGc=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535ef8b4-44fa-4553-2d41-08d9dd25db46
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 21:34:51.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxd9M3F16bfEO2kFOpNfUG6WYdfyk74tgKmwWieSw5LvoUUIGYIHk7Dl0U4/7EmZw/Hzd6/OnjdTw2BSLzZVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 6:30 PM, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
> 
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
> 
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> 
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v12:
> - Add a comment to the timer driver about #pwm-cells
> - Combine/expand comments on rounding in xilinx_pwm_apply
> 
> Changes in v11:
> - Add comment about why we test for #pwm-cells
> - Clarify comment on generate out signal
> - Rename pwm variables to xilinx_pwm
> - Round like Uwe wants...
> - s/xilinx_timer/xilinx_pwm/ for non-common functions
> 
> Changes in v10:
> - Fix compilation error in timer driver
> 
> Changes in v9:
> - Refactor "if { return } else if { }" to "if { return } if { }"
> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
> 
> Changes in v8:
> - Drop new timer driver; it has been deferred for future series
> 
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
> 
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>    debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
> 
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=TLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
> 
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>    some don't.
> - Put common timer properties into their own struct to better reuse
>    code.
> - Remove references to properties which are not good enough for Linux.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>    initialized before we have proper devices. This does bloat the code a bit
>    since we can no longer rely on helpers such as dev_err_probe. We also
>    cannot rely on device resources being free'd on failure, so we must free
>    them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>    to deal with endianness issues, as originally seen in the microblaze
>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
> 
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> 
>   MAINTAINERS                        |   6 +
>   arch/microblaze/kernel/timer.c     |   4 +
>   drivers/pwm/Kconfig                |  14 ++
>   drivers/pwm/Makefile               |   1 +
>   drivers/pwm/pwm-xilinx.c           | 319 +++++++++++++++++++++++++++++
>   include/clocksource/timer-xilinx.h |  91 ++++++++
>   6 files changed, 435 insertions(+)
>   create mode 100644 drivers/pwm/pwm-xilinx.c
>   create mode 100644 include/clocksource/timer-xilinx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..373757fcc8c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20925,6 +20925,12 @@ F:	drivers/misc/Makefile
>   F:	drivers/misc/xilinx_sdfec.c
>   F:	include/uapi/misc/xilinx_sdfec.h
>   
> +XILINX PWM DRIVER
> +M:	Sean Anderson <sean.anderson@seco.com>
> +S:	Maintained
> +F:	drivers/pwm/pwm-xilinx.c
> +F:	include/clocksource/timer-xilinx.h
> +
>   XILINX UARTLITE SERIAL DRIVER
>   M:	Peter Korsgaard <jacmet@sunsite.dk>
>   L:	linux-serial@vger.kernel.org
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
> index f8832cf49384..26c385582c3b 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -251,6 +251,10 @@ static int __init xilinx_timer_init(struct device_node *timer)
>   	u32 timer_num = 1;
>   	int ret;
>   
> +	/* If this property is present, the device is a PWM and not a timer */
> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return 0;
> +
>   	if (initialized)
>   		return -EINVAL;
>   
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..cefbf00b4c7e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -640,4 +640,18 @@ config PWM_VT8500
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-vt8500.
>   
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on OF_ADDRESS
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
> +	help
> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
> +	  typically a soft core which may be present in Xilinx FPGAs.
> +	  This device may also be present in Microblaze soft processors.
> +	  If you don't have this IP in your design, choose N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-xilinx.
> +
>   endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>   obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>   obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>   obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..b4d93e8812c6
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cycle
> + *   with the old duty cycle and the new period. This is because the counters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic reload
> + *   happens after we set TLR0 but before we set TLR1 then we will have a
> + *   bad cycle. This could probably be fixed by reading TCR0 just before
> + *   reprogramming, but I think it would add complexity for little gain.
> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
> + *   possible by stopping the counters at an appropriate point in the cycle,
> + *   but this is not (yet) implemented.
> + * - Only produces "normal" output.
> + * - Always produces low output if disabled.
> + */
> +
> +#include <clocksource/timer-xilinx.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The following functions are "common" to drivers for this device, and may be
> + * exported at a future date.
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles)
> +{
> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
> +
> +	if (tcsr & TCSR_UDT)
> +		return cycles - 2;
> +	return priv->max - cycles + 2;
> +}
> +
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles = tlr + 2;
> +	else
> +		cycles = (u64)priv->max - tlr + 2;
> +
> +	/* cycles has a max of 2^32 + 2 */
> +	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
> +				  clk_get_rate(priv->clk));
> +}
> +
> +/*
> + * The idea here is to capture whether the PWM is actually running (e.g.
> + * because we or the bootloader set it up) and we need to be careful to ensure
> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
> + * need to
> + *
> + * - Set both timers to generate mode (MDT=1)
> + * - Set both timers to PWM mode (PWMA=1)
> + * - Enable the generate out signals (GENT=1)
> + *
> + * In addition,
> + *
> + * - The timer must be running (ENT=1)
> + * - The timer must auto-reload TLR into TCR (ARHT=1)
> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
> + * - Cascade mode must be disabled (CASC=0)
> + *
> + * If any of these differ from usual, then the PWM is either disabled, or is
> + * running in a mode that this driver does not support.
> + */
> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
> +
> +struct xilinx_pwm_device {
> +	struct pwm_chip chip;
> +	struct xilinx_timer_priv priv;
> +};
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
> +{
> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
> +}
> +
> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
> +			    const struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the cycles, but we may
> +	 * not increase them. Caveat emptor: while this does result in more
> +	 * predictable rounding, it may also result in a completely different
> +	 * duty cycle (% high time) than what was requested.
> +	 */
> +	rate = clk_get_rate(priv->clk);
> +	/* Avoid overflow */
> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	period_cycles = min_t(u64, period_cycles, priv->max + 2);
> +	if (period_cycles < 2)
> +		return -ERANGE;
> +
> +	/* Same thing for duty cycles */
> +	duty_cycles = min_t(u64, state->duty_cycle, ULONG_MAX * NSEC_PER_SEC);
> +	duty_cycles = mul_u64_u32_div(duty_cycles, rate, NSEC_PER_SEC);
> +	duty_cycles = min_t(u64, duty_cycles, priv->max + 2);
> +
> +	/*
> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
> +	 * the duty cycle count by one.
> +	 */
> +	if (duty_cycles >= period_cycles)
> +		duty_cycles = period_cycles - 1;
> +
> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
> +	if (duty_cycles < 2)
> +		duty_cycles = period_cycles;
> +
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
> +	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
> +	regmap_write(priv->map, TLR0, tlr0);
> +	regmap_write(priv->map, TLR1, tlr1);
> +
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */
> +		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
> +			/* Load TLR into TCR */
> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			regmap_write(priv->map, TCSR0, tcsr0);
> +			regmap_write(priv->map, TCSR1, tcsr1);
> +		}
> +	} else {
> +		regmap_write(priv->map, TCSR0, 0);
> +		regmap_write(priv->map, TCSR1, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	/* 100% duty cycle results in constant low output */
> +	if (state->period == state->duty_cycle)
> +		state->duty_cycle = 0;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops = {
> +	.apply = xilinx_pwm_apply,
> +	.get_state = xilinx_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct regmap_config xilinx_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.max_register = TCR1,
> +};
> +
> +static int xilinx_pwm_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct xilinx_timer_priv *priv;
> +	struct xilinx_pwm_device *xilinx_pwm;
> +	u32 pwm_cells, one_timer, width;
> +	void __iomem *regs;
> +
> +	/* If there are no PWM cells, this binding is for a timer */
> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret == -EINVAL)
> +		return -ENODEV;
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
> +
> +	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
> +	if (!xilinx_pwm)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, xilinx_pwm);
> +	priv = &xilinx_pwm->priv;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	priv->map = devm_regmap_init_mmio(dev, regs,
> +					  &xilinx_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return dev_err_probe(dev, PTR_ERR(priv->map),
> +				     "Could not create regmap\n");
> +
> +	ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not read xlnx,one-timer-only\n");
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Two timers required for PWM mode\n");
> +
> +
> +	ret = of_property_read_u32(np, "xlnx,count-width", &width);
> +	if (ret == -EINVAL)
> +		width = 32;
> +	else if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not read xlnx,count-width\n");
> +
> +	if (width != 8 && width != 16 && width != 32)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid counter width %d\n", width);
> +	priv->max = BIT_ULL(width) - 1;
> +
> +	/*
> +	 * The polarity of the Generate Out signals must be active high for PWM
> +	 * mode to work. We could determine this from the device tree, but
> +	 * alas, such properties are not allowed to be used.
> +	 */
> +
> +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Could not get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	xilinx_pwm->chip.dev = dev;
> +	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
> +	xilinx_pwm->chip.npwm = 1;
> +	ret = pwmchip_add(&xilinx_pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int xilinx_pwm_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&xilinx_pwm->chip);
> +	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
> +	clk_disable_unprepare(xilinx_pwm->priv.clk);
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_pwm_of_match[] = {
> +	{ .compatible = "xlnx,xps-timer-1.00.a", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
> +
> +static struct platform_driver xilinx_pwm_driver = {
> +	.probe = xilinx_pwm_probe,
> +	.remove = xilinx_pwm_remove,
> +	.driver = {
> +		.name = "xilinx-pwm",
> +		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
> +	},
> +};
> +module_platform_driver(xilinx_pwm_driver);
> +
> +MODULE_ALIAS("platform:xilinx-pwm");
> +MODULE_DESCRIPTION("PWM driver for Xilinx LogiCORE IP AXI Timer");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
> new file mode 100644
> index 000000000000..1f7757b84a5e
> --- /dev/null
> +++ b/include/clocksource/timer-xilinx.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + */
> +
> +#ifndef XILINX_TIMER_H
> +#define XILINX_TIMER_H
> +
> +#include <linux/compiler.h>
> +
> +#define TCSR0	0x00
> +#define TLR0	0x04
> +#define TCR0	0x08
> +#define TCSR1	0x10
> +#define TLR1	0x14
> +#define TCR1	0x18
> +
> +#define TCSR_MDT	BIT(0)
> +#define TCSR_UDT	BIT(1)
> +#define TCSR_GENT	BIT(2)
> +#define TCSR_CAPT	BIT(3)
> +#define TCSR_ARHT	BIT(4)
> +#define TCSR_LOAD	BIT(5)
> +#define TCSR_ENIT	BIT(6)
> +#define TCSR_ENT	BIT(7)
> +#define TCSR_TINT	BIT(8)
> +#define TCSR_PWMA	BIT(9)
> +#define TCSR_ENALL	BIT(10)
> +#define TCSR_CASC	BIT(11)
> +
> +struct clk;
> +struct device_node;
> +struct regmap;
> +
> +/**
> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
> + * @map: Regmap of the device, possibly with an offset
> + * @clk: Parent clock
> + * @max: Maximum value of the counters
> + */
> +struct xilinx_timer_priv {
> +	struct regmap *map;
> +	struct clk *clk;
> +	u32 max;
> +};
> +
> +/**
> + * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
> + *                             in clock cycles
> + * @priv: The timer's private data
> + * @tcsr: The value of the TCSR register for this counter
> + * @cycles: The number of cycles in this period
> + *
> + * Callers of this function MUST ensure that @cycles is representable as
> + * a TLR.
> + *
> + * Return: The calculated value for TLR
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles);
> +
> +/**
> + * xilinx_timer_get_period() - Get the current period of a counter
> + * @priv: The timer's private data
> + * @tlr: The value of TLR for this counter
> + * @tcsr: The value of TCSR for this counter
> + *
> + * Return: The period, in ns
> + */
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr);
> +
> +/**
> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
> + *                              AXI timer drivers.
> + * @priv: The timer's private data
> + * @np: The devicetree node for the timer
> + * @one_timer: Set to %1 if there is only one timer
> + *
> + * This performs common initialization, such as detecting endianness,
> + * and parsing devicetree properties. @priv->regs must be initialized
> + * before calling this function. This function initializes @priv->read,
> + * @priv->write, and @priv->width.
> + *
> + * Return: 0, or negative errno
> + */
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer);
> +
> +#endif /* XILINX_TIMER_H */
> 

ping?

Uwe/Thierry, can you have a look at this?

--Sean
