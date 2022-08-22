Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6983B59C353
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiHVPpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiHVPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:44:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987C2CDC3;
        Mon, 22 Aug 2022 08:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OustFFWkt5KHs5AlsQy1Yi9yzQbzDbAhZ7+acRvbZSJmWmODXqnP8p4o18BGwUtkVZwi77rkF5SDlTFVu+9vkhpT79CAgqzTvP0y36ph652jGc+cvVhpzGI3az3+74az2g5VayTbIcGHoTGy5tYACz+xhJRzXp663Y31VksrJZ5T37YN9i1rvZm8EQFxYFZxuH/+pg00m/d8RtxLJnlaA3t6M03JNPeH1a2hrT5QIUDhvdrGmYNRTXnk/p/JQZ2UYXx+KpOE22fIicg2f1dlLt8IV8+MU+IFWkf4AtBJN81J/meGX0QxvlnCcLj9OsIdk7UxoLjJyC+cFPW+PO1NfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/OpbNFkSWYpdU/D79n3x3BNVi6hpYbJqxVo4K3Aj1Q=;
 b=Lo5Ed1eVDZiN/w/LuytvpqmG5IrIZ1Hbs9wOTeKITRX4NWlAzFhgzV1QnyTivPJnVCpzrUSQBjRqn88B5L+nlFgC6KIu1RxXfG8rujDkY0r6JJ7neNIn1C6vThY9KZFl4i5ky0gLiSQcG7nuufRsfzOqEZNaOHKkyELSq4fJ3zNM/9SP6KfnuJfp0wxgG+z9YzVJgxLxCpLl2bfvP42D+Q0eIldbBEsNuxKPNHznOTS4nixpnCRpE2L6CfFzQI3i81CkhIrXneKQbrHEse3SVQNloIWPTbLC7t8qgh5i1RXSsYbCtHDh3tFh22klboe+sJ71+LGEtrePPeW8rIDyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/OpbNFkSWYpdU/D79n3x3BNVi6hpYbJqxVo4K3Aj1Q=;
 b=OgyvUwe47uB/eJgdjFDX1cYHTMy5Jb/o/gFYfdZBY23BrNyevKg9X3ne5TR1qJI/uEmT0QhA7MQ5Vy6viBCgrkJW7BhcMCbSJ/MiO1oQ4h5F/c51z2RUWQ8PRuu37Ii2zanCnlTsgA3a8L8QzTbEMcy/uw/zpEDUqY5Sgy2hnl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:43:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:43:56 +0000
Message-ID: <6f7df43d-292d-3a6b-76bc-09d669733939@amd.com>
Date:   Mon, 22 Aug 2022 10:43:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
 <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
 <UVMZGR.6LXKPONA9OS33@ljones.dev>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <UVMZGR.6LXKPONA9OS33@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337b76e1-edd5-430c-3726-08da84551f93
