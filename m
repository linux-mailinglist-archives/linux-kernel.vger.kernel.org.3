Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3647CE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhLVI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:58:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32966 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhLVI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:58:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C392061917;
        Wed, 22 Dec 2021 08:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3221CC36AE5;
        Wed, 22 Dec 2021 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640163526;
        bh=rkAS+OCqMkmXDfYk1BVI4Q62pHtiYuu18uaXrbLk5Fo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qb0ZUa+3LoO4zlzI3RmokRpDSpFK4D4Evm3e6uoz199S3EECyojnIda3t19EcEISe
         yqRsiH8iHbHm2yJCGx/4xMh6STx6f4Oi2epPiwDa0NWHZMtBxfZm2Otvq9d7zPqKO0
         shx/k+clH3Ko1WIwcOIIGZSAMSfl/MeG1JLibQS79sQTikOMguV5JneqG8bJtJZYv8
         T/kkiAam+BCwJ/AXWEOXPEGv8YtKJGsXLqM4KIPw5qg0ceFL1EyLmjP2NVOb/qiaof
         rAyNtpbC9eCF7M7YwjALfITtZR/7PEorG7J5tnOuacXC/AoIvYeayXIryR8Nn2YDik
         VFQriQjaRubQA==
Received: by mail-yb1-f177.google.com with SMTP id y68so4665955ybe.1;
        Wed, 22 Dec 2021 00:58:46 -0800 (PST)
X-Gm-Message-State: AOAM5311nzvCLRD0/9VxYz7xyeljLNZmcx1OGa2z/aKzbAlmxcKh3/8o
        98tMlfVZHgrvr22oC6wLAvuZPiY6daFRC0IbRvo=
X-Google-Smtp-Source: ABdhPJyciTSJG0DxNn+uCfpu0CJJEfXLfpOOtn/Ni/wJFHEnc5NEAbHT1vecCdxYsj7z0UGsybBjHm6YYroywi2BwiI=
X-Received: by 2002:a25:d647:: with SMTP id n68mr3154876ybg.529.1640163525287;
 Wed, 22 Dec 2021 00:58:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:1313:b0:11b:f4cd:b869 with HTTP; Wed, 22 Dec 2021
 00:58:44 -0800 (PST)
In-Reply-To: <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com>
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
 <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com> <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
 <f210483a-69f7-1983-65cf-f3f5bd4112ac@virtuozzo.com> <CAKYAXd97orfDc7VA+fae7tLjTufMksQTepYKazY=gX7UkG0+rw@mail.gmail.com>
 <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 22 Dec 2021 17:58:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-zBBF_J-z1Ph4ruRD3Fb3EORsKfDjKw0yX42D0SCD_Ow@mail.gmail.com>
Message-ID: <CAKYAXd-zBBF_J-z1Ph4ruRD3Fb3EORsKfDjKw0yX42D0SCD_Ow@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return asynchronously
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-22 15:51 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
> On 22.12.2021 08:25, Namjae Jeon wrote:
>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>> To avoid possible deadlock ksmbd should process locks
>>>>>>> asynchronously.
>>>>>>> Callers expecting vfs_file_locks() to return asynchronously should
>>>>>>> only
>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>> Should I check this patch instead of
>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>>> ->lock
>>>>>> ?
>>>>>
>>>>> no, these patches are independent and both ones are required.
>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>> How does this patch work? posix_lock_file in vfs_lock_file() does not
>>>> use
>>>> cmd.
>>>> And your patch still leaves FL_SLEEP.
>>>
>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement described
>>> in
>>> comment above vfs_lock_file().
>>>
>>> posix_lock_file() is not used in all ->lock() functions, and use
>>> F_SETLKW
>>> forces some of affected filesystem use blocking locks:
>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>> flag on fs with its own ->lock ", this patch is meaningless. How is
>> ->lock() with F_SETLKW called?
>
> I got your point finally,
> yes, you are right, now this cannot happen.
> However I'm going to fix all affected filesystems and then revert
> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
> When this happen and ksmbd will still use IS_SETLKW it will trigger the
> problems described below.
If so, You can include one patch(this patch + revert patch) in patch
series for fixing ->lock of all filesystem. But I can still not
understand why we need to revert the patch and apply this patch.
Maybe, I need to check your next patches.

