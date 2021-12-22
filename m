Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6201F47CC22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbhLVEcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:32:14 -0500
Received: from mail-eopbgr20111.outbound.protection.outlook.com ([40.107.2.111]:22382
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235909AbhLVEcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU5ri9dZY5ndfbcK0sdrC44FQgJo9MxewLSvDhwwEMEk7S8buhYOUGh4htjWBtaZAsDlD2/6Hkhx21tsa8x/KDzTSqtncgDH/z5XJUa1rPOpMaREArBD/ESgQ6ZH86trGFqG6P+VHNbb8Xkko7wvbxikkEWpWpqDqvp1ZsK14H9Y+CLh2QealNAp7rNKggeB15MPadUdF2DRe2q3Jw2kQJxeA2DeQvgG90eCsXhLSiR4/JIxtOpeWtuHGE0QVydxKGjbmd1MzZtTO33he+4PzRVNz5Xh9OjvXq34pK8bDuyP9rcytpq+Q3f+pMazDksMiXzKTxHHKi9cyBmRsjASKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmgFtFpGJJQfCR4v9U4Yc2RwsCDgwukfzGvaBIGZa/8=;
 b=JfPWXqQvyIP7NnL1mrOmH9Qf0o7ATJhqtneuOhM4gzUuxFheMXyZHNK0o4wFU1817lMl8CZy7X1Q4iEbrEdrgvNs3CDWpcBfsqsYY1jacz4dI/VFcg8fuwPgC36qiZFSiyMIYVRvh+VKc4c/oT0/ELI0HdmUMoCFxXJTc5tCcHg1g3LAbgzc7l0n/k314EOUUVVY+xF80ySil3SD6so0gmdaX5fSGW1Wya5yw+JHRKXnnoQ0JboT1R4SWrzAXGBZLLFzmO1TZ2Ki9s1Lhrch2j5kBTvJS8MCeXYUCxqp8TyZn57B242X53EUAk3Z5EiFoMz/Q6GVrMeaEvOrxZLbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmgFtFpGJJQfCR4v9U4Yc2RwsCDgwukfzGvaBIGZa/8=;
 b=jxkCBAuSlM0UMTlj1BoDFU8JNnDNPFWHPlbOkB1ihEFDCJiy3PT+K2m8ech9S3ftM6xoixPthV6fbtNi/r7UwGJi9JxFm7q+/RivaJm6Cwzhb4z5ZeUjM9ICdwJkmgknrdFS8VTGfXe4C2DC3Ik8gFN3cR15Y5hqcBsA685uSaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBBPR08MB4727.eurprd08.prod.outlook.com (2603:10a6:10:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 04:32:02 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 04:32:02 +0000
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
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <f210483a-69f7-1983-65cf-f3f5bd4112ac@virtuozzo.com>
Date:   Wed, 22 Dec 2021 07:32:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56acd3e0-17e5-4055-a8ca-08d9c504002a
X-MS-TrafficTypeDiagnostic: DBBPR08MB4727:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB4727C8BFBD18BD754872B8C2AA7D9@DBBPR08MB4727.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN/M9WiHF5vX/jvzB+ttp79yWCy4XCAZzdXvgr5ZshjCU0cE39CzLr+PUR6UcCSe0ez0cakdTi/iPwOHVWK39dFhtKQO9KY4RLl5qzDBCFQyIj3CmWFXgsvE/ItN50U7UgOfOdMSzNTYHObJ44ek2+T2YJe5OGOYhkKCLzfn0UuaJwerUvEHPUBf6MCfitttPV+bFeue6H68lLRrEOgGE69PU/wxyX353hmDvKxKrvMTLGTaCvuyrF0WZSHtfqRBpXUNWqtnkdK9aRo31Itc5c7Nc91U9XvPOEl1tOKDZnYFmL8uMLL+vHEHK2CAVj4zn1orLK2X3Bf3+iDbA7q7DvFspNEk9lUgqsvIJHOngSsXSo1ACT3iC4r2LDpthwgnnfmhWNKaqM2D1wID/IYEmnc/z3cHJK6QBVVZJ8c4U0GPt4AHS0U/YBNLiaic+VigxSvf3Y7e51e+L1aphd3TL1gRxoRs4S6gH7Yac58WNQ/t3LFwJXs0PsBS6NIOkAAsJEoKfmqgjv8r1PLF6NznRfDo1f1GeXMzK2kCyrvWpUu0rEDBzbYNaZDLkm5l+/jlPw5s1IGo4XKMEFFMs5kTzTCrZVOh88l4ty/8D3MnYZRDAGzmkKimjRvH3Sy335inZDnFMFgdPuMvw4fmnJYMx5olo5f4bMdqhpVDFZLZ1YEMYAxWycbEbUtRsfRvpe2CIBJVaH52XnfgYpGE4RQsSosZtzx7X71y236XpTFJCGRR2lHIa8du/xURTgJ9gLVhNy26sDOyG+CjVcyRIhO7wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(5660300002)(38100700002)(36756003)(4001150100001)(38350700002)(6916009)(186003)(86362001)(83380400001)(2616005)(8676002)(26005)(2906002)(4326008)(31696002)(31686004)(54906003)(53546011)(6506007)(52116002)(316002)(6486002)(66476007)(66556008)(508600001)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZhblIvVEt5YzRPamhJbnZ1OEhZd3EvcW1tSFhaaUZmWFRjNy82Y3Vrbk03?=
 =?utf-8?B?QXkvZGIxRUFsOTFOVm00dkNleXF4ZlJYaFBmNThPVzNHeE9GSnNEOXVMMFFi?=
 =?utf-8?B?azJhNUxOOUZlUXRmQ1RuZXlHak9xUk5UT1M3QVAzL0IxR3FVTGZrQzQvT1Bi?=
 =?utf-8?B?Vm5yVGNBN0JHSyt5TG11Qk4wR3Zta3BPVXBxSG1uSTVwaDZjNllSZG5sM2ZI?=
 =?utf-8?B?MU9RVi9oWmlCQUFSdm1jY3BxOHZjbHVoN3J0MWJnSlkzRGFjREV4K090U2Q2?=
 =?utf-8?B?blg2eGZKNTdnbTlKZFBEQnFnaXNaL051eGN4TzVWVUNCbFJOOEhpNVl6UjM0?=
 =?utf-8?B?bFl1dExzejJtVmUvazRlNmtWOEpOMXVTQml1QnIwWHBXYUNRWTZac1RBSG1s?=
 =?utf-8?B?eXM2clNuOXkvbXdxYlpDSkFZamowMGhqaFl0bDUyNll2MjYrOE03T2RXcWc4?=
 =?utf-8?B?WDlGK0h2M3FDM2tiVVcxOVYraDBYaEZodFRmV0ZpQzJFcXlQU3Z3SGdySG5t?=
 =?utf-8?B?ZmZHWjVkVmF1a3BmQVpyTktpV3hsTnR1ay9WQ2RoaVNkeS9UTkZkOXlRS1RS?=
 =?utf-8?B?NHdKWlpHUnlGSERCVnRSZENSYUtWa1dUMVlRWExxSjZGZVF5bWlhQ1Q0QVJm?=
 =?utf-8?B?ZkNNOXIvTjFFVkRtamlHRlUwZkpkZnBrSUJ1VGxsU2tpN2tFMnZqbU5WUDVk?=
 =?utf-8?B?SDVhMHRRVkx0azJlcm1wMmtSQUJ0UWEvVXVyYzh2VW9IeXh4T0p0YXIvbUl2?=
 =?utf-8?B?SytmUEN5K1BQS29lUE1ScFl0RE9ETTNhYWFtRldsMzg5Mkp6M3JHS1lNeTFJ?=
 =?utf-8?B?dGZBVERBTG1qMmo1MC9hWGZudlJlZ3VOQXBLNjhIV08ra0xuYmovRElSQUxS?=
 =?utf-8?B?MmhPczFqcU0zTTdBRW92ekJjWHc5dWtnSXRLRGJmRmtqWE54R2Jpalh0NUZs?=
 =?utf-8?B?ZThBRytMWDM2OGRoVERlc0g4bzJMd1REbFh0d1lxOWFnRVpPeG5nNDExRmpp?=
 =?utf-8?B?ZEFrWE9EVkdqM2FhWlIxVkFJNGJ3c3VuaUtqTmx0K0ZvTHB3RTlMQXRNbkJD?=
 =?utf-8?B?Sm1kYW9COXlCZ2xrY2FVMDI3ZzU1TEtEazJ5UzZWbHVwcmhZZ2F5bjdOaFcz?=
 =?utf-8?B?M3NKSnF0U2c2STQyN0JqRzhtYUtadmhWdXRxbDBqTlZnU3ZVTHFleHpyL293?=
 =?utf-8?B?N2pHeGY5VXc1UDFQRmMxMlA5OTZxQlkvcGNNVGZzSnMrQWFoUkgvVDBtUkJ1?=
 =?utf-8?B?NFg1cW5LQzBXV3pmUDFuSkdnZFRYZ2MxdytBOWZnaFVmNEh6MjdMck5POGZR?=
 =?utf-8?B?eVBzdUtNVSt0bnhMdmwxeURXUjZZbFlHVUJSUFdodzBFUkQ1NUpLWFlxMlFW?=
 =?utf-8?B?b3NPY05mUTdxeW51YnBuSTVDZzV6R2U0YkU3VmVjalAzRDdMNitqTGRtOXg1?=
 =?utf-8?B?ckR1c3BvcTh3Q2RZTyt3WDFiY3U2MmhCQkF0bVNYWmJubUZIMHZmbEFoVjdw?=
 =?utf-8?B?T3lxSVkrNzhxU2dGZFlLZkhCNUlta0FneEhZNmZ0RTlaTkdtWmpoazAwcThi?=
 =?utf-8?B?bktvdzlabVRKNjZncHNiN0pRQzBIV05ydGZHN2dXMklndHNLcW5tSE90RzE5?=
 =?utf-8?B?eGc1a2Z6NHh0SnVWenhYcnErNmREaWQxQm9TSk5oOXJ1c2ZFc3ZKSHB5Qzl3?=
 =?utf-8?B?S1Fyc3pmNkhRVmdEWXEwYVc5cnJoY0d3WWVTeHdjd0k2MWV3VzdrQURDTElw?=
 =?utf-8?B?UEV4MEJkbituRHg1b1U4N3Z4SDlRS3RRT0J4Y1g2K0UxQUxUdmJZejRkZEk1?=
 =?utf-8?B?dnZKQy80eWhNMzl0Vm80UmR3MVl0ZUNSWnIvWEV6eWxhaEtvQS9Qa0s2TWV5?=
 =?utf-8?B?MkpocHFTZ1g1OHVReSsyT3JMVnNSSWlxT2p6cmRuL2xpUjA5Ni9xanFIU08z?=
 =?utf-8?B?RVY0cW5KdWsxV3ZhU1ZaaS9rVjJ0OWJYTjluZU9RT1MrUmpSNGwzcE92ZmZU?=
 =?utf-8?B?aDliemt3VXBSVVBNRXRweHhMdktiSW5jZXRhMmgvUmJ4VlZnV2lRMkZwNTU1?=
 =?utf-8?B?cTBwTzVIckFYOFY0dEdRL012QTE4MGtkMGkyUjEwcWh6aW02WlRWUEk5WklY?=
 =?utf-8?B?ZTkrWGt1WDNmVnlzQzZTaW5OMmhVVjFwMkU3d3JSRTZDdUVlOTFIcEMvbGVV?=
 =?utf-8?Q?JLnuxqMEr1auNGk1TGcHFaA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56acd3e0-17e5-4055-a8ca-08d9c504002a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 04:32:02.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwaVnEKBE86cu+zygB7x0thGRJbhUkJAgC4e1DsQevheOn34Bmd46KRIClzP9qEdX97hHwPcKriIZyXjD6cHZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 05:50, Namjae Jeon wrote:
> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>> To avoid possible deadlock ksmbd should process locks asynchronously.
>>>> Callers expecting vfs_file_locks() to return asynchronously should only
>>>> use F_SETLK, not F_SETLKW.
>>> Should I check this patch instead of
>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock ?
>>
>> no, these patches are independent and both ones are required.
>> current patch fixes incorrect kernel thread behaviour:
>> kernel threads should not use F_SETLKW for locking requests.
> How does this patch work? posix_lock_file in vfs_lock_file() does not use cmd.
> And your patch still leaves FL_SLEEP.

"use F_SETLK, not F_SETLKW" was copy-pasted from requirement described in
comment above vfs_lock_file().

posix_lock_file() is not used in all ->lock() functions, and use F_SETLKW
forces some of affected filesystem use blocking locks:

fs/ceph/locks.c::ceph_lock()
        /* set wait bit as appropriate, then make command as Ceph expects it*/
        if (IS_GETLK(cmd))
                op = CEPH_MDS_OP_GETFILELOCK;
        else if (IS_SETLKW(cmd))
                wait = 1

nfs v3 handles it in nlmclnt_proc
fs/lockd/clntproc.c::nlmclnt_proc
        if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
                if (fl->fl_type != F_UNLCK) {
                        call->a_args.block = IS_SETLKW(cmd) ? 1 : 0;


nvs v4 handles it in nfs4_retry_setlk()
fs/nfs/nfs4proc.c()::nfs4_retry_setlk()
        while(!signalled()) {
                status = nfs4_proc_setlk(state, cmd, request);
                if ((status != -EAGAIN) || IS_SETLK(cmd))
                        break;

gfs2_lock and ocfs calls dlm_posix_lock()
dlm_posix_lock::dlm_posix_lock()
op->info.wait           = IS_SETLKW(cmd)

So if ksmbd will try to export these file systems it can be deadlocked on blocking locks processing,
even with my patch dropped FL_SLEEP.

To be honest, some other filesystems, contrary, ignores cmd and handles FL_SLEEP instead:
cifs_lock and fuse_setlk.  Moreover, locks_lock_file_wait() is widely used too,
(and can block if FL_SLEEP is set). Some of these cases looks like bugs,
its careful processing requires some time, therefore right now, to quickly work around
all these cases kernel export threads  (nfsd/lockd/ksmbd) can drop to FL_SLEEP flag).

I think it makes sense to create new bug on bugzilla.kernel.org, explain all details of this problem,
and keep you informed about progress with filesystems fixes. When all file systems will be fixed,
it allows you to revert "ksmbd: force "fail immediately" flag on fs with its own ->lock"

Thank you,
	Vasily Averin

>> "[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock"
>> tries to workaround the incorrect behaviour of some exported filesystems.
>>
>> Currently this way is used in nfsd and lockd, however it is not fully
>> correct,
>> and I still search some better solution, so perhaps
>> '[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock'
>> will be dropped later.
>>
>> Thank you,
>> 	Vasily Averin
>>
>>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>>> ---
>>>>  fs/ksmbd/smb2pdu.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>>>> index 0c020deb76bb..34f333549767 100644
>>>> --- a/fs/ksmbd/smb2pdu.c
>>>> +++ b/fs/ksmbd/smb2pdu.c
>>>> @@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct file_lock
>>>> *flock, int flags)
>>>>  	switch (flags) {
>>>>  	case SMB2_LOCKFLAG_SHARED:
>>>>  		ksmbd_debug(SMB, "received shared request\n");
>>>> -		cmd = F_SETLKW;
>>>> +		cmd = F_SETLK;
>>>>  		flock->fl_type = F_RDLCK;
>>>>  		flock->fl_flags |= FL_SLEEP;
>>>>  		break;
>>>>  	case SMB2_LOCKFLAG_EXCLUSIVE:
>>>>  		ksmbd_debug(SMB, "received exclusive request\n");
>>>> -		cmd = F_SETLKW;
>>>> +		cmd = F_SETLK;
>>>>  		flock->fl_type = F_WRLCK;
>>>>  		flock->fl_flags |= FL_SLEEP;
>>>>  		break;
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>
>>

