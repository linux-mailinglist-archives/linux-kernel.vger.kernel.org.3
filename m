Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31FB4E98BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbiC1NxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbiC1NxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:53:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F45EBFB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebex3bJQyi8f0Q5Gszuoz+cumICyniEuKGnjHL18uK5cu4WYfkVvZuHOffcifWnMGBLpilPNhbHf2agkqzzjGXd68v7x2sQeUlUEByKjn0A8PZkdh0GyZBNIi68vGYuO+F3w2KLcdp66zqAxkt13JKj4g5rD14bZf/3WvBQC53JCNR/TDqFFDJNO73Yw0hv1Ro1wdtbl/mP3MfBvDdUVxqnljZGhJ5VZ742Th24UuEjULceJvQh13cnY9oCtLogG7+/4z8JUFul10g+WcBO0oVQDGXTHgRIglRx7X8aIm14q4ypCtl/PYMhOYCI+DP0B14UdWCnJY587cF26Wa2kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiXKlSWqDxO+G6At6s9ozEx0c/mgoMfM7loYq//9JBY=;
 b=dUP1UD2PFEXdqPANICG3hLYXf2NtFOQzAvjMnUtUOylDS4qoUbSLqRcyVi8BezOK1e7uFiF9gEbmqITta5FdIo+pxrQhX7ZAqZcqfk0dXQx2eqr9uhYEXJ1qGiIhm+vfOMYOInwUSfyYweP+2uRmNwY+auZOMKu7YD0h21lnpAhs3oktXJiuDiinmsdQZ6rqhN1qF4eiqP9veQaZkHQxEdNPehGtL9OnYGIhazkrxquZq6Vki8S2syQjFWB75kBHGl2bC0+ri6HDlpR6V/CNZbAA1FPta/XUJy49DKWoP44HRxChmmz0GiaN37SaJpu8is6Etw2yWHaM0PyP0QQ8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiXKlSWqDxO+G6At6s9ozEx0c/mgoMfM7loYq//9JBY=;
 b=crXZSRVmq0ySJiphF3jBpl5wQPa0EvQ7aeutGHMk32FP5bURTilZMLyDB01HlUQJ0te+2jpLlSxN2CpGrAFsarDksb+WZNZWAZRcYtKwhf7yg94IIDjv/qq1qh8h0GzN9W+W3izPTGhip3nUqtKr7PbfY/l3qvZ2KnSFcMiLxrVAJOUH736GLHz3kiCA0gsFKHjkSIMf9S0qbQZ+lBy9qC14yPRSDkM6Fg7UlEi1Q28spNkJ+IU79/+HhKqJidbz6OQzwe3jI9MRpF01FzPZJ35/U/4QhhzwfSV7XY7UfWdA6GJ2mv9w68mTkIKiLgEN6Pl7UXs2duI/fq/3KxIKBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 13:51:29 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:51:28 +0000
