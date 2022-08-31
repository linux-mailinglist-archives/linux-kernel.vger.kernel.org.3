Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703375A73BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHaCDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiHaCC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:02:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2082.outbound.protection.outlook.com [40.92.99.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACCB2CFD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4wH9umKatoI0Emyy31A7p0MNKLasxdwnskEycIfhb81Zps3JqzNANt6AzKQRjKe3+fHXw9igeL9tGHM89KC5MNGwK23OBIgr+54e1Ovw17M0ZyBGHnzUt9doJPGAZWFeAMN6QOEJgmukLIK80YPUCY9odqDRfexMuELOVZn5jfIef1qrBdSVeXabFfAHlbV9jPEIkl/1GUqgP9YuKnHg892EESa4uWgaAwjrbu5R99Wqvid3qBjYaemHhMFbXPf68eOvAf8cL0UlKCc7UPZqRIRsXwIkyCLEeZBk2siKfY5mB3o1q/2Vxn6AF/twBJPDWwkYFea9Pv0nKGbOwtJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOQyfDe4Adx9BFysXmc0HVCiHkyPd+6GfGNCW3ncnNE=;
 b=UyXszjPCt58HkyXfEbF2QKZGUxPyFuBO2KViKB6+5QieWdawAQryo8kTop9u0U7f9uqi2hyqig4t8y3FWT5wBatMqPVvKCb/mrcoQyr5RRGs7UkazBCjpHtWrIv1EEjwx+f055mlp0TXBmqV+vkSfqzberkIzdd4o0X1fGRcretK2qNDsg0NwYx3vpmXHYeITGbJqGS3hVLUB2HeHLjMJR+VR8sB5rMIRC3VvGnT6gtFXDvVGGwjkJYKIBuEcATlTYpMZsiI+LHXtpb8e2MzYbWSz+FAgwxCmIVz+qSlC++qRWRZ8r240kRI9mdIpk+OZgQpUGvxgl1vLek0uw/EFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOQyfDe4Adx9BFysXmc0HVCiHkyPd+6GfGNCW3ncnNE=;
 b=L0OxetEA5RBNSvCRx5Dqi64sVacd6ooMawyhlOwvomjvntxqXxc39xbJqgdq/Mu9LuvJYZo23C4fB7Zgap6BA9ALDypO2Z/mF7CfwwbrOOJyjazmd4mSHNbaurhT009JX/mBA8PnClCzZ3nSy1nwR1eAjZn38I/DXKwvb/jWgipGwsW1TPw6YkPLukb7Jou4auk2k8Jd+5adjHWOxVIOHjngdC7grOGsvaiSR8NPDkpewryW+3oQGgZy6G8hBHrLIkTK/hyw9pcrHPVc6fPLvXLSeVeSDmvlxS/iiyKppkTaJvuBGifMf57qzNLFFYy4Ic+vt50HCVS5OFkE6m4ZNQ==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TY3P286MB2949.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:314::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 02:02:53 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecbb:5892:bd41:fe91%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:02:52 +0000
Message-ID: <TYCP286MB21468B3DFFB36261A85F1B7CC6789@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 31 Aug 2022 10:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] scripts/gdb: fix lx-timerlist for
 HRTIMER_MAX_CLOCK_BASES printing
