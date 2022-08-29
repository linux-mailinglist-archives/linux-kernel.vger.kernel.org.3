Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25705A4F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiH2OdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiH2Ocx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A586915F5;
        Mon, 29 Aug 2022 07:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPR4bkGiS1cxen5ZBZ0KmzNb6pVNXTQ54ZjaALvEsJlVLo5PgO1bXlC8NbEkd/ZQoEQEE6DQkEqXoRuRSJ46oRcW9/3iEhtMFWJJTkKJp9Ij7MtidYGthcgOd4HNpcjaJbeovKuVkOrjEi8ULW5NpbG3oFCYn0Ie0Pe89S+9PIjeubinhJ+EAAq59nG/k5ipAf7m2VUWcOdHrushTFC+WF4Ne7qNva+pHiKR8iIORUJbwITK6F2k1k+35+aePjMWq4GMCVWk0QkALUuVLFC7Q3IPPQBuDcAC0+uQa/QW/WAHtK+ysSQliJOcalbNjXtGcqeeEAjW+xN4X5hs7fUprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwzXYq6+BZ6aXvMFHGJPw2KJwJ8qz5b98jXVOF+3MvM=;
 b=FVc4aYfuIks98tbzm+rpB5FtnmOR14AM9P5qpqjM7qktDgvkTYHdkwg9hjdtJ+gVpiEMDfgwVvf4MJbYsO/9TnO58ixfLu0OBEeuanY9ZREzX7dltNlK0IOyVuORCfyschlBVQBJ8vYoXt860A+VZx5MUY1qy4vsLjgVRNX4rlfqQmubPjyQa4szbPbdfsbqHUbNK37PlU3dqfSVOPgflyRx991HKm7KG6ROMOYUnFAHu4LF8n4m5MwkLfy6tBzrDEnDTbKfZTffGRyhccxhymVMMlJTJcpq2ds1IoA7aTQqBM4hhUvggRhemo/1Hk9xf5gf7+7WMfs3Q6qugSr9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwzXYq6+BZ6aXvMFHGJPw2KJwJ8qz5b98jXVOF+3MvM=;
 b=TsWjAZcVjxN/o6ExYswFgZEkfw2RXHkVFZAZDGGAg5LSDaU1zfTWtPRVKQ20rIHX3wVkcmtFeAxqblr+K4VTUBC0UpjZNX++hohpKAcxdPcBP8qZzavomVYmlZxjdv5HlXmqVl5hnWLaqnlnDTM98to06oqFB4K+cMynlSgpxd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:32:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 14:32:46 +0000
