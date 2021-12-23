Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7735247E9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhLWXO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 18:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbhLWXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:14:28 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39125C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 15:14:28 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id F2B34C01C; Fri, 24 Dec 2021 00:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640301265; bh=y91BeSmqGXr/+UBmcINrbASkr4x2UMrRV+bdI+j5fFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCvcN9EswgESruSc1khcij7KfrOQyVmyJ+s//wERoiXWzsMHCyYp2DnMGInInAAcr
         fuG0LdJTkClpNhhPLA1HAZyXMKDYeJ2HGiNS2GSVBnga/LzutqzVrc2piszXmODC8x
         /roXEf6eMiiDZbICX+AlSjQkog9aOVGsBFQhdFqw6JRjCp433V0ysyL6i4EQGd65lu
         39Yoq4SAkk8pJLuxkJHkiMGM0PITmKU2AhFWymgvCGXRx/fNP++Syx1zI+f6AshOfs
         dpjaPE9d1DDdxTO095XE4KmobN2aBClWSlSRRPxoZYhQc2WNnV9wED92rYgPc9NzMs
         THHalMNmAFOBw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 69FA7C009;
        Fri, 24 Dec 2021 00:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640301265; bh=y91BeSmqGXr/+UBmcINrbASkr4x2UMrRV+bdI+j5fFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCvcN9EswgESruSc1khcij7KfrOQyVmyJ+s//wERoiXWzsMHCyYp2DnMGInInAAcr
         fuG0LdJTkClpNhhPLA1HAZyXMKDYeJ2HGiNS2GSVBnga/LzutqzVrc2piszXmODC8x
         /roXEf6eMiiDZbICX+AlSjQkog9aOVGsBFQhdFqw6JRjCp433V0ysyL6i4EQGd65lu
         39Yoq4SAkk8pJLuxkJHkiMGM0PITmKU2AhFWymgvCGXRx/fNP++Syx1zI+f6AshOfs
         dpjaPE9d1DDdxTO095XE4KmobN2aBClWSlSRRPxoZYhQc2WNnV9wED92rYgPc9NzMs
         THHalMNmAFOBw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b7d8b844;
        Thu, 23 Dec 2021 23:14:20 +0000 (UTC)
Date:   Fri, 24 Dec 2021 08:14:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
Message-ID: <YcUCvUF10TKg2wDI@codewreck.org>
References: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote on Thu, Dec 23, 2021 at 09:21:23PM +0300:
> kernel export thread (nfsd/lockd/ksmbd) uses F_SETLK cmd with the FL_SLEEP
> flag set to request asynchronous processing of blocking locks.
> 
> Currently v9fs does not support such requests and calls blocking
> locks_lock_file_wait() function.

There's two stages to 9p locks: the client first tries to get the lock
locally on the client, then if it was obtained locally also tries to get
it on the server.
I believe the servers should just ignores flags like FL_SLEEP they don't
know about, so we need to translate it as well if required.

> To work around the problem let's detect such request, drop FL_SLEEP
> before execution of potentially blocking functions.

I'm not up to date with lock mechanisms, could you confirm I understand
the flags right?
- F_SETLK: tries to lock, on conflict return immediately with error
- F_SETLKW|FL_SLEEP: tries to lock, on conflict wait for lock to become available
- F_SETLKW: not possible through flock/fcntl setlk, can happen otherwise?
but for 9p purpose same as above.
- F_SETLK|FL_SLEEP: tries to lock, on conflict ????? you'd want it to
return immediately but setup some callback to be woken up? how could
that work without passing some wake up struct? or just behave as plain
F_SETLK? but then FL_SLEEP has no purpose, I don't get it.


> 
> Dropped FL_SLEEP flag should be restored back because some calling
> function (nfsd4_lock) require it.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215383
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/9p/vfs_file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 612e297f3763..81c98afdbb32 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -135,6 +135,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	int res = 0;
>  	unsigned char fl_type;
>  	struct v9fs_session_info *v9ses;
> +	bool async = false;
>  
>  	fid = filp->private_data;
>  	BUG_ON(fid == NULL);
> @@ -142,6 +143,10 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
>  		BUG();
>  
> +	async = (fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd);
> +	if (async)
> +		fl->fl_flags &= ~FL_SLEEP;
> +

So clearing the flag makes the local lock not wait at all in case of
SETLK|FL_SLEEP, and this errors instead.

I can't comment on this without understanding what's expected better

>  	res = locks_lock_file_wait(filp, fl);
>  	if (res < 0)
>  		goto out;
> @@ -230,6 +235,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	if (flock.client_id != fid->clnt->name)
>  		kfree(flock.client_id);
>  out:
> +	if (async)
> +		fl->fl_flags |= FL_SLEEP;
>  	return res;
>  }
>  

-- 
Dominique
