Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5813B59BCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiHVJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:30:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2101.outbound.protection.outlook.com [40.92.99.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B1E2E686
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4ErQqMAZ77y9fYv4fUNgdy3/ZSUumwDqkn3/25BC71bnTsBFHEBADItBDC/JKcjHq3/fxgmPo+4OpfshHecEAAU3Jdlm6Wb+QjVeiNGq0f+ZYSf95zB8zCpUg9x1e66h0lJ5THCAKyeOZ24VU25E9JOpNb14TsLJOuI62XTeR1Oyh9t/XG9ewgIL1vFOXgKv19BCllwNeIipop/xL6Mr24GTspANKS1yNEvpI09l74eereL8k6MdoWdovxlkx2IGvMh2LXL8e/cS00ivmFrwEJ/RMEJ/bXYq3JrAM3zlTkepJqQfptvldfJszEQJApjXghBXPl0JGwxHzNCyp4rJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfhBDohEtcnQ/5ciQ+LBeRqhsHEesf2oggSR3O2+fyY=;
 b=h4MdVAf8NnFuojg+XlVy9dw5mT8mkf7SdFTgcaaRRgMy4Z665w80IDy7hrA46RbhBolAvG86s5/pAkub4AlZXleNVbxbNDxIc6Nia9ay18LsdyVgqljLlgF8zRK8WqHnqvk+8j3TJ5PiXfpHwdn+3OUMAQax0kiISwNDWLhQxwH1/gDAukYQB05fMNW7oq9ZuZsBUGElS7Y/EvF+0foFMlVtSnoLCg/1JjxRXE3acbz7wtETGlj0l7gPSMLf4FioTedh4OI7Ej0Dt2tQLvshtP5IeH5RTnxC2uQD0neItWQkKGkA63hXZM3q8TWG5mXlPN6/oEQLI/k/lXTbZFwhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfhBDohEtcnQ/5ciQ+LBeRqhsHEesf2oggSR3O2+fyY=;
 b=p0I3K3LONiXuvblP/9jx9Qui6eMNC8DXLrJjwx/Px2Z08CrtClXMKoYNXDqPC5girtV2o+fBfvFDijZFs5LDN6Nc25XNYjLibufN7HGFpSxUwCZQocNXYAKadmihud1W0imGXtRQ1bAIFYQ6v5Vt6ZT/5SnU8Iq245wXyHZpXLxRRYwyBppPufr12MWr279uHZK4+UweIEJrssvqJvJU9vngceWtpsP93JDKwxt5p2i7etjAS7/poKu7xwKFAtj66WTt7U7+lILVkDDRb2daF9juD+XAn7djNsxQOk4cx+qzYO+rzCUOuq6niUujAHglPdKLpbMmpNTWm7L3730nqA==
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ff::9) by
 TYCP286MB2590.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:241::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Mon, 22 Aug 2022 09:30:09 +0000
