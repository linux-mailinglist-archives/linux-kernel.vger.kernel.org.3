Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07C353088D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiEWFDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiEWFDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:03:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230FB3E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoKYGde95Il34Gy12YO1BFnzaW6VEu9VFLj7XZ1QSHxfmQ+X0Itr+iYmX+b8t74nei3TxFzwswEhdO/I5tKbrA0GHsy36biGYX/BHKYyUn2Kek8l9PEPuv+b5uqAwg+CLuv8osajQ7rFSLs93gUjVXnwCrtBKG9zQnAMI7b8HDRT0iu82JQK2KOBXdkKWE3hJ+9Ze49h7/wc+hNInIs2qLBqb0/9PL2gLHA9dvtpx3QNpXTSsVn4y7hYzNPalcCQK9qI+ct26+CZ+NOHcRd/fCCJ8jldGHtGj9+zks1RmEFU9LSfWRcdAlp4/kw1PjUoBM0bmBMY6GNqZFnlgb67Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIEV/gFS7/PJOsc4LJ51t7I20FHlqf1tq9YJp9VloJ0=;
 b=KvRIfrwLnCFhEiGtxNKaecn1OFzR8Jpd7W0bO6ZJb6mu/bMS/ZXf1bGI4rOr/8JjIj1gZmYgJ/NJ3iCrOs98DKEPOefPE28XtT07nFwpyTZMzWzYyvFPvyU4bqpO7wTEBfl/sa6xXncnKsTxsOPO0ZlWzZ/TNTE5SinG/3/sx0B17jfe4goiL05VId/3X45AF4/OsVmKzsirecmG2dTBE15vkAkvzQWmnFKn5BwZgfzFNzJ6rVF8SPV6DC0ZESX3gq2Qhtsg4X0bvDRY+l5mF0ovMQ7S2oAndjNCf5oJn6IskzDzTrydCgFt3Pkl4ioQg3QVVZEXv8jxGAs9bgRhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIEV/gFS7/PJOsc4LJ51t7I20FHlqf1tq9YJp9VloJ0=;
 b=JH1w9gJE2+5QxpReGvJ0WcmRJEVtLceulNa6uCjF4K8AU+p6+sMEQ6WJ9bNHanDMBq+NGC6TvErMj/EY0bhrq/FDbfhxEelYU7aC68P1OpkDrZw/PZH0/OGqR2g26zwrMbh4v+NOnqyUqrf+eECoqIPCI0WeB2EUqShbV5FYsz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 05:03:08 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::6c89:168a:a0d0:2f8f%6]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 05:03:08 +0000
Message-ID: <9c50a737-3e3d-71ea-2722-914cd89c9a07@amd.com>
Date:   Mon, 23 May 2022 10:32:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] x86: Use HLT in default_idle when idle=nomwait
 cmdline arg is passed
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
 <1b24cadcf1d86a91352baa13905218015b9d4fed.1652176835.git-series.wyes.karny@amd.com>
 <a2fba1bf7cf0833372a825f626c12502a44a660e.camel@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <a2fba1bf7cf0833372a825f626c12502a44a660e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::32) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 971e6d98-a403-43a3-3713-08da3c79869b
