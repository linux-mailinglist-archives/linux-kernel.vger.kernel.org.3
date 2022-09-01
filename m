Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D565A9242
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiIAImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiIAImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:42:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80111.outbound.protection.outlook.com [40.107.8.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA334130AB9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjoYo/+BWCxBdwgj0gFTiI3nDAMOBX5M0e4SYO+IDGFU7j2b65E5BclHabTVaHL1sRUojAzJgD1YjkuOXZu8LhiiYYKv5BZpmtHOxeFxTJYyw7suCf15MzwSXgN73v7pdT1yZf/SVETDZN0FyHH90XMv6TxjeY2TU4PIFo1F4cFmVVYJe+JOgV54T9GwJ3R/sBdZyCS5Zv0dHh2RGlo/aTVQNusJOy05h5JX3p+Q0Ip84l5Mp/ROqGU5L20MW1epCee0w7NcgwVpJVZEF3mwGi9f34RVs6bzVceehtLgJLM89egQgDWRGbkAcDWJMPhJBvM+HStQCIseBK/T+Z3Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhokj4qEhrWR2R5XusB+WLqCDAPCr0rwwaKcebjsgOI=;
 b=k4ZvYMGlbHWf4Ta5ZTXsPmGgUVqVw/5hycOrlFznjjZ580HA0gQ4NFBTvnrhjiZq6SUmy8t3TKcphlNkaX8zjVy3O+AwBsSEzjh2TolIKwZQz1HT0zcKBhTrSA4IQGd/o6zcOP2VyVK1uoElcjf2cJKWTcZ9pJikFKWGqkV/AK3MfU9kLZYYo1sKr9VjR5jQUpDiSRFn2FFIGgTxAHX9Jx8dgYVR5KGItFfMgiQiWybusHLJQcfWjYiXXpDVyup1NKMrw+O5T8BBMKfWa2KGdqP2V3ISod+KAuTa/pPHLifDImsrLTFax2yYd8mO9fYRHLG6hqE5YaQYjWziRlj9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhokj4qEhrWR2R5XusB+WLqCDAPCr0rwwaKcebjsgOI=;
 b=g/oVnBqLJ57T3Dx4fzXhXxaYZL/C1gRj7yeUPBPhv+74//EAUK0AtgxLw4Y8a2HfuH4XQRRIbo6CGX9H6ezBR3QLXmPnvHO5oVtxLHH2ZNsLCuyJ5h9x6rwMWb2xvWle1BR7aMgWyUmQie6QTpHuu/+z05ZQEBZVIykAd3VESVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by AM8PR07MB8230.eurprd07.prod.outlook.com (2603:10a6:20b:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 08:42:03 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::b333:1f3b:1b01:50d9%3]) with mapi id 15.20.5612.005; Thu, 1 Sep 2022
 08:42:03 +0000
Message-ID: <ccde957b-20b1-2fd6-5c90-ad9ee4b8924c@nokia.com>
Date:   Thu, 1 Sep 2022 10:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
 <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8658:EE_|AM8PR07MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d10f890-ae24-4c8c-9aa5-08da8bf5d7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKsssqzQAOqqR2HjGsp0sFVz97vPnrS11HlnjSNIHBoqNFg1s1BZundSrm5p7XYLyI1olvGA9TxKrR/azIwYL+us9jaBsjiKTQQGD/6sQDqstuLvKtl0YyHBEJcMjDl8lqw+0S1QlyyI4Jmh3WS9H+sM4R/ukUcLeMTqcVlrhT94Rs3d+N0U5wzLq+sxBKOFdJPAmx2iHb/hvJfbzgHbr+KU9JL4Y/t3K/mYKh300FQR84Xp9IHw/TyFMP+ODopDldrw01TT+1PKYj3GoDkyLg8tpMhbYlPV8CYcsGyizdBy5evmDMyl8Diz6sa/3D1TSt4I7Ybbql1Mp3aZOxqUsT+VKNH8Nk67F/BG2INyxY3XyhVlkfBjpgtwFzlCaYxnH873TZf3b4P5rrnNoeof+pA/lM49IOu+aFxIY5u6PQFLD0ECGYC+Koi7Tc9+NKfqfH4sTxNQk184t1XQbN3Dah9Q2tM/TNtrpAFZ4gH3+LgYRgvFO9/aYpxCm/FqSVYefO5vJ2sLbFcC0Vpn43cXlE3od390NaThL2b0oFGpOWpQw9imnUb8MG30UQsXYh3VmxwgR0PE96cfwiMl2vmomLrJgtxKfgo5slY4JQGg3uROgXR9Vw90m6kDY8aBt39Cmf9f7zS6WHRUUKjNF6Kk0hZjQrBUnlmbRaI9AXw89frjYBVX3lUGoiDllHkXYiCPUuOM6dn5yWsCwPg0JqFtV20jlgYdF7rqhyFyr84OH41MNyn6ePJs68ksNz6rHNe7U6qUuL/6my7GJ8thD9w2krpBCP1P/Jo7kj9wEBNMjSqXrgKjrTXKGPZr2JFH8xk1imCH3fI61pqYuYU74b6AMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66946007)(82960400001)(31696002)(66476007)(4326008)(66556008)(6916009)(2906002)(38100700002)(316002)(8676002)(54906003)(7416002)(8936002)(44832011)(6506007)(186003)(478600001)(2616005)(53546011)(5660300002)(86362001)(41300700001)(26005)(6486002)(6666004)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZGUUpKR3BEdzZxZDNUQkk4WjZsZ21QbzlsUDZ6LzU0UnFocDVOdkdFdCtF?=
 =?utf-8?B?dXQ5L00yb0w2RzhuNHhjelA0dkIxWlJQUEMyUTZVMVNJK2hEb1dZZTZGZldQ?=
 =?utf-8?B?VnJtd1JMN1RrYjByeCszaEs5WEYvREFaajhPRS9pZ0RqZ0JJVzR6U2FkOWFL?=
 =?utf-8?B?dlZSalN2MTRjdjgvaFp6UzJvU1h2dVArR0JPUU5LU0hPUUhKQXI2SGpEWmFM?=
 =?utf-8?B?WDh4QkdHaGdvamNTOGx2NFF4M2NVbFhrenFUa05nMXVQNEN0WjhEUlNZZUlt?=
 =?utf-8?B?Zjc3MXVJUFk2RUhXUVBvaGNhN2dEa1pWTThqTE9TeldsRGFndVJzSzVFK0wv?=
 =?utf-8?B?ejJtU0pDQjVlbXZlQU03NklvanJta1hHQXdJOVdaY3IrbkRqeGVnKzQ0VnBs?=
 =?utf-8?B?MkNRalZwREh2K2crZG5QNVhMM1k4eS96eWNaVW9yamZhdFdiZGJNczE2TEh3?=
 =?utf-8?B?K2dKNitSUDI5cm85OTg3djkyY0lRZUtrSHZOd20xZGswUkdsakVnZEpKQlRr?=
 =?utf-8?B?bU9iMWJRcDIwVTYvN3Y2ZmRLM1NXcmpPZHBMaHBnYTM2UUszSE56WWpZOVdt?=
 =?utf-8?B?dGJCRlZiaTkwOFBnWFVhU0phejUrTVRvRUJ2c3hTZ09uV0RsYzNyaU1XSW9W?=
 =?utf-8?B?NkprRHE5NVFvZkdla29SVFJ1SW15WjdySHE0Y09jY2JEMEs4ejRHeFpmbEZ4?=
 =?utf-8?B?b0dCZ1RGOW0wRTRSMUVHSno0KzZCd3JUZjhsRU5tTUxtY0lEbnBTLzJQV2tK?=
 =?utf-8?B?SkdLSGRtcUZmTU5ZMFduYmU1azE1WTE2a0MwdExaQzVPTkxxTU4zYzNGWlk4?=
 =?utf-8?B?WFpWUjdKdlRTSGRLK0RSRjRlN2RRVmpCWk1zV2FPM2pFenkxdXVuQ01vbjZ1?=
 =?utf-8?B?a3ZUK0JySkhKdGhoRHAydXBrZTFzYWZ2dEVKU3V3WFhnOGpZblV4WS9RRzNm?=
 =?utf-8?B?ZENEcWcwTlo3R3hTVTA2NXc3OHFBLzd6YmEwWkx1NVUyTHJIYW9Vb3FBQTlZ?=
 =?utf-8?B?bFg4RU1uSDBvaWNXK2VQbWtJbU1EdzRaR2dVdFZDQUFMQXNENG1lUjBWK2s4?=
 =?utf-8?B?UkRybElhaEF2TW9GbnhkZ3pkNVFFMFp5YXl4V2NEaDViVW1vQi9CZmFPS1Iw?=
 =?utf-8?B?dkVhMS9jc3N6QS9vbGd6UUtIQndEeURKVnJXUUV1eHB1WHVueXVLcWl4S0Fw?=
 =?utf-8?B?UDhTVGtkVURWTDNzNmpMYVlQZlVNL3Q3aHNqdDJYb0p4K0xkUXovYmRxNlAz?=
 =?utf-8?B?Y1VvdjMzWjNCUGhIWEV4YWJIcnd2cm5Jc1FneHFOSWdFMG5TQWlJaU8xNmVM?=
 =?utf-8?B?YnlQK1R1NmlJSFJzSWZjLzQvN0dGWEozdm9FV1RLckd5ZGRVOEJGWVN6aDJ1?=
 =?utf-8?B?QTRuZzJnUzlxNWY0VFBJUllndWFyZ3A3MmtoZDhWSVFPeFFBemxvR1paSFk3?=
 =?utf-8?B?OVFLRGthM0hFVFNEUnFSUkJxc1ExN3hJbEdxSlU3VUdYNjhGVHIzcGI0MTJi?=
 =?utf-8?B?bjdzRW9HT3JPdU52eG5rOE1UNEtXakVsMXBlMVVyYW9TRGI5VzIvdlN0aUFG?=
 =?utf-8?B?WEV3a2Z1NkM5VnViQ2Z6ZmlHcUVkQmFOK2t4bDdjVW9xRGZwOTB3YXlxdU5s?=
 =?utf-8?B?bEFORkk5RmFZWXM1SVgvazd1ci9jQ1JhU1Z4OHpZMzk0UU5URmxIQzcrNnlB?=
 =?utf-8?B?Q2ZGdEVxNzdEbEI2TmRyY2JUS1F5Tzl6eExvRlZBa1NBc1ZERDJ5UTNhZFNz?=
 =?utf-8?B?N1NZOXlVUzVsMW03QzdDNHg4Sm1jd2VnQUIwN0RkckgveC85VHhad3RxUGIr?=
 =?utf-8?B?Zk8yYTB1TGpacjBTNW5FTi9rYTEzbnJtVXY4QnJYZlU5Q0dFMmdzaWYvVFFG?=
 =?utf-8?B?dGxXS1BGYmIxODZTRjdNeWlySk1QUVlvRm4vS2lubDVEZFM4YVZkVVZNdmxJ?=
 =?utf-8?B?dWFKU3liOE9ieC9CUEFsVTFFUUZCMzdIb0c4OWQwN2ROdFZjQzlHbjdMNlFI?=
 =?utf-8?B?RjVVOVl3WE80azBZUjNjOVhMV1RDcWI3aVFEZngzcDV4Y29LK3hjOUtmRnFz?=
 =?utf-8?B?TEErd0tKdVMzUFYzMWVsSGx0bTk2S0U3M1prcW9qV2RTQ1FscGF2RE5pak5S?=
 =?utf-8?B?QVV0N3ZOS3EreG1EWVRZTW1sQ0FHeXhXRlk2SDdoNlkzN0YzV2tjaVZiTTFy?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8230
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 31/08/2022 11:30, Linus Walleij wrote:
>> -       create_mapping((void *)MODULES_VADDR, (void *)(PKMAP_BASE + PMD_SIZE));
>> +       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) && IS_ENABLED(CONFIG_MODULES))
>> +               create_mapping((void *)MODULES_VADDR, (void *)(MODULES_END));
> So the way I understand it is that modules are first and foremost loaded into
> the area MODULES_VADDR .. MODULES_END, and then after that is out,
> they get loaded into VMALLOC. See arch/arm/kernel/module.c, module_alloc().

yes, but both areas are managed by __vmalloc_node_range().
 
> If you do this, how are the addresses between MODULES_VADDR..MODULES_END
> shadowed when using CONFIG_KASAN_VMALLOC?

That's the thing, __vmalloc_node_range() doesn't differentiate between address
ranges and tries first to recreate [already existing] shadow mapping, and then
vfree() unconditionally frees the mapping and the page.

vmalloc() KASAN handling is generic, module_alloc() implemented via vmalloc()
is however ARM-specific. Even though we could teach vmalloc() about MODULES_VADDR
and MODULES_END (and don't call kasan_ instrumentation on these), but, this is
ARM-specifics that it's used for this range.
 
>> +       create_mapping((void *)PKMAP_BASE, (void *)(PKMAP_BASE + PMD_SIZE));
> (Splitting this in two steps if probably good in any case.)
> 
> Pls keep me on CC for Kasan ARM patches, thanks! (Maybe I should add some
> MAINTAINERS blurb.)

-- 
Best regards,
Alexander Sverdlin.
