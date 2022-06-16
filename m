Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB754ECD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378546AbiFPVrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFPVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:47:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586660DA5;
        Thu, 16 Jun 2022 14:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvA+/aLLf8aKoHeooyd0/mfx+PImsQjWPlz+O1upsH1DlR9rekHYh6g3qHsMD2Sh2XkZ+QMkISH7Y3mMYj4qfPYCS7JuXZk4ErtAGtyT5Yi/wJ8wo8dePN/OwAoONGhIyDu7s9AuWg8+YUUBgEbMOvsaGx4WZvL8UVkYNu9EbYH6KmJA62rwbsVOieiZy/DN2qyi7mvNq/G7AmmEkRisC0qLYoSfo39XAsKmnhW4duqZSxZUiMxHsyc5RvrdjiVfAgJruU17mmXaGPvrirkpXUNEQI5EpEwn5hVSpcC9rYZuKillZVbsRXjKddgCcSzOHW8YI+L5QkGs4uSyaFHCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpZLp2E3nfEzLuT9kshTotOAZVQlsgG9AEi0i9gbGC0=;
 b=eCsKx7j4glCli2qaM/XDo1iRoivo1PFMlV+AdZR0VkpmdKXmxUUhFqW47gZTudfKzKPx3Mpa2qGBRLFcAAn4C1rgGloa2HyFUJtTAwfyQtR+jGKOUofcKRCVcDr13q+KJJA5Ag6zlBqFjACcfkTlnrN6XvqyKJhEQhsPFv6idtJW5m4z56FEWwFXPTD4EOe0vEuLAloojMl6mAXK1VdknGq1sewDhmfBTvsWMrqOQG/6pisrbb8rA5M85ZImMp4+5sGTlqbIJoND43Ch2F7wWrkkrL1cOaB2Ib9t0ti2V/SQsoKfPumvHb3fRFa3IsuHAeMHz56SKkSn9RzBGIXwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpZLp2E3nfEzLuT9kshTotOAZVQlsgG9AEi0i9gbGC0=;
 b=V5BgjFcFj75xRO/Pp4kUgCPb7b6YtEZJFrG7EVuEqIcRuCxGnQF5hFdtMFQUkq0zcQlckRoLgr8H3x2xHvN2onad9gKtXtMozGZeIZFb95T3iX3fgo59nxguuf67zdt4SNYowGzlWRRU46jpUMi433Hfk716W//47NBNHXmyad0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 21:47:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 21:47:12 +0000
