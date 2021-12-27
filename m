Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50647FAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbhL0HJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:09:04 -0500
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:39785
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229825AbhL0HJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:09:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIAypu/PcgrMm6/r/G9Ieei75Utfc26yYP03Ff82MDC/iAD81ydmyJSUqZi1NnezsKOFTyhsT1dcvK7JeV+Lc9TwBXFreWCszlXwf8x2ndNHKq+9dOckyFMMrgeDn/J5JITPtgg64PL6I18rESZkpoSQQxrC39KpvSDbolAKj5tmvBObYMjzuLIaGlxw495y/A+WlKGMB5oVhDjLDEnJsJsvhrY9xkvMQJSlaf7wF+8vi4SYdisKyDewFM45nkT1M7H/5z9tkcjB6/v0z8rQrI8cxWC6chk14gtsVnJVUEnBV7nC+td21cNliDQr86g9sUct+yv5S8H3QXDyhvt+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0XrFHo1Dvo9sdR7bstiieYFKoAIe79e+Si9H2sWJPY=;
 b=DD7vd3tEpvDRZ0//y92qQeBiMMgOEYOVrPZyR+iTxP3HSNDH/KE9kMCU69OblDgANs5lFzM0mvuAY9b6IE9XXRIbsL2RNstQtc9CBBFX1NhkoC8x2+O4nW9Fft3OE9VXxNk6V17vUMjhxEEveSZRiz7N/6WqoQQ6XRZQMXnJ+EemOukNlDkX6KdF3/gw0cQpVXOymIyrhxa2Y51qKnkBIbeiqE2Fif66umZzepj+/g3XfU6m7XE4+zpr9IReyGxDs8luqiGBHKu4zM6URe/+0waY4bL9BknOiLKadzeN0zz8XNugfofOyDZ2pd1E8/0Rv9Eewh8zkYqspMJcgFFpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0XrFHo1Dvo9sdR7bstiieYFKoAIe79e+Si9H2sWJPY=;
 b=qzMsnVHLCdBIufFEnps0XEiQSsU8jXcnbtd//tlmvaXJxnRR3c6ahkHEiKJNHkbL2mCjixInzNjq+WfU+myBfw2c4uEYgdqwFay4U0tsd/s7LaYNommPPoZCAxcZ4plNDC18lHyz57LHSNA5OxlGT48xEopeE31+RVhkcb/B6jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB4468.eurprd08.prod.outlook.com (2603:10a6:208:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Mon, 27 Dec
 2021 07:09:00 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:08:59 +0000
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
 <4e61a114-d55a-3c14-e019-83891c5b1f0a@virtuozzo.com>
 <846ff849-58a9-ff03-8144-d7d47775553b@virtuozzo.com>
 <CAKYAXd8=EoOnMHURFPfwvCHmit+Xg+tKdsjWN7wrEXDa53aVxg@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <567591e3-1f1a-f883-e610-4f99e982f4b2@virtuozzo.com>