Thanks!
>
> Thank you,
> 	Vasily Averin
>
>>> fs/ceph/locks.c::ceph_lock()
>>>         /* set wait bit as appropriate, then make command as Ceph
>>> expects
>>> it*/
>>>         if (IS_GETLK(cmd))
>>>                 op = CEPH_MDS_OP_GETFILELOCK;
>>>         else if (IS_SETLKW(cmd))
>>>                 wait = 1
>>>
>>> nfs v3 handles it in nlmclnt_proc
>>> fs/lockd/clntproc.c::nlmclnt_proc
>>>         if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
>>>                 if (fl->fl_type != F_UNLCK) {
>>>                         call->a_args.block = IS_SETLKW(cmd) ? 1 : 0;
>>>
>>>
>>> nvs v4 handles it in nfs4_retry_setlk()
>>> fs/nfs/nfs4proc.c()::nfs4_retry_setlk()
>>>         while(!signalled()) {
>>>                 status = nfs4_proc_setlk(state, cmd, request);
>>>                 if ((status != -EAGAIN) || IS_SETLK(cmd))
>>>                         break;
>>>
>>> gfs2_lock and ocfs calls dlm_posix_lock()
>>> dlm_posix_lock::dlm_posix_lock()
>>> op->info.wait           = IS_SETLKW(cmd)
>>>
>>> So if ksmbd will try to export these file systems it can be deadlocked
>>> on
>>> blocking locks processing,
>>> even with my patch dropped FL_SLEEP.
>>>
>>> To be honest, some other filesystems, contrary, ignores cmd and handles
>>> FL_SLEEP instead:
>>> cifs_lock and fuse_setlk.  Moreover, locks_lock_file_wait() is widely
>>> used
>>> too,
>>> (and can block if FL_SLEEP is set). Some of these cases looks like bugs,
>>> its careful processing requires some time, therefore right now, to
>>> quickly
>>> work around
>>> all these cases kernel export threads  (nfsd/lockd/ksmbd) can drop to
>>> FL_SLEEP flag).
>>>
>>> I think it makes sense to create new bug on bugzilla.kernel.org, explain
>>> all
>>> details of this problem,
>>> and keep you informed about progress with filesystems fixes. When all
>>> file
>>> systems will be fixed,
>>> it allows you to revert "ksmbd: force "fail immediately" flag on fs with
>>> its
>>> own ->lock"
>>>
>>> Thank you,
>>> 	Vasily Averin
>>>
>>>>> "[PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>> ->lock"
>>>>> tries to workaround the incorrect behaviour of some exported
>>>>> filesystems.
>>>>>
>>>>> Currently this way is used in nfsd and lockd, however it is not fully
>>>>> correct,
>>>>> and I still search some better solution, so perhaps
>>>>> '[PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>> ->lock'
>>>>> will be dropped later.
>>>>>
>>>>> Thank you,
>>>>> 	Vasily Averin
>>>>>
>>>>>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>>>>>> ---
>>>>>>>  fs/ksmbd/smb2pdu.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>>>>>>> index 0c020deb76bb..34f333549767 100644
>>>>>>> --- a/fs/ksmbd/smb2pdu.c
>>>>>>> +++ b/fs/ksmbd/smb2pdu.c
>>>>>>> @@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct
>>>>>>> file_lock
>>>>>>> *flock, int flags)
>>>>>>>  	switch (flags) {
>>>>>>>  	case SMB2_LOCKFLAG_SHARED:
>>>>>>>  		ksmbd_debug(SMB, "received shared request\n");
>>>>>>> -		cmd = F_SETLKW;
>>>>>>> +		cmd = F_SETLK;
>>>>>>>  		flock->fl_type = F_RDLCK;
>>>>>>>  		flock->fl_flags |= FL_SLEEP;
>>>>>>>  		break;
>>>>>>>  	case SMB2_LOCKFLAG_EXCLUSIVE:
>>>>>>>  		ksmbd_debug(SMB, "received exclusive request\n");
>>>>>>> -		cmd = F_SETLKW;
>>>>>>> +		cmd = F_SETLK;
>>>>>>>  		flock->fl_type = F_WRLCK;
>>>>>>>  		flock->fl_flags |= FL_SLEEP;
>>>>>>>  		break;
>>>>>>> --
>>>>>>> 2.25.1
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>
>>>
>
>
