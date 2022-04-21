Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD05509BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387242AbiDUJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383050AbiDUJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:05:11 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC71FCFE;
        Thu, 21 Apr 2022 02:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5USoslaz/Eyf255Hjr25eiBM8S0LWZWhyB2GOGnOtDsl2gDKpJ6B313PLgK2eqzzfUFMmuHlBokC6plgMvOkptaA9JI9CdVV02JaknFDNhCm+YhkH9jDA72vpG9xX0YVPXH2DjB6b52XiGCr+0RM2o2j9YElVPL0U2qRKFVvh1l1yveO2hCxNG7N/DqB5cvclAJgDKzTzD6QooZTZKlr2jjtv7EpdAYo4/ECzpe1fZx1i2ogg/aWhAAbCFy7qHIhpa3odf5td+K7T6ndWg5f/vGwDhJ9zPjXXQ0AxwgpaOUHGKi5H5UuZanD691bJ8AqwQ/iDuSg89gjJ8PCc03IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7mdpigJrlkmZFrDxOzB/bKeLLs+dXYAvDqg4uDr5Sk=;
 b=eQw/RA511LwiAXLeBrwSMqefsNhx824pjP94MOt9OSY+FH8dzIhiCS0R3Ep+JsDhr+xpiYiaZ9+2IaIp3aN/d0GnHLrIy7RrmauIq03BqLMrzLtwIQ/4XMgvtLrBVcXsVg/Fba7z3jTnUhKezeP4twPizB0+AD03Hf9ifuSfa/bvaRsfAO+9BUEiIen79dn2xAOOceMO5BXT3z0BOAtu5MKYFyhwZDgG/rN2MTSjyX/oY8iBT6UR1RQQToOBIeHmJCm892vGBDhc1ZQlTnR9cpTmIhp4YTvYAaMiaZ8jmzCSsx5Z4qGQbMxNdnbwB8ETGm+zBr/dgOCVXWv5K1KbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7mdpigJrlkmZFrDxOzB/bKeLLs+dXYAvDqg4uDr5Sk=;
 b=KOoLMDKm3r1jbLYmCW1y1lQ2uf7p3ms+yRnFS7TtdhSN7QWIveY59ZH7/Tk8nHKokoBcW/HvYtnPqm2TjuNk66GsvX28yhr1mkDgU+6KkPI+BBqkvjbz3iUYryPVE+qL11Wn706kM8ShbN8FM7BkDkQJflS1e4HbAkNW1JhU7DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by MW2PR12MB2585.namprd12.prod.outlook.com (2603:10b6:907:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 09:02:19 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::21e3:cab5:423:b1ff]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::21e3:cab5:423:b1ff%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 09:02:19 +0000
Message-ID: <54d37c89-ca09-92a0-bb5e-ea26128f837f@amd.com>
Date:   Thu, 21 Apr 2022 14:32:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] amd_hsmp: Add HSMP protocol version 5 messages
Content-Language: en-US
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com
Cc:     markgross@kernel.org, siva.sathappan@amd.com,
        Suma Hegde <suma.hegde@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Song Liu <song@kernel.org>
