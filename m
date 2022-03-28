Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7F4E9D01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbiC1RFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiC1RE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:04:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8211C02
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPuU7CGUy6c2nhVXawnbTp0ezTzGBHz0U5tSVwX/b6tOgqxp7h/nxDV7FBTRCy5Wfu7GMM3qPrktFz1RmqgXhKJ5eqzXS9LLRtnfswmDxt6AX4/QOoD5VNU8QucPYa4ov8gnNtrA/UMylxwwqtlj1tYsDve0wdS7rLc90rQZHgf1nFMUiE1RRP9uJmYrXBa58zon8tM+Rr6hUtz/un8YnVd3zJPo8ZlPjgPwb3SDY7HuGb6GzuZhFZsAZRwPRxZN4uHyFSLn5w39qjwnj2vr2EcDFGtvhGKIJ2JTqDYegpqgP1aK3GC6m4Og2pxyynTzep7oNUM7gVdoMej70t51Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB7Asoo6GAaFpZUNomAPRFhujew9j3E3jzekWlutNxs=;
 b=UE/Vyuxz4lVeso8tEjZXR1TDavqQEmF5STwusJ5K1cjEk9zvs8bwRn86gD/S5fDOhDNzjpAVS2Ds1RzDaQAFEL6BZS5LWAvd2WsqiR6yRx94UpSN3iTMaLeGV86wBe47TkXYO6+ExKE3sHyXeW4RBxzYGXfltJ0GNCfRfM9QegT3xZtHQmViCrSZF8jyeaU+UsKWYcFbc1j05psCwyEEQ4vOIW6yR34LEQmyf9nk12XsDSj9fepFYzT4ezuzvWx1M8QDwUpjfxD9zqDNxWsxddt1iWUJN9Qk1juiVNspqcCdjE6Dy1qFAsRLaqtPboAdi9WnFPaZrbz20Pso0r31OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB7Asoo6GAaFpZUNomAPRFhujew9j3E3jzekWlutNxs=;
 b=bieG1OXtdctvTVPKfMolSvS9zqLYqTvG4U66KaHPEayes1lLju8pSwGc3DYcGa7m66gqDu8ia3z9d0HCCUytovbMxg0I24yCTjClieP1mwqI7VW8u7AxYFuqQeQjBPKUXjERwqszac7p23DJ+GVmt0+okfy7UiGc3mkQjFC9KQzw4ZXttLta4B+SM8d9q6/eVjzpOr82dGMY3RZ12N3OC3Z00xau6tFiz1g6ZeUP2KqHPj7THS4q5Dga9IcZ8QPRA5KNnxfGqX2Xh+xDVRfmbZzrHGgeXeztT4tXIZlVSDE417DipG3yOxJ9kuq52H/k/h8tPM52qZNECFslUC9PVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 17:03:13 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:03:13 +0000
Message-ID: <147f7144-5a9f-55e8-6164-6ede73f270a1@nvidia.com>
Date:   Mon, 28 Mar 2022 22:33:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ALSA: hda: Avoid unsol event during RPM suspending
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, kai.vehmanen@linux.intel.com, perex@perex.cz,
        ville.syrjala@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
References: <20220328091411.31488-1-mkumard@nvidia.com>
 <s5hczi6l8fz.wl-tiwai@suse.de>
 <7f7934e6-137c-4d8d-049b-0ed5e57cf00b@nvidia.com>
 <s5ha6dal4ys.wl-tiwai@suse.de>
 <7cbfca20-bd1a-9ca0-f0e2-2ecf5fa74f45@nvidia.com>
 <s5hilryjbnq.wl-tiwai@suse.de>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <s5hilryjbnq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::18) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c79e9bc-2cd3-47f3-5fb7-08da10dcd834
