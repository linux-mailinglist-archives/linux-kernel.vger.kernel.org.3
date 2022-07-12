Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDF57271A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiGLURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGLURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:17:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97214C48E5;
        Tue, 12 Jul 2022 13:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQy4k0z+JSG3D9J9pYzRmVCdSR6QMqRb4pd1/pY9atgKD2hpWWva2kqKyuP5swah5YRNfqxdVdq7D4VF5AOv6osZHLq83pjcxhlmZLKeWrIgoX42O6siw6hzIQ+thvSmIc8Jp7xuZO1LWZ8c3dOqqfQP/wn/H1JgBCmTUas5QRGeb3yjYol7mINc6BsCKMSF1C06kyNyFqDxiFXI2Gvk0FARtzPHI6tVEzmtBprDvKpJYATdEXjdsuvF05Kl6+sdPO0VE4EfRpq+sfqVykvoa5jNcMHi9+OYdvMbSdzzTSkCTaxfQds4/ZXa9fmPRuJoUZrpgDGFcoNMpIHyhfwJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPINEDoxdjHPHmpBaYfJJ245WIdsM+I3WL+lhwbhYiI=;
 b=UGbPLGpB4NESMVXXpaqgC10YyIOJ8lcxvg51udf5pTfJEH2nnYs5pjHIIp9Dij7c4TVO3BZSuemempsAjNo8nYBDa9inY9utOB6hDyRkIkxTurgc443WqP5nQ9NJHTjZOYb7oCrMYPMd5B03MRuVMFfhgdSSl+p3a7jT1s7o5StuXyX7YX1EI+R3p8VQfBuJT35TdbXPZV39rXtPlwazoBaidmkoFmXogxFgk/IQYnPjVp8/2doXUIAM6cx09F4W21wymJcjFdgkSAqubj7c7TIPfPlP8m3/DKS8cLegragkT2iy1ssCacz5Bwb8yocxUjZXKs5T0h0pVCk02S6fVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPINEDoxdjHPHmpBaYfJJ245WIdsM+I3WL+lhwbhYiI=;
 b=WS+b3E8/TvEh8+GXGJ8u+/RrNKsfRte4IihBhgDNSPHPWtMWDq4uJQ9iFAW9OrqKIIre7UVo+Ob7l20P9avEGlj2D625p0RiwNrJHhZrHEyIRQYx98vlZWkuqy/mTGRBAMx6xd8gDs0ZtsfO+MzYFBGb/cNsvVbJmWVTqMW1Qco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB3534.namprd12.prod.outlook.com (2603:10b6:208:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 20:16:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:16:55 +0000
Message-ID: <fd572ac1-9447-b148-8ad5-c6ecca5c6477@amd.com>
Date:   Tue, 12 Jul 2022 15:16:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/10] PM: suspend: Introduce
 `pm_suspend_preferred_s2idle`
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <CAJZ5v0g5Zsbddid+w2qxa_bqwmeP-FSk_42SZ3doMoFs0r8S8g@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g5Zsbddid+w2qxa_bqwmeP-FSk_42SZ3doMoFs0r8S8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:5:15b::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3568a60-75a9-4d9f-1efd-08da64437739
X-MS-TrafficTypeDiagnostic: MN2PR12MB3534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rK6F8EsaFhFHgXMF2o4tKuzmo1VN1PHjyNE6LMOKuVZ4o9Vy7iOUUyXMwy0FAhRnl1s1O4XmW4x37Q7QLpRXFI1azT36jc5Ery0YBaSAhUVC0SAvLlMLI2rjjeZsUR6NozRVXaqAdWcumaFisce/ntPuePIJmocQ+ZOl5Y2hD1Y+P0Fa7y6etr19GsuoOc3ID1NRpCoyc0SHTQ/H1zgjp49pa4pvsLnBYQ7G4mhbZl0KaeQeB7Bobl9ScDwAiAbdBsLMJUx3bixZkByoz+hAJQWDLewqi320swX50X7xMS1QmsCEDi6/5EMvuchdMirs3uuVrgEyfR5FmyAKOdE/8FUJX5zNthb7CVmzEOB//mQD39PMRFVGYoG2OwbnfI2bAVcgPNqwXnZy9T/pT5vYXvFyDJbx9inreVDJ1rJoTlcWlJqdVCu88lLxxwORdLiOmwF+/E/xWxMst33cD84uaUEdU4VFrP4rg1fQulk8fNnOIdC2CCMuvA0YadWZk8M57fyyO8pTHPZZ8Eek8+5lbz2uVa+qiFTTKPsIndTRYi3EubpPkTcNbSaCtOrGZH0UWRuekNyOimV3NYz37zTyGxD459Mq9QXWdAyTX1kEAL1q3WLe0UgJ8C+DTqUyjQEJTVs3Fa1N7mjyYttOExMppR0e+RUF4HaCQ59JC6jaidI0WJFIvtGXOl8dPebNBERPEdo/AW96OWnKXbCI1LVkd7+tpyjuHTKS/1hnQbyLyhdWOJTPoBgXJ/6KpBSdZtEo1VtRVZbtxx4BFaa7bIUV3i1O5bgVo4jg1GwB2mXbgglFLCuyLRG1nPfPKLYqkZoPAI3vbreoSeobvMYe4kgsAdNdrldEP6QLYDc2hltyvKbIXCDE71awwDt10C6zCwfH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(186003)(31696002)(478600001)(66946007)(4326008)(53546011)(26005)(6512007)(41300700001)(6506007)(38100700002)(2616005)(83380400001)(66556008)(31686004)(8676002)(2906002)(6916009)(15650500001)(5660300002)(8936002)(6486002)(36756003)(316002)(66476007)(86362001)(54906003)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmU0SEIvMWNGWFdxVzEraWJZeUJnaW5Qc0IrWExBRE5jM3dyc2xuOFVsY0l2?=
 =?utf-8?B?YzliNUVQSDd6WXpWYXdNNGY0dmFxS3R2aGtZZEY3cVlYSzVldThTRytaeEhT?=
 =?utf-8?B?YllFVFlmZDZ3WkZpU1FEOTBEMVpjTVJYVEtpcG0veXQ2a1ZYTXhWa2FkbnY2?=
 =?utf-8?B?enYxM0hPblFEaG8zU01zTXhWUk9EblNObkxZU1pDRnQrQzM5enVWTmtnM0xW?=
 =?utf-8?B?dUZYc2xzaXNkWFJGdFByY0JmazNGYVV0bGQxNHpMcWtpM3R3UEhTUmRsUFdy?=
 =?utf-8?B?U3MvQU1CeFBxZGtsRkVQVVRJeC9INzM1NjFHSWxvOXhEMDJvNGlBdG1La1Np?=
 =?utf-8?B?YkhKMTFsWUo1VG1WZy9LcGErQllDMEwrRWJFZ0EvL0FBQjAvK1M1L201eTRt?=
 =?utf-8?B?SDZEM3VYT29JdDB4NXM4aEtNOEZDTlllSXdkRnYySG8vdHE4RFhBdzd0YW0z?=
 =?utf-8?B?b1VPa1pzWkFTZ3ZYaWNPNFlBVzEwN2wwY3FSWTR1RFJCaEU4elQ2ekhGdG8r?=
 =?utf-8?B?Q1ZHNGJBQ2lmczRSa3lWeTJkRXlyVEVxRC9TNldyVzNmU3NZaTNqcVduVTNl?=
 =?utf-8?B?U2hSemZ0QUxDUEFYRWdUTGxoSlNjRzJqSm4wUDU3dGFCSWxmQVFMS3hvaE5m?=
 =?utf-8?B?TlhYNHA4NThzd1JpMVhRNnQwMWViR0cxUVN5YWJRa00xL01iYWw3RWlSSlI3?=
 =?utf-8?B?OHRuSGExc2xZODBINHA0YXJNZjZ6RmdzNmpMRmZZd1VHSHdEbTdVOFliSmps?=
 =?utf-8?B?TEcrdXhKVXhnaWJSZmgrd21seVcwVENFQmtraXNpb3YwSG4yU0ZyY2ZBQ3k0?=
 =?utf-8?B?OHhzYkRmbGpiWHUrS3FrdDVQeW1pdlhqNzJJbW5wNUlkV1RZMDBYd3VZV0Rw?=
 =?utf-8?B?STVaSlZaUFZCNUdHb1JPemFBKzFIaERoNHBNOTUzMXhZa2xSb1hRMElocnQ1?=
 =?utf-8?B?UHZuN0ZRUlltVHJZOE9VazcvLzFwVkxUb1ViR1F5aSt5dUNwaFZjWlJRVk1x?=
 =?utf-8?B?ZTZkdTBSVnZ6QS9rV3NVR2tYL3ljQVpma1FwOUZnVnY1azh5VjlNelFKcjJB?=
 =?utf-8?B?V1hiVE9IcDBzbTBLQ1lnMnhvbzdxREtSL3JTVUZhT2FpZDBUYW9USUZ4NzRL?=
 =?utf-8?B?TWhjQmNmT3NENnRURlNPQWZ1R2tKdkpBdk1td29zTTRCSWlYckxLSERWRnd5?=
 =?utf-8?B?cThiT1BIbERZVlU3USt4VzVjSXcyV2NXeFUxcGRYT0gvUXpxOTZqMnJydTFa?=
 =?utf-8?B?MlYyaXdWRjdta091bEhDRHFtdEswRjNWczdYeWFRREZqR0pGejI5UElkVjRz?=
 =?utf-8?B?T1JzL2NiR1FpR1NGcDJsRUhiQndJaHJnaG5Ma2FXbTQ5TmZKTlN2aE5CTDVh?=
 =?utf-8?B?NU9vbkFpa0FGdDY2Q2Z1RkN2dVpNa2wySWFkbFRXcm01QmFHc0NNSjBFVU9x?=
 =?utf-8?B?SkE3WU1hcWp3Y2gyZWVwZWZ3Y0xTNTRWdFZCNGQxWHRCMlBseTBZQ1o2QXhu?=
 =?utf-8?B?bnlhUWJOcGZXb2hHOUFKZ0JVOU81VHlVbHpjcG9DNVVOZnNSU0cvMTMrNlk3?=
 =?utf-8?B?Yk93ZGpnMkJybXdyRjNiTDJ0OXlxa0pUazJkRUR0aXNHUGk4bjVlbVpYWFNp?=
 =?utf-8?B?eUcybjJQRXBkOGNNbVl2Ni9rYVBqMFltdzdtL3l6Mmh1MVQvWTQ2Nmc5cGZG?=
 =?utf-8?B?Q21zVWhLK3BydWgvZXRURC9iL2xSQ3dYZlQyaVcxT2FaNEV4WmloM0JrTVBI?=
 =?utf-8?B?K0RwaHN5Q0lKd2JVODZpYkY1Tm1NMThHLzljbFdWQm1zNlROOWpZM3pjWGt3?=
 =?utf-8?B?NTltTUtVVHVoZFdJeGVWdy9LWmJFbXVBNytmQnkxUVIxRVNtSGw1V05WZ2hN?=
 =?utf-8?B?anlBU2NUbmZMNTBPNGNRZUJQY0ZHc1BHQjZhdHhGaGdiVnVNRFZqYUVROUtk?=
 =?utf-8?B?V3VFNVhjTXlhNyt4QWdHNXNLSk1TWmJYQ1lnRXVIcjRTbjNhL3h5K0d4cWp1?=
 =?utf-8?B?RjZhdFk2dTJmOXc0YkcycnkvZXVKL3Z2aGFjWElsL2dHYWFESTl3QzFaTWtY?=
 =?utf-8?B?N3FWdnJscVZYdXZZLzE5WHYwZHFGcVdKay9YZ0pHd1dVZzdwTDcxRW5xa2Jx?=
 =?utf-8?Q?uOD0ICDjdCCoX9kAy2XHQ01TG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3568a60-75a9-4d9f-1efd-08da64437739
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 20:16:55.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M8y3w5P3aTc58v0fJxkTPVv0LOEBof5ebQUDMuK/yNgGXkiKPYVwZzVxh7UnmIz+8l0xb3tyMXJgIwy8VOR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2022 14:06, Rafael J. Wysocki wrote:
> On Fri, Jul 1, 2022 at 4:33 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Many drivers in the kernel will check the FADT to determine if low
>> power idle is supported and use this information to set up a policy
>> decision in the driver.  To abstract this information from drivers
>> introduce a new helper symbol that can indicate this information.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   include/linux/suspend.h |  1 +
>>   kernel/power/suspend.c  | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index 70f2921e2e70..9d911e026720 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -305,6 +305,7 @@ static inline bool idle_should_enter_s2idle(void)
>>          return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
>>   }
>>
>> +extern bool pm_suspend_preferred_s2idle(void);
>>   extern bool pm_suspend_default_s2idle(void);
>>   extern void __init pm_states_init(void);
>>   extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index 827075944d28..0030e7dfe6cf 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -9,6 +9,7 @@
>>
>>   #define pr_fmt(fmt) "PM: " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/string.h>
>>   #include <linux/delay.h>
>>   #include <linux/errno.h>
>> @@ -61,6 +62,22 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>>   enum s2idle_states __read_mostly s2idle_state;
>>   static DEFINE_RAW_SPINLOCK(s2idle_lock);
>>
>> +/**
>> + * pm_suspend_preferred_s2idle - Check if suspend-to-idle is the preferred suspend method.
>> + *
>> + * Return 'true' if suspend-to-idle is preferred by the system designer for the default
>> + * suspend method.
>> + */
>> +bool pm_suspend_preferred_s2idle(void)
>> +{
>> +#ifdef CONFIG_ACPI
>> +       return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
>> +#else
>> +       return false;
>> +#endif
>> +}
>> +EXPORT_SYMBOL_GPL(pm_suspend_preferred_s2idle);
> 
> First, this is ACPI-specific, so please don't try to generalize it
> artificially.  This confuses things and doesn't really help.
> 
> Second, ACPI_FADT_LOW_POWER_S0 means that "low power S0 idle" is
> supported, not that suspend-to-idle is the preferred suspend method in
> Linux.
> 
> System designers who set that bit in FADT may not even know what
> suspend-to-idle is.

In "practice" it means that the system has been enabled for Modern 
Standby in Windows.

> 
> But it is good that you have identified the code checking that bit,
> because it should not be checked without a valid reason.  I need to
> review that code and see what's going on in there.

Within this series the intent is to see that the vendor meant the system 
to be using Modern Standby on Windows (and implicitly Suspend To Idle on 
Linux).

With this I was trying to distinguish intent of the OEM between intent 
of the user for helping to declare policy.  Maybe the distinction of OEM 
and user decision don't really matter though and "mem_sleep_current" is 
better to use?  I think in a lot of the cases that I outlined I think 
that mem_sleep_current can drop right in instead of acpi_gbl_FADT.flags.

If you would like I'm happy to do that and send a new series.

> 
>> +
>>   /**
>>    * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
>>    *
>> --
>> 2.34.1
>>

