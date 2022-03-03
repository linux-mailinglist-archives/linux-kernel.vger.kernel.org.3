Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9C4CC8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiCCWRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiCCWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:17:01 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4486E31;
        Thu,  3 Mar 2022 14:16:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP3eDI3HOLQjVK1Ag72++36O7u6i2OV04Xt6jSoVOXHjnUpC2hEx4co5MaCGlf9LqfOjBh4Wi8GMyS9NAYKTSpasey2Zbczdl2UtPMDXIgrcq2Y4BE6RZqtiGKkvKZ6mZLlylHdEAhGC0Ezbg5SxUgmZHq0gBWtsKcKZWA7CQfygAT0G5L9FmKSXsT+GsmFQnxayBMlOT5+tQ1qYMvtRSV84mY1AsEOJ2gQC/NMVV3jf0kXy/hH57EfNvcecPHxuUlQuFZFjwYH8qwkrM2eRVuJEKH8N5PSwESueFrDRjIPeKFXVs9I68gNRCaKKm8yc1hYzf6lTYfU+k+nYXtoK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djV9kvGPcEK6DsFrhRPTKzctic6XgZjb8dfJiItogJc=;
 b=LRirN0khDeUCDATnlwCdWt83ATsZePFsg7X3MAt86a8jie3MhQuPQUuAPdha6WmhxR/IRH1EKvfhno5NDAX6rJ84FXdfAg4eMaG3mibiZTEriwIdxNYSrzAYOZwpL7//qzqIsbsMuoaNobZyjgzAKC+1bCU6RgXtrZkVRv68xpTQqpDGiUMlOyC6AzzKZcWwEl17J4efBgRh3TUVDYOS0VKtciFJgTpMn3aR11pe2lv0b4vDG5z/enteWfWbRwtbL7ZmClafqHnDNG08XdMg0SxhaFhM7M5MHFDB9J22Q/6QtwzGwxBE367967W2aSq7CEAfbfbz4sixyE4Gq3yedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djV9kvGPcEK6DsFrhRPTKzctic6XgZjb8dfJiItogJc=;
 b=SV9o9oqxOqRkjURoUIJyqvitvFetNwh68Tix+2EY6RtjckeO6xb6T3Q+uelchfHAaBKdaqdDymadrdciftjeD9OGqLi2/SXSDyiFHx6P2rUohurKwuzFxC5sOR5FKoMMxHX2iqOg7pa5uxWuQenqch7YREFldJjOIDCs1ZZtCNDHmRz1dHfKCixfNlKuSCCjMQ8C2wbGkprvyqAXTQ0A4XywNs260FebOVBP2Z7kXwk2Zk8sKQMJ42aecUY1PBUdU3VNXcH3Rpi8OvrYwBNPT+3JzLuc0CsA5cXoI4l2hOrrVNGz34ncFRPv9pMzJkHFuc8KLDSMNFAFm2rY0gfFng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4872.eurprd03.prod.outlook.com (2603:10a6:20b:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 22:16:10 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 22:16:09 +0000
Subject: Re: [PATCH v13 2/2] pwm: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>
References: <20220204180106.154000-1-sean.anderson@seco.com>
 <20220204180106.154000-2-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <1531e89f-4847-4f31-3cfc-a2b21e69cc35@seco.com>
Date:   Thu, 3 Mar 2022 17:16:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220204180106.154000-2-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:208:23b::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ff7920-06a5-46d9-d3e0-08d9fd636b67
X-MS-TrafficTypeDiagnostic: AM6PR03MB4872:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB487234628781DDBE1C50C2B396049@AM6PR03MB4872.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Osmj/N2mLfzRYxCmXA40fogA6KuwGHhRTU+CvLys3dol0O8DbhrKHhukk5zYkekGlaNxSg2fNTZZoS9+pJP8gK8zxJxjEPaONw31AKeA9AKudJVQambMNzDneP5Lg6z/IPCuQ+P2dAsmeKS2xLMjx1dorqPvmIzzp/v3CPIoL58MriSgIR591ebBw2/yWTbPUCVWl0KLnmreb462j8qvatvYiiY57ENEdk+DCLKaPznrJSQph7Ve0ffzSU591Fb6d75/WFjDeR8CUiLGLVmxgo2uhAB1irKFrKwgPn6j6F/mTo73rVJeY7jr6TrtJkUmcnOi28crzJsAYv6fUJQ3L7oxDACKYPuEy1GHHwqAme/T2t0S81wN9E8lJyVMvKPLX5dSSOwHmBHofvy3WA4j8Fe8nDt+Xefe9Xt/0110knZ08DsPL8/mynwDkyzUY3IlF/NeeFyaCTkxsgOvopLQ+YipnBzflBfe+66OtdqyaSOSN7Cmt3YbYBCNhLI/GBvT9C48YEUHfdz4HCU4DPJnee9aJlhv5S0qlPaE9/IdffhIn4O7dwUiddoieYaPyq7dr/yEyyBP3LpDVMjGz5oP+k62qWBBXtuyZQ/3rlwLex54XpCAcyOdYhGTBrgx45pMkHqigHFB+du1ciyyoFKOb+ZcbiBo0EHFzAJqfr5ByYWLRdqcymIfapWxPselLzOr4+8L8InGCABukE1vbsd7rAWdAo0/rLn95K44akjAWOjQqD9pHssHpcooDL5w8AgUCurwtJO9hDH6T8ok0lco/5Tx7/uzDBIbkjyQtHDR3EWt7KM+5V208eF55MccE4jVPFqclbDU6lDccOJukihnijoxi+gx6+3rXJUV9K3+u5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(83380400001)(31686004)(26005)(7416002)(36756003)(2616005)(54906003)(52116002)(53546011)(6666004)(44832011)(6506007)(186003)(6512007)(30864003)(8936002)(66556008)(66476007)(316002)(38100700002)(86362001)(31696002)(508600001)(38350700002)(6486002)(66946007)(966005)(8676002)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHR3bnNDaXdpbjdnb3dvNkZWdnUwOElpLytvTnJuZlE1MHRZUkludmkzYkVn?=
 =?utf-8?B?dHVRY21zS3BvVVFYdW15eCtiUDY2SDRhWC9GMFczTmc4M3VCaUJRNkRxK1pO?=
 =?utf-8?B?Q09KTGo5cDJSVW14RXRmV29ubnkrRnpDNVhxNDVSZk1nRnBNNW5aVkMya2Rq?=
 =?utf-8?B?MGxJVEdUamp1cC9OUWFlODdIMGVyMFBTL2o2UFNnRlVoelZDZlE0Ym9xVGRH?=
 =?utf-8?B?R0hXTnlrS2tqbHZwV3pMVjlUOTZvWDlJRCtNYWRLWTRrM3FnWk1QeXJqak4w?=
 =?utf-8?B?Vzg3aVNuRGUzc2x5L1Q1OWNvZ05FL3BPN1ZxZWpwWVlnSWtGa3JkMzFmZTJE?=
 =?utf-8?B?amVIK250Ym8yREdOeWVKQ0RNYk81bDVlVzdpbERIY0g1eGlpUGczelI5R1h2?=
 =?utf-8?B?Z1hvWVVIcmE5NDZiaE1TVEhMdW1Dd3hkeHFHaTgrYlhNVnplTkplZVZ1M0h1?=
 =?utf-8?B?cnlrckZiWlE1Qmxjd0YzWGJQTklGd0k1OVZnVFFZR0NxcjhNUXM3S040YVdX?=
 =?utf-8?B?cXFxVGVKZm44QUhMQ3ZhcW9pV3V4WSt6eHFBOFdDakVUZ2UwcnBOb1dsKzVs?=
 =?utf-8?B?VVNUeVp3bnl1aWVKSTU2a3lHak1EWEdMMWV3UlNUek96cVMyOWh4SUorTDN2?=
 =?utf-8?B?NElFMCsxUjl5SG5WODMrWFM3VlVubnR6N3E1LzMwZncyMDdZWkxLR09VNTVw?=
 =?utf-8?B?cjc4MnJ6WkxvZ3hoU1orSG10bE1sOUhrT09Bb2x4YTJSVld3RjdzbVZscE9C?=
 =?utf-8?B?eHI3cnpob1ZFNDI2SEtVWEs5YXZ4Snk1Q094YzNsTGljcDdGM0kwL3pFTlFu?=
 =?utf-8?B?RjhLeGlrN0UreHNiWkJFd043dFlYWncyTXdnQmN3blRqNDFoSllhK0ZXQ2lL?=
 =?utf-8?B?c0JRVHNWZlJhYjBjNjdvYXVZRjMrWjZ3MlVxc2RwamIyUzdaNGdKUFhGZDVQ?=
 =?utf-8?B?MVBhc0IyMHN0VE5nWXhKZEtHYkFWRWJSMVoydjFFTDFhdi8yVG9IWVZvWVRu?=
 =?utf-8?B?d05ZY2wwdzRoN09YVDRUaGxvbG5hSHlRZDRUSGhkbmpKMmVDbjl4b0s0TU56?=
 =?utf-8?B?Q25HaVFURDVUNE5pbDlKclRvY25Vb2pEVU1jSkg5K2lhWnJyZ29kOFI5ZE1G?=
 =?utf-8?B?UkdBSjl0MUtyN2dacnd1TlJGNy91QUVJMW1NZlA3dTJwcXdrdml1bU0rcit6?=
 =?utf-8?B?RkVqOEdzN2N6bXl2T2Y0Rlo5bnBnOHhCNVZrZnJrN0VCVUoyUHltMFh2MkJh?=
 =?utf-8?B?T1R1ZklsWnRmSHBjQmVmaVRXdkg4ZmxMRGNiVlM3b3NEWTFpZjdWOXNpaHJW?=
 =?utf-8?B?MmR6enUrWnNVL1lzdmMyR2NlajRveGdCK042c3FjRTlKUzBkV3FiYlp4UnBx?=
 =?utf-8?B?OXhnWW5LcEZVREdkZ045UEFkTCtCSTRGa0xzR3pqL2Z2NXlJU3FKb2kvSU9Y?=
 =?utf-8?B?WlpnV3loSWJqUVpwUnpKUTVaRkNlU0g1K2VHNHFldElWTzJncG5YUzJYUE41?=
 =?utf-8?B?SDJmM2srM216Nm5ieWV0NTRtWmpMMkt5dm0vQ2tnU1B3M2h0TWhMdG9IalV6?=
 =?utf-8?B?bURnN1JueWsxK1V2cTJhSUdXNjQ3S2NLczBLOWYzZEh2NGNzVm5URWF6Y0lQ?=
 =?utf-8?B?QVB6MHc5eFF5VWdSdElYODVGLzMyMG42UDlRRTV4NjlNK0N6bU1DYjhDL25W?=
 =?utf-8?B?R2ZkUlVyaG8wU29HOVFiMHQ4WCsybDBrRGw2bGR1Q3BNVksxNzUxMHRETVNG?=
 =?utf-8?B?NHRmSmRUcnZVaUI4WnBTdkk4VG9jUnplTnJGZWFBWWczdk5Uc1crcHY2c3E4?=
 =?utf-8?B?alMvaWNFWDQrSnp1UUJ0a3ZVcWJXc2ZiOVZGeTNTa3pBbitUZ2lRSVNjempx?=
 =?utf-8?B?dGZYYVk5U1l6RGt4QmRqSWorTWVNNjdoanA2YTNiYkhXN3BxZUpmOUhTTThz?=
 =?utf-8?B?RnByVlBpSzYrVkZERndvVllQYkMrQlVFMVpTQXpDZVNkRGVUS3hjKzFaNXFi?=
 =?utf-8?B?UEp6RkNmbFUrYWxQUkJmMWZpN29URzhhUVVBNEtwcXM5bHl5SzJ6d2lDYVJh?=
 =?utf-8?B?a0pqSTc4ajJuMlR0dUh1SWFMYm5SRTk3eUNLVy9CNmE0SlNnL2tvY3YzVGRW?=
 =?utf-8?B?Tkc2YS9kVlppUFhUblVyTm5tUGxuMHM3TDJLeVNha2JUQ2NoOE5KVk50U3JL?=
 =?utf-8?Q?Dmh77RW+DJSv+Krs5+HOpCQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ff7920-06a5-46d9-d3e0-08d9fd636b67
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 22:16:09.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4yZoWPofFJ5vj1V7HHbvOGeXSTGUZucqbo2J7/r+2DDoXzDmZr09i1glh/EqDcLW5BuwxDCFP5Vtu0pUFJ0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/22 1:01 PM, Sean Anderson wrote:
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
> Changes in v13:
> - Clamp period/duty_cycle by assuming rate is at most U32_MAX
> - Expand comment in xilinx_timer_get_period
> - Note that the 100% duty cycle calculations may be wrong for very high
>   clock rates
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
>   debugfs
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
>   some don't.
> - Put common timer properties into their own struct to better reuse
>   code.
> - Remove references to properties which are not good enough for Linux.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>   initialized before we have proper devices. This does bloat the code a bit
>   since we can no longer rely on helpers such as dev_err_probe. We also
>   cannot rely on device resources being free'd on failure, so we must free
>   them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>   to deal with endianness issues, as originally seen in the microblaze
>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
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
>  MAINTAINERS                        |   6 +
>  arch/microblaze/kernel/timer.c     |   4 +
>  drivers/pwm/Kconfig                |  14 ++
>  drivers/pwm/Makefile               |   1 +
>  drivers/pwm/pwm-xilinx.c           | 322 +++++++++++++++++++++++++++++
>  include/clocksource/timer-xilinx.h |  91 ++++++++
>  6 files changed, 438 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>  create mode 100644 include/clocksource/timer-xilinx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..54709e3f09a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21201,6 +21201,12 @@ F:	drivers/misc/Makefile
>  F:	drivers/misc/xilinx_sdfec.c
>  F:	include/uapi/misc/xilinx_sdfec.h
>  
> +XILINX PWM DRIVER
> +M:	Sean Anderson <sean.anderson@seco.com>
> +S:	Maintained
> +F:	drivers/pwm/pwm-xilinx.c
> +F:	include/clocksource/timer-xilinx.h
> +
>  XILINX UARTLITE SERIAL DRIVER
>  M:	Peter Korsgaard <jacmet@sunsite.dk>
>  L:	linux-serial@vger.kernel.org
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
> index f8832cf49384..26c385582c3b 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -251,6 +251,10 @@ static int __init xilinx_timer_init(struct device_node *timer)
>  	u32 timer_num = 1;
>  	int ret;
>  
> +	/* If this property is present, the device is a PWM and not a timer */
> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return 0;
> +
>  	if (initialized)
>  		return -EINVAL;
>  
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..cefbf00b4c7e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -640,4 +640,18 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
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
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..1e7a38bd9b34
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,322 @@
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
> +	/* cycles has a max of 2^32 + 2, so we can't overflow */
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
> +	period_cycles = min_t(u64, state->period, U32_MAX * NSEC_PER_SEC);
> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	period_cycles = min_t(u64, period_cycles, priv->max + 2);
> +	if (period_cycles < 2)
> +		return -ERANGE;
> +
> +	/* Same thing for duty cycles */
> +	duty_cycles = min_t(u64, state->duty_cycle, U32_MAX * NSEC_PER_SEC);
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
> +	/*
> +	 * 100% duty cycle results in constant low output. This may be slightly
> +	 * wrong if rate >= 1GHz, so fix this if you have such hardware :)
> +	 */
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

I know Uwe had some feedback on the last revision, but it affects only
theoretical hardware (under unusual circumstances).

This has been though a lot of revisions, but for the past few I haven't
made any functional changes to the happy path (just refactoring and
fixing some edge cases). If there are no objections, I'd really like to
see this merged.

--Sean