Message-ID: <a0a63b87-f1ec-03ce-0c3c-a66d7c8144b0@amd.com>
Date:   Mon, 29 Aug 2022 09:32:44 -0500
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hfYhNLp+x9iFiqsQaL4XA8QdFhRK7Csgr8po8JPoimyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0015.prod.exchangelabs.com (2603:10b6:208:10c::28)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e6e69f-ef9f-48aa-5f71-08da89cb572f
X-MS-TrafficTypeDiagnostic: BL3PR12MB6618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHWpGXiI8NST2Exh7VN/pdOKZOVNJYp0zx6w8A9EIrDT1VD2beV8fDti6QD4cg8Hta9o6PnhWM8pOO7xHk6yZ4YWKBgfLgRW8LPgI4dGiNF8Ab47exU5f3u9zqEhUn2su3N4jxmGZkE9Vc6tOHHirA1MSLjPlgXqMCM1FheZ0v26ZoxPu0pshYmz6Mp7HDGR/mKuV/MIrxBl0CbeJ+287OnvrKIsR4rLvDeIoVGL+MM+dNHqrLgYwYWjnmGuuaxlVGFOqTQXFA2pBk6RBjq848/IJ7Enq+JN0An/+KgXeKCSRa6OmzScydyQWDPXIyAqteOGIpAxlWyCg//AtB902HkqDy7ohEtAWysHvNSSXybNkYRjCg4RhNRnUN7HFmBYykbONoXEzKzPUL6M7/R73KEG7BPVs1LAt824ZhYQUt3MGOZ2ZZv8a55EZ/p4JZfdeQKwD6vcmCbDtYXA6kTcjSWFXkH4GlyMBOF4harbvulqkg0V27u8TVR8F3RJiBuOXWZR9IJWwtbZoqTArboEvP8jARcTqxNpVd1XHwP1aqd7zIhoybBgCbWa0T0mwcAC58kjshk/AEYzU61OJJ/Kvq5Yjotk+BN7+2IAwWl9cn7l17No5GIH+/Qzsp6cuHy5A4OqancK85BPAwxF0xMU5/4iXWEkdptgYevG1MFMIU+E0TDUbrJFuswie7K06ueMvcrSivg9QjP3Ncu+IPUxh8it+YqklV2UlO5ndo3Er9WR4ueGvVdpcUpGMZ0U+q3RUhl8RD3QyoJ8PU268XINhQK3keKF2GB0qLochl4bz+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(5660300002)(86362001)(2906002)(53546011)(6486002)(83380400001)(4326008)(66946007)(186003)(8676002)(66556008)(66476007)(316002)(6916009)(31686004)(6506007)(478600001)(36756003)(41300700001)(26005)(6512007)(31696002)(2616005)(38100700002)(8936002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBHUUd0anlxaTYxR3hVN1IzRFlYUk9rR0JRS1R6dDJqVG5IMzVYby90aDkw?=
 =?utf-8?B?NjM4bVJpZTFzY0lwNVdaNjlVK0Jna25RNHBEWWFQN0wwRGJoUVhVK2hlVDZK?=
 =?utf-8?B?dWpzVDNjcTB1MURlMHpRNnpVTXNBSE5iMTI1QTJhcTNoa1F0M1pIdDdMSlVh?=
 =?utf-8?B?aktUUm5PcEMyb1UrY1BTd21KK0RqSkhjcFVHMEdhYmFDQzJrK3JwYyt4SER4?=
 =?utf-8?B?SlV6cSt1OElqUXBOME5RQUpMN2ZkNzRlNGJLUmkwZW55OTM0cEFwTllmRmlO?=
 =?utf-8?B?emZ1TE9zMUIvSE5vUWxsaEVvdHV0TTBLYTJpTHBjaDMvZGFpbGR3M0Iwd1ZD?=
 =?utf-8?B?Z2dqMmk0M204ZWxNYjBqM2YySFh4eG9Pb1BUU1BIOWpKYzJRWWNORmR1bkJU?=
 =?utf-8?B?c1ljZ2t2c3c4Si8vaFNkUnVJbFFNaC9DS1ZVbllYTHcyM2hhblp4OU5MUC8v?=
 =?utf-8?B?RjNBR1hhR3ZvNC8yT1VPeTZNYzlWTzg5RUZnSzl2dWZLRTlROStQU0tGU2o0?=
 =?utf-8?B?VG1iM2ZCcUxCNzVHT3BCWk4xQXJxTzlLS3V3NEdYM1gweEZsYVZraTdTcXpF?=
 =?utf-8?B?aXFueDNvajZhNjFRZ0xQdXE4Z1pHcmlyb1dMdzRvZlVkS01NOVEwQldtclFk?=
 =?utf-8?B?UDNuTzRkYjBPa0NmeVI3LzdVWC85cHp5QVBuOCt6YmtJaW9uVHpZZUpOaTFW?=
 =?utf-8?B?dXl2VGF6MUdiMWJzM2FYUGk3SG82VkhlUnlVTXZTYUVpcnRDTTZXMENFRzEy?=
 =?utf-8?B?K04vZW9GaDdoTzZRMzE4QklVdTQ5amFKN3JRcGo4WUdrWTZuWmxXMG9sRDV3?=
 =?utf-8?B?TGFBS2dHMjVPWWYvWUEzSGQzUVJGYmdHR2NpOFF5Nm5oWWRaa0dzVWxyUk5m?=
 =?utf-8?B?UUFLeGNrWUxKQ2QvSE9XajgzVkRrRGk0b2ZuN2JzbCs4U251SWNhZmQrZFg1?=
 =?utf-8?B?VS9MMEdoQ2czZXNCUjdReE5UYW1nWVpPRy9DTFF6ZCtNY1FoaHQzR1FHbnZz?=
 =?utf-8?B?ajBGS2drWG1EZGFiOXg0ekVRdG1HSjd1ZTVBOGxveTRhUUpTeVMyOFJrL0Y3?=
 =?utf-8?B?QVNrRlRpYmlmSUdMMEtrUHJjWjdqemM3dUZsWURPWWcrZEJmamVzU1M2eGhr?=
 =?utf-8?B?bDlWSDdpZW9oRW9WcTRoUnhZOHhrL0praWkwSzBvdVlDSlB5Q1hxK0RqN3RU?=
 =?utf-8?B?dE0vYks4NUNCUnJCcXlscmlnZlRHSnVJbEdPcFVsTWdSUVIzdkN4bmhCQ3pa?=
 =?utf-8?B?NjM5NFZpR2FIYnlLb2VUSmZlRTRzQXQ0SjZlWG1ieGc3UHNpc3FjYWxiR2l6?=
 =?utf-8?B?TWRUQ3JpWmNNU1Q0ZVc0KzRVbWVlVUpnanVBWGU5TEJrcHNuaXBXczM4bmVn?=
 =?utf-8?B?Yjh4SSttbnNwM05wOHB5Rm1aaGFOTzE1ekNuNUw1TVNUNC9hUVJpQzNmMnFh?=
 =?utf-8?B?cG83L3VvZUwrcWI0dmFYVDVEbkJoL1NRSFptVm9nZ01vWG03OE83Z3Q0VFB1?=
 =?utf-8?B?QUxpaDZhQVVMTDJRWldqMVdhWWhsWVptdVBrMFZoMEVJYXRnY1lsNnBTZHdX?=
 =?utf-8?B?d3VWb3JsVk9RVXJjalAvTzVlVk9HdnZoZjV0dFl3N244Qkdnd0Y3UU4yN20v?=
 =?utf-8?B?T3lSUitOdG9lUGQxbmVENnFaTjh5QjJsbHp0OWZCZUlFeGhyek1JeHBTY2tr?=
 =?utf-8?B?MTFLYWRILzFhWHRDZ1FUSzhHVkhFaHQ0bmRjQzR3RU5JdjdmOXVYc21DNDAw?=
 =?utf-8?B?TG8vb3pvNWxKQ3VRejZNWXJrWEYzYlpLUHgzanA5Yis5NTlxQmpOTll1ZEtu?=
 =?utf-8?B?elc2dTFZSGtaMmxjQlc1UmFkMVFFekp1T2NLeFVFM1RIUFgxdFBsS3NkWFEz?=
 =?utf-8?B?cFZZUlFzNlZiaGhtK0pTSE1mMm1iMlNiYTB4Z3pLVFlxZUJZdVYyT3NIM0Iw?=
 =?utf-8?B?NUNBS1I2MUVmU2RkZTgzWTk3UlNpSGxDN3JVc3Zvdk5JUE5YNVE4aFBaT0Vm?=
 =?utf-8?B?L3J5NEpIZ3BSbm1tYzFSQkE1Rkxtdnc0VXo2M0dZME12YlBNZHFweDZEa3l4?=
 =?utf-8?B?T29mRkVqVTZac0wxZHdzR3RNMXFnVmdSTmp5bGxycHNFcHRCNHg0QUJNMUY0?=
 =?utf-8?Q?pmkV4DIFGdpD8wnRLlYkTk0Id?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6e69f-ef9f-48aa-5f71-08da89cb572f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:32:46.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr2EcomotBundsCp4gw1jdneEH8Cg7VPYqNPIoz0Adk/77J9eIefYg0YlQlNvj8hJIUzPjyDR+7n+tWsk7QizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2022 09:20, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2022 at 3:29 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On some platforms it is found that Linux more aggressively enters s2idle
