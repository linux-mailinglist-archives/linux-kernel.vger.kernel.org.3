Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602347CB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhLVCuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhLVCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D99C061574;
        Tue, 21 Dec 2021 18:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B99BB81A37;
        Wed, 22 Dec 2021 02:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0759C36AEC;
        Wed, 22 Dec 2021 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640141413;
        bh=heaGfU8K5wQbCU/IeiVmm4nYfRSn8Op7EFaMyViC4do=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=st8oI4CL6J70vsDbv/MD56lCEkKhqtfHbBwPw1Ml+tS0rLYXaeL3f9ARR77B/HnBL
         dX0JRGV07EKIfxWaTj4InvRkxJ8JQZBnOPofxNJ9K9Sv67fZTEH3/DRpSYrv3BzsVH
         eVEWsLpfW9OIbpqiEDjsxNmE1UhXi3komL8iLchtKcOsUpdXnuvENRZ5d6pvV118jm
         PKvh7y0r2HpmI4TM4dwzlDZye/ybs2spbPBiIIYuB2YKbPfYPhbftz3HOFZqS1qCot
         ppeherPS5ZYUQmZPevuZxmO6OnRpH9EtvhxLaCdag13530/A3gqBxRBqJWiJE+MuvQ
         7f1b8RTzCsyHA==
Received: by mail-oi1-f177.google.com with SMTP id v6so1710520oib.13;
        Tue, 21 Dec 2021 18:50:13 -0800 (PST)
X-Gm-Message-State: AOAM533aQshZt/07bKpxOPnrhPsozHXirHylP3MIwKOCoLSwyN9vjnoN
        P1T1o9jxgywzM4l0LK+wWB1jY2OapygPppOGihE=
X-Google-Smtp-Source: ABdhPJw9vDABzFuk7y5WMXaJ6JYCAhxixceFj9RLqlQJOCT5ok5yu3nqssxaGEhIjoAqyd4id4PqNBWV0nVK815wI3o=
X-Received: by 2002:aca:a808:: with SMTP id r8mr763636oie.8.1640141412920;
 Tue, 21 Dec 2021 18:50:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Tue, 21 Dec 2021 18:50:12
 -0800 (PST)
In-Reply-To: <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com>
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com> <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 22 Dec 2021 11:50:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
Message-ID: <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
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

2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
> On 21.12.2021 15:02, Namjae Jeon wrote:
>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>> To avoid possible deadlock ksmbd should process locks asynchronously.
>>> Callers expecting vfs_file_locks() to return asynchronously should only
>>> use F_SETLK, not F_SETLKW.
>> Should I check this patch instead of
>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock ?
>
> no, these patches are independent and both ones are required.
> current patch fixes incorrect kernel thread behaviour:
> kernel threads should not use F_SETLKW for locking requests.
How does this patch work? posix_lock_file in vfs_lock_file() does not use cmd.
And your patch still leaves FL_SLEEP.

>
> "[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock"
> tries to workaround the incorrect behaviour of some exported filesystems.
>
> Currently this way is used in nfsd and lockd, however it is not fully
> correct,
> and I still search some better solution, so perhaps
> '[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock'
> will be dropped later.
>
> Thank you,
> 	Vasily Averin
>
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>> ---
>>>  fs/ksmbd/smb2pdu.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>>> index 0c020deb76bb..34f333549767 100644
>>> --- a/fs/ksmbd/smb2pdu.c
>>> +++ b/fs/ksmbd/smb2pdu.c
>>> @@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct file_lock
>>> *flock, int flags)
>>>  	switch (flags) {
>>>  	case SMB2_LOCKFLAG_SHARED:
>>>  		ksmbd_debug(SMB, "received shared request\n");
>>> -		cmd = F_SETLKW;
>>> +		cmd = F_SETLK;
>>>  		flock->fl_type = F_RDLCK;
>>>  		flock->fl_flags |= FL_SLEEP;
>>>  		break;
>>>  	case SMB2_LOCKFLAG_EXCLUSIVE:
>>>  		ksmbd_debug(SMB, "received exclusive request\n");
>>> -		cmd = F_SETLKW;
>>> +		cmd = F_SETLK;
>>>  		flock->fl_type = F_WRLCK;
>>>  		flock->fl_flags |= FL_SLEEP;
>>>  		break;
>>> --
>>> 2.25.1
>>>
>>>
>
>
