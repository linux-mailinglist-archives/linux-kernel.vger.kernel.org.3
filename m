Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE785953EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiHPHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiHPHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:34:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEBB4DB37;
        Mon, 15 Aug 2022 21:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThYdgyXgtQGFyy1NZmbNbmTv0Uo413VvNLxAdxQLvHSr6qs5Y8laMPN0VIKcnhKwN6IR0Nuv9GjDC1GVap5vM7/MFzHHfehlvTVHO2Ybym7vcGNHqAsFX0sXo8glx8FkmMr6UilukVzdLg7qy6c2ZHifNazR7vE+2Jw/uV46c0W667fDHQ05+5OuvuVO0oFeXjCXbJaxM7KZTHeVOc5SfhNtLR9LFZi/KEbx5/X/h8oe6IFr9S/KlJDRDth44UIk0J4hf7m4UNw1F8N4y3GJOnuKlBM36xs4RPq1qWDP5QEgnLRzXWIb5UHbmfRFXj4pZI5o5e4hLhzi94FLBWQRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iqjQ7zTt6EBB3XC3XjI2B84c+QnIJrzzS3EAIvuPm8=;
 b=Q91VYbdvT2QjGIu6QXDOji3k5PjZ4EU8uHZyCCDthyEI6yQk0DPniurYe4R8fBZfZt+Vo/OpKoMXEiUSzo1dLlxuqjKGNIw5tRVQ31Ujbya3Z4pPkTjADqVgsn6x3hLxkYBN/fJZcx0pUsmRUjzgpSW2NmZ0k4DGfEABnH1lJG5y8QTmSqOXnZ7YiqqBtZuOZPbDpdvLqx3e5Wdv4H+JpCCTjW9O2fbJw8txUPYVfK0KCaQQcVtFBIU4k4nr+laD1uPzbA7Q7C9LBS6b8WG+RB8wC4xNDTrPXDsDyFc76Bz3xmVetgaTbsV850HlW0xwxkmEPbNXIESElFxOQJ4nsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iqjQ7zTt6EBB3XC3XjI2B84c+QnIJrzzS3EAIvuPm8=;
 b=K82x6PmrOQV6jdWWxJiwTcijm2hyTBA0EV3fyyA1pqpM6iYIOE8sQXq0mq4esJ5rKyR1rfCPX4CHJFhUyxJgndJvzMRnpDS2YX34eVjtaiaI/SroNsciBQFFd1dHE+8loh45FGhM/q79ATqBzAE+lG33LxJGv/TkrkLu2ivTLoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR12MB1553.namprd12.prod.outlook.com (2603:10b6:405:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 04:16:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 04:16:15 +0000
Message-ID: <e186622e-f3e6-5715-9f6d-bc41fb41560d@amd.com>
Date:   Mon, 15 Aug 2022 23:16:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220813092624.6228-1-luke@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220813092624.6228-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0045.namprd12.prod.outlook.com
 (2603:10b6:802:20::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62b2c6b-2a52-4012-e3a1-08da7f3e0faa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1553:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuFpKR9rWPw6ZyvQH4te+Jgl34Oij59+pA8I4clgK/9Pr4+YTrDH0i7DQ/iyMykf4gP5B1IOoAxxpPGy8RXtjq4H2MbJT/9Uk1XTrkfEHW7auyn3ENKlFFaZrr8a5L6X/FT77uiFPLkgi/cJRIeearHWnhrhXA0rW/RV12N+9AJBwSsHzA930ookvijC3gpqLut1Tr/3p7hWZf1YwY7XUiP7sgynaTA8AE7KRvlgmId1CR6fDXqfYing7elSTU0tjK3FNnKXZmT649OSUpuzJkoBdmBFApMRhqFslRxa9K5Yiuo1lyi8nj+4DM2hCsnU3b8Ii4kGaYR2/ymbLX9lxkzFtEkhR+wUjhjuIe/JLOadJ1IiN2ODG14o7HNKQk5Zc+rO6bi7wH7bx1HoHrNKQf1qG451D86sOvKRY/J4AZR9e4Pl/r1lJmUX2AbOJ6vOda0E5YPWndvSpGoX8RSSGjFDstAP/QXYtXdAFA2crOFObp/H1HpzOOLA8/Oe0TggMIHN1kTW3fOg0a1dXNbLmEoH7HnErZy0AGewFqngt1TNbz9KMOI/k8o5CGPG9lNxiVaubboabh58bhO1qp31f+innBNErO/yxl0s4t/I6C1Er++kpaPhtu+1+38qQlPs1mCX/xbbVJTaZdLJqgpqXb7BIlt+L0SKppuaIcXzkR0PRnWCU+ndRVP5hFjJaubD/0SYtfxMj9taS7XckXUEZB9qhY9fdi51DCYev1FrmPVSEnrVhKuM5+Dl3CoaqBE869bAHBQbORmOohZc0E1ulRZRVb/9ShizupSJDuH1mCcG0Ha6UzDp6e7WbS3bq2zMl71wctuwAusOjrCw77XY1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(38100700002)(44832011)(186003)(6512007)(6506007)(53546011)(31686004)(5660300002)(36756003)(2616005)(8936002)(2906002)(6666004)(316002)(31696002)(478600001)(8676002)(4326008)(66946007)(6486002)(66476007)(66556008)(86362001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3liTWd1NmNpakJOd09SbWdVR1BQZHNSYnd6VjdPMktKTnRPL2FkZEhXazhj?=
 =?utf-8?B?UHdFd0tLSDFweVQ3VFVsVVNaaEdyM21PSTdTYXg2elMrb2RoYmo4eEU5MTFs?=
 =?utf-8?B?cy84bEpGQUVXOS9wek9SSVZNZXNEeDNwV1YrQnVETHFiRlJXNXV2OVVuYTlT?=
 =?utf-8?B?cGF0NGhKbUg0cTRUL2lvQlFCMWJRNnc4ek1QSVYzM3BrMnZvbTVicWxzUzJZ?=
 =?utf-8?B?czE0QmlEK1Y5SEVVMDNhYkZIeWQ3bXZUNmVUbjY3NCs2b0F5ZUFNVlZXdlox?=
 =?utf-8?B?SUhaWUdLMjhneXBFLzdHc3BkVlhxZG80Sis5TlozbG12YzhkRXFWNWw2V3dZ?=
 =?utf-8?B?eHZhdksyK1F5TVdDek1lRlVXTHllVXpWZmtHd0taWGN3UTJIR21lTW5ZOWt3?=
 =?utf-8?B?emoxNlZuV3dNdU5RajZ5TmxXeGhuaXhQWWR3T01vTVBQc1A0b0VKcjY4Mzd3?=
 =?utf-8?B?bXVPVG1wbG5EaUxaMTBTeTcwUmY3S2FyY0g0VXdobFRKS1R6akFtYWVIcmJk?=
 =?utf-8?B?eWFZdU9DVmM3eGdzb0JpaUw3WUFncHFHYmZjdm9KK1lxcjBySkUycjNGZkhx?=
 =?utf-8?B?aTMrTmhKK2FkVWRuSzZxU1NHbStiOFpEZGhrQjJST0h3UllQWXZnQWp1V2Mx?=
 =?utf-8?B?OWk0ekRFYldISlM0dXl4VDgwQUJKTkN1b2ExNEhvRUFwY2JMRG9Lak5nVWpK?=
 =?utf-8?B?V0JnVUxvVjFSNjdtOWkyaDA4cDZpRjhreFptanpSSGxQNE9VYVl3Ullxcm5p?=
 =?utf-8?B?bE5KdUFhQUJ3ckM1UXZlVXNDSkNoUW9DSlJJUUZNZ0JGMk9BU09MamJzMTdY?=
 =?utf-8?B?SWl4Nk5nT2JYOXp2RnM0UURoZjYyOTAyMW9BdXdWUWI1d3I3ZS9yOE12MjAv?=
 =?utf-8?B?YkxEUkJqOGpSZi9BTnBQdUp3NnEzM0MyV0dQTjVDeWZrVTFQLzRXTVJKam1P?=
 =?utf-8?B?OUhnejdLdDc4S1NScGFVaCtJcDNpUUFScDhEWnB0RlBwNmVPci9hekdCY0pw?=
 =?utf-8?B?a1hPQTYvNUhGVDB6L2ZBSjhpSjVDTlNRaVg3WU9TN21idFVXU2JLVDFLbUZr?=
 =?utf-8?B?eER0bmRiSHRmZ0dCYWViZHk0RUdUTjc4UVFnZFZiNEN3UTg3ZE9LbHFKNFRr?=
 =?utf-8?B?UmpjcjdmbTJaZG5VY0wzdnZWckZraFZlR1NLN1BPd0MwWTdNVU1UZmZrcndP?=
 =?utf-8?B?MjFCWEJqWDI5eFZTRmZDd284dTgvS2F5UnlhVStva3FXTVdheTNBZ1M2MGJH?=
 =?utf-8?B?aW9uYm8rbTFZeEI0Ryt6QUN5LzNsVFNITjhKMGltWHpzc1ZML2ZQUGE3QTlM?=
 =?utf-8?B?b0xTRTNpbUpwUFZyb0FHSk5QYnNUSFVGOVJrc091TXdVZ0VmTVdFRnZhbXBu?=
 =?utf-8?B?YmhkWlE0Vll5Nm05NityMjZBWFNoU1ljZ3VNMm0vaVhINFVRelJrME5jSE9H?=
 =?utf-8?B?YUNKaDliZDF5SitsMjQ2WjNtSnY4NUh2Q0NISFkvZ2ZUaC9MNGphNHV0YzZi?=
 =?utf-8?B?MDdDNEs1eWIwMjE3MUVuUlREN290Q3VoekNUeWo5emhXOUV4QUxFTDhmMmJW?=
 =?utf-8?B?a3JJRlJkL2ZCNnA2VTZURmlaY242dWNYbzkrU3dwN2sxU0svZGRDRWFobWNx?=
 =?utf-8?B?SDBPbkloOGR0UnVuN3Z4UktaUWJ2M1hwVi9WUUp3RnpmUVN5TlQzTkl2b2pI?=
 =?utf-8?B?VGhUMXZ0NzBTQjM5Q3pLSWNvYXJ5aFgzYjNqUXFuQzB2c1NWQlJwT1FVWFNR?=
 =?utf-8?B?NkFONHN3SDZKZkhOcmQwcnE4RmFLeXJ4RUlDWm5rZkt5TFFIWiszMkh6TkVR?=
 =?utf-8?B?ZCtZcHBYakJXYjhYS2FodmJZcDZDQTBVYzVWVUJ1WGx1eGpXNHd4aXVhT2xN?=
 =?utf-8?B?OVJBNUw4ZnI0YVRFQzQ3U2RZdzBLYnhEUzRqTXZReGtxYXplcjQ1T0Fma1pP?=
 =?utf-8?B?V2xLSXVPRlpPd2FKSXgrTVRkREJKRWlJQ3NhbGplYksrNDl4WnhqbGpKMnNG?=
 =?utf-8?B?a0d2YWZjVkNycWVLemVyMzZuQlVUUVVFaVlYOGx3VnB3eWt2VjRjdk5WdGla?=
 =?utf-8?B?YlV5TWxjSVcra2UxcHNKT2FreHJpN01OcWNtZGV0ZVBLT2xSdHlJdVRNNWhp?=
 =?utf-8?B?a1VFWXFYQVR1aStGeDJxQ1Z2N3VsN0xlSXZDUmg1NzlVS1NCVVRUaEpVNFMx?=
 =?utf-8?Q?IGMpRbA6UNtDsnQPrfvK07uOzyp58HOvGeFXpCPc1t0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b2c6b-2a52-4012-e3a1-08da7f3e0faa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:16:15.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFcadM/0WpgW9I94bIqDEwRhc0mwj0VIWfgu910GjiCRM1fbTwiCK/6zYuVx35ro5fZk5MWf+oQZOm9yaCye8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/22 04:26, Luke D. Jones wrote:
> Support the hardware GPU MUX switch available on some models. This
> switch can toggle the MUX between:
> 
> - 0, Dedicated mode
> - 1, Optimus mode
> 
> Optimus mode is the regular iGPU + dGPU available, while dedicated
> mode switches the system to have only the dGPU available.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
>   drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h    |  3 +
>   3 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 574b5170a37d..03124eab7f01 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -58,6 +58,17 @@ Description:
>   			* 1 - overboost,
>   			* 2 - silent
>   
> +What:          /sys/devices/platform/<platform>/gpu_mux_mode
> +Date:          Aug 2022
> +KernelVersion: 6.1
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Switch the GPU hardware MUX mode. Laptops with this feature can
> +			   can be toggled to boot with only the dGPU (discrete mode) or in
> +			   standard Optimus/Hybrid mode. On switch a reboot is required:
> +                       * 0 - Discrete GPU,
> +                       * 1 - Optimus/Hybrid,

This feel like it should probably export using 
/sys/class/firmware-attributes.  That's exactly how those types of 
attributes work.

As a bonus, software like fwupd 1.8.4 knows how to manipulate it and you 
don't need special documentation.

> +
>   What:          /sys/devices/platform/<platform>/dgpu_disable
>   Date:          Aug 2022
>   KernelVersion: 5.17
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index e2b51b5550e8..0421ffb81927 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -230,6 +230,7 @@ struct asus_wmi {
>   
>   	bool egpu_enable_available;
>   	bool dgpu_disable_available;
> +	bool gpu_mux_mode_available;
>   
>   	bool throttle_thermal_policy_available;
>   	u8 throttle_thermal_policy_mode;
> @@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(egpu_enable);
>   
> +/* gpu mux switch *************************************************************/
> +static int gpu_mux_mode_check_present(struct asus_wmi *asus)
> +{
> +	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
> +
> +   return 0;
> +}
> +
> +static ssize_t gpu_mux_mode_show(struct device *dev,
> +                  struct device_attribute *attr, char *buf)
> +{
> +   struct asus_wmi *asus = dev_get_drvdata(dev);
> +   int result;
> +
> +   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> +   if (result < 0)
> +       return result;
> +
> +   return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t gpu_mux_mode_store(struct device *dev,
> +                   struct device_attribute *attr,
> +                   const char *buf, size_t count)
> +{
> +   struct asus_wmi *asus = dev_get_drvdata(dev);
> +   int result, err;
> +   u32 optimus;
> +
> +   err = kstrtou32(buf, 10, &optimus);
> +   if (err)
> +       return err;
> +
> +   if (optimus > 1)
> +       return -EINVAL;
> +
> +   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
> +   if (err) {
> +       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
> +       return err;
> +   }
> +	/* !1 is considered a fail by ASUS */
> +	if (result != 1) {
> +		dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
> +       return -EIO;
> +   }
> +
> +   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
> +
> +   return count;
> +}
> +static DEVICE_ATTR_RW(gpu_mux_mode);
> +
>   /* Battery ********************************************************************/
>   
>   /* The battery maximum charging percentage */
> @@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
>   	&dev_attr_touchpad.attr,
>   	&dev_attr_egpu_enable.attr,
>   	&dev_attr_dgpu_disable.attr,
> +	&dev_attr_gpu_mux_mode.attr,
>   	&dev_attr_lid_resume.attr,
>   	&dev_attr_als_enable.attr,
>   	&dev_attr_fan_boost_mode.attr,
> @@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>   		ok = asus->egpu_enable_available;
>   	else if (attr == &dev_attr_dgpu_disable.attr)
>   		ok = asus->dgpu_disable_available;
> +	else if (attr == &dev_attr_gpu_mux_mode.attr)
> +		ok = asus->gpu_mux_mode_available;
>   	else if (attr == &dev_attr_fan_boost_mode.attr)
>   		ok = asus->fan_boost_mode_available;
>   	else if (attr == &dev_attr_throttle_thermal_policy.attr)
> @@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>   	if (err)
>   		goto fail_dgpu_disable;
>   
> +	err = gpu_mux_mode_check_present(asus);
> +   if (err)
> +       goto fail_gpu_mux_mode;
> +
>   	err = fan_boost_mode_check_present(asus);
>   	if (err)
>   		goto fail_fan_boost_mode;
> @@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>   fail_fan_boost_mode:
>   fail_egpu_enable:
>   fail_dgpu_disable:
> +fail_gpu_mux_mode:
>   fail_platform:
>   fail_panel_od:
>   	kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index a571b47ff362..c023332842a2 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -98,6 +98,9 @@
>   /* dgpu on/off */
>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>   
> +/* gpu mux switch, 0 = dGPU, 1 = Optimus */
> +#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> +
>   /* DSTS masks */
>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002

