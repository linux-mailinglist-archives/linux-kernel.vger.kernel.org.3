Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF64B2E07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353005AbiBKTwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:52:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbiBKTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:51:59 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D832A5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5L002qsw/ye7ThGAXIgyXlr6O41kfH/6MaJZrO9AbxZm4M7a8vCshLM5yQqlO/qc6JOuSAEnJ/JVK0WSRYKwWhkKp+FnDRgOes+TuZ+/OSV1FIyQQMGu2nfPG/NrrYHSbQP3lH4ayJo07D4IlgOyEwZ5FFPQ+3xvEfov8+YYSODNuttbTp4Mi44LDL4nkhT3KdDayk6hNzoWCxFYDy98bRvXm3jbwXbiIcFho6f8mzwK53fz2PJRTXibuOL4uuLvWkwUEPDFgiW3JNACUrzRieiNa72tW0rRoGgPshCE+6xlTEFZ7qoKtDnpZc0d084ow5oyPa9h1QhHWhIaIEWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVYTkXGzsFQpOJz/FRf7xWxjfJSd0lzdH2LrovRPg3E=;
 b=FYH8+Ehjr2xRQj4kK3rmo6QNjPuL7vXawx3wPiVtSp+6rEs6wM6MblRM9RSpJH0C8AdYGmCnuGIoNpJOyLj5H6Z50INK6f+CTMZBrNmYIMG9KmjciShM6s2VuKgcU43bBT/mb71g+DDMvKgYsyvav//YJI/Z9wO0w07WFOKRAyXM/1mpDM2Exsl7/4270voZ/ijou/sYaplyuK1hBkyac65/I4OZihMcKaMCa7YpbP7NfyOw1v4osS/uZ+fkvFMpfpHE0n0PItpJOkQapLSJIsr8Ced7+YwfoWp0/5psDahezx5ipDef4gv3EqxOLM5IzY523yIbsjfWSIYXrkzgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVYTkXGzsFQpOJz/FRf7xWxjfJSd0lzdH2LrovRPg3E=;
 b=C1D3N4S4WqH5bNUBSWFAgSX4WVj9fAlVubvECZBklqwtvJoEm6vO01KR5GvHBrKCZHH2wHaAuyNhhZYnR/iKa9vk5TbNYO//dBODSKN9bDUAPTxkBW4YW0bLiGeS8WOOpzVX5mz/wFJXHyEGYIukenKz583pKiPVMtxFILKQ18g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 19:51:55 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 19:51:55 +0000
