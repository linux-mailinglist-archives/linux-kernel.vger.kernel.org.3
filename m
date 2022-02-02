Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E84A7720
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbiBBRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:52:22 -0500
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:61250
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346366AbiBBRwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp7biC+ugE0H6BI0OgRQe0gNYrNT/oj8MLM70Ixmj0p/bNla0jUj2PlWQVWIdK8vZnV9rklsYtpvocgJswf3Czvo1yGocJ0EZ5rJjSLV4WeGRMtfol9bT7tHCmzfSikG/eJGchkU3T9rHcPuaNNtmawbsuIIGSfx372QYlYGkDBCP/Q1RjbZv3twkKrGJN1jXdnWHrb9z8U/ROPJ/NZrGcIj9z9lOr39DHeSfRLNyA8G0uv7mVbtB+Njlt7sO6v0C0JUc1ZztQCYdnY68WADHiN76+qzInpSr+JHm8KMqQR4pDz36gud9l0QaK7DBK4zZRAF6Zx1FzkhCjLswkPvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+f6I9jWg82oiXTIiTDru6eHwgIXZSXfk7HqDYjbQkk=;
 b=c/MxfBLO3dzaUPs8ueSBXDbtp0s3pmDGS1x8jKqtKFLUhRI3VUq1s3vaWvAAW9A/wM/FIVOXo0CrD1Lbd0X/gL3JUq20AMT8PX8dqh5NKNttXJMf9szNCeiJURYm62hv9gsHbIbv1wW1vcASLcLDG0P4297fexTXgf1MGzdDsGDf7T2dGTtogXa6tnWa3jUO7KmtPyGr1g0GrBKyI8fs/fuX/R/PlY+pLawy+TpX9tdx1jO6I+KP8ha38zp83z5oeXHBrBDMl7XcMDtRiVmRY/W5K/mAJsqDZuO7WWB3f6qRmUtVcW+AN+sLntmJk+vdR+wK8oNjwdeaQg3/PrC+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+f6I9jWg82oiXTIiTDru6eHwgIXZSXfk7HqDYjbQkk=;
 b=ChWg0feoRM/nUUOkkAj9L8OzdI5Uppb0z0sXBS5oLJZiEdi8IbZGsctpe2H+LpnetmBxv1p007cIU/LJo3xqtyShdW3B0ZHimnvqgdX+SgYXriEi6XoKSVY0RQ0SW7WRF4mNdomBEzD4O7jLBr/jV+pEVh9ZsGhS3n8vlbkmjOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by AM0PR0702MB3745.eurprd07.prod.outlook.com (2603:10a6:208:16::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Wed, 2 Feb
 2022 17:52:16 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:52:16 +0000
Date:   Wed, 2 Feb 2022 18:52:10 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfrEynukTySY0FhE@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <Yfp7wZXLKPIYBxmp@localhost.localdomain>
 <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
 <Yfq1no7OL9w21/kp@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yfq1no7OL9w21/kp@localhost.localdomain>
X-ClientProxiedBy: HE1P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::13)
 To DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5351c2-5212-434e-4744-08d9e674c035
