Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6383147EED3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352677AbhLXMbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:31:34 -0500
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com ([40.107.21.111]:53504
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233709AbhLXMbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqCRepGsF2rggTxBUtGQZAQHPCLL57NIz76RWWfgsWK94ja3eOPXo8xxddV/+NYBUZUvdkWqocn1hG1o/gUMVdmFP1P/MRIQtVOcplkOnondsMeHtYLdK8tEcrNYsm3Tg6dwOmmzWiTDP4Hrow0oc5T1yZJrqoiM1PCcWWcZIlE0tDVK2Zf/X/2IYAImgSDtoRkcugLfw3UoZUJdcqmbGIH8+U71ao2E9UAtg57UqMXdPOm68xjgjA7zlhIJKh91WO2zDFREhWlpIZKJPpkX4m0Zsa7sHJ2jqITTL/icishhBoPoDFjkomW8jLBYog57bwKI3/3f9/51YDjybpYHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=465RV1Cf8HC4job4W2+/Y2AuilIW2lrXyWHo5k/MLr8=;
 b=RzHdYO/xiw8duNkMDaKy2S7Q6p2UJNT6lP63UGoPjl3k2Y9hq7I1jn/MD72X1lPvWIkgR3ftPVMs+KPNA0t/sG7aUoHlcVE7huhmBprmSVH4sc1rdCFSLRd+X7+U40vi92nfvbOV+xegPpCXFHS/pFzYGJusLRysRxfwAJ4xHy61Quwf08pKD7VkKBIrZX0d9DQRWG5ZfCrJtvPYpEUH2r15NAbPwVPSxULb4+bqM4my1pC0ZItG+cbmkiKNO4gh+kaLGopta0kVO4ciqv2N26rIfWFvuYCNvxKA9fzLmMtpcc00ieanM5kp75oXLf8Zu46X26VU4gdFm+oI+23a/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=465RV1Cf8HC4job4W2+/Y2AuilIW2lrXyWHo5k/MLr8=;
 b=PIoW9JLROQoRc+dWMfyTvxYpINvr/ZmrLBM6CYgJ1UJd5Q7EOlDFSI2tOtdY4hkZ6GjdYgCetTXcmvpp9aUCg1gaCfUcfQb9Kmkve9EN9EoOvovKuHcdMV+19YD+9ydJHH6tzmA7KZzg3VeEi1RgmOedM+enl/7iR5XF2bk/T0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM8PR08MB5603.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Fri, 24 Dec
 2021 12:31:30 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 12:31:30 +0000
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return
 asynchronously
From:   Vasily Averin <vvs@virtuozzo.com>
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
Message-ID: <846ff849-58a9-ff03-8144-d7d47775553b@virtuozzo.com>
Date:   Fri, 24 Dec 2021 15:31:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4e61a114-d55a-3c14-e019-83891c5b1f0a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::25) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ebd16bc-cf36-43fc-c78b-08d9c6d94fc6
X-MS-TrafficTypeDiagnostic: AM8PR08MB5603:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB5603AFB59320F9A1D9D8CD5DAA7F9@AM8PR08MB5603.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91+hVez4jd4j587374fDq2NKoT8oRzuJtwXgnPUqlz8EwOKrw6mvVoIpxX6JmBxaiBCHYqm1K2daubS1z/RkGPyQYvJvgkjixEimcJKT0vg0bD4uE6QmnJp9zmzgUUfrbQK4YB4K+wh76agwVR5EmlwzrENlQZA1Y9RzFsOBAGwiS7JiSkO1b+jenL17EoI+Mnv81FG6DwOTFZM7mBUlX5MhtkqL3oKlh41o+T6vTqJhvTAf9HoA1jDPKjMF/cw2k/gYD0lR1YmgPopsxre2DjuxcHuBxSdPPQA6wrnusmwplBOoloA8xQ2wCvOEBdYX1AS+toIxTjat+YeAWkBAPTJ6WL4dSfqyXMrc6yvpnCowKJNUtdxjJrY1+FH9ao6NEKLpf5dAMs6QWDlQa5mntJvh/YnMOt4mPhbia79xnyxmveFJAo+aj854icglo6GHTrEnUFmyjmqFvs5YAzGGYj5QgV9F9Qc8a1AXnjDo2WZbJQpe+W6MqBoc/S4xfGwqPshD3iMzfzyzqTJXrHU4DEpVejgqzdRMdR4vWM/JaTTLDZ0PgyRrd6jL0RKF0bCAFHQUy1FZcw6l4w4t/jlugJ7vYANh61c21EHA8hd5AIjFAGAwCyXWBc9k2yQKv4LyJG5LygInv8zAZBdaZAiqXsqb2Gb7dFsDO7Te0ZP6CPUbF06lY+6x0E0qWXdc/yr9M72R23sZ2XgqlMu1jUDxdJVa2KJJzEWHsK5zCZ71xl6CQdnhdWF2v/ONZvDaBwkJB1erEwXH5UwliyedNBBgmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(2616005)(5660300002)(8936002)(31686004)(8676002)(38100700002)(4326008)(38350700002)(2906002)(66476007)(66946007)(66556008)(6512007)(26005)(316002)(54906003)(83380400001)(31696002)(6486002)(508600001)(36756003)(53546011)(86362001)(4001150100001)(6506007)(186003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmExWDBiVHAwN2tMZjBxTFR3cnZCdEFKUGVqZFhWTm80ZnBQL3Y1R2tmekNk?=
 =?utf-8?B?SUEwNDl2UU4wdTVIZ2xrTUgwQmloKzcrOVhHb3E5OVV5R1NHdWtJU0dmLzh1?=
 =?utf-8?B?ZU5PT2pEcnJtSXFvc08zN1RRTzRPMVZpR1ZCd1B1aVJ6eDhRZFY0MUorUUJk?=
 =?utf-8?B?S0t0Y1VtaGk2NUtFb24rZGt6bGFCRHZVSWlXcE92TlZtbUxvU1NKWlNQYkxh?=
 =?utf-8?B?RWJpMmYyTVFpQ2c2bmZMbkd6MG5EcERycDNQbTVYKzFnVzhQbDFpaWxSUFpX?=
 =?utf-8?B?REczdUdyVFd5SDJ6Y0VZdXA0YlhDSW93dTZyTWd4UmFnSlRkYTZHQWRkSkVD?=
 =?utf-8?B?SGxMaEFrdHd5bERHZmZGMmhQRGkzcXM5VG1BQ09YNFc4bmVJL0RYbXJZM0pB?=
 =?utf-8?B?Q3l3U1k4ZGFXOG0wUGpDT1oxU1MyRUlwLzNJK3hBRGkyNkw1Vk1ZVENpQzRR?=
 =?utf-8?B?Z0hyRDNCNWdVdEZIZUxsa1IvTm9zQ1NzUXNDUHU5Ti9wKys4Y1VBeGU4UmRk?=
 =?utf-8?B?VHFPelcvVjRhYnRIMzZiTHU0UmhrOTBxU2lSUzdGUThKdVVmRkFEL0hMQkd2?=
 =?utf-8?B?UnBURHB2RWIwMUY4OVo2RFArTW8zRnJ1eTdkM0hYNmlwME9SN0ErT1E4emZ0?=
 =?utf-8?B?dGVwUForNW1zQ3VpemRyWnJtYmZEMDJNd2dUR01haFRhRGZqcHdSZ1M4UHo5?=
 =?utf-8?B?Y2JBamlxRk1SdHhackJBUER3ZmZKYmEvV2VvekFTRUx2VXhMaUx3Vms0KzIr?=
 =?utf-8?B?RGpvQmpBODIvUGZBR1NDcFJ5UW8xNndUSXhzclpsalRRcUpPQUJhdHYyem5B?=
 =?utf-8?B?QS9wbk9VYWphc0NqVlNrakpqU2VqVXlzRHB6aE1WdlpHcVJjSmxBRE1YMUZH?=
 =?utf-8?B?MExCbERnWG9DblVSNUlsTms4TUVEQ2ZvMFc2TVQzWUViN1AyTlFteGZqR2J5?=
 =?utf-8?B?OFBBRUd5R09kbEpwbFk4UllQYVlqTTNZWGJwK0NQNnluVXc2bnhyUWREK2dT?=
 =?utf-8?B?WC9nZVp3YWVvamRlSmFrNTR0elVDWVZSTWYybGxYb1Jyd3drY2Vaam03UEZF?=
 =?utf-8?B?bElKODl6K2hEZ20xZVlWNHlTUmprOVNnYXhaQy8rWkQ5TU8vbUt5U2pRTC84?=
 =?utf-8?B?SlA4V1VOL0xuUkRRbWtieldYK2JFTHBnZnpyZFFrZ2pud0U1dnh2eVJyRC9p?=
 =?utf-8?B?OFFxaUk3OVFPMXQ5S3lQU3lrZ0QrVWVLNEdhWXYvYkFyNkhqK2pybkxhRHc3?=
 =?utf-8?B?SnhqY2hLTWpTdVhIZVBOcjV6OUJteUIrVVoxV0xMVmxrLzliZ29ENnJ5UXFz?=
 =?utf-8?B?S0ZtcGtFUEtITFhZVi91Z0hITTg1Y01SM3pkNjh6R0hmbDlSNHlnckc1SElG?=
 =?utf-8?B?T2tLbTRDT0hjSURoVlJzc1UzeTFsK0p3eklHcTNrK0U2NWlkSFZpa0JJOEFC?=
 =?utf-8?B?U1JubEs5Z1JpV1pFNCtMQzlsN2lQN0dsRDVzVUI5YXJVa0JGd3RUSGFZOTA1?=
 =?utf-8?B?TlBBb2R0MWttemQ0N0lHNDRTYkV0TDdFMDJQZ0c0VzIzR1lHdUJsMDhCZ1dY?=
 =?utf-8?B?cmJZNnZVK09QemptU2NBWDNCcW1McUIwVWNUUEJHOUJ2MVZBQnpKYmZNcEVp?=
 =?utf-8?B?azliNUVEcEV6N29MNWNpOTBuS1o1b0VJRU1mSmpVRE94MUZGTVk2WWtWbjA3?=
 =?utf-8?B?ODRYUWR5L0lIYUQvOFNwYk53Mjd6cThobDVKaThSWGdyZ05WWTUzcjdtZXlo?=
 =?utf-8?B?NE1SQ0VmWE84NFlqT2lHallObXo3QWREcXpwSzd3ZkhBSENjK2pWSW5DeGha?=
 =?utf-8?B?QlZYeUg4SG5vWFk1RlhXTEFZQUJsN2kvZHBRMDcrZE45UFZGcGxpM0QxYTdJ?=
 =?utf-8?B?OVFiRFg3THRLc3p4ZEU1MWNlMmI2Qlo5aUNZSlZHRUlzQ2pBckVmTzREUmhP?=
 =?utf-8?B?Y3NuRGZ1R2VleVhNOTFmcmU0d1ozUWdXY1VHbEJXTVR5ZDdsM2dyQVJVejVC?=
 =?utf-8?B?SDdvd0E5S2FVNWZSU1RzTENsaHc2SWFyNnVSK1JzRzJpWGFjbnExVnRYU0E5?=
 =?utf-8?B?bmRkRkNHZ3pFRUg3YlVuV3FNckk5cFQxMDNoUlAxOFpudVZBbEwvUlVFOU9r?=
 =?utf-8?B?MkdRUlEycVpyQzlFUHh5K3g3R1kwZXhOWDBYKytNUmI3UXVBMHU1djJFaVZ6?=
 =?utf-8?Q?rRyuJXpXOvUiVLMsEf85Gmg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebd16bc-cf36-43fc-c78b-08d9c6d94fc6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 12:31:29.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/5skCEkF2GppWj9+EeDjkdvP3r+UTTTsVB7gotiTcx+g5lv7oBdMtTI/c3kva6HXrAqEZYcUsoqNxFyVerh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5603
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 18:17, Vasily Averin wrote:
> On 22.12.2021 11:58, Namjae Jeon wrote:
>> 2021-12-22 15:51 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>> On 22.12.2021 08:25, Namjae Jeon wrote:
>>>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>>> To avoid possible deadlock ksmbd should process locks
>>>>>>>>> asynchronously.
>>>>>>>>> Callers expecting vfs_file_locks() to return asynchronously should
>>>>>>>>> only
>>>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>>>> Should I check this patch instead of
>>>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>>>>> ->lock
>>>>>>>> ?
>>>>>>>
>>>>>>> no, these patches are independent and both ones are required.
>>>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>>>> How does this patch work? posix_lock_file in vfs_lock_file() does not
>>>>>> use
>>>>>> cmd.
>>>>>> And your patch still leaves FL_SLEEP.
>>>>>
>>>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement described
>>>>> in
>>>>> comment above vfs_lock_file().
>>>>>
>>>>> posix_lock_file() is not used in all ->lock() functions, and use
>>>>> F_SETLKW
>>>>> forces some of affected filesystem use blocking locks:
>>>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>>>> flag on fs with its own ->lock ", this patch is meaningless. How is
>>>> ->lock() with F_SETLKW called?
>>>
>>> I got your point finally,
>>> yes, you are right, now this cannot happen.
>>> However I'm going to fix all affected filesystems and then revert
>>> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
>>> When this happen and ksmbd will still use IS_SETLKW it will trigger the
>>> problems described below.
>> If so, You can include one patch(this patch + revert patch) in patch
>> series for fixing ->lock of all filesystem.

I've checked how smb2_lock() handles FILE_LOCK_DEFERRED returned by vfs_lock_file() call.
It seems for me, working thread will be blocked in ksmbd_vfs_posix_lock_wait(),
so whole ksmbd server still can deadlock. Am I wrong probably?

Thank you,
	Vasily Averin