X-MS-TrafficTypeDiagnostic: PH7PR12MB5879:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5879132CFBAC3ABCCB23585384D49@PH7PR12MB5879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sakqYrsoa/ba+peFP8Qqnen6LCtsZ5vVrWfI/xHcNtcv28hyOIYkeEgXMHUhykcm6tdd+icLtDnDfgRZYnKndi9k7B22oQojH+294W7t4dxdsVpGVMoqF5ocfITkRKDyRH9wuE8WUahAXCsqQeT68GMM7oujMcxz6rNf1dBSG1r7qooIMMsGikUMSJKZFi4tOH6SwxAKbfdHGm/FHcKZvGvZ45WcGtTNgokkH1v4+/Z8Jpkp7WmPdSpZYlDKNbFkH+omWFE+HH2e392/4ftyMBdOIX1exqUFLmWXtFO59gkro28oy4rDiSF5/gr4gFpI0+VpLI48wCowC6P0eqtl/WTLHYo/bqeM/4qvoWxvXgOuVk+JDmSZ6JLRBn/v2WQmgU7R3K1nPNexlL5sA5QoJvvkACkVGULjoSsnyR/wG8dp0YaSoeNBpjUnMl6+HACT+aXiGUHRpRSYBP+G4jqwzbnXOviihWueMKPnvw4Tqetzl12debnHj9O3E6BCxEASH0ZBY1Q7jiiNP0t6h/G9QSmip+Mr00lpDdT1AnNvodwMPAUvPDB5n917BOvEuvYbaybqs23IOXnaMzJpY0Alm/+DlKIhAizgJV3/SAcxW4uvrJZFPlnGyU5fp+svdBr1OM9iu+0nynXiFsba5gD4xi0LUtpRGz3CorAtTGGHR3R0tTxNyyQTPU4BV8rjyJf2NDnInEArVYs4d7IxelecPoRI3aipP6mMfq1DTTd5xfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31696002)(66476007)(6486002)(2906002)(66556008)(66946007)(5660300002)(31686004)(508600001)(186003)(44832011)(26005)(4326008)(8676002)(7416002)(8936002)(316002)(53546011)(38100700002)(2616005)(6506007)(6512007)(6666004)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1sQUZlNDArb082Ny9uck12STVweVkrVzJPZHVxSGRkMndKa0VNY2YwNUpx?=
 =?utf-8?B?S3l4cWRMZDdZeHZjYTFOUG8waEtTT0hYaVpRSnM3dmVnaXJVNjJINmlzREVI?=
 =?utf-8?B?bHpMWit0YVlyYTFEZ3RnQkJsS20rN1Z2WEQ0aVgzdVJlOTZleFZGNEFYZGZ2?=
 =?utf-8?B?VmNCWm1hSXVKTk9tem1CdzAxRVM5N1luQ0F3ZThtOWM0eHFnOTV1YXhzcHFi?=
 =?utf-8?B?WGxhS2IrNnU1WWhkd2JRbjMyYWxsMGk4dCtDRzB1blBxcks4R0FsODZVd3RX?=
 =?utf-8?B?blRqNnFjeE9DTk5odDRvQXBwR29KV0Vpa1BtNGlCVkV1WDFxNnBmUHB1OGZw?=
 =?utf-8?B?SUxKM3ZNblhiMzFuNlFuU05ZL1VKdlZBbnBiaUFVSXRxYkxPTnhza3pwc25z?=
 =?utf-8?B?SEp4VUtwOStLQU1CN0tnUSs3SXhEVXkwOWdTUURrSys1ZVJiaGMzdFJLY0Rt?=
 =?utf-8?B?MGZqY0lWMjFzVS83bmFGa0NyZHZWTXB6M3FEVWxHZGdER2Rpc21EdG91eXJR?=
 =?utf-8?B?WXNCWFpxZG9OTExObzY5MzBicDFpRnVQZXZLdzJkRWRKWEszZjVOM3hSN0xV?=
 =?utf-8?B?NTZ6aTR1ajVybzVudFhZa3gvQzBqZ3h0RmZ0eFpLWUFOaXNPYTZnV3NjSDVM?=
 =?utf-8?B?T01Lc0FoRTFMM1U1dXRPZjZFL29xTmtrKytEMkVBdTZabk9HSlpUam9KTENv?=
 =?utf-8?B?WTMyY0VQR0RpZ3F3dzQ3M01kRjhQZWZVdjdrYmVWdXhWQlJiL09oeXdHVjVY?=
 =?utf-8?B?R0NsYnpLZHl0SDVmNmRDUXNGN015RnVuTFZrZ0dFVUp1eFhRUVQrWExTWElX?=
 =?utf-8?B?ZnVZeDN0TUxKMHVWNjJQeFE4eGV0dlNUNDFHQmRVRldZTnhGSmEwNEpib2gx?=
 =?utf-8?B?Q3dlSFNtTVBXa1UzUjJxNW5wOGhnd0duT0Q3VVZ6dm1LN2lFUUkxQStkTGh5?=
 =?utf-8?B?eE5ZV1BFTHlSaHRpK2kzS00wYlhITkxOYnpmSHM3Zy93VUtCRGdjMENvYlQ1?=
 =?utf-8?B?KzZMUitsSGdQT0dXQURvRnptb3N5MHRiMXJ0YVpYWUpEbmpYeFdDN2NRWFFP?=
 =?utf-8?B?K3FQODMyblB0S2JrZ2poMytnOHQ5dHBRc3A3d2VFeHNBSFJlU0pDWFdIVTkr?=
 =?utf-8?B?MTdadFZxYVZPTXh1WHVmZVBkdTRhaEV4Y2pjOHFkZ3FyR0t0ZEozNHJNbS9R?=
 =?utf-8?B?UFYyM3BFalZLVUY1OU9MRGdhZ3lSWU10SWIvZ2ttUEhEVUxiTy9JZVAyT3RN?=
 =?utf-8?B?UmVFZVNTT2llVCtmOFdrZk9VNnRabTBnQzc0TE9UdjhLbTl0RzB5eklCNjQw?=
 =?utf-8?B?eTVrNG54RVNlR21PaHIvUWRyUjhSTUpsSXEvdG1ueCtZOTBMV1JmSWdvZG8r?=
 =?utf-8?B?RXg1SkI2NkJKNzJiZGo4V2xvdVhHMXNPZ3p5WU1IbFUzM1doZ3FYU1hBWVBq?=
 =?utf-8?B?L2FKeGhvaFNOSFdSazY5NytEV1cvd3pwV3I4K1pNV3FCSnFheldlaTNiYW8v?=
 =?utf-8?B?MVNVbisvY0JMUTQzaGZMVWhkR2twdjkxMXNZTU93WUdnMFdUbFM4a0d6d2FY?=
 =?utf-8?B?VTU3ODc2dG5NQ3FuZkduVG9PcU12YStQR2xQWkJ1QVlTdy95eGdsQi9id1RX?=
 =?utf-8?B?WERLV2lZdjZVaCtIQmVjL3JySUU4VmFyWTAvUjFMbDJsS3F4TUR0U3V1QVBz?=
 =?utf-8?B?M1pBWTRuMVpyWmNHZnFUNnpKRVhqRzV5YU5BSFAyRUFuY0pjazFFWkFxOHZ3?=
 =?utf-8?B?V3RuVndSUWJWTDJHOExmQS9xQ3lzUEkxSUJJSXNCUVBPMEJ1b1k3clFhVE9E?=
 =?utf-8?B?MDFLVEpyMFF5Wk9tTnRXRHBlQVpoZGJ6bnUwdk45WUxMdlJvSHk3Szd0UlRV?=
 =?utf-8?B?UDZSNGUrOWlsRGh0eUlVM21kRGtBY1ZnaXRmMjJZM2hSVTYwVUNQd05NSVds?=
 =?utf-8?B?UlVJVTFlWFZKcnNHcnYwWi9qbjRDM2hFZmdUZ29ISWozMkZpdTQwWlRHa0pF?=
 =?utf-8?B?Vk9OdTFobkZoSWJXczdVN2lDRVd2WngzUXFpakpsck1vaEJENlBpaWJGSzBy?=
 =?utf-8?B?RUVFek9YZVZ4cjdHZGg3WXpNU0QvNnJtb0NtV2lIbTU4cDBoR2dZQTF5ZmFa?=
 =?utf-8?B?UjNUdm9ieEo2OWdxMThuL3d2WHBlUXl5dmZGc1M3Y1doZGNXMlpWVlFOQVFv?=
 =?utf-8?B?NzJHdnJhYlUwY0Yya0dONWVnZjNPTDc4WWRuY1ZaT0xVakx5Tk51amZIaXNr?=
 =?utf-8?B?RHZGME5XM3M1dmg3OE02dXlFZWl3QWVtY1hrK2RramgxNk5UT2hRdXU5V3NL?=
 =?utf-8?B?RWMwWW1BQ3UvRHpQN2NzTE5HTUYzTVdrUFFlcHhwKy9yYTFtSGp5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971e6d98-a403-43a3-3713-08da3c79869b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 05:03:07.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zWZADcrrBp1U0QI3PXCZSpoAaS/5UNcHkvX2S9itFrmHR6dmb/uMsNFoTD5gI+S26h3poAxjFP1iKTyWSF6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rui,

