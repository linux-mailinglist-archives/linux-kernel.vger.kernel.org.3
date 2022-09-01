Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386205A8B77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiIACaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiIAC36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:29:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2073.outbound.protection.outlook.com [40.92.98.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC251161
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCS5I890xdyaQenxexb1HMdXUKwTXGkHSwCCTIxOQfm9W5wYBjvbQnwBh4WwqPlj9/npBbfpfaNbHaGXNTsczOIdtj7z4TjDDY+jp6085KeLLxeq3QWAsSs5nNcQH4FRX/r4mlfnY3p1DV3f4SjIfya6vHp/J3WfxSgu09lWY7sJ2dVJ/AddYoh/1O6JOFa2gwhe8nkaLU7Ac/h3Ck489+dwivch95Xm/tf8abMKEAic07fv8WKbzZ5lpNwYwKar6zwUJmJ2ixYzsOnrP5k1gZfHv1fWtTcMs3YFg1+rcQg49J5EojWI5n8/KhUZEBA2nWCAjE/H30Cnskrgj4AonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZFxxa02a+VLXe96fLWHks9CQi6CDfmQ/1JltT0zmu8=;
 b=h8NfKEw9rqlSsbYpMGdcrm9dXcv5r36BkL1G32NuGiv0LJrjlU/3RB/tklanJBBvh4+fvFFouIeC7GyR34N2wqgBbEWMwUlESdK7lZDSNUS9HeVHQuC5DGqG76MUKyCLa0e8qIb3Cg3ZXtgV1RUnHXaqQRH2j4OLZqIJhMyZHJKob1BY062qPnkgm6GmwNlMMZVYrR30R98f8KOQylgq74fDaE4v15GckrHot36ijxn69y+RoXVyZD2hyEJvgGMzaa6f0SgJ3ji1FfTAxaYQgxwXlr3T5LJHIpPzp6fVLW/qS3Laa6MPgp+9JUgS9Z9qiqlrQstPOpm6C8Ivh7avKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZFxxa02a+VLXe96fLWHks9CQi6CDfmQ/1JltT0zmu8=;
 b=A+JoZi9zOVbQjQf8Dj2zGXDfOd55YGf0PyJq5pUZJAcq6mCPnBb2x8Cjx0awKWLdaCqBPS//f9qb/dgbAMTmzu9ET7ntkmZyQ8tRCubDiCTGNh0NWL1pPaDBN64SmZfMqxutP9pYMs9OeoMRtPRNeN7IhtTqDBsEn+yOCQs3FHP6XdigXQzzwNuBKO5kS3CSCuB1WQqeXN1n/SSWtKZ4Rz8oBTIZq7bfTUUGIBIi4e2uZtcKjw6BamcMI1WMwIQ9uJwERWuhXfQYEQkD1C5+5bQQY/L+EyaTblbX/ziqz76SWHiG2ShB2x4Hk8isauXbJaeXmHlptJD0IVKHyC4Eww==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYYP286MB1360.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 02:29:50 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91%5]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:29:49 +0000
Message-ID: <TYCP286MB2146BEA44B0B645B08372D24C67B9@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 1 Sep 2022 10:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>, kbingham@kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <07c91a50-bfb0-acc2-f4aa-cb7bf53a3b50@siemens.com>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <07c91a50-bfb0-acc2-f4aa-cb7bf53a3b50@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [hNn9SHPpHgLULNEt2TshZu78O8hVZYhN]
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <e6443d4f-9ac8-226b-ed67-428e8ea06fc0@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da610196-33cf-468f-49bb-08da8bc1d7f7
X-MS-TrafficTypeDiagnostic: TYYP286MB1360:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy5YKuX8lXsSCgO/Jeo8nyY6ML9ZTsE13GrI2GeQTr3ldSL432sdgw34rGn/WqS9s/v9z+QI8+K7NCfzcdNRVWzAaPW6CcxynBSqyS5EhLM6qZjj7w0qEHzend1xNVIAqZPmzkUttx5F7JamuWdWoOpdevOv2J/VpI9g/qJuxvqX68I7F6j6mZtXr93G8Ij6xqGI3GW7NG0CKv1vyIBFJbmyjXyqohnE2idgjk4Wh/do5Fml9rcZPKwYbissXK/uKiinTDIDOOUw03CI7BuzMbfLuhtiNLnvox1aNx/35yfhBSqh9va3SBpMz2vVaKmmwtisWdyfd9/NHAz5v6JnHkEIYqDUZad9uTER8oXzPlrQlSWQxESfh7noSECEEkEVANmJuNvcrPYS8C7tdozGbKXTi2NHxK1RyZGB/BHokrQqhKMYFt/ezC4e6TXa0LNXnFSe/aAqzDK4+VzG3eOVgz4dWZdYACbfKaiVriKcZ/unSZh1o9IgSqwgUjpp8UrGDukdNGBIbwaeRIlN/ChZPVV1q/c9fXMfVVscDCrtjLmMFr7hri5yWZfpWsy5c3CyEgzMvf0eXheHmV/QJeZi+NlMllswmrVss8H2NdTEIiEJfblROk28XF3HcX7Wea1TDNStbbbihYQ2zYaV0c1RxmcbZvogdeU5+S0KJA/td22lmBmRTqycooOgfloKSLY5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVXckR5QUlnOHVMb3ROcldtVmt0bzZBdGRRTGJmVEg4NU5tVXRSb0E4Mkky?=
 =?utf-8?B?Ylk3eEwwTS9vS0dkSjY2QmdVSHZIczlTSHRsR2ZQUnVZcWpJZk8wd0NhNmN4?=
 =?utf-8?B?bEhjMkZML09lVXJPbHRENkxLMkpHQ01aWmY5OGVzRnVWM1doWlFJaFVtT00w?=
 =?utf-8?B?Yi90Rk1ab3AxcnRqcXp1aGJNdmkwOUFMZTUycjNxOElOR0kwMnhmREp6enlp?=
 =?utf-8?B?RkFsVlZZRWJ5dUZBV0Y0OTlBNFRjZVcwNEEzeXhDVEoxa1pxVitJczlQcFdB?=
 =?utf-8?B?WXMvVDdpMG1qbmxFMkRPc3NNV1NYcE14TjZJNThTV1p5RG16dnkwWit6N1A2?=
 =?utf-8?B?VDJLUllWcGdPTjlUdkpKVVpXeEV6WWwxQm5DR0pVOFdiTzhjNkthN0p0Mk91?=
 =?utf-8?B?Zld3dXRLYVpzSVRhMDhSLy9TeEtpV0E4c2NYelhnUkd1NVRFMXBqVkJicjhY?=
 =?utf-8?B?UTFnbWdsbFZxV0VTREFyd3pIV3EzeFRiY2IzUlptTzZDOFZPS05nU3pzN1JQ?=
 =?utf-8?B?L1d0eDhqTDd6bE10ZWF2bzc5U2VrVmdpZDF0TExNNkhrU1NPbmJiU2tBQVlI?=
 =?utf-8?B?cXJ1SVBRVDRIVlQ0TGQ3Q3B2UjhUZjhLcGNyUExGQWJ0ZXZIZzlpYStYVDFq?=
 =?utf-8?B?N2hPQVRIWWpDQ1hQSzNEZDBGMVJ1NlNtOVk3alNRUkIyVlRvM2Q3Z1UrSnh5?=
 =?utf-8?B?ejNEWGVLMkJsdW1USjBidHZuV2RTeEI3d3lFQlRnakgxcnJ1MTdyd3hJeDl2?=
 =?utf-8?B?WjJ4Yzl0MHZTLzUrek9xZUdwamZaMGZ1aHpJNzRaOGNVME1IRXkyMG5jemVY?=
 =?utf-8?B?R0RFTUF3NnhYajBSS1dVTmpFUDl4VHp4SlJTdmhpa01LSnpDT1crYWlUdnVH?=
 =?utf-8?B?MWRxeTFZdm1MOGdoOE5wQlNteFpDdnpwSGVpTm5SRFRES3ZhbnVLeUpzQlVs?=
 =?utf-8?B?Ni9hRXArQnp1dDFOdGtRV1pzaDErcjBXQ1FoZEVmTGVNYlNTVHRNSWJiY0tv?=
 =?utf-8?B?RUxZbUE5ZkU0Q29kb0RQYzE5cHdnL3lLSUwvSzA0NU9oMUZyd0ZUVzJDWWNV?=
 =?utf-8?B?TU1XalJWQzJ0cWE0dkRrVWlyQnZmdHhhTmRvTEdQSXFKeFExazM4YnN1eEFr?=
 =?utf-8?B?L3pldmt2Z2c0V2p2VnFveG5QeDB3aE84MWFDOENhNUpnTmZtUzNuM3hEd3N3?=
 =?utf-8?B?b3dzNHNvdS9iT2JmWlVIL3FmbmVKUVB2akNnM0NMWWJtNFNHbWFVMGtxNlBy?=
 =?utf-8?B?SjRBMmMzVnFFNU1kNFNUd2xKSDdCM3d6Y2o1eHBRalBLSVhqQWE4eTZMUFh5?=
 =?utf-8?B?Wlc1aXZiODQvdngzWnBTQldMdnM5U3pTYTJsalQ0N0RLNmwvVG1KK3F6eno2?=
 =?utf-8?B?RmFiUXM3Uk5CcjNPckVvenRuaEVqUlNsanhCNDR6alBJMWlYVjhmQ1pkUDhY?=
 =?utf-8?B?aGt5TFNDc2N3cklSYWpsL3FxQWN1Nk1pdXN4eS9ZY1dhZE1VTDYwOVMyZnEv?=
 =?utf-8?B?N1NhZC9NZ2EwK3lBUENqMG90ZkVEeUF2VmNhR0VVRW9rSDkvaHhCNUMvTWdl?=
 =?utf-8?B?MDVEOXhoUHhEbS9RdllrYkduWXZXQ1R3LzhHbThIQmlRNzdhYVRUTlI0dk9B?=
 =?utf-8?B?S3VGVHE3KytUbHRPZmxhd054ak1SYnBWbDM2UTk5U0Fvcms4TkJzRThCUGlY?=
 =?utf-8?Q?IOiCdtkpo+Scprgm2Xkl?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: da610196-33cf-468f-49bb-08da8bc1d7f7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 02:29:49.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1360
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/31 23:01, Jan Kiszka wrote:
> On 20.07.22 14:27, pngliu@hotmail.com wrote:
>> From: Peng Liu <liupeng17@lenovo.com>
>>
>> Below incompatibilities between Python2 and Python3 made lx-timerlist
>> fail to run under Python3.
>>
>> o xrange() is replaced by range() in Python3
>> o bytes and str are different types in Python3
>> o the return value of Inferior.read_memory() is memoryview object in
>>    Python3
> Means this only ever worked with Python2? And we now hard-switch it to
> Python3? Not voting against this, just confused if it was like this so far.
>
> Jan
I think so. I tried the other gdb scripts and they worked for both python2
and python3. I guess timerlist.py was initially tested only with a gdb
with python2 support built in but not one with python3 support built in.
>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>> ---
>>   scripts/gdb/linux/timerlist.py | 4 +++-
>>   scripts/gdb/linux/utils.py     | 5 ++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
>> index 44e39dc3eb64..8281da068c5b 100644
>> --- a/scripts/gdb/linux/timerlist.py
>> +++ b/scripts/gdb/linux/timerlist.py
>> @@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>>       ts = cpus.per_cpu(tick_sched_ptr, cpu)
>>   
>>       text = "cpu: {}\n".format(cpu)
>> -    for i in xrange(max_clock_bases):
>> +    for i in range(max_clock_bases):
>>           text += " clock {}:\n".format(i)
>>           text += print_base(cpu_base['clock_base'][i])
>>   
>> @@ -157,6 +157,8 @@ def pr_cpumask(mask):
>>       num_bytes = (nr_cpu_ids + 7) / 8
>>       buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
>>       buf = binascii.b2a_hex(buf)
>> +    if type(buf) is not str:
>> +        buf=buf.decode()
>>   
>>       chunks = []
>>       i = num_bytes
>> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
>> index ff7c1799d588..db59f986c7fd 100644
>> --- a/scripts/gdb/linux/utils.py
>> +++ b/scripts/gdb/linux/utils.py
>> @@ -89,7 +89,10 @@ def get_target_endianness():
>>   
>>   
>>   def read_memoryview(inf, start, length):
>> -    return memoryview(inf.read_memory(start, length))
>> +    m = inf.read_memory(start, length)
>> +    if type(m) is memoryview:
>> +        return m
>> +    return memoryview(m)
>>   
>>   
>>   def read_u16(buffer, offset):