References: <20220412073925.609698-1-nchatrad@amd.com>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <20220412073925.609698-1-nchatrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::13) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea074c9-dee1-4b1a-e400-08da2375a357
X-MS-TrafficTypeDiagnostic: MW2PR12MB2585:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25858432D6F0DC335AF13FCBE8F49@MW2PR12MB2585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WsjCGuLVdvmLmT/2rLbxdwAmUYV7YBbwKbHgDB9H/0J3QWE7wPL82IQCAs2K+Ul0x24hgnQw+acvOrb5+XfRUCEnExrpaNkGD2DNmGHVyD5TAxXT181WWoaLIcL0LunJakLgnOOunMnmJqH/o7oIZ1p6urSTcpQ0wzwd8BnH8PSp9M6RoazKkbImkDQvjXBYfcCoD8a3tmi9VjLE+qyj0jM05f2FuNSKmxUfhiSay9IGwrcNGp1Z5KbWpMGAZmKBPkvzCS9fGfxS2id3q4i5vsalCGYvgyT6Nsx/2rOr+2/5+odOZb0GUo+xQvry7GHzbZh/9KLPIBFR49zZnmFuM9gzW/Nl8WF0vB9GUuO76fx7d/PEY+jP8iDpe+6IAwWXfCVY6ofS2veyfVdK/KWOEynPTnBxco14HOt6h0Y/MWomiHrZpLwRI1ry9vah/SuYe0SJy7loNXtWrorjWSb2KpwNon7Filgm7lGVc6z9QWaQxZb8/vkQaAOL9JP8NEVlzGzM4Cbq+VxsT0ZOdN5ObEVtc6BR/chIfkrfU8ft533BACbPlYcxdNt/lpTVDiN2LoiOQnGHnwR1ZNRjMzPcuA/efIIG7ywkfhB5054+L62cdnvAmZkLxsZ9hry4iGQhCuY9RXfL5KLZcRoF0tudWUnax55HqjpDnAwJhNMB3iRBzxwwQLDeQlOe4ikQVa4iDzUoMdRHSjW8MOeZ3EVieRae4VE47mS/5pMmnJh8H4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(2906002)(6666004)(5660300002)(15650500001)(53546011)(508600001)(31696002)(6512007)(66556008)(8676002)(66476007)(4326008)(66946007)(26005)(6506007)(31686004)(2616005)(316002)(83380400001)(36756003)(38100700002)(54906003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUc5WExOTzRnb0hBZm0ySS9IWTJRZHI0S2JtSFZhMEI5Rmd6MnQ3bXZpcnNm?=
 =?utf-8?B?eDA5MDZTWTVTVEx6SDZEZ0U0L2hOM0NyMWtXVGM0cHIweVpNTXJwN0c4NU1i?=
 =?utf-8?B?dkNkb0hva2diMnoyZnY2ajNNNGlLUzV0TjJXc2NzL2g2bUhRNnh0cjROaHgr?=
 =?utf-8?B?a0c1NEppZkZiWnVHaTVVcHZwcVQ1R0VDVmwrUWhMR0twTXBMMmlZanQzYjJt?=
 =?utf-8?B?STNlKzVCUmtMK0FNT1V1VFRKOG8rWkRwUDFJQW5FcFo2ejVValFtK24yalpr?=
 =?utf-8?B?UG5ocnVCdW5lNkxSVHR4Zzl2Y0ZRM2psbFhJanhFQXlqamNWUVY1TGlyaGxi?=
 =?utf-8?B?OXhvT0o3SDB2L2NkeVJUaTlxMS9WY05DZktuYWxPeUZVVmJ5STd2N0tTaWZE?=
 =?utf-8?B?SkkvSElJYXQ5VE4yTFBNZWI3THFQalg0NEY5ZzVWa1NHczkrV3BVNnEzL1Bs?=
 =?utf-8?B?NC95UjhHSHBTZHV6TXJhRGNGY2VVcXM1eGE5M3I5bm5GZmdha3ByY3hDaGtv?=
 =?utf-8?B?MnkrQWd6cDUxY0ZzeE84ZTQzQm02RDhjUlBaamRVNUR0RS9WY29RdVN2U0U4?=
 =?utf-8?B?OWRERzV4VUxKc3JWaCt1a3g0V0Y2Yy9wMUFxaTZWMUhjVkdoZXh2SThlTlVa?=
 =?utf-8?B?NlJsejRhYThBaTJPbzlPNWcycjZwdktPMmRhek1FVGFFWXB1QXZXT3Q2dUQx?=
 =?utf-8?B?NkRSZ3RXZ1JvKzI0M05JWHdSUHM5cHdlTlZtN2N2YnNQUHFCRWZlb0t4SHNO?=
 =?utf-8?B?WFR0Si9FeS9kNUVoK0srMXpEOFY1bDlZU1J3ZHVqWUJPMlAzc0I3NFEzY2JK?=
 =?utf-8?B?MC9HMzBldmFQckxsVlJxWGlNYXVEdHdEekNsUDBVVWxLdDdYSzBaNlRSakZR?=
 =?utf-8?B?cFVRR2JScytaNW1FelNCZzU2cm92QkNwSDN6SmtDQm55RC9SR2JzOUk4eVBi?=
 =?utf-8?B?dWhwbzJBc1ZrYUNRQTcwQUhURy81WWlJWU1hVmFyM2ZyQldVdWpEcTEzUzY4?=
 =?utf-8?B?bWJCQnN2bXNaUGdpaVRSY3NyS1BzMzJtLzIvMG1mcmlJZGhtMG1HdWpHSWQw?=
 =?utf-8?B?S1BxU2dWRUMrbVV1ZGcvdkk5SFA3V284RDd6WVJKWCtPWW5JdUl3Vkx1S0lK?=
 =?utf-8?B?b0lQWlZ5cEsySkpxN3pmZFBodkhtekVXSCtWM1hPV3BYNUg4RWp4Y2Q1TUF1?=
 =?utf-8?B?TFRWM2tPb0M2ZFVNUVd3dmx0eXlFRm1wN0Q3Q0pRQWJiNUNhQ3lGQVlhc05O?=
 =?utf-8?B?WHRVNXZ2b2VwcGVkeERFMTZqalBmKytFNWVjemlxRXpnRkZ6Wk9TNTlieEpm?=
 =?utf-8?B?aUlpRk8yVkhlWElpZUE2NjVsNFQzaCtFWUpFU2h4a0hWVFo1c0lmejJpYUd3?=
 =?utf-8?B?U2ZSVWl3NnJkb1AxdTJ6Nk5VQ3hoK1JMZG40cHNMeUZwZEFBdkI4L3I2bitZ?=
 =?utf-8?B?T0ZyT0d1N2RRNUtTLy9nQVErZmQ4NWlCMjZsYTlMUFVQUjI2S3JEekpUd2h1?=
 =?utf-8?B?WFpOcWhvd2oxQnVqQkQvTlk4ZHJnUDdYc05EaEJjdkhFUDZpZmZUMDdkRURz?=
 =?utf-8?B?alQ0OFlZUUdZSUNkK0FwTFlUeDFKNlNyUWN2MDdYalhLR0syTnJQazJUdWEz?=
 =?utf-8?B?dzZGTmhYaGdWWW5NOHNpSWI5MlZsY0NVVUxYNHlsejErRmdHTkRkaTJ2a3Bk?=
 =?utf-8?B?RktSYVN5SVlQZVBwbXRLSEJmTFkzU3dIeXRtaks1L2UrNWZ0VEQwY05IZEIy?=
 =?utf-8?B?RlFZc2ZXR1htbWN0OEVMc2YzZnp2N3JwWjIrV0Nnd1lwYThYdEJhaFhLLy8y?=
 =?utf-8?B?RCtMUkVGOEZMZmZBT2prZ1JQMmRtaXAxeEpNblFvWloyeEFHYmtxQVIxbW9Z?=
 =?utf-8?B?MndBVVBoZ1BqNno5RkpSZU1PSEZra3lxNWFYeWtxRHRmZkZtT2ZZQnc5V2Uy?=
 =?utf-8?B?SmZibXdHQ3c5TWliVm5LZkkyOUVFanE1dDc1T29vdEd5TG5tYTlXV2xrdkhv?=
 =?utf-8?B?dEZJYUowZU5jYi9hTXk0WUZiSC9qMEJUeEh1VC9zQ1U3UDRlNk9IM3I2dDNm?=
 =?utf-8?B?WFYzYUI0aXdSVXo0c01JbXdydEFjUis3dy9jYnA4LzdSSis3c1pHaW11ZlJu?=
 =?utf-8?B?WlNYV2tyeDZpemg1NU10a2JxbkZKYTA2dmtWQlY5RG5BYWhiNm96SU1SR0Fa?=
 =?utf-8?B?QWpBLzllS1ZISFF4QnhyenRDdktzRlFxU0t2ZlRhaGh4R1BxQUZHejY4NWk4?=
 =?utf-8?B?NDdjanpnQ285eFVkV05waFdkTmczT0c4V0Fic3BBU3ZsRWl5SlY5dTZZeFFE?=
 =?utf-8?B?a0d3bzVlbUR0bVduMVEzY081WE9aQUczRGk1bGJzaEl0aUpvVmZDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea074c9-dee1-4b1a-e400-08da2375a357
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 09:02:18.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T9URpy3h5+dMhdJOMspnKZx830Ugq1FJR/GnAFXY9K4BFayfE6ymrouRXxRbf+nivFw64jlMlX5+ImMR50MRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2585
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 4/12/2022 1:09 PM, Naveen Krishna Chatradhi wrote:
> From: Suma Hegde <suma.hegde@amd.com>
>
> HSMP protocol version 5 is supported on AMD family 19h model 10h
> EPYC processors. This version brings new features such as
> -- DIMM statistics
> -- Bandwidth for IO and xGMI links
> -- Monitor socket and core frequency limits
> -- Configure power efficiency modes, DF pstate range etc
>
> Signed-off-by: Suma Hegde <suma.hegde@amd.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
A couple of reviews have happened, can we get this patch in. Thanks.
> ---
> changes since v1:
> spell correction in commit message
>
>   arch/x86/include/uapi/asm/amd_hsmp.h | 114 +++++++++++++++++++++++++--
>   1 file changed, 109 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
> index 7ee7ba0d63a3..769b939444ae 100644
> --- a/arch/x86/include/uapi/asm/amd_hsmp.h
> +++ b/arch/x86/include/uapi/asm/amd_hsmp.h
> @@ -31,9 +31,22 @@ enum hsmp_message_ids {
>   	HSMP_GET_CCLK_THROTTLE_LIMIT,	/* 10h Get CCLK frequency limit in socket */
>   	HSMP_GET_C0_PERCENT,		/* 11h Get average C0 residency in socket */
>   	HSMP_SET_NBIO_DPM_LEVEL,	/* 12h Set max/min LCLK DPM Level for a given NBIO */
> -					/* 13h Reserved */
> -	HSMP_GET_DDR_BANDWIDTH = 0x14,	/* 14h Get theoretical maximum and current DDR Bandwidth */
> -	HSMP_GET_TEMP_MONITOR,		/* 15h Get per-DIMM temperature and refresh rates */
> +	HSMP_GET_NBIO_DPM_LEVEL,	/* 13h Get LCLK DPM level min and max for a given NBIO */
> +	HSMP_GET_DDR_BANDWIDTH,		/* 14h Get theoretical maximum and current DDR Bandwidth */
> +	HSMP_GET_TEMP_MONITOR,		/* 15h Get socket temperature */
> +	HSMP_GET_DIMM_TEMP_RANGE,	/* 16h Get per-DIMM temperature range and refresh rate */
> +	HSMP_GET_DIMM_POWER,		/* 17h Get per-DIMM power consumption */
> +	HSMP_GET_DIMM_THERMAL,		/* 18h Get per-DIMM thermal sensors */
> +	HSMP_GET_SOCKET_FREQ_LIMIT,	/* 19h Get current active frequency per socket */
> +	HSMP_GET_CCLK_CORE_LIMIT,	/* 1Ah Get CCLK frequency limit per core */
> +	HSMP_GET_RAILS_SVI,		/* 1Bh Get SVI-based Telemetry for all rails */
> +	HSMP_GET_SOCKET_FMAX_FMIN,	/* 1Ch Get Fmax and Fmin per socket */
> +	HSMP_GET_IOLINK_BANDWITH,	/* 1Dh Get current bandwidth on IO Link */
> +	HSMP_GET_XGMI_BANDWITH,		/* 1Eh Get current bandwidth on xGMI Link */
> +	HSMP_SET_GMI3_WIDTH,		/* 1Fh Set max and min GMI3 Link width */
> +	HSMP_SET_PCI_RATE,		/* 20h Control link rate on PCIe devices */
> +	HSMP_SET_POWER_MODE,		/* 21h Select power efficiency profile policy */
> +	HSMP_SET_PSTATE_MAX_MIN,	/* 22h Set the max and min DF P-State  */
>   	HSMP_MSG_ID_MAX,
>   };
>   
> @@ -175,8 +188,12 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>   	 */
>   	{1, 0, HSMP_SET},
>   
> -	/* RESERVED message */
> -	{0, 0, HSMP_RSVD},
> +	/*
> +	 * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
> +	 * input: args[0] = nbioid[23:16]
> +	 * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
>   
>   	/*
>   	 * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
> @@ -191,6 +208,93 @@ static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
>   	 * [7:5] fractional part
>   	 */
>   	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = refresh rate[3] + temperature range[2:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
> +	 * DIMM address[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
> +	 * input: args[0] = DIMM address[7:0]
> +	 * output: args[0] = temperature in degree celcius[31:21] + update rate in ms[16:8] +
> +	 * DIMM address[7:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
> +	 * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
> +	 * input: args[0] = apic id [31:0]
> +	 * output: args[0] = frequency in MHz[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
> +	 * output: args[0] = power in mW[31:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
> +	 * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
> +	 */
> +	{0, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
> +	 * input: args[0] = link id[15:8] + bw type[2:0]
> +	 * output: args[0] = io bandwidth in Mbps[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
> +	 * input: args[0] = link id[15:8] + bw type[2:0]
> +	 * output: args[0] = xgmi bandwidth in Mbps[31:0]
> +	 */
> +	{1, 1, HSMP_GET},
> +
> +	/*
> +	 * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
> +	 * input: args[0] = min link width[15:8] + max link width[7:0]
> +	 */
> +	{1, 0, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
> +	 * input: args[0] = link rate control value
> +	 * output: args[0] = previous link rate control value
> +	 */
> +	{1, 1, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
> +	 * input: args[0] = power efficiency mode[2:0]
> +	 */
> +	{1, 0, HSMP_SET},
> +
> +	/*
> +	 * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
> +	 * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
> +	 */
> +	{1, 0, HSMP_SET},
>   };
>   
>   /* Reset to default packing */
