Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFF59FA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiHXMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiHXMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:53:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA596753;
        Wed, 24 Aug 2022 05:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f23BidJ2Q+VN/SjoVjWjmzhFGY7bL77lKYJFfZuiaARAm6p57XJPeEhWfhBoRJOSDr4h3N4r1PRql+7fo3zecVSZFge6gjtNYZtmV7xI/thxuuvk2TjVtqovg3tNkBaLKQgI2YpsqDjt/x76zPC75LExQhU3qoOCyQU9+lcj74+4XJ9acX/PncaNwBe8vXJzO7tm1w1zNzv2Q8csZe+utovwU/3BLoD1r639d3LdCuohej2Jd7ACNgIhpEY5K5CCOpDBiI/nReHJTGGhC84tTlKLkUNBcrnIZjmu0kxBsI0rjpq7Sg2/YhHj81gl11D1f8VNkzSYTAJihpA2iwD5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN6G9qOwf8fSoutolbWDg3f7wg6W5C8PKM2Q8jcTjNY=;
 b=CXLWZQEfOuHnD5oGmNhdr+Q+9EaD7G7tJVTS//hWSM9QT/QzPnMsScY0LvRnWETQA73bAX20xDuI+3KfwJ6sEy382AG6n4hlnJikK5Nxhc77pS9tbFa12Mv9s1ImnO8T4gm8Qbug+fOH5j+CTd4fuYOz7xwlLxnGI4tawZBESfmxRg+eW5A4F30j3FUOXqWi9aVpEzJ480gJGMcLoh65t/qVQOzfMElL/DkQNkcw5ZRBfmfibVqrBmabhLB2LMWeZNc+w+D1nB0PMhbNeVVG2XY+ZzsL0PoagWxe1j+ETKvIw1mNHw7OF3ObNC7iFdl/ZeegJ8ddMBMN4HO8jQr8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN6G9qOwf8fSoutolbWDg3f7wg6W5C8PKM2Q8jcTjNY=;
 b=GeCklcZ8/IaO3CcAS3IgMy44m+IFwGEkY58VqScHcr5XnA46fzeUCFgjoO8BEA46FVsEsKFx44+XY81uUsnf/mShUPYLrZFoHheyPQHgMsgoXZv+O48v/J/DlqlsZF66OobNjDUOi7DLhElj7ld2H/sEYSyOEXBy0kGvyXyC00U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 12:53:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 12:53:48 +0000
