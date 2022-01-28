Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A834A03B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351699AbiA1Wcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:32:35 -0500
Received: from mail-eopbgr30134.outbound.protection.outlook.com ([40.107.3.134]:55513
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351661AbiA1Wce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:32:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEXS1UYxpDKtZbsBRh51M4BMbxQk932sVPllnUT8EqEdXw8u7EvtCnRdrYtSY+8+Uxg0ONG/E9F+M1yw41Kd/8Ef75LZc7bo8c+P+GupLwDUnH58IOS/+oQz3eAS8IVNQ5v6tT09wW/pp8ej+2JP6BepMjRvyswuUQrNTQ617R1wVnVTiN/YV9igJ5dh9/qrK6NwbJtyPKvffGnLzDmJoOeod9rQO5PsGRktNaYWoXaObxXVa+F+Ys+rCWLf07A/Rj6TsBJLHSSCdI6rFlX7LPHQaRHtJpfNCjY1vwyeyZrX8QEfOG77CVv6ueAChGdzeljPmnTMOUYy+QO8qRpPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcRQX9PrxnpT96skImbpQu6ioMUrZfMqxEZ72+gjvck=;
 b=ae1Xx34hnwGPX6ce/bFi4W6FUcQ0O6qC6pNz2g/BQrIKqFDE/sw8seI/UyRfOHBis+nBQm1iOGsff8vDk+YNQEsxHjqFzqRip0LfUrBdZEUd15egpG8d7Ka+0XiF8fROo1ophrR9BDPixWdILUBKW4mk+VCrSmFhfVAdPcqRdUIAWZCWkZqC4LQ5+B5UXmuAxgg/hYO8jb9NjUmoHzeETwNOniVg+zY+1t8yHs6hsetGDjMsbq23+ihK9tYSYvYMNG8BvWT50XspUk1cqTapxwuU3+u63qY8YnlumSF/rUgY+e2zhWsmavrHNcWPBLDomfMkeo22mRk3TN72uOUJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcRQX9PrxnpT96skImbpQu6ioMUrZfMqxEZ72+gjvck=;
 b=NlBVPEKNcKp5AH7INLawXkHnDyfdXOQI6cHdm6TaJSyROSP8waxNy/YUymyRtMsBeDU6boTuEAugdjtNwluSRAGHtS5x0r5FKt3qQyl1EseNAEnfvlnwCjF1pFCD+wRcp0aP5kkDhGphOI6YvOqt0K6F52lQC0Ap4XdkvfrYBxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by DB6PR0701MB2215.eurprd07.prod.outlook.com (2603:10a6:4:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 22:32:30 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%6]) with mapi id 15.20.4951.006; Fri, 28 Jan 2022
 22:32:30 +0000
