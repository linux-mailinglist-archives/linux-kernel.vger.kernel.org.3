Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D038657D470
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiGUTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiGUTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:55:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977DDED8;
        Thu, 21 Jul 2022 12:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O50KO30HbMMuNerd1CLz7zciW4uAfhMaaI5ez0PKraEOYhDIUQenqemSx7Hal6/FIaPj36T46Ai76sfrkiR//9qkMbhVXS+j+mqpzYtB23aubCU4fcyUdM3eN7XAEbGwXLMUmxmpWavV0tkD671w3VuJwr6XRkdL0pnc0Vz+xnHv+VGj6YZdoR8mefDsoSlwAE2j6EBEhf3IbtnfhOt2vrb52SEqz+A7KimU3K8eTbrmcqKZt87jO0JhMV+Fe5tb1y862V0BrGG2zNCyRJFC/5sJ1/cu7uMg4uKQH4VKJVK3CI/n2Jj3BD/Zax1LoqyQt+ZgIgq6xBZkHTBGZcf0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqixkhdXqeBDtET6DlTdnSbCkr4bPbXmzR6b4GzRezo=;
 b=fAEQfH23xZA5PrnTUi6ZIlTiq5uFneYhYxA6Rc2ZY9lB4JydwfE4IrZawkZg0MHYQm81OVrlGYHf0n9HkdyP1iSCHTu0vgg2XyPZXLmSVyuFf7M/F/x2lUry8FQTvHxF3KlqDgykVS8eO5oyqD3vVSiCG2wE2qUDtt6JZ6JMu4cZPlcDDVhs+HUvLzT/4WZfWLg3b/8M2kZP5T1IYqDXZqDeNAUgYdWYsH+9cZQ0it8KIUwgO6EC7KM6bmfKAbTCfswKWGnuAJQlsPdn/IPld0AyRW2LVc4QE4Stu1koLKhSconaejjeG92BYkfDFy/VkXZd4ryjuei7tvu0Tvqwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqixkhdXqeBDtET6DlTdnSbCkr4bPbXmzR6b4GzRezo=;
 b=E3w0LafnabRYgJZv2iJhk2k8xQLNvu2XQdWDsIpBHeFLG1PNiZnhHG/T3DLM3pjQ1O8mPw3SYSgVYBBUFxNNyXw85+cHHteEDGkynssJbmHXRJC8lv7wXU9h3QK+bMs4PiUWybNEeGeSj/KcLvmvPGxHiYHjrdK2Ob9UgbueNbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN6PR12MB1745.namprd12.prod.outlook.com (2603:10b6:404:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 19:55:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 19:55:18 +0000
Message-ID: <c3b142ff-4a54-036d-320d-0b74410ba825@amd.com>
Date:   Thu, 21 Jul 2022 14:55:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ACPI: PM: x86: Print messages regarding LPS0 idle support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <12039470.O9o76ZdvQC@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <12039470.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3906d4-f443-4f50-305d-08da6b52f013
X-MS-TrafficTypeDiagnostic: BN6PR12MB1745:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d04VOS/4bYKq4cJrGJhFtc8Ppm+tBYuacOhMgWC68ak5JxS/oeXGSUu08dWPnV6PhUGmXutdZHEmXoloCP06iJ0FNsvxnYPMJuKHVbyFbTaouKncLV7U0CZcxowZJ+YkXtt97tJrXVVSxjHSefr/Ckj4geTRj+xh+eV8FX0CGbdZdjvVQZOdvfzFb6ZNlDAkG6ja9LKSXRQg36q0g5BvIvO6H4INaExo4/JHytlLUiRpvNQfx68jxZC/QY9xb6qvsluDEEaCoWScFRdb3drolA16F+hqB5C3hXLIk907QTE03XQnCzoLFLgwGzLw6Kwtq44CRZFMc8xkKvibGu2rdJmU5Tm6CEv9r9by0Ds+6SOKlVZeZTxOvtSTZNNaXwmeh4CuTFlcwEiWW7wbLlBXvt0xakWMIC/8FifJPPSsmqhFh1TnES0Evc2NM2wJbGniOUwjCKMcQmwmoPk3963DZdQzhpXnQDvMYn7bq5qhzI2oNtD3fOSkTzOn3KDvbOvy87KNygSx861EbLyq3x78GwfWNiEPtSvio6DlOUh+tnKWsHw18aP8qTJ7Cc9o81I0C7QoyConUGHFzEUIu1truch4Mzss0bhEqTI+C5QXHRHOIGbxr+TXXvP7yAiAdlEchpiPYj5xKCcNB8ACXTeUY2dSh5COrh599LFsq0BHEWgnolYST7F1JOiVJel1TPK8lyX1mmRKsQLLeqg+1IMPa1+dUz+paX4PZVkz/zbMRiZzFHrkDRHSYiwpbtkY1LuWpfBmFrfHn6kKnzUm7B3ua+5OK+SiJ6qY6bZ52XaDTwzXSv9ECLbB4cPTxEQ1mWYG0ALk5pMQ3/zZsQhFfdRI9WVO3TG9kVFL7WybrhQOlvMcF7R4tnf15w3lzyhSlq9IFeEPFOV7N22ZV8FbWAx3WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(41300700001)(110136005)(66476007)(6506007)(478600001)(6512007)(53546011)(6486002)(316002)(84970400001)(54906003)(2906002)(26005)(15650500001)(8676002)(4326008)(66946007)(66556008)(8936002)(38100700002)(36756003)(83380400001)(31686004)(86362001)(31696002)(186003)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tHaVdxdTBuZ3R3SFBGZ0tkN2kvVWlBVHFYSmhKY0xTVyt0UjZLd21nUFVO?=
 =?utf-8?B?QzQ2NGpYNFFYRTBmTDZEM1hxTWhHSHdPd1ppb3BuNldOd2svSmdhcGhGNWsw?=
 =?utf-8?B?RFNEaFRpbWtrMmlvQlNuS29OSm0zeFJrWE1XeEl0T1owb2lvTmdwQ3JlRzE3?=
 =?utf-8?B?SDRUYVpGQzY3WnFCa2ZEbTJNbXRQZGNBd0poYmtFazV5VHFxaEhEN1hSZmVP?=
 =?utf-8?B?STdOemhYTytrbVNuamRaQWNFc0R5eCs0b0thRXJxWjVqSGVQN3VzSmpFWkxN?=
 =?utf-8?B?MTd4eG9zQWplR3VteUdqY3d2NjNCSE14eEpENU1tN1B6d1k3bVRTc083ZzVK?=
 =?utf-8?B?dlR1b1AyK2EwWFhNM2NjdjQvWm5LOURoS3RIbDhBU01WRWtZQ010SVVwS3RM?=
 =?utf-8?B?RHF5S1h4V2ZYRTNRWmg1OU5BS2VUVFcwM0lkclUzYWxWMGoyb1RtaElFRjVF?=
 =?utf-8?B?ZzQwajBsNjRUd0ovMDVGbG9TNmtxWHBGYzh4RmpjRkdCd2FHSDFJc2RWVVkx?=
 =?utf-8?B?dW5GQjdKbksxZG52cWduVURja1B2dms5RHA3bTBaREIyQTNxR2VlTzFSLzEw?=
 =?utf-8?B?QmtxUWdtT2V4SjZTSWYxbGFlaW94SDdCTHVwZlJFbURYeXc3UkVBdXcrNFRI?=
 =?utf-8?B?VkEzWnJWTnVkRzgwdVh6RWk5VjhDQnhHMlM0RjV2UnpaUG9sZ0RqazA4SUtk?=
 =?utf-8?B?RzNBMGRESGpLS040b0ZmemRPYmpYNXd5cWVBYU91MFFxYk1uQml3ZHBVYTFs?=
 =?utf-8?B?U1NTOUJsYUZ5aHducGwveWlHRU1QZzhMVVMwMzRmN3dkNGpEck16WXZuZmhu?=
 =?utf-8?B?TzgwdkhsSzhXOXZxeFNCdzc5ZEE1VHFNU3lzM1R5UFdHWWZsR25XMW1SeWxI?=
 =?utf-8?B?YUtBdkcvaWRLRVFvbVVNU1lhcExnbVYxUmRzSnczbGpjb1ozNkxrMXN5Vk1m?=
 =?utf-8?B?citBcXArZmdXVm04R3NqOGVVV25HUUxoTExVZ2U2QkRKdi9uSnBjWVZHcndB?=
 =?utf-8?B?S2VSMWtETTZqeXVmV0RlZEI2QmZER2ZBNTVobUZpUjBZSGlyV1l4ZXRDYjI2?=
 =?utf-8?B?TmcvSHNPRkpKWnFabDcxV1k1MWVoQkNNaVluVmhYektMcG9tZkNZTEp4OXoz?=
 =?utf-8?B?NTZJaVZkQlA1VU9oSFFUd3dIQXlHTGZOQmpoZU1pV0M1SlJIZlpHWDJOajRh?=
 =?utf-8?B?Ri9uZlFFaTM0bXlZR3BMbkREdlMvYnIvSGFXcDRGUDc3UnBCQmhlS0NBRG04?=
 =?utf-8?B?QlRGNS9Mc21QUlNISTBiS0xYdXJyRmJKNnQ0aGxjaVRkUGlVbTYzWkZVUVpx?=
 =?utf-8?B?MmdwZ1NubzQ3V09NZU5XVm9Wby9PbXYybGhQOXFuemxKSFl4UnU3cnEvdkto?=
 =?utf-8?B?VTRxMzMvakVrOFpVUUZrWXB2UGVEcnZXbkMwODRLd0t5ZFZhQTJ4bzVZbWhR?=
 =?utf-8?B?WG0zRlRvZk54bERXR0VmMjRuTldQdWliRmV2UGdVNXZ1am9NL283Sy9CcXBC?=
 =?utf-8?B?VVNlWERvQS9iNm4rbzE5V3ZCV0tOQ0ZKTnpVdVZybjNOZldNZWlSS28yNkNk?=
 =?utf-8?B?aGFSeUJzait4YlNRQ0JzWnlZd25Jelo5THprMnlGL3pBUHU5Q2JzTWZKejNw?=
 =?utf-8?B?WkhMVEpFdDQxZ0RvL1cyZnVGb0tkVnI2K21nZGExRFlsRTRSeVhBVlJMbmlU?=
 =?utf-8?B?OE1pdjMyeEk0WHFGeUN0MzhTbUU1OFYyOWtkbTRna0FmNnVFTDJjTWxtVmlo?=
 =?utf-8?B?TzZOMW1lclBMU2k0QjdjTW1vUTB0SEpKYVJFbjh5V1pacGJMNEVzRkloL3V6?=
 =?utf-8?B?N0RvcG5ucllvRUpzdXNDUlZ6c2YwNlZneWUvZGdqVWtWL2V4ZlU5MmQrdkhH?=
 =?utf-8?B?clQ4Ri8wQVVJdVNlb0pmdlZTbXJTYi9kQUxaZGJHMnIzb2xYVWJyb1JGOGl1?=
 =?utf-8?B?WUkrck5SeCtlbnRGZGFxdWhMMmxsbkVkVzVFejVmOTZqZWxydEJHV0dWNjVs?=
 =?utf-8?B?bXBYWEZjM1RrL2pzWnZEdWkxZ2UrZGptdG9PSWlidVF5WUlMYUNUYytuU3dh?=
 =?utf-8?B?YWtOVmw2NDUreUxUM21LQzBQeFNmb0F0REs5OXZVWGZILzNKdDBNaitSb2Vy?=
 =?utf-8?Q?au9Ea+dxCAjtSnbQTk/lUcDh/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3906d4-f443-4f50-305d-08da6b52f013
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 19:55:18.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG2TEIEEa7r0b21ZKtELpJbKHW4wLxj32gY1/WXPnNTyNjHpV6Q0oEtsva+Erb9Ezr1UqvT9H7Hr2EQJogDayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2022 11:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because suspend-to-idle is always supported and on x86 it is the only
> way to suspend the system if S3 is not supported by the platform, the
> kernel attempts to enter low-power S0 idle in the suspend-to-idle flow
> regardless of whether or not the ACPI_FADT_LOW_POWER_S0 flag is set in
> the FADT.  However, if that flag is not set, residency counters
> associated with low-power S0 idle may not count and the platform may
> refuse to put the EC into a low-power mode, for example.
> 
> For this reason, print diagnostic messages when the platform should
> achieve significant energy savings in low-power S0 idle (because the
> ACPI_FADT_LOW_POWER_S0 flag is set in the FADT) and when
> suspend-to-idle becomes the default suspend method (because low-power
> S0 idle should be equally or more efficient than S3, if available).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/sleep.c      |    3 +++
>   drivers/acpi/x86/s2idle.c |    4 +++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -824,6 +824,9 @@ static const struct platform_s2idle_ops
>   
>   void __weak acpi_s2idle_setup(void)
>   {
> +	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> +		pr_info("Efficient low-power S0 idle declared\n");
> +
>   	s2idle_set_ops(&acpi_s2idle_ops);
>   }
>   
> Index: linux-pm/drivers/acpi/x86/s2idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/x86/s2idle.c
> +++ linux-pm/drivers/acpi/x86/s2idle.c
> @@ -423,8 +423,10 @@ static int lps0_device_attach(struct acp
>   	 * line.
>   	 */
>   	if ((acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
> -	    mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
> +	    mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3) {
>   		mem_sleep_current = PM_SUSPEND_TO_IDLE;
> +		pr_info("Low-power S0 idle used by default for system suspend\n");
> +	}
>   
>   	/*
>   	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> 
> 
> 

