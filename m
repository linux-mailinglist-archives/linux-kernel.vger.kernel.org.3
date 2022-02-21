Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BFD4BDCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbiBUNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:53:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376418AbiBUNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:50:45 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE35F9D;
        Mon, 21 Feb 2022 05:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUorPhih57F0fFULLdfwivAbTVR42jP6VO9g5r32HlwyIt6sxYCzp7tN7JZKHWCJYFyUrH9IMIgN28MisB/+TTq6U+yn/YcoJqlP1tu43LMkzDCnqEg8njRwEqfWh9OrganNAeNQIa/PdqgSFtZKzfXaLIIeD4lmN838x81m94FoFnlHZ534zGc7jFr95i62rwPLMdd/bc4G0aVAaTdDDojwF+2Xh78HlAqKeyTurHY00lz5FOOTrIiLTGUZr6OlD4D2A02tPFFfsl+0/qAJe8kycdr/ER6msKNGySpGjtTASPPn1bqG8winLNuwB7zUWNJHroTkguZ+SouuG5voAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIIwLgDhsD/tP14IAtJpW1l4h/Dz7wGGozJPKYT3lwI=;
 b=ON4fa5fDrDix9O/04qTExgY5VjSGr+Cr1fAieoFprNFQ0drWK9ieFgHGyY4CfuuLMvwy1Iu+xK+vfr5MCdJRbCPB+stIvvnc2dm0kwPkWZq8+4PpdGTAZM+xQVZKL3CAUFaiS18a86JuID6gOI/n8pljG9yEOMTGQzTsLTneant0gomzqYgk4J0Z0Nlez2DjIG7UeP3c+TC1F1j4/K3X8J3umssvXIv5zGQnz7erednwBeYlQdkT+6d0/q+dcj24lSJzdTL30JVPk6ZhowQ0GkrLFoJi2JUkIpvp+1pisu8kGO1CwKHDyHh+cfQ1YTERo5Qy9V69OWYIqg7DAxmoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIIwLgDhsD/tP14IAtJpW1l4h/Dz7wGGozJPKYT3lwI=;
 b=HYO9H9CAA5NB04n0vYj78AcQUZTkjQz2p70rQc6MYb1XGJFnrnENUNO0RpKHUFwkfxd5lm0PBQQ/+opJDj/9FS79z8NVe6Ch42b0p/oYaI25BjnRhYZBGOJBjtg/HPAefjsSaW+GV1bRyu3EMZMRO41vFeZh0LWNdPRsyG4jEHeXOCZEgVYdFGM1yr7Yg9hh8+mPTi5AfMiaJ4ZBZPF6XnmCgwFrA6ZrWOv9mtQxh4MArZWOByZQI6+Dsx8LhWifw/hV6eugyYZLPxLU5K44l9nHbS7slMKi6BX27+5Wh2uletx2ggGl6pezX/OR9UudPxwexgStUMFAudbsdjEuVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB3977.namprd12.prod.outlook.com (2603:10b6:5:1ce::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 13:50:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:50:18 +0000
Message-ID: <f6c833fa-e93e-9bca-4951-3043d638c1ac@nvidia.com>
Date:   Mon, 21 Feb 2022 13:50:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
 <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
 <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2739112c-5ca5-4e54-b6f6-08d9f5411821
X-MS-TrafficTypeDiagnostic: DM6PR12MB3977:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB397737DE8DAEA1F3E0778EBED93A9@DM6PR12MB3977.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJV2G6/JOzES0IAtcpB4BhpKNln1jGGXpPHH9McFqE38q0SEtBRRWa9ea7SL2I7J/sUr8f0MX2VooFDm2aq+AUyJZi8WyVZizA2vQWNL6jPgwIKm1SepHI5P4MwZvE5LwJwP3eq4b0Qa9yj2mypMgZf1MDTMwhrz4XE5jk1eb8UsddjuBkE0tY8iltOHEnmGmOt2n+MTXB5cRNBSejP2PanpVjYn3nSwQokpS7cFyYu7AJE91EgPqlTcumdR6oQqagHoNVRDZe16P8gJuQ6ZHhYjkYvC4mOrPYFVSrSjTn7nC0fYTc05MttpwTecmZVLORAmyBVGR4hEf0TDZQneXBk1pcKXeKqcjySXOABsGUdxWJJcDTvtMeN0YN9s3GO8e2MlAAWEj34MIGunVaBa7EgPgVXZQvC7QAnMh6cxYf4st64qMCvTNSHoKYmSsAWQR1r1KaiYI0XvEttwJJa02pQTdSABq9+dJaZl6utFOfoD6mVc1MtXkDGRVlRPxLBmh1tHiRN0wVwuVac04y8b55KJc0Y0jQ2NV7l0JxgLFMTYCLnazflPLbSxWuaKI8+ESberyONPHD7NcLK/s7e58Lj78d58p4YHkJ4093B8ybOnsQ+9DQUL3Weila5AFl3OlNN8dLCn3QSTTDH/+rZdhHzeb6bdlWVRl+ej5jWc/UpwPUNQIQXQEf8MpXYzFjhFzDin9oI+yk9Cv2zc166By8VWxeGeQCAdX0H87KcBvnJZAwhrBpoJXGlu7IjZq8Fw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(186003)(26005)(53546011)(2906002)(55236004)(6666004)(31686004)(36756003)(38100700002)(110136005)(66946007)(83380400001)(316002)(508600001)(66476007)(66556008)(4326008)(6486002)(8676002)(6512007)(8936002)(31696002)(2616005)(5660300002)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFnMnZGSTUxQTVYUXBaMG9HVGN0L2o5eXRsRWxWNUZlMHJjcDg5dDR1TmZG?=
 =?utf-8?B?VUdBMHhGYjBKcG4vWTFaaVJGV2xjVkZ4cWc3dFlSRWFjQzcybDZQVThBN0tQ?=
 =?utf-8?B?RytUR0R6UlY1M1pJQ3ZoUkdGZ1U3cktGZWFjdjBuTllRNUUvRXpnc3B6c1Nh?=
 =?utf-8?B?VURaRUhFTG95T0czcUxMYzI5TE1VNmwyaVExZ3duSHJxWGE2NWZYTjVIYS9n?=
 =?utf-8?B?NHNQMTA2eGw5cHIxSHM4QjlBSTVQbFpNcG5Fd0VHZG03WU9pQUV4MG9ScUkr?=
 =?utf-8?B?Z3dENCt0dUg0K2lJZGU5eFRLblFVSHdjN21iekh2K1BsL0p0WlhSamcyNnNz?=
 =?utf-8?B?ajJuVjUxc29mWkRmQ1N4TkJqeGdhakR6Q2FJVXJ3ZEpiN1YyMHQzai9jSk5B?=
 =?utf-8?B?MzN3ZWJTcGdpRTlFdGVPQmRId3RXaWRkRks3QWY0WkxkR3BabGlYbFA4SVZS?=
 =?utf-8?B?b2pSUlNFOUtlL3h3cVUyWjRETEdtMWVVMVdhY014aG9YeXJNek54dExmYWU2?=
 =?utf-8?B?eXd5STRmWVcyNGFFN0txbjBFdCsvTVNYRWJBbmYrSFhwdjdRL2pmMHFHWVMy?=
 =?utf-8?B?WG85REZldXZZVkNONEdnd0hqbU5JWC9qdlA5RUhMeDBUQTNzcEJNVWkzYjZk?=
 =?utf-8?B?NlRYVzBCcnBXYkRpTlpQUHFrdkFFeTZXQU5lcTFlcnlja1grVU5jRnY1dFB6?=
 =?utf-8?B?QkNTUUkwRUVEMHdBU1hmdURxQVRJTWJvTm9IZWxSKzh0NWZHcXk2TGE0VDNz?=
 =?utf-8?B?N3VweXo4N0tOY3EzNDZ3SjlxN0hvZXhhK2hYMEVvWUI3alFPdjBHdU90aC9I?=
 =?utf-8?B?bDNrYUt0dEMxWjZxRTNsNTROREh0Um1TdHdSMTF2SXlqenpaZlJ3UTlYL1Rp?=
 =?utf-8?B?aGdrNHNLam9ueDNkTHBIOGorbDJDQkp6eHg2REZBN0Y2U001cWxTMldRazdD?=
 =?utf-8?B?dEVTNEIvMDRzK3RQOWpESmFSUUh3OW12QS9PVHpuTnRkMC8xNHV3ZndZaklN?=
 =?utf-8?B?dXVOTXdYNk9LdEVRWlFoQW1hNUZqa3VLWDR6VXkvVWRJNlM4MFFFQzNlRk5W?=
 =?utf-8?B?Qy9UTWFJZkNzb1Ezb0pnd1FQYmJSRkVnSWpUVnpBNldMdE5GV0huUXhUTE1N?=
 =?utf-8?B?NTI3cFFsZzFQQXZvT3d4U0gyK2pGRmJRbkhUMVVIMGY0YWR4TFFjSElYaFdy?=
 =?utf-8?B?UkdkaEdidU93VGFjN09HMXpFcmZpMi9lNGJmbC9nUWdjcDg4a0h3bk5iZU1t?=
 =?utf-8?B?Y1Bhckt6OHpZU0R4bkdEaW1jbXlPSzJ4Q2o0VnFwUWhNM1NCdGZuRG9pYnhV?=
 =?utf-8?B?K0Z6YzhZUzRBblVYeUVUdDF3T1IwQXpJVzgyOFlHMWdpN1MxZUhKT3V2MlBN?=
 =?utf-8?B?dm42LzlGU2dIQVFpUFk4RXRtWUdFeE4rRkRiRlhiczNWc0E4aFFnY21UYkJq?=
 =?utf-8?B?cUdVTEVWaUVwbEVDQmVYQnVqSFA0ckNDdzIyRUFSYUtEUk5ldDN4WTN6bi9o?=
 =?utf-8?B?Z0p1cElPazM4Z1p2NWR3NU1wQ29hRURTWGVaaDFJeDZTM3pNNVo0YU90SDE5?=
 =?utf-8?B?YkszcnN5MDZxbDlhQ3BLNlh5ZllZNlNRbnQ2bENnSHhlYmd4Sjg3U0JzWWNY?=
 =?utf-8?B?TFFrUUt0UUJLNFpZeU9PL2RscDhIOE1KU2g2S3AxNURNcHZBTDhzZ2ozdlZE?=
 =?utf-8?B?akY0ZVR6eW9heGNWcEprVXZhZVdFL09EdmxWeEhCYlMvNWVaUUY4bmF6R0o3?=
 =?utf-8?B?UE5adVhTMnF5cmI0S3FFaEU1WlJPckRFTUhDVmVtMnUxMlc5WFVpaUZGSE1B?=
 =?utf-8?B?cHdsOGplaWVJWTNxNys2cENhM2JqRSsxaE1YWVhJMkJMVkpjWHBBM250aHli?=
 =?utf-8?B?ZlhwUm1ibEx1K1BBaDM0UDhocEpIRWpmZFVwdDBNMXk4d0pmcUR4a3d1U0xM?=
 =?utf-8?B?THpGbU41VnltSmNPK2c1N3d6SUtOaXlEY1gzbkVYTG1IR0paVGZLVEtMbE4y?=
 =?utf-8?B?TFZuS3IramFxL0FBc2hlVm5jNUt4U3hkOEE1TW5kOU9zWWcxLytuMVJZNXcr?=
 =?utf-8?B?RzFCRjlxTUorOHJjd2dKTWRDQ1l2M1FvdjVkcnhEY3RsQjNrZGMrcUdoTFFP?=
 =?utf-8?B?ZnlwNnpyNS84SXNBYndnMkRzTUJPNXF1OWxjQ0ZhR3BvZ2hLd2dEa2JoUWdp?=
 =?utf-8?Q?aN9Q5GyqtlKKNBDu4FqCltg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2739112c-5ca5-4e54-b6f6-08d9f5411821
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:50:17.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9pVD8w2Qw6Zc3+6dTRXpqlEKOnjGuWoamTdttfBB3pCSvo8dfUUsGEWqJEuyPc1bIkmP0618SzzEZ+3V8+vYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3977
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2022 12:59, Dmitry Osipenko wrote:
> 21.02.2022 15:56, Jon Hunter пишет:
>>
>> On 21/02/2022 12:36, Dmitry Osipenko wrote:
>>> 21.02.2022 15:01, Jon Hunter пишет:
>>>> Hi Dmitry,
>>>>
>>>> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>>>>> Use hwmon_notify_event() to notify userspace and thermal core about
>>>>> temperature changes.
>>>>>
>>>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>     drivers/hwmon/lm90.c | 44
>>>>> +++++++++++++++++++++++++++++++++-----------
>>>>>     1 file changed, 33 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>>>> index 2e057fad05b4..e7b678a40b39 100644
>>>>> --- a/drivers/hwmon/lm90.c
>>>>> +++ b/drivers/hwmon/lm90.c
>>>>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>>>>       struct lm90_data {
>>>>>         struct i2c_client *client;
>>>>> +    struct device *hwmon_dev;
>>>>>         u32 channel_config[4];
>>>>>         struct hwmon_channel_info temp_info;
>>>>>         const struct hwmon_channel_info *info[3];
>>>>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>>>>> *client, u16 *status)
>>>>>           if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>>>>> LM90_STATUS_LTHRM)) ||
>>>>>             (st2 & MAX6696_STATUS2_LOT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 1);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 1);
>>>>>         if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>>>>> LM90_STATUS_RTHRM)) ||
>>>>>             (st2 & MAX6696_STATUS2_ROT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 2);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 2);
>>>>>         if (st & LM90_STATUS_ROPEN)
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d diode open, please check!\n", 2);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d diode open, please check!\n", 2);
>>>>>         if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>>>>                MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 3);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 3);
>>>>>         if (st2 & MAX6696_STATUS2_R2OPEN)
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d diode open, please check!\n", 3);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d diode open, please check!\n", 3);
>>>>> +
>>>>> +    if (st & LM90_STATUS_LLOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 0);
>>>>> +    if (st & LM90_STATUS_RLOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 1);
>>>>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 2);
>>>>> +    if (st & LM90_STATUS_LHIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 0);
>>>>> +    if (st & LM90_STATUS_RHIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 1);
>>>>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 2);
>>>>
>>>>
>>>> We observed a random null pointer deference crash somewhere in the
>>>> thermal core (crash log below is not very helpful) when calling
>>>> mutex_lock(). It looks like we get an interrupt when this crash
>>>> happens.
>>>>
>>>> Looking at the lm90 driver, per the above, I now see we are calling
>>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>>> hwmon_notify_event() I see that ...
>>>>
>>>> hwmon_notify_event()
>>>>     --> hwmon_thermal_notify()
>>>>       --> thermal_zone_device_update()
>>>>         --> update_temperature()
>>>>           --> mutex_lock()
>>>>
>>>> So although I don't completely understand the crash, it does seem
>>>> that we should not be calling hwmon_notify_event() from the
>>>> interrupt handler.
>>>>
>>>> BTW I have not reproduced this myself yet, so I have just been
>>>> reviewing the code to try and understand this.
>>>
>>> Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
>>> managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
>>> spot any problem in the code. IIRC, it was a NULL dereference of another
>>> pointer within that code.
>>
>>
>> OK. From looking at the above I don't think we can call
>> hwmon_notify_event() from an interrupt handler because this is going to
>> try and request a mutex. So we need to fix that.
> 
> The interrupt is threaded, so it can take a mutex.


