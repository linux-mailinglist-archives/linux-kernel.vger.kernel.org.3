Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B154A70ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiBBMko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:40:44 -0500
Received: from mail-am6eur05on2107.outbound.protection.outlook.com ([40.107.22.107]:36864
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231748AbiBBMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:40:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShAvwbMt8tbilz5c4hL1F60Y/ngMOlLWKuq3Vgcd/KUJHzNRU3qpcjBgRvCRw3xKAPMHmRUaqNdcOnlnucgHkqupoP8JjsdT1fEQfKmcL8wly9jtBCm+tiqgtIsKb24VUZb2f/AJCg3FYc8kKZGOy2AGfCKGXh5nyZ71VVdqxwDjSAQUP/sdZsVO6Rz45wGVh64FrTDzkXoCQVGwHBWcZ4pqH8NYa9If5zvGXXr/gGoJh6SD+aKs1oFRt9vAUw8x5MuR0+/k3mOPkzTAHM1nF7bgCvkMyKqc+YnS8MK9vI7YKqlU6GzF9lvLqdgQE5AeeLvVGs7Mmdk4/g/eeub9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR48XsqDO0baRp2K4yyIJhX01sdClYNldCcnt9+eKa4=;
 b=cHvlWUWkSFUh09sRWPWYp9r4xYywhE0AoIY47a8ErDmBTiZgRgwsft00uOfPGlrl2guIkieBmIw8vohABqFC91yJU52EklZkANjC9CVmIG5Fv6VgDaEtV2A6p5kyYbZeFBH4KWpgmDyBF4yqgbMOppOB9UGF0/KxzBrypG7sHicIQsJz3IkPF8RDVH62yiuio3sgFKQp4flfeiKGirES0mzhKH1rcEExxDVEklqD1/orOapVVT3Cww/I7/aReTpCgpF+A/DogKa6opYtKocYoiSUeK432crO3lDlaMUi1BrGVkaH/kXCCF639FGEiCz1ImbBJXwF1wA4xE+c+n0s8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR48XsqDO0baRp2K4yyIJhX01sdClYNldCcnt9+eKa4=;
 b=KygJ9WwmBOtbIpyD1U5rlel7X2z1gm++j9IZIjPWEnlQqF+bsfp9T/uSxdlxaTh5C60J9tyrApmNQbsf5Pm/Aid2Mz5+BFx3jp3GwahkZhaqrSFvxqjyMn803eBlUgfOZZIVFncIcxtaaCfPfCK6npmB1D/E+FFCHPf/p7LPwnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by PR1PR07MB4939.eurprd07.prod.outlook.com (2603:10a6:102:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 12:40:41 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 12:40:41 +0000
Date:   Wed, 2 Feb 2022 13:40:33 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <Yfp7wZXLKPIYBxmp@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
 <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
X-ClientProxiedBy: HE1P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::24)
 To DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ddc1cf-4b22-4bb9-4a8f-08d9e64938ac
X-MS-TrafficTypeDiagnostic: PR1PR07MB4939:EE_
X-Microsoft-Antispam-PRVS: <PR1PR07MB49397BC5610D20F3514C8212EF279@PR1PR07MB4939.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5NfzbLGBgtlmBPSO+Wk7aTB0Nxk7l74EY0cngBU7x79sonz4YhaAr0fXcsGAFnGXJ8Qwit+lpEDSu5oFw1P1sH3AxQcQM+XBEvuf0EmkYeOvIrYDeUCVDKhxrY9SSH0bb4rz5PC7T2+r8u2Xmf4xdyg17IcXWdK5WhTJnqRcG5F3chrCD+9CptOVq9Se0YANKxb0TZZmjmImYIF6DVwZh0kMmXP13ssXuWHXW8nuxYnBdJNKgw6aw43bVoi5EwN5CLZDZG2C+qRoURLsA5rYCkdjv+d13NGU2UQEWYNw7od4MA56Q08ng1Cxn9jo/Jurg2bpEeMrgQRepAwJ1w2y1f6iL7ZyjY7Rs1Wbl+OEHPXygy2+yrOoBhM6YHiXQ5t4lEKQ9UzXjVlS6feSrwwgS+v2Derv7qaxNP87DSre6gD6zD+4VT5mc+cadmUkyNcdaq84gBhvmW2wqSurbfiAQLUlRCXfHi8TEhieZRQtLFb7p9aD6KkToPe6HSyrzaKwIRVaV5qP0wb7AVBLkve0kgEiPRWrseyaY2OUIUN3lUxCkVuOGOecqag4PuxMF0gm6FftE7WGhIcSb8z8/U0oE9PBZoZazVprkChnd692t+RdHVF69vK8BqhABDHvrZSpXK4WCW69LZ34bJnnQWI4mNBzeXBgtWwGLVwU+ftHLKwVOi8wOuYq0B88k4bm98jI6BguK+zXcEAZrlDpFDp44ikw/YZbqlwN90oOerw4fed5RzsaxjGuJm8vdNMaofn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(8676002)(66946007)(66556008)(66476007)(4326008)(8936002)(6512007)(9686003)(82960400001)(44832011)(186003)(6506007)(6666004)(5660300002)(316002)(2906002)(6916009)(508600001)(26005)(83380400001)(52116002)(86362001)(54906003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJHVUNMMzV1dlhOSkgxZ05zcEJPQnFQczA5ZnQ4b0F3TEJkQk5KVnNUVjk3?=
 =?utf-8?B?QkQ5bE1mMlozTnFUZTZUaUNCZVRDSHExeWJjNWdLNFhQQWpaS04xVTA5S2pY?=
 =?utf-8?B?YkVQMzF0NlRnUEtXbWIwMzFsQ3VrdDIzZ3FabXIxZ2RCUWY3Y3pSMSswNk55?=
 =?utf-8?B?S2JZYklheElwcWpTWFRrdy9ESHUvcUFqMWJOMy9xbUtzUVJXN2pXdWMxbGc1?=
 =?utf-8?B?S1BBVFArWHFna1M4aStHbWhVV0tMdkFtUUx6eG53OFIvVEYvaEorazVpK0h5?=
 =?utf-8?B?aTEwcWxiOEx6d2s3bEo5ak5CQ0hiRW51RVJ3T1l5bHIxK0VpVXh5WU1zbDBs?=
 =?utf-8?B?K3ZXQjZibW9JZkhTeXdTeTl0bnFlejIra3dKc0svdFhadWg3RFRYUENFTFFS?=
 =?utf-8?B?eGJ1eWJrc1VtOGxPRG9VRU0zalpxb1JrR3lFU3EycWF1L0FxWU5OU2JFVk5u?=
 =?utf-8?B?SndMVkdTbnQyQ2FEdlJMeWRBbmRDSFl0MXd6NC8zdzU0cXZ5eVY4OVRwc0JX?=
 =?utf-8?B?NlVJZ3hTRXVaa1NTTU1oZXcyRzFiQU43aHA3QnpBYWRySi9CRjYvektwVm9p?=
 =?utf-8?B?UmVOU0NEY0hOWjZ4Y0hHR0V5TlltZE5Bd1Zmb2cxdTZIWW52ZVdDbXkxTjR1?=
 =?utf-8?B?VkQ3dit2OHVoemZHYmtGbld6QStZT05sd1lyY0FBZEZvSS8vRTRXTHBhUUpD?=
 =?utf-8?B?dGxQMFNUYUJMMFFvZGdxT1lEa1YzZHdxYzYrdmFVOWFWbHljR3VmN0VYazk4?=
 =?utf-8?B?MUdiSjlnK2ZudUM3bVhFRVlHZzRQL2p1UmhRbDNvMUtWM3lHTEsycmNzb1U0?=
 =?utf-8?B?WUVka1pIai9TTUVndjNvQ0hzbVB6eVJCMWYwMjF3blRhSUFCSUMzZ0NaN0pX?=
 =?utf-8?B?YzNEYUxFQnZITW5JS1luenhpQ21rY215bndvSDhVaFZJdERwVWZ6cXRjSjNU?=
 =?utf-8?B?ZVRITi9LQ3JZWTRuS0hQT3Z1czJWZU1JNWFIZEhQc00wU0pCRUlLWUtKeE52?=
 =?utf-8?B?RjlWbUZDcmtyZytYa2pwVXcyQlppZVVtMExZdjc4aGFRV0FoQlR0dW40Ly9x?=
 =?utf-8?B?enVqVnNxL3BaME9YZUpRanM5alFCMWxUMjRvRk1zS21PRzNlcXZmTnd0MVls?=
 =?utf-8?B?NnBNVmxmWmd1SXA3TDJaWTh3THZzRDNvVHdjNlV6TGhWU1FtQW0wamdqK09w?=
 =?utf-8?B?YWo1OTE2UUphbWVwTUJnbVRGWFRaUURJU1FOUmVIK3MvSnNtS1plWjIyR0to?=
 =?utf-8?B?eXF1eVRtcjVKN2xLRkRJZVFtNEQ3aU0rdmQrZDhpTDdLWXNmU2o1aVpnMWIv?=
 =?utf-8?B?OHNpc1FxNnZ0aVd5WFpqOEpKWHlJY2xodThmOEhjNWkvV0dwSFNIUDh3WXBN?=
 =?utf-8?B?MmVIejJWY3hFYk9Obk1XMytCbmY5SzVrbVdoWGVUYlZRR3VVSjNCUzFWdHo2?=
 =?utf-8?B?dG11bjgvUy96TnVyZWc5NGhoOWo4anBLWFErOGlydERIa09qVnI4eTlyUFVh?=
 =?utf-8?B?eVdVWm1yZFVIbWxkZWttWTFGVXZPc1RYWC9YYy9yc01ZNXN5SFQzZnRmaVBr?=
 =?utf-8?B?TnNnZzlFd044VlhMU2txWUNnRFowSXZwTytMZGJiSUN3S1hFUkVCTnZvKzln?=
 =?utf-8?B?d2ZpOW9RQys2MDdpb3czRDBQQ2ZHZS9qN1JCL0lRZ2RrdW9xclMvd3laVWU0?=
 =?utf-8?B?NU9TaFhkdnNROFdZS1RvdlVld3ZUTHErSVFMMUZOOWpFY2d5SmZTRGN3QmRQ?=
 =?utf-8?B?SDJzemFGMWwzRE9NQ2lpcERyaS8rWFM4cFVXcjJSQTZoSkFOd2QrSVh2bVdm?=
 =?utf-8?B?SjRlQWEreG5TaUJWZHlBZ1Y3dkV4cGZkWlgyRDBRVUVCaWRKNEtyV2VpQ2U3?=
 =?utf-8?B?alhtMUlXbkVRWXhJL3luSlVXbjI0ckZqb3N2SlZLQWJkU0RWVU4wN00rTGZi?=
 =?utf-8?B?Myswem94SXA3dWxCYy95TWMwUjUvZlJzLzBsa2N1a1JtVHMrMEJMeXd4cGdm?=
 =?utf-8?B?dmxTMnpNWUM3NkdjWTRMMUZPTS9JYlFuTUdHc1l5eGFKZThBNkw3KzJzRjRZ?=
 =?utf-8?B?Z1B5VDBBbnZTTzRGdWRydG9MamEwWDIwa1IvdG8vdlNiRWE4QjFIR09hWXdk?=
 =?utf-8?B?MS9sWG5CdzdFMGRKUGJDQW5ycXkwU2o5Mk83ZWJOcUFIN2lGcllOc1BjZXNG?=
 =?utf-8?B?N1d5b0JsMzJNTFVueFNXRCtWN3dmNGdFZ29LOUVqUXZvbFovcWd3WWdpNTIz?=
 =?utf-8?B?Q2E0SUNIZlp5L1BWWXpLcXJ2eVp3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ddc1cf-4b22-4bb9-4a8f-08d9e64938ac
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 12:40:40.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u49gY+YvrZiF0/gzNAmWJFHFkZpCBkR1RzmcegeCAOJ8n1EKONVR53p+wE7nGMu0fMOHWme9OB0wquEUX9CjB57xS7fkezJfQwCzR9CDbUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR07MB4939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Tue, Feb 01, 2022 at 01:58:29PM +0000, Mark Rutland napisał(a):
>> If we use the restart handlers only to reset the system, this is indeed
>> true. But technically, restart handlers support the scenario where the
>> handler does some action that does not do reset of the whole system and
>> passes the control further down the chain, eventually reaching a handler
>> that will reset the whole system.
>> This can be done on non-uefi systems without problems but it doesn't
>> work on UEFI bases arm64 systems and this is a problem for us.
>>
>> In other words, I would like to be able to run a restart handler on EFI
>> based ARM64 systems, just like I can on other systems, just for its
>> "side effects", not to do the actual reboot. Current code disables this
>> possibility on an ARM64 EFI system.
>
>It sounds like two things are being conflated here:
>
>1) A *notification* that a restart will subsequently occur.
>2) A *request* to initiate a restart.
>
>IIUC (1) is supposed to be handled by the existing reboot notifier mechanism
>(see the reboot_notifier_list) which *is* invoked prior to the EFI reboot
>today.
>
>IMO, using restart handlers as notifiers is an abuse of the interface, and
>that's the fundamental problem.
>
>What am I missing?