Date:   Mon, 27 Dec 2021 10:08:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAKYAXd8=EoOnMHURFPfwvCHmit+Xg+tKdsjWN7wrEXDa53aVxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:206:1::27) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f2d867-e56a-45ee-d391-08d9c907c15c
X-MS-TrafficTypeDiagnostic: AM0PR08MB4468:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4468D90D974D4C5E5F58B081AA429@AM0PR08MB4468.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYrMrqPYYYumkvNg9Zpi/Ln3p2qR7wio8hylu6I1ULojuXOa4GoNo3Axq5tumA9IoV0y+9ZpuNSp1SywUimFSlTjbXMEdiJPTfsiuTswTZD6S5889WR3E04ahwFShdO47fXr3Dg/Qk0cvDlZU473ii3ntGJPph+zPFtKJoDAKXbq4k44iSgPUGSipTxf+okW/LuHkRsKpwhb+PRgLqiz+zzl4rx+x+6/lpmUhkNb03t1CK7c65r469RXkvr25tAalkMYZnshFA1v6j1yyFxCRwh0bjDOBnwNsnYCN8WKVhLtg99jiquuYQ3wOURKTzHdCCn+U4DhUw2k82g3KQplutdJYE2egtq9LOv6MiyG0VVduOldt4+pEf0zJQVZVWWUp7T5iSGwZqiUZMPgzer5e44UbY9wPvvrlnCqneSsgd0JT1TeOY3AVKegSzVy0FpbQy8hZy0EnNZNdmQE7Ib4xu8cmuxazWghMCCtr+pJ5ZfGiDTaeSeYIzbOhlJuFkjZSvA1RYks13MSxns98UjAsy21mFvE0YkoqhzuQGiCaGXlDD5PLiQ9rkG1hyhmPp0IH2fiHgQiJViyySuuxyFJ87d1iL5sVDSqGnwsDioTJRA+W3kyEBWtKeOhcvbd/vRt5vMyYC8MRl3KcFkjwf9T8FstewT327icISvWzb6xAXmGE9/KnYw99KXsk4kSngx7k7OZPaJwgQZgV/HuRv2ArMV4zhckxR1Is+ZW9bLlC6c2Ggb3NiYJVwgEgy3xKOX7FtvievZMsqyp5MVTMQymgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(36756003)(8936002)(38100700002)(38350700002)(53546011)(6506007)(6916009)(8676002)(316002)(4001150100001)(26005)(31686004)(2616005)(54906003)(52116002)(5660300002)(508600001)(83380400001)(31696002)(66946007)(66476007)(66556008)(2906002)(6512007)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZnTGw3dG8xUm4vcTFCUlMwNlg5cVZMVnJHNFpwUGxGR2xta1V2OUVQaU00?=
 =?utf-8?B?NEJwSTJOODZEeVRyalorMDV0SVd5cWJja0hZNlBGYmc3ckE4NkdxSmM1Nncv?=
 =?utf-8?B?SDdzeTc5VzB6bHA2STlUNzkrMHh2Y1d2UzJwY3cxYWhQL25rbjkwclJDNVFN?=
 =?utf-8?B?OUh4TTVMMmVqQTMvYW1QODFRb2Fpa2ROUlNFQ1lBSnV1bng5c0srNi9aVU02?=
 =?utf-8?B?c25HdWt4Q2VTeDViU1M1aTd2RVJWekU3M1RSdWd3K1hhOHhvYTZvemRMK0RS?=
 =?utf-8?B?bC83UEc2bXRIdTZWLy8zQU0wditmUGFFUmZEVGltM1AwbWFGNEV1YlBkTXFW?=
 =?utf-8?B?QjhzYUNaa3ZLMS9zZDNvMVZxbGdXclJRRGZLeGhqelBKOXRneUR0bzFpOFJ5?=
 =?utf-8?B?NlFpSFNUT0xMcFpvODRzcFp6RldYZDdmRHdaMUNzZk9nNmxlK0VMTEUrRmZ4?=
 =?utf-8?B?YTRNME5LamE4UGlzcmhwT2V6b29mS25JODVQbFVBUFk3Qlo4VERQMExmUDhy?=
 =?utf-8?B?UmVDZHhLK3pCSnZuNURPT053SzJBSjRPeFRTeXZ0VmJFam1RcU1wZi8wNXNY?=
 =?utf-8?B?a2R3QzBJa1R1Rkx2M1lqY1RkYzl4M093clZZbjlvbzVJaGFSUjM0WExkZFM5?=
 =?utf-8?B?ZHQweHlOaWRHYlFqaGpEdGZlTFp0dW1GRTUyM3hXbllRRnRFem5GbjI1bUEv?=
 =?utf-8?B?N1hvSzE5TFFYRHF1OFJ6UGNMU3ZiSHRNMmd5bGpybS9vWW8wc2ZUZktYektx?=
 =?utf-8?B?N1U1d3lQdFNHVEVxbjVnbkZNZDYwT0tDTEJSK0plam1KMkx5VUZNamFGS0hv?=
 =?utf-8?B?QUltL0VmaG4xbm56c0RRZkg5UHJDMlVJRVFlc0hvbkJlSExiOWREeTExa044?=
 =?utf-8?B?TnFKQWhjZVRRanpYOTVNQkRMdHBrWlVhTW9NRDVNc0JzcDQyb3hWNFFqL3lN?=
 =?utf-8?B?ZWE5VTY0Sm5jRXgwK1BObEFTdEY5YWxMdzREV0tGaWVhVTU5MWphc2lHb0Ez?=
 =?utf-8?B?ZWY0YVkvdXRCaWtKVk1tbXVhRWNxY3lSMUMyVGNtYXlna1MxY3ZpRFZIMVdZ?=
 =?utf-8?B?TEtqcUFBYW1zVURQd1UyNkNuRFRnT3A1S1B0NnpFNkkwTVVCdnhZb3VQY2Zh?=
 =?utf-8?B?MmE4Q3BBc1MyaVovRDd6VFBkWVRJU01KSnFwb1QyazN2Mjg5VUk0VlV3RE4r?=
 =?utf-8?B?ZDY2cFVCbEp6L21sM2h3a0xqcldMajE4ZXJBc3ZZSVFUbEQ5NHlHVUE4SkZJ?=
 =?utf-8?B?VUFHblZHSStrNC9palU0TURHYW9CVjNRZWlMOU12ZUhGc3NNZHIxLytaQVVY?=
 =?utf-8?B?Rjg4VXlvaHhrbERMd0ZQbGxVTllBbGRlSS9sSlRBTVhGUlBmL2tTMlN1dFlk?=
 =?utf-8?B?TmovZ1hDMXpnWmlGRDY1Q0JVOENnVWp1cHltL0xENnhrbys1amc4TW83MTNt?=
 =?utf-8?B?VnM3OXc5Z2VLWHpqQ0xVK3dnaTZxa0tRa3RMRTd0TStneU44QkQwNUFKU2VU?=
 =?utf-8?B?MU52cjNzVStwZW91dTB4RWcyd3p6SXB5d0k2N1hUa29jVmk5RHRrVWVKM1NR?=
 =?utf-8?B?ZUc3SnlYUG80TDMxWHFBT2RKQ3RiYUkyZHp1T3NIekFwU3R4b0dwUE55cVV0?=
 =?utf-8?B?eDlZbHhYRWJWZVo2WWVzSUZjRmhOL3RMeFFqb291eDZoYjdoODFROVg5Q1hq?=
 =?utf-8?B?aEtYdnZobEdHQUgzdkhxaU5vczA2ZjkwSlNicGpjZEYzamxvR3IwQjUzK1lX?=
 =?utf-8?B?bDZSeVUwZGIzb3hVMUNEUWw2bi9sUzlpVStXYmFuRE1PYUcyTnRFZ2lQOUVV?=
 =?utf-8?B?WXVoMXA5Rnd3NkhLcEZoZDdrWUNoMVRCSDg5MXhzbUlwc3Q4RENUeUVKdlBl?=
 =?utf-8?B?K0R5SnpBTE5iOGU0VER2aW41UEVteU4rbWhoaERGa0NjV28vc0dFZmlpdUNp?=
 =?utf-8?B?b2QzdkNVMzk5UGpsb0FIMzA4Yk5DZWFkYUtCVG5MbmxJS2RoYVdJZ29XNm5E?=
 =?utf-8?B?YU1hRmVQS3I3cmtNNG45aGpuLzE4OEgvMGxsVHA3YWtzMzh3RHYvQ1RTYW5t?=
 =?utf-8?B?NS85aklZT0FWb2JhcmgrUGRFcHhXRklzalUwWEI2TDhUcklyV1VRRUIwODA2?=
 =?utf-8?B?MjNBamRUSEpaSG9YYnRrNTRHRncvM1YybndBQjB4ZWZrQUw3RVNXOTdnT2dC?=
 =?utf-8?Q?rALNrIDQ6alfexnZjAU4XdA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f2d867-e56a-45ee-d391-08d9c907c15c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:08:59.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+/3tX9Pom3cfGak8oUi8XjZnKOd5/U+NFpE8FSyxV72CueV9ygd63FvOknijV3CQKADGaYVUaRl+3+0T9bObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.12.2021 02:08, Namjae Jeon wrote:
> 2021-12-24 21:31 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>> On 22.12.2021 18:17, Vasily Averin wrote:
>>> On 22.12.2021 11:58, Namjae Jeon wrote:
>>>> 2021-12-22 15:51 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>> On 22.12.2021 08:25, Namjae Jeon wrote:
>>>>>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>>>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>>>>> To avoid possible deadlock ksmbd should process locks
>>>>>>>>>>> asynchronously.
>>>>>>>>>>> Callers expecting vfs_file_locks() to return asynchronously
>>>>>>>>>>> should
>>>>>>>>>>> only
>>>>>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>>>>>> Should I check this patch instead of
>>>>>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>>>>>>> ->lock
>>>>>>>>>> ?
>>>>>>>>>
>>>>>>>>> no, these patches are independent and both ones are required.
>>>>>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>>>>>> How does this patch work? posix_lock_file in vfs_lock_file() does
>>>>>>>> not
>>>>>>>> use
>>>>>>>> cmd.
>>>>>>>> And your patch still leaves FL_SLEEP.
>>>>>>>
>>>>>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement
>>>>>>> described
>>>>>>> in
>>>>>>> comment above vfs_lock_file().
>>>>>>>
>>>>>>> posix_lock_file() is not used in all ->lock() functions, and use
>>>>>>> F_SETLKW
>>>>>>> forces some of affected filesystem use blocking locks:
>>>>>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>>>>>> flag on fs with its own ->lock ", this patch is meaningless. How is
>>>>>> ->lock() with F_SETLKW called?
>>>>>
>>>>> I got your point finally,
>>>>> yes, you are right, now this cannot happen.
>>>>> However I'm going to fix all affected filesystems and then revert
>>>>> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
>>>>> When this happen and ksmbd will still use IS_SETLKW it will trigger the
>>>>> problems described below.
>>>> If so, You can include one patch(this patch + revert patch) in patch
>>>> series for fixing ->lock of all filesystem.
>>
>> I've checked how smb2_lock() handles FILE_LOCK_DEFERRED returned by
>> vfs_lock_file() call.
>> It seems for me, working thread will be blocked in
>> ksmbd_vfs_posix_lock_wait(),
>> so whole ksmbd server still can deadlock. Am I wrong probably?
> No, Each commands are handled by ksmbd-io kworkers.

In this case ksmbd can do not require async lock processing
and you can drop my previous patches.

Is there any difference where thread will be blocked: inside ->lock() function
of exported filesystem or in ksmbd_vfs_posix_lock_wait? I think it isn't.

Thank you,
	Vasily Averin
