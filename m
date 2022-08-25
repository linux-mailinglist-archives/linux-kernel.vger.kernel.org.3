Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87835A18CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiHYS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiHYS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:29:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F5B7ED5;
        Thu, 25 Aug 2022 11:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1BdIAIkp55U0hgIuGR6t8P25KXIbuPvO14vRlPglKh5hd1xtrljztX/2AA1bJBIVeRBpSS5oc93bi6MFeDacvg+mdJQ3opoCZQPUfu2IW2uXzZW4hvdDfkb/Ii9FEf5b31GWt6Lcg1lN2/s08PXwffOIPElKEokCtVP9+a1y48cG9wq46mksauB0vPKNn0OwTML2TSPgZYYaYpTGj1ZtxiwDj2Mzm4U/2BD/sR43kJpRktwhY7TTWZCxYP5oVJ/OM+Gr81DR4ARpMNjZQ+MwzjH91p53/frXJ6SLA6ns9hyKqTHfI2Oq3bdgSSmgbsjn3GT90rRtog5eeziPwgoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnhZ4DdJRNtKxToWfpyHN1WppDMK5XDv79whDp+hpRE=;
 b=V23t+KzlWqkYaBMFdg6qsPZOL5Gl8jxHX142kKDFWdOJ3cJ4MCJskFYBAoJl9F0SUsS9OJpWy+JqQfdj9C911tELBChA5/g8VbgNhiBCAYzzc6QVzvTZ68pdsXtuVyV/rTah4r9M82zTn9KVggdWDwI0SMgX3KjIkdve9VQXSoQfK4KliqJNgrD47g8Aim5lody4Y56w8yWwmz1qKyDaZN0YWuI3S14RH21tnAB/aOvmoiQmwDcP06ceCc6+Ki2YcSeHFVDy90RtQqX48/xfxjFquBYl2OkQ81eDRhCZiuyVjnmcyIWuhYewGmciC4WFcVGVp+7Pac3ac7222MAwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnhZ4DdJRNtKxToWfpyHN1WppDMK5XDv79whDp+hpRE=;
 b=Mywcpu+lJV4dtF/Dtc2WrE9+NqnFe0f47th1JNNvbGB9b4Ol2X5kTnlTBT7wvag1Qu2tmghlReqVbM7ClCZi82kC8QPlCrmgABWWnHIUABCyJRc4g1vhrRwo03VkV+3ov1ioarDcoJ9WV3CPmjBRZmCjA8VuD48NLmwf9eB7XiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR12MB1743.namprd12.prod.outlook.com (2603:10b6:300:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 18:29:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:29:15 +0000
Message-ID: <54e439c8-7390-be01-66b2-5692af571d1b@amd.com>
Date:   Thu, 25 Aug 2022 13:29:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5607133.DvuYhMxLoT@kreacher>
 <ecb5a2dd-47b2-e5e1-5254-42bd5d018578@amd.com>
 <CAJZ5v0in-me017RoR8yRMMXmbBofr6u9o2_WMGh38cpiy3cG3w@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0in-me017RoR8yRMMXmbBofr6u9o2_WMGh38cpiy3cG3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011ef10c-11f4-4de1-f5af-08da86c7b703
X-MS-TrafficTypeDiagnostic: MWHPR12MB1743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCxxJ31+wUuE93jIpED2Sl7KoY4HJZCskqZAmVeyRCjkjEyd3+8oaHpEn8AxyTl1Dq0OhrrB1Rr0eGP75LDMAoTWjYhZWz9AJM4aOz7OrZ75VquwzlIYzNEI5W0N6iO1h6GYQkbXNlDCSeYDrnkZOg4Or+GPJ1PGy1qWf5ozEnE7LeNOFYJGSf7+fH8qcIKHn0ZHezk8mfjBKUWEnPDb6F2hgTqgqpgKgFckYkSBmlqFhbC6c0sMtXkta4BcAFUge4A00wwk2Z7SCMx/AnMoyhswe65hR9bCeIYlwaoVXMbpQx+mAiSyZgnhfXQG46fRusXRNuPf25nQbirC0VFVOuj8UJnhrk6YJu8wPeC6fBRzEA/XJbtfmmeDZcZsVf/7kWAXXq5CS/vxjQEbBVKEJW3od9SJ5ABP7iZgN+qHjGwtR0b6UGeDCcZVPrS5s1jZ1lLGq9wkHeUtxvCTjOlt0UM/GBfr4bYqn0NJuRGajJrs6E1rpldU6mPmVXLRuHe4jI8kQs3nrdbArwG/RT/g6oAhIPCZ4GR/Nmy65rMKzPdDuAmWF7Hqev3T/3u7lbOzskx4E8SxYbmaK7MceDUqCQumI4kbmrVz6TFtOwxLrNXXK46hIyo8pSiYVapWgNVqz14vYS3KD5YoRHsMztzm6APNwMbXVcllzpd1taJEc0S2obXldBeNrY/IQcPL+YN963ufvhogqCJMcvS3bQ50aimBFFDUcv24QB4UIQIW8+9j/QZaHNk45M1MULzVHtPWN3DdRHPxLv5D6pXwnCWXa2zG82+sSwDBamNabFzlEDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(38100700002)(186003)(31696002)(86362001)(41300700001)(2906002)(6486002)(2616005)(478600001)(6506007)(26005)(83380400001)(5660300002)(66556008)(8936002)(6512007)(53546011)(316002)(8676002)(66476007)(54906003)(66946007)(4326008)(6916009)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpUNzJocjB2b04yR1ppeTlmNHhlN1crTGtRZExKTUEyUE4vOUNtOXZxTWZL?=
 =?utf-8?B?eWJyK1FsMDl6ZG00Si91enU3TnFGWU9CMnVyenhjL3RubW5sdU9TS1Iyb2FL?=
 =?utf-8?B?Z3FEdHlEakI1R0wzWUVZVi90VWZZM2RPK0I5aWpXa3RScmYyZlBmNnhaUG1T?=
 =?utf-8?B?WDBFNFpVakhsMy9OL1hRaVZuMEZ2aDYyNlZ6YjlXREdGV2FYZG83aW5uMHdk?=
 =?utf-8?B?UEcxR1pvcGFkM2FEQ1pCUmFrZjc3Q1pnYjlYa1VDM2F1RGdtTkVsUUdNcnpD?=
 =?utf-8?B?Ly91SVlSTTluU3htRFhzekM0S2svVU1kbmtPWnBLMHdrSVU2Q3RzdDMyN21r?=
 =?utf-8?B?UUZOZkhPL0dGT0MvK2NIcitXRDZUMXh1d1hSODlCMWY1czMvdGx6RzdNV1Vq?=
 =?utf-8?B?bW9KY29mczExMlNoZ09XOGFXMEJXVzhjV0VhMzhxVzk2d3VJRnhIYVhEbEtx?=
 =?utf-8?B?S3VnZWlJb1AvYzhlRmFPemZYRVZDSXB5NDc2OWFCb2xudVphNEVobXN6M3pt?=
 =?utf-8?B?SVJoTWo5dTZEdUpxaXhCcHpMSzZ5QllZRFllM3E0Y0RtYlRBRktGUFFSSEkw?=
 =?utf-8?B?NkVhWGcrdXJqQ09HQW1FUlo3RTVIdzlIYjNZMlBkZGZHSmZlajg5TUIzTkts?=
 =?utf-8?B?WXRLTXNybTlBYTlpTTczMEJySHB5RzM5QUFkUmtlcUhMODljMElnMmFTeWpy?=
 =?utf-8?B?dDBra0p3NUF1SENJeGowNmlOYWNCcUxDU0lMK2t1RFpxb1ZFbUJ3emRYT3JK?=
 =?utf-8?B?dlFJQWQ1eXdBK1JGb3owS0oyVzQ1QmhjcFIyOGFGQzd4UDdPWDRxNTZUaUQv?=
 =?utf-8?B?NVQ3MS84SUp6WG45bjBZTDM0S2hRNHJFTkphQ2Iyejdmek5LUXpoOHJGb1Bp?=
 =?utf-8?B?S0s4OC94VDhKK3lXWklXY1o3RWZhQ1FFUHMxd0ZYbi8xVXNJVEZWUzMvdUZ4?=
 =?utf-8?B?VFFFeWdQZHdnQzZMM1BDQTQ1UGMwcjh1TnpPcHJ4LzhkbTZHWGZCMGE0aDNT?=
 =?utf-8?B?VmtHRE9LNTdzVVI5V0xJeHVXU0E1NEUxMGZ1bFBFaUhWWGRKcGF6eElsNHp6?=
 =?utf-8?B?OFUweTZJbmV2eGdONGZFM0JkczEzZ1VJVnlib3ptK1BiK25KQmV1ZEFQNm9z?=
 =?utf-8?B?VHcrS2RjcitydSt2Qko1Y1hsOWwwQW9rbEszZEZtTXV6elVvVEppSmhwQnl3?=
 =?utf-8?B?dWFKTFlER0k5aFBWdDUrY25lYWkvRjhMNFNrcWphNnZUaSswNmF0TXQzMVhM?=
 =?utf-8?B?dkdOKzZKZXhxNS9NRko4NU5kV25GSVZQbXRCakU5Zy9teEZ1TXZ5RVdsdlpy?=
 =?utf-8?B?ZHN0OVR0VWE3eTUwWjhZRUJ6eUUyYk02UEozTWZkY1dTU1hTMzBTdCtUVWtp?=
 =?utf-8?B?STJQelhBVjNzVHI3aFJNYzhkTXBwVGRJTG5lSWlnMmFmUERZZVdTWXlZMFhK?=
 =?utf-8?B?N0dYQWxWOWNUdXBwcG5zaHZQYW1Ca2ZCRHBqK3NROWEwdThSdHBHZldVNXVn?=
 =?utf-8?B?aWU2bXo5eFBsZkdNWm01N3hKM0JLNElBWEZCTDYxZ3JHQSs2MmJwVmJVdFh2?=
 =?utf-8?B?cm9GVnEyR2w3c2M0cGVZdFFTeGJzK2IreTFsOVNOL2IyUC8wMFBmUGhkSnlI?=
 =?utf-8?B?UnBvU0Z1amV3VUQ0VXB5dkxJRzFlMlpNUk5RTmtwZ2RVSmhDY0ZiQStQeXow?=
 =?utf-8?B?cStKcTVLVFkvRWNlM3hZT1huL3AzRkNhMjNxc2VQc2Ztc0dHaEc4QWhoUXJx?=
 =?utf-8?B?aERBYlp2eFJkQ0JnVi9FNGJxYkdmamxOckFLZUhEWS9VU21uMjZJeGRkQURi?=
 =?utf-8?B?eXZJdTg2K2pjRDFncXA2LzNRcUZ5QlcrdE9DdXdMWVpvZHRuZkZtNElKczdC?=
 =?utf-8?B?bHU1SmZqZUc2bHEyR1hheUFkaWRkOThlZ1FCTTRUSDl0QUw5dUJNQlJqM0J1?=
 =?utf-8?B?K3hIL1VNcmVEZnl6VWxCZUczaVI4Ymo3NlVpTStLYXp5YXI3cDlZZThNYU53?=
 =?utf-8?B?SVNtVzk3L0JWeXBkeHF1cVZFa1lBQVRkV2JwZlo5MWZhR0ZVTm5teEprb2hu?=
 =?utf-8?B?L2VWUEFESHlEYjVWdWxnWFVKcWdhSEx0ZGlEWlJhU2R0cmNUUnJaVTJjUzFh?=
 =?utf-8?Q?coYTM+qtj1xY3gg++czbk+ehP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ef10c-11f4-4de1-f5af-08da86c7b703
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:29:15.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkOakmZLy0KDMBDmYGv2sOaNePbCbqr4NtKm3CZ2HCEpNA4aOi/Zf1xN/IeTMq/m1DFOsbYhpC7sssA1iGMxvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2022 13:26, Rafael J. Wysocki wrote:
> On Thu, Aug 25, 2022 at 8:17 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/25/2022 13:01, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
>>> use low-power S0 idle on the given platform than S3 (provided that
>>> the latter is supported) and it doesn't preclude using either of
>>> them (which of them will be used depends on the choices made by user
>>> space).
>>>
>>> For this reason, there is no benefit from checking that flag in
>>> ahci_update_initial_lpm_policy().
>>>
>>> First off, it cannot be a bug to do S3 with policy set to either
>>> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
>>> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
>>> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
>>> protect the S3-capable systems from failing.
>>>
>>> Second, suspend-to-idle can be carried out on a system with
>>> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
>>> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
>>> needed to handle that case correctly, it should be done regardless of
>>> the ACPI_FADT_LOW_POWER_S0 value.
>>>
>>> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
>>> ahci_update_initial_lpm_policy() along with the CONFIG_ACPI #ifdef
>>> around it that is not necessary any more.
>>
>> Looking at the source commit for this behavior:
>>
>> b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with SLP_S0")
>>
>> It was trying to set a policy tied to when the system is defaulting to
>> suspend to idle.
>>
>> To try to match the spirit of the original request but not tying it to
>> the FADT, how about using pm_suspend_default_s2idle()?
> 
> The user can switch to "default S3" later anyway, so this wouldn't
> help more than the check being dropped.

Right, they could also change LPM policy to different policy later too 
if they want.

This is just for setting up default policy.  I think if you matched to 
only when pm_suspend_default_s2idle() it would be the least likelihood 
to change this default policy on unsuspecting people upgrading.