Message-ID: <34bf5d3a-adb6-ce12-8c9c-ee9144f5262d@amd.com>
Date:   Wed, 24 Aug 2022 07:53:44 -0500
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
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4e4c5234-3327-0e49-989c-1117ffb2f13d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cca00adc-5e2c-4271-74e2-08da85cfafb6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yymnCo41UCIV3xe9TdShnJrRVTxCheUjAdCbOQ5zXYEi0jSCEmGTQPzYa77qErF50SWx3WlEN8WUvBYoS325XYZpU7JNVo/lZwKZoLFgRT7JY9UUW1eFVx+G8Sj+gzxaXQvltY2P2/xHlCnAoftPnfR8yOy5pSCtryVO1F/qj1BZb8fGOncftb7Cf9Vz66DvvL7wNgaop8I1YHS3/uEcB+iBD8sq/YX73YZSDiM6mMyI+mizfINAYT220S106f+RIEb/mvjQheT102Shjg98NmLWZmB1HkKpXkd5vbZ4ZoPqLx9m1jnbJGX10X9+hlKYa29EugVYeWe2jiq0AGqC60jaHAcq2ENxBxk7nqkKMWfHm8llAgLiVhm8sCLwauG6MZ7+urGGaT2EDKsYmAndCDa/XYTTSsWv2fm6d40ss7TNQc4lRN4qIRIBQlPBKU/R32pT6xskule+YaBTkCDjUgbtwHDzaIyuYfW3s6jr473EAgtooVBQISwy6MQiWhvmEdwi/+PC1xqkNicNPUxsqCFfDrJoV3TLhZv8IFoc/oUg+XKMooflxx9IS8Sr/OlOnS5OZ6wP2JH/qnqmYEYp4B2taZEmKvkNKmSByp58d+4AoQE5WPTG8oPlsjhA/7IwbvKDeDvbig3Xyg5HJNAzCIMLoeaCJ8fFbWyptsh1BJrxGg0njNWfXbZDJ8iB6sOWHk8f5qQFZ+LfsL3VmZbFFEGlxRzQFM3t29V/YqL+S42ZXdIIAMlwjiEAVzJZ/9eM/aJxYFho8r9U+ZZ4kzlNa0jN+LIUoRvohZZws59QQMITPXI7GEp922vmd5YYgj1AnhtqO55FD4+tfjw92tRtdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(66476007)(86362001)(66946007)(31686004)(38100700002)(36756003)(45080400002)(110136005)(8676002)(31696002)(4326008)(66556008)(186003)(966005)(6512007)(6666004)(2616005)(6506007)(41300700001)(478600001)(6486002)(53546011)(5660300002)(316002)(2906002)(30864003)(44832011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9QY3YrVmVCNUFQLzFsZmw0SjRyYXlacFJ2STNObTFLNUMxcHNIYkNJTC9w?=
 =?utf-8?B?cGFnMVVkTnczK1NCU2Y2L0JZajd0Z0Q4RUd3WWY5ZSs4NUkvMWFZSkZSbkNC?=
 =?utf-8?B?bU5jMFJxazUvc20xc1pVWEVJYmhJNmtHREI0K21aWkxSaHNPT0NuQU55Qytm?=
 =?utf-8?B?Tm5odjlCU2RGTzlqS2w0ZGxNVi9HdklHc3ZWbDlUYUtRV3FZY0FweGpuU01W?=
 =?utf-8?B?QlVmdnFJV1RJbzhzTXVsN0NuOXNUVW83RWR1QlN5ZnZUZjdES2tmOGhBRDA3?=
 =?utf-8?B?RStOeEhPR1lpdGVPVGxKT1hlaWZWUXJMbWZSTjlMVnFiMHJ4TGJyM2RqL0Vy?=
 =?utf-8?B?OHQyK2tkMDFsZXVmVHA4U3Zpelp3UW5sT3YrcXg2ZkM5eHB1RWh4NXY3dEtW?=
 =?utf-8?B?RWJvcW9IcGxmbXBnUnZpZWxjYXJKSUtCQiszVjY0cmJ2bHh3Nk1QcWpTWG5H?=
 =?utf-8?B?amwvdTVCZ2JWaVNkTm5FL2NuQlFTdEI0Y2Q5ajdtM01VRTN2d2hqakszbXg1?=
 =?utf-8?B?aC85eUh1OFNtS3JOK1dnUmpZb3VTQWhqU0tETUZBRllIRzRLT2x2NGRGNHhq?=
 =?utf-8?B?SkowWStUVXo1RExqaStjeWhDN25xT24xaGhGaGlXVXNCSTNrS2o1STVpVEgx?=
 =?utf-8?B?TzVzd2U0UHFiMWtPei9uMmoyVWFKS3RGdFREeGFiMWUvMXF1cllZZ0Y3SDdW?=
 =?utf-8?B?SVFVY3hFa3k4SldLSjIwejhFdlZrRGd6dk9FbWRLQmREY29IcjBzSVpKYkI1?=
 =?utf-8?B?VkJGaHZ2MlpnTnFBdlE3VjhtQ0ZRZjNvYWJGTFFXSGhOd0pxVGV2LzdnZkZr?=
 =?utf-8?B?eUtLdm1FOHdNUmI3YnZXY1dORWNETHllcmE2TC93MHhiRDRhdW1VYi96Z1c2?=
 =?utf-8?B?eHhGRWdSTU5uL25zMVNDYXF6VWkrditHT1Rzb3k5YTZMSEFJdTNKN051NTQv?=
 =?utf-8?B?UU9PV3FpRS9JeFl5dzhCQy81TURSNll5d2Z2Ym9TcHA5Ty8xRWRDQnBjeVZD?=
 =?utf-8?B?c0tYUnVseGk4ZFRINzFERWlYYUtnajFhV1V1Q2lRc0pWelJ6VnRXdEw1N05R?=
 =?utf-8?B?SFVIUXlkVExuemN3YzFmQ0JtNUJrR2llVjJEZVY0NEk0dS9HOHMyZGJ6Wk5m?=
 =?utf-8?B?YjNoTjdZVTh6MGpsRHJ4Wmlqb2pkc05WbkQ1dkI5a3lnWXJXZFYzblFNRk9U?=
 =?utf-8?B?UmZWOGVqMUoxMkc3ampMby9qVlJDVEdBTUNsdDlZb1BuUVNVdk1yTFJ3Y1pF?=
 =?utf-8?B?aGh6bG90aGh2aE56OEw5RHd4K2NiUGREblNISUJDaXNVRlJ0emhyTDJ0aFlo?=
 =?utf-8?B?Z21JeERYTUVnWXBTWUNFclhrZlAvOEl1WXFiaTRoL3lTSEJxb3JwOHhnQjVw?=
 =?utf-8?B?bjAzTHhUOThIQ25IaTJUbXZGeWtTSHowSUV6cWM0akhubjZvWWwzR0tHTFpM?=
 =?utf-8?B?TkpDcFB1MjRYR2NUcjBKRTYvYUJ6V1Z6REdEK1hKSkVYNEJpZDJ3OFE4Q3dl?=
 =?utf-8?B?dmg2VWJXVjdoUURiZ0VVT2RrMWRKN09qdjBrN3lZMnhrMUY3cFNmV0ZYVndN?=
 =?utf-8?B?d3hTZmZBUWJQNXBDN240NXJTYk1ycnFQQ1V6RFM0cEVKODJTYzNwb3owdkh4?=
 =?utf-8?B?RlRxZmt1Z1dMQVZTVFZrSi82c0RiNVVBVnNadjZ6WUs0MmJsa1lMU1RJZ05U?=
 =?utf-8?B?aSsvUTQwMkZjK2ZGK28xc08zRTJwbmYrTGdjUzg2QkxSUHdVOG5KNXdlaUta?=
 =?utf-8?B?ZWdMWEJZZEo5YzUyaXNJM3FWTXRycy9ydlhnaDFqV0ZkV2tidTI1cElDUHFH?=
 =?utf-8?B?OFEyMlZDb0MwRXllYXNNWkxRanNoRVEvRTlHZTQvOGZsWE0vWW9yMGswMnhR?=
 =?utf-8?B?cThXUEU4dTh0eUZ5cDJOalFmK2llYUw3dEpwQ2xEdGFXbGh4akRrc2hOZ2hS?=
 =?utf-8?B?MlZVYUNVUUVwbWt3Y3EvWGZNWkEvYnd2VWhmZE1JQVVoZDhzQ0djc0g4bHVU?=
 =?utf-8?B?WCs5VnIyWkM5WmdtU291ak9PR1FZQmdjUXh4K0JpM1hsa2doaHp5SUR4dWxX?=
 =?utf-8?B?cDlqcGlheks3YnNiamZ0YnVZTnpscHFUU3BLekpsRmR3WHpheU9uZXFWQmpJ?=
 =?utf-8?B?S2xyRnJVUFNVbXFJY1RiVk8wQ0xwckFjbzBPU1NSbmFtc2JZOXdlQ1MwVXdP?=
 =?utf-8?Q?uSTidKifYFemX7oAtDlmTx1sjqCcBWyM5AThgTZ9BnhQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca00adc-5e2c-4271-74e2-08da85cfafb6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 12:53:48.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olc3LnjxMHDUSovPnOceaTL5mPmmYqQa/5+SkK0hq5yBzfUVNmUoA8mVJaqH6YTky1QLsJV/dnM6ecraH+vRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 07:40, Hans de Goede wrote:
> Hi All,
> 
> On 8/22/22 17:43, Limonciello, Mario wrote:
>> On 8/21/2022 18:07, Luke Jones wrote:
>>> Hi Mario,
>>>
>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>> Support the hardware GPU MUX switch available on some models. This
>>>>> switch can toggle the MUX between:
>>>>>
>>>>> - 0, Dedicated mode
>>>>> - 1, Optimus mode
>>>>>
>>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>>> mode switches the system to have only the dGPU available.
>>>>>
>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>> ---
>>>>>    .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>    drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>>>    include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>    3 files changed, 76 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>                * 1 - overboost,
>>>>>                * 2 - silent
>>>>>    +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>>>> +Date:          Aug 2022
>>>>> +KernelVersion: 6.1
>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>> +Description:
>>>>> +               Switch the GPU hardware MUX mode. Laptops with this feature can
>>>>> +               can be toggled to boot with only the dGPU (discrete mode) or in
>>>>> +               standard Optimus/Hybrid mode. On switch a reboot is required:
>>>>> +                       * 0 - Discrete GPU,
>>>>> +                       * 1 - Optimus/Hybrid,
>>>>
>>>> This feel like it should probably export using /sys/class/firmware-attributes.  That's exactly how those types of attributes work.
>>>>
>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you don't need special documentation.
>>>>
>>>>> +
>>>>>    What:          /sys/devices/platform/<platform>/dgpu_disable
>>>>>    Date:          Aug 2022
>>>>>    KernelVersion: 5.17
>>>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>          bool egpu_enable_available;
>>>>>        bool dgpu_disable_available;
>>>>> +    bool gpu_mux_mode_available;
>>>>>          bool throttle_thermal_policy_available;
>>>>>        u8 throttle_thermal_policy_mode;
>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>>    }
>>>>>    static DEVICE_ATTR_RW(egpu_enable);
>>>>>    +/* gpu mux switch *************************************************************/
>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>> +{
>>>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>> +                  struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>> +   int result;
>>>>> +
>>>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>> +   if (result < 0)
>>>>> +       return result;
>>>>> +
>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>> +}
>>>>> +
>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>> +                   struct device_attribute *attr,
>>>>> +                   const char *buf, size_t count)
>>>>> +{
>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>> +   int result, err;
>>>>> +   u32 optimus;
>>>>> +
>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>> +   if (err)
>>>>> +       return err;
>>>>> +
>>>>> +   if (optimus > 1)
>>>>> +       return -EINVAL;
>>>>> +
>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>>>>> +   if (err) {
>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>> +       return err;
>>>>> +   }
>>>>> +    /* !1 is considered a fail by ASUS */
>>>>> +    if (result != 1) {
>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
>>>>> +       return -EIO;
>>>>> +   }
>>>>> +
>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
>>>>> +
>>>>> +   return count;
>>>>> +}
>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>> +
>>>>>    /* Battery ********************************************************************/
>>>>>      /* The battery maximum charging percentage */
>>>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>>>        &dev_attr_touchpad.attr,
>>>>>        &dev_attr_egpu_enable.attr,
>>>>>        &dev_attr_dgpu_disable.attr,
>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>        &dev_attr_lid_resume.attr,
>>>>>        &dev_attr_als_enable.attr,
>>>>>        &dev_attr_fan_boost_mode.attr,
>>>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>>            ok = asus->egpu_enable_available;
>>>>>        else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>            ok = asus->dgpu_disable_available;
>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>        else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>            ok = asus->fan_boost_mode_available;
>>>>>        else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>        if (err)
>>>>>            goto fail_dgpu_disable;
>>>>>    +    err = gpu_mux_mode_check_present(asus);
>>>>> +   if (err)
>>>>> +       goto fail_gpu_mux_mode;
>>>>> +
>>>>>        err = fan_boost_mode_check_present(asus);
>>>>>        if (err)
>>>>>            goto fail_fan_boost_mode;
>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>    fail_fan_boost_mode:
>>>>>    fail_egpu_enable:
>>>>>    fail_dgpu_disable:
>>>>> +fail_gpu_mux_mode:
>>>>>    fail_platform:
>>>>>    fail_panel_od:
>>>>>        kfree(asus);
>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>>> index a571b47ff362..c023332842a2 100644
>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>> @@ -98,6 +98,9 @@
>>>>>    /* dgpu on/off */
>>>>>    #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>    +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>> +
>>>>>    /* DSTS masks */
>>>>>    #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>    #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>
>>>
>>> You can see previous discussion here https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C54f5129bf4ad437bd11108da85cde220%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969416575174610%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=GqFSQY5%2BVJCX1Wytp5mGq54rcx6ks9sKrGdGFf2WtNI%3D&amp;reserved=0
>>>
>>> Below is Hans response verbatim:
>>>
>>>   > Yes it sounds like a BIOS setting is being toggled from within
>>>   > Linux, which would normally be done through the
>>>   > "firmware-attributes" class, but all existing "firmware-attributes"
>>>   > class drivers allow changing all BIOS setting not just a single
>>>   > setting, so using the  "firmware-attributes" class here is not really
>>>   > appropriate.
>>>
>>
>> Although the two consumers thus far (Lenovo and Dell) use WMI interfaces to build and discover varieties of settings there is no requirement for how the backend for firwmare-attributes works.  You can just as well poulate a single attribute statically from your driver.
>>
>> So I guess Hans and I disagree here.  I have a feeling that we shouldn't be introducing custom ABI to userspace just because only "one" setting is offered.  I anticipate that some day the DE's will offer a GUI setting built on top of fwupd which is built on top of firmware-attributes.
>>
>> If you *don't* populate a setting with firmware-attributes the only way that users will discover such a setting is by installing other custom userspace software that has the knowledge of it.
>>
>> At the end of the day it's up to Hans and Mark though, this is just my 2c.
> 
> Mario, thank you for your input here, it is much appreciated.
> 
> As Luke mentioned in my quote using the firmware-attributes class for this really seems like overkill. As for discoverability, the firmware-attributes class only standardizes how to enum / change BIOS settings. The consumer of the API still must now the name of the setting which can/will be different per vendor.
> 
> AFAIK fwupd only uses the firmware-attributes class to check for / disable some BIOS flashing protection. So having the GPU mux setting in the firmware-attributes class is not really relevant for fwupd.
> 
> If in the future some generic tool which uses the firmware-attributes class to toggle GPU muxes is created (presumably with a lookup table for the exact setting's name under the firmare-attributes API) then we can always add firmware-attributes support for the GPU mux to asus-wmi at that point in time.
> 
> I just don't think it is likely such a generic tool will happen (any time soon), so for now I still believe that using the firmware-attributes class for this is not necessary.
> 

Actually I've been actively working on that.  Take a look at fwupd main 
(what will go into the next tagged 1.8.4 release).

It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr 
set-bios-settings" which will follow the rules the kernel API uses.

So I expect that if this attribute was implemented as I suggested you 
could do:

# fwupdmgr get-bios-settings

and find the mux (including the possible values if it's declared a 
kernel enumeration attribute and possible_values is populated).  If you 
populate the optional description attribute in the kernel fwupd will 
show you what your enumerated settings mean.

followed by:

# fwupdmgr set-bios-setting dGPUMux iGPU
or
# fwupdmgr set-bios-setting dGPUMux dGPU

To set it.

fwupd will prompt you to reboot the system after it's done changing it 
as well.

It's implemented such that GUI clients can use libfwupd just the same, 
and I really think this increases discoverability of such a setting.

> Regards,
> 
> Hans
> 