>> than Windows enters Modern Standby and this uncovers some synchronization
>> issues for the platform.  To aid in debugging this class of problems in
>> the future, add support for an extra optional callback intended for
>> drivers to emit extra debugging.
> 
> I'm not liking this.
> 
> If you want debug, why not simply add it where it is needed?

Actually this is exactly where it's needed.  The synchronization issue 
is with what non-x86 is doing while x86 transitions into ACPI C3.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Add a prototype for `acpi_s2idle_enter`
>>
>>   drivers/acpi/sleep.h      |  1 +
>>   drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
>>   include/linux/acpi.h      |  1 +
>>   include/linux/suspend.h   |  1 +
>>   kernel/power/suspend.c    |  3 +++
>>   5 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
>> index 7fe41ee489d6..7856930a7da9 100644
>> --- a/drivers/acpi/sleep.h
>> +++ b/drivers/acpi/sleep.h
>> @@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>>   extern int acpi_s2idle_begin(void);
>>   extern int acpi_s2idle_prepare(void);
>>   extern int acpi_s2idle_prepare_late(void);
>> +extern void acpi_s2idle_enter(void);
> 
> And this name is confusing, because it suggests that the role of the
> callback is to make the platform enter s2idle which isn't the case.

Can you propose another name?

> 
>>   extern bool acpi_s2idle_wake(void);
>>   extern void acpi_s2idle_restore_early(void);
>>   extern void acpi_s2idle_restore(void);
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index f9ac12b778e6..c984093a3657 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
>>          return 0;
>>   }
>>
>> +void acpi_s2idle_enter(void)
>> +{
>> +       struct acpi_s2idle_dev_ops *handler;
>> +
>> +       if (!lps0_device_handle || sleep_no_lps0)
>> +               return;
>> +
>> +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>> +               if (handler->enter)
>> +                       handler->enter();
>> +       }
>> +}
>> +
>>   void acpi_s2idle_restore_early(void)
>>   {
>>          struct acpi_s2idle_dev_ops *handler;
>> @@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>>          .begin = acpi_s2idle_begin,
>>          .prepare = acpi_s2idle_prepare,
>>          .prepare_late = acpi_s2idle_prepare_late,
>> +       .enter = acpi_s2idle_enter,
>>          .wake = acpi_s2idle_wake,
>>          .restore_early = acpi_s2idle_restore_early,
>>          .restore = acpi_s2idle_restore,
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 6f64b2f3dc54..9df14b5a875c 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1076,6 +1076,7 @@ struct acpi_s2idle_dev_ops {
>>          struct list_head list_node;
>>          void (*prepare)(void);
>>          void (*restore)(void);
>> +       void (*enter)(void);
>>   };
>>   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>>   void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index 70f2921e2e70..5a3fdca0a628 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
>>          int (*begin)(void);
>>          int (*prepare)(void);
>>          int (*prepare_late)(void);
>> +       void (*enter)(void);
>>          bool (*wake)(void);
>>          void (*restore_early)(void);
>>          void (*restore)(void);
>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>> index 827075944d28..0c08032d6b50 100644
>> --- a/kernel/power/suspend.c
>> +++ b/kernel/power/suspend.c
>> @@ -136,6 +136,9 @@ static void s2idle_loop(void)
>>                          break;
>>                  }
>>
>> +               if (s2idle_ops && s2idle_ops->enter)
>> +                       s2idle_ops->enter();
>> +
>>                  s2idle_enter();
>>          }
>>
>> --
>> 2.34.1
>>

