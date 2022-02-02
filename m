Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B054A762B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbiBBQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:47:37 -0500
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com ([40.107.21.107]:19552
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346008AbiBBQrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmmjjdUcav44y4h1cIrHkwVpkNlabUEw3qOa1B5X8JbFEsstwLNood+/HM9nDiamAjA+MBShEFNBpEPUKKA15Nnkh9wwCCPCZK4ZgC0/Fe3XW3+dsmjOPlXmgto4/mPqf/fVu8u2W95hLHTnV7tCawR6CudnyCWxtccRhD7wKS4v+DuDejTOVghzbDbCeOavWMq7vYxYpDK0LA5h9FPN1ueRE8cpvcGiZABHZGjf0XMly1z7uMT/XIeqamcWkQyI/kxDsqVNy3zDz6M4PVW2299FmpeZYg3M6ABEJv5uCzTtBFpWJwUBTUNwREcohSk0CKWOtOq9+Wf7y5sKHyi6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymgwSVsL1SO5SCH6vaXQhQXcEaadpRwVOIVi+vrkBaQ=;
 b=C7TCZnjUTmkmWJbGiQO/tK29CmzXbhuywL6cOyW7K3KMTL5VSr8uJH8ONVuN/zleUG+cBpdip6pgbpnoPfhAPGRp5pRWGKrkhiKcMRNXHBxzJBSs+vuD94CMhPq2+RRnBI0b9lnFhl5HdHL4kys7Z7XqSWLZGT1EjuuVsfv7iloZYMlFvO/50OrnHJKwM4b4xm7YqFU3EwRqiQp6F00t15OUA+JLd7Bzq932JFuK/TqYarlubP2xhQOrNhoCA0jn2gPIkOFUGGrIkifP7u8EHLgvWyo0jGhE1DfefZBog7q3RVHk+A9Sx6dWYRwz3ous37l9PUVn6OrhUkoJo6H3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymgwSVsL1SO5SCH6vaXQhQXcEaadpRwVOIVi+vrkBaQ=;
 b=YbAdlcyLPVV8w3M3z4/vk64PVPuTyhZ+OW7c7vh+qY1nK7G4UObvq8RYOoFgML9727QKqsG6nK9zWXchA3CE83280x1ntkilJbxnhQxmAptQg9dTO8XXRj/31Ge1jqXjqp72E5eYhU+Rjkb3ZWwo3cXxsip8PMf/dzpoTGcj/N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by VI1PR0701MB7056.eurprd07.prod.outlook.com (2603:10a6:800:195::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.10; Wed, 2 Feb
 2022 16:47:33 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 16:47:33 +0000
Date:   Wed, 2 Feb 2022 17:47:26 +0100
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
Message-ID: <Yfq1no7OL9w21/kp@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
 <Yfp7wZXLKPIYBxmp@localhost.localdomain>
 <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
X-ClientProxiedBy: HE1P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::29)
 To DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e457b95-b0b5-4daa-de24-08d9e66bb558
X-MS-TrafficTypeDiagnostic: VI1PR0701MB7056:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0701MB705618894429EACB5F0C4D06EF279@VI1PR0701MB7056.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhrlygykYXoX56Xd57Zwz0c8905jCv05fvxAVTG85TWObMefwMz0dvWkxH7d2KexlATQd736BFHLfbukwDh+Tc1NPWJLj9eJj1M+sqVfq0F8owE0nRiS1zxoTXr/uVOJ695J+NPt1WbmHnpjnehSnOxtbrk/J25VWfWNxhU3fKgZ4KcbiZxi8dZdgi6Lk7ueFLvW0fa2Vgg3Cyz15GgnzZoLh4RITVGjRkp04lrHp2sHgDYvjisnS9sZlPoX5g3Yw75nFh1mHSrGCeGPddWexeZYv7JehnGpMMc3tTMt7UNqKFnsj+5U703uRKXYdh0WdFodopeBSM2NlNIqMcMWth7GKAIkngwb6DBfZHgBJRlOnXULdvxNCHGSy7SvUsxym6GIRYeJCOFE/zlQvKDylKdgbgG5/VxQfSprC9vN16lxJYcOhRTurp0jQe2qy6djF8w4tHnf1AcSpQDst1q6aGD30raPQZ9kROYiuCmASmuVXi8qODHhO37MuU/cBAX3oTktuJ/5DMb09YxA4HPEh0FRxzx1K6ZB7WRYL308hML/TKUujQvhXaBnA7GCQucs5KYr7g0U/knrmebNq1PrTtceZkoixYaPC0RpEU3Jzcf6W6fWc5Jrq8UsjNOrFowrXduCzHY+BWEvN4KoUi5DF5pKTTl7VCLkUYsptDOOdf3JLE0uncQaZVDthvP45gX8wu2+558X0iZcos+g3b6ydPSPzR6Yya3K9+NmNmAInnq6MMu0b7jB273nYj5SPPqA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(26005)(186003)(44832011)(54906003)(82960400001)(5660300002)(6916009)(316002)(6512007)(9686003)(86362001)(8676002)(6666004)(8936002)(83380400001)(52116002)(2906002)(508600001)(4326008)(6506007)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzk2bmZKN3hKTnRwZmlUQU5mUGIxSEk2UEY3TGZDc05FS1ZuYWZaMmViSUFN?=
 =?utf-8?B?dUUxaUJ2bFRkbGh5OHZvbnpGRnE5cndQeVVxTjBJVVRwVWY4eWEzMHlwNG8r?=
 =?utf-8?B?TXkxVkpqa2VqT2R3UWxnSnFUUG1uVHpoZzB5RklWMEtCd2prNC9aclJsdHZF?=
 =?utf-8?B?dmxCN2NiNERCOUN5MXZEa0VTUmwzdEpSS2Nxc1FpcGg1eXZuVVpCWUx2RUJh?=
 =?utf-8?B?L2hwM2NIMVg2TE9ZRkduMW5yU1NPWm5QcWM3UmlMWFNlZUlDUHhNZGMwVXlt?=
 =?utf-8?B?cEJzcW5GU0VrNHpjTVo5Y0JGTFAzWVBzV2FkbkdHbXk0bldaanUxSzhXNWtB?=
 =?utf-8?B?Rjg4SU9nTzc4NkEyV1VkSlRQdzZXR0UvQXRxM3dVYldIdDdCVEkyczNPL0pr?=
 =?utf-8?B?S0NiR1pMTjdwZ2JuYi84ZW9lM3ZPTTB2N2NtYUhTa0JISWlsV2JjRXNGTWNK?=
 =?utf-8?B?ZjBDSTg1ZE8yQSt5aWp1cmcva01ibERsOTgyT1JuODdDVVNuQnRIcTJNbnBW?=
 =?utf-8?B?THBzYjFtR09YVUlDdCtuMnk4NHA2SWtHMm1OQ1kyK1hqSmhYZXpUQVl6Tml2?=
 =?utf-8?B?Q0tpa1h1VVJFTnJSS0FPNTlKR3J2UStjRWxpVmlodkR1RytYMTlFNC9yK0o3?=
 =?utf-8?B?WlVBK2p1S3BQOUFpaU05Njg3YkNjMEVBOC85M2VnZ3E0emZKMHlDSzU5WHNv?=
 =?utf-8?B?UUlSQTlxR20ySHByakd0ckFOc3Y1YTh0YVhwYllJL2k1by90dFMyVjFpM2s2?=
 =?utf-8?B?Kzl2S2N1UC9IcldZaWloVjdudWpzc0ZHRldvMkdlbFFHQnh5ZFRLODM5S3dx?=
 =?utf-8?B?MXQ3aC9BVklSN2pjcDg2cU05YzNxT1FjaVpDSXlFQi9paVdMSGxEemdybEJV?=
 =?utf-8?B?YzZUM3dXSHBLVjJYaFJwQkFFUTVUQk92UFVqSFVMZDlOY21uZEdPYzEyeVgx?=
 =?utf-8?B?MGZxVG0vT2txbFdGM21RSlhJczF2dnlxTWk3SW9GT2x2YmYxRUdjeC9BZGJw?=
 =?utf-8?B?TjMyd0ZCVThXd01rN1FwTzhWWGtXRSsyaWQvbFJhc2p0YWFONjZJeGgrZXlm?=
 =?utf-8?B?Wng4cWNZdUpjOXFHaFFKa1JzelNocThXVG02NmY4WVBINlNjaGxod0s5NnQ0?=
 =?utf-8?B?SnJQZEhVRVhHYWxzR2RjOGRDYmRMNk1QeFpZRGxuWE5TN0VNQllFMnc2VlpE?=
 =?utf-8?B?cEM3ODJlTXFYVTV3M29jVHdCV0Y2Rk1ZYXNyUGpmMHljOWZpRXJHS0NOSnk2?=
 =?utf-8?B?dHo5Nm9lZ1hscVJ0VXl5d3Q0L1JhR1R2Y3ZuM1Y5Z3hHRTY1VHNWZ2UyOXlG?=
 =?utf-8?B?V1kzSGw0ZlpYZ1g3MlZnTzhnL1RBOGhMK0JmSzVQeEdrdENPZzE3QXY3Qmlx?=
 =?utf-8?B?RnlZVHBpWGdTekZNa2hVTXExUHYrakMvcGd4dHMvbTI3aHExeG1mc1l6VFdn?=
 =?utf-8?B?cnRDZ01YczEra1c0QitnQ25KelFzNUpKZjF0L0lmRWo3SW5QRXNvL0JJZkJO?=
 =?utf-8?B?cjlROVVPTWNZUS80N3JBWUgraE14ZCtQdk11SnkzN01TRnRodDdKNjNEcTBu?=
 =?utf-8?B?N1NWYlU1cW9SaUxDOWFiaXlYdjh1WjdpVUVFSnJwR2M2bDRlRDZNcFhJeHJI?=
 =?utf-8?B?YUxndlowdzRQUDFMZmsrMSt5QVh2ZldyRGtSZUZtMVZrQU1ReWtLWkI3eldD?=
 =?utf-8?B?OVFKalFRNlpQblFxTWRmZldwNE5HcmJjcm5CeWc1NmRkdFY5SWExKzR6WFp3?=
 =?utf-8?B?elBtWEtiY0lLTGJjVi96bjhRNXppejFBYnl6c054OWtCT2NiaXhoc0JGUTlp?=
 =?utf-8?B?cGo2WTRVZ2RBTm5SUlo3RVlSeGVSMUJiZG43S3pDMkV0ODNySitmbzlvQmIz?=
 =?utf-8?B?cDd5VEtweFR4Um5BL3FuYUtqL1pwbUtsU2tEMHI2NUNSMWtqUWpJK1VPeVY4?=
 =?utf-8?B?STd3OFowaGc4MnlxRy9DTXhhNldvWWduaStLY082cTJhSUdhYlpTQzFLVHlV?=
 =?utf-8?B?Ym01VHR6T0RzeEh2YWMwVlRHNWFVWmdZTUdlVmNiTTN3QnBwT1ZMK3R2T1g1?=
 =?utf-8?B?WGJyTzErcXNKSktZMVZFM0dVOWt2RXVvMUhQbWc2MzVRMEZHRW5BNjN5cVRs?=
 =?utf-8?B?bkZhRi8xZVptakJ4YXlqRHo0NUVHY0hvcEZBd1pPSkVFdXkzQU5LbjF0bWE1?=
 =?utf-8?B?M05aczRCRmt3eUZTc0E2UittL1V1S3g2dkgxZzY0THlTL2tzeGxQc0FWb2ln?=
 =?utf-8?B?YWJvRmhIb3l1djZHRWsydU1vc1Z3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e457b95-b0b5-4daa-de24-08d9e66bb558
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 16:47:33.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFPsjiyHWJrJQOlwPMthTt1K+obJ5dYFzC7dZUhvNFFuKVKd8VGMfHJOCbrCDzPft9SoTiKWzh6sYsPBzDIESXNeJQV1xSWeMYNbznzvfvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wed, Feb 02, 2022 at 03:01:37PM +0100, Ard Biesheuvel napisał(a):
>On Wed, 2 Feb 2022 at 13:41, Krzysztof Adamski
><krzysztof.adamski@nokia.com> wrote:
>>
>> Dnia Tue, Feb 01, 2022 at 01:58:29PM +0000, Mark Rutland napisał(a):
>> >> If we use the restart handlers only to reset the system, this is indeed
>> >> true. But technically, restart handlers support the scenario where the
>> >> handler does some action that does not do reset of the whole system and
>> >> passes the control further down the chain, eventually reaching a handler
>> >> that will reset the whole system.
>> >> This can be done on non-uefi systems without problems but it doesn't
>> >> work on UEFI bases arm64 systems and this is a problem for us.
>> >>
>> >> In other words, I would like to be able to run a restart handler on EFI
>> >> based ARM64 systems, just like I can on other systems, just for its
>> >> "side effects", not to do the actual reboot. Current code disables this
>> >> possibility on an ARM64 EFI system.
>> >
>> >It sounds like two things are being conflated here:
>> >
>> >1) A *notification* that a restart will subsequently occur.
>> >2) A *request* to initiate a restart.
>> >
>> >IIUC (1) is supposed to be handled by the existing reboot notifier mechanism
>> >(see the reboot_notifier_list) which *is* invoked prior to the EFI reboot
>> >today.
>> >
>> >IMO, using restart handlers as notifiers is an abuse of the interface, and
>> >that's the fundamental problem.
>> >
>> >What am I missing?
>>
>> You are completly right. It is possible that I would like to be able to
>> *abuse* the restart handlers as notifier. You are right that we have a
>> reboot_notifier but it is not good enough for my usecase - it is only
>> called, well, on reboot. It is not called in case of emergency_restart()
>> so in case of a panic, this won't happen. It also is called much earlier
>> than restart handlers which also makes a difference in some cases. So I
>> see no other choice than to abuse the restart_handler mechanism for that.
>>
>
>Why would such a platform implement ResetSystem() in the first place
>if it cannot be used?
>
>So the right solution here is for the firmware to publish a
>EFI_RT_PROPERTIES_TABLE that describes ResetSystem() as unsupported,
>and Linux will happily disregard it and try something else.

The firmware is generic but the problem is specific to one usecase of
such a platform. In other words, the firmware is written for the SoC and
it does not know about other parts on the board, outside of SoC. It
doesn't make much sense to provide the support for such custom device in
the firmware.

Please also note that the ResetSystem is supported. As I said, the
normal, typical reset is done via EFI, via ResetSystem. Ony if you have
a special case, where not only SoC, but also some other components in
the system have to be reset, then you want to change the reset type.

We also have one case of abusing the restart_handler as restart notifier
in the kernel in the form of drivers/mmc/core/pwrseq_emmc.c. I would
just like to be able to do this also on EFI based ARM64 systems. Is that
crazy? :)

>Btw please cc linux-efi@vger.kernel.org and myself on future EFI
>issues. I found this thread by accident.

Sure, sorry for that.

Krzysztof
