Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838FD59FAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiHXNJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiHXNJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:09:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3604297537;
        Wed, 24 Aug 2022 06:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYBRFgJCRJlbY3Z8kZJPwFCNttu5SGI71LsksJpmHtdI4TuwYHpj7V8zwRkFj0r+sSpiTjRvb+AiSEZsC5jXomfLQ6z8Ljo0kF1u6E6O3Gub3poScE38aO3q4qh1vU0E0Cx1jLlLyUQfVJGqxkoEOET2oWy6iQ8nHK2dVVqvRLyj4kO0Ij5poxvLRSPetJD9hcKeVL9N3rx8yGc5Fj+s/4/UHz1C0ihUBjiEqgLfFx+9RSlelv7W9rVwhsSdXoSDbFj2pYY+GnEAZ2mdwzUv9RvHFo/VZapOyoM+nFjI9ye5ZoHqwF944HGKbTyDev0iq9tLhv0rzbNkzi0R9s+91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQCM+NBQL5UMLdLokOVhw+RpiCPIyIJZgr5mdbVWXyY=;
 b=IJB/T+BgcJtWUv6YYOfx+aI1p4zWHBxVLQ97Dq7TFpN722q+RQ5ewzcfdWrTUe1+oN5FgtfjR6f1eFp02yAMwKW1y77Exm8QmlSjdOHICty76ysJww0mD1+wWC5lEuY+eJQ1tlq6Y1CrQztXVhVLIqNCLFGgMQKKkNr1I8HfkfTwfBqCNAcXWO9UVRLoj5yd+n30vc9HoTQj0yVlvQ0pSKYhWcKjug1WAqgY1bGPjqjxWWmTwyDGK1zMOElfI97dMlmEHzk42Ojs/7u2APFqtWboHNACL7Kx1BUqtdYY10GQ+6ZZ0V4I1K6eMjErhrmkp9SsYcQrK8EpGttqu2hCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQCM+NBQL5UMLdLokOVhw+RpiCPIyIJZgr5mdbVWXyY=;
 b=ouy14LGnUrtB6Yhru5TqsnNoI1ZVI4hyZanqISwVONiCnNgPFDRJSRNVspwOebr5qrA3Rv+nD+UeS1Gp8blq8P3WMto/CZ2rSLUkVOUl1R4jct9ROHEAvHgYDUhGHxnXnLhs6tXHV9uNN8EfVHWLdVhnRvHRem+N8btVZB5ufuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 13:09:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 13:09:11 +0000
