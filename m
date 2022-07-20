Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E757BAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiGTPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGTPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:43:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5661B26;
        Wed, 20 Jul 2022 08:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnINRIhj/aV6WDjwTRUUDygQf140v6ZcaptGF1FH6j+4opKgJtm7JArW3CcQwJ7+UiGZssKrBgd1pjMZGgrjFb8KrhfFGINGMFcQz68ugsxFHawZm0scTJEHwhHve4gmHskPfATPmnnkwuCV2BrvA2QtfG9BfghYaWugV9QtdDxrh5wbEn38Gqx2qUJYcJ6Ug9Gpf1xZ/We0mAt2d//+htFw63HAt8XwNsjgMHwMzPLQ91v+dA2JZv3mEIKZo/re3M4jKmzQ9KeG/BIDpmRSYeX9FMeJkYQXLb5KDI8Y9FzkCLq2XbIH/CTNeFLXwZGlnFOD0DMqJHsK7QXMKbp/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyHFjdsbywJAK360WedhDxOGjuEEg6wmVNdcDdfQK14=;
 b=TUtYhb7XSJ3+ESNO6ch9bTO3M5r+XNWcJxl+YIKHKLx2QTeGLiLlUTWIM4sEznd1cmDveEqwUNWPatjgT9/rweFO5x23QkuZi5T5xjVmHXMoNybwXY46ndKegCAg7KpGtyeliVubDq4FHsQHjti3Ynz/gWWBliYGS+stFxnPmuKdho9I47fw+TD/t6DeC9QVQQPyS9s6mfiZkQskYBTqsLhKbWNzVdIdzNMdIR/hickfayZ/ArNEUtSvciSB4bj0h//q7xtFhlf04gG38weLzEgKy/bL2yPbNYoXCrXKEXxdebUfYDDb+7KU4K4/hOaZFojsGrYTaSdaWuilmypVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyHFjdsbywJAK360WedhDxOGjuEEg6wmVNdcDdfQK14=;
 b=wIxR9EFKxcq/8DtMraXJrBWuhGZK/25xgJZRoAzrvS9CT+ncX5pi/H4IvE/6/WZBbqeki7zPDP4t1189PRI/A/10l9AZnws/YoE8YgJjDo2s6O8+XK+qp8VG6xkeCbPupoIFuj0+Ne04+qUXnbGAWroFcb+A1fKqG4keo43GrB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 15:43:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:43:25 +0000
