Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5C4A0345
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbiA1WFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:05:48 -0500
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:8289
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229608AbiA1WFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:05:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWbuG6bh5zzJwi5ITx7Q27iXrwEV6gF5z7dsZ6jU8APYd0xmyelTOb7RdBLrWegHure0MEwjsBW7e3PoU0z+JZOPZiamSE3tbqRLKj5MmLeGysB1ZddL8pvf6TvTeRsDBADfkH7P1/6PbGXUjJxAuQxAFHT4XSwSEWtVk3TMMrULL5iyoSHw05Zlt5Vq0y3dqaQeZj02K4gG/tJvDLbMG6OJlzpVtm7TH8Y0ZBnfDvShYHsEEYNjdPbbnlrCbwnOZAOQtbF08D+c+0hf8DYlGTV8m7/UUqTF7KJNasYIUhsfXiu/zMXKMd/pJNyS7AkEaklLybL5Fh0YfPfRY3kVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYvctaIL45KuTsMGH1h/Y8HfebQIANgjFe2qsqK3kRg=;
 b=bW9/w9hHiGoxPPX9ik6hWNb3aHeZiA2FDPjrR04gAXqQ95frcLRgB7EZ2zzXkM3MNWnp6wah4oluiFB6X3D9f5xV1M5ZtxFACVN9iLVWaN5wSE63a2RLzcDScAGwQKenoynZ2pPS087ccWNa9TxcQ2PSqN1cVkFQY3irRNNg/APCj6q0+ysURLYNX7SFx82buIDlcO2e5TX1h2RVIPdOoKckHs77faS61ZOLyLUEkrH0xf3j+dc8zjm0M6xr2gzGOO2M/gqA6bXt185m4KHNBi64UDUX3HmUtb72glOdS1VH3jfSUjYS0NcNnadEAg930YfGne+L54+/kMFOxhsuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYvctaIL45KuTsMGH1h/Y8HfebQIANgjFe2qsqK3kRg=;
 b=iDvTOomtupyknpBFynK285hwNFg8NmF9CRofEC88NtX44RQg8iCL0/gDMsXZFFYVEHoe7+gGjSymaKFMfXgk+HqmKm9mN2xZ+JF0LuyZYUF4seMreZNqc5QJ5C2LoRfYvSeqGnJ0MCe62n5UtIBwstEotUUgWaqSoDPegcnDis4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by AM6PR07MB6005.eurprd07.prod.outlook.com (2603:10a6:20b:2c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 22:05:44 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%6]) with mapi id 15.20.4951.006; Fri, 28 Jan 2022
 22:05:44 +0000