Message-ID: <7cbfca20-bd1a-9ca0-f0e2-2ecf5fa74f45@nvidia.com>
Date:   Mon, 28 Mar 2022 19:21:17 +0530
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
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <s5ha6dal4ys.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb099607-6c10-4b97-6e1d-08da10c20eac
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126F1A25281424CFF62DC01C11D9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3zVgKvUM9jGFHxJlbpyRFdkSpz4ooJbtbHHnV6DamKPfZ1PaSURyHMDW3jBsnKJ2T416U1gzBA6yTY0ffN1Bfox5CfF7eMlFHoNgKfCi1ceLERKD0MHwji972pEKDlzoOvxMQGnmFkAzdN4qowC4vK6cMUTjoyyoaFqSl+xBosJxJUTM/0DFxNLlZKxq8aBW+JA/wXh4ksIB/K3gfrwg9X5803zWlXbyi5W8H8InVd5ucGG5ZiXzTgfKI/UpoKelHSYwNjse8x4soCuhRg5VEedCf3xZW+tmG0pB4UBQDEo2UWlf7pu4p7qnQO6S5Kg3yAw+2b/Z6BUUUEIXWQ6EEd8kjlGuvBW9mhTD5xA5nZ0RuoHleRvuGvKxvlN0q5MtPi+nlcf72xQRjUper+XDztq9MoQ2i/aiJRf9T9oD8MZ/D6R0IqBxy58Xf9rhtpo1UY43qpcMAJtBxqWzpvZIJ2V0C2H+q0Ya9o8vNr7vstxIjWg1U4IJFN0A5PmHDMN/Icy4VA5Nfl6Vtdru5nGoupTj9fkJ80HLnELGhHQrhyZ2YmGRbnct5wOgzqT6995cXQQU7VGWes5xRwuEMJum/69LnHvHABNSODRpnkeEro8Pwo1wjstQRK40Jw8jwAMunCeVCDMZWI64l5Y3CvjVvudNYmG2IWjpRVOEn8awELebBr7ct9UPHdY+75IRVnSVbKet9rnpcgXXsHh8WRJCtGO3apwHK6s2e9aOKsY02Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(6666004)(66476007)(66556008)(53546011)(55236004)(6486002)(66946007)(38100700002)(6506007)(508600001)(86362001)(31696002)(6916009)(83380400001)(316002)(6512007)(2616005)(15650500001)(2906002)(26005)(107886003)(186003)(36756003)(31686004)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUo5dUxWRmtqMm9UWjJlUThweWRvWm1pcGhCbjNDWXNpSnpUWUJwcDM3RE5z?=
 =?utf-8?B?UVFWcEtMbXY4LzJLQkExT2hDSEZoYkZUZ0h1TVF5Y2t2cnNHdnExbTdnZk04?=
 =?utf-8?B?ZXFjYnRHOUpwRXBndGtmZFNMKzVWU0RuWld1aUhZUkR2M0tkYTdDdW1xdHVn?=
 =?utf-8?B?MEpKSWRrYXJXdDBZYUdnWUFQZjB1YXVreW9UM1NTT1JpeENYeDJ0S3VPblph?=
 =?utf-8?B?SVZ5ZjMrSGppR3Q2R0s1cmZndHFTMFk3a0RkRGFVNzkxazQxKzd1cTFkSXhi?=
 =?utf-8?B?RHNmcVpzcmJoRGNMNHMxTzRqNndudFNwYXR4a0tqS251eWJ2d0RTdFg4enhh?=
 =?utf-8?B?amdFcWFSMG9jOFprSVJla2UwN3JlZ0hJZXpyR05KKzJrTDJldjJ1RC9sUW4x?=
 =?utf-8?B?SksrazhUQUxkYmV4V05LcnlVS0p3UHliU2R6UDFSWGdiWWhlRDF4YTdNM0tN?=
 =?utf-8?B?QzZCOUE0QzJKQWpxZXBSTDV6QzAweU5MWlp4dC9yS0FSemZTemJTaWFGZ1ds?=
 =?utf-8?B?cEs4WE5PNXdNeklzQmFFenY2SDEreGtVaE5malJjc3I3NWsza1Z2ZHhuTERT?=
 =?utf-8?B?YndkdlJ3Q3pCeUZUbGIrTkpvdkY4RzFPd0t1RUJJVjdUYVZwUFZHbkhkbExK?=
 =?utf-8?B?OFAvRnJHV1hlbTFoSFh5TGpPT0hwKzhMUU5jL3JuSkVSR1czTTM4UW0zRFhR?=
 =?utf-8?B?ZTQ2b3lUMjV5Rm9wV2lwcXBQOWdjcEdwNVFVVWk3MkMvbGRMUEt4Tkl5V3JM?=
 =?utf-8?B?Z2VtNjZGMlhEOG04RzFCWXhOdjRabzh6NkFaZVRJVWNwYWFtYTBNV2RxWGRT?=
 =?utf-8?B?cklEOXJFWWVBamcxWmwxY1pmVEMydUQvSGxWUHdFc2c1NThSa0pieTNqZTFI?=
 =?utf-8?B?WDJLTlpPOVdoZlFscjNtd2xmRVc5bFNYMzlOdFJTamZUNFpyQS9rTkROYkg4?=
 =?utf-8?B?T2dscVBBNGZtNXIzeXd5bC8waWR5eUVSZitidVJMeUNVRGFPdFRZc0JELytI?=
 =?utf-8?B?K2YzWXhRNGFxMENHUkF1RWRHdVVlUlErSk5xMEFyOHdYLzdrZEIzbkpZOE9F?=
 =?utf-8?B?NU1qa0hQTzBqM2ZsdHB5cGpFT2lRUUZTZlNWWDFIS09Lc2FRN0ZrR2p1dm9B?=
 =?utf-8?B?NDlTVGpZN3VVSEU3WGdhYVlZeTFqZHNLQU1HbUFWTzAwZForc3hvanVxQXRQ?=
 =?utf-8?B?UW9vb2YwdzFkZG5PVTJsSGhBNk9NbldoZE5Sb3VlY2hxR3RMZ1dVSFgwbWNG?=
 =?utf-8?B?RDNnakZwYVgwRmFYekxPY0FhOUlhZzJKUlptdjNiTHVGZGtXNjFzZ0lacWFw?=
 =?utf-8?B?UVcyOXlVb1RQZ3FEODJZNHFZVHhjMVY0SzdHTERRbXovZlFoQTlXeXplMGVK?=
 =?utf-8?B?ODdOMFJDQU0xeUFJY1B1OG1GMEF0VDdVazB2NWFzcGc1QmJkM2hJNWZYT1dQ?=
 =?utf-8?B?L1AzUjZwajk5Umd1NjJ5M1VxUXhabXh5cE90MUxqRWM0cjBIS2pTWEZXRzFH?=
 =?utf-8?B?MnNCaGpHYUdvZjZ0SXBhUDVkaytEeUNkcExPa29uSkc1MGJJQ3FIdVcxdTlE?=
 =?utf-8?B?MnpQaGNtaDlIdWZBMjl3Y2s0d0diY2RBT1RnQmhlYTBSSy9tY2ZuVVVhTnhG?=
 =?utf-8?B?bVFRRFp0TkgxTk0rVkhOanJjQWVWOHNhWHFDRGRqajhHN0NkUk8yNkI0UnZ0?=
 =?utf-8?B?ajdQVnhreC9ZSXF1VUVNUUphdXNGVVgza2lWNjRqVllEUnZQNVJlR0hCOXg1?=
 =?utf-8?B?WjR4dzdlbEw4TWpiWTBWZkU0MUZBUGVITG5YdnRxd2VBN00yU1ZWZmxBUndB?=
 =?utf-8?B?YXplVENIWkREekxMd0JyMjFBaXRlRnIwRTB2b2g5QnhtbVNTbUE0SDBUN293?=
 =?utf-8?B?SHdMYWVHaExwdTZuNTVnQXNQaGIxaytpSytsQko5ckNwR1hRS0FZeCs1Qk1N?=
 =?utf-8?B?d2RIUTVrNGNtMTN6bEhYQ3dFYis5dDIzdG5CZmZIOXQyUWgxMWlMa2Evbjhs?=
 =?utf-8?B?a3FGSk5OdkJ6NUZxN3lIZk1nYTNRcFJ0MWFzSWVnNm0xWXNraDA5ZzBRZmt3?=
 =?utf-8?B?bVd2REovZXVOeTZ2UDVlbVN1Z1lmcFJXNXFTeENkUWdCUTV2bFl2ZzdidUY2?=
 =?utf-8?B?b2ttaEZQUFU5QUtxbHhsYytObjBkNEYrcTZKTlVwMDQyZkhHOVZHWEhUN1ZM?=
 =?utf-8?B?SjRiZk9BWEhGVnNwbld3eG9pbjltRzU4Nmhodm9aVEd3MEYvcXk5YzMyV3R1?=
 =?utf-8?B?Q0M1M3ZHSlVwSmFQb2YwZDh3aXRYUnF0Z1dwUlhvdThDY3loUEJTRi9zUkFp?=
 =?utf-8?B?dXN2Q2F3VFdiemJtazFLWjFpMXFFQ3BxYmxxemxRMHVCeUU4SzZZdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb099607-6c10-4b97-6e1d-08da10c20eac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:51:28.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXBxnG/GQ0TbXhRZ0/cpEFyiE2dymz26JkLA+R8LFNSkkadeGBq+uP4pyrXn2JddAfr6WBTNxHZ1zfbV3DWCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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