Message-ID: <12c1ef93-74d7-6e41-bb9b-f030ab20c97f@amd.com>
Date:   Wed, 20 Jul 2022 10:43:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add a quirk for Asus UM325UAZ
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Krc <reg.krn@pkrc.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220719142142.247-1-mario.limonciello@amd.com>
 <20220719142142.247-2-mario.limonciello@amd.com>
 <CAHp75VfWwDiPecBdP0Nm-henzZVMoyiu+nWuV=eUkuxLkqeViw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHp75VfWwDiPecBdP0Nm-henzZVMoyiu+nWuV=eUkuxLkqeViw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee1216b7-4c8d-468d-f576-08da6a6695b1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Duz/JU/eHk87JHAJrbcqAATha7OhjxM6yxeMGFyz0BcMhetHhAGUEABrd71pNOWOXQ/Z1+gpABW+G8P3yxe4/5XrwHnvYJxkRWUtCQWZtgEmrlkQFLRqDHWcyqFyBPR1358ISPHJf0yO+gHIW0ppOves7MLfqiQ1ln6X2TlWKhNa3IvxAqiEAaWVzRG3x7+41JIQ8LDgpV1ILWQfecf1WxaEv8gV7p4YGw0FSmM3MB7GFEN98B+mr6nw4ScLQlPUMsKN90qEAYEkBrZxGpjM7lLG43hLKk+WKlg6IgBQSPXRshajp0biT11Nn+FMpssJC53I60ZJMXgmPEQ5a6nfIGgtwzTYrCdEoFYYBYuLpSN2uh9ptYuaEDd4laWsKJPE5JbWpAF8yP0+2bZK5zU/xJpFY31ID2k4lmXbSv9aRJCOG2E1WcQ0RDKZbnX6ABO4nrsn8PzQGplLeMJbft7KvFtOGpQgNLw+hPabtdQ4eP6MRiLKGnBvgGRHJ178ZN5ndVEvBpzvOjq2qREltiK/AJN10kL4eTiRejC6pkwwBejGEhNtJxptFX8WTx4y1pBFgmYqq0m9+Q1OEf1LlaKY1+cyidzlZvRiXXxtI7+t4dPbhu5I1f+dKToNZ3rYwKJS+xPz2W6OkjBVv8oUf76Ew48/UDqIXWXg3ccHLbJi4tGoHBNXyWffxP7Ds9oGDN5Nllr7sxWtZMMc7lRNmiyFbd+RETFQR/tFeZUuie9ybyGPygo3z0UyFHUFNFfQXCTW3vqmB+ffH4o/peNhRH7hkBZDfYP259wMZOQTfIJ6rZKRjGHyvK2gsuri6QoGJKLMI7ckqRKH9Oa4RqRonlbypvOFCxiqn45emKrJILGNbAJpXPtCpr1wbmROOuo+tfsG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(4326008)(8676002)(6486002)(66556008)(7416002)(66476007)(66946007)(478600001)(86362001)(2616005)(966005)(83380400001)(5660300002)(36756003)(8936002)(31696002)(6512007)(53546011)(186003)(2906002)(26005)(6506007)(31686004)(45080400002)(6916009)(316002)(38100700002)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U241TU1YcUwxZktuUlNDaUNhT1lPS1NBZHBjTGV2OEErWGt5VUUzMmJnK2Nr?=
 =?utf-8?B?bUdJcGZFMzM4ZEljUWZSdlFQQVFaQ3UwL3ZNMG1YQ3BnWFMxOWduWUsxL3M2?=
 =?utf-8?B?RnN1NDlUSFZVZklzcWFScCtxOUNSQStUZ1I3ekV3V0tqbjNwbVR0ejVyeFZL?=
 =?utf-8?B?dDlYV3hrYVJKU3dsMlBYR0NFL2lRRjlQS1FmTERla0FaSWZzckNsMXFSbmxM?=
 =?utf-8?B?eWNodjFLRnRIL05wNDJQTSttTUp6ckRkaUVINlBDYjFmQkczZlczWEdOTjVV?=
 =?utf-8?B?WFdoRkwxSSsvaWNudndGY3MzdGNwSnJwWjFBZ3JZSEpOWk9rNHFVUmlzZmlN?=
 =?utf-8?B?Q2VzU0h2UWVaZHVtK0FEaWNUM1p2SlNRc3YwcnFHNC9IMCs1Y1hFUk91ZnNS?=
 =?utf-8?B?TUIxcys2QXYyUEI3VUNvOG5oVHV2eDRGV0habitPRWRBSHlMY3ptKzVtU3k4?=
 =?utf-8?B?dU1MYzZtOHZaSXdtWXZ2ZmVBVW9rNFcxWTZzVjJWMVpmMTQ3U0lualIzRWdT?=
 =?utf-8?B?WFBKR2FsMUlveVFCYUFSaHhES09FM1hVemJaV1RiUmhKamVzUzhVMEJHSktx?=
 =?utf-8?B?UzUzbnZ5V2hpcExwMExSUk5DL29HbkVsdG8yZG11ejBUVFRxM0h4cUFYQXlD?=
 =?utf-8?B?MTArTjBDWmlaY0Z4dHUxWTBCby9Xd0FaelMwbzl3cTdVZXh5MnF4L0RhUGRZ?=
 =?utf-8?B?Vmd4Qk5PR3gybXp2YmF3blJFK2xIZm5xeThBRVRSRjFhWGU2OGVlekF6ZUNB?=
 =?utf-8?B?VnBFc1l5MHNxOG4zVUlnNEZVVkNrR2xEa2g1bko2N0VBK0F3ejFGNGpQa0Y4?=
 =?utf-8?B?VFRDMmZ3SHRCQkxUT1NUb1BCdWdpWXo3S3J6OW0rM1hOYzYza0ZEQTdGSVhS?=
 =?utf-8?B?R2xpZ2VuVzd6b2t0OUxpNFVBSnV6cGt4QnRyc01FVlZNYmRQK29nOE1PN3BR?=
 =?utf-8?B?aFZOYUxYYWd2NDhPeUNQSVZOQklXZTl1WFc5YjNPWmJmNGUwYThxV29wbS9y?=
 =?utf-8?B?NWZkNmpKaVR3dHB5cStqdHJUQ3V3VnY0UkRrUGsxRmpXTStxSmg1V0w0eWtz?=
 =?utf-8?B?R2g0VVRkZER2OWY0OEsrZVZVd0x1MElmMEVGdndPandXQ3NXa0pjT2JQQUdV?=
 =?utf-8?B?ZU11aWwzeCswMnJaeFZYNm1NbFFCU1pTUkZsMzg2SXNJQ05ZUnRKTkc3M2NQ?=
 =?utf-8?B?WVhMVFY1REpoTGx2WWFzV1hVdTRJRE0yT3pDS3FBSlQ4VTBpbzRZVU5YUEZ1?=
 =?utf-8?B?bjMyWEdLMzJESEk4VmhtSkh1MytSZmRMSWVxOUNndmJIMTFPRWU3K1oxUWpQ?=
 =?utf-8?B?S2kxZHB0bzl4bzRudUo4a0lrUFdXNE9aZHRLZ2ZRbDNsaXBCTkVBdkNLK0tH?=
 =?utf-8?B?MHV3QWxkT0lWcUc5R1I1aWgrYVoyRFZWdDJJSWttTnV6R1pRM0FlYVg5RTBP?=
 =?utf-8?B?cWYvR05OVVhyUVY1ejFrNWROdlE3aW55eFNRdGQ0ajNjMXE0aWJhVGRxeG5F?=
 =?utf-8?B?akFkWU5KaWsyWmtHem1GcHBQaEE5MmRqaTRCOEJsekp2cDRDSEZ4VW51WXRq?=
 =?utf-8?B?cTN5TnNSelZ2cThnMEVXcFlhaTd0d1dmQXZ3WlFCZnlKeUhoK3hKU3hCKzl3?=
 =?utf-8?B?L0YyMXhFRWttUWRhYU1hM0ZuL3Y3ZlhEN3V5YVNlbUdwOGxENnpiY1Q1UmQ0?=
 =?utf-8?B?aExKV283ZWJqR3VQVWJIUDlKWXFUTkczWElVdy9IbkV1U2lZU2crTWp0eFdw?=
 =?utf-8?B?cFgxL2d3YTdYVFFKcEhlSktsSUdLcTdPc3k4d0N3OFozdGNVTlJodFNqbTdK?=
 =?utf-8?B?akowa2RvVXl6cEx3NFRIV0IwSUpsSDBnYVpCZ2IwbHdJS0Vqb3ZPSzFvaW82?=
 =?utf-8?B?L0U1a28xUW0zckVnc2REYTd3ODA5OWVXeGVUcTN4TkVDTmZzOWlSZERlTTBl?=
 =?utf-8?B?akNHUmtoVjc2WTY3LzJndGI3UzdnZm9mNEZMK0xlMmIvemVsc3ZsMDU2aDlW?=
 =?utf-8?B?REJLMFR5bkJwVGw3TzBsVURRNFp0ZUY0OGw4ZlYrSzQydTk5eWptcktjRmVn?=
 =?utf-8?B?NTcxeWx0elVCVHR3Vm00b0x5ZGFYcG5kSjJHZ3VzQS8xTk5LaUE0QkhJeUF2?=
 =?utf-8?Q?oudQW/24ZhEFFFdxMqeHp+vGJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1216b7-4c8d-468d-f576-08da6a6695b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 15:43:25.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEvGXQYnd2XMVIm0lZ/U82RpPPSu33/EeZ8ElvVnEdfLjl/beh80jNe70bX3vqkkmC/wmtfW1nmGKNciyXsFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2022 08:57, Andy Shevchenko wrote:
> I am on vacation (Mika also iirc), but I believe that Hans can review 
> it, so resend with cc’ing him and add above as a comment to the change, 
> or better cover letter.

Thanks, I redirected the original messages to Hans.  Enjoy your vacation.

> 
> On Tuesday, July 19, 2022, Mario Limonciello <mario.limonciello@amd.com 
> <mailto:mario.limonciello@amd.com>> wrote:
> 
>     Asus UM325UAZ has GPIO 18 programmed as both an interrupt and a wake
>     source, but confirmed with internal team on this design this pin is
>     floating and shouldn't have been programmed. This causes lots of
>     spurious IRQs on the system and horrendous battery life.
> 
>     Add a quirk to ignore attempts to program this pin on this system.
> 
>     Reported-and-tested-by: Pavel Krc <reg.krn@pkrc.net
>     <mailto:reg.krn@pkrc.net>>
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=216208
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216208&data=05%7C01%7Cmario.limonciello%40amd.com%7C2c67d6b468d44e177dbb08da6a57d2fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939222681842692%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=INWMYURdKmQeTaFw1PT%2BEohTJGJSRRONYJCTw9klXu4%3D&reserved=0>
>     Signed-off-by: Mario Limonciello <mario.limonciello@amd.com
>     <mailto:mario.limonciello@amd.com>>
>     ---
>       drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
>       1 file changed, 14 insertions(+)
> 
>     diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>     index 375942d92d6f..2149713ea8f1 100644
>     --- a/drivers/gpio/gpiolib-acpi.c
>     +++ b/drivers/gpio/gpiolib-acpi.c
>     @@ -1586,6 +1586,20 @@ static const struct dmi_system_id
>     gpiolib_acpi_quirks[] __initconst = {
>                              .ignore_wake = "INT33FF:01@0",
>                      },
>              },
>     +       {
>     +               /*
>     +                * Interrupt storm caused from edge triggered
>     floating pin
>     +                * Found in BIOS UX325UAZ.300
>     +                *
>     https://bugzilla.kernel.org/show_bug.cgi?id=216208
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216208&data=05%7C01%7Cmario.limonciello%40amd.com%7C2c67d6b468d44e177dbb08da6a57d2fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939222681842692%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=INWMYURdKmQeTaFw1PT%2BEohTJGJSRRONYJCTw9klXu4%3D&reserved=0>
>     +                */
>     +               .matches = {
>     +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
>     INC."),
>     +                       DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook
>     UX325UAZ_UM325UAZ"),
>     +               },
>     +               .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>     +                       .ignore_interrupt = "AMDI0030:00@18",
>     +               },
>     +       },
>              {} /* Terminating entry */
>       };
> 
>     -- 
>     2.34.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