Received: from TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d]) by TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d10b:afc9:3056:11d%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 09:30:09 +0000
Message-ID: <TYYP286MB17633C3B6BFAFD8951BD06F0C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 22 Aug 2022 17:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Content-Language: en-US
To:     jan.kiszka@siemens.com
Cc:     kbingham@kernel.org, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17630AE047E8AD679B37C77AC68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17633E7DDA7739F53B1C4CF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17633E7DDA7739F53B1C4CF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [OGMCMEFIZQBtVGZEY0qbwUv7WCjLObpG]
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ff::9)
X-Microsoft-Original-Message-ID: <0ac5a378-c7f3-d8c5-a182-f829c40a5516@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9709eeee-d351-4b5a-5a47-08da8420e822
X-MS-TrafficTypeDiagnostic: TYCP286MB2590:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbp5NczsJdatorfrlBGsUcVaA2tW+ULOb4XaIiZoIXOR3hqPgVbIIqlVo/1JzZWsqYk4Vdfx7yL7czskwVXkTVGI/hBasPP5db7zq2Nu/wd0nbUweMrG7h12wd+h0QyFXNqOrxFe/gmeHW7ugqn1+sFqAgXm/U3+zFZRRF25QiElNWKaGTlIDGtTDRaUI2lpm3ZngoC3Ul/xQo4YTXCVDxKA0alFqLLDK7usIB+rcG7OgBsjKlXqDRpo7N6Ppa/oB1GKOxmz/nEiEgX4q+OQNyB9BQ3JzY60MeVhL6CGUcRgya98IZJZsJkPMuCHxRticL++tukuzKoJtySU9P4je3skCmD/9YtFFWiu7UWay/8qTErlpepG/PnOXIZE20Nkwgk/0/dy4kMzCpgf5Q9KaXj1YCODYsPn/VGYxJ9YsUr1cWNC2Ni69amgkJAAeywG4ilqChHUeUMxAiiQuKFlgKn1PgCu6ErIL6jxkKnAogbEEdK7Vf72mFZr79XL0LOvu9mlY7x5bcUVELjhnqMCaWfb4+D10Wstl8hzkWMkSlqHuDB+FZ9mOuyqvud1PEF8Txj5LnxoVyzPhbpmZzy1sqi5tCOZIMPYdvRwM+WYo5UL+6ZPOqGLkOfY0XcarUtFZsbNot73E+aWcQm1S7mI1KHDr6/bZzcaG4ls5zJXW5LeZ2z1svfXSW3cr2lk3801
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3QxZHJPTWRaZ3NodWY1cjJHaGRrUW5IdTdxeEk0Y3dWcEJJTDhwQVhiSk5F?=
 =?utf-8?B?SGVpcjVaMXJCYk9UditRZXhES3VRNlNWM1QzZVlBQ3hBUzhDbzgvNWozSys3?=
 =?utf-8?B?Nm1Obi9ZUG8yQUNPUis0U1prbzgvTVhKNWYyZW1zbk9QV0lxN2poUkFLZ285?=
 =?utf-8?B?REt3YWRBL1JTb092bjJSWGdENDkwUlJkVVZkMVFya1ZLem81eHAvYzRCVVBL?=
 =?utf-8?B?SjVIRHFyWExJN2d2L3hJWGtFUnBJek5sUEhSeWVveHNacWNqTG1HaUtvWHdR?=
 =?utf-8?B?L1NBQ1liTG04SjRQcHZvZWNyWm1nK2FKM2tPRmJUT2R4elpUNm1WUnozZ0JR?=
 =?utf-8?B?QnRRNFYzWVdKdm9WSW0vZVpET0E3eW55d1R4NWlFSG9PcUZXeUpRbGlhSGpM?=
 =?utf-8?B?VW9CeXM1MUVncjBWck91elV3MCtPSjhTbGhLS1F4MXY0c3FxOCtIcTAzUW4z?=
 =?utf-8?B?SWFUNHpmL0JaQjVIN2JabFVPSXRwN1lVQ0FPYU14NFROVjZEWDhEUnJTdnBX?=
 =?utf-8?B?dTFMTWxwSCsxbDhEOTFUMG9QVUJtN0NqRG03VE9CMTlDSkpGTUZEdEpqaEpH?=
 =?utf-8?B?M29oOEwxY1JEUFBkYkRnZjB1Z1Y4a3FhbXBGRklrbWFkVWwwYmVrUElkV3lk?=
 =?utf-8?B?OWRib0J4ODBFa1d4KzZJMHFmdDlWMnhTWmQ3bWxidkdGVmUwZ1RWUWNZTzlS?=
 =?utf-8?B?cDVFcWp5U1NucjN2YUdGN0llTi81UEd4ZnN6dTRoVjFuRElMc0M0cTZRbU9m?=
 =?utf-8?B?VG9TUWpNVDJ0RWNFSStyWkJMVlRpTnp1R1BiOExTYkFNUGNyYVIrcWNZZElh?=
 =?utf-8?B?ZDhjSElsNE5nOW1TaDFXY0hBdmtrRkhuaHEvbGVTcHIyTkxUZk5OYmtFQmd2?=
 =?utf-8?B?QUkvb2NQc2ZKQm9TTWc4MG5xd2dhQUk3NGxnZjFLZHNHWStaWVR6dFNVKzk1?=
 =?utf-8?B?WTRqTkU4WUFweVVFVDhua3drZC9QcnlkQkhsRE1jWmJXOUh1ZXRTaVBXVmpy?=
 =?utf-8?B?cFlFWk51TE1oQVRQMFA3elhpaVNka3YzdjZGS0Z6WG1WSWdwd0VTUkNkNEs0?=
 =?utf-8?B?NmNFT09GQkxLdUVjMVJ5TU5salYzTGM4S1pSWTRXcm9IVGJWZjBUQ012NkRH?=
 =?utf-8?B?d3NLdWlSYkRGUEhhdXNzeDlISHFNTUs3aTdJQTFtc28xY2hFRkZNc3gxekx5?=
 =?utf-8?B?YzAwczZKWGpieWQyZjdGYWw3cDduNmIvem1rWVlvbXV2cUVqbm9aRXpNVnNl?=
 =?utf-8?B?V1M2WFc5YW9kL0tYVHFvdGNmRUtNYVhjd2lKbjVEaG1VQ1lMZUFOTnFtenVO?=
 =?utf-8?B?NnJDaWNGMlREV3N2L0VReUZrOEN2MFBDVjVoekphYU9BZjdIaEhPUU1wQkhv?=
 =?utf-8?B?YnJTOXR5RENIODZzalFyRXpXdzhzcVdjelRTZ3pvb1p2NzIvWFh0VktMcW1R?=
 =?utf-8?B?RE9yU3l2eFRhU3FhUWxsdWJUNEtObmxUdTJjUEVOZ3RCSE1kcVJpd0d0dUhI?=
 =?utf-8?B?M0JOQm9KYXhldVphV1pRUFQ0YXl3dU5pdnN2UVYyRlAxNGpZOFpGaWZoVHVi?=
 =?utf-8?B?NVF0OERabXVOcmhEWGxtRk1sbUxLZTVycFJnR3hJOGxBN3VqRkUraTI1VmZ4?=
 =?utf-8?B?b1RnSWRzejc2R1BiQm81Y0ZkZ1d6WUtITjhiYzFYNVp6T0ZkMTRtNDRRdzRa?=
 =?utf-8?Q?/JzhZnKyT1wtJavZx1ow?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9709eeee-d351-4b5a-5a47-08da8420e822
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 09:30:09.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2590
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2022/8/4 16:50, Peng Liu wrote:
> ping
>
> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>> From: Peng Liu <liupeng17@lenovo.com>
>>
>> Below incompatibilities between Python2 and Python3 made lx-timerlist
>> fail to run under Python3.
>>
>> o xrange() is replaced by range() in Python3
>> o bytes and str are different types in Python3
>> o the return value of Inferior.read_memory() is memoryview object in
>>    Python3
>>
>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>> ---
>>   scripts/gdb/linux/timerlist.py | 4 +++-
>>   scripts/gdb/linux/utils.py     | 5 ++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/timerlist.py 
>> b/scripts/gdb/linux/timerlist.py
>> index 44e39dc3eb64..8281da068c5b 100644
>> --- a/scripts/gdb/linux/timerlist.py
>> +++ b/scripts/gdb/linux/timerlist.py
>> @@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
>>       ts = cpus.per_cpu(tick_sched_ptr, cpu)
>>         text = "cpu: {}\n".format(cpu)
>> -    for i in xrange(max_clock_bases):
>> +    for i in range(max_clock_bases):
>>           text += " clock {}:\n".format(i)
>>           text += print_base(cpu_base['clock_base'][i])
>>   @@ -157,6 +157,8 @@ def pr_cpumask(mask):
>>       num_bytes = (nr_cpu_ids + 7) / 8
>>       buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
>>       buf = binascii.b2a_hex(buf)
>> +    if type(buf) is not str:
>> +        buf=buf.decode()
>>         chunks = []
>>       i = num_bytes
>> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
>> index ff7c1799d588..db59f986c7fd 100644
>> --- a/scripts/gdb/linux/utils.py
>> +++ b/scripts/gdb/linux/utils.py
>> @@ -89,7 +89,10 @@ def get_target_endianness():
>>       def read_memoryview(inf, start, length):
>> -    return memoryview(inf.read_memory(start, length))
>> +    m = inf.read_memory(start, length)
>> +    if type(m) is memoryview:
>> +        return m
>> +    return memoryview(m)
>>       def read_u16(buffer, offset):
