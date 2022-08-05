Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB70E58AE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiHEQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiHEQ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:59:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E64AD72;
        Fri,  5 Aug 2022 09:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5uCy7VLWwu25G2WnyP79MaIyaNsNTtkMaM+bg3aJAyOYuheVRWYjnEncQM1gMOYMQ4cElyu+2+b47NopYFtutXRvU22iGKLermtoVM54PXrpQ9t4CS2G/dn4h7fHxgq0kyLr9jgO/vd9+OkCOvHAkWH9/g5Skz3yas91gAY9HQdjN0dJ8wJxpCa7u4G+LXQYnqSABgWM54JFH3mm5pWSNYbT0cD5qWyAO986NJS/UpvNd6IDljS7hufY6CiWCyylwNUscxiNMtfer78DEJ0bg4ox0iDy/8WpsQ3D6lbA1FrlGo453Z7v3iEoKfyAqkSfqfkjlCTwrcWGawkJa3L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUvEyMn2GFauUMihSDYJ+S3ITDzJorZC1L4KnnKigNg=;
 b=fnm2JSvPkZhWoDDlplKzqG6Maer0iw8WFdIo18vlmuZpeXGFudYr9Mh4GvoevgKr4v+laxJLni2yngcTwXggLplhircIY3Ni3i6JUUWYydb1fQMxSyDpEr9C11r3uyDa7eRU6gkBaK9PNsWogShAYX/Ws2XbHMYrIXRIhPgXxjlc7ftOgA2sBBAjR9l5BBtbLZrn/p40fSkPMqFYnXuparAZO6JxwJZF7LZ5XfyeBFMOGmu11aPKbUOmPRjXILjd42lR+xsoPjULpqDyaBcNpzD9bdxwR/+lVdopWKo0KC3PcgRbi4mGa2Xq5sNFeuaameSPHpemnftMHqS+cW3/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUvEyMn2GFauUMihSDYJ+S3ITDzJorZC1L4KnnKigNg=;
 b=pn5A6hUU8yY8PDjt7Uj4/FKvb7M5jKDm5aH3DR07sHsAgX4HUTEQ2apJFeBzoDpQmGRH25hZfUxEF8Lhq8PBvqiDU9eNJA2UK+T7Iw5A/8Fz7HMYo3jedCKTXBiT+8VLUrpdVNjD+93jl9Tg3dse0LZKI+sngQ2nEgaI0zQOjhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 16:59:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 16:59:06 +0000
