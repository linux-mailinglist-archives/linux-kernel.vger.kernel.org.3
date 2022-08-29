Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAC5A4FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiH2Ovy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiH2Ovo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:51:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181D92F69;
        Mon, 29 Aug 2022 07:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKUdDoExwAjRxA3EinklrqDXaEfmhVV+O0UcxFY1gr2J5lpKrQoRR4VV/xiKm9LBacw7oP6g5VEP6BATPJ3yN0DaNP+0lUjztF5YnN/Fxx+HFlNN3LtqCHGzThOAPsXE7l5oTJ5g2MC4VdxMC3bD6POhUeoCTEHSwm6/RTVoevH7NSbMBPVhMk5/+EE1hvGtUF5EaoXvlJnI/jtRrCs2NFmRNyn9IPP7ijw4Y6QEsk7TbpA/W9yl7zYbzZlH6FSl8TfzyN0c5wEv3dskIqhn9Pa/rYE+ZWW+v8iBZyPkm/OMcFKc7ao0CBPnapYmWpvF847JFVMmC+pipj+E2AP5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+hCoGrXC2PLfxaOGnOgRPb7E+sxGp40EFoucNZjCK0=;
 b=NA2MtJA+IFwQeuSbiD2wpnQR2YoACX29ZOgyPKVT1Pprx/oQTvz/2ERjEI5R80gTvCTxJ+6xI3O8KnEVA4J0+jD1JK1G2wQANSKb7o/PQe6O0yHgNu52msnkBJO/eeIPngoIg/JsSK6/CogXi31SU8HS18dsbLScRcdYK0nhRScvdNeMDx1owKbqNHG/4LpWAQS8ebjIEANHg3TsN14gIfsUgI8LuuCWb4Cb9RVkyeq5zlGb5JgIka/sJX8boW8DBe2lhgFM4HZ+Uh0RuI0Gnlp6iJZywrPKZYum1QyFPVMSqLa1xDaIAH24Urbw5FoKBYbP2hx5wKCFM6tky5x5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+hCoGrXC2PLfxaOGnOgRPb7E+sxGp40EFoucNZjCK0=;
 b=eBlLBLUshN4iS6sp6aCYTvETMvnxrdoB2korjO0YFwXJlK4BmpBibP09AlrlIJFS/l/jBIOjrw120+FKDHmwU9gMNKsNBLXIWBgH5ZR2Wy7j/xVzUKAkmCZ5HZb2tvEo8ICVfwAmJAAZPRwMkBYKuCMcOywgcEDd9C+cDx+18Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Mon, 29 Aug 2022 14:51:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 14:51:37 +0000
