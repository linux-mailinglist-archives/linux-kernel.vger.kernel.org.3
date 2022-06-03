Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9853C424
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiFCFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiFCFZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:25:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E4115706;
        Thu,  2 Jun 2022 22:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1A/bL5yEKBIgnr4bI0oROoUdU0B/R6ojXFeEW13LZbkpgIT0H60av3veHSVK40XoWBKL5Y6ouE6kMm3bdAY9CZRlO7B3/utc2gEX0OptMvEhhYNYH3Bcs5p+ZQLh8nNpMsZjAFLePnVJwKQ6PJc1s5eaEg6ovcLFQqduyv3ID9Bb1GcW182q0HHO0D/8qWrvM5o8/oC8tVZiM8OvRrNLKrWlsUeAe6p4mzm4zhCk7W4/7FajbRKM+UtvwWYlkClENmeATb+44imKEnGM2UQ+tAX3S5bMO412GKBRY2KW5IjxB3sSI378fcrMgTPv7Br7QgYM06+zqbHW/v3z6ping==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srYSZvdj9vTJVxaTh4oGYYcj33XQc+EN4SLmOCfCrU0=;
 b=FokeBQvHhe/51qS9Gvi7Q0p/zVFo5y4gULQ6Q7Ku1ScAgYUHdT/8DPKXrGJGSv/Xxz6FkTy/NRpqljzGHNaNwJTUvScofVLyhmlczgpBiOhbeRuM8Yc41QZHOQiCiLvOSUi9uft7TMxlNbphB3I+eDcvT4F5vXQnW336K0s8Upn/+D78++0KrfOPtA987nyyQ16SHhsbBioZ76DXvt7fgcutyPlKIFKjpt8OlVC/A4c9FVi3NfO3W+2vwu58O2JU69RLHhQicq4naKdQ6kGMDfuGNMoG3NONZH+NaVXTYbLS08Olu1EQ17rkVsriVYEeaXYua78+6qGr9Zy5I27F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srYSZvdj9vTJVxaTh4oGYYcj33XQc+EN4SLmOCfCrU0=;
 b=Ey3XGndKYfRaKwlJ0vPf20NeF37NPNERpicAUPMzFPYTgMCKmJAh5WvC9RvOsQ7Ohmiwed3P/OllIX1l5OzuW16CPZbBcvrGPep/TFw0TO9lpkW2DhDHHMtHQv4w8Rahbs55EJRuU/LISK7CMbKtEouQjoMlX8RftXyz02L7Vuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 05:24:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 05:24:55 +0000
Message-ID: <9135b529-0ec1-fe37-5352-a231c8604d80@amd.com>
Date:   Fri, 3 Jun 2022 10:54:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 6/8] perf/x86/ibs: Add new IBS register bits into
 header
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-7-ravi.bangoria@amd.com>
 <CAM9d7ch3UOgT0mcF6Sxde5dHUOS9ux7DwG7sE8+s5Das54cHzw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ch3UOgT0mcF6Sxde5dHUOS9ux7DwG7sE8+s5Das54cHzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::31) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a6e19b3-89a4-4291-6fb5-08da4521645c