Message-ID: <0e700e9b-35db-f419-813a-1277e0b7476a@amd.com>
Date:   Thu, 16 Jun 2022 16:47:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <YqugZQiDu35Y8lTu@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c692609-b9d4-43f9-c4d6-08da4fe1c502
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26325A3B469FB198918AB1C2E2AC9@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ee+f04h0ht5kwdGtj35anLZsPz0pzJ0WnnsDC9dMSXir94y/IPwWnQQUr9Qzl+JS2o82jRoMMbVAHkLs4Igv6IJZ5PVZ9QQN0iNzMxdqG7BVqrM/Hs1boo9C8bpHMCvFOlSH5tK/iT7+8MU3n3ukGN+RcahVbbA1O3GrxzypDBJraJ38xRjxJvdkm/qGm3qoOzNquIBtV14M6DArNF8oov4PbXHcSVJNGBnq/5MHQdvDo9Y1Ln7mg2Zu6Ud9XM3/V6Z8RSUM6fUOzXBBDpp7yaGcXplE1nvRt3AXzxvgU/t+Z7ixTmRQ2SpaB8c8ZGCWhIFI1MrQ0Po9Jc0/zTbw+Hh8fGVOT7mfS418IW69u3u3G5LJeT3n4oG8yk17X6/kGHfRq43cOJ+xsL21UG21QInFjvWbqyigy1zmae2VibZ740hOkKBswhuIzvvsrWkYyFEwCI9bATwcd5XOAwkVJY1DTe9ZC4jPsY2M7OwmV2Xe6qT/HfbEAP2w/rUVKSN9rrS7RcId7WAonR51qUEms5T4kbaMt/nWAe2vAV9fXm3Qk1WqHvqXVVdcbuCBk41qSzXdrFcVE/z+zYu5rGuNeWC3lt5THhH5fhBZK3+swUGuqyNM93Uu4O964DUs5inmwxBTw2S1JABM8Rz2xNd9oXscJuryYCJ8kl5Mendw2Gh+zPj4fynUOkmMP0LHvGk3zAM6xUG+MxVquRSdPXlQ9tpWEUGDhq/fKiMr5xNygxNoofepqNQExfzlOa5ukLvkyZIarX0FDoe5Ug/N/+ISu5gOPjnGd31mglLEnxrV4Gl+rjgmzjiAu5QmKwi8Saw4xnDZGbnArndWiidj/R/AAtOtuHrXmkh4tfXzVp6AJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6916009)(6486002)(2906002)(508600001)(83380400001)(966005)(186003)(54906003)(6666004)(45080400002)(8936002)(5660300002)(66946007)(4326008)(8676002)(66556008)(66476007)(86362001)(316002)(36756003)(6512007)(53546011)(31696002)(2616005)(6506007)(31686004)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FGY2RWTzB5d1dmWHF3NEtXTXpaTm9DaC9TWEV0Vm45UVE2Mk5xT1BYWVB4?=
 =?utf-8?B?Y25tbVQrUDlkWW16RG93TUdOZjZHcEZLang0YitaSlUxVXFSZDJvcVlIMzkw?=
 =?utf-8?B?VCs0T1RCUU5NOGsyZy9aNzdwalJkQVo2LzQ2eXg0ZE1QdUQ3MEpzVnRNRHlY?=
 =?utf-8?B?MTMzSld0ckZFcFhKSUtjd093MWFzdGI3VFBUbnFDMmkrYXpYaFhCR0NGUVhZ?=
 =?utf-8?B?ZjcrWGE3MjM2bzI5NmxVYktmVmtWUjB3SjkzYXhNR05RTUV0MUljNExNSlVo?=
 =?utf-8?B?VWRabU1kR093V2h0S0EwQ1ZGeGowUSsyT3FKVDBjV3dwakpOdFFsZmNhb2ZF?=
 =?utf-8?B?OTgvdHVnVk1JSEVMTGhnK25xeDlJUFhHRTk5emN1dGNNdWZ3WEJVVTdkNmpK?=
 =?utf-8?B?OUZrSkJtS0NUUU9rNnpnTHhPd3pKaFVyQ3pGdmFFVVdoV0RZVGJtWnJ1Z2Va?=
 =?utf-8?B?dnZrL3BKd1p1cXAxQ1NRSURoVmNRektoL1MwT2h1aDRFWjZQRFF3MHNOMTNO?=
 =?utf-8?B?UFVXYkprdzZ1azJsY3lSaEV6MnVlRUVkWGM0bVpHRVdXT0M0OFQrZDJDWnZ4?=
 =?utf-8?B?RjFkNlYvd2p1QVAvWEZJOS9JZ1BISnd0Y1hsRmpSSmt4NDE2TnJEMjFsb3U2?=
 =?utf-8?B?SjJCSjdKMlNWQ1lTVFBYZjVVSk1VM3RpWkRsd0RQUUtZaWRiYzFiejU2VWFK?=
 =?utf-8?B?bE5zdW5hYzYzSWdvWlEyNms5M2lQMHVDTzFUa1N4dEhReCswY2lLaTlGN08z?=
 =?utf-8?B?VG1ka25wTkRzbTd4Q2paR0lSYmk0bnVFVUZ6elJiUXozTkpLbHBXWC90K0hN?=
 =?utf-8?B?Q3Z0UFU1ZmdWVDJYR2VoTXlsalRJWFJ3ejljdHlOcGhHZ2xTTEZ5SDFMaTVw?=
 =?utf-8?B?YXdkNmlOOTNWL3AyQkxYU3Z4T0dFZ1VhbUxJckRKelJPSE5mRlQ4MFR3WFNp?=
 =?utf-8?B?YXMrejZqdmZ4bEhVaVJzM2ZDajk5bElSMDdOS3ZHenpEejJvOXQ3VFFrUXFz?=
 =?utf-8?B?aENlUmZYbUxHZmtNVmZOcUtVenVLWHBnZklqbFIyNk9Zb0ZiNHZISXN2USti?=
 =?utf-8?B?VVdXZDJ2Z0NVMXZycHYxeGp0bnRWd1RlSENKSFlETUJlYlRNakFQaUF0NTUx?=
 =?utf-8?B?U3pFWk1MbjBWcWJhamdhMUd2dnd6NXFZUTEwekxuK3JkWjVVTGpZcGxydXdY?=
 =?utf-8?B?K2VCRlFjdXl3Q1RIZ0wrUEd3a0U5a0hGUElvaGpNTU9QQTBGbVFoRGFCQ3By?=
 =?utf-8?B?Nm1TM1F5aXBHRytRWVZ0Z21GanBXUDJYS0RTMWtpVE42VWlidTI3bGpVYm16?=
 =?utf-8?B?V2xJSldFc2ZHZjRvNHhVd3B3aFVyWGJ6NEFkQnlkbEhreVJwYUs0K1MxcHZS?=
 =?utf-8?B?dGFHdW04WGxCYmh6Ukt0V0ZURkpXdmYxektPQ2VXZXdTdkQ0UTB5MkZNZjM4?=
 =?utf-8?B?N2Z3SGkwUEhjKyt4UmdiaXRxL0wvY3JpK2dsSGIvTmxnYXUwQ0tiSTROYmtT?=
 =?utf-8?B?NERQV0oyNWc2UUNGZTIrSUR2K3FoelBPRmlSOVJNb0dRMGQxMGFEcUdXRE0w?=
 =?utf-8?B?cTZBMnM1MVA4dTVreXhKWjBLZmswN1h1ZVBUdDg4ZThDOGE5Qm1KZVpnTkdH?=
 =?utf-8?B?dm9xNXIxUHg0K2RHOGJBU2Urc0I2d251N01oWUUxMklyR3AvdERrbXlyMWlG?=
 =?utf-8?B?Um5mUHZjZUsxWmpmUkZOWjBxTWRlUFZXRWZCYzgwN3dGRGNpaXdsMjVPaXpq?=
 =?utf-8?B?OVBWdjdUUFBRMTBaRE5wRGprUElFWjVuRDhld1M0YmNISXVKRE4zNnRwayt6?=
 =?utf-8?B?aWtiYktpR1BqcXBxVFE0anRoTzdqVWVRcmpXRjF5dVlTb1BBSEFxVHU4UnFs?=
 =?utf-8?B?VWg0M1dhV0ROUjZ6cnRsYXNTbStZbTQvT1M4RmxjRnJNVzZkTjNKSUJGR2ox?=
 =?utf-8?B?SEJCVC95djVyWmU1TG9FQ1YxNC9nZUlaVDk2SFh2QmRvdkZKakd6b2NpZjVu?=
 =?utf-8?B?bDhwcVBZWmJGaXZOQm5YLzhVTGpPaEZ4ZjYreHZDZTcwUFZNc2dlNWp0cXR4?=
 =?utf-8?B?SXRMaUdGb3JzTGVJN0NuUDh4TWxWa21JWHh3ZmFiWHZBSEpIYm9LRUZRMlhB?=
 =?utf-8?B?dU5uenRwY1Z6cVdXSFJJRVNLL0I1MzBTeUhZQUE2dzBVUFpLaWtIOGVqY0ZW?=
 =?utf-8?B?d21ZcHF2UmRZd0hlZTNicVFuNVdPbEliREtaR1ZjRkRhd3RCNDVXQmxnVEI4?=
 =?utf-8?B?aXVZbW85MjFkajVvdGcvMEhtY1FLUmhQbERNMWRsVzVvNjJGSDBqNGtkZHov?=
 =?utf-8?B?d2tML1N0R1B1aVI4NkxwdFVJVU9nMmtoTU4rVk9EeVpCNi9WcU96dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c692609-b9d4-43f9-c4d6-08da4fe1c502
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:47:11.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTURF56o3NZN9x+tFlyUClrlpD19NmCnMWCsrTwOQ2arbUf1md065gAx/gqvUBtz4Z4wBy9Scg2P8KG0LURzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/2022 16:28, Greg KH wrote:
> On Thu, Jun 16, 2022 at 01:31:42PM -0500, Mario Limonciello wrote:
>> The USB HID transport layer doesn't set mice for wakeup by default so users
>> can not wake system from s2idle using wired USB mouse. However, users can
>> wake the same system from Modern Standby on Windows with the same wired
>> USB mouse.
>>
>> Microsoft documentation indicates that all USB mice and touchpads should
>> be waking the system from Modern Standby. To align expectations from users
>> make this behavior the same when the system is configured by the OEM and
>> the user to use s2idle in Linux.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdesign%2Fdevice-experiences%2Fmodern-standby-wake-sources%23input-devices-1&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C98b9958eb5304304fcbf08da4fdf1cdf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910116925045711%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ZI7wX9jq38V0bNZFjca2qbVZrU4frillcrZ6WEGEn%2FQ%3D&amp;reserved=0
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20220404214557.3329796-1-richard.gong%40amd.com%2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C98b9958eb5304304fcbf08da4fdf1cdf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910116925045711%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tt1eHDJqtKybfNw8XDF9ZFCuAMJJEotOB2NnGuXItA8%3D&amp;reserved=0
>> Suggested-by: Richard Gong <richard.gong@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> More people keep coming to us confused that they couldn't wake a Linux system
>> up from sleep using a mouse, so this patch is being revived.
> 
> How many different devices did you test this on?