Date:   Fri, 28 Jan 2022 23:32:19 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfRu86YoiFpVsqyn@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfREAiRMjQ9ci4LC@shikoro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfREAiRMjQ9ci4LC@shikoro>
X-ClientProxiedBy: CH0PR03CA0421.namprd03.prod.outlook.com
 (2603:10b6:610:10e::26) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61ad7cfb-a61d-494b-dbf8-08d9e2ae1176
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2215:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0701MB22156EC11A79883F323F938EEF229@DB6PR0701MB2215.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEow5RhHqd6ffsD7TlGVVKHQ0LXdRrMh+3m2ZrKbtyx6CkvLHVko5BTNOPK7wQxOQv81BTt3fKhmkhXlAR2hgoNAr1OypJceMUkLgY8tmk+wpZWusSbLo0J8L7V7G2dgJ0l5jqalEZrJYA6YOrYetFi2YxrKdaFzmPqaAI1pyYhXsjWapYN9dRpdgQGqm45398+c4wjoQlune/8VDrT5wnRXq9PAEiu1xvwG/VB4fen/yUx551+b6zECrdzN7C8bj8a93tmb9+tgitZzlo1xUO8/1sttjUMGi1OGfdw24EiYrBSLF8J3cvhQ11v5KtrjiKr7qw9p0E+9jAHoH0wCLUV48I82lSiV39aIHpHFAO43dxyiC6Z8oQet81Feb/b+gPutD+ogtvtTdBVK0kq1nJe4id0iKC46tkoeK2xcKneOxYwqprG+iNFu/GECHMVMgxC2SBBsVoHcnBvHN15xAvgazBWVZgPu+qeHtBeCyyiQv4lxzqJv/Ul3iig6kJPqBfG8c1LnJLLwXg517f6gTLyt0scH46x+X7HI9DHoWt85tE5DVRfqyq6UlG+H+2IT3czGcXumqmO7Q5b9aCKXwNO+jahtjYbZgtlNHUatf1sc0NJxkZmBKJpegRiaDW24O3qZfS8e9bnG0FSqOgW7I9L124WCJKnattUFPSJrCtVAY4V9AqF5Omm8sCsFGnNTfSeHutSaSzyEwIhCFe8iJAG6rjonWL8U3DEYnphs+Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(186003)(8936002)(6486002)(26005)(66476007)(66946007)(5660300002)(66556008)(86362001)(8676002)(9686003)(82960400001)(316002)(52116002)(6506007)(6512007)(6666004)(110136005)(2906002)(38350700002)(921005)(508600001)(38100700002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDIrSkZWRTQ3Y1JyRVU1bjVQeVg4OFgxM1BqeWxOdW12ZThWM25CNzZjWFpC?=
 =?utf-8?B?RmdzL29LQ0FJUUM0M215VkVxK2M3b1RSSDhTdnhxTC9XSnYrRFJ1SjduWWxG?=
 =?utf-8?B?ZnNGN1IzU3o0MmxuWms2SktDWHZ3ZFlUWEtZZzhxU2FOZmJwai9WdmhUbUQv?=
 =?utf-8?B?V3QwcmRha21EUzFEOHE0K2E1SXF5VzRRTmlLZTRMbEhRUmkwV0w0SFQvUEMw?=
 =?utf-8?B?S1B5ZnBGZFl1U2xua0hPUjYzWXNqaGExWlZHbmVZaEFrTnY5TnhKWEdmalhW?=
 =?utf-8?B?TGQzVG5LaklsQ0MyaHczbW5KMXlvR2VDMWRpcXl5anhpWGxqMFBwditJWkh6?=
 =?utf-8?B?c2hUdG9JajBwaFcrY01rYWprWUp5cHNwdlBEZ2thQXdDZDNzZEM5UnlHM3dX?=
 =?utf-8?B?YmhkOFphTk1kTzd3NVdHa2t0d0Q0SUxVcXU3cFRtTVJTdlFxZzh2VGNtMzJG?=
 =?utf-8?B?ejBqUldHK3Jhcnl3bWVxTjZGeWMvTGprLzVUNU0vWTIzS2JmV3hyS1dmS21I?=
 =?utf-8?B?SWtIZWROYUE2Zkd0dnA5VDcwZlZsNU5kL1lhUi9ZZC9sVUFnTE43ZDdnTmQ1?=
 =?utf-8?B?b3RCVUp3N1h2NlU3SlFORDlDMGo4eE5EQjNpTTM5Z1NkdGlDeXQwSjlZMGhK?=
 =?utf-8?B?Zmk2SS9Dc3JFTXhGNVNXeEtNRjdHTXV5NGZ5bTBvZFlsMG5iVCtDcW85MUFk?=
 =?utf-8?B?MCtZYytVaDgxbjBzT0RHVzBGbndYOFRPV0p2NWFWQ0k3bnducG13Yi9IcXFK?=
 =?utf-8?B?WVkrQTBpVktDblAvTXVObEIvM0pETEc3eURPTHZncjd3eDhiVCttTjZkVHFN?=
 =?utf-8?B?Q2MwYXp6ZU5jWlZSYisrKzNNaiswUmtkQjM0ZFlWSkgwU1oxL2VvRnNpSHVh?=
 =?utf-8?B?U24zR2tpcjFqK2FYNFlRN3J2M0NDVHIxSjdBeTF0L1BPSWJ2a2p1aTYzU1lO?=
 =?utf-8?B?dUxGY1l6cVl4bVBUVFFWd2RTRTVLbklWNWlHcmp5RTNJUHNBQUZkdSt1WFZ5?=
 =?utf-8?B?eWtWOEJDalJmYVMrcGcrMmpOWUMxOUlQaGdYMC80QzJBVWx3YVdFakxQNEov?=
 =?utf-8?B?V3pLSDZZN1VpTGg5d2VTQVh3MEJXMTVvdHlnNjFBNzcvUC9hZ1dFbWNPNVFG?=
 =?utf-8?B?MGsvak02SDdmMEc2MFhESnpNemJOUTFSOGFzTEVLa04yVTRXN29yTzJjWlRu?=
 =?utf-8?B?aE5DUnp5Rlh5RHNRTHYvOXVtcC8vUmQ1cFZ0Vk5qL1BjdDBjN1QxclFsTVdx?=
 =?utf-8?B?NVY1eE5KekNUQXFMa29yVDJFbXJvRFB3TkRTNlBudTVIT1dNTzFENGEwb2dw?=
 =?utf-8?B?Y1NQZzhVa2VkMTRZZXFFZ1Jxcm5ZR1pYcGhRU2psQU9Ta2JxSzNIbG55YXdB?=
 =?utf-8?B?dVZrY2NkRlhGSXlFZmpIeFY0cUovcldkWUdUMVpCSFZHSWR5UVBNK1QvbTZD?=
 =?utf-8?B?ZzM1RFRpd0JEUXVpUHNqYzBrakdyU3VyOVBuTWxvMmlqcHhqanNmUi9mWHpi?=
 =?utf-8?B?ZGZncFUwSXkrVHVUdUhoOG5XQ3ZqTXMyRk10MzZ2Z3NWdHg2R3VVaXM3TERj?=
 =?utf-8?B?elJ2cURhRUxIUHQwbE12RDc1aVpSMDJpZ29iSUNoZGZyY0h1VnNSeG9aUG5P?=
 =?utf-8?B?ZUNnWlZKOGtrQVZWem1ONzJya0lSZ1RyVDJsWWFNeDRCYUxIRU5XNnNIcFRD?=
 =?utf-8?B?WWRJa3JBSkRlaXJ5N3lpam5NNnZHVXVwZjY5dHNlakpSV3RQcUM3THhhTnA5?=
 =?utf-8?B?b3IyaENJQjJIRmZmWThvdUlic3h2elRibjZKT2IvR3ppWDNHNUNMQUEyNElR?=
 =?utf-8?B?aG44cENhTHBZWGJFbFhxZlNPZ3RsbTFZVGN1R2pYbXcvMld6TEJGWHJ4b1ps?=
 =?utf-8?B?bTgzY3IzS2FDeUFTM0RCV0k3QVRxQVM1RlhCQURKSWp2d1pwZGhYYTgxNGJX?=
 =?utf-8?B?RUVtS0NYZzlJYjZObk9UL1plbHU3L3NDZTBkSmV0WHJZV0VWR2UvRnFrVW9G?=
 =?utf-8?B?Q0xGdHRlcXBWUlA4VjVuZVJ5UzRybmlaa2VJNmU0Ylo3MWhzSmVyWnh2UU80?=
 =?utf-8?B?VTZCOXZIMFM1M0RCaVRlQk5wTnViVk1oOVYyK0ZXaVh6N2EwaGpXQ05BN202?=
 =?utf-8?B?MXVhcWZmY0hNbjREN29Wa2xmVmQzRy9HSXp2SmxaVFBwY3hXcDV4RFgrdTFM?=
 =?utf-8?B?MVBSODVpOGpnVXZBQjFidy9NV1ppL1FKMWNrVXBpN2VPbTdTOThpNkkxUThz?=
 =?utf-8?B?dEdCWVlLVGpOdTNIbm5zeHdHZWtRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ad7cfb-a61d-494b-dbf8-08d9e2ae1176
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:32:30.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em/GzGqGrD21u3ONiQ7vkwITz4nb89ZsbRBsyaILyit79gLnKjnvCAHt0lURbHrkh3xkOEULl2gkdR+jxF1PciOfbHKNwkClrbewn/iGw7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Fri, Jan 28, 2022 at 08:29:06PM +0100, Wolfram Sang napisał(a):
>
>> +	/* We want this to take priority over PSCI which has priority of 129. */
>> +	.priority = 130,
>
>Is it an idea to add a #define for the PSCI priority somewhere and use
>here the define + 1? Hardcoded priorities look a bit fragile to me.
>

You are right. Our priority policy for restart handlers isn't really
good and it is hard to choose right priority just about every time a
handler is added.

That being said, after reading Mark's argumentation, I now thing that
just being before PSCI is not enough. I think that a much higher
priority should be used as it is not normal situation that you would
like to run something before efi_reboot().

I would really still like to move the efi_reboot() to the
restart_handler even if you consider running some code before
efi_reboot() crazy. Since 255 is max priorty but using it basically
does not make sense (as this would let to the exact same situation we
have now).

I would use something like 250, or even 254, just to indicate that we
know that most certainly nothing should be run before efi_reboot(), but
still allow those silly people like me, to do what they want in their
system, without the need to run the custom kernel. I think we could even
add a proper comment, so it woudld become something like:

/**
  * If you are running UEFI based system, you most certainly should let
  * efi_reboot() do a reset for you. If you think you know better, we
  * leave you a window of opportunity here by not using maximal priorty
  * here.
  */
  .priority = 250,

What is the downside of doing that? That we will run through atomic
notfier chain instead of calling efi_reboot directly? Sure this is
slightly more complicated but it works on all our platforms and is
battle proven and we don't worry about that there. And the upside is
that we give people possibility to use their beloved mechanism if they
really like to. Because flexibility is a good thing.

What do you think?

Krzysztof