On 5/20/2022 9:08 PM, Zhang Rui wrote:
> Hi, Wyes,
> 
> On Tue, 2022-05-10 at 15:48 +0530, Wyes Karny wrote:
>> When kernel is booted with idle=nomwait do not use MWAIT as the
>> default idle state.
>>
>> If the user boots the kernel with idle=nomwait, it is a clear
>> direction to not use mwait as the default idle state.
>> However, the current code does not take this into consideration
>> while selecting the default idle state on x86.
>>
>> This patch fixes it by checking for the idle=nomwait boot option in
>> prefer_mwait_c1_over_halt().
>>
>> Also update the documentation around idle=nomwait appropriately.
> 
> I think we also need to update the comment in idle_setup() as well. 

Agreed. Will update. Thanks!

> 
>         } else if (!strcmp(str, "nomwait")) {
>                 /*
>         
>          * If the boot option of "idle=nomwait" is added,
>               
>    * it means that mwait will be disabled for CPU C2/C3
>                 
>  * states. In such case it won't touch the variable
>                  *
> of boot_option_idle_override.
>                  */
>                 boot_op
> tion_idle_override = IDLE_NOMWAIT;
>         } else
> 
> thanks,
> rui
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>> Changes in v3:
>> - Update documentation around idle=mwait
>>
>>  Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
>>  arch/x86/kernel/process.c                |  4 ++++
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpuidle.rst
>> b/Documentation/admin-guide/pm/cpuidle.rst
>> index aec2cd2aaea7..19754beb5a4e 100644
>> --- a/Documentation/admin-guide/pm/cpuidle.rst
>> +++ b/Documentation/admin-guide/pm/cpuidle.rst
>> @@ -612,8 +612,8 @@ the ``menu`` governor to be used on the systems
>> that use the ``ladder`` governor
>>  by default this way, for example.
>>  
>>  The other kernel command line parameters controlling CPU idle time
>> management
>> -described below are only relevant for the *x86* architecture and
>> some of
>> -them affect Intel processors only.
>> +described below are only relevant for the *x86* architecture and
>> references
>> +to ``intel_idle`` affect Intel processors only.
>>  
>>  The *x86* architecture support code recognizes three kernel command
>> line
>>  options related to CPU idle time management: ``idle=poll``,
>> ``idle=halt``,
>> @@ -635,10 +635,13 @@ idle, so it very well may hurt single-thread
>> computations performance as well as
>>  energy-efficiency.  Thus using it for performance reasons may not be
>> a good idea
>>  at all.]
>>  
>> -The ``idle=nomwait`` option disables the ``intel_idle`` driver and
>> causes
>> -``acpi_idle`` to be used (as long as all of the information needed
>> by it is
>> -there in the system's ACPI tables), but it is not allowed to use the
>> -``MWAIT`` instruction of the CPUs to ask the hardware to enter idle
>> states.
>> +The ``idle=nomwait`` option prevents the use of ``MWAIT``
>> instruction of
>> +the CPU to enter idle states. When this option is used, the
>> ``acpi_idle``
>> +driver will use the ``HLT`` instruction instead of ``MWAIT``. On
>> systems
>> +running Intel processors, this option disables the ``intel_idle``
>> driver
>> +and forces the use of the ``acpi_idle`` driver instead. Note that in
>> either
>> +case, ``acpi_idle`` driver will function only if all the information
>> needed
>> +by it is in the system's ACPI tables.
>>  
>>  In addition to the architecture-level kernel command line options
>> affecting CPU
>>  idle time management, there are parameters affecting individual
>> ``CPUIdle``
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index b370767f5b19..49b915d1b7b4 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -824,6 +824,10 @@ static void amd_e400_idle(void)
>>   */
>>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>>  {
>> +	/* User has disallowed the use of MWAIT. Fallback to HALT */
>> +	if (boot_option_idle_override == IDLE_NOMWAIT)
>> +		return 0;
>> +
>>  	if (c->x86_vendor != X86_VENDOR_INTEL)
>>  		return 0;
>>  
> 

Thanks,
Wyes

