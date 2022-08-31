Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A855A73BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHaCCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiHaCCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:02:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2074.outbound.protection.outlook.com [40.92.98.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843CB2D92
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTumgiJz8tHPM8Z8x04/9oliTwpJ42oqnRLOPKIRmS02JPr8aroePdaUdR6lgjTH6KyL1/X/Q+i8MA324Z9cM9/x0GIrzAB/cs6LvsSMk8qtcSr1Pc3JghGjFIlrN4G7g1bHpQwSDR7PmGtE2FHIMe5h0HdWVGsOEekH2bEFaSlntzZUvp3ekY9ax+eH0/co50oqJMx7evyxu0zWM/I7/NuvmINKzqJhKnQAtFs0FHozJr59jipPoNp7Vjo34fB8u5sqTzdAB4qPJasnavRORkvq2OYB92OChGE0N8JIeF+hdknRgwlRFTfGs1Xp4Jz/2QOcPEm7lyOGDuW6tC4gUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnB+dS5ZuEeE8i20ki7ZmyakDEXvhG+Q/43BX5vqlcA=;
 b=BN/pKBVhzmQPuvmkrOQq2jBwI3u0ODyGElpet38pLH+RAZhUKbqFUBZ8UNQKE22cWu5vGOfR20yM3N+kuyrNHv2hCkW7O8BVWESmGQ26mrZAPVl7t5g5Xnu5OlQUJIhg0iervv8dhHuhxX7svHcngM6PlSV9UzWlQCp6pBKuFQAFeyeUwsJNDGmawsYY+nFXNFyYwebLU0A5cl0OGCMRvNzHx6J9CQVsWkpzsjJKjkBO3jYuNps3Ehgl6LJEBW1s+gpf8vq83Jj6QOKcnDa3DB5rAmWoR/hAcBqivz5OIL8r2c8wf27T/Fko05Kd6Wh0b4sd4rD94+DBCqCzygvd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnB+dS5ZuEeE8i20ki7ZmyakDEXvhG+Q/43BX5vqlcA=;
 b=ZEg2VsebR48+rMT8B3JpqVJi4l4pQSiule/XqeUCkMdEsyLdHYWrl5596WYwpGtmCGAQ2LMZqEUdEcVCH6+DSFLySO0VBhfnynAz1v6vE6mo8KDR0VHCsAYprYSdOJ2uJepbvHn30Qk7cNz+LOezVUnLhxxFuR83BC37smYkpuwKWf3R4RFGGDsaKUpmI4J1pCb2XUwqgUAmvX58mclHWSy2jm+7bWH7Rx3MbgxC7cdBxVj6/gD+r+OepuyCx4zyXwZbmXV9ZAdTZdT60du0OqeHl2UVtr3fDV7lEM6HrppVCm8gN9JhekkJEkQ/2pgig+aqKaPqgaXOftakaVk/iA==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by OS3P286MB1687.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 02:02:04 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:02:04 +0000
Message-ID: <TYCP286MB2146AB9675875CDB8DC6F5F7C6789@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 31 Aug 2022 10:01:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct
 timequeue_head change
To:     kbingham@kernel.org
Cc:     jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <TYYP286MB17634911E6C6951ACD128342C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17631A31235CF10F476FFC34C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB176395568EC0A0C49C63C658C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB176395568EC0A0C49C63C658C6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [smukgGZQk8Y6tMhlk2CfkYCHO3DMFi5H]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <77d7bace-d7d6-05d8-7986-02229676188c@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32641a16-5622-4340-b371-08da8af4cc9a
X-MS-TrafficTypeDiagnostic: OS3P286MB1687:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6d0GAwfQKIHvYnJH013wX4TTGTtObFew9rm49aAxAA6N3R3ESVB1fZpsSwbu6aKE40Pja2taQZOM+gDhdHrmi8FM2v6AAQpOIS7lTPa9g0kuX7taHKLETH8GXXD0VsBIOQxBbkExoxDiThUJj6L6n+qmeOVEOdlU4BiJx1O3kzCDRMJHmbv2S/6IGq1bcUMUElSnx4uE3TLdI3drfoby0lgd1TMF1zg+yFMuvKZm/MKG3cC9KvMt6uSf5nlBMLlunX4ORarepOVTNvXMr9qvnXGYobkYV1xgM+e+ol3LFRlJRxFoakPlbDmY5U1iynMrt3qOxZQGqMrtCLnSaYQDeemnJsMr7hdWYrv9L0VbdRioqFG0AQCuauKX4vuHDMn37YmsWY8VDB/arC7MynksPBO28LMjDiA3KikgQ3PkYY64PFqjB5pn5WAtbllobCeWY5iasoBEAi3OyqaGzYyHIYcV4q/597Y/js4t9xP9dUZm7Bw/BPrAVlxkH/4Du3e/8+EM2H+g+PxunacAn4V3pSrlAWe9LPrNm2OB0mGVaQ/dRLffZ+blyHtxTsQiO8deHQNF70s2/dNHWfx2nWrDzUUAqQu4aYGb7mHlb3HHLeGrIFz1TIZxXNWyiNZDrRsLJMKyP7Ts0yAhAzeOCUAk8UtbdRAc2xy+7AB8HZTljEcERghWONKL9ZwX9sYhux4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdRWi83QXY5WENuQ2E0eDdRT2lGRmY2QThKa1hrOWRsVVV6WjUzT1d2VHpE?=
 =?utf-8?B?dVBuSkdhSzJLYWNrTG1QcEJIWENnSGorZkZmQ1JjUFZDZWJKSDlkNFNSZWZ0?=
 =?utf-8?B?VVFhNjF5L2lmMzQrejAwbElmRGdDRHR6T3dIZ1RJdzdqT3J1aW13RHVQQm1u?=
 =?utf-8?B?dXFQdnU2VURNYThWSG9kTmppSEFDc1lud2JIbXJSU01KMU9vOWdpdy9icThq?=
 =?utf-8?B?ZTB0Y1lWY2VtYnhxd2E1NzA4bHBPM2N3eTNDR3ZKelVLU2dJYllPd0lhck82?=
 =?utf-8?B?QXRTdHhYMWRja3pmL0JUSmJJQ0lSZlNYK2NXZFVybkpCM0V3UStsSTdWN2Vq?=
 =?utf-8?B?LzhvZS9SY2NtWW9KRWZkNi8yUnI0c0JydEs1Smw4Y0c5S2hqc3c3LytLTFU4?=
 =?utf-8?B?amk0M1h6WXhHZVNKMC9ucWp5K2ZNQjJGVXVnTURiWnZkeW5xM0d4dE1OVHdX?=
 =?utf-8?B?RVVBOTRWT2VzY1RsVHF2elMycXgvZDZ0dnNqTnpIM3RCaEc3dU5KNHY0enlk?=
 =?utf-8?B?WERITHpOczAwVEdqQ2ovMVFpSEpLUk5hQ2NRSndJaDdyenNtdWlKQjhVU1Rj?=
 =?utf-8?B?M2NUc3RQTEdVbmVJbWFwNEJqQlhzRGdBdDRyUmhTSzVsYi9ETUhmTkFtWUky?=
 =?utf-8?B?SmpiYTUvQzlUbHV4QXN1VTNOOWxQUXZlTGNOR2NQako3RGRWUzlnYlJSNy9h?=
 =?utf-8?B?dXlBS1J0OUVJK3l3dE1lQkhTaFBNZ1JFSmd5bEtpZEZMa3JYMUx2UWxySFZT?=
 =?utf-8?B?QUlTaXVXWVQvTTNnd01MT24wUDhkSGxORTFiUXVhZ21JM1B4YXcxVlUvZFpt?=
 =?utf-8?B?aXllVzN0bFVYcVFHblhWR1JQRmlYOG9PU2ViNVRyakZURnI4eUpsTStWM1hl?=
 =?utf-8?B?K3FORXdjNjl0NXBnRUJXTk9QQ0hsUlYxQVhsVEN6bmI3cC9BbEdaTmlySktq?=
 =?utf-8?B?ZWo1Zys5eVRIcmRyci8wZEgzdFpUZEMxak5yWlBpYkZaODYwZHlmT252V1Fv?=
 =?utf-8?B?dnM2QjNMSnZRRTliY3N6d2gzcTZvOHJmdFJuayt2MjNjZjNxb2ZRdFo1RmNR?=
 =?utf-8?B?S3JMT2FONmNXeVhiY0w5MHpZWVM5eTdna2pxa1VEMjhDcEkyR2R0em14WVVH?=
 =?utf-8?B?Q2ttVk5wYUJDVUhueExsZzMvcWZLY1NkbzdQZVFwd2JvNzlFanl6YzNueFBm?=
 =?utf-8?B?VENVYUwwUlVna2I5QkJpQ3hmelZKQXg0cmJrTG92TlpMMDA2YkZQSG5waEFS?=
 =?utf-8?B?cVNiZ0NEQUYxbkhBMXVtTG50TE85d04yMzFWR1Q5K2RBdkVkSWRhc0hKUHVo?=
 =?utf-8?B?cXRRTHpaS2NBdVQ1aFAwZnpsN0Y2bkYxQmRUdlpjMW13UVFXQU5KQ28rUklM?=
 =?utf-8?B?dlhlZFo3c1NrMi8xTnhHeWg0OVV3dG5wZHlweUFjQlU1U0k4elpKNmdJckhr?=
 =?utf-8?B?bE5tN0YvMGtQdXVja1liQmppNFZJVlEwTTA0UTVMSm03Zkt5MzI4OWdqTW5H?=
 =?utf-8?B?UmdhRlVpMUk0RDVubEIzd29HQ1NaandteU1Bd2JIQkhrTFFNWi9rMEdQU201?=
 =?utf-8?B?ZFRBUHRPSER4VTJkUWtMeDVRWkpHZEhMMS9pTituYmxodWRuTWIwWVVpdlV6?=
 =?utf-8?B?VWx3M09LUjIyWkp5YmNYaEx2QU51MzA5WWN6UVB3UmRFeGl5OXlXd2ZXTmZr?=
 =?utf-8?Q?pSK+ezy6sf0TJ9cJkHws?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32641a16-5622-4340-b371-08da8af4cc9a
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 02:02:04.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1687
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

On 2022/8/22 17:29, Peng Liu wrote:
> ping
>
> On 2022/8/4 16:49, Peng Liu wrote:
>> ping
>>
>> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>>> From: Peng Liu <liupeng17@lenovo.com>
>>>
>>> commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
>>> timer") changed struct timerqueue_head, and so print_active_timers()
>>> should be changed accordingly with its way to interpret the structure.
>>>
>>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>>> ---
>>>   scripts/gdb/linux/timerlist.py | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/gdb/linux/timerlist.py 
>>> b/scripts/gdb/linux/timerlist.py
>>> index 071d0dd5a634..44e39dc3eb64 100644
>>> --- a/scripts/gdb/linux/timerlist.py
>>> +++ b/scripts/gdb/linux/timerlist.py
>>> @@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
>>>       def print_active_timers(base):
>>> -    curr = base['active']['next']['node']
>>> -    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
>>> +    curr = base['active']['rb_root']['rb_leftmost']
>>>       idx = 0
>>>       while curr:
>>>           yield print_timer(curr, idx)
