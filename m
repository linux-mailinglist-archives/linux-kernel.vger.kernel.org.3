Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4C54FC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383187AbiFQRo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382906AbiFQRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:44:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64240A34;
        Fri, 17 Jun 2022 10:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7U+UUDjNCAgxYciCmwvDRRiUITYX7/O4qOz9KHCqSWVkalYuuoQPUwQZYg+XSjSRn3H4VeIOgMW4MiJiHBGvKdqPGRKQ3brBGcFPf6fTyJQbQRi8RboLjDgDEUm2L1T/lHMWdUZ34XehTzPcY3yTAQUs2eJJP2txJzaboTgwo/hXSeKjcl35j5S2/AA/tav2MtkeyDccnXPBDxOLrihkU2Nr9PZEOAsN3W8rCW31DYbrUDJD5RipQZJFP2exwyrEOKeWS1mXBkU9YJGwmCfPNvo9L8StgOfksAFt+6xmo7Ou7/gfw5Goj6jkMepx3eQyr7TbsIZXe6+78lc0S+GZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7tVstiYDie+D8SCHlEDMtTgDH50ZaMvCmz17NuaX5I=;
 b=ajvR881yfNFepRBj1tWs1c7d2vvOMeXe5CKRQ+s3fYItqWaG4yXIhcJx+Rnsrgqm/RyRNKxkzrq0hjlTzKYjE13dIYbKzZbkSvheb2pKpRt3Tm2daIOWo4r6Ye74BAejT10hpRpCfGo9MHOe91W1s07W1GTtoqPXdBGircnhitdFLVOUiNV5uev2b6IODDESXGh2P14Oxlcrt3ozaab94KWApdElwZxo4X2AhdUghSunlWAOTfXokV/7J9KiPkuoT836RFgJd3Zy0G1T0lN92X/x7xpLIEahcyr/0iBpwvmlBapxmlDeXZ+UkovEOHb9ibG2X+qAOR3fNx/+jmo5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7tVstiYDie+D8SCHlEDMtTgDH50ZaMvCmz17NuaX5I=;
 b=o/4jpb6egxkQHSz6SgDhle62cJ4c2KHOpO3TdtlkeLIqUdIQ31AlvgMg2K5fC4vCTAMmotfZowzCsPow4JD/FBxX3qUcH2IZ5Kjc5X2b8NMGfqRRmWXAjyn9tL78x/WR4OsOXqwjMo3n3SWg71lgkjIz0TifzLW27ttFtozcv4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 17:44:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 17:44:51 +0000
Message-ID: <226c5a9e-4563-2ee3-5a8a-c90ea7098c6e@amd.com>
Date:   Fri, 17 Jun 2022 12:44:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Content-Language: en-US
To:     'Alan Stern' <stern@rowland.harvard.edu>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com> <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
 <419f8edc2a7744ecbfaa0728227db180@AcuMS.aculab.com>
 <ed0379a0-1360-4271-16bd-cde2e4b3372b@amd.com>
 <Yqy8UJ1U06jMUJiA@rowland.harvard.edu>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <Yqy8UJ1U06jMUJiA@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b35e31f-3fd8-48d1-cd17-08da508914c2
