Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85D0487B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbiAGRos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:44:48 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:29782 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240348AbiAGRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641577485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85EdgHrgHg3qUCuA6FdAsAJjWEA2obgbOb8NGr3fKkU=;
        b=cZf1PP/j2r1Oq3FXoKTBeiAGKNH9617qCOYw9rL4RqDLSLIfYJDkBucnOpSZlL/Ab7RTtc
        uXFMTZqleE3hPivF5xhl27F99xFcsSbzS8Ho9gLz2BtaMPW5GHa/gXSluDDrEVeb4NMmCv
        zeFAZ1h2KOK57hX30tCzVOfCQ8w63vw=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-UYFNG53ANuOtGiJSmsWQTw-1; Fri, 07 Jan 2022 18:44:44 +0100
X-MC-Unique: UYFNG53ANuOtGiJSmsWQTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpCXTuvR/QzB6/HMSYejJE0d+vPSC99HT9IFb/lVKgNhIvEcF+MQUzrqFUbg1GpEl44C1xORXaHBZVaTwa/rKuOOp7yh/IZGSgFLn6qVc0OCkvdqrukvA4lzgWGMXaUSQpN2n+NB9KLqmInWbDr6s7dptC7KWN6j0wQgLoIIUBe9ETMGGHCVxHbif8egqLXSq/xlQ9fmRusHA4Q+GKPtS2Qj5PLei/XfZcLGh2hfuShOt4ZLEDfE6mHCfUudJKY9RRvcJmQnaP4pyXlZL6bQoogpE52z69kEd9Jc6QN2zL72opY5lwE03gFs2Hr3golEhnYV0Pj2f5RKk0ZxS5ELMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85EdgHrgHg3qUCuA6FdAsAJjWEA2obgbOb8NGr3fKkU=;
 b=Di5TTG3RIaUHncpPJVUGHS90w6TmflOAF5brJwxm4RBt2pciSo0jR1lhob4+Vdr7EcEExEDi8XcB6B+AnAk+LYbQTE4vWzlRSiZlU3M6dNt4wcgAHTONV3qRTdQmP3cJID/RYEQ4nT7cBFHvR+Oe9T2F6rJ2hBw7njIYXaO0He+126SMAQ6j8/Wzb1WWJXwiIy7CX+Z9EVOHsfpyA3OE4Wy168/Dz+oY/32J9tI7YTDbHOhUgMltxBww057CyYYzlPRYr2onchTfM7W2bFm49NayabjZDSYccpSnqf8wquV3wNtKycETTIq5uxnJDQmBgLyLE9lFhdT0zak2KrnahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB4983.eurprd04.prod.outlook.com (2603:10a6:20b:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 17:44:42 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186%6]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 17:44:42 +0000
Message-ID: <8e6f07ef-10fe-381c-3a8d-db497492036c@suse.com>
Date:   Fri, 7 Jan 2022 18:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v2 1/2] docs: add a document about regression handling
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1641565030.git.linux@leemhuis.info>
 <f71246e0999520d681c7b35d24f7eed2f53ee2b4.1641565030.git.linux@leemhuis.info>
 <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
 <1126ce91-f22b-c397-4d1e-13d290a424a5@leemhuis.info>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <1126ce91-f22b-c397-4d1e-13d290a424a5@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::14) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6029f87-da47-4d73-1635-08d9d20562f8
