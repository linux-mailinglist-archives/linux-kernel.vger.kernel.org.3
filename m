Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40047D430
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbhLVPRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:17:37 -0500
Received: from mail-eopbgr20107.outbound.protection.outlook.com ([40.107.2.107]:17538
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237912AbhLVPRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:17:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEg0k3dLOdC8X9aGbBsnHi/r9tlDpkLhFXO/48BJekI2L+drxHoguwTFhAh1zil0cldGmrZgFcrajp3OZZMICXhg4DUFxaJLZvdIpMAnllE90kivnjT5VJZwTT69M4ct1yyFClbDADvCJFPrWTwZm8Y85TQJIsdRGHgTolDqhcesQwI+jQGXazHn+sIfwsUABQkzii60KE2+y0X8pI3VbdSvOffALi8jQrxlzcWJzLWFdM+xz/P97iC63iwlZvD31xC6ut2qedBgNh4NSk3RqwMqdympDqiPrlaCskjUT/Kv3CoCQlyYvgJG8cejMvCA5EyBVbb1XNa9eFgwae+BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+BXfke3cVzkt8Yx56xKjFBMMT+PTtNgHbPtNBl4vZg=;
 b=njj3zMSrG/MmqUek8YqE95f6Nr8dKL9TIun8udFEHxjC0z9HRe09JfS6hbqkRDpcM87FY9AWK2dGZnEqOg6JnZaLf/GICoYumqvTnSamiL5Y4R1nCH8gwN5q23xQ67PLp/jJZtF2oKaZGiPZF9jgFzhVoifGfUhtEipMbo4GuXl7xnUcPaWjW8uPGR9FmrUz2xgpx7T3h3MrbxtqT6WNw5JBG9YOpd3Z64vtiRAGNWiZq8f3d3NBqO8AzPwrTrE5hvO8TP0eMAC8GalahaR4b14ngWJQEkLn2BuMSWi70rmJSwiT77lsn/+E1nyOv0vxNVrTUdjGHHbjUX/YoUILxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+BXfke3cVzkt8Yx56xKjFBMMT+PTtNgHbPtNBl4vZg=;
 b=L/WpNRdyqac+68FVNLZ49OQDaj7suyjS2D1+fyhHbWk5npADLnaiLeXfWVM24BtmDIVipNOq6Z9kQGhpFORHWYgj0wA1ekZckwSSiGLxeHAtkvRQ7APikS2qOI6ShL/f9HPqn0Z/RdT0y5yHRryl4aDBliwchF9Jag/KrPTRke8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0802MB2309.eurprd08.prod.outlook.com (2603:10a6:4:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 15:17:32 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 15:17:32 +0000
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return
 asynchronously
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
 <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com>
 <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
 <f210483a-69f7-1983-65cf-f3f5bd4112ac@virtuozzo.com>
 <CAKYAXd97orfDc7VA+fae7tLjTufMksQTepYKazY=gX7UkG0+rw@mail.gmail.com>
 <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com>
 <CAKYAXd-zBBF_J-z1Ph4ruRD3Fb3EORsKfDjKw0yX42D0SCD_Ow@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <4e61a114-d55a-3c14-e019-83891c5b1f0a@virtuozzo.com>
Date:   Wed, 22 Dec 2021 18:17:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAKYAXd-zBBF_J-z1Ph4ruRD3Fb3EORsKfDjKw0yX42D0SCD_Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0189.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::14) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1336e7e9-36e1-484e-1545-08d9c55e2cd6
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2309:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB23091BB0BFFB2DEAD4FC146EAA7D9@DB6PR0802MB2309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHYOa5cKeAoEafsc0MOThNy1NWrzWQazRfoLve4dsKAQ9GiqzOpCn3P1+uELBDgnpsrzlqRWz5zgEI9rtWQJL66S9MwUCM3R8ewxdBAdWkYxWQ54bjnkq1ckzY1qwNTmtiFOHH4589XuhrGdvDxpanDGOsl4O8zw3Qua+Qkqi0DdsbaDPzFktd2La93We3tRKlX5JwhiiiMGFPUOt86pDfP2qvOhOrAxBeMcq3iuep9Lgk1dQTf8buiwOE8BSiEJX7gHrjpoLsa5POGSS9xD++3XHK7y3sQGK/NgF8Fg7jRH4qFh1dP6T1BmEQNt+01Ton8R/JCBhpp4bylyRV18T99q8zofYAsixqiGspce63KpUEymCdYyFcd28m24r4cAleGiM99FoFCXYX6INV6lUlFtNg2qSrbREys1VcplSf1nPDpJBN2moyTkxntPvgr5KtTEu3FAFC1ajXWs2VFGhfvlCAUsl2xGXG2ksso3CwmrzD34mP9ZNTvowbP3/9YMOUoP171ZtDwaNHI4WJxuNEQAcrJxb19j0DD1ULFzebGssdzGxgpw4pbYpj+dSkK87GoHlhKY63tKW4bxzyE0zZlD2/8U0UnOX+HNJwXiwFckBnlru7FG246QxdRkH/1fVDU2adtP5KLzVA7cU5DC3UrAVoO5P28M2GWslWTTJGPIMa+7JJbrx+xQyNdSq+ZwQxodwaBsXMWs5ZxW1s5XM7MOJ8vaSzZmlEzGxZDfmQl8kTFeyTYCgl2ORgtKIyuZPZJ3ptHk/CcMb06MTUuzTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(38100700002)(38350700002)(6506007)(66946007)(8676002)(5660300002)(508600001)(6916009)(52116002)(66556008)(66476007)(8936002)(54906003)(36756003)(6486002)(53546011)(86362001)(31686004)(83380400001)(31696002)(2616005)(4326008)(2906002)(6512007)(316002)(4001150100001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVGaVlUcm11S1orZmsrYWFNZnVFc1VpMjZJaWQ5SUk5QldsU1g2OUZGRkJ6?=
 =?utf-8?B?SjB2bWRxRFdQVG8vUWVFcFl1SFJqSnhUUkRGaFBlMm9pa0I2YWVqV28xRDJ2?=
 =?utf-8?B?UW1TTDU4TDFjZm01akJzODZVQ2YzZEZnZGY2dDFRK2dLemh6a3ovbUprSzc3?=
 =?utf-8?B?MVJ6YU1EdjdvbFFFcno3V0h3V3hNZ3NVOU5XQWxPekQzaFVTb3ZOVkRRcm9l?=
 =?utf-8?B?a3pEU2Y0dEpGMU1rZXdrTGhYcGN5OXQ3aHFKeHpGOTY1M0pwYmtPWk8vbnha?=
 =?utf-8?B?Z1dUTkVNK2lKZFJ5QzVTRzBlY0hiSzdOQlF3NjR4bG9vRUVybFg4OWc4bURu?=
 =?utf-8?B?THZoUzRsU1ZTbkw1NGYyRkt5TDJuYjNJUXpnQ21qY2pRN2hxMVlVZWRnWUU1?=
 =?utf-8?B?ZGFaTm5mSnpDVkVNeGRGSkxmbnNyOTdBMlo2M0NleWZKUDdsNjlSN244bzBS?=
 =?utf-8?B?ZTFxak1OVGdMUVhzTUlGKzBqL2FKTHBOcjJYYUJoWU14cDlXQ3pzSndBaThB?=
 =?utf-8?B?VkhKY0o3VGE1TWhyVkFmUXAyR2R6bllNajByWElRdUxQaW9Ub3N5dXhodUFT?=
 =?utf-8?B?T2VsOGI0NGVpanZrejVNNzlBb1BkbC9IRjl0YnF6VC82Lzl2OXRHTjVuNEtY?=
 =?utf-8?B?WGEyTTRlZjJlTnNnTzZTd0pidUhEZjZOamd5NVBDY0tyTlc3aHdpTTZQMDEz?=
 =?utf-8?B?OHhCWW1mVEhsM1FoaHRXSVZZOTAyZ3lqY1hwNTRDL2lMK2FzYnRqa1E1VFFt?=
 =?utf-8?B?NHV6cWs0d2R3elh3Mk0va1ViVXdIcGhPRHducXNlSGRhdW42MTNUK3FOTWd3?=
 =?utf-8?B?TW5QRk5qOUw3Y0l4b3VaMWJ0MTM4VXFRRXhKM1FRWHc5eXNMTjFpdVFBZDBO?=
 =?utf-8?B?UWY4cjdCSGdWZTJOZjZMN0JDb29FeUJDNUgzTStNN3hPUDZiMnlhUkdUczkr?=
 =?utf-8?B?N2RMTk1hNW42R0kxU0U5RldVS29UQXZXT0c2ME5xeExjUUxJK3QrejdtTHNZ?=
 =?utf-8?B?MlNkOGZuVFl0NjRrb3lra0RCb3poNExGTi9wbHcxd1lwYnkzbnFUZ0Zzd1Fp?=
 =?utf-8?B?Q3RBSXhiM0YyclkwNUdhRFpZU2ZuWml3WnZiTEhkVFduTDJkYlFlWlZuWi81?=
 =?utf-8?B?dGVCbFY1eTBka0pWVHlJMDZiR2d4Nm5DNVRJMjNjbk90ZGl4TDl6NUQyc28x?=
 =?utf-8?B?UEdzWWc3MlJKc2NyN0ZocmpKS1gwRUpWdjlqaFdCdDJyL2dlbEJZYXA4ZUwz?=
 =?utf-8?B?WnBYQjNCQnpjU0NzZ3QxbDV5aWZPVmJUMjRneit0aFQxa0xDL1lWNGxwR0dx?=
 =?utf-8?B?WHkzRE9yelJQMGEwc2xFTU94ZS9IdWs0OWRraWxlSjVNQXpac1dZRVlRNlFU?=
 =?utf-8?B?ZGlqTHRJbm9PckdNNThod2JaT09wWWhDaFBXRHZFTTVzMmx0V0RHdEh2K1hj?=
 =?utf-8?B?cmNtSldwUDRLMnArMFRJMW1rVXBuMHd6N1B5TFdwaXByR3VwZEtQSUZPVGJK?=
 =?utf-8?B?SVBndWhOU3B1Nm5FN0UwWVVwVkN3QjJxeUZFeTFHOStyaElCMnl4Z3ZUS2F0?=
 =?utf-8?B?K1MrdmRPOFR3VTRjR3A0VWtPUWppcERubCs2Zm9TWHF4R0hKUzkxd0ZPS0I5?=
 =?utf-8?B?NFlvS2JLQWpieWNRK2FGclkxN3VuQ2l1Ry9rbjVFOUZpa2pQazZ5UGIya0dq?=
 =?utf-8?B?eVFPbDg5MVJ6Z0JJSzBLS0lLSmtQNU9IU2Y2MTNGeWl6ZlZkSldjS3FNRDB0?=
 =?utf-8?B?VGwrKy84TzBvUkdQYktxaFRvU3hUUEt1WWQ2dWgyY3pldTNDa0k3TnNqZ2RV?=
 =?utf-8?B?cjZJd0NrQmJTbERqbllHL0MvZVU2Z0luOFRyNzNML1plZWJCQ2Q1OXVwUFNa?=
 =?utf-8?B?aC9pNVZyTDFwTHhXamVxZnU5OVcybk9QT2tJY2o4LzhIK3BuQzRlVXdQbnpY?=
 =?utf-8?B?Znpvd2R6SzM2SmZHMEM2SUoyQ3BNbnQ2bW40MUhXY2ZEdUhCYUg1NTM0NEsx?=
 =?utf-8?B?dDJlWmRIbW9WYTNhZGg2bzlaUU85N3ZNV2FxL2hEeHZaZGxyVUM0N2JkNUlO?=
 =?utf-8?B?enJUL0Y3TGZFaXFYVmFTS084NVdxT1lqZlE3Qlo0aFJSVTg3bDlETVNjNXVU?=
 =?utf-8?B?Rlp2ZW5wZHp4VVJ3ZmNVeldNTmYrbEJuUGgwNEVwWWhpdEZVNXpleGw1T0cx?=
 =?utf-8?Q?SMqICTVJ6FCmUIoaqrKK3iM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1336e7e9-36e1-484e-1545-08d9c55e2cd6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 15:17:32.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdDZKXEF0d3L+v62qzOlKs+l47fFCqm11gukf7tlyeEvfIRdvf/lTmo1NAr4G9nGulb3N+Kp1VV+lf3sFEyQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2309
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 11:58, Namjae Jeon wrote:
> 2021-12-22 15:51 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>> On 22.12.2021 08:25, Namjae Jeon wrote:
>>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>> To avoid possible deadlock ksmbd should process locks
>>>>>>>> asynchronously.
>>>>>>>> Callers expecting vfs_file_locks() to return asynchronously should
>>>>>>>> only
>>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>>> Should I check this patch instead of
>>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>>>> ->lock
>>>>>>> ?
>>>>>>
>>>>>> no, these patches are independent and both ones are required.
>>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>>> How does this patch work? posix_lock_file in vfs_lock_file() does not
>>>>> use
>>>>> cmd.
>>>>> And your patch still leaves FL_SLEEP.
>>>>
>>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement described
>>>> in
>>>> comment above vfs_lock_file().
>>>>
>>>> posix_lock_file() is not used in all ->lock() functions, and use
>>>> F_SETLKW
>>>> forces some of affected filesystem use blocking locks:
>>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>>> flag on fs with its own ->lock ", this patch is meaningless. How is
>>> ->lock() with F_SETLKW called?
>>
>> I got your point finally,
>> yes, you are right, now this cannot happen.
>> However I'm going to fix all affected filesystems and then revert
>> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
>> When this happen and ksmbd will still use IS_SETLKW it will trigger the
>> problems described below.
> If so, You can include one patch(this patch + revert patch) in patch
> series for fixing ->lock of all filesystem.

Ok. let's do it.

> But I can still not
> understand why we need to revert the patch and apply this patch.
> Maybe, I need to check your next patches.

1) it is ideologically incorrect to call F_SETLKW from kernel thread:
W here means "if a conflicting lock is held on  the  file,
then  wait  for that lock to be released". 
However this can cause server deadlock.

2) nobody handles F_SETLKW cmd. It is set only if exported file systems does not define
own ->lock() function, and so this request is processed by posix_lock_file() ignored cmd. 
So there is no sense to set it.

3) when all affected fileystem will be fixed, it will handle properly FL_SLEEP && F_SETLK combination.
this will make unnecessary the force of SMB2_LOCKFLAG_FAIL_IMMEDIATELY and drop FL_SLEEP in ksmbd.

Thank you,
	Vasily Averin
