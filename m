Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB6578683
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGRPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiGRPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:39:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302F193D5;
        Mon, 18 Jul 2022 08:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilFf+nuv730d4Pbp1mqVWRjuqQBV+2HBj4cE6i50gjxujlC3etVSnmeRFV7JBXD3oYnDqmTwvbJ1v5eDY1pvZ8BA67UMkqQ8ZVnS7uiqAEr9TAxy5TnwqhJiPB8Z6C+zQBNPy+qWzgjbpKHUkEr77InfaLqWufkGUcU8Xgh2jb/WvlGxNk2sjwvShHddYe5MQOq5/dR4TqsjZyxt2jW7ZxrAx9pYlqOdiNjXtzb54DyDxIUSg/FXoDyfEuPHp+v4CPn7RLXgiQygKaQGB8atyn2WKdtf/2usyAQIsLbDekMumZ2qfKf/0qJGBGmHjAWorPzm5oS1sRcZu39IruV7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AKNYjSmoN3xpj11gwWsDXJFk5hgeXb/IFZNZ35dKR0=;
 b=jK+vDED07R2dqYAi1MWaFi4WAvjqFHYBE5oRzs9UvjmIJHCb/PmDJzsS+EYAEwXU/CU7Oksc6whZW8oRjZmDLqDo1sMl81eRywKlHlIG0I9yqo/N9+VAuerZwPC2l9BKqL2JRfBVnRCapyuINKjvES9iwUiClaO0aOawG0lnVw6D/XGR4nxpECWpxxYZRY7fj6kCcXyjF3H88qk0Hv4jpniHHEHuIlgLnRKfUgfvWr52a/PsJfH0h1r2PEAlI8EiJT6wDZh0UnRA6J+PNMV8Gvq9msRwmcDJg0dOiH7UFlYOlg4b3vJ5cWIZKe+UtIjG6SdLpiZKKW0A2+iSDcE82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AKNYjSmoN3xpj11gwWsDXJFk5hgeXb/IFZNZ35dKR0=;
 b=i3QJ8bG7XfC3YaLsOZnu8jYTtmKR/me51fRO4uykVHGyCrK9LNWtcsdhOkd7c815bEo6XrGq62a9Tt/X9nHu0D1quwGzW5NhsoGPGqNok/B8qoqcF09rWfLLGnx2AwRERDHdmofV46BmtSSFx4M1iziXfkPCLhrw0lTe7FS+kh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 15:39:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 15:39:23 +0000