Message-ID: <a52990c0-3e54-a5f2-22c2-3446e92f4294@amd.com>
Date:   Fri, 11 Feb 2022 13:51:53 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] x86: Use CPUID 0x8000001f to confirm SME availability
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <568d9945-ed0c-90a7-d9cf-a5662f1dbce2@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <568d9945-ed0c-90a7-d9cf-a5662f1dbce2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fccb4d9f-c459-4826-ed1e-08d9ed97f4af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB372575D44E479F3C6C38D4F0E2309@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o53BnjgcP8OIKiVD9uPYs1j5GIQMFuA8BRCg5WnhrlaCkJsOR3A3szudeOz1ExV1ZTjnx3tE2IWXyMtUzCKJL99MmqBZwevyGzrT4RSwTv0gDv55XVVJuvizcxph+W7Xw5v3GvNNatunhNbYf/r1peJZFxR9HpVggTCRbClD4/DGSAVW773xIIHv0p6HARzZ39tLzDewYUrk/66FEheHqUFr7WrF+YmUEgqwjl9o2IMkdBn3KUMp+HnMtjteX6NrU4bMFYPS1fi+dAVUq/wnIYHmP3YXg3slkoFNH53SYhhhTzkpLcSPBJMFXY9RBflfE+wArHGvAHko/X4hVpuDmFZvocgEeqe6GWfNHVvODp8sH1UrDUyywP5JevIKQYQBf57AlS1QDbatNnyOfOOofSwyEQLm9KlPBIGAItVb9ctT5ho2/Yq2+gC1gmUAJkxZDMwEHSyLWBDY0yyH6AWA4RkOF7ru/4VZHFCY+7nUDOlIHlFHYafEvSE6619sg5EzUjdKhOJxVW4mA5NF55Mc4j2dDGjq/Ur+ImyNcESIHH2ZQMVD+Y2+KOcseKeqs+lAgGT0cdbVeqHJHVZskYQGI9ewRjA02l7MEqx1eCZdHzIa2kx2KuYK2BMq9lUAgg67qohdtvpT6Z4QF+3Nm/YjyHpDOt0L6aiwkkaXxVqVj5m74eWddwQRPn+e3+3q60Oq608m2UBbtpu45bdlU/DkMd8k3MME3L6CVsTyc1X95cGgxniarh+SnLekHGft9fQO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(26005)(2616005)(38100700002)(66476007)(66556008)(186003)(110136005)(83380400001)(86362001)(8936002)(4326008)(54906003)(66946007)(31686004)(2906002)(5660300002)(53546011)(6486002)(36756003)(6506007)(316002)(31696002)(508600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm5TZUN5TUZlM3FqUG8yZUdidGNlRDQwOFlnTjZPVEdBbFZ5amhrTGhLUTMx?=
 =?utf-8?B?WU5rTk1XVWFNKzZ0RzFvZWRNcVhOcHNxZlluZUpZOVB0UldGdHNmVU5KZGow?=
 =?utf-8?B?R1dLVGhaVnU1RWJVTVV2TFJwTVZtZmpOYm9LMlhXOFdESHBpenRmMWFRZ0Y1?=
 =?utf-8?B?N3p6bE5haTl0RVpUUlRBMjQ1UTRjSi9mRGl1Ym16VWZ5QytqZ2dZdFhvcFU1?=
 =?utf-8?B?RW9oNUk5NHhNekh0Mnlobm5NeEs3UWNiRzFoTWd0aERhNnhld1d2V1lIbHhO?=
 =?utf-8?B?dmZsdWpEWmNhTnlTMUVXQVk2c3FscXFxZVpyanVzbU1BQlJhRHNQN1lpOXZT?=
 =?utf-8?B?YXM5MlorV1orZnVKQlFBY3NpaTdtYXVTZkpmcnN1Q0d4WW41ZEhVRHhWUnlM?=
 =?utf-8?B?QzA2MHZ2aGRyNTVVMlF2Zjc2T1BQQ1ZSVEVmUFQyK0J2RFFYa1liaERKSlpl?=
 =?utf-8?B?emZkSDZCcnFJNUI3UDkrS3dxQmJJYkUzZGhYbGpEV3NtQXhNS2hUTjg4ZjdX?=
 =?utf-8?B?MlFRQzVGZVN4M0F0bkxjQUpxdVBYRUxqc29Kb2ZqZW1md0Z6UzB0TmVTbjdQ?=
 =?utf-8?B?Y010RXljRm1jY0ZWME5RWit1S1Y0MVhLUmc2eTVnaHRGR3RiaXoySGk5VVo1?=
 =?utf-8?B?ejRvZXNLS2RiVFd3dkUyUHg4K3ZubjFzVWpWM3lMMU9xMUROSjcxdGJjUWJ0?=
 =?utf-8?B?Skh6OHBzWXBCYUNEY2cwb0xBWmZYbUFSRGhlR0s4R3VWZ2p0aVRRd1o0RTdB?=
 =?utf-8?B?RFBzaXB3ckh0d3lONG41dWxRSXVDSk04d1BWQVVBa0VaVkw1L21zd0J1N3dR?=
 =?utf-8?B?UzYwRW9rSGJFSzd2SmpJdFRiR3ZZV2FGUCtPcEIzaEhjZkZjYkJrV1UrMEFs?=
 =?utf-8?B?TFZablljbEZBR2lBODhIN2Q5UXNLUXFnaWJBWTRHdGVHcWY4YUt5MmV5LzhK?=
 =?utf-8?B?YjEvWHhrcXB6Q3E0bW5YcVprNHMvMzlTUFMzWGFDZWliM09Wd0ZVTW1HWEVS?=
 =?utf-8?B?VWlVbXRzZHBFRFV5S3laWE10M2hSb0Zkd0hmQTUyR2Q1em1LbmpBWTExeTRR?=
 =?utf-8?B?dVJpYVlWYjFWaXFXMnZsakpoL1BMMGFPd2JXNDVIU0lCeWpGTGJva3Z0UHpt?=
 =?utf-8?B?WUlnNFhiQjlPWFpNYUcyWm5QNGxnQnNOZW14U2F5bEpPSm5HY05vdkFKWmxD?=
 =?utf-8?B?TGZEenpvK1Q0enFhZkFPOTVheDJnS2pUc0Vhcmw0bUIyM25vVVliSGpDaEVZ?=
 =?utf-8?B?bXUzSSs0YzBRcXpBbDlpb3NBMVVUZFJIdnFSYjJTK2JlSGpGdzdwL2pmbnZ2?=
 =?utf-8?B?RVRLNFFCVXp4MWtkd1pUSmJBTHZIYkpyZFMxVksweEI3cjZiczZncHZEcGZr?=
 =?utf-8?B?OWlpU3dQcDZZOWNxVDhmNkZyRGFBSUlla2EvSkpqUW0yN0RENm9RQzJZOW9p?=
 =?utf-8?B?NXNMb29NOUV4K1ZNbUl4YXBrU2sxMGo3Z0VObzlJeWJhTE0vMVNpVFY2NmlW?=
 =?utf-8?B?QjRQTkNmY2ZpMHNJRytkZ3hsOE85TWlBSHNaUm82L2F6cWppWjFoeDNjQzZD?=
 =?utf-8?B?ZjVXVW9QSGV1QmhHOW12bzJITzV3WWNRL2Z0RzB6Qk9aZ2ZBWk0vTi9KRy9M?=
 =?utf-8?B?VkQ0N2dlWTViSDFIbzlMbnZDcjJrZzhPc1Q1VVBBcS81MldhNWxqMndpdEx1?=
 =?utf-8?B?M3V4S3dYWGpuckcvRmxhcC8rNk44SlFzRVA0eE1ka21yK2ZjcjllcnpPTXRo?=
 =?utf-8?B?T2F0QmN0dzJ6OUZaOVI4RytNSDg1b3ZnSWdpK0ZXNU96eDg5VkpZdElSYmU3?=
 =?utf-8?B?NnZqVU5yM0lZYWFleXBjV2VpMzN2OGxSMnhCNFlHaEJreEFSSjhEUVRORU1Z?=
 =?utf-8?B?U2pxenBodHdQYjU4NU5OTU9hY0oyLy9yNGZCZjMzdGZPWGpsMlhzNU5DVTRO?=
 =?utf-8?B?ZGVMNko0QzZ4SGlwUlJCSSs1SDhnUU5VVFVjYSs5MmNObm5lNVgwQ3QzblpP?=
 =?utf-8?B?clN5S2dJNVhPd1NVK3ZIdVFHVERDSE9KWWZoTXplalVlWU10MGlKWnVtcklt?=
 =?utf-8?B?MXMzTWRrc0Rkdkl3YXdQNDhGZWRlQVlRYURDV0ZvcksyZTlOL1BoTVlsQ2ZN?=
 =?utf-8?B?dHA3WExKa04rUGRqbnpxZHE5cUZUU0hSS24zSWhyZyt2UEpzUWw2bmRPUXl2?=
 =?utf-8?Q?kwdKfQUYhPD+/JF3UzjPjN4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccb4d9f-c459-4826-ed1e-08d9ed97f4af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:51:55.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lmMcsx47KHf8YiLCEvDD1Vd3nXRySykb78pU5qK23TLRJVwtpCdbSgIduoXyAzXF1SZ2dIANtagrr07FsEAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2022 08:55, Tom Lendacky wrote:
> On 2/10/22 23:36, Mario Limonciello wrote:
>> An upcoming change will disable the X86 SME feature flag when the
>> kernel hasn't activated SME.  Avoid relying upon that when determining
>> whether to call `native_wbinvd` by directly calling the CPUID that
>> indicates it.
>>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/process.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 81d8ef036637..e131d71b3cae 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -765,8 +765,11 @@ void stop_this_cpu(void *dummy)
>>        * without the encryption bit, they don't race each other when 
>> flushed
>>        * and potentially end up with the wrong entry being committed to
>>        * memory.
>> +     *
>> +     * Test the CPUID bit directly because the machine might've cleared
>> +     * X86_FEATURE_SME due to cmdline options.
>>        */
>> -    if (boot_cpu_has(X86_FEATURE_SME))
>> +    if (cpuid_eax(0x8000001f) & BIT(0))
> 
> Please test this by running kexec and alternating between mem_encrypt=on 
> boots of the kexec kernel and mem_encrypt=off boots of the kexec kernel 
> to ensure there is no memory corruption in the newly booted kernel. This 
> testing needs to be done on hardware that doesn't have the 
> X86_FEATURE_SME_COHERENT feature.
> 
> Or if you post the generated instructions in this area I should be able 
> to determine if the change is safe.

 From objdump on process.o, here is the function with this patch 
applied, built using gcc 11.2.0:

00000000000011d0 <stop_this_cpu>:
     11d0:       e8 00 00 00 00          call   11d5 <stop_this_cpu+0x5>
     11d5:       55                      push   %rbp
     11d6:       48 89 e5                mov    %rsp,%rbp
     11d9:       41 54                   push   %r12
     11db:       53                      push   %rbx
     11dc:       48 83 ec 18             sub    $0x18,%rsp
     11e0:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
     11e7:       00 00
     11e9:       48 89 45 e8             mov    %rax,-0x18(%rbp)
     11ed:       31 c0                   xor    %eax,%eax
     11ef:       ff 14 25 00 00 00 00    call   *0x0
     11f6:       e8 00 00 00 00          call   11fb <stop_this_cpu+0x2b>
     11fb:       31 f6                   xor    %esi,%esi
     11fd:       48 c7 c3 00 00 00 00    mov    $0x0,%rbx
     1204:       89 c7                   mov    %eax,%edi
     1206:       e8 00 00 00 00          call   120b <stop_this_cpu+0x3b>
     120b:       e8 00 00 00 00          call   1210 <stop_this_cpu+0x40>
     1210:       e8 00 00 00 00          call   1215 <stop_this_cpu+0x45>
     1215:       41 89 c4                mov    %eax,%r12d
     1218:       3d ff 1f 00 00          cmp    $0x1fff,%eax
     121d:       77 49                   ja     1268 <stop_this_cpu+0x98>
     121f:       4a 03 1c e5 00 00 00    add    0x0(,%r12,8),%rbx
     1226:       00
     1227:       48 89 df                mov    %rbx,%rdi
     122a:       e8 00 00 00 00          call   122f <stop_this_cpu+0x5f>
     122f:       c7 45 d8 1f 00 00 80    movl   $0x8000001f,-0x28(%rbp)
     1236:       48 8d 7d d8             lea    -0x28(%rbp),%rdi
     123a:       48 8d 75 dc             lea    -0x24(%rbp),%rsi
     123e:       c7 45 e0 00 00 00 00    movl   $0x0,-0x20(%rbp)
     1245:       48 8d 55 e0             lea    -0x20(%rbp),%rdx
     1249:       48 8d 4d e4             lea    -0x1c(%rbp),%rcx
     124d:       ff 14 25 00 00 00 00    call   *0x0
     1254:       f6 45 d8 01             testb  $0x1,-0x28(%rbp)
     1258:       74 02                   je     125c <stop_this_cpu+0x8c>
     125a:       0f 09                   wbinvd
     125c:       eb 07                   jmp    1265 <stop_this_cpu+0x95>
     125e:       0f 00 2d 00 00 00 00    verw   0x0(%rip)        # 1265 
<stop_this_cpu+0x95>
     1265:       f4                      hlt
     1266:       eb f4                   jmp    125c <stop_this_cpu+0x8c>
     1268:       4c 89 e6                mov    %r12,%rsi
     126b:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
     1272:       e8 00 00 00 00          call   1277 <stop_this_cpu+0xa7>
     1277:       eb a6                   jmp    121f <stop_this_cpu+0x4f>
     1279:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

> 
> Thanks,
> Tom
> 
>>           native_wbinvd();
>>       for (;;) {
>>           /*