Content-Language: en-US
To:     kbingham@kernel.org
Cc:     jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        Peng Liu <liupeng17@lenovo.com>
References: <20220720122711.6174-1-pngliu@hotmail.com>
 <TYYP286MB17639886A7064A1E610FB2E3C68E9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB1763C4319C6D5CC50E5ECCF2C69F9@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
 <TYYP286MB17634FC71CA47477B6C4031DC6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <TYYP286MB17634FC71CA47477B6C4031DC6719@TYYP286MB1763.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [NBa5lWBacxpgbXrRDR0ftyPlkf+W3w8R]
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <5055bacc-c63f-4499-3dad-2ff2588c0140@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca7710a-78c0-4d7c-f57c-08da8af4e954
X-MS-TrafficTypeDiagnostic: TY3P286MB2949:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EX8KSE/omaamCoSmSxUHAQSI81+Z2scEFpdc3J9W2ZDeNQL80t+xMS6ebg6RKJTPkwSNi32Qa645Kbz8xzfy76Ha7CUEBjeQ3yGJItV/vHtChwj+1lQXTUARBsAPpZ8503RSp8CuYF6VGoKN3pVOSp7IbbL4+5qTvD1SurHF8/kTe4hv0dt59yqvLkH1XCVxun0TgY6dgpwN3xhNtLiBjq94TH1thjZVqop3UO7Xo8YGSS90/ANHqsGT16mpGjuDFm2+db+4sb9VGDvt3ax5SLJQBRPnPqRsmGha7xDY58ipJPMcNLPhamBKnKlxMVjp//ZeIXGtYYr5WsEDLgt60zSD+02TmDrsY37/fupyLaqtb04BntCPwErfhikCaVcdFJYGXiAOrkCuLJz97cqT/LxGS3K4qeU9RFZKrPxAxHY3YfDdeg03YndPiBevyJbBJvVcuSWbQ9FIcxy5kJEK2OoABfynRRkGeMNZJBSa+rork/BtBf2sMTP69h5QcbjaC6xV0Z3Ph3KAvtA7ocq9t/pKMnXBQ8ZmLjXU7ZZw4ccwP71v9O+zvt0E7tQ172etO3RYOobuNMt8o3W4jhc5RiZzALZ9GxJ7Nwn2WdZSSgOZr/++ibI341bNC/2VFOWtFiyeWKY3IeHIXPuBPGqAzV5b6HLjoY3p84A0RAbCktzr2j5dWOEXwii+dNduZOOM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktGd3ZaaEs0Z21vd0tRanFqWEpkakpieEV3eDNnWU5TcWVOaElxVmFsQ01H?=
 =?utf-8?B?TDFIYzF4elBrWEpRaC9zZlYvcEFiYmlqTThhNk1uekNuQnI3VGtERy9QZkcr?=
 =?utf-8?B?T0plUVk5d3dHVGZHQ3RFUDZlWDFMeVlXYVkzUTgySnh4WUZOWUg3OEJtdUhJ?=
 =?utf-8?B?bTFKK2pEcFZPWGZ5MUplYXJQQUVIclh3VThhTVpqeFdDV0hTMmxWNlBTNFNO?=
 =?utf-8?B?WW9Jc2ppUEFoZGhkSHNKcEhIU1hhQ0NaM3BudjFiOGJ2dEFZRG82QjBrRnJi?=
 =?utf-8?B?SklLTnllVE8rUEJqUFlMZGJnYmhXMHZubUxDRmk5V3lYUlgyUE15VHk1NHZx?=
 =?utf-8?B?eGRhR0ozSUhCeFhqS25rdVZvNWhuSm85aElyQlVuRUJCamNxZHJsdllsU0Jx?=
 =?utf-8?B?L1R6Mk9CNy9naTN0djMxeEc1ZlphSnVWOFVEMW8xc25Mc2pxS3hIOHJUdW9B?=
 =?utf-8?B?ZUlLY2dOUW9HWDYvUWNxcDJoWUJPN1oxRGR2T3NhUlhiTnFYcTJoYmNTamw2?=
 =?utf-8?B?NzA5akw5cTc0c0tZSG10ZmVEUWNEdG5jVzZ1ZC9VQTlUY1laazY2Q2VWdU1j?=
 =?utf-8?B?VmpRRkJrdXkwQkM5Q0hxRGk0OEpWZ0JrS3kzZXMzdE5DVHR0MjFFV2lGb3pu?=
 =?utf-8?B?eWREWFM0dG5WUWlPbURkMzBPZ293R3Q5Tnk1ams4dFd3TnJZeXlSam5rbWxV?=
 =?utf-8?B?eWF4c2M2TEYySVJZV2FIcCtIa2RtQkdkTkZibXEzcDdycFN2bGQxK2tlRjBU?=
 =?utf-8?B?K0FwZlVZZ05WSXVMejRKdForN0RyUTRHS1M2eVdMR3d1V3lQdDRQSVI4MVk1?=
 =?utf-8?B?Qm5vQklDajh3OFZhekFNWWsrUkEzL25iRkRQcGQ5ZjVvME1TblRyQXJiT1Jz?=
 =?utf-8?B?cnJFSGZnMmszMG1PZkpGWVU0TnNmWG5EakgzTkJDa3UwVE1aTUJxR1ZPcWQ4?=
 =?utf-8?B?MDFJUnUwd0hQU1RLUlRWSjlHYlpibys3VnFaV0J4VmczUmFlWUFjVk5nS2F5?=
 =?utf-8?B?b0pGNTJPblhuSjNpTlo4MUNVNXJ6SG5uc2RKbVVNcFBzcEhWZFZJVXFzcEJv?=
 =?utf-8?B?aThudCtqY2ZXUUZscjRQL3E2cVNibzBSOUtyR3dhM2NtdHZJdW41cTl5TDdk?=
 =?utf-8?B?ekxPUFhoT2VialRIbDNiYnA1b3Vhcml5Ry9MR2w1YzRSaGF4NHZqV3d3bXJ4?=
 =?utf-8?B?STcrMTVTd3NXNzV3eVI1ZGNHekswMktGSnU2ajY5enliSTUwRzVHdW9xYncw?=
 =?utf-8?B?TG9ZN0FMVkJ0RkV4Tk94V3dGeFU3L1R3RHN6a3hTWUF5dzVkMzZnU2tRdElW?=
 =?utf-8?B?VHVSNEErMDdIUEliMFNLZytGbDdIV0ZpekRTUC96UUtCd2dyNXlTelV3NTVU?=
 =?utf-8?B?dnJzU2Rrd3pwSi9rMUxjSXc2MWxsTldFcGpCVGpBV0NXZEtDZGxtaERUVHVs?=
 =?utf-8?B?WTJwcHpGcitHSTZONUxQUzZpY3RGSndZUi90U0hDOUpneEhTalZzWE15K1lO?=
 =?utf-8?B?TVM4R1JPdXRKc3ZGZjNma0cvS2QrZFpZU090c21SZElRbXlqRGxRVlFGVmFx?=
 =?utf-8?B?WEFjdTFqNVJLL2oxdEdpV3hUdUJ2N1hPcUJSeG1MYjRzTndUbklQYTVicmRx?=
 =?utf-8?B?TGRQSzFSbXhvT3Rzek5vdk10R2VyNWtlcWVYYnVYMElEVTc3YVZSa3dBZDJD?=
 =?utf-8?Q?GDi+GZTPCkSJQDqAv+6L?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca7710a-78c0-4d7c-f57c-08da8af4e954
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 02:02:51.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2949
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

On 2022/8/22 17:30, Peng Liu wrote:
> ping
>
> On 2022/8/4 16:50, Peng Liu wrote:
>>
>> On 2022/7/20 20:27, pngliu@hotmail.com wrote:
>>> From: Peng Liu <liupeng17@lenovo.com>
>>>
>>> HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
>>> it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.
>>>
>>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>>> ---
>>>   scripts/gdb/linux/timerlist.py | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/gdb/linux/timerlist.py 
>>> b/scripts/gdb/linux/timerlist.py
>>> index 8281da068c5b..249f0e804b24 100644
>>> --- a/scripts/gdb/linux/timerlist.py
>>> +++ b/scripts/gdb/linux/timerlist.py
>>> @@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
>>>           max_clock_bases = 
>>> gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
>>>             text = "Timer List Version: gdb scripts\n"
>>> -        text += "HRTIMER_MAX_CLOCK_BASES: 
>>> {}\n".format(max_clock_bases)
>>> +        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
>>> + max_clock_bases.type.fields()[max_clock_bases].enumval)
>>>           text += "now at {} nsecs\n".format(ktime_get())
>>>             for cpu in cpus.each_online_cpu():
