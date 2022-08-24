Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9A59FC69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiHXN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiHXN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:56:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247DE0B;
        Wed, 24 Aug 2022 06:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3yUvkpZ+QdWYtXZ9n7HMPbmWmq4FhrmDFUABlxubfdEGA44GgJKf+I47zXU8N6tTNbaDQ1v5thQOkNXXYq4HLwuReRbvwyaY0ccI4o3pVw54lShbe8QFzjksz9ZSYsTodQ+OoCrtpFRpxGdw8W3k2ydU6KfgZ7yl33+8ODr71jXk22dvyxEky9dDNpBpwOXxwFGrNcD7NX0wMyu8jL7XEkbhnpj6RI8qglO+yAjnB2OvKHr9FPGPfQjLN9vUVIivFeG/pTbGyUJaJHmWbSej6BhcrswaWKXNDjbsKnJGwyBqtFFKh31QOYHYKfZLBj9+ndtYTuOQFJ4YSdAk31Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmcJFvGFd7SVezpQh4u66Jl2vTAdwdB/u0+Fm3Yp13Q=;
 b=GX7hYy/10DQiVDcPoYOyMfpgI3t9DF8D2zfgFkg1gIPC9F4bE7Pq8MeO8n9KaQ1gKla5ydnD00FGILCKNB6hs0BSbEpnJT5CV52pbs0k+noeEDzeHfISah13P+RnEHjE28SBboyVq95qvW0+nMR08Hk4L2jlR3TVm83xFdPwHD957dg1A8+lhYbadXqTo+mTMZvknNhsxHD7FUudGXt8XEYImbp9lDOi1rRSiR8S0e4jMoeQmfKNhC7Mq+m7R5G6xOz6dKbL9MHT1HsVehZDJG+LhFoR4A1x6TpZaLqPbfbTUjyr9yq0XbmZhcmigdJVLO0192ok9CyRGNH0vWKhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmcJFvGFd7SVezpQh4u66Jl2vTAdwdB/u0+Fm3Yp13Q=;
 b=SiLG0ZIvy8F54nwknopElxHCWXWa5zVnQJcSJDmfcIEzbltsLWHtzb+JD5LLzQy1C6TBheaXwQYIwHIlt/uxLMyhebwRnBsYYtRQVM6c7SFhWyhV99PYqDcRF+dJrVAUpNjL+PiNM7c4ZJ7uwmdPGkMNADHv6FuxNQiIHtP5PP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB3391.namprd12.prod.outlook.com (2603:10b6:208:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 13:55:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 13:55:24 +0000
Message-ID: <e8f8df44-8edd-fd45-f947-300ac98a5a41@amd.com>
Date:   Wed, 24 Aug 2022 08:55:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Luke Jones <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
 <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
 <UVMZGR.6LXKPONA9OS33@ljones.dev>
 <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
 <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
 <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
 <fda6b7fc-b307-f4f3-1176-6b15c639b3d0@redhat.com>
 <80a42677-81a1-dc97-5ee3-86c80c79500b@amd.com>
 <18f6f6ea-5a39-87bb-29e5-e97c7ef96d0a@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <18f6f6ea-5a39-87bb-29e5-e97c7ef96d0a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:806:122::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35391ef-1e5d-47bd-4742-08da85d84ab7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SW+18cupCoe/Q1Fdslr5MoYiB1TWwWRTQ2AGDYeWMcOTSspA2CyGM5ZaeT2fylZvihJYE7gmc4CjGOrlsIUfN5FM+LZ/gYGgEkM+myAHgCPPZYBpGCw9skOxGmHp4t1zwSkOt2N1J5ePHH2Wdrpi2Fb9qRLziRBhICkwrLybHlxC9qhE7BYb8X3yMtJv5qcTDFrPfrzA9sIe2JWsat0enBxRoxithgSYdyM2EemfXov7v9Ud+BTjURq4thEIlR+Jg+MszPOVv6j1QNS/GcQmGfJSiXUH7STQOj6vJI0Nq/JIFHr8RHdRTkkkOCHUl1UB1SwtkAkZQmHldRfHDuwjIcJK+lH2/g/U8VWCfO4WrHR5/URQi8vWS2UcWddipox03+W+0gDpGptot3/avsoC8M5GWbtWtKm/tI4DQFYVzVuElJ2x1d1ahRDEOeQzceitzAs9pCvs1tiC9QezJrqztIHVQbcQf24UAZalk0ziqbS8HSbHbRw4oPji0WP8ksjhANRGiifPblCiR1F+QU8bLrOygteJdKRMHMaYSGhHG/cl9bDaQOyOHwahapz/GZwnnbj3z7Aa9LX4eracCZS2pwwzNrzDMbV6lnHcUDbmACx8TQlP/T3R3Oq34bS7PgpLUMLUFuvUfRxJbipETr8hfenH505jF0PXopJpP7LvI4tRP16Ksl6zq5T4iI/knrduX3ttrywgqEOsZtgp88dcqZKmnd6DW6FRCNqmCNIBJd1n2msfyZKWW12bljJaoWzhKJ8KAjWvnnGjNRJnE9X5fuMz3nO2Y9QhJDsDmynwh+2byJN9EkaniLlW89Ggq3KQJ8pgdvA1sTPOWC8elilezQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(41300700001)(6506007)(53546011)(6512007)(31696002)(86362001)(36756003)(83380400001)(478600001)(31686004)(186003)(2616005)(6486002)(966005)(45080400002)(66556008)(66476007)(4326008)(66946007)(8676002)(110136005)(316002)(38100700002)(30864003)(8936002)(44832011)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1Qc0M0TjlWYjV2eDhmU1hMbGd3dW9oQ25hYm5Bc0wwWmJWZGR3aXYyMEV5?=
 =?utf-8?B?RnJ2REFXNkJYVVlVYk1rVmxONjVuMnh3TUR2bzdNUVFFeVgvM09UQlU5LzBJ?=
 =?utf-8?B?T1Rnb3d0ckFKVWU5dWVFRm5XTjFqS2V6RGRMQ0xRZjB5aDI1dFNBS2hBeHcr?=
 =?utf-8?B?U0Y3YXlMMTNPczczNm1PaDFVMHp2WFMxOGVEMW9WZWIwd1ppcEN4KzdZWW0x?=
 =?utf-8?B?dExNQ2ptNXlheUhhemFlZE55bi94cFRJdkJEcEc2V1kzc0s3Z3p2UWRnYmFo?=
 =?utf-8?B?UmZuT05TbnIrbUZJU3dZVnNWMVNYNFp1c21CSzF0S3NmSjVVNGdnTkd1TmF6?=
 =?utf-8?B?STJaZW1mZ3ZwYkI4T2llOTBGeFVJV1JYYlRPT0FodThEZGJ3SFlVOVQ1cmpw?=
 =?utf-8?B?NU9zcXV2bXBNNll5MDB0NDlNdGRVdTRxQVJiZ1ZFRVRDd0ZMZTAwOGk0c3FP?=
 =?utf-8?B?RXFFcjRBR21Ub1B2dTRRLzdDMjB0UW9hSnlzZGJEb1habU1JMXB4aGs2MTlt?=
 =?utf-8?B?Qmcrc2hrNUlOL0VmbCtJeXFnN3hCNUZYbHlnQlRleEFJakk2WDRlREpoMXhB?=
 =?utf-8?B?LytvZ0JjaS92UGFVNE4wa3pyYVBYN0k2UEQ5VzgvWDc1WFhSblR0MmVBbThw?=
 =?utf-8?B?dWpUQy8yNlRTUGlmVDFGSjUxRXNvV3dCN1BZTERIb2t3WTkwYnVicGlFVzJQ?=
 =?utf-8?B?bnBqZHBIZUllYnVUL0M2MEdrWUlCbEd5UThZeW1WQzdCakhhNTk2ck9YUGFj?=
 =?utf-8?B?ZFlRNFJ1MnBpUFdlYjNyUHduS3hUeUErNDhFU2RZOXNnb1B4M2g5OVY0cjN5?=
 =?utf-8?B?RnVKYVZWaE82aWVuSzZkdnlJcVIwNStqWlQ5dnQvcDBLNXhwY3BzcUFBUklo?=
 =?utf-8?B?QzgrQUkxeFN4MCtkZzAyVWpLTnNtdThhVm1vS2xVaHlNTTY5ZFRzSEdZc2tR?=
 =?utf-8?B?Yi96bENMNWlmWEdkSXFPWU9kQ0dBS2h0ZktFck04emNvSFNOWVN4WHdReUlv?=
 =?utf-8?B?aTRpRTVRazNXbmFyTjltckhMeTFTMnB3YVg4Z3NBT1REUFc5ci9Ib3loQnRz?=
 =?utf-8?B?UDVJNGI0NjdqM05SNGRpQWZjWGczOXZkWG44OHB4N3JDbmkzSVJMYTZEaURC?=
 =?utf-8?B?S3ZzcDY0SDFoMFVrRDU5ZkR0MjJ6U2k2aUVlUCt4QUp0aHhUdVYxa0hya0hQ?=
 =?utf-8?B?RUVKU0IxbENtaE5Zd1BuNW9yaUZMQ1cxcVZqMmRkdVJaNVpGS0hoK3hRVFVX?=
 =?utf-8?B?eHJLU0VaLzMvNk0vSWlnZGl6MllaSkJ3cGI3aXpjbEFUWXBzR0JsVmJhdFdy?=
 =?utf-8?B?MVlERTJ0cXpuejNFU1d1dEp5cVZXdi9VcGRaT3JQRkdJTUNmelVJczE0TmJy?=
 =?utf-8?B?SmZkWW1iV005V0xnYnN6QVdGaitEVHBtZTdaYjNPRGZlSXI0dlR1V0pxcHRr?=
 =?utf-8?B?SnIxU0VsK0M3TVltenZQc1ZuV241dU5pZERoeERjZGZWeU95OWROeGh6dWdm?=
 =?utf-8?B?TE8zN0tMV3dvYzZaS3RCZnJLTjFRaE9mR2dHVHg3VGZaY1VPcFhXVTBhUlJT?=
 =?utf-8?B?R012S0lQTEJtamVVcVpvd1ZKM041UDNtTlI5dlJLSVpsMGRJVEpuSW90b3hl?=
 =?utf-8?B?c0s4R2hteXRDWitIckE4NmNTVGU1Z25zRGNxRTVaMktlUS93UU5xQnFzeEJ1?=
 =?utf-8?B?eHdTdis2R0FuYVdBQnBrOXBKVHpwWk5Rc1NhM0NUdHlzNE11TWJuR0h4bHpD?=
 =?utf-8?B?RDNpUElvTnpVaTNaQWw1N3hnOEFnOWJQc0dSMDM3ZzZTZ2RlNzN4ZnZweFd1?=
 =?utf-8?B?aTBmMXpXSFVJK2hCbEdqdTF1emNUd1kzbHIrVlZRbUoyVGoyZnlNdzlYQkF3?=
 =?utf-8?B?QTFCWXRLTTVXa3RsT2lQcS9iNVYyZzN5emVPUk51cm1wOUZkcTJhdTBPSHp0?=
 =?utf-8?B?bDhsd0Q4cHpZN3AwR2tlZ0lEZ1NObVZzbHFtcWVFTXBqaUozdmJTSU1MZlVi?=
 =?utf-8?B?MnNWSWdRR2lFWG92Q2NMcmp2Y0VSTU1vSVE5Q1EzNnpYMEdLSmg2RGxvalVP?=
 =?utf-8?B?T1o3NkdhZEtlTGdFUjlOelFHRWl1TjZpNi92ODRWU0lWR2llcU1RNHg4T0xJ?=
 =?utf-8?B?K082d2hvYXBFWituYUEyUFlGZGdUVksxTTBQSXRZa2VzZ1BzNlZJUjdCOEkz?=
 =?utf-8?Q?Ts+I+CbuxOKsXe+TZF4lePEe0bruM+gecaTG9nnblz+k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35391ef-1e5d-47bd-4742-08da85d84ab7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:55:24.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D1De8bK6lLON/jddkv4OW9BlRZGkjal02IARTqgKKDg61xVPqTqAoQCzC+zzmuSiuLKiwF20mGYY0TJWzEreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 08:49, Hans de Goede wrote:
> Hi,
> 
> On 8/24/22 15:09, Mario Limonciello wrote:
>> On 8/24/22 08:03, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 8/24/22 14:53, Mario Limonciello wrote:
>>>> On 8/24/22 07:40, Hans de Goede wrote:
>>>>> Hi All,
>>>>>
>>>>> On 8/22/22 17:43, Limonciello, Mario wrote:
>>>>>> On 8/21/2022 18:07, Luke Jones wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>>>>>> Support the hardware GPU MUX switch available on some models. This
>>>>>>>>> switch can toggle the MUX between:
>>>>>>>>>
>>>>>>>>> - 0, Dedicated mode
>>>>>>>>> - 1, Optimus mode
>>>>>>>>>
>>>>>>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>>>>>>> mode switches the system to have only the dGPU available.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>>>> ---
>>>>>>>>>      .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>>>>>      drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>>>>>>>      include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>>>>>      3 files changed, 76 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>>>>>                  * 1 - overboost,
>>>>>>>>>                  * 2 - silent
>>>>>>>>>      +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>>>>>>>> +Date:          Aug 2022
>>>>>>>>> +KernelVersion: 6.1
>>>>>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>>>>>> +Description:
>>>>>>>>> +               Switch the GPU hardware MUX mode. Laptops with this feature can
>>>>>>>>> +               can be toggled to boot with only the dGPU (discrete mode) or in
>>>>>>>>> +               standard Optimus/Hybrid mode. On switch a reboot is required:
>>>>>>>>> +                       * 0 - Discrete GPU,
>>>>>>>>> +                       * 1 - Optimus/Hybrid,
>>>>>>>>
>>>>>>>> This feel like it should probably export using /sys/class/firmware-attributes.  That's exactly how those types of attributes work.
>>>>>>>>
>>>>>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you don't need special documentation.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>      What:          /sys/devices/platform/<platform>/dgpu_disable
>>>>>>>>>      Date:          Aug 2022
>>>>>>>>>      KernelVersion: 5.17
>>>>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>>>>>            bool egpu_enable_available;
>>>>>>>>>          bool dgpu_disable_available;
>>>>>>>>> +    bool gpu_mux_mode_available;
>>>>>>>>>            bool throttle_thermal_policy_available;
>>>>>>>>>          u8 throttle_thermal_policy_mode;
>>>>>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>>>>>>      }
>>>>>>>>>      static DEVICE_ATTR_RW(egpu_enable);
>>>>>>>>>      +/* gpu mux switch *************************************************************/
>>>>>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>>>>>> +{
>>>>>>>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>>> +
>>>>>>>>> +   return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>>>>>> +                  struct device_attribute *attr, char *buf)
>>>>>>>>> +{
>>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>>> +   int result;
>>>>>>>>> +
>>>>>>>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>>>> +   if (result < 0)
>>>>>>>>> +       return result;
>>>>>>>>> +
>>>>>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>>>>>> +                   struct device_attribute *attr,
>>>>>>>>> +                   const char *buf, size_t count)
>>>>>>>>> +{
>>>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>>>> +   int result, err;
>>>>>>>>> +   u32 optimus;
>>>>>>>>> +
>>>>>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>>>>>> +   if (err)
>>>>>>>>> +       return err;
>>>>>>>>> +
>>>>>>>>> +   if (optimus > 1)
>>>>>>>>> +       return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>>>>>>>>> +   if (err) {
>>>>>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>>>>>> +       return err;
>>>>>>>>> +   }
>>>>>>>>> +    /* !1 is considered a fail by ASUS */
>>>>>>>>> +    if (result != 1) {
>>>>>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
>>>>>>>>> +       return -EIO;
>>>>>>>>> +   }
>>>>>>>>> +
>>>>>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
>>>>>>>>> +
>>>>>>>>> +   return count;
>>>>>>>>> +}
>>>>>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>>>>>> +
>>>>>>>>>      /* Battery ********************************************************************/
>>>>>>>>>        /* The battery maximum charging percentage */
>>>>>>>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>>>>>>>          &dev_attr_touchpad.attr,
>>>>>>>>>          &dev_attr_egpu_enable.attr,
>>>>>>>>>          &dev_attr_dgpu_disable.attr,
>>>>>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>>>>>          &dev_attr_lid_resume.attr,
>>>>>>>>>          &dev_attr_als_enable.attr,
>>>>>>>>>          &dev_attr_fan_boost_mode.attr,
>>>>>>>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>>>>>>              ok = asus->egpu_enable_available;
>>>>>>>>>          else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>>>>>              ok = asus->dgpu_disable_available;
>>>>>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>>>>>          else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>>>>>              ok = asus->fan_boost_mode_available;
>>>>>>>>>          else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>>>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>>>>          if (err)
>>>>>>>>>              goto fail_dgpu_disable;
>>>>>>>>>      +    err = gpu_mux_mode_check_present(asus);
>>>>>>>>> +   if (err)
>>>>>>>>> +       goto fail_gpu_mux_mode;
>>>>>>>>> +
>>>>>>>>>          err = fan_boost_mode_check_present(asus);
>>>>>>>>>          if (err)
>>>>>>>>>              goto fail_fan_boost_mode;
>>>>>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>>>>      fail_fan_boost_mode:
>>>>>>>>>      fail_egpu_enable:
>>>>>>>>>      fail_dgpu_disable:
>>>>>>>>> +fail_gpu_mux_mode:
>>>>>>>>>      fail_platform:
>>>>>>>>>      fail_panel_od:
>>>>>>>>>          kfree(asus);
>>>>>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> index a571b47ff362..c023332842a2 100644
>>>>>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>>>> @@ -98,6 +98,9 @@
>>>>>>>>>      /* dgpu on/off */
>>>>>>>>>      #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>>>>>      +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>>>>>> +
>>>>>>>>>      /* DSTS masks */
>>>>>>>>>      #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>>>>>      #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>>>>>
>>>>>>>
>>>>>>> You can see previous discussion here https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cdfd7f0fd73f4438aa06108da85d787c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969458019501480%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1dknF207zR%2BTQz96qLaWFOhrYsL2IEYCABDuIAuhuKc%3D&amp;reserved=0
>>>>>>>
>>>>>>> Below is Hans response verbatim:
>>>>>>>
>>>>>>>     > Yes it sounds like a BIOS setting is being toggled from within
>>>>>>>     > Linux, which would normally be done through the
>>>>>>>     > "firmware-attributes" class, but all existing "firmware-attributes"
>>>>>>>     > class drivers allow changing all BIOS setting not just a single
>>>>>>>     > setting, so using the  "firmware-attributes" class here is not really
>>>>>>>     > appropriate.
>>>>>>>
>>>>>>
>>>>>> Although the two consumers thus far (Lenovo and Dell) use WMI interfaces to build and discover varieties of settings there is no requirement for how the backend for firwmare-attributes works.  You can just as well poulate a single attribute statically from your driver.
>>>>>>
>>>>>> So I guess Hans and I disagree here.  I have a feeling that we shouldn't be introducing custom ABI to userspace just because only "one" setting is offered.  I anticipate that some day the DE's will offer a GUI setting built on top of fwupd which is built on top of firmware-attributes.
>>>>>>
>>>>>> If you *don't* populate a setting with firmware-attributes the only way that users will discover such a setting is by installing other custom userspace software that has the knowledge of it.
>>>>>>
>>>>>> At the end of the day it's up to Hans and Mark though, this is just my 2c.
>>>>>
>>>>> Mario, thank you for your input here, it is much appreciated.
>>>>>
>>>>> As Luke mentioned in my quote using the firmware-attributes class for this really seems like overkill. As for discoverability, the firmware-attributes class only standardizes how to enum / change BIOS settings. The consumer of the API still must now the name of the setting which can/will be different per vendor.
>>>>>
>>>>> AFAIK fwupd only uses the firmware-attributes class to check for / disable some BIOS flashing protection. So having the GPU mux setting in the firmware-attributes class is not really relevant for fwupd.
>>>>>
>>>>> If in the future some generic tool which uses the firmware-attributes class to toggle GPU muxes is created (presumably with a lookup table for the exact setting's name under the firmare-attributes API) then we can always add firmware-attributes support for the GPU mux to asus-wmi at that point in time.
>>>>>
>>>>> I just don't think it is likely such a generic tool will happen (any time soon), so for now I still believe that using the firmware-attributes class for this is not necessary.
>>>>>
>>>>
>>>> Actually I've been actively working on that.  Take a look at fwupd main (what will go into the next tagged 1.8.4 release).
>>>>
>>>> It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr set-bios-settings" which will follow the rules the kernel API uses.
>>>>
>>>> So I expect that if this attribute was implemented as I suggested you could do:
>>>>
>>>> # fwupdmgr get-bios-settings
>>>>
>>>> and find the mux (including the possible values if it's declared a kernel enumeration attribute and possible_values is populated).  If you populate the optional description attribute in the kernel fwupd will show you what your enumerated settings mean.
>>>>
>>>> followed by:
>>>>
>>>> # fwupdmgr set-bios-setting dGPUMux iGPU
>>>> or
>>>> # fwupdmgr set-bios-setting dGPUMux dGPU
>>>>
>>>> To set it.
>>>>
>>>> fwupd will prompt you to reboot the system after it's done changing it as well.
>>>>
>>>> It's implemented such that GUI clients can use libfwupd just the same, and I really think this increases discoverability of such a setting.
>>>
>>> Interesting, I must admit that that makes your argument for using the firmware-attributes class stronger.
>>>
>>> But in the end it IMHO still feels wrong to add firmware-attribute support for just a single setting, rather then for something which actually exports all or most BIOS settings.
>>
>> OK thanks for your thoughts.
>>
>>>
>>> So for now I'm going to with this patch as is. If eventually it turns out that having this inside the firmware-attributes class would be really useful we can add it later, while keeping the sysfs attr for backward compat. My thinking being here that the code for the single sysfs attr is quite small, where as adding firmware-attributes class support will be more involved
>> At least looking at the context of that diff I see a whole bunch of settings listed and this is "just one more". I noticed:  "eGPU", "lid resume", "ALS enable", "fan boost mode".
>>
>> Maybe a later follow up should implement ALL of these as firmware-attributes but keep compatibility for sysfs.
> 
> Yes that might be interesting, although most of these do not require a reboot AFAIK, still
> exporting them in some way where they are easier to discover/enumerate for userspace
> might be useful.

There's an assumption in fwupd right now that it doesn't re-read the 
pending_reboot attribute that I'll fix.

It's up to the drivers to set that attribute if the system needs a 
reboot though.  I remember when the Dell driver was implemented that 
some attributes don't need a reboot as well (particularly BIOS password 
IIRC).

> 
> Regards,
> 
> Hans
> 