You are completly right. It is possible that I would like to be able to
*abuse* the restart handlers as notifier. You are right that we have a
reboot_notifier but it is not good enough for my usecase - it is only
called, well, on reboot. It is not called in case of emergency_restart()
so in case of a panic, this won't happen. It also is called much earlier
than restart handlers which also makes a difference in some cases. So I
see no other choice than to abuse the restart_handler mechanism for that.

So, ideally, for that usecase, we would need a restart notifier that is
called immidietely before restart handlers, is basically done in the
same way as reset_handlers mechanism, but would simply be called
differently and would use separate chain. But does it make sense to have
that?

Apart from this simple usecase that I have focused so far, I also have
another one that I didn't mention before. As you know, even efi_reboot()
has several types of resets it can trigger (warm, cold), depending on
how "deep" the reset should be. In some cases, however, we have a need to
escalate the reset/reboot even deeper, into full board reset which is
performed by an external component - this cannot be done from EFI
firmware so we have to do this from Linux, before efi_reboot is called.
This has to be done also in case of a emergency_restart(). And obviosly
we do not call efi_reboot() in this case, as the whole board goes into
reset, including the CPU. This reset is, however, conditional -
it does not replace the efi_reboot() which is still used in most cases.
We use restart_handlers also for that, but this doesn't work on ARM64 with
EFI.