Date:   Fri, 28 Jan 2022 23:05:32 +0100
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
Message-ID: <YfRorCpk0seVGI+5@localhost.localdomain>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
X-ClientProxiedBy: CH0PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:610:10e::17) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee1535c2-42f9-4e21-f4e1-08d9e2aa5444
X-MS-TrafficTypeDiagnostic: AM6PR07MB6005:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB600516580D37F03C0466ABC2EF229@AM6PR07MB6005.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+8kwkfF1oM9L2Q/YFB07zlXa4/LQ3JGw0xXYGUdH87eJ2NiS9ho2Tlgl3mLS0EH6JaUVYB2n4QdTnd1eOM02SGa2o+7InCpv5Nm7zmN9SPF2YaSlArklz40lbdfY49/6ggGVrRDr5Nhgx7cv5AJAE35MwBkZWVRZIfb2hU54tivTAbQBBAs1ZXoMAJ77Fdm3nvHMZej5veaDxV7GAMnyQtPZ2B/5Wo3EOYXRrTa2ZWaMedjFVvtqmVA7Pu5caL9sSFO34yeAQmLVOl7EFF7395mV6GRzK39a/etfOMzBZFxZoNOrh+hw6jzThOQ0yL9JANdKxSZDEqCn0AMMSjudZa4+40NZtM4S0m3ubVl6icpyMUTNBCZVRkbmhfkVBKNU9gvCFdslc3s5eUGZqHJCZbPQnhfPfJkJaLhF8shkn9UrRzOKtaAze5Okrn1glecR9jNcc87i3fUPJANb6C0jXSgmaPvXxRflYKPovC5kGxa2gVAmFfuUCQp4SLQbpR2Lzf1DmH2dezx+NtQhFZG+w/re3PTd2HL27eIHx1URXJno00iFFsS+Iwp+cT9QpwtHzr+WM8fu5AV79pGzcQXhQ2aJdA+cf3WRcl58QNsxG/BEN7JRKNJ+POMc1q+5br+zZNnN68Z8rY9vHbBO5qn6dQDiHXhnXQyRK/e9i5LFhA6skI7Ly77OyY0/9iDIGpuTYhxCnVSkaj9VJpw4yI7/S55cf4hwrjbICmTRYsiLdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(6916009)(66556008)(86362001)(66476007)(66946007)(44832011)(26005)(52116002)(186003)(5660300002)(38100700002)(83380400001)(38350700002)(82960400001)(8676002)(6666004)(8936002)(508600001)(4326008)(9686003)(6506007)(2906002)(6512007)(6486002)(67856001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NVY0dsQXNyTWthaHA2eEtXb0hzSlpnL3J0Qks3bEIvSTdBZ0VGdW93WVJE?=
 =?utf-8?B?ZjYvU3NHdW00OHczUFo4N29WWVVlK3JiRUthdlJ4K0k4Y25sZzQzMDNEdzhM?=
 =?utf-8?B?ejNJcDExVUxXeVU1QW5OMUxaRXZlYzBEb01uTVE5RitCVjBLejdzY1NaNVIy?=
 =?utf-8?B?L09CNW5vYStxRHQzU0RzTjJEZjI2VFE3aFJ1d2hFZ0pqUmk1R3JZb3ZINnhU?=
 =?utf-8?B?TTR4UDh3dVROc0xoMG05ZUVDZlZ4MjJRQXJLZjZkVEFOS1NHaXJaTzVGYytU?=
 =?utf-8?B?bEtTUWhLdXBSc2xUWTBxYTdVY3dPd1RNVlluTjVWenBEMFJhc3RZOXppVHZZ?=
 =?utf-8?B?V09sNGFtVWFqOVVkMU51eFJhUFovMTB1QWFHT1hjME5KSGlndFM5RlJ1VnU1?=
 =?utf-8?B?Q2NLY1VLT2xLcGZZclhGdjg1eWNLMktUYnFRV3dTWFNiYTEzbmc5bGxFKyti?=
 =?utf-8?B?VjBHb0daQ0NPcDNXMjhST0VERm1DU05CeVYxMzJjUUhBQ01xTW4vNUVFV2hD?=
 =?utf-8?B?L2lMN0hXM3lOWDh1WVFlYlY2ZmNNMzIxejQwSFh6K2orTjR2R2V5OE1CNkty?=
 =?utf-8?B?Q3BTY21UT3k2ZW84bTZZVEk3RFJ1MHVDc0h2RExXVndQcnNQbVc2RWZwb2xj?=
 =?utf-8?B?aGlybHorNDdKcm9UZUFrdUw5OFkwRDRMMkRXb015Y0RBalo5dDNVRlowbXJJ?=
 =?utf-8?B?UERtRjFJNXgwSUZFMG1GMCtlaGlPMkdZT2NDK0IzYWNuWmlSSXMxc2EzYWlp?=
 =?utf-8?B?VDNUZlV2QVpTcmtsdmx0M2xvbmJ3alZaZElzd25YNVBqSUJxR2gzYjdDWXdP?=
 =?utf-8?B?aWJ3Q2pTNWNqb0RHL3hZOFQ5Z3BJR0IyL2tQazdMaysyY2g3TzNaTnpGTEFu?=
 =?utf-8?B?WlRMblE4a2ZWVFQ2VDhTeW15N0g5MVl2Vk1Mei9ZOUJiMFc4RXhSOTBSQWdF?=
 =?utf-8?B?alJva2I5REdlaVJWZVhJcTBJeC81VFMvZm1xUjBxN1gzSEF3dHh3YjZVZFRt?=
 =?utf-8?B?ZG44U0RIc0tRWURzVkltdmJYYm5ybDdMaE5QZk1QL0p1Ymtaeks1Y0JweXJK?=
 =?utf-8?B?SjhBQjhkMkdRZW50a2JoaVlrYmVtZmErY1FTa0I2d21wazdhMDMyeldkbzEz?=
 =?utf-8?B?NjZUeGhNdUhvR0lVQ282c2J2VHRiM2VhRWhtMlExOVhKL0VkRGZHZDNZNjZt?=
 =?utf-8?B?dG1JTVZSVk1kOGNTeFRONDFqZWdMS0RDSnBPL2IxVXA1cUNMYURzWlpJREV3?=
 =?utf-8?B?TWNWSWRDOHNGZ1g4eFRIZEN6VVZGNGlCaTE5b3FJdkEzQWliaVdYRnVnU0Ex?=
 =?utf-8?B?ZG5LWTF6L0psL3hZWnA1MU12RnZJc0VUcjBFTFphUC8zMWh4dUNoMkpzODQx?=
 =?utf-8?B?NklqdjFqanhNbDNhckd5c1V2Q29QYmt4MFR6ZzFXVU5CVlIvTEl0VDg5eWJ1?=
 =?utf-8?B?S2grbExhZUpESVk2b0Zremh6Q2I1c3B3cm45YjByTXU5RnVLam9XVW15d01h?=
 =?utf-8?B?QlVyb2JEbHBRRnB2UmNpdkx4S09UQnM5V2E4WUNPZEw4cXN0KzE1bmNUdEtW?=
 =?utf-8?B?LzBqditodkhpZWdUc2NJcU01dW9xOS9oLyszZ095NUd0cHo3U3RDMGIzKzVH?=
 =?utf-8?B?Zi95ZjYzNC9hZFZJbnkxNERNdXZzVXNzNTlvL2lMMmZ0NDFsdUhwWU9ucEky?=
 =?utf-8?B?Uzh4TEt3dGZkZVRkNzRuNTh6QWJVZG9NN1FSN1EwLzZhbVNlcGZLVjhuRys5?=
 =?utf-8?B?WkNOZmdkMnNnckcwVE85a0hzQVFTem5MdERmYjNYN3RVK1RiYUszblNYSnlj?=
 =?utf-8?B?eUF2aWYvT2FuakxkaVBaZWx5OFhxaGM0dHA1MnRiYXdkd0Vyd05EOStUM3d0?=
 =?utf-8?B?MHRsaXJJRDI1STZYZXZkY3dNUlhGdkVncndSNFF6SEtia2N2VjBmeXJ4dlRP?=
 =?utf-8?B?dVB6NFl2TTczVUtabld3bU5uWUNObTRrZjRIWTJoOUhtZXgvWWNGZW9KVWQz?=
 =?utf-8?B?b2NCWFBjc2sxSXovZUo0VWhiTUJNL3R5WFQwNjM3VDM2N0VwN1JLTjVoMUNG?=
 =?utf-8?B?bktsSU90TGw4WWN4cEdvZ3RoRjM0cStOb29LREk4bWJRNTFXVDVzbTlJa0R1?=
 =?utf-8?B?cHVVZnluSVUzc0VZaEZiRDRLOWs0aEgyVFBvcmpLRWRoZkJOcmxwLzhHdVZY?=
 =?utf-8?B?d0tHWVYyd0FrYzdMSkxEaW5iclFqWS84YkpoVlE2eWoxVlBDZ245R041MlA2?=
 =?utf-8?B?L1BMdXBoMW5zRTV0ZU55VkJ2M3pBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1535c2-42f9-4e21-f4e1-08d9e2aa5444
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:05:44.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDg+Di2mjWzXeF2keVMphAw54jpdZSWcNbSLDYEw/aEIFceC+4PTAOIX+bsKRpRBM4SP8C+IwTH7LQV8PceW9eYn5/VkctH86HNvdCkaOJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB6005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for your feedback. I don't know UEFI specification that much,
it is quite complicated so maybe I am misunderstnading something. Let's
clarify.

Dnia Fri, Jan 28, 2022 at 04:01:41PM +0000, Mark Rutland napisał(a):
>On Fri, Jan 28, 2022 at 02:50:26PM +0100, Krzysztof Adamski wrote:
>> On EFI enabled arm64 systems, efi_reboot was called before
>> do_kernel_restart, completely omitting the reset_handlers functionality.
>
>As I pointed out before, per the EFI spec we *need* to do this before any other
>restart mechanism so that anything which EFI ties to the restart actually
>occurs as expected -- e.g. UpdateCapsule(), as the comment says.
>AFAICT, either:
>
>* The other restart handlers have lower priority, in which case they'll be
>  called after this anyway, and in such cases this patch is not necessary.

But efi_reboot calls ResetSystem(), which according to the spec:
"Resets all processors and devices and reboots the system."

So nothing should be able to run *after* this call. Thus, none of the
reset handlers will ever run on a system where efi_reboot() is used
(with current, unmodified kernel code) so this case is invalid.

>
>* At least one other restart handler has higher priority, and the EFI restart
>  isn't actually used, and so any functionaltiy tied to the EFI restart will
>  not work on that machine.

If we use the restart handlers only to reset the system, this is indeed
true. But technically, restart handlers support the scenario where the
handler does some action that does not do reset of the whole system and
passes the control further down the chain, eventually reaching a handler
that will reset the whole system.
This can be done on non-uefi systems without problems but it doesn't
work on UEFI bases arm64 systems and this is a problem for us.

In other words, I would like to be able to run a restart handler on EFI
based ARM64 systems, just like I can on other systems, just for its
"side effects", not to do the actual reboot. Current code disables this
possibility on an ARM64 EFI system.

>
>> By registering efi_reboot as part of the chain with slightly elevated
>> priority, we make it run before the default handler but still allow
>> plugging in other handlers.
>> Thanks to that, things like gpio_restart, restart handlers in
>> watchdog_core, mmc or mtds are working on those platforms.
>
>On which platforms is it necessary that these are used in preference to the EFI
>restart? Can you please give a specific example?

>If there's a specific platform that needs this, then we should call that out
>and explain why the EFI restart isn't actually required on that (or if it is,
>and functionality is broken, why that's acceptable).

Again, I'm not saying EFI restart is not required. I would just like to
have the flexibility I have on other architectures, and run some code
just before restart. My understanding is that pwrseq_emmc.c driver does
exactly that, for example, but there are also other possibilities:
  - using gpio-restart to notify external components about reset of the
    CPU
  - starting an external watchdog that makes sure we are not stuck in the
    reset procedure, etc.

>Otherwise this patch is making this logic more complicated *and* making it
>possible to have problems which we avoid by construction today, without any
>actual benefit.

The benefit for me is this added flexibility and unification between
architectures. On other systems, like ARM32 or non-EFI ARM64 I can
insert a custom reset handler to do some actions just before restart and
on EFI based ARM64, I can't.

You could argue that restart handlers were not created for that but they
suit this purpose ideally and it wouldn't make much sense (in my
opinion) to add yet another notifier chain that would run before reset
notifiers, for code that is not supposed to reset the whole system and
this is exacly what I would have to do if efi_reboot() is forced to be
called before all handlers.

Best regards,
Krzysztof Adamski