Message-ID: <e10210df-1741-2852-03cd-73658795e62e@amd.com>
Date:   Mon, 29 Aug 2022 09:51:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/4] ACPI: s2idle: Add a new ->enter() callback for
 platform_s2idle_ops
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220829132908.5254-1-mario.limonciello@amd.com>
 <20220829132908.5254-2-mario.limonciello@amd.com>
 <CAJZ5v0hfYhNLp+x9iFiqsQaL4XA8QdFhRK7Csgr8po8JPoimyQ@mail.gmail.com>
 <a0a63b87-f1ec-03ce-0c3c-a66d7c8144b0@amd.com>
 <CAJZ5v0hauoY0xDJqDUQwbY3kz6o7irELtvbYs+ruyMu_MYQzdw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hauoY0xDJqDUQwbY3kz6o7irELtvbYs+ruyMu_MYQzdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0370.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dbb36f2-9992-4352-cbb2-08da89cdf9b3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMdKGmTMqkw2ptP9x0q5lWmJyidGJ7QvUgdF68ewkmVhmecVWLPNUdPWnzKbEx8T2yrkgJ9ljpZhOHsb5Et21WEKGsqU7puCleWL+u22Vll70RqlWOdJ2oGmEdVGBMDMhUi7SHgBRl5NpCT3e4XUIYy5KYB1ZY19YodRK58lNVamz/VwQzLTyZZci3oD8KzHp1I0LT84fPZVQAxFNcsnJEjV0+JLDdUkktCR2EWU2hEFe6cEvi6n20FK0lqYX1WZIel6NhREoEf5PQPiv31GBVRZhETHGxjboXo9sXWHlBnM9xU71orXIAyGZ06bu6S1wlhVXvvJ4h/7gccJo+8eFvxGMEhmdw/pgE9aBkNChW5+CiSd5ider11T1Q3exXDeZM/1Qk1p5K7qvi4+utXP/Vx2BAYR+emyk6vxFr1qUmlr0ar51sNYsEjYD0951dyhHXHb/KMuNXq+LyAPVj+Uo4fDsCco9HONjyz4JkSPz5zHOshf9Ys53xfXuap3ERf8W3h4A5XR60GVRKZg8lfDXnP3lZMVOkWz5LQy6W/8YYxBpImCk/WYoHH0IK3fZ8aFUnYBslUCP3U5w31ae6jF7pt5VI0SgXS9o9O+yS16HyyDW5o49UQLLwOwwdS9gFnGvIVfoHWJWc0ZHPDUOiPyU/bwFkYVMcT1X5YInCDvjEbGRCgEqqzDRJhJcONYO2udUPyjsVmK+fL5YXCXeAt5dQ6oDAUuPjlJAjW6aItFC4/f1X6Uet0ez2LVbX5OlZHWhzXi39m7fy/07I36H0KT0CLxLdgxXCEuZJNPG2eZv2zRPmG9vSyDOCOmJiKt9FxXg9/PGK5DsmNvrPs7HE2QGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8676002)(4326008)(966005)(478600001)(6486002)(38100700002)(8936002)(54906003)(6916009)(316002)(86362001)(31696002)(66556008)(66476007)(5660300002)(66946007)(31686004)(186003)(2616005)(83380400001)(36756003)(53546011)(2906002)(6506007)(41300700001)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVnV1BacmFSTGhDbHJUM3Jlam8vTTFaaWFnVHdXR0tndHdvTVBYOE5Pd1NS?=
 =?utf-8?B?WGNyR2dyRFRTblpZdU5vOUVmSVJmRzNzenFLNklMY0pZVDhCeXFOSzBNcFZR?=
 =?utf-8?B?V0t3TjdxenJuWjdiRzZoRG1vSFJkNEhLUlcyc2Q3VUMwb2lZVXhhQ3FHL1pX?=
 =?utf-8?B?MVJ6cGMvN01NQWo5eHp0UStyS0dSRmNZNUlGK0M3UnJIRGt6eFp6bytNdFZD?=
 =?utf-8?B?N1RrVmk4THV3REZOdWVIOHBDYUJMUXBtVVBsOHlVaHByWkJkLzlSL0lPZjA0?=
 =?utf-8?B?dzNmWXJFWDVmRXdoVTczc3ZIUWNsREJUVENaZjdhV1BrSERMT1B3elRLTldP?=
 =?utf-8?B?NGpTODdvOFJKMGdVbCtWWExYazJVN1N3TnZSYWZzYXlqR0F3b2hHZVNYMXhw?=
 =?utf-8?B?OVN4ck1MdTczSzB3Q1BweFo1L09LeUtiS3BkYk9TZXAvTTQ5TW03cW1RbGs4?=
 =?utf-8?B?ekUwZkQvOVdxQVY0MFU1cXNDZ015dUtaWXJiZmRmYnM0YVkyZTJhMm1iU1dF?=
 =?utf-8?B?aUZmdFlGYmdMaWZsbVd6ZlFielpIanhNZjFWZjlQY3VKZ1BVWDk2UU16eHlR?=
 =?utf-8?B?VzlhUGJQcEJ5akEvZU5yYWVMcTlJOG1CY3kzUUxnMVZKUE9OUWpFYWxvTGxo?=
 =?utf-8?B?enRVTUM0SnZaTlBpcW10Tkp3N0xHOFN6L3pDYTBXbzEyZXJOY0hSc1JJd2Q4?=
 =?utf-8?B?THJxdGkzeGNVb3k0ekUxWllxRnljRlk3T0xpV0w5QlZncUk0TEJWc09qL2JK?=
 =?utf-8?B?NWtJMTMvbHl1NzQxSzZSWE9JTTM1dmszSXhBUzgwMlA2WXIyYkk2SUtzb09h?=
 =?utf-8?B?WFFaWTVweS82Vm82Ni9ZNjhtTWZwUmgzdDYybUQ0d3JkRmRHOFBwUkhSL1A4?=
 =?utf-8?B?dnhaOHdMcUpsZmIxVWE3T1RBRGVub0JiRndjOVdJUVo4Mk1vZm01N3M0b3lE?=
 =?utf-8?B?RW1rZTZLUmp5aGZ1WEFpSWYrS2tRSG5nQ3JibmRpSUZxaGtnK1YwcVhRN1FI?=
 =?utf-8?B?OFl0VURYaHAybjJsTk1zV21BeGxWdlB2S1Blb1ZiYlZXdStXZGR2UXYxNjc5?=
 =?utf-8?B?RXpOZEhtZkx3RHdaaUp6c0YzVlVVNVVnNXFsVm5KTG9qcGZqYXdhcXRFRkdo?=
 =?utf-8?B?UW5xSUVoa01pS1hSeXdwUVY0b2NBclVsbC9TaUVXUnR6YjFzc0VVN0ExVUNU?=
 =?utf-8?B?a1lKenFOUEV2anVWSm1tUG5ZVURycjVKbE13WnZLUi9pSGV5MGxoL0g0L3Fx?=
 =?utf-8?B?NTNZUmwrQThpMUk2MzdpZ0ZZVlBvVGd0bE9ERlVtUU10MnJsampkQU4yQ2Fw?=
 =?utf-8?B?QXRESXBnZVdIMXFYdVg0ZGZGWXRGNWNLZjl3UE5jVkFrRFkra1RoRGRvbEJa?=
 =?utf-8?B?L3d4LzZueVpWeU9YdTJKSGdLeWVNUzlHeTJrWEkwcDE2alpBaHZCbVkvZmVi?=
 =?utf-8?B?Qms5c3EyN2tnTEV3VmR0TG9RNWYzMExJSlU5Z2F5UGxXNU00SGx4RkhIaE14?=
 =?utf-8?B?VWsveXoxQTZhL1lPN3hpYUdDN1M5NnZ6OGMxc1ZhWE9iVGhQY25ZZW1rb0pU?=
 =?utf-8?B?SXVyYUovZUgwRHJTMWVlVjVHSUMydkpTNXRsUVpEUFQyRXl6WnRFZHdlWHB6?=
 =?utf-8?B?REhnQ29rT0FHWE14YlBaTlFHNVdxSnhIaFEyb25QbmY5VWhnTmNCazViUkhC?=
 =?utf-8?B?dlYwT0I5UTJabEJ6dUxMY205OXNMWkZ5VDhEVmllcXBnNStZUjl3QU1ySVBQ?=
 =?utf-8?B?czJJSzJWYkdIQjA0M0NOYUJDa2pJT1lNSXpybDB1MVJCRlV1UUNJV1VQNGhw?=
 =?utf-8?B?Rk9Ba1k4RUhyTmVyVkI1MHFUNURrcW1ieTZxZVp6bUkrRU5YeE00d2V1MkhW?=
 =?utf-8?B?Mmx6VnZEV0xnRitLQzVjNTNGeTNWdXovUDNmYjBmWGRIa2FSTS9MUUZhcXN4?=
 =?utf-8?B?QXh6ajc4bVYxWm0vOTM0Z0p0SDBlTjF4L2htNlZ4NzlFeUlhdk1CeCtmVXNn?=
 =?utf-8?B?c1gvTEFYait5T1VFVm01S1N2MGpnMElpL0Jaa3d3WFAwdmdSbUk5UFhzMkVZ?=
 =?utf-8?B?VVkvZnEyck5qaHR6dXFhZE9BTFFaZHZiRHNyOERJMlorM1NybURISTE5T0lh?=
 =?utf-8?Q?SC40nTA4v6QQC408vj/y0vQFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbb36f2-9992-4352-cbb2-08da89cdf9b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:51:37.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QraLv6/gEH8bwsaEBxrMt4uGTj6qFMjTuvg9W1kSaDUwViv/cDyU2RGJ40VuO0+A4S3spKG24MdSGFAaX1Kihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2022 09:40, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2022 at 4:32 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/29/2022 09:20, Rafael J. Wysocki wrote:
>>> On Mon, Aug 29, 2022 at 3:29 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On some platforms it is found that Linux more aggressively enters s2idle
>>>> than Windows enters Modern Standby and this uncovers some synchronization
>>>> issues for the platform.  To aid in debugging this class of problems in
>>>> the future, add support for an extra optional callback intended for
>>>> drivers to emit extra debugging.
>>>
>>> I'm not liking this.
>>>
>>> If you want debug, why not simply add it where it is needed?
>>
>> Actually this is exactly where it's needed.  The synchronization issue
>> is with what non-x86 is doing while x86 transitions into ACPI C3.
> 
> I meant directly, without adding new driver callbacks.  Adding
> callbacks for debug only seems a bit excessive.
> 
> But I guess the problem is that you need to ask the PMC about
> something then, don't you?

Yeah, that's exactly it.  The code changes there won't make sense 
generically.  I suppose it's possible to make a global symbol and only 
call it in the AMD case, but this approach should be a lot cleaner.

I did CC you in the other 3 patches in the series (in platform-x86) so 
you can see exactly how it's used.  Patch 4/4 is the one that uses this.

https://patchwork.kernel.org/project/platform-driver-x86/patch/20220829132908.5254-5-mario.limonciello@amd.com/

> 
>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v1->v2:
>>>>    * Add a prototype for `acpi_s2idle_enter`
>>>>
>>>>    drivers/acpi/sleep.h      |  1 +
>>>>    drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
>>>>    include/linux/acpi.h      |  1 +
>>>>    include/linux/suspend.h   |  1 +
>>>>    kernel/power/suspend.c    |  3 +++
>>>>    5 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
>>>> index 7fe41ee489d6..7856930a7da9 100644
>>>> --- a/drivers/acpi/sleep.h
>>>> +++ b/drivers/acpi/sleep.h
>>>> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>>>>    extern int acpi_s2idle_begin(void);
>>>>    extern int acpi_s2idle_prepare(void);
>>>>    extern int acpi_s2idle_prepare_late(void);
>>>> +extern void acpi_s2idle_enter(void);
>>>
>>> And this name is confusing, because it suggests that the role of the
>>> callback is to make the platform enter s2idle which isn't the case.
>>
>> Can you propose another name?
> 
> acpi_s2idle_check() or similar.

