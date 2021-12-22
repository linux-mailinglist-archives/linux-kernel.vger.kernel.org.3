Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A930D47D462
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbhLVPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:51:03 -0500
Received: from mail-vi1eur05on2120.outbound.protection.outlook.com ([40.107.21.120]:23604
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234501AbhLVPvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:51:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APwSU4znnbG7e+kaODt5Ze883dU2yK2moNNryawy/bwdVyKS0EiC6hquUOLdtei44rI4L8VUTzJBAcx/yrey5q9z+l65qR1d51QY5oCyfmWvYznjsF2kCa7Fx32Ifp7TuQmL5kUAv+u5KVChOVPOC+RX6hzvQLzsCXfwr75l+fGcpiCQYoicLESjHEZWE3tjB3ZzJHY8fhizx3jVmtg8aze8DLIpyQ0nb83VLBrzMaR1I2RH7OO7az+dvJn9ZNVKgSedE+A3KBd8PM6izfQbNe6lgkSWTkIMZWjiTvSfgUiUWPllgN9AAXTiN6xFkeHaAHGBk16TSt6iJvHr6pGycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmRpDMkxgj95zrIXFUDSIsILLwNoz4f/TsuVbvERAJg=;
 b=TUVyd3thssrlbGYc9OdhCIxy4eVxNDbuge2zIQKYo9+qh0XPGwoax+12qO3J1hmNdCaiz27G5aL8jsV+AR+pWlnisK26K/Yow4bHdv+hqoDoz+dcy1Yi5+YE3RM290dV03I3fJ+VAnuJ552cE3JFzKig0bNkdUKFA1fs/wLJy2ipnBDmts+1b6A3IgSRMnHOFKzI0KAfKB9B3kQ7nqTZCCTHgYR2h0EQGlgBDRF2qPJBiblU5UOVC5aLhjBrpi4eYJOY1b4MWVyzeWJxU1LXqGle9YFd7qT5rQTB/uClGk0G7e+cnfxFCN7s9Yg32PQHHAlTczhhF9HjWyhcjH0Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmRpDMkxgj95zrIXFUDSIsILLwNoz4f/TsuVbvERAJg=;
 b=Y0gnUbF3dBnRXJmsOmhjiUMlxW1MdWpFsNnbu+EnRdPTIkOHg4G+7VUj3xLqsFSg8ufqp16FQRt7MT1LsTnZzd9ZW/g357o1+CoULizJSnEzElbv94B4fonkkg3YfMDluyJHWw/DR+0yMjdTrRLFzfildChmFCwUwKB0W01s0V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR08MB2680.eurprd08.prod.outlook.com (2603:10a6:6:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 15:51:00 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 15:51:00 +0000
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Manfred Spraul <manfred@colorfullife.com>, cgel.zte@gmail.com,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, rdunlap@infradead.org, dbueso@suse.de,
        unixbhaskar@gmail.com, chi.minghao@zte.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211222081026.484058-1-chi.minghao@zte.com.cn>
 <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
 <1181e64b-94c0-908a-b9e9-1a38f4610430@virtuozzo.com>
Message-ID: <02171384-9d1e-19fa-5fa1-5f84b720a03e@virtuozzo.com>
Date:   Wed, 22 Dec 2021 18:50:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1181e64b-94c0-908a-b9e9-1a38f4610430@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::28) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88137960-2ebc-492a-04bc-08d9c562d995
X-MS-TrafficTypeDiagnostic: DB6PR08MB2680:EE_
X-Microsoft-Antispam-PRVS: <DB6PR08MB26805BC060B50CF173E53F20AA7D9@DB6PR08MB2680.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jnRfsZ2D/WEiBn8qTHsyp9Gdyo23chjav5KIkf3y4E43qRBNQ6Mhxwj1Ko1p2BHki9vlMLkBSaoYteSCSUB0L2zJMq9fYhhbxHviQoVFbunqbQPhN1KS45/X2Crbj/eE0utnMxuU/QRi+qWUM1YXBDIt09t1Ima6NYAkCH7Ub9VZCNzNMRK3s74d0TaYhgblqv0ykobhuBJMr/HZyvIFhF8tvZL0mu68or7R1elrf1CTENcakmWZAkIIXJt8o0yuR8pIHHf22u7JJQ6gfcnQQgK03UvtI//cnQg/LN+xrwtW4sVsanirL8npRWFY2Q+RRckSa+B9jO28ttto2v0VC4+0DFQYabsEfaBrm21MfLZDZTkvHkFe5mbNru4J8l0AOBzUDRQZZP0+FK6zAxndRSXrwSHIjPrVhuM5AxhLSehnKwmpzHak0vlE8cF/LDsYbf7ej0+BM1HFkd3N81MVtmgp0FWGech3ikIoixza/PTqxZyhnspBdzn4LF5oTotRoDm4zDZFf6wGoqDzJeh95ZAckI0iF1OzwW24+3h2XfM6ByeGM62p+71SqIf6JhfTeIQQT8UaA12zPng99RhIRPrW6HuKAZT9SzV5qN/wmZhXVdLlVXTq+gkUJK7Td5lHy6//20e6gAnJXR1uOfggvn0oBxv7cljkC/VNX61n3jUYdrOaHxwOe4DQiQ6U5YCu8JSC3OiQTqC34wAUJbIhew3aO/FvZlF+cVh0tUzm2uIDB7czuJqmUKqecbjgw4XlCUTx7gv1OegDOy/QpilTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(316002)(53546011)(31696002)(8936002)(6506007)(36756003)(186003)(7416002)(2906002)(66556008)(6512007)(66946007)(2616005)(6486002)(31686004)(38100700002)(508600001)(86362001)(66476007)(8676002)(4744005)(4326008)(52116002)(38350700002)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURZNE5jNUxlK1FEaTF6Z3UvNVg4RlpSais0OXhKelJYSW5aVzFYSU50VWhz?=
 =?utf-8?B?ZHdxVk1NamxwRFRXSGtVUnI3Snh4eUN5RE1oM3dwVG10c1ZCWmhvMHQyZ3Vm?=
 =?utf-8?B?SlROMFpZK0xnYlZDUW9XN2MzT2VXMnI3MHVRZE02RXFQOTNGYk1QMFlvVGov?=
 =?utf-8?B?YXViemVVUzFCVGZBRGcrakVaTll5UDNHNS9VWGNwRkN3NEVkWkh0M0dYbWtB?=
 =?utf-8?B?d09DSVJHNUNtcHZiMUFuWlh0N0g5N3dTN2VZZXJ5WEJuOGJobXhGSXk5cGlO?=
 =?utf-8?B?MDBoNzlOTGRvZ25rdWVkRkQ3L1hsZkZPQjZibnNjQWx6V0c1bk1CSmlzb3Vm?=
 =?utf-8?B?YWZhMUp2UEFnKzRLVUk2YlFBR1B2ZE9LSFdoY09XWTQwNHZ0Yis5a0pteGpK?=
 =?utf-8?B?NkZyMVQ0TFR6RFFleDUxcW9XSGRjUStTbDJ4MFZZeit1UlJHQjRvTkIvc3cv?=
 =?utf-8?B?UnoyNzBvUGI0SVZ4WGVYWVgyR2NJeEplMXVsZ1UrQ1VvMklqM29MU1gxZTF3?=
 =?utf-8?B?UWFCSDhLbEoyMzNnQjdRUlNzdFJqcVRRdHZkQ1U4VEsyZVNrOVdWbXQrZWZ4?=
 =?utf-8?B?N3VyTGtrVXYzOFhhMXhONjdhV2N0bGEzd3pORzRUUlh3YzZacWFyd3RaeGdv?=
 =?utf-8?B?d2UvU0VOZU5MbkU2OWhxRU5QMkpXNjN0YWVvQ2JIODFYN2tuMm52VXErbW1W?=
 =?utf-8?B?L2NhTUZXaDlLL1BjUUhyb0Qybk9FdlZxNDRoZXlNSlNyYmpjZHZMekkrSndU?=
 =?utf-8?B?RUhBYzdoRVEweENMbWZwaGpnOHNBb3I0T0lETHRZRllaTzBzTDVlaW5KMHBR?=
 =?utf-8?B?OGFuTk9IWnBLR2VYcmR1OURTN0g4Z2dHTnVrMlBXWTI0MGVkQlNsQTRkb1Zs?=
 =?utf-8?B?bHNIaVpOSXZ3dUVhN1gycE5KYmFxdElLd1huVHVoQk1TS1hTZUtmV3ZYclAv?=
 =?utf-8?B?cnRKTTE5cDRkVVVjTTdUMTJXN1BJaWtsUWNZbnZ2T1BldHNYV2g2ZkM1emR4?=
 =?utf-8?B?OG1abkY3U2Mrb0U3TTYvWVAvLzBndEUvejZLV3dDaVVmd3ZFMUVCd0FZdkJz?=
 =?utf-8?B?NjF6WS9HNUlGVGFncUVJanh0L3RPZGM5d1lpUDRvNisrbTRrbENvM2tJazhN?=
 =?utf-8?B?d2xhb2dORC9kdzBEaHZidmp3ZXFWbUlXbVFPVjVvT21LSGVWbHozd3lmSTRU?=
 =?utf-8?B?ZG1jbWVZRHR1RkdYaVNxTVBNcCtUYlB2YVhnZ1NuUko3T3JWa0VxTlNXREhH?=
 =?utf-8?B?TFFLQlFpdlc4K0cybFFORWxxUG5OSWl0RnFiWmx3Znl5YWdEZGNLZThhMGM3?=
 =?utf-8?B?dW1qalJPa3RwM1VjYjE1eVE1dkVZd0xqWmNaZlMyQndKNnFFTHVZcmlSTHo1?=
 =?utf-8?B?YjZEOElNcVh3T2Z2eGdKNlRHVlRQTXAvdy9QZkRLdGdGZ25WdkxmRk9sblNZ?=
 =?utf-8?B?dnBqenEyd3k3T05pRUNDV3JKUzQrVWJpdENEaS9wWWY2MGNJU1RYZ1Y4MUdn?=
 =?utf-8?B?U0tnY05HTmo4WlYyaU1QZGE4ZEErNTNOeThxTldCSWdQTWJMSjA0Qjl3NVZK?=
 =?utf-8?B?Z3BjOXByQUZGUG5IdzVybnE5a1Y2dGRHemE1K0h5b0E2K2pUOUY5U0JTckRN?=
 =?utf-8?B?Mk04V2Z2ODlreGFwenF5b294VVpYdDdKRjEwWUJpWThwRlhmY3JUQjBiTmhm?=
 =?utf-8?B?V0dXUEgyckpGcFd4eGEwa0lqUldXOTRneERIdk1nTzN0UjBWdXRBcXhkTi9R?=
 =?utf-8?B?a0xTTnZEb3dhYnh6SXNnSWxNdkJmQWRHbXJYcGJ5dFRDWFRzYlJoOC9TcUpK?=
 =?utf-8?B?VnBCbUdYY3VIRTZjZ3FDMjNCRWtWTGU0Z0FqSU90NHFFMlAzYi9PUzRUM1hl?=
 =?utf-8?B?dmxGakt3V0tMdTNnWHdhdTRSdHFyTW1RSy8yNzdBUjdLN2pYUlE3YTdpOGV1?=
 =?utf-8?B?WXpEMWw0dWtTK210eTZFeU8rSVMrSFA2SXFNWTBPYnhxWFZLR2FQbnRBK01I?=
 =?utf-8?B?ZEIyeG1GdVlCUytIUFR3SjF5NGp3cWN4OU5nbDl0OTFPOG9XTEJwMmhyMG5y?=
 =?utf-8?B?bnc1QUxJTHVKU1RUSFZvZlFEU1RRREcwQVc5ZkNYMzBCTHZMOXRERHhwaTNN?=
 =?utf-8?B?dU9LcWVKSTF5WUdlTW8yUm5PMG1tNUM5aWFxYVpDNFU4c1NNZEtIdC9XWmxR?=
 =?utf-8?Q?SuwBEFeN8qnVyYQpCU8a4EU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88137960-2ebc-492a-04bc-08d9c562d995
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 15:50:59.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yIA8sO4FKRlbaGncHPhaOpD69we7ew203ekhQt+UyCWwvUkA4CgfF8SU9tcLz2d0GkFWUUOwWsBy5WspFlc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 18:31, Vasily Averin wrote:
> On 22.12.2021 14:45, Manfred Spraul wrote:
>> Hi Minghao,
>>
>> On 12/22/21 09:10, cgel.zte@gmail.com wrote:
>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>
>>> We can't call kvfree() with a spin lock held, so defer it.
> 
> I'm sorry, but I do not understand why exactly we cannot use kvfree?
> Could you explain it in more details?

Got it,
there is cond_resched() called in __vfree() -> __vunmap()

However I'm still not sure that in_interrupt() is used correctly here.

Thank you,
	Vasily Averin