X-MS-TrafficTypeDiagnostic: IA1PR12MB6281:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB62816EF4E7FD5162EF68B5C9E0A19@IA1PR12MB6281.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1chpjbh2Ch7KzEu1tT+HXfEayPi8aPE/le2R0TJJN8q0cuRcOXjJGz+7oPtmhgZtAbfLtj9z5fHPaYUf934I6pPCZ4KLNP65gpJveRpj8vd14etG/m81ve5bJlJyJWxfZYmYRBwXSTj94Fi1etzu3bKLLfNDzl6dDRvPJ+ZDId1WkfgR1e8OV9AAwT3z8pZI8Lu+gy1Umqw7n5yj2Rh5Ea1A4+fqXAKsDpjJHl3fz0AtENyZeOZFuS0apxnFuXQLsyQUErLT8wbWwMg3DmkIU1XEJudN7uIbfhREdwGKX/5Y2r0MrjXiE+qdQytpAidV0Znm0lBa0+mCH0JQc1P/VtDjawdx1xl0K/uZFk/Q5UbBcA4lEmW+APl6qDe7FRse5eVgxB8x65FRYkN0P4xzmXKfXK/D6QgDBporXd67lvkgwwl2ISJ6xDz/novv8HoTOgShTsYIZQ2jjIhCXtNplzJHKffeZX3bOYl2Yc0Z5glVfFfJs55nDGcUew60hubvmOl6s4yLU3ffQEoakAiUJcQFhRDYWIZWoz8Za8jq1q5eXS5euUgDo+F2hN3wOZrvqZ9A+8U/LCQ1kHuvyMDLr0MjUVTiUCxUn6BuY/4vPLUuCEjE8+sQ4U5zsWwJz7Fy+iHVNs9K9OB7AvWfoBZQz5FmzrRkwjKvQ2jxF2wEnUYJ9wAIyZflRexfg8T2TuX1ekdoCSmjRoizhiosPDPTEBlVqySrHpzwclGWXcxV6VrxnWOQ6poSSGfOtlRxUg9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(86362001)(4744005)(38100700002)(44832011)(8936002)(5660300002)(508600001)(6666004)(6512007)(26005)(6486002)(2616005)(53546011)(2906002)(6506007)(186003)(6916009)(36756003)(31686004)(54906003)(316002)(4326008)(66946007)(8676002)(66556008)(66476007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJLSEw1cHJDTkpyMjdFZi9sV0lEd0hacnFPUDU0WjRzV2JVY21VcFZ3amls?=
 =?utf-8?B?NCtIaGNQSk9OZEdYeStsS2xHMmlZOWo0d2lpTlczVHo1Q3hEOVZ0ZmlUZEph?=
 =?utf-8?B?aHVFSFlpTkNWcDhDRmZnVmNkeWx3cDJKM1JIdzlzWkNCVmFIL0pFNVVRMFpN?=
 =?utf-8?B?aW52ZWNDdks2Tmg3MmpWK3ljWmFuaTRkb3hqMkphTHZaTVkwT1M5VXdDV29u?=
 =?utf-8?B?SjBROFplb3ZmWEZaQTFOcVppZXpDUjZ5VUxVN2tsdnpnbnd0TlNQUCtTWkFq?=
 =?utf-8?B?Z1RxdWpPT0FBNVF1L1JqZDVSd0V0ekpnM1NlTnBzbnlTMlZrcGd5cWxzU1Vu?=
 =?utf-8?B?TDdJWldQMlBJa3VYMnZDeXVkbzJXd2pDWitEUms0L1hFWlRTM3pScWtFZm4y?=
 =?utf-8?B?ZWpaSFRWVG4wVXpSRFFZZm5tL3AxNXM0S3hXc2lMSFBiWHNsV291QUJqOTBR?=
 =?utf-8?B?NVg5cDVObDR0MGZWemFlcjlIVGhzMGgvRzF6Y3RCeGdXLy8wTklRbjdvb1FX?=
 =?utf-8?B?UTdCWXMxRVVKNDUvUHQvNzcwd043N2JYYlRodzdPdmp4ZkdRWW9HdnFFYktU?=
 =?utf-8?B?UWNlV0czNWZoWHdPM294d0RUWURGYXZmcGhBN3ZxZTRYVHYvcTVYQ2hmTitz?=
 =?utf-8?B?bXBtNysweVpJVkQ5Zm9IM1pxTDB0MkpOOFF5aXI1eTF4NVZJazZTNWVZcnlH?=
 =?utf-8?B?SVE5ajI0NzV5OThmbEFSU3VmR0l5RTVQNGdKbjJoVitKVVRIRXNpaUQ0RnZ1?=
 =?utf-8?B?dlFFOUNXT2cwS0h1TktvdHl0QlByeGJrbkQ0d0c3SmZyeW1FYVl3Vi9ueiti?=
 =?utf-8?B?ME1pTHYySWkwdFVCRlFtYlVUOTFHVVVYd2NGVDVsZ1BrNlg2ZzZ5c1pvY0F5?=
 =?utf-8?B?UGRraFAvU3liem5lNitjeUcra2l1d2w4OWVYYU5GK1NSYTNZbjZUZWdNOGFG?=
 =?utf-8?B?T1FZQnBlYmtpcUFuZzFPWXNVd2tvb2dOOGFmL0NMRGNyWW12MnpOanpSQ3c5?=
 =?utf-8?B?YmdCVXhybmFJVW9odzZXcUptaUlqcVZzTFlYdVkvOFdzeUZJR2E0WnIrZ0lJ?=
 =?utf-8?B?QXowK0NsaGlyamU5WWFvUWdEeUdxaTdMelNWME55QUNFR2JXVkVPbDBKZXl4?=
 =?utf-8?B?V1BDcDJhei9TWHJTeHljY2tnWjJtdGZ0cDNlbHpGWUlOamRJYmFXTVhJdmZL?=
 =?utf-8?B?cFhsYUFIOU1ObjFVcDlCUnFHMFJRa3hBMVdZaWhXTUVUVWE4UHh6ck1nVlNS?=
 =?utf-8?B?N3JHLzJwUlNoL2pzdVc0dVczOThETnNGOGNjdm1FUXMzL1NoNERrSzdiU1Q5?=
 =?utf-8?B?eWZxcHJwZmhGeHFPMFBiRXhDTTEwV1RFSWQyd2crNnBNSjJpdXFPWnFQQjRU?=
 =?utf-8?B?aXhTNWc4cXV3R2ZyNHp1Q0RVeFhWUVYyRG5hVzBmaVNDVjg1KzNwZjFPSlBq?=
 =?utf-8?B?TVFHVHhQMkVjTi9PUjJKWi92WWRSY2x2YkgxTFBYZXA4YVpJTFhKWmRSNkRu?=
 =?utf-8?B?NDUvcnFUNUNuVTU1TUo3NER4M2ZXMXRLNUVDU1BsQ0FweEM5elErY05tYmhK?=
 =?utf-8?B?bjJmMG9pajd4a0w5aml2a2RCcHVpbjBZNE4xRk5LRUtsNVBlb3pqTExWQlpR?=
 =?utf-8?B?bU5GU0FWdmp2S1RlUjdobnUvd0VDSFZ4ZmdpVjdDbUNqY0g4ZGhVb2NCOXJL?=
 =?utf-8?B?UVZMNjZCNC9KUVMwVEgxdE5nSFNtUHR6eER0OE4xUmZMQmlvSTQxNThCODFw?=
 =?utf-8?B?Q0NDQmIvYWFPMVdWd2J6eDZxOEt0RTdORSs0Y0t5c1dFd0thZCs5a2puSGVl?=
 =?utf-8?B?YzNocjhvTXNwSHFZcG5McDJKdE5CanVwWFpvUXp3ZWlUR1hnQm56T1licUhW?=
 =?utf-8?B?YmVuNVhNTXNuR3RWRU93MWptM0tUeElyQmIxbFBFY0NBTUw4SFp1MzV2bGVm?=
 =?utf-8?B?dU9tUGN5NDk2YmtTQjNkMFlsK3RGc2MzMll4NUVCQTlhcmVGcHpGamNKY1pw?=
 =?utf-8?B?Wi9PYjZqcjBzcXUwdzlhTTZpOEFwak5NMHgveEV4cTVsNjBDVlhGeFZFRDh4?=
 =?utf-8?B?ZWQ0Z21CejdBZHlsOFB6NSt6WUhDVVlpbUdQNnkrZ3VnaW1lQlYvSWtpZUxT?=
 =?utf-8?B?aFp6WG9aNm96Y2ZrSkNxbFc3Z1EvWlExbmV4ZXpXOXNrK3ZGL3ZpRDNKUThs?=
 =?utf-8?B?WFNKWjRod2hZRVJxZStFemwvK3c5ZzBDZFhEa2x1STBBUlMrd2tEcHNQQkFl?=
 =?utf-8?B?TFZialJTTzQ5N0h1cWEvVW85QnpqQjFrL2pCWEJWdXJyU21XN0VqUWxxOW9U?=
 =?utf-8?B?YVREaVN4am5kTmg1MXhsZmpGVHhrWmIzU0JlbmtYclZSS0lBL2krZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e19b3-89a4-4291-6fb5-08da4521645c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 05:24:55.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woVwH/aZSU66MokEKRZtWpYzEeCguErJNAl8etc8uI4oHA2PtiW7346o40kpwThBrZpdJxFpxzeHodTEqdiK4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03-Jun-22 3:18 AM, Namhyung Kim wrote:
> On Tue, May 31, 2022 at 8:30 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS support has been enhanced with two new features in upcoming uarch:
>> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
>> has been introduced in IBS registers to exploit these features. Define
>> these new bits into arch/x86/ header.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Acked-by: Ian Rogers <irogers@google.com>
> 
> Isn't it a part of kernel changes?

Yes, that was left out because in the initial versions I did not have a
separate patch for kernel and tools. So Peter might not have consider it.
In any case, the changes into this header file are not used by kernel
atm. So I'm fine whichever way it goes in.

Thanks,
Ravi