Ah yes, I clearly overlooked that detail.

Good news is that I have been able to reproduce this on Jetson Xavier by ...

$ echo 40000 | sudo tee /sys/devices/platform/bpmp/bpmp\:i2c/i2c-0/0-004c/hwmon/hwmon0/temp1_max
40000
[  105.890995] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003cd
[  105.900105] Mem abort info:
[  105.903328]   ESR = 0x96000021
[  105.906673]   EC = 0x25: DABT (current EL), IL = 32 bits
[  105.912407]   SET = 0, FnV = 0
[  105.915751]   EA = 0, S1PTW = 0
[  105.919230]   FSC = 0x21: alignment fault
[  105.923698] Data abort info:
[  105.926853]   ISV = 0, ISS = 0x00000021
[  105.931139]   CM = 0, WnR = 0
[  105.934420] user pgtable: 64k pages, 48-bit VAs, pgdp=0000000101f6b600
[  105.941230] [00000000000003cd] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[  105.950864] Internal error: Oops: 96000021 [#1] PREEMPT SMP
[  105.956608] Modules linked in: btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress rfkill snd_soc_tegra210_mixer snd_soc_tegra210_adx snd_soc_tegra210_dmic snd_soc_tegra210_mvc snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_i2s snd_soc_tegra210_ahub uvcvideo videobuf2_vmalloc tegra210_adma videobuf2_memops videobuf2_v4l2 cec videobuf2_common drm_kms_
helper videodev mc snd_soc_rt5659 snd_soc_rl6231 pwm_tegra tegra_aconnect snd_hda_codec_hdmi lm90 tegra_bpmp_thermal snd_hda_tegra snd_soc_tegra_audio_graph_card snd_hda_codec snd_hda_core phy_tegra194_p2u snd_soc_
audio_graph_card at24 snd_soc_simple_card_utils pwm_fan pcie_tegra194 crct10dif_ce drm ip_tables x_tables ipv6
[  106.032497] CPU: 3 PID: 296 Comm: irq/126-lm90 Tainted: G           O      5.16.0-tegra-291805-gf905a41db850 #3
[  106.042869] Hardware name: Unknown NVIDIA Jetson AGX Xavier Developer Kit/NVIDIA Jetson AGX Xavier Developer Kit, BIOS v1.1.2-901d3c52ed23 02/14/2022
[  106.056392] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  106.063903] pc : mutex_lock+0x18/0x60
[  106.067750] lr : thermal_zone_device_update+0x40/0x2e0
[  106.073161] sp : ffff80001494fc60
[  106.076553] x29: ffff80001494fc60 x28: ffff59bb27801c00 x27: ffffa4295d826790
[  106.084052] x26: ffff59bb27801c00 x25: 0000000000000000 x24: ffff59bb27801c00
[  106.091541] x23: ffffa4295d826870 x22: ffff59bb27801c00 x21: 00000000000003cd
[  106.098905] x20: ffff59bb28078f08 x19: ffffffffffffffed x18: 0000000000000000
[  106.106387] x17: ffffa4295d82689c x16: ffffa4292d400b7c x15: 0000000000000040
[  106.113766] x14: ffffa4295f8889a0 x13: 0000000000000228 x12: 0000000000000000
[  106.121294] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[  106.128793] x8 : 0000000000c2f000 x7 : 0000000000000001 x6 : 0000000000000000
[  106.136133] x5 : 006800047a8e0f07 x4 : 0000000000000000 x3 : 00000000000003cd
[  106.143473] x2 : ffff59bb27801c00 x1 : 0000000000000000 x0 : 00000000000003cd
[  106.150813] Call trace:
[  106.153333]  mutex_lock+0x18/0x60
[  106.156804]  hwmon_notify_event+0xfc/0x110
[  106.161164]  0xffffa4292d400a74
[  106.164417]  0xffffa4292d400b7c
[  106.167659]  irq_thread_fn+0x2c/0xa0
[  106.171359]  irq_thread+0x134/0x240
[  106.174971]  kthread+0x178/0x190
[  106.178469]  ret_from_fork+0x10/0x20
[  106.182187] Code: d503201f d503201f d2800001 aa0103e4 (c8e47c02)
[  106.188550] ---[ end trace 62bf0e0b37a16815 ]---
[  106.193261] Kernel panic - not syncing: Oops: Fatal exception
[  106.199106] SMP: stopping secondary CPUs
[  106.203401] Kernel Offset: 0x24294d740000 from 0xffff800010000000
[  106.209584] PHYS_OFFSET: 0xffffa645e0000000
[  106.214011] CPU features: 0x0,40000843,06400846
[  106.218651] Memory Limit: none
[  106.221822] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


I am wondering if this is some sort of race condition in the thermal
shutdown path. I would be interested to know if you see the same.

Cheers
Jon

-- 
nvpublic
