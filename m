Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939D4BE822
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358405AbiBUM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBUM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:56:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FC1C10F;
        Mon, 21 Feb 2022 04:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrXEui+EftXDVXo/T8fDA9x8hXvCdo1hsvGDOo2zDukvjZLCCbGqJ71txOSfP5hggsk5SWyuDG3r1/1wwjde5Te+BcXcpCKzDYH0F/kHuM/0btqFWTpDAUU4CKI15TUwX0uImntV9bT9Q1eNKz2et7o7O1iudmqO0vKXKUGvsaj4Sja1fkCpJ47Zy5EFUKsDK2pHUvYWLdRzeXxuG1KNDU25RSpqjIqDxIAtNcsXx3YbAzmuYTmaOB1JlAsNoSDCnKC2N46yHKGEYu9NmZFPwCKYZUn6xF+38PXwQWUlzmVnVjB7CFEY7ESYyKj0fPoeCUfgvOh9OxENxYb842aZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJNo3T1mAtknuizmLnRnF0ruyr7YNv7WExxkjDM0oRo=;
 b=FsmdOiwzPgRqAFDqjHOUCv7zafMwpS6H+kO9Zw/V/gziqkbxdrrRk/W2u7M590xIhNWvj6TwUn1Y9wtXFbNWSAlP41xuwkc8TEf1B262pAVcmyYdSoB5rFmg379C95jsBfz3V8VAaxqb3hnun3N64EVX5Orc0kE8HrovzVSEty48FdmxiCcXhLqpiz3SDiPVh2DUHbjnry+0x4ikK6BI7rgIwcPTCrLsUWxTIKgwX6QbRHV5obWguGMVGZcYx+BUtE529fVMeSmGDx5PuNXRvQJhFX3AvpkB3qYoJwjWPbqfegTFM/jdYm6QKQ10STZDN6CPnosv3r4U65Wqlop7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJNo3T1mAtknuizmLnRnF0ruyr7YNv7WExxkjDM0oRo=;
 b=n9e+IjhKnmER3nrIZsceKRDGPy+aXWN1kf5PGYQoTXupMWtQ8DCmu7vw1FTh8tYMNZTnqma3l7ooNx6c09wPRVBFH3iLNWJPxT1qEn+PmXDxsQAsO33237ZDeVm7mmynq7rKvb4YsjyV0PmOV6zHqfjsOuCaqdKOWx+zf0KqOGvmncyFiaFxbgjusvMxCPwuamdezU4dT/R6YRevomi/SbsvM4Qk7kTVaxvamxYre8OaLFqcZGzsMSeN/va8YBrrqy/cHFXVpW9g2JkxeGNKdBa9IDHwnkBpMnKnj3IYYROgXBb5QmBPccT6kTDDvTdF6XOBdVcYJkhI4F9ExGD3WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Mon, 21 Feb 2022 12:56:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3df2:54be:277e:7ed7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:56:09 +0000