>> > Otherwise this patch is making this logic more complicated *and* making it
>> > possible to have problems which we avoid by construction today, without any
>> > actual benefit.
>>
>> The benefit for me is this added flexibility and unification between
>> architectures. On other systems, like ARM32 or non-EFI ARM64 I can
>> insert a custom reset handler to do some actions just before restart and
>> on EFI based ARM64, I can't.
>>
>> You could argue that restart handlers were not created for that but they
>> suit this purpose ideally and it wouldn't make much sense (in my
>> opinion) to add yet another notifier chain that would run before reset
>> notifiers, for code that is not supposed to reset the whole system and
>> this is exacly what I would have to do if efi_reboot() is forced to be
>> called before all handlers.
>
>As above, I think that's just using the wrong interface, and the reboot
>notifier mechanism *already* exists, so I'm really confused here.
>
>Have I misunderstood what you're trying to achieve?
>
>Is there some problem with the reboot notifier mechanism that I am unaware of?
>e.g. do we bypass them in some case where you think they're needed?
>
>Are you simply unaware of reboot notifiers?

As explained above, I am aware of them but they have their limitation.
They were designed for slightly different usecase. The are designed
around blocking_notfier and are supposed to be called only in still safe
environment during graceful reboot, quite early in the reboot process.
If you need to do something just before reset and/or in case of a panic,
you are out of luck.
Of course reset_handlers have their limitations too. For one, they are
called in the context of atomic_notifier and we can't assume the system
is in good condition when it is called but trying to flip a GPIO line or
do a write to MMIO register is a sane thing to do here.

Krzysztof