X-MS-TrafficTypeDiagnostic: MW4PR12MB5668:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjC1Rdx0bzqGK2zIc+If/bFTjUtTQAwBq2RBIihtrPGRyy7kANoMyWxVJKya8HnHsPdP9yBXsI7S7hb2tjBlycuIcf1p7GktQdWsK+lqADW++AOxQZF+HzcAedwXSxUQnEPSFs3gr3WS9vX9nelWTawPK0esr6CrrTpvkyBkOETNg9Up5sX1IxrpGQzSiC0F18t7cvSvNNtCJAgjyuP0N7YDuCM/c2Ykoo2DiRKMt1eot5ixSioVy4/+IdGUy0we4vtd71zRkV0rR6IOFMQEN4RVs5tCu3In2rOqBXywecUX3GJ/86c5bumoR99Q1kvvB5dnG8zgLL6oAyH3/mm3z8eTlPyUn1IpzU4z9FxeEgy8Ig0gf692B3YdNqppIkYbeM8s9uWsOSEH8NXTaV43v3LoyKjibbTwdf3kWHkBboiP3+BAtRWrRavzCdpWiKe6ImV6MdrgXhCvOj4S1/QMzmlS7Ry1/qpUkXsREbCgecs44ksd4OTATT5D5xTegJ4srCRI/XrVe6e6V62YgLj2qp4+vyFr7/LOtZ7V/ADx8stw5Bv1HTaFqUzSJYU2bKNY8xkFI8gJVH2Q+9MEtGOmf8Mx3CQYoS7kv1+X1caeW0iWT5Tg1Op8524cMqYkaI/5Faedh+lLTfoyH5Di3HPT9aY1pejDRZ3ZewMXjmsKmW7e/EJ4Qg0XcSHm5YXJ2/FGR2mn3narqSKZZgYOYdyIQKu9QGunv0CO/wPNBaMQTWaluxLlFpIbU6B1AU9r9pJhb5qdhKyu4Idus2O++8I7HcgxmT1fLn7YEOgzynRqs27lCmYUtyZW2bMB2WQdQc4ef/fgc2/uSxSqaV1J8bW80w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(6486002)(66556008)(66946007)(316002)(8676002)(66476007)(8936002)(31686004)(5660300002)(6916009)(6506007)(2906002)(53546011)(6512007)(4326008)(41300700001)(478600001)(966005)(36756003)(186003)(45080400002)(2616005)(31696002)(86362001)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpGZExKcGtTbFlsdENKN2wxaVgvN25RMWpxRW1RME1yUllhaWM2dUgraHZH?=
 =?utf-8?B?KzQ5UzNHQUJ0M1lQS2xZM2NXdWhBbzVtSzRYbnhsNjdIN0hTU2tFK2F4SzFz?=
 =?utf-8?B?bWdQam9nUHRXNWxKdUROcHlkMFdqeGlaNVdGWGVvbGVxRDRQRzNUNEFKOS9X?=
 =?utf-8?B?cE5XN3B0eWlYME15OTJWTzZrMjFqQi8yRzFwajFjTHJJMlZIVTlEUHRjQ1cr?=
 =?utf-8?B?NnlzamZmYndHTVpUWkpLdVVSR1RrQjNkRzdXa0lWbVZVcUEvdEdEaEhORjBv?=
 =?utf-8?B?MEpCZ1M1aE52NGs0ZWJ1dDRjaFViTEpneExhNldxcWF1K21HWnJkR25Hc3Q2?=
 =?utf-8?B?OUN0S0QvTGlKZytUT1kyK3d5RHNudUhYQm5xbUtLZGlBMzg1RGphZFoyOXlT?=
 =?utf-8?B?dzZQMVdldzFDaTB3VHRVSG42dU5kS1JLU29hUWRkMnMyS1FRMUJZbUtXMmw4?=
 =?utf-8?B?K1hWSFJ5VG9rYXFSbG1LOEtzNW9LaWI3ZXpBRHZRcUtWMnRnTnAvdmlWOUs3?=
 =?utf-8?B?a0ZGMWFXWHppV0JoYjl5eWRLTjlEbDhQWkh0cTcvTzRQL2RPbFdKS2cvbWtB?=
 =?utf-8?B?WW5HZGtTaFc1dC9FdGQyYlZYd3dQVEg5bjdHNHM4bHBnM1RWT2k1Nmt3RjNt?=
 =?utf-8?B?Z1EzRHBLMXNkbnpxMXdpZVN4MmZsdi9MY3NiK2JWc0dwOVdCcm5tNTUrOWNi?=
 =?utf-8?B?VERjQ2tSbmV2TU00dXBNVVZMbzNlNUE0SFg2L1hGbWNCSXd3ODUvS2RIRVV0?=
 =?utf-8?B?d0hVL3pVc2Z4VlBCd1FHdE1xclVpek5uekFuLzdSMVFsTHJqVUQyTkY1SGJU?=
 =?utf-8?B?ajRMSVAvOXArS0hUNTRzMHRrUFpVN1pxQkhEb1NnM3ZFcjVJZ1BObG1LTkE0?=
 =?utf-8?B?Y0l6YzFlNS84ZkF6a3RTWFNCY2JhT3o1SERpNkE5NWVwdzJ1bGtwdHQvWlhJ?=
 =?utf-8?B?WDNTTmdWbTYzdHRyWUxZSnJnZjZyQnZVSmRRR2J5ak1BckpMK3NnbHdReUsx?=
 =?utf-8?B?eWtYRFhoZ255Yk9qM1F5M3FNM3IwMW9HMExUcXJBaHcrbm1Pck1CWWhNeHR3?=
 =?utf-8?B?VTFjblhZaXVTZ29JWU1PcTNzbXFaMzR3N05JTzU3QXg1N1YwSVlDandrV01C?=
 =?utf-8?B?YWp3eWRaYSt6N1lBUGJxMVROanVVVmNjYzFvK2RaTE5WelhRN1o5TUNlcWlD?=
 =?utf-8?B?Tk8vdERERklKdkFQRnZjRHRnZkVFQ0MwN1lobzFWeFFLQjg4QjNmNDJiRnFa?=
 =?utf-8?B?YmY5d2U0dXdtbVl4QUlTUXovTnhZRDk5NGdLM3JtSEFRM1I5S3hKRnk2bjFJ?=
 =?utf-8?B?SDJDbDg2RHk1VmQ5SWVKNlJDTHNLNlJzUGFWelg5R05iSWM2aWtiRk55RGFj?=
 =?utf-8?B?dXYrZXhxcnoraWdMU2oxcENhSmhyQVRBdUk0N3JhSENSVUxvRXpROVhEd1Z5?=
 =?utf-8?B?UEhkVVBnMnFXTGhuZ3VtdmkyL083WGxsbmxYbXl0SEo4dVUrMENPODZUWDRh?=
 =?utf-8?B?Yit2ZzFqbk1QV3BMNWs0SVd2RDlCWGR6eVo4TWJib0lkNE1oSW53Nnk0KzZF?=
 =?utf-8?B?R3NsdndPQUl4dkg3b3Z2S3RYTXNTa1JzeXRxTFZybm8xbDJNaXl2bnpJbG9H?=
 =?utf-8?B?M1lqcEtZVFZQVFhlRGVuUjhNazFEeTkzRXRMdnFBUXFYTVRXZjAxUDd5b3Jw?=
 =?utf-8?B?MkZTYnRvWE9zY1dwcWRsd1BZK0RKbzd0elV5TTFYRFlwNE5ZdFNBZWxaL1Av?=
 =?utf-8?B?SnpIWHY4cHEzQ1lkaU9wS0NkQkxZbVVKN2Qvd0JyNE5hQVBPRFMvTjhPaEIx?=
 =?utf-8?B?TkQ3R3NLRWgrZVpKZ0xRU1VaNUJTUHl3RWdEVWRad21URmR4ZisrMU5xRmkx?=
 =?utf-8?B?N0ZiekRPU01ERERkU3Q1QmI5M1VkRndBdkM5OEdoR2lhRUlEdjNzNHVjc2Ur?=
 =?utf-8?B?WGVoWFloN2JieUxYOTlaN1hHUDNoQ1p3N1lKRUZBT1B1SC9jamViV0hWYjZP?=
 =?utf-8?B?MEp1WlF1OWM2R2VPdEYybVEzWW5XTzV2c2NYbVpvc3NCekloN3JTRmpmUmdy?=
 =?utf-8?B?VVF1RVZyOHdnYVVuRUlFZUdrZ1JRSW9DVlNXSWM3UFlnd0JnNzF6OTQ0VmhZ?=
 =?utf-8?Q?waP4lonphpyzCVlx11mMv1v1s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337b76e1-edd5-430c-3726-08da84551f93
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:43:56.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUPZah2Z5UP/gVjQOJZvatYbIr2aW2U+LRQwZnpp6qzgnQD0XlO6USuobh/aq9oDpmPUo4VVrX3bWzLZfNeTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/2022 18:07, Luke Jones wrote:
> Hi Mario,
> 
> On Mon, Aug 15 2022 at 23:16:12 -0500, Mario Limonciello 
> <mario.limonciello@amd.com> wrote:
>> On 8/13/22 04:26, Luke D. Jones wrote:
>>> Support the hardware GPU MUX switch available on some models. This
>>> switch can toggle the MUX between:
>>>
>>> - 0, Dedicated mode
>>> - 1, Optimus mode
>>>
>>> Optimus mode is the regular iGPU + dGPU available, while dedicated
>>> mode switches the system to have only the dGPU available.
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>> ---
>>>   .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>>>   drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h    |  3 +
>>>   3 files changed, 76 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi 
>>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>> index 574b5170a37d..03124eab7f01 100644
>>> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>> @@ -58,6 +58,17 @@ Description:
>>>               * 1 - overboost,
>>>               * 2 - silent
>>>   +What:          /sys/devices/platform/<platform>/gpu_mux_mode
>>> +Date:          Aug 2022
>>> +KernelVersion: 6.1
>>> +Contact:       "Luke Jones" <luke@ljones.dev>
>>> +Description:
>>> +               Switch the GPU hardware MUX mode. Laptops with this 
>>> feature can
>>> +               can be toggled to boot with only the dGPU (discrete 
>>> mode) or in
>>> +               standard Optimus/Hybrid mode. On switch a reboot is 
>>> required:
>>> +                       * 0 - Discrete GPU,
>>> +                       * 1 - Optimus/Hybrid,
>>
>> This feel like it should probably export using 
>> /sys/class/firmware-attributes.  That's exactly how those types of 
>> attributes work.
>>
>> As a bonus, software like fwupd 1.8.4 knows how to manipulate it and 
>> you don't need special documentation.
>>
>>> +
>>>   What:          /sys/devices/platform/<platform>/dgpu_disable
>>>   Date:          Aug 2022
>>>   KernelVersion: 5.17
>>> diff --git a/drivers/platform/x86/asus-wmi.c 
>>> b/drivers/platform/x86/asus-wmi.c
>>> index e2b51b5550e8..0421ffb81927 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -230,6 +230,7 @@ struct asus_wmi {
>>>         bool egpu_enable_available;
>>>       bool dgpu_disable_available;
>>> +    bool gpu_mux_mode_available;
>>>         bool throttle_thermal_policy_available;
>>>       u8 throttle_thermal_policy_mode;
>>> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device 
>>> *dev,
>>>   }
>>>   static DEVICE_ATTR_RW(egpu_enable);
>>>   +/* gpu mux switch 
>>> *************************************************************/
>>> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
>>> +{
>>> +    asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, 
>>> ASUS_WMI_DEVID_GPU_MUX);
>>> +
>>> +   return 0;
>>> +}
>>> +
>>> +static ssize_t gpu_mux_mode_show(struct device *dev,
>>> +                  struct device_attribute *attr, char *buf)
>>> +{
>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>> +   int result;
>>> +
>>> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>>> +   if (result < 0)
>>> +       return result;
>>> +
>>> +   return sysfs_emit(buf, "%d\n", result);
>>> +}
>>> +
>>> +static ssize_t gpu_mux_mode_store(struct device *dev,
>>> +                   struct device_attribute *attr,
>>> +                   const char *buf, size_t count)
>>> +{
>>> +   struct asus_wmi *asus = dev_get_drvdata(dev);
>>> +   int result, err;
>>> +   u32 optimus;
>>> +
>>> +   err = kstrtou32(buf, 10, &optimus);
>>> +   if (err)
>>> +       return err;
>>> +
>>> +   if (optimus > 1)
>>> +       return -EINVAL;
>>> +
>>> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, 
>>> &result);
>>> +   if (err) {
>>> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>>> +       return err;
>>> +   }
>>> +    /* !1 is considered a fail by ASUS */
>>> +    if (result != 1) {
>>> +        dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", 
>>> result);
>>> +       return -EIO;
>>> +   }
>>> +
>>> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>>> "gpu_mux_mode");
>>> +
>>> +   return count;
>>> +}
>>> +static DEVICE_ATTR_RW(gpu_mux_mode);
>>> +
>>>   /* Battery 
>>> ********************************************************************/
>>>     /* The battery maximum charging percentage */
>>> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>>>       &dev_attr_touchpad.attr,
>>>       &dev_attr_egpu_enable.attr,
>>>       &dev_attr_dgpu_disable.attr,
>>> +    &dev_attr_gpu_mux_mode.attr,
>>>       &dev_attr_lid_resume.attr,
>>>       &dev_attr_als_enable.attr,
>>>       &dev_attr_fan_boost_mode.attr,
>>> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct 
>>> kobject *kobj,
>>>           ok = asus->egpu_enable_available;
>>>       else if (attr == &dev_attr_dgpu_disable.attr)
>>>           ok = asus->dgpu_disable_available;
>>> +    else if (attr == &dev_attr_gpu_mux_mode.attr)
>>> +        ok = asus->gpu_mux_mode_available;
>>>       else if (attr == &dev_attr_fan_boost_mode.attr)
>>>           ok = asus->fan_boost_mode_available;
>>>       else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device 
>>> *pdev)
>>>       if (err)
>>>           goto fail_dgpu_disable;
>>>   +    err = gpu_mux_mode_check_present(asus);
>>> +   if (err)
>>> +       goto fail_gpu_mux_mode;
>>> +
>>>       err = fan_boost_mode_check_present(asus);
>>>       if (err)
>>>           goto fail_fan_boost_mode;
>>> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device 
>>> *pdev)
>>>   fail_fan_boost_mode:
>>>   fail_egpu_enable:
>>>   fail_dgpu_disable:
>>> +fail_gpu_mux_mode:
>>>   fail_platform:
>>>   fail_panel_od:
>>>       kfree(asus);
>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>>> b/include/linux/platform_data/x86/asus-wmi.h
>>> index a571b47ff362..c023332842a2 100644
>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>> @@ -98,6 +98,9 @@
>>>   /* dgpu on/off */
>>>   #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>   +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
>>> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
>>> +
>>>   /* DSTS masks */
>>>   #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>
> 
> You can see previous discussion here 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fplatform-driver-x86%2Fc3bb0989-78d9-c513-1669-75407b2acbac%40redhat.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C3df656b0acd34b793bb908da83c9e8f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637967200474348826%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=MsHEOH2aUUYGBhOBhVukN6DxWeBE16qz0nw%2BJryfM7M%3D&amp;reserved=0 
> 
> 
> Below is Hans response verbatim:
> 
>  > Yes it sounds like a BIOS setting is being toggled from within
>  > Linux, which would normally be done through the
>  > "firmware-attributes" class, but all existing "firmware-attributes"
>  > class drivers allow changing all BIOS setting not just a single
>  > setting, so using the  "firmware-attributes" class here is not really
>  > appropriate.
> 

Although the two consumers thus far (Lenovo and Dell) use WMI interfaces 
to build and discover varieties of settings there is no requirement for 
how the backend for firwmare-attributes works.  You can just as well 
poulate a single attribute statically from your driver.

So I guess Hans and I disagree here.  I have a feeling that we shouldn't 
be introducing custom ABI to userspace just because only "one" setting 
is offered.  I anticipate that some day the DE's will offer a GUI 
setting built on top of fwupd which is built on top of firmware-attributes.

If you *don't* populate a setting with firmware-attributes the only way 
that users will discover such a setting is by installing other custom 
userspace software that has the knowledge of it.

At the end of the day it's up to Hans and Mark though, this is just my 2c.