Message-ID: <1c7fa65d-47ab-b064-9087-648bcfbf4ab5@amd.com>
Date:   Fri, 5 Aug 2022 11:59:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] i2c: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <12042830.O9o76ZdvQC@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <12042830.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45b544d-a98c-47c3-d9c7-08da7703ce81
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYE01z+xyrmC9YvLhTbrGl+Vo6OBv8K8ala9yW8ruAlPVEIA7HOTh3kF/o3JTSfEYj+uwGYaiyF2ftd7WmuScFSRCjJakyVEpC5l1pWS4lepXFqNT2MNX3UdRAZu8+TBlWBndtOBc+EJI+BBAU9gPSj16ujsxo9//P6/eMteIGWlQ0mg6H05rz4fGdTEImVVOR/mxIzcwkUWe3vlzVWIAF+1bTWnoTtv799VX59fzUC9FmVJgtXMSwY6N8VcYCsOeMT/PZ5BKmS4FgbAFs9ImOwhV2HLKgPkky3QL2DEiFZHrnUTr+zAMYl3U8rF5f/ldCVPzO2Ur6pb5x0e5tMjipUJ5VQvnKIpOvgjZpFVf7p3TKI2HgtDCgCceKccTO9xASVEePj3dXsD4tS/AVNst2Sri0X2VSeUuj7Dep59lJAy1tyM6MVkFWpLfM7uqohvKHMTWVi/ee2M9QEvVc/0cnfPJcNBrtbygLxHI4SyTaQl8erLRgFUE21dDYCq2QeDUZlZ4vZwp8g+pMEzock36HGAa6vPLM7PPtBksqBCkh5tirsI5B6gDtoMlBQ20xTtT/MFob3kJmGRADxSVtRve/pz7ybJLbnhiZyjck8YJGwwecA02MV/opnyQVlhpFh4Vb5zPPJgj6RLv/A0GV502oyXq2HL/j12HXQjgOoVxGWIEkIu0jOigF/JoqfoPaFUqwS2TuRTIj0hdIZDa0nlqzWznVwJtPZAn+mp3uuyYRVYl7ShAcpyZvi4ivUbR8yGFQNKO/V/WRIsrhr1H3oOPMlGQpvSVR38ecfwuJaW9eiNp3napuMcnKLKCDUz9YluUFTD6I5lQxZgF+biSOHuo2oowjZ2x5Xh7XLwh4Ff4zgnxJ53gnq3jDUd+QWiEuPR8Dv8uawhoy8cPngLLMYX/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(6486002)(966005)(5660300002)(54906003)(110136005)(7416002)(478600001)(316002)(66556008)(8936002)(66476007)(31686004)(66946007)(8676002)(36756003)(4326008)(6666004)(2906002)(84970400001)(41300700001)(6512007)(2616005)(26005)(53546011)(6506007)(186003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjV1dGErTVVKbkdNL0wyUFptWWRzeURSc3RzL0t2RjJvUVo5RFJERGtQQ0Rk?=
 =?utf-8?B?REFSVkplbXVaWWEvNTZpY3hXaEJjM0FpT2Q1bUIzVUNiUldYdlN4cDBYcjlX?=
 =?utf-8?B?TjBOSE5XNFNFdGhxZU96MVc0ZUJhTTJwdGVFV2wwMWRIVThlY3pGbW5qVTdt?=
 =?utf-8?B?dkk4cndNV2w2MkZSQ0wwOUFrYnFrR0ZaRHZlTUNiSUorSTF3YUs4cURBRS9l?=
 =?utf-8?B?REloRGhSY1FIY3lLRnZGekZERFhHQzQ0b21EdmJIUEVxQ3p1bS9zTXBUb29P?=
 =?utf-8?B?SnZxTDQ0TStJNlJvdkpLcWJMSlpIa3pRbGdHdFN6YWszQUVmVUdqdFJlYkxU?=
 =?utf-8?B?eEFLMENjd2NOWXhsSWxrWEM5YXhBSmNUVzFvRzlkUHVueGpKODhGUk8zV0p6?=
 =?utf-8?B?ZEJxRFZ3M3AyRW1OUXdFWXRFRkI5S2U5MDlLU1VrZCtUdUtKSTNXcmRtSnNG?=
 =?utf-8?B?cjA3aU5HRS83WjF0ZUUxVTJ4Rng5OW0xYkFOWmxQMzAvbWNZdUh2TGtVdkxG?=
 =?utf-8?B?L2RITTRPWFZMRVpVSWd4L2xnaUtZNDFnaWFWbGdTaEM0SlNkcUlXc2JWa2Fu?=
 =?utf-8?B?V1g0NHRSczZ0cHBabkpLUTZtV0I3ZmVwWFZTRUtEakdtNXVUL2puTnNvWTdj?=
 =?utf-8?B?cmQwdXVER2MvUmxLL2NBbHQza2VVRklOTVZHNzk0NGhCSXRiQnJ3N3hheEZR?=
 =?utf-8?B?cVJjVFBIR2o3NHYzT0xLSU8xcXhybXFxVnRXN29wVk50TlA3c25PSjVWK080?=
 =?utf-8?B?WlBYdVBybWRYeGg5YlQ0SGZxZ0krU3lOSHczNjFSakVtZXdCZ1Y2NlFCdmxy?=
 =?utf-8?B?L3lEUUkxYUU3STZtVTFSWE0zMnhtREJ1OUEzajFjYiswRm5xRnB4RzVIL3hs?=
 =?utf-8?B?UTJHSjZtNERKT3EvTlBNSEJLcXM1TFUycXUxUUJ2NjREMm1IaVlRWmtxRi8v?=
 =?utf-8?B?RWo1TVJ1ZGplbml4UHJ2NzRyTW5tT3RBcitSL0ltaDNxYmlJZlJOOUJ2eHoz?=
 =?utf-8?B?WXQ1emJJU1FrMTYxSGc5UkhGcHZlaDVSV1ZyWnhTeUp4am53bU9BRmJyVTBm?=
 =?utf-8?B?QkNjQTVKMzNBNXdnUENVZDBMU2t4Q3g1R2NxNm5jUTluWDNoQnhTMWV4ck4y?=
 =?utf-8?B?TzlJcXhXTCt6d1VvVEhzRThVQ0JrVFgzenpxT0lKOUNmV3lScmlOb09YaThJ?=
 =?utf-8?B?Zkk4VE1MaFJJQU00WmhyS3ltZ1Jjd085UE9sTHllZE1tcXVqcUg2WjdIcmQ5?=
 =?utf-8?B?d0duZlZUZDYxeUhUK3FuZjI5eFRzeGF3MXZxU1kyaUJFRGp3Z3lrQlBRcHBn?=
 =?utf-8?B?c0tiYUxaM1Fwc0ozOTVNdi9QbnJpVWh6QllONlcrdHlFMEZFQUs5QzJBWHlz?=
 =?utf-8?B?aHRnVks1RXFFZUhJRDhaNnRidnZpVHJHRDNXT3dMMjlObDJIeXN1K0xQeldW?=
 =?utf-8?B?eFoyRmpzS1J5aEw2aVVHYnBpUDEybzIxWEpyeEFRTDdUWXBUSEZSOWpBeDlZ?=
 =?utf-8?B?bHJaNjVPRHpCeUlzdnFYL0JXSkFxMU1CV0QxU0cxV2ZLM3NaMFBVUUg0WE9Y?=
 =?utf-8?B?SjU4MXBPOHpNRStabHlNNXBEanh4RmRuQXk1aFVyWklCL3laNVE0ZFBXMyth?=
 =?utf-8?B?UGNabGQ0d0VzZ1pOSmx4M2hFdzlsZjNvdS9WNHA0VU5KZEg3eWdNZDljZkZO?=
 =?utf-8?B?VG1JSXYzVzZmbGJ6djQzMHYzektkY2NTcG82bXByb0hyeU5zaWdmRk11NDc5?=
 =?utf-8?B?UUR1Wko5V3BFaEtwalFIOHBuUGpDUVQxUnNiS1JuUkEvZ2xFQU4vMDNTd1o1?=
 =?utf-8?B?Si9zLzZmZDZvcWE1Tk5nVXdXT3V1R2dsTi9TT1J4SGcyZUxPbGxkOVJ3ODdQ?=
 =?utf-8?B?dEpSWHQxamt4ZG5MQzVsQWRjQmNMMHo1cjB0eFBPY0JiVDJGc1Z2NlFlak9s?=
 =?utf-8?B?N002S00relpKMlBOY2I4U01RMXo0SU9VZGljcnNEaktxdW5vK2w0NFdSamNv?=
 =?utf-8?B?bGhXUGQ2NDV0SHE2WmhGM1JGZjhlOXV1MWgyMHFCb2JpWktvazBsSlQrdTk0?=
 =?utf-8?B?OGh5WHE0SXZTTmFaelEzUUVBQ28zdHhpa0orVUlTV211d2dpWTBqMFVGb05T?=
 =?utf-8?Q?PbN3riktCQf4cmpWOy34aJ5IZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45b544d-a98c-47c3-d9c7-08da7703ce81
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 16:59:06.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EsUFBCMTDABkASuoqBdpaDHC1RNmeU5PtFWYfL7+KqGqWqwvn88Y0mqHng4ZxLK5EGRyTRw6G8nzSWnmBNi1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/2022 11:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> Because of that, ACPI_FADT_LOW_POWER_S0 is generally not sufficient
> for making decisions in device drivers and so i2c_hid_acpi_probe()
> should not use it.
> 
> Moreover, Linux always supports suspend-to-idle, so if a given
> device can wake up the system from suspend-to-idle, then it can be
> marked as wakeup capable unconditionally, so make that happen in
> i2c_hid_acpi_probe().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

+Raul
+Hans
+KH

Raul had a patch that was actually going to just tear out this code 
entirely:
https://lkml.kernel.org/lkml/20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid/

As part of that patch series discussion another suggestion had 
transpired 
(https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/#24681016):

```
if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
	    !adev->flags.power_manageable) {
                 device_set_wakeup_capable(dev, true);
                 device_set_wakeup_enable(dev, false);
         }
```

If this is being changed, maybe consider that suggestion to
check `adev->flags.power_manageable`.

> ---
>   drivers/hid/i2c-hid/i2c-hid-acpi.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/hid/i2c-hid/i2c-hid-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ linux-pm/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -105,10 +105,8 @@ static int i2c_hid_acpi_probe(struct i2c
>   
>   	acpi_device_fix_up_power(adev);
>   
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -		device_set_wakeup_capable(dev, true);
> -		device_set_wakeup_enable(dev, false);
> -	}
> +	device_set_wakeup_capable(dev, true);
> +	device_set_wakeup_enable(dev, false);
>   
>   	return i2c_hid_core_probe(client, &ihid_acpi->ops,
>   				  hid_descriptor_address, 0);
> 
> 
> 