Message-ID: <8eef6593-ebaf-5b5a-b9b2-c93277d4afaa@amd.com>
Date:   Mon, 18 Jul 2022 10:39:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220712020058.90374-1-gch981213@gmail.com>
 <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:610:4f::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 157c5331-b3f3-4cb3-8b23-08da68d3b019
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9UTiWQRDthjbZQZNW3lpLG5rKegR3MMkh3hH+T6XjfSzNC5N1BLFSX4ukDReIKdlrNGC4zzU7/wvyMYkc70hk8oSETpndhbdKxCHlmaf5l90s7TKhYHvfeDw8AIU+xTolD9H5/MnJBrQpyRPN4E1Lt2wE+hb/Xq1M+Mgqg1HUoRmD1gty9wspNTg37DnU+weNdlxLwHkbyfeMTEO9osYq8pk7w3fiQVXsNi00gbb7541jG4pSjWafjTg2R4OsI43avzGiqqMYD7osUUlCpxInuCusW3+ZTVoNM8zQVsgex9rMkJ08ewbmGK8mCKbe706U9LgjTGsDyKOHDGqXHkzmmjT9EqVppvPqg10gBTUDv80Kqan/O9TDTyJTc9p8xtaOylxp7xsA2nleJv7gcBAixETpKtcAPDz3HQ4ilbT5y/tThtmX9RNX0Qmvf6lYfnFrHZJud41XdSUSfieyntdV686ZIabzrM4p5q4TK4UWy8WFHWVFtPZBm1Z50UXmUd0BO0QLXpBrBDv9xvMNicWafstSzYGk87qw2LXSKJNaf5zMeBCkOffgiZSZm8aaMp8jo5IRSaMD0lMMnwA/3xjiwr0CCxZZdO+coX7et9spX2Dcf/eNR36AwDJj80OfOb42jx8v9Aed/1HrqoUg1NZF4ycrC3EulfdzhSTQx2zf+rHJqwo+z89xoJ9V5hSh2qTmSsurjx0FYmkeA4dSzsOZb8sjWT1llQpriySKyusRH3eeH/oLV1hO8ZvrNxm9iMIK8cAl2R26trhk6l9k4qlREfvvWePqzKgMlBHE3V/UYITiW1Zwkkas9o+EchCXV7DNUYVqfc+fEHVHAOTydrKwY0yzJZ8m5WFaYT5S82GGtyl141/lbn1ivb5BkLNwU6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(8936002)(86362001)(31696002)(4326008)(8676002)(66556008)(66946007)(66476007)(36756003)(54906003)(53546011)(38100700002)(110136005)(6506007)(316002)(26005)(31686004)(83380400001)(41300700001)(186003)(2616005)(478600001)(6512007)(966005)(6486002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW5ETENCSmVqZUpFUGpMSGNDM2x4RGwzd2lpK3BuM2s5WnFuNkZhWUtkK3Yz?=
 =?utf-8?B?cWJENDFybEczdExIc21RZUM3TnZpMnFURGpyc2NiL2lWUDlBeTRrdENUZE15?=
 =?utf-8?B?TElxNVVGRUxrTVhlSXVZZTdKTWhkMDc1bkZucmlqaFlxWitQakdMZXBmNXpu?=
 =?utf-8?B?dlAvTWV4M1Y5aUU5a21hWC90MUk0TVpmZHp2OTdZVGVTaUloUE13bjFUSStU?=
 =?utf-8?B?S2drN0JlK05HOVl0T3FPMFBva014Q3BCUnpBTWdvSm0yV0p0TTlkK2QwVmdj?=
 =?utf-8?B?dndWbDFXZkxibVliZXY4dUV2UnFLVkZNalMzR0k4Zm44eWZxMlI3RkdIMjhH?=
 =?utf-8?B?NW5EV09abnlIakc3YWlDWHI4VjVyZ0xGcWVtZk56aXJuWlIrVE1LRGEwSkh6?=
 =?utf-8?B?dm5EZjBKQU5kRHZNZVdrbUhYRUxNQnpwcktsR1ZYQmdLWmk4LzVFYXRXMm82?=
 =?utf-8?B?cFlzZFFEdS9tUVFqb0k2bWg0VjlwbmhsMCtjbmZKRU04Z1l2dWxmSnEzeXZl?=
 =?utf-8?B?QzVBZDQvd3ZKTnlSVzdOWVd6WXZjcW0xMUxvdmJ4WDZwWlFkaDRmV3J4czU2?=
 =?utf-8?B?SEZyMEEyRW56azZPZmpuaGdYcUFFMFhOaFlld3N3N2NuNU9LUEs0ZlFTSEM4?=
 =?utf-8?B?UVpqQTRyU2RuRUdzeVBSeVBJTyswUGJFbHh2Y1dMS2ErQkxEamxBZUN5ZldF?=
 =?utf-8?B?clJSeFZJS0JGMEtQdGQ3YWRKTXYvSGIwZFUrS1FUR0Q5RG1QWFA3WEZ0NHE0?=
 =?utf-8?B?Z2NkNHZFSlNvOG5ucGN5UE55UHV1SGdtQjNJSlIwbDhKZ1RqdHZhT2N0WW9p?=
 =?utf-8?B?WHRmQ0NvVDB4Ty8wNlJhaUIwUzk3UU56dXFXb1pqcWNLKzJoRVdFa2lYcE5R?=
 =?utf-8?B?VUVYdTkyUXZSSWx0M1pIT3NjVERBWHVhM0IzNWpFZExlYlAxZUxhNnpmcXMw?=
 =?utf-8?B?azRGNlR4bk5OMEZJTEdSL3FyclhzekduNzhYbVdtWXJpWDRQSWJrUnh0eXZI?=
 =?utf-8?B?eXNLWVNWZGRIQ2ZOUElWcytpR3ZieU5HLzN3Tk5xWGVoNW9zd3k0TmQrTXhJ?=
 =?utf-8?B?RUd3NStWUnVsckc0MnU3dEE1WGdCdGdhaHJHcGNseFMzZVMxOUtxbzV5dGZI?=
 =?utf-8?B?NnNmTEFERHk5dEcxSVNTTHJDU01VcEw2T1djOGN4RHBYa29UakZIN2pLa1RO?=
 =?utf-8?B?aHczZURXbG5mUHZnR2VoMWxDWStxb2JONGNRRCt0M3hWZUtLQWpYaG94Q3Rp?=
 =?utf-8?B?LzQ0UFdZckNudGdoS3pKVXpqZjlydUJNQzFUZFUxVUQraFpzbFRqcWlPRGRa?=
 =?utf-8?B?ODZubGxsZktRRW9FaW9wMnZ3NlFaWEpzWDkwdytDYzVsZWZhbENoNXZVdUFZ?=
 =?utf-8?B?eTh6UU1VZTEwcGNidG82a0tMK1dndlMwSUdEL3ZaU1JqaDM4R3VnMStsMHhk?=
 =?utf-8?B?R0dvZzlqSFMvZmdwa1VDMjdSUFAzYi9iVFVCNWtSSWFFMEN4MGV5Qmg1U2FT?=
 =?utf-8?B?M082bVowMndPZEZ2Qk9jcWZkWW9rc3lsYzJBaWtvbTc0dnljZHd1Rms0WUZM?=
 =?utf-8?B?ZjdKZjQvM3JPUDlJUlV2Vkl3VXUwcE1ocUhCa09EcGhRR3RUek5mcFpSQ2pT?=
 =?utf-8?B?bGs1Qm02NnMxUlMvTGJBRE5UeUtFYXB0aUJPa0RSeElyQzQ0RXhScGNYcFp6?=
 =?utf-8?B?azFCRU43aThyVjVFNU9iY0ZPZ21BTW1tdVVhMDdwYXZxN1RCM1pQTmttS3FG?=
 =?utf-8?B?czN5aG5LWTZ3clFGNitXQldRK2paRUtxY25LcDRGUzJ6SXR5ZXpwOVVsSkNG?=
 =?utf-8?B?eVpCZy9Dem9qcDBxZFNVa1JMdmhtUGFwZTc1VmYwOTUySEtqRHhBZFpYYUEw?=
 =?utf-8?B?eW43dnJpa3ZtSDZldHpKNmdOYnR1N2UzUFQ1OVJKVVhZVjIrYnFuL0FNaEQ4?=
 =?utf-8?B?UUo2M2VnbGs5cE8vOUd1Z01SWTJjakg2ZFpsZjAwUFFidC9wc3N6VTlzeUI1?=
 =?utf-8?B?WEQzVDdmVW9ZL1hzcTd6amVWV0s4eVJ3N0dneFJDUVV6OVFoQ2xzWUhHcDdk?=
 =?utf-8?B?bHdaMVh0c1NhQWR2V3ZHZ0FIODhYSGl0WGNpeXpDMzFxbnZ1NVFPM09FSjRB?=
 =?utf-8?Q?mvmmBZ+iNPJFplgoyCqUzmSfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157c5331-b3f3-4cb3-8b23-08da68d3b019
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 15:39:22.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRjRMrC7sBnR4lLFqfvAVALbTPaXiiL1z578v8vrVHM+SzZsoy4K3MEFs7lrG4AcPZedP5cUZpAMYTJ/ZDOsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2022 13:35, Rafael J. Wysocki wrote:
> On Tue, Jul 12, 2022 at 4:01 AM Chuanhong Guo <gch981213@gmail.com> wrote:
>>
>> IRQ override isn't needed on modern AMD Zen systems.
>> There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
>> this way on newer platforms. This IRQ override breaks keyboards for
>> almost all Ryzen 6000 laptops currently on the market.
>>
>> Skip this IRQ override for all AMD Zen platforms because this IRQ
>> override is supposed to be a workaround for buggy ACPI DSDT and we can't
>> have a long list of all future AMD CPUs/Laptops in the kernel code.
>> If a device with buggy ACPI DSDT shows up, a separated list containing
>> just them should be created.
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> 
> I need an ACK from Mario here.

Sure.  As he mentioned this polarity change is needed going forward.
So if we end up with a similar regression as the Baytrail attempt to 
make this generic and need to revert we'll need to find a different 
heuristic to make it generic on RMB and later.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Here's some other tags to pick up too in the commit message.

Tested-by: XiaoYan Li <lxy.lixiaoyan@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216118

> 
>> ---
>> Change sice v5: reworked
>>
>>   drivers/acpi/resource.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index c2d494784425..510cdec375c4 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>>   {
>>          int i;
>>
>> +#ifdef CONFIG_X86
>> +       /*
>> +        * IRQ override isn't needed on modern AMD Zen systems and
>> +        * this override breaks active low IRQs on AMD Ryzen 6000 and
>> +        * newer systems. Skip it.
>> +        */
>> +       if (boot_cpu_has(X86_FEATURE_ZEN))
>> +               return false;
>> +#endif
>> +
>>          for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>>                  const struct irq_override_cmp *entry = &skip_override_table[i];
>>
>> --
>> 2.36.1
>>