I tested it on all the mice I have at my disposal and the AMD systems I 
have that support s2idle on top of 5.19-rc2.  As the code path doesn't 
run without s2idle any more I didn't look at that.

Mostly Logitech, a few no-name brands.  Both wireless (via a proprietary 
dongle) and wired.
Richard tested (the earlier version of it) on what he had available to 
him.  A few other people in AMD tested a variant of it with the mice 
they had as well.

I know you have concerns from the previous version on test coverage and 
I feel that if this is accepted it will get a lot more testing in the 
various labs from other companies as well.  We can put some explicit 
calls to testing on this early on in in the RC cycle to try to encourage 
more testing.

> 
>>
>> Microsoft documentation doesn't indicate any allowlist for this behavior, and
>> they actually prescribe it for all USB mice and touchpads.
>> v1->v2:
>>   * Resubmit by Mario
>>   * Update commit message
>>   * Only activate on systems configured by user and OEM for using s2idle
>>
>>   drivers/hid/usbhid/hid-core.c | 36 ++++++++++++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index 4490e2f7252a..3a1214ecec49 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -12,6 +12,7 @@
>>   /*
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>>   #include <linux/init.h>
>> @@ -26,6 +27,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/string.h>
>> +#include <linux/suspend.h>
>>   
>>   #include <linux/usb.h>
>>   
>> @@ -1176,17 +1178,29 @@ static int usbhid_start(struct hid_device *hid)
>>   		usb_autopm_put_interface(usbhid->intf);
>>   	}
>>   
>> -	/* Some keyboards don't work until their LEDs have been set.
>> -	 * Since BIOSes do set the LEDs, it must be safe for any device
>> -	 * that supports the keyboard boot protocol.
>> -	 * In addition, enable remote wakeup by default for all keyboard
>> -	 * devices supporting the boot protocol.
>> -	 */
>> -	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>> -			interface->desc.bInterfaceProtocol ==
>> -				USB_INTERFACE_PROTOCOL_KEYBOARD) {
>> -		usbhid_set_leds(hid);
>> -		device_set_wakeup_enable(&dev->dev, 1);
>> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
>> +		switch (interface->desc.bInterfaceProtocol) {
>> +		/* Some keyboards don't work until their LEDs have been set.
>> +		 * Since BIOSes do set the LEDs, it must be safe for any device
>> +		 * that supports the keyboard boot protocol.
>> +		 * In addition, enable remote wakeup by default for all keyboard
>> +		 * devices supporting the boot protocol.
>> +		 */
>> +		case USB_INTERFACE_PROTOCOL_KEYBOARD:
>> +			usbhid_set_leds(hid);
>> +			device_set_wakeup_enable(&dev->dev, 1);
>> +			break;
>> +#ifdef CONFIG_ACPI
> 
> Why a #ifdef?

AFAICT acpi_gbl_FADT is only available when CONFIG_ACPI is defined.  I 
didn't think it was reasonable to make usbhid depend on ACPI.

> 
>> +		/* Setup remote wakeup by default for mice supporting boot
>> +		 * protocol if the system supports s2idle
>> +		 */
>> +		case USB_INTERFACE_PROTOCOL_MOUSE:
>> +			if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0 &&
> 
> That seems odd, there's no acpi/pm call for this instead?

No, there's not.  You'll find checking of this bit in about 8 other 
places too.

I probably should explain the difference from this and 
pm_suspend_default_s2idle:

acpi_gbl_FADT-> There is a bit in here indicating that the system 
supports low power idle.
This bit is set by the OEM and is used to indicate that the system
should use the special ACPI LPS0 device and should prefer s2idle over
s3 if both are present.

pm_suspend_default_s2idle-> This means that the system has been 
configured to s2idle after processing the kernel command line.
If the system offers both S3 and S2idle, users can override what's in
the FADT to set the default as they desire.
This is also how i8042 decides to set keyboard wakeups only in s2idle
mode.

> 
>> +			    pm_suspend_default_s2idle())
>> +				device_set_wakeup_enable(&dev->dev, 1);
>> +			break;
>> +#endif
> 
> thanks,
> 
> greg k-h