X-MS-TrafficTypeDiagnostic: BL1PR12MB5971:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB597113AF1EE8CEBAB364282AC11D9@BL1PR12MB5971.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6d1DHNz9q5IBlD+4Z1pS2iI2Utc/dIGC1ZFKssMHTmqeovsyWk63duVHEmbS54EgdDJGA90Ef5awA7PzaocPD0AelkhRpzBq4BOODrFXlrJA+zGA3gZeY0tUASMVODegQPkARvR9kfaky12diTlk6RMhcHECo8AzOSeR5ypqYlAk6Bb9EhgpWUfpAw3kOhtXWd0x9ylrAjzs5UxfSr3vlXCiKXtpfeigjBUokDNppe1vq0EuyyAdrCgq78chuvki94s3NLHtACxFGsAhN+SHzafBc4yaXOD5xozV7kqEXjGcclaFJTPDCnJ1Ojzm6CTTCKxW+CxlOlcDKHY6oWX0v/ai15e0m/EMuolcJssZTVpT+zAo740SWdunLSDqltzdDy2ZOK1Bd+HTpoNEHeAq2P7YhS0Fanlosbl0+Kt8Ux0aiCiZhv3IqeRN+Haqubqp7alPLAwFVG1Ns3rXtnyeLmWg/cmvL9dGkDbDz0sdN4oA9x3MWVJUtbfhFRNtpGzw9bfqUdcHBvkDr7BdNc8c3CsRwd+eHU4UMnBhVoX2Pfx48pBJSWR7vp7tyy4LXpwYjzzZgHFVM7eOdUwfzEmt70QzT3Ub20t5tl19k76XTVqKN1giFFGnmRn//UaoVyxOLSzeBTUHGYLO/EOEDmCatb+DPgDjDTWQQIKACn+LKyunTkxQewygJXX7uTzxvjYd/QrnCpQhM3MirlKTSYdkRfvjavKJmNc6RITl6Q/YNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(6506007)(8676002)(2616005)(8936002)(66556008)(4326008)(66946007)(66476007)(38100700002)(53546011)(86362001)(31686004)(107886003)(186003)(6512007)(83380400001)(15650500001)(36756003)(31696002)(6666004)(6486002)(508600001)(316002)(6916009)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEQ4T3Vqa2haVTJRMW1jd2I1dHd0Y2dQMGxrcHZQY0pLUGFLSitRN2JjS0Iw?=
 =?utf-8?B?OWtWZEFmOFRYZXNlNXZzQ0Q5NFBpN0JzQmxYdzFMQ1B5VDNseHNlMGptcUty?=
 =?utf-8?B?RHNHYk5FY0pYdXVuRFJYb3IrT3NyYXJoZkFVdjNhUWgyb1VtdlJrWlVsd3hZ?=
 =?utf-8?B?Zk1pWHZBeG9nbml4WElVc1hTSVNPUlVuYUVyWEhTZ3MxRkpJSG5jLy9IOGZT?=
 =?utf-8?B?eWg5dHdvZ1F4RFpyelN5WkY1OEJwTTZLRGJIVlJ5ang1T01UM2xPVEZCdmFK?=
 =?utf-8?B?NTdxeHhTMjhITU5VRVVwZlpQL045S1M5ZGpUYTVLQ2s3TUlEM3g5OHZtWjc1?=
 =?utf-8?B?dC9jY0RqUFZ4M3lxdktrODUyc1B0cjBjN0pHQXBNMGQwY0VZN011QnBOUzFI?=
 =?utf-8?B?ZWhHSmNvUVQxU3FFai9aTG9DRm8xUnMvMUVudnVhb21iaVNFUlNqNGF3WE1O?=
 =?utf-8?B?aTU4OVZGNTRUVTZ3VkxyeWpzbFVPY3FUaUZRRkl4SkpnbklYcVJPK0VWMHJ6?=
 =?utf-8?B?TlRkaUFkTDhoTTFCQ1dzKzJoZmRLZXZHUW1iRndBN3RpS3loWjhtL2lwOTBP?=
 =?utf-8?B?NUJ5VHNOYXhNeG8wbHJCVVB4RHpERFNyUWVUVms1NGtKQU9DUGVEdTdSN3ho?=
 =?utf-8?B?Zkl1NXhVNmxTYkdJdjhVSG4rRUxPNjRMeXNYNDd1elkxeU5kZDlYK25zd0JL?=
 =?utf-8?B?ZjNKR3dwOUg2MFc3Q3hJQ3dDazhCcGVaSnFTSzNkdXoyVXViR2piODROUEo5?=
 =?utf-8?B?VEpUbE9jME1sSW1hdEpXVzNyUmFKUnFOUWE5azRRR1BtdUU3WjRsUGdjeTNU?=
 =?utf-8?B?TWxpdkNiSHN5V05LVUFObEZUYktneFhRLzJyaEdZLzZnL0lWZFdSajhGSnRj?=
 =?utf-8?B?LzhWdWZkZ2p6MTNaY1NBNThDbzR2TzdxTkFVZ0xGT3JkcGNCL2tsSWRVK2tN?=
 =?utf-8?B?Q0FpSCtoK2JFdkl1aFJSN2tlSVpQRjY1YktUQTdzYkdSbWttaEtKQW42NFNj?=
 =?utf-8?B?Z1ZTTTRrQy9KWmxpUWpKRVlZdDZFMHhlSzBWMFJDWks2cm51U3RPSTRoUHVj?=
 =?utf-8?B?aW5MZmhrN3NIbi9uaGlhY3UxSmVWdXg3Z0c0Mm1BMXJtaFZmaXJlN1ZhQ1Ax?=
 =?utf-8?B?ZlEwMWI2TUJBUnIxN0hYSENWME44ZG5vR0h1Zm4yUW9QdEUzYnRYYmNaOFV0?=
 =?utf-8?B?N2ZrQ2NjNnYxeUhKVDhTOVRQYU81eFdLSTViUGtWQmNQSmlIWGczTlJOblNR?=
 =?utf-8?B?NzIyVGs3dXlmb0dpYjJEWGgwZE5OM2t0SGUvVmk4UEpVTUg4eDB2SjAyeFRu?=
 =?utf-8?B?dnVpenIrSG93emVEcVRtVzN2SXROajF2ekJUN0dvbnVHL0ZIa2d2Q3JzUjAv?=
 =?utf-8?B?MGhXeUppZGNwanhQUWVGUXFpSWtHbDVLUGxDc2I0dDJ1SnViaXlRQUE1UkhJ?=
 =?utf-8?B?QXlzcFBPRG56SlUwRDNqaGl3OWNPdnpTUFArei96bUdDSFVyZEVyaWpDRzdQ?=
 =?utf-8?B?QXpiZVpFQWlSOGlMWDhHMUpiOVV6bE9uc1ZBY2pJMk5tS3Z2MWw3b1pLZ1lr?=
 =?utf-8?B?MmxxRU85c1JnbDVFZlFnQWhaWUc5b1UrRnhQdTlNcE15T2V5UzZxaG50RTZT?=
 =?utf-8?B?M3pZLyt4SkVZaXMyQU5USlM3Uy8xRFlPaGRoMUl2Q1RZblM1VzIxL3JCSlRw?=
 =?utf-8?B?VEk5WkdtOW1vV1p5VTB5YUxiREpZYlhsd044a1lKN2tTY3cvN2tEdlNNTzQ5?=
 =?utf-8?B?a1Rad0YvTEZobmx4aklQRHBJWWZVb2I0aTRMTEZRRjBMN0VVaVNFZHA3cC85?=
 =?utf-8?B?OVNwamtxNzVDWGhXcmVmSUlKS1BsbGVDTVBLT0JEc09ONDNRWW1PODZHcVpY?=
 =?utf-8?B?NnpTWUpnTEVvbVZvMTRrZENJNm1RREhZK2MzREhLU0lBVmU2d2hJRjQveWVv?=
 =?utf-8?Q?wQm7YYaHHRnqqPBkYkK1ASkQkYms+dSt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c79e9bc-2cd3-47f3-5fb7-08da10dcd834
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:03:13.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgfyFjUBYPBXwZVpQAmcWYXFRTdtf+SU94rS7gelv0ha1gDo/9Wv1ZztlwCeuj0K6Kcfaa/ebbMPRLnIo/kwkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2022 9:45 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 28 Mar 2022 15:51:17 +0200,
> Mohan Kumar D wrote:
>>
>> On 3/28/2022 4:27 PM, Takashi Iwai wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, 28 Mar 2022 12:19:03 +0200,
>>> Mohan Kumar D wrote:
>>>> On 3/28/2022 3:12 PM, Takashi Iwai wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Mon, 28 Mar 2022 11:14:11 +0200,
>>>>> Mohan Kumar wrote:
>>>>>> There is a corner case with unsol event handling during codec runtime
>>>>>> suspending state. When the codec runtime suspend call initiated, the
>>>>>> codec->in_pm atomic variable would be 0, currently the codec runtime
>>>>>> suspend function calls snd_hdac_enter_pm() which will just increments
>>>>>> the codec->in_pm atomic variable. Consider unsol event happened just
>>>>>> after this step and before snd_hdac_leave_pm() in the codec runtime
>>>>>> suspend function. The snd_hdac_power_up_pm() in the unsol event
>>>>>> flow in hdmi_present_sense_via_verbs() function would just increment
>>>>>> the codec->in_pm atomic variable without calling pm_runtime_get_sync
>>>>>> function.
>>>>>>
>>>>>> As codec runtime suspend flow is already in progress and in parallel
>>>>>> unsol event is also accessing the codec verbs, as soon as codec
>>>>>> suspend flow completes and clocks are  switched off before completing
>>>>>> the unsol event handling as both functions doesn't wait for each other.
>>>>>> This will result in below errors
>>>>>>
>>>>>> [  589.428020] tegra-hda 3510000.hda: azx_get_response timeout, switching
>>>>>> to polling mode: last cmd=0x505f2f57
>>>>>> [  589.428344] tegra-hda 3510000.hda: spurious response 0x80000074:0x5,
>>>>>> last cmd=0x505f2f57
>>>>>> [  589.428547] tegra-hda 3510000.hda: spurious response 0x80000065:0x5,
>>>>>> last cmd=0x505f2f57
>>>>>>
>>>>>> To avoid this, the unsol event flow should not perform any codec verb
>>>>>> related operations during RPM_SUSPENDING state.
>>>>>>
>>>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>>>> Thanks, that's a hairy problem...
>>>>>
>>>>> The logic sounds good, but can we check the PM state before calling
>>>>> snd_hda_power_up_pm()?
>>>> If am not wrong, PM apis exposed either provide RPM_ACTIVE or
>>>> RPM_SUSPENDED status. Don't see anything which provides info on
>>>> RPM_SUSPENDING. We might need to exactly know this state to fix this
>>>> issue.
>>> Well, maybe my question wasn't clear.  What I meant was that your
>>> change below
>>>
>>>>         ret = snd_hda_power_up_pm(codec);
>>>> -     if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
>>>> +     if ((ret < 0 && pm_runtime_suspended(dev)) ||
>>>> +             (dev->power.runtime_status == RPM_SUSPENDING))
>>>>                 goto out;
>>> can be rather like:
>>>
>>>> +     if (dev->power.runtime_status == RPM_SUSPENDING)
>>>> +             return;
>>>>         ret = snd_hda_power_up_pm(codec);
>>>>         if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
>>> so that it skips unneeded power up/down calls.
>>>
>>> Basically the state is set at drivers/base/power/runtime.c
>>> rpm_suspend() just before calling the device's runtime_suspend
>>> callback.  So the state is supposed to be same before and after
>>> snd_hda_power_up_pm() in that case.
>> Thanks!, Make sense, will push the updated patch after testing with
>> latest suggestion.
> Thanks.  Also don't forget to cover a case the test bot complained:
> the reference to power.runtime_status needs #ifdef CONFIG_PM.
Sure, will take care same in next patch update.
>
> Takashi