X-MS-TrafficTypeDiagnostic: CY5PR12MB6406:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6406F966AE70287D8FCDAEF3E2AF9@CY5PR12MB6406.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00hAu5hevtOqJOCPZIJZBtrS37dFxkCsQKLZBXUv5y05HXOkaggaNYfUSgsaBk5tWelBjtIKkfCsE3QymP9+HB8c+oM95XT34/CkVonNLLzxFffsocqI5/J7EKaymb+0kXithtHqh6AgQTejnRTRwUjMj5biXMri2miSEGU0UGM9kNEfIHtAbz1wunCjL/UwT5Qspk+1AlWp5zI3Wv9yKoGjU9SEG7ckMtm/mspqRf89+EquRkWaATKgYYwOh51vDAaxKrKPCSpqkxZPNpP0pYbW4HO+sEXWbmhHRj3Wus0zKDvNl7lsmmKGIATp50q7r5IlmVNkbu650B6CP3ZuegAv1rD+joBilcmp1K61WUNJvfYy47bELI5gBEN4XT2gdun9aayGCe4BNPo2fMCMTVe5EOnCKq5mmjI/ebaXrHTBf3Fkofv29umbfpkdZSWD+ZArQs9o9uVjsRE6HN8xrq6/mtw4ket4Y6FWqllP6v04uaBV9AnGY8QA1cSXWFQSyoaGDULMiYmULUsx4EI1SOnZKRN0clJ0gkRWQ+fMcruAlrtnVr5scQkOZijUacTbK/3mpP0JFjDm9GTWhLaHDm+ifmgKc1MhZHz1ThoFfkBrss9MAdXtlhPVQZFEMpkBtkJLiE+rS6CDe6Xx6qO6ssrB3IfO8gZVCi5q7qF0gFlXzeAiwXT06zgF0K8AmiNe/Xi0MBc1Ck4EyFFiSTxBd3GRQEsTJKOxu9PmF+BSIWiK6ITNiKG+it0BKceWWO7A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8676002)(66476007)(498600001)(8936002)(2906002)(66556008)(6916009)(38100700002)(2616005)(86362001)(66946007)(4326008)(53546011)(6506007)(31696002)(26005)(31686004)(316002)(6512007)(5660300002)(6486002)(83380400001)(36756003)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdwRTBvN2JKSnVYc3RSQ3N6TURSb0FhcWRsY3J3NnZIdEVqZ205ZjZRUXNM?=
 =?utf-8?B?dWpuRWtldUw5dmRYL21ZeW1xSmZuWEVvenppbmRkM3l2T05qQjZnYWlTVVc1?=
 =?utf-8?B?akw0aFFFRUdCOHRaN1FtQnZkMGs1RHR1dzc0bTFhWGkzdDd0bDl5Umx3dDlG?=
 =?utf-8?B?ek1vdGpOYzh0RVlFdnlIV3JrSWFmbG9ZaXZzM2MvNXA4Ty9xUE4vWEdvcENa?=
 =?utf-8?B?Qlo5SE9VTGlncTB0eXZCNUNiQXFITmt2VWRERGZyVnBwQkdxdmlxSklDdUNL?=
 =?utf-8?B?dUZqeXN5VVdQRW0zTVFaVHY2alROUlJRdWh6SmMyazJOSEM5NFMrWjJyN045?=
 =?utf-8?B?dlI0aDg3UHVyRHJPMzFjajVXZmMzSmlTcmZJNTBuZ3JUWEFVYk0xaHI1aHpR?=
 =?utf-8?B?dTVvYU5JaGVRWFEwelZ6RnVVYXV1aTlSSitSZk95Q0hsQ0FacFplaTRRUXhp?=
 =?utf-8?B?bWVZek5mdkNkaWxCT1hRbmV6TU9EVTNteVM2U3Y0czRtS1NMeHMwRGxobFB0?=
 =?utf-8?B?ZDBMR0F2ZUxxQVBxM1hEOU9rdkx5VUFNeG4vU3Brb0pUbjQwc0dSdXFzVklG?=
 =?utf-8?B?VDN3aElRcEpHbDlLTkZTeFBVbm9JeCtMdlZGeFpENGJEQzJxNURRTCtVbmxr?=
 =?utf-8?B?T2JBNFVHQ0ZMakhFV043SVhGMUpFdzgrYTlrd25SRGthbzl0b0RJN2NjN29G?=
 =?utf-8?B?dXNBaHd0cndjS3IveGl0TXZKcjhEUGJmYkNsN1BoWU9hYmRvN3lBVEVsVzBY?=
 =?utf-8?B?TGRkVGMxdDlMRkhOVXl6N2xTSmlHMDhkaUFLaWtKZ2RiQTZGb2tHeWdHVTN1?=
 =?utf-8?B?eVdRc1F4Wk1ZV3Z0QVU5QVFhRlhIMXc3b3p4TnVMNUNkcEgyWTdoNGJ1c3dH?=
 =?utf-8?B?eXBYamxnQTB4TkdkRXA4VXU5djIrQ0tGck96cGROVVBNem1rM0tGMlpPL2RC?=
 =?utf-8?B?SXU0OUFZU1lMdXJ6a2JxTlE3dVFuZURzU0h2SlFmQlcvVi82WTg0aGJMaFpV?=
 =?utf-8?B?aXZyUXpkbkk0cjh5dDF4KzU3TXdNYU5JL3VMcTltVS8rVDZ2ajRGSTNCRCsv?=
 =?utf-8?B?SGJTbUhGU1lqN1BQaERsS2U5K3pXQnBXSWYySGpzYkkyZXY4ZzJ3d2kzYTRs?=
 =?utf-8?B?NFBlaXJWQis2SEx3bTVkcENPWU0wTVFoVjVoMGpLVy9Pd3RsNTkyNnpDMENJ?=
 =?utf-8?B?OUxOVjBlL2k0YzJzWjRuU2RId2NzUnhlOHhLSHY0elZpZDZSRjNSK0sxSlR2?=
 =?utf-8?B?Vjh5aDY4WHN4RkZENENCeW1yT1gzOHhPVlNZMEdlZXlRcFJMMGxQWk12eW9K?=
 =?utf-8?B?MEVGOXBQS0YxTDdWaVNHR09KUUp3aGZNb1lHOXNzdkNkMFFzRW83THFsS2di?=
 =?utf-8?B?MGJBKzNqZ1BSNDJXSEtMcVNuaEJGcTFCS3dqekNjR3d1b3lzTGNOajBLTTR2?=
 =?utf-8?B?Zzd5QVg4MDl4MUkxVU9XdFZYek9UNTlHZ0VNSnA4ZWU2b3Jwb01GNGViMVVT?=
 =?utf-8?B?RWxWTXp1dVk3TTBYcmJGZXdCUmd0Rk1INGpPdG55OU9SN09FeC9ORGRPSnNz?=
 =?utf-8?B?eHc3NnpESUNybGlpeTg1VDFGL2hzWDZuUmRWb0Y0Q3dOemExcXl1MGV1NFZj?=
 =?utf-8?B?TWFqalZGUnh0WVVtZU5GakgrVFFMVDBnM2NBU1Zvd1hXQXNYaXo1RVArS0o1?=
 =?utf-8?B?MU56dW03dWlPZit0UUw3VDZndXpENHVNTUk4UGlRdnVSckUyMDArcktPaXFi?=
 =?utf-8?B?NzVVMEtEK1Y0WG41ZnV3bDJxMUV5OUZlcklxYlhsaWI5bkJXUUE0aUJWS1Nk?=
 =?utf-8?B?VEkrdmdURWlKQXZzaklreFk0SFlCR0NoeVBkRGRnZkwxR3d1aExMQTBONzNr?=
 =?utf-8?B?L00wUjhUdlNBV3dvS2R6NTZRUC8zanVjZ2FnSHdHYTJ0VzJLaHF2UWVUd0w4?=
 =?utf-8?B?ajVyai9sYjcxM0xndVYwRFVmZmJQVkl4THJOVlgxRloxU0U2L3RsNHhtWHFO?=
 =?utf-8?B?SmxRMS9oRFB4aXpmQnNZdUF0aFdYY1Z4YVppZkVuZ1FQWGFGbXBKeHdOMkxL?=
 =?utf-8?B?dTd1Mzlnc0RYRkh2dnlHT2l1d25CREtsaVY1SEc4Y3VUWkRiazR2UmFWUUhX?=
 =?utf-8?B?VzBYSFhzLzdPZzN0ZXNCSjNDMGZCK3p1RTY0RmthUFAvS0xlK1lBQVZtc0Zl?=
 =?utf-8?B?cGVud25pVldvSGVEV0V1QTlhVVdMOTZSZWg3ekF2aVFxV1o0UmVlNmhBdVdJ?=
 =?utf-8?B?WlF5RXoyeWFhNnZUYjFLR2JkM3BSRWJsSThKQzNnbVgzV2NuckFmK0Y0UUpX?=
 =?utf-8?B?eVFWbSs3UTc2clpzMmZ4c2Fza041cWMvd3BHaU1yVkczeldJUEs2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b35e31f-3fd8-48d1-cd17-08da508914c2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 17:44:51.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnvKHrlb/1XazS1tQ+8khnMC8z5gjM6k2CPr/b2O17maGU2CsR3dPfRgQA8FEc30cj9hEIruF90kxB5rThzV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/2022 12:39, 'Alan Stern' wrote:
> On Fri, Jun 17, 2022 at 11:06:05AM -0500, Limonciello, Mario wrote:
>> On 6/17/2022 10:39, David Laight wrote:
>>> From: Alan Stern
>>>> Sent: 17 June 2022 16:05
>>> ...
>>>> Another issue is whether wakeup for a mouse means pressing a button or
>>>> just moving the mouse.  For a mouse that uses LEDs to sense motion,
>>>> moving it won't generate a wakeup request -- USB suspend does not allow
>>>> the mouse to use enough current to keep the LEDs illuminated.  On the
>>>> other hand, there's no reason why wakeup by pressing a button shouldn't
>>>> always work.
>>>
>>
>> At least one of the Logitech wireless mice I have here works to wake either
>> by clicking the buttons or moving the mouse, presumably because the mouse is
>> battery powered.  One of my wired ones works only by clicking (which is as
>> you describe).
>>
>> I don't believe there is going to be a way to have granularity of which type
>> of event will wake the system; it will be hardware dependent.
> 
> Precisely.  So if the point of the patch is to match users'
> expectations, and some users expect to be able to wake up their systems
> by moving the mouse but their mouse is like yours, then the situation is
> hopeless and the patch won't help.
> 
>>> I'm not even sure I want a system to wake up because it's mouse
>>> gets knocked.
>>> I guess a mouse could include accelerometers so that you can shake it!
>>>
>>
>> I'm completely opposite.  As soon as I sit down at my desk which has a a
>> closed docked laptop, the first thing I do is use the mouse which will wake
>> the system.
>>
>> And if you take a step further and consider desktops if you *don't* do this
>> you'll have to find your power button or use the keyboard.
> 
> The usual counterexample is laptop-in-a-knapsack.  You don't want the
> laptop to wake up just because the knapsack was picked up and that
> jostled the mouse.

But who puts their laptop into their bag with a USB mouse plugged in?

I could see leaving your Logitech dongle plugged in and forgetting to 
turn off the mouse before you tossed it in your bag.  However, the same 
problem can happen with a travel USB keyboard you forgot to turn off.
That's already set to wakeup by default today.

> 
> Overall, it seems like this patch needs a better justification.
> 
> Alan Stern
> 
>>> I've an idea that one of my systems manages to boot if the mouse
>>> is knocked (and it was last shutdown from windows).
>>> At least, that it why I think it is sometimes booting up.
>>>
>>
>> It was probably hibernated from Windows rather than shutdown.  Windows tends
>> to make this "invisible" to the user.  Some systems can wake from S4 on
>> certain devices, and I would expect some registers on your system have been
>> programmed to work that way.