OK, will plan to change over to this name for v3.

> 
>>>
>>>>    extern bool acpi_s2idle_wake(void);
>>>>    extern void acpi_s2idle_restore_early(void);
>>>>    extern void acpi_s2idle_restore(void);
>>>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>>>> index f9ac12b778e6..c984093a3657 100644
>>>> --- a/drivers/acpi/x86/s2idle.c
>>>> +++ b/drivers/acpi/x86/s2idle.c
>>>> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>>>>           return 0;
>>>>    }
>>>>
>>>> +void acpi_s2idle_enter(void)
>>>> +{
>>>> +       struct acpi_s2idle_dev_ops *handler;
>>>> +
>>>> +       if (!lps0_device_handle || sleep_no_lps0)
>>>> +               return;
>>>> +
>>>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>>>> +               if (handler->enter)
>>>> +                       handler->enter();
>>>> +       }
>>>> +}
>>>> +
>>>>    void acpi_s2idle_restore_early(void)
>>>>    {
>>>>           struct acpi_s2idle_dev_ops *handler;
>>>> @@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>>>>           .begin = acpi_s2idle_begin,
>>>>           .prepare = acpi_s2idle_prepare,
>>>>           .prepare_late = acpi_s2idle_prepare_late,
>>>> +       .enter = acpi_s2idle_enter,
>>>>           .wake = acpi_s2idle_wake,
>>>>           .restore_early = acpi_s2idle_restore_early,
>>>>           .restore = acpi_s2idle_restore,
>>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>>> index 6f64b2f3dc54..9df14b5a875c 100644
>>>> --- a/include/linux/acpi.h
>>>> +++ b/include/linux/acpi.h
>>>> @@ -1076,6 +1076,7 @@ struct acpi_s2idle_dev_ops {
>>>>           struct list_head list_node;
>>>>           void (*prepare)(void);
>>>>           void (*restore)(void);
>>>> +       void (*enter)(void);
>>>>    };
>>>>    int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>>>    void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>>>> index 70f2921e2e70..5a3fdca0a628 100644
>>>> --- a/include/linux/suspend.h
>>>> +++ b/include/linux/suspend.h
>>>> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>>>>           int (*begin)(void);
>>>>           int (*prepare)(void);
>>>>           int (*prepare_late)(void);
>>>> +       void (*enter)(void);
>>>>           bool (*wake)(void);
>>>>           void (*restore_early)(void);
>>>>           void (*restore)(void);
>>>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>>>> index 827075944d28..0c08032d6b50 100644
>>>> --- a/kernel/power/suspend.c
>>>> +++ b/kernel/power/suspend.c
>>>> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>>>>                           break;
>>>>                   }
>>>>
>>>> +               if (s2idle_ops && s2idle_ops->enter)
>>>> +                       s2idle_ops->enter();
>>>> +
>>>>                   s2idle_enter();
>>>>           }
>>>>
>>>> --