X-MS-TrafficTypeDiagnostic: AM0PR0702MB3745:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0702MB374592873CF5A6BE5E4C0AD9EF279@AM0PR0702MB3745.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9t6eeCliBUvin4+A2n0BY8UR8gfpx6o/czi6YnR4ZAeTUxPM/WOjfWmAP1a5kT5x7UYggfwJ/0hunxr+Va36VqnFHc7ZTDwEhd23Ji8sMcumqP0fCXhOX7U0x4Wa5WDvP+Gq2F3XvE2V8nj0fIS1vV57tkDNm98TmMS62oOItOyASIdsGj91BWzyOdNWOTu8KGPdvMHsyur8R+0TVqVtBTjEc32tvygkhx29YNp4KDnqfudqRVNhG9eEwC+6WTxQh91D7ZVv3OR6SvcYY8LqXsTHypn+EAscR4RNr2faMOqrvW4NxXl7YLz5rXSz8uJWjYysZUCYjbcCzvoQWXaFfhreZoIs8xsmsGLcuRxAX5ER+/UyZglRJT+kjJQPqIlqriGJRh+3Pi09zz1XdnV82glrhGrdSBax/ahWa3YS2bG+IIZV4Vk5+pfUE2xBJMeeT8crVaEg1n/X5y1e54mKSjkwOwNf++M8iPA3xdkEuro7hAQsDRYBYA2rNOrrYCMOqn0Vg65UHOrZeKQhALNcCQJ2u18t6dI0WE8COXuOzcHGh1s4kI9JLiZFE2ha5/d+KlY27W2Fin+rG6zGq9cVsvXWfBTLkj5nviL57004YK8547r6q7kv2V01xqg+PVd3YYiet7IN4FdCS2tD8q1KqJDLakH6RHHWqG+xk/UkFDLMRIeoYJrdu8+2zrBiQfWuSiHfnMkTKXFNmN2aI+6rdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38350700002)(66946007)(54906003)(38100700002)(6916009)(8936002)(66556008)(186003)(316002)(86362001)(83380400001)(6512007)(9686003)(66476007)(6486002)(508600001)(26005)(82960400001)(8676002)(2906002)(6506007)(6666004)(44832011)(52116002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDNsQ1dyUEJTbG0zMWVobmFRanN2dHU0c0p1b3NBclRvbC8yU0hObStyVk5N?=
 =?utf-8?B?K2xTQ1J5WkNzSWhLamR2MkE3ZEpRUmpLM2lOVUxJNWN4ZnBEWS9wSnBrdFdu?=
 =?utf-8?B?cDEyRmg0VENrKytra242UXBRd1pyOXRrblg1UTBPSmJKNWZ2Nm1jZE00NGVR?=
 =?utf-8?B?bzZtVDAza3FuVjYrNUNRa1pEZ1hTeXpKRGJ0RkkvdWwrdU9wb1NQZmZZeG10?=
 =?utf-8?B?TURFcitRRzBTSEdtbUpBclVha3hqUHVRYTVHZFpJSHVTeENYWHJPRzIyb0hR?=
 =?utf-8?B?ZGUzbmZqcVJZekhjelQ2VGFibVVkdVdsMHRTZjdqaktVbVVpRXdjVTBuWWda?=
 =?utf-8?B?WWJ6Mis5cDBpSHNiQ2UzYkJCZFlVUnlPQWo1Qkt2TkM3V3NpZ0l1WEJWTVNs?=
 =?utf-8?B?cUNHaCtZVEt3Vk9rL3RjdmxuZ2NDa1dScXZaWmMzSHFrSjJJZVBDcDdFRXB3?=
 =?utf-8?B?VU9DWWVqRVV5QmtyVTBYM2tBTzNHY3dXUEhLbG1UWGxFRmVIcGUzVys5THY0?=
 =?utf-8?B?dldEd3JVVGRJaXgreDZXR0NlRkpNTzZ0WGdHalJWTmswTlZGN0JHdnNCYkJ2?=
 =?utf-8?B?RnpqNHhYUE01RithTDNDTlNLVjdpc1luRGZMNm1mcFFWaUVZNW9uUXdaWWh4?=
 =?utf-8?B?d1JscTNvN212OVI3aFR6cUU4WWlPVElNeDdvclM0aThTNE9PM0ZmRHVMclhZ?=
 =?utf-8?B?ei9iZHROQzhjSG12aGEyNmFMd0hTT1FMNXVUL3J1K3YzZm01ZGUzWGZVWjFQ?=
 =?utf-8?B?b0djNE5acUx2UEV0bVp4VFNTcVNCVWJvWHdFdG4vSlU3M2ZBL2JLZGI4K0xU?=
 =?utf-8?B?TWQyTlo5MjRJMEpvdHVJd2ZIRnFOTnAvVStSbmxJMGtSTTRqZ1RtcFFuc045?=
 =?utf-8?B?dVdpWG05WGFadlgwU2pXL1VyMDZ5RWhrTUxlZmJ4MmV2TGxWOUNaMDF0YWUz?=
 =?utf-8?B?NitGMHhva2ZJaFNocTljMzlvN3pZaHNPWElocGhWSUZzQngwU2ttVVI5ZFVr?=
 =?utf-8?B?clcrQzBBSkZRTkVUa09IVDc4VFIzbU5JSXpuV1FxbmZuSTA1NzhlTGl6NEFF?=
 =?utf-8?B?VTkyS2NPZ3B6ekRBNmdLNjNCRThXYk5GamJtb2xSZFlHM0R1MEQ0YnNGeU1V?=
 =?utf-8?B?ZXc2WkUrRENMOEM0T2xFamVISUEyWEI5WlpkTEdJNWNHVXNKb1dSc3VEMGFy?=
 =?utf-8?B?T2RSU0I3cUhIM1IzcFRPRWQzSUptdnZaNDRQa3NtclZ0ajlEU2V3ZSt0OVN6?=
 =?utf-8?B?Zzd5QzJSbjNiYmRLRlR5WjdPWmU5WFBlSDZIWHBTS3hNTm5DNWxnQTVDc2dR?=
 =?utf-8?B?Qk04YmhHT084MFN2WHc1NTNNUm43bm9qc05Ea3l2VmdmWXE5aXRDTmNwblZ5?=
 =?utf-8?B?N3JOQm5YNXhzbVM5NjhUUDhvMzFLcHZlbVpQb3YvdWdQamxoWmJocWVnaGFO?=
 =?utf-8?B?VkY1a05IWlNyNGVKTWtjSGU4ODFUWVBvMEN3Q2NBWXdFK2ZpTE9GZTR3OSs0?=
 =?utf-8?B?eW1LZFVOYnR0STVsdEE0cHdwMmdTeXRqNU05WDJ1K3Nwb0JpalhmNVFDNzlK?=
 =?utf-8?B?QVdmVVpXT2ZIbmFsallHaXFpY3hFQnIveFVkU1NYckxvVEF2azZnczRUeVBo?=
 =?utf-8?B?bmJXdjZMK3VFYXpJejJrZDVWR05BRHlUc0pzSDVBazRwaG1xUE5FNmtZSTZM?=
 =?utf-8?B?Y0VOa2VHV1RDemZKOFJtcHFZTm0vVythd2JQb2hrNVZSNXdSb1RiN3AxUDN0?=
 =?utf-8?B?NXBSNzhPZXJIYXBPQjZ0OE1OcjlGQVhUaWZuTkxHd0xEMS9yMGZsRGJNVkFF?=
 =?utf-8?B?VVhGMlNHVURzZmFscUErSmNDNEd1S2R3SkJBZXZZbVlad1NBMHpiWVpJWFdk?=
 =?utf-8?B?ZVo4SGcyamVRcnRUbkdWZTluWGVPclAwWTZQd3h0V0ROVFhrWGU4YnFUKzBo?=
 =?utf-8?B?Q3B0M3hUa0lNd05QSEFBVzlhd1phZTdMRi9FUnMremlqWDF1SnFMYlpiNXFu?=
 =?utf-8?B?d3l3OUVEejVSa210SXhOYk56dGxDVU83TkZaK3hpZ21WYUdpc2pHQUFLNVM4?=
 =?utf-8?B?Q1EvTmxrdXNlNGRENVFKZVBhYktGdzlLTFpOSFVsV1JOTHpDeXdFSitFNFJC?=
 =?utf-8?B?dWdnQnVlRXptQm5VRXpvSm1yOGluUlFVdHNXNzNBR0lxUUtZa0FUeHZpcDhI?=
 =?utf-8?B?c1lEOWhuSnlQMlZBcmJyNGdPQVpUejZDUDNQci82Z2ZiZTdyUUluSEpCcUxn?=
 =?utf-8?B?cStjaGxPNU80OFh5NWtRRWNQVUtnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5351c2-5212-434e-4744-08d9e674c035
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:52:16.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGPuOO4E1v76k4s/pSsX2JqSlfKKPNnea3rtVD+YO33MYhLGzG3iQWhD9nlYIhMjOdpxNCHRnkdLQEAPJ3tttKe8zs4FR1halc8COMeXjiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0702MB3745
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wed, Feb 02, 2022 at 05:47:33PM +0100, Krzysztof Adamski napisał(a):
>Dnia Wed, Feb 02, 2022 at 03:01:37PM +0100, Ard Biesheuvel napisał(a):
>>On Wed, 2 Feb 2022 at 13:41, Krzysztof Adamski
>><krzysztof.adamski@nokia.com> wrote:
>>>
>>>Dnia Tue, Feb 01, 2022 at 01:58:29PM +0000, Mark Rutland napisał(a):
>>>>> If we use the restart handlers only to reset the system, this is indeed
>>>>> true. But technically, restart handlers support the scenario where the
>>>>> handler does some action that does not do reset of the whole system and
>>>>> passes the control further down the chain, eventually reaching a handler
>>>>> that will reset the whole system.
>>>>> This can be done on non-uefi systems without problems but it doesn't
>>>>> work on UEFI bases arm64 systems and this is a problem for us.
>>>>>
>>>>> In other words, I would like to be able to run a restart handler on EFI
>>>>> based ARM64 systems, just like I can on other systems, just for its
>>>>> "side effects", not to do the actual reboot. Current code disables this
>>>>> possibility on an ARM64 EFI system.
>>>>
>>>>It sounds like two things are being conflated here:
>>>>
>>>>1) A *notification* that a restart will subsequently occur.
>>>>2) A *request* to initiate a restart.
>>>>
>>>>IIUC (1) is supposed to be handled by the existing reboot notifier mechanism
>>>>(see the reboot_notifier_list) which *is* invoked prior to the EFI reboot
>>>>today.
>>>>
>>>>IMO, using restart handlers as notifiers is an abuse of the interface, and
>>>>that's the fundamental problem.
>>>>
>>>>What am I missing?
>>>
>>>You are completly right. It is possible that I would like to be able to
>>>*abuse* the restart handlers as notifier. You are right that we have a
>>>reboot_notifier but it is not good enough for my usecase - it is only
>>>called, well, on reboot. It is not called in case of emergency_restart()
>>>so in case of a panic, this won't happen. It also is called much earlier
>>>than restart handlers which also makes a difference in some cases. So I
>>>see no other choice than to abuse the restart_handler mechanism for that.
>>>
>>
>>Why would such a platform implement ResetSystem() in the first place
>>if it cannot be used?
>>
>>So the right solution here is for the firmware to publish a
>>EFI_RT_PROPERTIES_TABLE that describes ResetSystem() as unsupported,
>>and Linux will happily disregard it and try something else.
>
>The firmware is generic but the problem is specific to one usecase of
>such a platform. In other words, the firmware is written for the SoC and
>it does not know about other parts on the board, outside of SoC. It
>doesn't make much sense to provide the support for such custom device in
>the firmware.
>
>Please also note that the ResetSystem is supported. As I said, the
>normal, typical reset is done via EFI, via ResetSystem. Ony if you have
>a special case, where not only SoC, but also some other components in
>the system have to be reset, then you want to change the reset type.
>
>We also have one case of abusing the restart_handler as restart notifier
>in the kernel in the form of drivers/mmc/core/pwrseq_emmc.c. I would
>just like to be able to do this also on EFI based ARM64 systems. Is that
>crazy? :)

Sorry, I forgot to mention another argument - doing that in the firmware
is SoC specific while doing that in the kernel is platform agnostic. We
use the same code on different platforms, architectures, etc.

Now, I don't understand why it is sane to have this functionality on
other archs, when we use PSCI or whatever else reset mechanism, but it
isn't if we use EFI.

For the notification purpose, we acknowledge it might be beneficial to
notify some code about the reboot (this is why we have the
reboot_notifier functionality) but having such a notifier on reset,
instead of reboot (i.e. at the end of the whole process and at all
possible cases where we reset our machine), seems strange. I don't get
it.

Krzysztof