On 3/28/2022 4:27 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 28 Mar 2022 12:19:03 +0200,
> Mohan Kumar D wrote:
>>
>> On 3/28/2022 3:12 PM, Takashi Iwai wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, 28 Mar 2022 11:14:11 +0200,
>>> Mohan Kumar wrote:
>>>> There is a corner case with unsol event handling during codec runtime
>>>> suspending state. When the codec runtime suspend call initiated, the
>>>> codec->in_pm atomic variable would be 0, currently the codec runtime
>>>> suspend function calls snd_hdac_enter_pm() which will just increments
>>>> the codec->in_pm atomic variable. Consider unsol event happened just
>>>> after this step and before snd_hdac_leave_pm() in the codec runtime
>>>> suspend function. The snd_hdac_power_up_pm() in the unsol event
>>>> flow in hdmi_present_sense_via_verbs() function would just increment
>>>> the codec->in_pm atomic variable without calling pm_runtime_get_sync
>>>> function.
>>>>
>>>> As codec runtime suspend flow is already in progress and in parallel
>>>> unsol event is also accessing the codec verbs, as soon as codec
>>>> suspend flow completes and clocks are  switched off before completing
>>>> the unsol event handling as both functions doesn't wait for each other.
>>>> This will result in below errors
>>>>
>>>> [  589.428020] tegra-hda 3510000.hda: azx_get_response timeout, switching
>>>> to polling mode: last cmd=0x505f2f57
>>>> [  589.428344] tegra-hda 3510000.hda: spurious response 0x80000074:0x5,
>>>> last cmd=0x505f2f57
>>>> [  589.428547] tegra-hda 3510000.hda: spurious response 0x80000065:0x5,
>>>> last cmd=0x505f2f57
>>>>
>>>> To avoid this, the unsol event flow should not perform any codec verb
>>>> related operations during RPM_SUSPENDING state.
>>>>
>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>> Thanks, that's a hairy problem...
>>>
>>> The logic sounds good, but can we check the PM state before calling
>>> snd_hda_power_up_pm()?
>> If am not wrong, PM apis exposed either provide RPM_ACTIVE or
>> RPM_SUSPENDED status. Don't see anything which provides info on
>> RPM_SUSPENDING. We might need to exactly know this state to fix this
>> issue.
> Well, maybe my question wasn't clear.  What I meant was that your
> change below
>
>>        ret = snd_hda_power_up_pm(codec);
>> -     if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
>> +     if ((ret < 0 && pm_runtime_suspended(dev)) ||
>> +             (dev->power.runtime_status == RPM_SUSPENDING))
>>                goto out;
> can be rather like:
>
>> +     if (dev->power.runtime_status == RPM_SUSPENDING)
>> +             return;
>>        ret = snd_hda_power_up_pm(codec);
>>        if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
> so that it skips unneeded power up/down calls.
>
> Basically the state is set at drivers/base/power/runtime.c
> rpm_suspend() just before calling the device's runtime_suspend
> callback.  So the state is supposed to be same before and after
> snd_hda_power_up_pm() in that case.
Thanks!, Make sense, will push the updated patch after testing with 
latest suggestion.
>
> thanks,
>
> Takashi
