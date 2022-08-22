Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1E59BB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiHVITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiHVITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:19:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2067.outbound.protection.outlook.com [40.92.99.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924D1DA71;
        Mon, 22 Aug 2022 01:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdApIzga66Nhr+bQmBXaMuMGQul7rePGVLmtbPilESBMttEpkjzMtNI1Id0Ki+0Ch22gu+bdzXhsRhiMLIRTnGaHRKIAVadJFrLm9dzq5hBDh9DnbZX8X8ILiZV0ws81OWJ1OkcfIZDR3STiGwvWMkc76KpAPda/obQ1BQxLmSAn5y7zIzWbKL2Pe9kkQMrLPDcC9Z4FUr3I2kxSQW06fDqPyu/uoUH1Z98Ea6IioygSu5vJRKVac63rNxSQV2xGQMYJQ9Q28GwWYNyQsMm5sZ/6AsQJmQI2G6gyfJeLKUiII1tgxTqPBmjghAYoGIn6Ik8svp/BBIsjJQLLgVRRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCgXK1rRPwY7+hVP2ab0oABPvFHhuRRYC9C3mKZIYPA=;
 b=n59z05sgZ7VeQVwev87b8ByN/7yW6Tq4d87e9NQWMTfaZNzX44fC1jzOimhy8xuhgyw1egeC5Ivs6TaNcypJYYWh0tX4EHH08N74TBlObjGPEBKnpWNpYu7Nste3cPX1DG0rxFj6GBKe/cyMkogNHdQQWkFI30Hl6EVuKnOK5rHu/790GPHVJUS6KuW2MQyKEDSxeoxjykFxT/SIsNK8zb3ywgsoGp/lAjxU3XLqUNWtIINbetROKeZjeIaZcsbSqr8e1+uzRYPB2UBDxb9zlPco9qCJJ9mRdQtuHC6L3q2SfAlDJmB5KHDCajyLPM8gszrN98Mr5cVAI9iUaUgWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCgXK1rRPwY7+hVP2ab0oABPvFHhuRRYC9C3mKZIYPA=;
 b=rRfWUcZ+6euhkpocgYgl/pL0NxadU+MOQHclpLth0NVnGYV/eNQ5J2Mt76seSPE5h9+RigsuLrlsVQqThMDt3X3OwXrwx30FkFVjFQ6ypK9taDKJCuZ6tUwitDltl3zcbOaIsQbJnoDZYmD+C7ZoiXY84ivpnlZVOJxy64ABfLO5kp5BqjMCzS6t19q11eiHte/8SGBE4LvSc2GEyuReMl/BKy9F8i7ojFin87zCJvfQdfDo5h4o4ye5bZqiZCK1nJfXskO4eN9yM5bSwSidu+RpQvZJtHSTLZWipDzaWE1lW6rRGEp1lE7kj2vspKxTH5mvxiu2n/butrVfxBGjZA==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TYCP286MB3039.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 08:19:46 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:19:46 +0000
Message-ID: <TYWP286MB26016A8EF8040BE37DE9A27BB1719@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 22 Aug 2022 16:19:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Bug: Re: [PATCH v3] ACPI: Split out processor thermal register
 from ACPI PSS
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org,
        lenb@kernel.org, rui.zhang@intel.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, punit.agrawal@bytedance.com,
        Riwen Lu <luriwen@kylinos.cn>
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com>
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [M1s99iGdYzDaGuL+KLSnGW3LuPcAYO1V0EkOhMHvmbs=]
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <3955ddca-1df3-6257-13e1-f98fc31cfb12@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d19e6eb0-aa95-4866-f149-08da8417129c
X-MS-TrafficTypeDiagnostic: TYCP286MB3039:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkjcR3E9VFyzSQgdF6RkRGFQGFe3bJ7B9xP9PNUy9LFkLEgBeNvcX4STqfAW9dwwBq5IPQppbeWrVorg8lFbu5hx+I/ljpfoKr0em5fd8I9dvjy11D+b3q1OX+HRIm154Nncfrt/2OOMAE/e8P7mSUVr+OCKQ58F2ddtS+0/EoQOVTeN77bRG2xUVkySwFLA16pbQx/rxe45OKhYTlqRNrBsJndefMSCUI1rFQZFkCqspJGlLEnzw2Ebqu3h1cEtqkgHbrIwte6LtHqnGSFwOI8WwudSMf63HSOy1TuxlS4ytoc1WdPWZJj8MitZT4gO+ueuAgOdEDqcaxXMSyIPwWWjfTvboO5WpEHfEYqwXkwXhoa2A5uKiDEVV/HG42Ge/86sEFgzBCzHtrK7Hn6007e+0lSwMiIAG9PuXs73jPS/aY8Vnzpapj1fj3KXAoeo7zGIBC8WNv2s97XQvRmfDsyV01QmXfSAdjCSbTLQ52XEruNfAqraV1l4293Pqr2RKYmnytaoN3Uqcmt0KoNqls1sCFBd9nWMJCXE1kuTeYqjceWz4Fzyq6qDUJmGX3lACXirPMqNsiCtYUAzmy+3CxAmSeUqSiIKYrsGQlDSOLzIH+3QsbW42q4Kee1PeDdPMlJRQCZKG7qfhWA/gC0UnfI9YxpWdgyST1GSB+NRN6OFU2X8iCGI8+Z2ws9VUN1W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01IL2Z2dHRMcWQyaHJGTm84NHZybXRuUTBncDBhN2paN3k3K3pvU0FFVS9Z?=
 =?utf-8?B?NTdScmtyMmI4Z1p6cnlwc1VzNm51blMrVzVXWU9XMVk3SWZ0MTNuMDRFTUls?=
 =?utf-8?B?WWxCM1kvNHFVU21BdE4rL3pmWS9lSlEzRzNyRWZHbzVDcVJzZkQySEFvbDdw?=
 =?utf-8?B?bzMzY3ZUSU5haDVFVGNyQ1NYMW9PVG1udE9mWlZsVjI4UlpxRU1hMk9hRmRw?=
 =?utf-8?B?aFg3SXpRekdkcmtuVDJWM2xRc2VoM0MwOERDVE4wTVdGUEI3Y2YrSVRLUnc3?=
 =?utf-8?B?SlNwOEppN0E1M1JibGs1VDRBbTQyYXF2c0JXK0g0a1JnUnREdUYwT2liMFRF?=
 =?utf-8?B?TEZGaHY1R3YzUy9yNktFS0hNNXNGRTFmbGY4bE9hRGlwU0FFNVNLQ3ZwTnFi?=
 =?utf-8?B?RVNQNUtublZ6azJsWmJCRk56MjdpM2FxOHkwRVpCMnJvNUZDWUZxcWpWZmZR?=
 =?utf-8?B?cmhNV2dRcVpZL3llNTlVbnAxSmh1THNtUmtObmx4cTNOYk1ySjIvZzI4dXEr?=
 =?utf-8?B?WmZGaXBKL1NNQzNTSzdCMU1ieDVJNWhuT2paR2U5cEkvNFJBYVNzd25uMWd6?=
 =?utf-8?B?M1NMYWQvamJOcEFjWlJqZkFqOCtkNUVOZkgwVVBQMjNSK0FJWWVJQ2IxdE52?=
 =?utf-8?B?bnNiVExMU05VNjVyUWdZOE9Hc2xvWlBTNEpUZTBSTDVWUFBEeWVjWC83a1ph?=
 =?utf-8?B?bzNHNy93WEM0SDFOamE4VnMxUnh5cURJSUFLKzI5M1FFcm5UbXVsVGZUZFlW?=
 =?utf-8?B?bFVLVGhscUVnaGlBb2cweDZRLzZ2d3U0TTFVY09iTDBJQWgvdDhJWW53NC9a?=
 =?utf-8?B?WVprRHFpcDRpcG9DRnpaV1NPT2ZWR2VtLzRjdmNjcE9QMlVidXJMZWxqTXBY?=
 =?utf-8?B?Z3N0ZTRwWHZUT2NOdnRpMXIrcm1iRjVGS3JaODlmNjFRTFpHT2xqYmhuejYx?=
 =?utf-8?B?K2I3WmFYTjJYY0xrYVlnd2c4d3EvSUdwZDVxd2cxT1V4UXJRYm5jWXFIaTcz?=
 =?utf-8?B?OEgzWmNDVEI3enZONFVkYnhRYjU1bnc1Sjd1cmhaMytZTk1mUmNmc2JyRGxz?=
 =?utf-8?B?Nm5jWFhXQ2JrMGtjWVNlODNGV3FQTzBzS3ZzOGpJSHNuRkM3dkx3bkJxS0lX?=
 =?utf-8?B?TEN0RW1PaVhQYXU1RUw1azYyZlIvSkoxaVROVmoybm96Si8rdWZhVTVVMnJu?=
 =?utf-8?B?WGE1dVVNZkJkV09CaGR6ODBNUVVPcmhVUWtoMEJYc2JnN29ZbkNKMnBuY1BE?=
 =?utf-8?B?elUxaXNIdEtSd1cyTFlvUmpWaWh1OXVMajJkRS9nSyt3Wk04bjVtYklEcko4?=
 =?utf-8?B?VDFDeVNVM1RNcTRlV0tvTjJRU2pXeHNlaHljMmNEMStOVXV6LzE2NHpybGpy?=
 =?utf-8?B?aURINW1PS3pqWXg0WXVnSmk0NHd1YjNDcWNoa25hZENnNVJwMGc1Q09rMFQr?=
 =?utf-8?B?MDRVWlRNcDRlOFh5QlZlSzliN0JXQ0l1U1JjbmF6TmRnZ29iQXpPQlp5V1A1?=
 =?utf-8?B?VW9lYjdZYS90WlRvRzBTM3BId1hWeXVNdVBTemQ4QmV5UnF6L05yc0hDQ1po?=
 =?utf-8?B?SWVxTDJXdGoyWFAvSlVJeXhiZzJBZWJEVjB5ZmorTStQK3lCN3g0RFNrbjZG?=
 =?utf-8?B?RDJkbysrbXdNQVByS25TV3hCK1dOY21CN1hKRHJEMlVmZy81clc4ZTNiN3JI?=
 =?utf-8?B?OFNoWnA3QU8xNVlmazRyYmZ1eDVDOUt1a1ZyUXEyVURKaTU2ZTc4TWlBPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d19e6eb0-aa95-4866-f149-08da8417129c
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:19:46.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3039
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/19 04:23, Jeremy Linton 写道:
> Hi,
> 
> On 6/16/22 21:51, Riwen Lu wrote:
>> From: Riwen Lu <luriwen@kylinos.cn>
>>
>> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
>> driver"), moves processor thermal registration to acpi_pss_perf_init(),
>> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
>>
>> As ARM64 supports P-states using CPPC, it should be possible to also
>> support processor passive cooling even if PSS is not enabled. Split
>> out the processor thermal cooling register from ACPI PSS to support
>> this, and move it into a separate function in processor_thermal.c.
> 
> It appears this commit 7fdc74da940d ACPI: processor: Split out thermal 
> initialization from ACPI PSS
> 
> Is causing the following:
>     41.341659] ------------[ cut here ]------------
> [   41.346280] freq_qos_remove_request() called for unknown object
> [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597 
> freq_qos_remove_request+0xa4/0xc4
> [   41.361152] Modules linked in: nf_nat_tftp nft_objref 
> nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set 
> nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart 
> btqca cfg80211 bs
> [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted 6.0.0-rc1MINI+ #237
> [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4 
> Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
> [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
> [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
> [   41.447550] sp : ffff80000a4bbb60
> [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27: 
> 0000000000000000
> [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24: 
> ffff07858b07d200
> [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21: 
> ffffdf6ade80f850
> [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18: 
> ffffffffffffffff
> [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15: 
> 0000000000000006
> [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12: 
> 776f6e6b6e752072
> [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 : 
> ffffdf6adcae53ac
> [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 
> 0000000000000001
> [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 : 
> ffff07863b7b8bb0
> [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 : 
> 0000000000000033
> [   41.522315] Call trace:
> [   41.524759]  freq_qos_remove_request+0xa4/0xc4
> [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
> [   41.533834]  acpi_processor_notifier+0x74/0x90
> [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
> [   41.543161]  cpufreq_policy_free+0x154/0x1e0
> [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
> [   41.551538]  subsys_interface_unregister+0xf0/0xfc
> [   41.556335]  cpufreq_unregister_driver+0x54/0x120
> [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
> [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
> [   41.571947]  __arm64_sys_delete_module+0x20/0x30
> [   41.576567]  invoke_syscall+0x50/0x120
> [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
> [   41.585023]  do_el0_svc+0x38/0x4c
> [   41.588338]  el0_svc+0x34/0xdc
> [   41.591394]  el0t_64_sync_handler+0x11c/0x150
> [   41.595752]  el0t_64_sync+0x190/0x194
> [   41.599416] ---[ end trace 0000000000000000 ]---
> 
> When the cppc_cpufreq driver is rmmod'ed from a running machine that has 
> both CPPC and a thermal zone. I reverted and bisected it, and in both 
> cases the splat above goes away.

Did you enable the option ACPI_CPU_FREQ_PSS ? When I reverted the commit 
7fdc74da940d and enable ACPI_CPU_FREQ_PSS, the warning above also appears.

Thanks.
> 
> 
> Thanks,
> 
>>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>
>> ---
>> v1 -> v2:
>>   - Reword the commit message.
>>   - Update the signature of acpi_pss_perf_init() to void, and remove the
>>     acpi_device parameter.
>>   - Move the processor thermal register/remove into a separate 
>> function in
>>     processor_thermal.c.
>>
>> v2 -> v3:
>>   - Remove the "pr" NULL check in processor thermal init/exit fuction.
>>   - Pass the acpi_device into processor thermal init/exit, and remove the
>>     convert in it.
>> ---
>>   drivers/acpi/Kconfig             |  2 +-
>>   drivers/acpi/Makefile            |  5 +--
>>   drivers/acpi/processor_driver.c  | 72 ++++----------------------------
>>   drivers/acpi/processor_thermal.c | 54 ++++++++++++++++++++++++
>>   include/acpi/processor.h         |  8 +++-
>>   5 files changed, 71 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 1e34f846508f..2457ade3f82d 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -255,7 +255,6 @@ config ACPI_DOCK
>>   config ACPI_CPU_FREQ_PSS
>>       bool
>> -    select THERMAL
>>   config ACPI_PROCESSOR_CSTATE
>>       def_bool y
>> @@ -287,6 +286,7 @@ config ACPI_PROCESSOR
>>       depends on X86 || IA64 || ARM64 || LOONGARCH
>>       select ACPI_PROCESSOR_IDLE
>>       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
>> +    select THERMAL
>>       default y
>>       help
>>         This driver adds support for the ACPI Processor package. It is 
>> required
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index b5a8d3e00a52..0002eecbf870 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -109,10 +109,9 @@ obj-$(CONFIG_ACPI_PPTT)     += pptt.o
>>   obj-$(CONFIG_ACPI_PFRUT)    += pfr_update.o pfr_telemetry.o
>>   # processor has its own "processor." module_param namespace
>> -processor-y            := processor_driver.o
>> +processor-y            := processor_driver.o processor_thermal.o
>>   processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
>> -processor-$(CONFIG_ACPI_CPU_FREQ_PSS)    += processor_throttling.o    \
>> -    processor_thermal.o
>> +processor-$(CONFIG_ACPI_CPU_FREQ_PSS)    += processor_throttling.o
>>   processor-$(CONFIG_CPU_FREQ)    += processor_perflib.o
>>   obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
>> diff --git a/drivers/acpi/processor_driver.c 
>> b/drivers/acpi/processor_driver.c
>> index 368a9edefd0c..1278969eec1f 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -139,75 +139,17 @@ static int acpi_soft_cpu_dead(unsigned int cpu)
>>   }
>>   #ifdef CONFIG_ACPI_CPU_FREQ_PSS
>> -static int acpi_pss_perf_init(struct acpi_processor *pr,
>> -        struct acpi_device *device)
>> +static void acpi_pss_perf_init(struct acpi_processor *pr)
>>   {
>> -    int result = 0;
>> -
>>       acpi_processor_ppc_has_changed(pr, 0);
>>       acpi_processor_get_throttling_info(pr);
>>       if (pr->flags.throttling)
>>           pr->flags.limit = 1;
>> -
>> -    pr->cdev = thermal_cooling_device_register("Processor", device,
>> -                           &processor_cooling_ops);
>> -    if (IS_ERR(pr->cdev)) {
>> -        result = PTR_ERR(pr->cdev);
>> -        return result;
>> -    }
>> -
>> -    dev_dbg(&device->dev, "registered as cooling_device%d\n",
>> -        pr->cdev->id);
>> -
>> -    result = sysfs_create_link(&device->dev.kobj,
>> -                   &pr->cdev->device.kobj,
>> -                   "thermal_cooling");
>> -    if (result) {
>> -        dev_err(&device->dev,
>> -            "Failed to create sysfs link 'thermal_cooling'\n");
>> -        goto err_thermal_unregister;
>> -    }
>> -
>> -    result = sysfs_create_link(&pr->cdev->device.kobj,
>> -                   &device->dev.kobj,
>> -                   "device");
>> -    if (result) {
>> -        dev_err(&pr->cdev->device,
>> -            "Failed to create sysfs link 'device'\n");
>> -        goto err_remove_sysfs_thermal;
>> -    }
>> -
>> -    return 0;
>> -
>> - err_remove_sysfs_thermal:
>> -    sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> - err_thermal_unregister:
>> -    thermal_cooling_device_unregister(pr->cdev);
>> -
>> -    return result;
>> -}
>> -
>> -static void acpi_pss_perf_exit(struct acpi_processor *pr,
>> -        struct acpi_device *device)
>> -{
>> -    if (pr->cdev) {
>> -        sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> -        sysfs_remove_link(&pr->cdev->device.kobj, "device");
>> -        thermal_cooling_device_unregister(pr->cdev);
>> -        pr->cdev = NULL;
>> -    }
>>   }
>>   #else
>> -static inline int acpi_pss_perf_init(struct acpi_processor *pr,
>> -        struct acpi_device *device)
>> -{
>> -    return 0;
>> -}
>> -
>> -static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
>> -        struct acpi_device *device) {}
>> +static inline void acpi_pss_perf_init(struct acpi_processor *pr) {}
>>   #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>>   static int __acpi_processor_start(struct acpi_device *device)
>> @@ -229,7 +171,9 @@ static int __acpi_processor_start(struct 
>> acpi_device *device)
>>       if (!cpuidle_get_driver() || cpuidle_get_driver() == 
>> &acpi_idle_driver)
>>           acpi_processor_power_init(pr);
>> -    result = acpi_pss_perf_init(pr, device);
>> +    acpi_pss_perf_init(pr);
>> +
>> +    result = acpi_processor_thermal_init(pr, device);
>>       if (result)
>>           goto err_power_exit;
>> @@ -239,7 +183,7 @@ static int __acpi_processor_start(struct 
>> acpi_device *device)
>>           return 0;
>>       result = -ENODEV;
>> -    acpi_pss_perf_exit(pr, device);
>> +    acpi_processor_thermal_exit(pr, device);
>>   err_power_exit:
>>       acpi_processor_power_exit(pr);
>> @@ -277,10 +221,10 @@ static int acpi_processor_stop(struct device *dev)
>>           return 0;
>>       acpi_processor_power_exit(pr);
>> -    acpi_pss_perf_exit(pr, device);
>> -
>>       acpi_cppc_processor_exit(pr);
>> +    acpi_processor_thermal_exit(pr, device);
>> +
>>       return 0;
>>   }
>> diff --git a/drivers/acpi/processor_thermal.c 
>> b/drivers/acpi/processor_thermal.c
>> index d8b2dfcd59b5..db6ac540e924 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -266,3 +266,57 @@ const struct thermal_cooling_device_ops 
>> processor_cooling_ops = {
>>       .get_cur_state = processor_get_cur_state,
>>       .set_cur_state = processor_set_cur_state,
>>   };
>> +
>> +int acpi_processor_thermal_init(struct acpi_processor *pr,
>> +                struct acpi_device *device)
>> +{
>> +    int result = 0;
>> +
>> +    pr->cdev = thermal_cooling_device_register("Processor", device,
>> +                           &processor_cooling_ops);
>> +    if (IS_ERR(pr->cdev)) {
>> +        result = PTR_ERR(pr->cdev);
>> +        return result;
>> +    }
>> +
>> +    dev_dbg(&device->dev, "registered as cooling_device%d\n",
>> +        pr->cdev->id);
>> +
>> +    result = sysfs_create_link(&device->dev.kobj,
>> +                   &pr->cdev->device.kobj,
>> +                   "thermal_cooling");
>> +    if (result) {
>> +        dev_err(&device->dev,
>> +            "Failed to create sysfs link 'thermal_cooling'\n");
>> +        goto err_thermal_unregister;
>> +    }
>> +
>> +    result = sysfs_create_link(&pr->cdev->device.kobj,
>> +                   &device->dev.kobj,
>> +                   "device");
>> +    if (result) {
>> +        dev_err(&pr->cdev->device,
>> +            "Failed to create sysfs link 'device'\n");
>> +        goto err_remove_sysfs_thermal;
>> +    }
>> +
>> +    return 0;
>> +
>> +err_remove_sysfs_thermal:
>> +    sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> +err_thermal_unregister:
>> +    thermal_cooling_device_unregister(pr->cdev);
>> +
>> +    return result;
>> +}
>> +
>> +void acpi_processor_thermal_exit(struct acpi_processor *pr,
>> +                 struct acpi_device *device)
>> +{
>> +    if (pr->cdev) {
>> +        sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
>> +        sysfs_remove_link(&pr->cdev->device.kobj, "device");
>> +        thermal_cooling_device_unregister(pr->cdev);
>> +        pr->cdev = NULL;
>> +    }
>> +}
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 194027371928..ba1e3ed98d3d 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -442,8 +442,12 @@ static inline int acpi_processor_hotplug(struct 
>> acpi_processor *pr)
>>   /* in processor_thermal.c */
>>   int acpi_processor_get_limit_info(struct acpi_processor *pr);
>> +int acpi_processor_thermal_init(struct acpi_processor *pr,
>> +                struct acpi_device *device);
>> +void acpi_processor_thermal_exit(struct acpi_processor *pr,
>> +                 struct acpi_device *device);
>>   extern const struct thermal_cooling_device_ops processor_cooling_ops;
>> -#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
>> +#ifdef CONFIG_CPU_FREQ
>>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
>>   void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
>>   #else
>> @@ -455,6 +459,6 @@ static inline void 
>> acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>>   {
>>       return;
>>   }
>> -#endif    /* CONFIG_ACPI_CPU_FREQ_PSS */
>> +#endif    /* CONFIG_CPU_FREQ */
>>   #endif
> 

