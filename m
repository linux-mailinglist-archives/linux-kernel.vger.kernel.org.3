Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B675A73BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiHaCCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiHaCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:02:33 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2036.outbound.protection.outlook.com [40.92.99.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7AB3B0A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsLV7ZvdPqzh4fXhxOHUGAGEP9hyuOAlYfnorirl1uHZJyjT1Fk9JYlHsPBtUzXI9irEQj3stvLcUNFNI6Bd4jvgJCM0efXAo2fQdoEcae32eFzPG7vF4qD6a5vQ5tt4ScjFAZNCPw9ScyNYaItA4wYuElbZYF4nyutL70s0xrUqNL+rzjH5gdtOkro2f074V5344emPMLaWnNma3bUu1PXAUwgRAw7Eupv0hEbxY+I/1CQQeOf+tsz1dGKC9GcXRPr5g8RTCJFZw/WA1uvWra04cRV99MUtHpfUJE/BPmqU25czTAqjM5mgSiw6ywshmUfu2rNtDnPxWxW7yIcXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxzre7LMy5flD5yfQwx7yn2MSC7Q8FSrtWHbQxjZdII=;
 b=CuypGo9sfp8tF/qoLemfdKe+7zxVbuHBXibQE4XuBbGd3ITxwWoCfv0TMDSITldNqR6SVGTvSGHx1BLopFPEVI++2STik77+pcgpuFMM8yW/757X8f9G+P9VIJys8kFk1KuYPwCqPTJiYJ0px88gEdi+Nw63p2NxDa5IB1gPEUZXnkJdUmJgopU6ougv4G+9PwoYKu0oOzmJA1D5dZ6o7lknKFefSucSczxo7YIyJOria9SK/WYfoWobCQMkjeYjwCCT8RgCJKCts5MhNa3Xquke2Dk0ZE2Nsd4WEYh41USsEFuRPMEoDqofosdZ/d1HGIeVJPYbS7Z5nOHp5n508g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxzre7LMy5flD5yfQwx7yn2MSC7Q8FSrtWHbQxjZdII=;
 b=mV/IF2gpyWHjeyioCLlx14VyqJoTo76tEf9IXffKUyvqJNhvEBBAqng2nzGD/CbTA0soPn/rMhY9iuqYcma0BJRULRz3pXj4TI/laurTjN1b5iOdDH5dGl8Hhf8IVcvvAv2p8HBFK8u2EuxIdct4fZRyzk/7RHxuW8ur1rIMBb9uZVqlaymV+DC/peelRq+TfpN2lZt/ndo9k5VCPNQH1xj7BsVzaxnIitoGvwnEvfXI/cuMmtmJlgudbYyeN/+mLrdfZC4ze8ABcp/ms3mPjwrGYuAmJsX/4GTIsiAQQvDIKW3OTklxa/IaSRKe7eJqp3W8OiwyJqaQvw7rLnVl6g==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TY3P286MB2949.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:314::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 02:02:29 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:02:29 +0000
Message-ID: <TYCP286MB2146736D3C8A193DF7B92F85C6789@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 31 Aug 2022 10:02:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Content-Language: en-US
To:     kbingham@kernel.org
Cc:     jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17633E7DDA7739F53B1C4CF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17633C3B6BFAFD8951BD06F0C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17633C3B6BFAFD8951BD06F0C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [QMoXBllJS2q/tBPTpcfIkdQpgUp+RKjX]
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <92eda12b-81ad-9b1f-b4af-da41f47647de@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d6c1a97-bfd5-46f1-4fd9-08da8af4dbc5
X-MS-TrafficTypeDiagnostic: TY3P286MB2949:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g957pl89Iu3uQV3iSEzMud4G4KTXUb+rlVj3SY28AP03vYxChbzF48YviuhYStd4boM4bFmpADweZh3LgJ8x24+5PtLsVvwOg9OYbxhzo0GlIQsVOIDZHnOV6cKcn1P9SNg8Nd6vg0NDacJh2ijmgyrdMypSPECIwp/l3da7qvbDVPJipc/3WnFxV3JB/xvQnv/+Q38JsoL87lbTOhTF6XvujUKjtY4z6PGNj1jp+sVGzGS+yODcvn/1gMs0AaMBmE+XbiJKTIH2zwjVvC+x3eIkkAvlnImyPF948OYSKRMTs4MqTSSY+4BquqZs/cgl/vRVwoV4Nrub/Dby3MA9PfO0kwBbPRB7xn+n5FZZxgmjLdKbn4XKBQgw1wz3mUluT+lcq/WH2pWSkRnL0KAqkk5WTGA/Beyt0jT3j6egqtFKgip6w+EYwNZv6ywW76+Hk+1P9AhL9qJv2KbecxopjwYYQcBWbg6Pz43/rEGM/fEInZowFXnruoFNgGmLCt5JYOH4jXPW8ZHLGsheFISxLBRoRbwd+N/FOrh70pmNAHPP4yqBnmZkCJ0rAggD5L5HNcajW//CEwKGRcRgnX30k7NBL+foReaT26heghzoasMydCTlNzgu6u17filWKbSm4w7gFsgq3x9MBd0O07o/Ix4jkzkNq1zZS7O8rN3v1kwXosi2VjQvQaELKe7Mrz1f
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGN0THUzM1B4KzVoVGNTZjIybVN2dTNUazFMMHl5MGFJb3dKODVNbXVlaXdo?=
 =?utf-8?B?MmhMZzlIWmZRenhONWk2dlBPeVJuZEtTRXAyS05oS3lFRkRNMU5iQjBoTE0v?=
 =?utf-8?B?YUJnd2kwZFg0eWp0Y2diQi9Cc3NuOHFtdGY1MG5DOUViVjZVVEd6V0RlM2hy?=
 =?utf-8?B?MVpqNjBCbHg5MzNqeWR6Z1gyVlQva29KbHF0SkdCR0F2YWZ3eG5KRXBZTVVr?=
 =?utf-8?B?SUNTRDNmbXZ4cGF6SUNqNTBYaFlwWm1mS1c2R3ZwU2dickVaamVLckxzWlgw?=
 =?utf-8?B?alB0WkNHeUJ0eHk0emZTYmsyMkVFK1VhR1lZczFnVkxPM09DMUpYYjNNeGRX?=
 =?utf-8?B?Wk9QVDZxTjNxc2k4TG1QVng0VzdZaGpmRkFnTTFNR0ZqdlpxOGx0bEd2Q09X?=
 =?utf-8?B?R1FYaElsdHRJK21YWld3U3Z6aUZSWFlmSEVyV3ZuVnlJWVNPZ1YzUDd6ZmJi?=
 =?utf-8?B?QjFXMWlRUFRaSWZlaG1ITTBvOWUzR0lweUZXNGd4TU1NdnhoSkhPb1YyejR1?=
 =?utf-8?B?dDVHMitrSVpJcUdqYVlCQ3FYQlppSENaMmlKcnN0ZEZWZlVpVkN5Rm1VRkFJ?=
 =?utf-8?B?UFdybXFDNzNDQ09RbWpPTzJtclFVcEpiOUErVm8zRmxSQ2doaWpTaW5Cejh2?=
 =?utf-8?B?eE0xOG5ZemNXZlJ2aFMrb29zR2hkMGYvdkYvUW8rc2x6WDh2Q3lNaG8wUVRI?=
 =?utf-8?B?ckMrV0lib2pZQ2Rpa2w5SnRMSDVDU2VGcjk2bTNJd1BLeXEvSVRhWDdPMFBj?=
 =?utf-8?B?Uy9JaVZOem5OR1VEckptcDBMSFk3ajdWb2pObFVGWDJHTjg5UUFyb3UyVXp1?=
 =?utf-8?B?WlVPNXV4RW5qM3ZTeWpCU1FocjlsQVZDdUZabDZZRGhBSjhremhFbEI5STVN?=
 =?utf-8?B?ZDhWa0hLUkphbjZzY0Y4SkpVbElXQ0pEbFVKVnY1bkdDK1cyNHRCSzEzZi9m?=
 =?utf-8?B?QmlHNGpLaGxtbGR2L0tJb2hoUnliQzZjSWJjTzZuOC9QVGtVWGozeGlIWjFy?=
 =?utf-8?B?b0M5ZGJYYXpLcHdRNnp0QTJCcEJ4dUNrdHM1VjBaQjF3NDZ6YyttRUIvdGd0?=
 =?utf-8?B?NGlUbzNNZ0lVV2paUlpDSVEyTG1mK3hwdThMRHRPTWNsM0V5MmE4NHdZNVhQ?=
 =?utf-8?B?aTh1M1doa0FtVjhNdkd4Q1BicFVETFpNSmpJeDZGTElmUWxNZXFkV2lNUnEz?=
 =?utf-8?B?dUdQUUlBV0pLcStDSjhCZHVjUWJhM2R5b1ZydFl6Qk5uVGRUcE0zUmpISTlp?=
 =?utf-8?B?eC94L3kwL0NaSWJsOVdFZ0k5YnJXckxmTEE2djBzRDBaS3kzWWVGSDYwaDlw?=
 =?utf-8?B?RjNkZ0lyVDc0N0FueUVjZW02VkMvOFlTRDA4REhnQ0xYRTBaUE91QkJhVTdn?=
 =?utf-8?B?bURTYkpmV3dEeFAyVjZ5TEwrS0d5YUZaT0dvQlA4TU1LUFpnSEQ4SzMvQmdQ?=
 =?utf-8?B?dW43N2ZPaVEwaDk1WHFBQ0tUd2JOU1gvQjkrT0JERFBKS0kveWpjemZHNzUx?=
 =?utf-8?B?SGJTZFM4d2FQNUNLQkRoYlVxN2IyV0Mrd2djSkU1UE93ZDB4MDBRM3ZKdVp4?=
 =?utf-8?B?Nmw0K09rQzI5djdwMDdnYlJ6d3J2SnNyaHdJVDhMR3E1N1VLbHVQV2lkV0Jm?=
 =?utf-8?B?bWoybXpXejVHYVFuYnNsUHBJRGhTMU5HcHRudjM5ZHIvOXREdW14VnhOVjgz?=
 =?utf-8?Q?9490b/WgVwyxmbugxSSK?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6c1a97-bfd5-46f1-4fd9-08da8af4dbc5
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 02:02:29.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2949
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2022/8/22 17:30, Peng Liu wrote:
> ping
>
> On 2022/8/4 16:50, Peng Liu wrote:
>> ping
>>
>> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>>> From: Peng Liu <liupeng17@lenovo.com>
>>>
>>> Below incompatibilities between Python2 and Python3 made lx-timerlist
>>> fail to run under Python3.
>>>
>>> o xrange() is replaced by range() in Python3
>>> o bytes and str are different types in Python3
>>> o the return value of Inferior.read_memory() is memoryview object in
>>>    Python3
>>>
>>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>>> ---
>>>   scripts/gdb/linux/timerlist.py | 4 +++-
>>>   scripts/gdb/linux/utils.py     | 5 ++++-
>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/gdb/linux/timerlist.py 
>>> b/scripts/gdb/linux/timerlist.py
>>> index 44e39dc3eb64..8281da068c5b 100644
>>> --- a/scripts/gdb/linux/timerlist.py
>>> +++ b/scripts/gdb/linux/timerlist.py
>>> @@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>>>       ts = cpus.per_cpu(tick_sched_ptr, cpu)
>>>         text = "cpu: {}\n".format(cpu)
>>> -    for i in xrange(max_clock_bases):
>>> +    for i in range(max_clock_bases):
>>>           text += " clock {}:\n".format(i)
>>>           text += print_base(cpu_base['clock_base'][i])
>>>   @@ -157,6 +157,8 @@ def pr_cpumask(mask):
>>>       num_bytes = (nr_cpu_ids + 7) / 8
>>>       buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
>>>       buf = binascii.b2a_hex(buf)
>>> +    if type(buf) is not str:
>>> +        buf=buf.decode()
>>>         chunks = []
>>>       i = num_bytes
>>> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
>>> index ff7c1799d588..db59f986c7fd 100644
>>> --- a/scripts/gdb/linux/utils.py
>>> +++ b/scripts/gdb/linux/utils.py
>>> @@ -89,7 +89,10 @@ def get_target_endianness():
>>>       def read_memoryview(inf, start, length):
>>> -    return memoryview(inf.read_memory(start, length))
>>> +    m = inf.read_memory(start, length)
>>> +    if type(m) is memoryview:
>>> +        return m
>>> +    return memoryview(m)
>>>       def read_u16(buffer, offset):