X-MS-TrafficTypeDiagnostic: AM6PR04MB4983:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB49832EE9DA7956BADA468585BA4D9@AM6PR04MB4983.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UXU/MSR7Bmm5YX3cCatDMFyYmDz6Pz9bYQLTvtZTLGrl6cjoPeNv4ua2PxvCjkvcVwE7j1Z10IvFtVb1kEB78CuDkZa/XVMbuHu4oMjLUtyiiV1/WaB5GnaF12MfGWyM5nlGHOobpLzBWQeY+JihM9Hqv166wj8PT6lujLWmHj0kMDgp4QfBgUpg3tNfc1XNjAnLqt2MUPmH/kdPwhnNLMtHCUN2kvClvruIpF0AhxyLkaaTFAMsenDr333sKzolPz5liFaYlNx2MUHHPIZn5s+ipmwA+liBGM0apqaV+zOb3ZbjQIeerjJ6gqTQOebUJEaP6ZBhYXKcJfVsT9CSOuGnlbg9GYNCbWMWdK10W948smKMwoUxjEOG+SBusx3iHwguqZOIh7pG20xJCEpTRBHalHiVY35nraWO9MyGXGfo6c6nRS3SwozyN31TPlWfaSjKZNOZB8E1fpO37ObmitT4prN2CbJQiAP9MqjlXu+TAvK/2gt8bQG5h8VdbXuVF+NaZ30Cnarqc5fvOp5yLQwgswiIZC1vMEBq8JyuZistYQFLspJdwK+fxNpT73hDsyMWAVNI8LPDY7mhrNmwMmwEk5v4qXY96OH7qLBay0kj2ZpJzaTckEeAQt4yb9V8PtvZ1HpD6+0z7h+xseWaKJbUsNtgT9kvGBWnQkOHovWgLyw1yyHpd5+pFfw6IpVJfm/j1tju+64bXeYY3zJeO54uxQ+hJMt+a5bf4ACLCSWcbuwFNvnfFDXJj3gZuMsMtgC0qca1vWyTljVpb9GEMAhI1asYjNY9TKkR701EADyI5nyvemU5JndffMxWM3/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6512007)(36756003)(66556008)(66476007)(6486002)(5660300002)(38100700002)(86362001)(26005)(8936002)(186003)(8676002)(54906003)(2616005)(6506007)(53546011)(110136005)(31696002)(508600001)(66946007)(31686004)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhJaENiQ0NpbmdBZXlzNmk2eUJ4Z1NkbTNtTWZoY2M1L3lhWVlVa29NbnNC?=
 =?utf-8?B?RVpPRkJkSkl6TXdxRUpNWTdURjkrOTdqQktXNnNDZngwcnVCQ0dKa1pMaGpr?=
 =?utf-8?B?c29VT0NkVjdrajFkZGlhRWk1WkFySkVwRS9aVnBGNWVHZU1GTytlWXpZNUFJ?=
 =?utf-8?B?NkpDMVJyUGdPbW1EeWo5OUg0dlV5OWVjQ3dTTHU3SFVpckk2ZnVMejdFV0l2?=
 =?utf-8?B?em01cFUvb3JlMTVveE1WWk1HU1EwV09RN1pUYlJ4RmVRdis1ZUN2Sm1rcHdm?=
 =?utf-8?B?bDZxSHFCOXdOZ2NrWFZrUmUzd0w3dFY0SnE1cVpJUVlQalJKMTJjdzhlaER5?=
 =?utf-8?B?WEJBTC9HNCtKYXQzajdHL2JuS1FINm83REFUVTJpNXhldmo1RnROVHhUWHRN?=
 =?utf-8?B?OGRDUCswL240Mmd2ZWp2SDczdFZMNmhnSEFtcVlvNXZndFA5czVWZ1VRc2s0?=
 =?utf-8?B?Qy9leGFFV2NSSzNPd2p5WnMyeTFyN1BnRVd3M3AxQmFicjcwN0dPK01TSEI1?=
 =?utf-8?B?YXNDTUlvN0liMktiVUQ2V3dCZmI4NWVpL2ovaGFoVmJpU0g1cXh3TUhFNHFU?=
 =?utf-8?B?Zi9YQ1kzYjRRNjY3bTZoRG8yQjMwRHRpY1JTZE5KMW1PM2JPNGgzQ1N2T1Y0?=
 =?utf-8?B?SHVZd1pkZC8xaGp5RUVOaDFkWmtWa25BMTg4SlFNY0xKMnJ6RUE5TWpQcXBR?=
 =?utf-8?B?b3RxOFVLYkRadm5nd1g5bDVyR2RZa2tZMGlINU1KQVArMDJMVU5rZVYrOWFU?=
 =?utf-8?B?OVAxdjFMb01HNWNLaC9YZFM3OGZ3SXQ3Y2RUZHdlUUpkdSt6Z0xhampvNnFo?=
 =?utf-8?B?dkRldHdzWUNTclZ6d2xldzdFaFAzN3dIaXdtSGFQL2FwQWFidnY4TklleWxu?=
 =?utf-8?B?TE9VbWl5U3lVbWdRQjE3QzRhL1pLb01XNWpWSE9EMHJjUndUMTJ3YzIwUnZR?=
 =?utf-8?B?RUdnYVRrM2g2UGJzWU9hSEd2dVhFZ1BDUmVnbktiNHlBTng2blNITmxnTi9v?=
 =?utf-8?B?SXVSRkdwYzQ3czlTWEQ1eFowNmU0c01PcGgwVUxybFh1Z01NaEFBNUxydFpL?=
 =?utf-8?B?eVQrb1BFaXNqWjUydXc5bzJmVGFoOURGUE5kdTBBVk9aZ1dERkRlZkZnZEJ1?=
 =?utf-8?B?clhIc0RITVJOWGR5YjBISGNkSDZJNGMyS25JSHNFTWQrbkFTN0NONHBvYkE1?=
 =?utf-8?B?cng3M3lRMXhOV1RkN21tb0RoNWptWnZaLzl0VDR6S0YxenNJcHdab0VjVmdl?=
 =?utf-8?B?SzZUWkllcEY1ZnJpTFZ0S3A1RE5qTjJPUTQ2QmRnYjl0YkM3UWVjRmRUM0w2?=
 =?utf-8?B?ZEd0UDBtMVROSmlxZHF0b1RNWlIrZnArZkFxUlJpMHZZNnZDSGNBNUI0L2dT?=
 =?utf-8?B?VmZRVk9jb2ZnaWdvWHJ3Q3FlUFF1YlZseXBhOElNc25UQVFVVk5jWEZNTDFD?=
 =?utf-8?B?c1gzOG5mRmF5Z0wxQU1yaWpnUHdKWFdmSnF2V0t3TWlaVFpWam00T1ZteFFn?=
 =?utf-8?B?bHlGaSswcWZCaUQra3Yzd3dVSEYzb25sMDZta2cyYnB6a2xIeFYvdjZCa3Yw?=
 =?utf-8?B?OHFhWXVXMkJqL3B5a0lXcnZVbDMva0gzNTdtT0NpTityaTlIOFF5V3FIUXh4?=
 =?utf-8?B?dmlxVXZIOXFBUGxZUE1kL3JFNUdHMkc0a2hhaEROeGViRTJxd3NJN0w4ZEY5?=
 =?utf-8?B?c3IxTVhNRitRcmpvZkdiVVR5OVN0eWxkOEY1cFlScVJ6d3owWnFSVGtrbXVP?=
 =?utf-8?B?VlhvZDh1UTcrOFJDQmJLb25hL0RLQytzRnF0TWZNa3FZd0lQZVFTaVp1Q1hU?=
 =?utf-8?B?KzVpeGFoN0N0aDREVnBvbFNTdy9LdUNMNjQ2WldDMlFYSUFqd3pLMG5yM1px?=
 =?utf-8?B?cWQ3c2Z3WDR0YnlMdnh2NHM3VVlSTGs3WGpZdjMxSy9NUXU0Y2szUER2ZU1z?=
 =?utf-8?B?N2JEWWZFK2w1WkJyNmk4NnVaZWV4Z2RScFY1OTJCcjhBOUc0OXoxTit1Tk1F?=
 =?utf-8?B?QVQvb3ozdEh3VDNHazNyL0JkTW1OQmxVQlUvZnF1OCtBT3BFcDJUeFphLy9k?=
 =?utf-8?B?OVR3MEE3cmZ1VFlHamhHWVhheG9oYzlBTHB2N25ISWxGMWVNYnppNkdtaElu?=
 =?utf-8?B?TXlrRDdnU2JiSmt2Y3J1YXMwY09yVlNBR2VYcWlKM1NtRzNVc2ZDL0VERTF2?=
 =?utf-8?Q?yoy7VkF/VF/b6qXKDN4qA0w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6029f87-da47-4d73-1635-08d9d20562f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 17:44:42.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wPaOMdcZSePGlFephK7Pn0SznJVQiacqqT87jU1se+NpB+hQPDrDSSaQPzXRgyHAS3/E+ZBbE9Y+UYrJiHhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2022 17:51, Thorsten Leemhuis wrote:
> On 07.01.22 16:37, Matthias Brugger wrote:
>> On 07/01/2022 15:21, Thorsten Leemhuis wrote:
>>> Create a document explaining various aspects around regression handling
>>> and tracking both for users and developers. Among others describe the
>>> first rule of Linux kernel development and what it means in practice.
>>> Also explain what a regression actually is and how to report one
>>> properly. The text additionally provides a brief introduction to the bot
>>> the kernel's regression tracker uses to facilitate his work. To sum
>>> things up, provide a few quotes from Linus to show how serious he takes
>>> regressions.
>>>
>>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> [...]
>>> +The important bits for people fixing regressions
>>> +================================================
>>> +
>>> +When receiving regression reports by mail, check if the reporter CCed
>>> `the
>>> +regression mailing list <https://lore.kernel.org/regressions/>`_
>>> +(regressions@lists.linux.dev). If not, forward or bounce the report
>>> to the Linux
>>> +kernel's regression tracker (regressions@leemhuis.info), unless you
>>> plan on
>>
>> I would have expected it to be the same mailing list
>> (regressions@lists.linux.dev), is this a typo maybe?
> 
> Thx for taking a look. Hmm. That's possible, but I (and the grep call I
> just ran) fail to spot the typo.
> 
> Maybe the wording is to confusing: regressions@lists.linux.dev is the
> list, regressions@leemhuis.info is a dedicated email address I (the
> kernel's regression tracker) use for regression tracking (which reminds
> me: maybe I should ask for a alias like regressions@kernel.org or
> regression-tracker@kernel.org).

Yes it's the wording then :)
Anyway I just wonder why you we should send the regression to the regressions 
email list, but only to the tracker email address. For me that's the confusing 
part. I'd expect to send it to the list as well and the tracker takes it from 
there. If for any reason someone does not want to send a regression to the list, 
then he can send it to the tracker directly. That's my understanding of how this 
works. If that's correct then I'd say we should just explain the difference.

Regards,
Matthias

> 
> Ciao, Thorsten
> 