Message-ID: <80a42677-81a1-dc97-5ee3-86c80c79500b@amd.com>
Date:   Wed, 24 Aug 2022 08:09:08 -0500
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
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fda6b7fc-b307-f4f3-1176-6b15c639b3d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1447b572-2dfd-47cb-4316-08da85d1d661
X-MS-TrafficTypeDiagnostic: IA1PR12MB6306:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dk3i//F/hK8oPaByQrE8yQo04iWwYUKDnmJNNd3kR19EMF6LcORqOkjteQKza1lWZ+z8Yey+zHchqoSGJgd83ci4CV0R+W5tDpNvEq2wnxuyXuvrkVuf7u0gzEUy3O63xtyKEiCVTGuAa/4Xjv0FEacHTRP7lvkizvR0059TZlgmVwveT5W1SqiYF8fhNsOjDaztSN2fgbrWUPylsoMf95X2ih9agIVTmXNQXTkOO2z4UIIafoRFcrVu7iQaGXyeD+u/3OLE8E17Iz1LXOO10t+WnelqnqMA2Y+RDOJy/AGjw3OBvZp7TD9ztn9lUY8MNVGC8tQRIhbN6Gcg7/zb1+mqFA41QO/2Pj1WcfAI/xIAgfn4jLZnfVNx3rZPx9VGVMrExcYmMykR9cHcyzO3jZbZ5kqaroNTmk8mbcEthoV1wlYVb1oy203PVxtJUCwuCDi5MEonXWXw1Y0fBE5Egz9XTrKcA7lLp52d30fMv2vKzrK5mWpt4pB04ad7iEAbpKVkjwPISx0sMrX7G94+x7OaJ7gxH4qSvlRF0OZzhtZsY0GMjFUcSOupgJ9DDX4BFo19KkDUU40ksIlC/BqU81PPA6NB+I3q0ZIvdud2IOIKmsK1wAodtJxQhIBWkUJgSVnEf7Am9WIBwCZqLdoZOPW6TJGt7Dd5NPzBM4WFmCLdKh02moiHVDPvqeQx8vEbRm+MFBX8Ge1sKYTmEqvwxEdv0j8rA/17LimQMwN4b4hHJ9mXmeHUKh9itGj4ROYo3NjicETtZq6eA0HJijeq9CZDlUC3eWU9dRRgyWV+2y5JmVEXz93NTjqSqmCp6mE8RSQmCz5p9MRkV5tW6jnORA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(6666004)(53546011)(6506007)(966005)(41300700001)(6486002)(478600001)(83380400001)(6512007)(2616005)(186003)(2906002)(44832011)(8936002)(5660300002)(30864003)(316002)(4326008)(45080400002)(110136005)(66476007)(66556008)(66946007)(8676002)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZnUmQrSVZVb3JCS1NUNlFrc2x6aUk3NU1DcnlMdFFKL09tZWpoazRjcjRE?=
 =?utf-8?B?Ym5mQzF2TkdzY05saUoxZFZsYjNyR1FlamMzVkVRaCszR3Y3RXN4VGZnOGhZ?=
 =?utf-8?B?MGhKSFlUdVBYQUcvMzJEZVg3QWx5STNVL295czc1bWFSbjhNdWpyeXZVbDZV?=
 =?utf-8?B?dDFQQ3Q4UmU4OEtGL05kRVlDQWtxSDhSS3l3aXNtNk1UcUVYcjdScU8wWjBm?=
 =?utf-8?B?eEg5T0NBbzBKVW11d0M2NVdJU2FpU0trYnJXWHBVNHdDcjJkeERycDhMTnZx?=
 =?utf-8?B?OUI0Uk03dms3VVdjUE80Y3hmbW02ektJYlZxbzhhc0g0YW14T1BWc0JuSmhF?=
 =?utf-8?B?QjJHOS9obCtwQ1UrRUFwWXB3azhadGVUZGs1VWx5TTgxbDFHeXBpcmR4STJU?=
 =?utf-8?B?ak0zL2VDUzNqcmF5bnBWd3JqenJaM2hCNHUvbGFVV0xzM0dISTJoYi8rMzJZ?=
 =?utf-8?B?K25FWGQxN1l5dmxKSFE1YmFpMkpTT2VMLzlXcVluUEpDT0Y1ZVZtdFIzUE9t?=
 =?utf-8?B?S1RsYzdvVnAwdnJTbWF6SHNVYjlYV0dEcG5mbm5NMmZxb2lCT2FKbEFFbkJ6?=
 =?utf-8?B?TEI3L0NHQW4wcCtINjRqWEh3QnM3cGRYUEY5eWVtZWxrVzAvUjBlMC9yaWJU?=
 =?utf-8?B?bGluSHZnK3dWUjIwSm9WTnpYRTFnTGxuR0t0ZEJRYnYrbnBVY0JESE8vYUxI?=
 =?utf-8?B?eDhwcWJrU1JpaDJ2clN1eG5WOWs1UjRuV3BhZ1NRTnhXbG5JcUtkZVNvQUo3?=
 =?utf-8?B?LzhnNkFUYTdld1V6U3JOakNWbG5zUmI1b2d2KzNsbXJVamVMR0RBd2VpMjVt?=
 =?utf-8?B?Qm5UUDNJWWo4am9yS3BhY2N5QW9Wdm1jYWpMOGZzaG5EbkNlUVBNYUluRWg5?=
 =?utf-8?B?cHRyWE1yaDI2VXlrU0ZkUGU0SDFIejZBT0FYMHd1bFhLL0pQRGlydXBEcita?=
 =?utf-8?B?OFkrRVRyeDZSZWNoRDU5NFpJZ09pd3g0cEpVaWl0NDVFRExWVHl6RStLcnR3?=
 =?utf-8?B?VU9EcWN5dHRLTlRlVDQrMFlHbTdvZXp5N1VZRG5iZHliZVdjdGsvZ1Blb2ZG?=
 =?utf-8?B?ZFJMNUREWGp6VFlRZHNIY0VpZUV1SFlTMDNwRUV0TEsrc2hGL1VZV2JvQTJF?=
 =?utf-8?B?cWd5NURzVTlQalhyVE5EaUJ3TU5FUUhwWFVVSk5KNVR3emtuVm1uRVBEUVRs?=
 =?utf-8?B?QWdQVTg1Y0cyYksvRHFzeWpPa29JMkhMY2VYNG95VExjdnJwMlA1RVNKRzU3?=
 =?utf-8?B?cWxPbWEyNENKd3IvWEdhWGtUWGdkcS9kRWx1OXBJM0QrWXByU2lqV09JaWtQ?=
 =?utf-8?B?RUJUL3ZHUmlialdCMHB3NGhuZlkxYnRNWVF5WUIvNWRoU1RBNVQwKzkrWlNC?=
 =?utf-8?B?Tm1LRFFreFduL21QcE1tcUNNejlodWtQbkNKaTN4V090aWhLaFRUeUdvVVNm?=
 =?utf-8?B?WWZUcFhsTFlkZmRLdVZLbVdUdkEwNThDVW82Y001QWN5b0hDKzFEQ1c2RHBx?=
 =?utf-8?B?ajc0eWpxVkVlRmdldmQ0VlRHZWlaQWxhUk5sWkJKcHZHSHdEOWhrRUg2bWR2?=
 =?utf-8?B?bTg1UE9lVGtocWc1TnhkMG5KMXpRYjRFVk1oMy9oTHJxSXBrNmtOcUlSVDdD?=
 =?utf-8?B?NmxFL3NiR3ExVzVUcytvM3hwNjRoWmRzQWIzRGJJaUEzUk1jL0Z5SmVzVXJq?=
 =?utf-8?B?ZE1jQzZOWFJSNWZ1YzJsTlJPcUMyaDBPUzErT05TZVFta3ZFNm1icXFHUS9x?=
 =?utf-8?B?aFhndk83UWJsSjVIWjRaWlU5VnJ3bHdpKzJXTHhLOExBS0JvMUlHSlBEM1JS?=
 =?utf-8?B?Kzd0V05PUXFDejlldnhDNGZ0NHVDVVFHeTdyY1lZeUp5VkhpN0hLQmJsRmlW?=
 =?utf-8?B?N3pvRnZ5Z1pzQk84YTc2blBvdzMwVjVNRjNYSWkzY2h1RE9nWlM4ZmRiZm5O?=
 =?utf-8?B?MXVCQzlZRGZjRzJYQVJSbVpjTi9qam1odDVQajR6c216ZVNNenozZXZtVVVz?=
 =?utf-8?B?UEV2cUlHZTM4cmdUTHVucmt0dGRZbXNMR3hZNVJ5WkFrVmdUdTJUSjVUbVFp?=
 =?utf-8?B?T2NNb0owcThMcjVoNldCNjV6Nm44dVZ3Wm9QOStsZDJxZlk2MjM4SkJQTHRG?=
 =?utf-8?B?YloyTFdDTTQzQnBXR3ZTMmVLYSs2VEhLOU1pYzdpN3NCbiszTjAxYnMvWGli?=
 =?utf-8?Q?gJ/FjJDwHXqGgMPwQ5QJpxcaqLq9WyTNMlq79xKMWYZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1447b572-2dfd-47cb-4316-08da85d1d661
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:09:11.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbaSNU4zFt5rQ8mPHI8HHcdYaMo6bp9CplSuWmXJm6w87RXDPuj+mdMuAlr9IfBbfVAHelXxFkaFI0MwbNlCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 08:03, Hans de Goede wrote:
> Hi,
> 
> On 8/24/22 14:53, Mario Limonciello wrote:
>> On 8/24/22 07:40, Hans de Goede wrote:
>>> Hi All,
>>>
>>> On 8/22/22 17:43, Limonciello, Mario wrote:
>>>> On 8/21/2022 18:07, Luke Jones wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>> On 8/13/22 04:26, Luke D. Jones wrote:
>>>>>>> Support the hardware GPU MUX switch available on some models. This
>>>>>>> switch can toggle the MUX between:
>>>>>>>
>>>>>>> - 0, Dedicated mode
>>>>>>> - 1, Optimus mode
>>>>>>>
>>>>>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>>>>>> mode switches the system to have only the dGPU available.
>>>>>>>
>>>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>> ---
>>>>>>>     .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>>>>>     drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>>>>>     include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>>>>>     3 files changed, 76 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>> index 574b5170a37d..03124eab7f01 100644
>>>>>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>> @@ -58,6 +58,17 @@ Description:
>>>>>>>                 * 1 - overboost,
>>>>>>>                 * 2 - silent
>>>>>>>     +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>>>>>> +Date:          Aug 2022
>>>>>>> +KernelVersion: 6.1
>>>>>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>>>>>> +Description:
>>>>>>> +               Switch the GPU hardware MUX mode. Laptops with this feature can
>>>>>>> +               can be toggled to boot with only the dGPU (discrete mode) or in
>>>>>>> +               standard Optimus/Hybrid mode. On switch a reboot is required:
>>>>>>> +                       * 0 - Discrete GPU,
>>>>>>> +                       * 1 - Optimus/Hybrid,
>>>>>>
>>>>>> This feel like it should probably export using /sys/class/firmware-attributes.  That's exactly how those types of attributes work.
>>>>>>
>>>>>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you don't need special documentation.
>>>>>>
>>>>>>> +
>>>>>>>     What:          /sys/devices/platform/<platform>/dgpu_disable
>>>>>>>     Date:          Aug 2022
>>>>>>>     KernelVersion: 5.17
>>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>>> index e2b51b5550e8..0421ffb81927 100644
>>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>>>>>           bool egpu_enable_available;
>>>>>>>         bool dgpu_disable_available;
>>>>>>> +    bool gpu_mux_mode_available;
>>>>>>>           bool throttle_thermal_policy_available;
>>>>>>>         u8 throttle_thermal_policy_mode;
>>>>>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>>>>>>>     }
>>>>>>>     static DEVICE_ATTR_RW(egpu_enable);
>>>>>>>     +/* gpu mux switch *************************************************************/
>>>>>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>>>>>> +{
>>>>>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>> +
>>>>>>> +   return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>>>>>> +                  struct device_attribute *attr, char *buf)
>>>>>>> +{
>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>> +   int result;
>>>>>>> +
>>>>>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>>>>>> +   if (result < 0)
>>>>>>> +       return result;
>>>>>>> +
>>>>>>> +   return sysfs_emit(buf, "%d\n", result);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>>>>>> +                   struct device_attribute *attr,
>>>>>>> +                   const char *buf, size_t count)
>>>>>>> +{
>>>>>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>>>>>> +   int result, err;
>>>>>>> +   u32 optimus;
>>>>>>> +
>>>>>>> +   err = kstrtou32(buf, 10, &optimus);
>>>>>>> +   if (err)
>>>>>>> +       return err;
>>>>>>> +
>>>>>>> +   if (optimus > 1)
>>>>>>> +       return -EINVAL;
>>>>>>> +
>>>>>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
>>>>>>> +   if (err) {
>>>>>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>>>>>> +       return err;
>>>>>>> +   }
>>>>>>> +    /* !1 is considered a fail by ASUS */
>>>>>>> +    if (result != 1) {
>>>>>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
>>>>>>> +       return -EIO;
>>>>>>> +   }
>>>>>>> +
>>>>>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
>>>>>>> +
>>>>>>> +   return count;
>>>>>>> +}
>>>>>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>>>>>> +
>>>>>>>     /* Battery ********************************************************************/
>>>>>>>       /* The battery maximum charging percentage */
>>>>>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>>>>>         &dev_attr_touchpad.attr,
>>>>>>>         &dev_attr_egpu_enable.attr,
>>>>>>>         &dev_attr_dgpu_disable.attr,
>>>>>>> +    &dev_attr_gpu_mux_mode.attr,
>>>>>>>         &dev_attr_lid_resume.attr,
>>>>>>>         &dev_attr_als_enable.attr,
>>>>>>>         &dev_attr_fan_boost_mode.attr,
>>>>>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>>>>>             ok = asus->egpu_enable_available;
>>>>>>>         else if (attr == &dev_attr_dgpu_disable.attr)
>>>>>>>             ok = asus->dgpu_disable_available;
>>>>>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>>>>>> +        ok = asus->gpu_mux_mode_available;
>>>>>>>         else if (attr == &dev_attr_fan_boost_mode.attr)
>>>>>>>             ok = asus->fan_boost_mode_available;
>>>>>>>         else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>>>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>>         if (err)
>>>>>>>             goto fail_dgpu_disable;
>>>>>>>     +    err = gpu_mux_mode_check_present(asus);
>>>>>>> +   if (err)
>>>>>>> +       goto fail_gpu_mux_mode;
>>>>>>> +
>>>>>>>         err = fan_boost_mode_check_present(asus);
>>>>>>>         if (err)
>>>>>>>             goto fail_fan_boost_mode;
>>>>>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>>>>>     fail_fan_boost_mode:
>>>>>>>     fail_egpu_enable:
>>>>>>>     fail_dgpu_disable:
>>>>>>> +fail_gpu_mux_mode:
>>>>>>>     fail_platform:
>>>>>>>     fail_panel_od:
>>>>>>>         kfree(asus);
>>>>>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>> index a571b47ff362..c023332842a2 100644
>>>>>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>>>>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>>>>> @@ -98,6 +98,9 @@
>>>>>>>     /* dgpu on/off */
>>>>>>>     #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>>>>>     +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>>>>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>>>>>> +
>>>>>>>     /* DSTS masks */
>>>>>>>     #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>>>>>     #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>>>>
>>>>>
>>>>> You can see previous discussion here https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Ceebec0ca0ab74f8babf908da85d10582%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969430056811815%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kFb75Jhr77XZScoegTh5FyJAnnEXm6cInIoxKdu7rhM%3D&amp;reserved=0
>>>>>
>>>>> Below is Hans response verbatim:
>>>>>
>>>>>    > Yes it sounds like a BIOS setting is being toggled from within
>>>>>    > Linux, which would normally be done through the
>>>>>    > "firmware-attributes" class, but all existing "firmware-attributes"
>>>>>    > class drivers allow changing all BIOS setting not just a single
>>>>>    > setting, so using the  "firmware-attributes" class here is not really
>>>>>    > appropriate.
>>>>>
>>>>
>>>> Although the two consumers thus far (Lenovo and Dell) use WMI interfaces to build and discover varieties of settings there is no requirement for how the backend for firwmare-attributes works.  You can just as well poulate a single attribute statically from your driver.
>>>>
>>>> So I guess Hans and I disagree here.  I have a feeling that we shouldn't be introducing custom ABI to userspace just because only "one" setting is offered.  I anticipate that some day the DE's will offer a GUI setting built on top of fwupd which is built on top of firmware-attributes.
>>>>
>>>> If you *don't* populate a setting with firmware-attributes the only way that users will discover such a setting is by installing other custom userspace software that has the knowledge of it.
>>>>
>>>> At the end of the day it's up to Hans and Mark though, this is just my 2c.
>>>
>>> Mario, thank you for your input here, it is much appreciated.
>>>
>>> As Luke mentioned in my quote using the firmware-attributes class for this really seems like overkill. As for discoverability, the firmware-attributes class only standardizes how to enum / change BIOS settings. The consumer of the API still must now the name of the setting which can/will be different per vendor.
>>>
>>> AFAIK fwupd only uses the firmware-attributes class to check for / disable some BIOS flashing protection. So having the GPU mux setting in the firmware-attributes class is not really relevant for fwupd.
>>>
>>> If in the future some generic tool which uses the firmware-attributes class to toggle GPU muxes is created (presumably with a lookup table for the exact setting's name under the firmare-attributes API) then we can always add firmware-attributes support for the GPU mux to asus-wmi at that point in time.
>>>
>>> I just don't think it is likely such a generic tool will happen (any time soon), so for now I still believe that using the firmware-attributes class for this is not necessary.
>>>
>>
>> Actually I've been actively working on that.  Take a look at fwupd main (what will go into the next tagged 1.8.4 release).
>>
>> It's got support for "fwupdmgr get-bios-settings" and "fwupdmgr set-bios-settings" which will follow the rules the kernel API uses.
>>
>> So I expect that if this attribute was implemented as I suggested you could do:
>>
>> # fwupdmgr get-bios-settings
>>
>> and find the mux (including the possible values if it's declared a kernel enumeration attribute and possible_values is populated).  If you populate the optional description attribute in the kernel fwupd will show you what your enumerated settings mean.
>>
>> followed by:
>>
>> # fwupdmgr set-bios-setting dGPUMux iGPU
>> or
>> # fwupdmgr set-bios-setting dGPUMux dGPU
>>
>> To set it.
>>
>> fwupd will prompt you to reboot the system after it's done changing it as well.
>>
>> It's implemented such that GUI clients can use libfwupd just the same, and I really think this increases discoverability of such a setting.
> 
> Interesting, I must admit that that makes your argument for using the firmware-attributes class stronger.
> 
> But in the end it IMHO still feels wrong to add firmware-attribute support for just a single setting, rather then for something which actually exports all or most BIOS settings.

OK thanks for your thoughts.

> 
> So for now I'm going to with this patch as is. If eventually it turns out that having this inside the firmware-attributes class would be really useful we can add it later, while keeping the sysfs attr for backward compat. My thinking being here that the code for the single sysfs attr is quite small, where as adding firmware-attributes class support will be more involved
At least looking at the context of that diff I see a whole bunch of 
settings listed and this is "just one more". I noticed:  "eGPU", "lid 
resume", "ALS enable", "fan boost mode".

Maybe a later follow up should implement ALL of these as 
firmware-attributes but keep compatibility for sysfs.

> 
> Regards,
> 
> Hans
> 