Message-ID: <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
Date:   Mon, 21 Feb 2022 12:56:01 +0000
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
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::47) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd17dccb-8702-492e-5f63-08d9f53987a9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3077A7F28E8AE2541FB440C9D93A9@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMGzOguisNu+/qX2Ihn6rCKMyYglNPIhqE77rhhjChl6M2sz/19Nz89qK2vAZc7mUaCCPeztkdt2A+6ERoWlce0W6wizQYpkYmJKrr9gqFgC5feOKyeGT5KPERmnxBOf/McxibO0OzhBy4tgegjKq6onQ7/c/sJeBvvoWIgDtYFvUGAkXc4imf7EGpqSUxpV61YPErViGWON8An2BylQc6vdmlBYRp1wtB4i5w+eVp0Wf4iPsvXr22BI9noeC9+uy5/H7zLaEx29L+8A1jh2NoHsHwcVtvdzkYfbLUcyxSqo/7SXD4k6nehGyDQwEHN5j+X55kUbyea5BiQhXFSgg2R1q5hJSBCG0VBcnl/plrqN3REzlJ1z99JSn2QpohIqMXcTA/HdU9eNn9frUNV5fpZNZWdBf/z9UqD52N1D6ohBFIwCTYo5y+JQfxjW4tDDbTD0geqhPRMMvQ1Qd3hAooPROWwGQIHnj6d9DONRqGcxI/rApWfavr74eXe4CoIzG2TmT2bAvYPrpKIAVfAzn/e4KNbA+komzgVVPOrDDs6g0NgyF0aBaihumPCbcPFLtJVe4nuAGaMGDfEQdgHaU7QVL6HiJzg78TBc6mi9ZjjtfgCzxCo+sB2NA0PnMvAZY9ZKSqFMaGm9XGdsS5CHuyRuc5w7SnK5z5I9v5DEYt+0l8sJnZTTcM6R5MQ2q6RxXH+W3BH68JNKWNkGAUEalsHS2/9AR17iCdvunlq9VGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(6666004)(508600001)(6486002)(6512007)(31686004)(53546011)(2616005)(55236004)(2906002)(38100700002)(66946007)(5660300002)(186003)(110136005)(8936002)(26005)(316002)(31696002)(86362001)(83380400001)(66556008)(66476007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1qbVRLWDNGZ2J0eHpadjlmM2o5djkxaTN2YnpaTHdNYjkvT3ROSXpiblVk?=
 =?utf-8?B?QVlZQ3ZMWWIxVm9qZkNUaGxVNGVINUdOYjRYK1lGQmw2NGJ6OXJiUUcyWFdF?=
 =?utf-8?B?RFc3SkwyaEJpbmdlL3hPYm51Qmt6YUt6VkNDT2NuWTFUcFA1cmFOT1FXT3NT?=
 =?utf-8?B?NzdHV2Zlc3UzaXF3blhZMXpjbFJOMlNMdkRlOUxCR1I4M0FBbHVwcW5pdXM3?=
 =?utf-8?B?Y2Q4dEU3YjZZUWp5dDYzL0N1NGF2c1JlY1dQWFlMdkpmbGpVcjg4NVVncDBQ?=
 =?utf-8?B?endTT1JHTTM2ZFRKd2kwbXZRK3ExdFdWbjB0anJFLytDSDhrcWVuUnJOK0tp?=
 =?utf-8?B?VDFFSGlveHR2ZXVMa3VabytiVU15ZDRudERmTUNWUzVIUDI0dFFaN29OQUNr?=
 =?utf-8?B?dGFTeWhybUF1OGRhcXVXbjZNOVdRUm1WcXhsVTgzVDhIYzhpNzgvcno3a0Zi?=
 =?utf-8?B?TnBiOGxRaVZkQVdLUm0vL2FWRzZHOGhsNDRXU3E5bkNyVk1CSWVtd2hSNnY2?=
 =?utf-8?B?cTIzNjBCNG9rMkpFZ2FXK2xUMmdQalgyaS9mU0ZFYlM5RUtHVU9TSnE2eGpH?=
 =?utf-8?B?S1c1QlQ0Zm1kcEFSY2U0R1JnZ1ZOYzYwWmVZYnE0SmtzQ3RtZk4xRTdHOFBI?=
 =?utf-8?B?OVRMS2tTZ2FTYTR3V1BjOG4yOFlNaDFYTVQvYy84MlhrTmlGcGVvMFNKaENm?=
 =?utf-8?B?bXRTcWw2eW5PdlMvWHZRWExHKzJydGZmWTQ2Ky9wZ0s1TWViU0phRzNGbnIz?=
 =?utf-8?B?TEJleW4rSFk0Unpxd1hVcXlwMEVHYjRVTXkrRE9wNkQzbjhXWnoreVhLL21K?=
 =?utf-8?B?RlJhcmFvNkIwU0N0Mlp0SHFXYXYyaUN6L2FYRDRFRU0remY5WkZvQlk1SGdB?=
 =?utf-8?B?eWR6dlVGeEZseGFzc2pCUlNoR1N5dXJud0dDcGl4cnBLVXNsRmZBd2FQcElN?=
 =?utf-8?B?bHFMdFdqWDdIWU5zVjZuSmphZ25valo2dXAwWjFSY0MyM2pZSi9BWVpQWDV3?=
 =?utf-8?B?TjhpNk9BMWRuZG1FalRSVnNBVERWbjJpTktEWVJmb2xmRyt3VVhSd1dSdWQw?=
 =?utf-8?B?aXF5WVlFOTZnOTc4eTRzamM4dWZaVUhwK0tHTW41aE92Wkh2WmlvSlNqU1lt?=
 =?utf-8?B?a0lwaXlSVFVBZG9EUFYvWFNXVkZ6bmg1TXA3c0x2MW1ENnhrZmlPTTBPV0Mz?=
 =?utf-8?B?OUZTWEtJWFZjc1ZCV1U4aVZINmtkNFovMytySWt1STJHdVh0bUFWdXBGQ1Qx?=
 =?utf-8?B?RzdjZGl6MXRiOTBoTDZSR0JxaUJiLzhYQ2ZVVnVKOStGNEpOTnpSUHR4SHJM?=
 =?utf-8?B?YVhWdEQ2QzJwdjZyTmw1d043dTRyVWpNZWxjQmZUVUtFRWlYQlphNEFUaXA3?=
 =?utf-8?B?eWdCcmF5M2ZMa2RwSXB3QUhpYmxobTg1RkhSQlZyWnE5RjBVb2Y4czZOM0NT?=
 =?utf-8?B?U01lRzdIdEZrVEl6Q3VQNkgzNnkzZWI4Mk43OWl3U083SUlTaDJLcmFLRGVh?=
 =?utf-8?B?djR2TXNkTVF4SzgySFFaSGRIT3U4aU4wbHN0MGhiVlpwYmhsWHU4aHdPRGh5?=
 =?utf-8?B?ZFFTek1wZjlROHQwUjQ4cFZ6V2lLSGpNZkdyYWFCOUxIbVVHMS9wN2VtcVFi?=
 =?utf-8?B?L2JKQ3Jad3Z2YmlTRitreXl4WGl4aGc2RXFDWktXSmQ4V0dSYlhNNmVSaTdC?=
 =?utf-8?B?akl2aVFQTHVwd1paZ0t4WDUvOGJRMGlMaEtOVkU0WjFkM0swMFczRTdsZ2dx?=
 =?utf-8?B?UVlSY2VEWEZuNy83MFBNMmFxQWc5ZVlwZVp1bFQvTjVnOXBqV0VlREttbUhv?=
 =?utf-8?B?V1ZSRUJ1NjBqMTROdUlOSjlqRXBpZGtjOE9BTG4xRFJXY25pWFJucjY0c0ZU?=
 =?utf-8?B?dkNBOUU0eTlxWkw1bVUyM2YyRjhKL1pJVmtrMWlweTZ6a2hMNTFXUlk0R0dr?=
 =?utf-8?B?a21iTWhUMThxc2RJSXoyUy9jOVU4d1RXaGpQSFdlSDQ0OUM1dVVPbm1Nc1Ra?=
 =?utf-8?B?Y2t4cjlWVWhiL3hmRGxzU3QzYUVUT1p6M0RpdTZXNWdoOW1RR0xHb3IrM0FN?=
 =?utf-8?B?MU9FaGlOSlMvN0lsM2RkcHo1bHpPczVXdlJyR1BPZU05b1N0clVhUjNYd0Ni?=
 =?utf-8?B?NVFleW82MzRWOG03MkMyN3pZeHQxRG1LYlI0VjJOcHdJWHNqdUVScWRMTDJQ?=
 =?utf-8?Q?DoNunM81PK7v+XkynWB0oLw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd17dccb-8702-492e-5f63-08d9f53987a9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:56:09.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwvAf2qvYYUByQFTra3zIrCfXGtBr1LLWJr4fJNDB0QdDDsVCrziA4rB4CN/7nIscQRnKnw9y/y3gpm4v63Y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
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


On 21/02/2022 12:36, Dmitry Osipenko wrote:
> 21.02.2022 15:01, Jon Hunter пишет:
>> Hi Dmitry,
>>
>> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>>> Use hwmon_notify_event() to notify userspace and thermal core about
>>> temperature changes.
>>>
>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>    drivers/hwmon/lm90.c | 44 +++++++++++++++++++++++++++++++++-----------
>>>    1 file changed, 33 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>> index 2e057fad05b4..e7b678a40b39 100644
>>> --- a/drivers/hwmon/lm90.c
>>> +++ b/drivers/hwmon/lm90.c
>>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>>      struct lm90_data {
>>>        struct i2c_client *client;
>>> +    struct device *hwmon_dev;
>>>        u32 channel_config[4];
>>>        struct hwmon_channel_info temp_info;
>>>        const struct hwmon_channel_info *info[3];
>>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>>> *client, u16 *status)
>>>          if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>>> LM90_STATUS_LTHRM)) ||
>>>            (st2 & MAX6696_STATUS2_LOT2))
>>> -        dev_warn(&client->dev,
>>> -             "temp%d out of range, please check!\n", 1);
>>> +        dev_dbg(&client->dev,
>>> +            "temp%d out of range, please check!\n", 1);
>>>        if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>>> LM90_STATUS_RTHRM)) ||
>>>            (st2 & MAX6696_STATUS2_ROT2))
>>> -        dev_warn(&client->dev,
>>> -             "temp%d out of range, please check!\n", 2);
>>> +        dev_dbg(&client->dev,
>>> +            "temp%d out of range, please check!\n", 2);
>>>        if (st & LM90_STATUS_ROPEN)
>>> -        dev_warn(&client->dev,
>>> -             "temp%d diode open, please check!\n", 2);
>>> +        dev_dbg(&client->dev,
>>> +            "temp%d diode open, please check!\n", 2);
>>>        if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>>               MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>>> -        dev_warn(&client->dev,
>>> -             "temp%d out of range, please check!\n", 3);
>>> +        dev_dbg(&client->dev,
>>> +            "temp%d out of range, please check!\n", 3);
>>>        if (st2 & MAX6696_STATUS2_R2OPEN)
>>> -        dev_warn(&client->dev,
>>> -             "temp%d diode open, please check!\n", 3);
>>> +        dev_dbg(&client->dev,
>>> +            "temp%d diode open, please check!\n", 3);
>>> +
>>> +    if (st & LM90_STATUS_LLOW)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_min, 0);
>>> +    if (st & LM90_STATUS_RLOW)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_min, 1);
>>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_min, 2);
>>> +    if (st & LM90_STATUS_LHIGH)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_max, 0);
>>> +    if (st & LM90_STATUS_RHIGH)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_max, 1);
>>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>> +                   hwmon_temp_max, 2);
>>
>>
>> We observed a random null pointer deference crash somewhere in the
>> thermal core (crash log below is not very helpful) when calling
>> mutex_lock(). It looks like we get an interrupt when this crash
>> happens.
>>
>> Looking at the lm90 driver, per the above, I now see we are calling
>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>> hwmon_notify_event() I see that ...
>>
>> hwmon_notify_event()
>>    --> hwmon_thermal_notify()
>>      --> thermal_zone_device_update()
>>        --> update_temperature()
>>          --> mutex_lock()
>>
>> So although I don't completely understand the crash, it does seem
>> that we should not be calling hwmon_notify_event() from the
>> interrupt handler.
>>
>> BTW I have not reproduced this myself yet, so I have just been
>> reviewing the code to try and understand this.
> 
> Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
> managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
> spot any problem in the code. IIRC, it was a NULL dereference of another
> pointer within that code.


OK. From looking at the above I don't think we can call 
hwmon_notify_event() from an interrupt handler because this is going to 
try and request a mutex. So we need to fix that.

Jon


-- 
nvpublic
