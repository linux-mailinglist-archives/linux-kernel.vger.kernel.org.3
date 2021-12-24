Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9247F16D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 00:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhLXXIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 18:08:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60594 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhLXXIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 18:08:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A8D6B82356;
        Fri, 24 Dec 2021 23:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CC3C36AE8;
        Fri, 24 Dec 2021 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640387327;
        bh=kQYdLE4Ohtv0TSsd1ZGT+vAMRM3Ifa8w6cgx2XHM8j4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ot81bgZtO8DJTsGcW9lmxd47+zBj1PByBWPvhJ16YBOiGTwdaaFz95K8AzdePJRmG
         ckPqJSq6JRKa2Zl05zAsheGL75jqQ8CTIUJG1uYB5vnHA6eEnTZlP4Lnu5e7xiUGcy
         TaAkfWxgcNwzO9Xqdm3QbUgCZEy/MCIlaOynH84hSm+dZhitk4mqUwv5lBqubEBJi6
         7L3Kw/iBD4HSRfEOqoMt2AYt1pXO6Nw240J8hdTNLPXwmVHL5IL0wEcJ+Hf91kMmcQ
         v7LaHgJbCP8XqSXFy65VRd9DjWlFGSixSYeL9rbEfGALIaOKRveD7auZyaBAiNKvto
         ZOK6UNabd4f1A==
Received: by mail-yb1-f182.google.com with SMTP id e136so29035589ybc.4;
        Fri, 24 Dec 2021 15:08:47 -0800 (PST)
X-Gm-Message-State: AOAM532upr2BH5mE3cD74BamighebFwX0LcizNgd2mDMpATV2OpH0VdM
        XwPn8GkD+TSKTpL7kOm/aiFxab6ni3S46xF/tg8=
X-Google-Smtp-Source: ABdhPJz/HP3QixsKQZxkYFFEE7jSKoFOzdwvoRYx1cXQ/FW7JBM9W8+EkHPxa9o/C2O1Ot6b5HjnVK9Mbfm0hjorKWQ=
X-Received: by 2002:a25:d889:: with SMTP id p131mr4310538ybg.475.1640387326887;
 Fri, 24 Dec 2021 15:08:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:1313:b0:11b:f4cd:b869 with HTTP; Fri, 24 Dec 2021
 15:08:46 -0800 (PST)
In-Reply-To: <846ff849-58a9-ff03-8144-d7d47775553b@virtuozzo.com>
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
 <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com> <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
 <f210483a-69f7-1983-65cf-f3f5bd4112ac@virtuozzo.com> <CAKYAXd97orfDc7VA+fae7tLjTufMksQTepYKazY=gX7UkG0+rw@mail.gmail.com>
 <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com> <CAKYAXd-zBBF_J-z1Ph4ruRD3Fb3EORsKfDjKw0yX42D0SCD_Ow@mail.gmail.com>
 <4e61a114-d55a-3c14-e019-83891c5b1f0a@virtuozzo.com> <846ff849-58a9-ff03-8144-d7d47775553b@virtuozzo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 25 Dec 2021 08:08:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8=EoOnMHURFPfwvCHmit+Xg+tKdsjWN7wrEXDa53aVxg@mail.gmail.com>
Message-ID: <CAKYAXd8=EoOnMHURFPfwvCHmit+Xg+tKdsjWN7wrEXDa53aVxg@mail.gmail.com>
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

2021-12-24 21:31 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
> On 22.12.2021 18:17, Vasily Averin wrote:
>> On 22.12.2021 11:58, Namjae Jeon wrote:
>>> 2021-12-22 15:51 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>> On 22.12.2021 08:25, Namjae Jeon wrote:
>>>>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>>>>> To avoid possible deadlock ksmbd should process locks
>>>>>>>>>> asynchronously.
>>>>>>>>>> Callers expecting vfs_file_locks() to return asynchronously
>>>>>>>>>> should
>>>>>>>>>> only
>>>>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>>>>> Should I check this patch instead of
>>>>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own
>>>>>>>>> ->lock
>>>>>>>>> ?
>>>>>>>>
>>>>>>>> no, these patches are independent and both ones are required.
>>>>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>>>>> How does this patch work? posix_lock_file in vfs_lock_file() does
>>>>>>> not
>>>>>>> use
>>>>>>> cmd.
>>>>>>> And your patch still leaves FL_SLEEP.
>>>>>>
>>>>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement
>>>>>> described
>>>>>> in
>>>>>> comment above vfs_lock_file().
>>>>>>
>>>>>> posix_lock_file() is not used in all ->lock() functions, and use
>>>>>> F_SETLKW
>>>>>> forces some of affected filesystem use blocking locks:
>>>>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>>>>> flag on fs with its own ->lock ", this patch is meaningless. How is
>>>>> ->lock() with F_SETLKW called?
>>>>
>>>> I got your point finally,
>>>> yes, you are right, now this cannot happen.
>>>> However I'm going to fix all affected filesystems and then revert
>>>> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
>>>> When this happen and ksmbd will still use IS_SETLKW it will trigger the
>>>> problems described below.
>>> If so, You can include one patch(this patch + revert patch) in patch
>>> series for fixing ->lock of all filesystem.
>
> I've checked how smb2_lock() handles FILE_LOCK_DEFERRED returned by
> vfs_lock_file() call.
> It seems for me, working thread will be blocked in
> ksmbd_vfs_posix_lock_wait(),
> so whole ksmbd server still can deadlock. Am I wrong probably?
No, Each commands are handled by ksmbd-io kworkers.

Thanks!
>
> Thank you,
> 	Vasily Averin
>
