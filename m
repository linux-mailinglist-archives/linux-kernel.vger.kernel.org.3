Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9447EFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352956AbhLXO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:56:52 -0500
Received: from nautica.notk.org ([91.121.71.147]:55836 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhLXO4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:56:51 -0500
Received: by nautica.notk.org (Postfix, from userid 108)
        id CF83CC009; Fri, 24 Dec 2021 15:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640357809; bh=nEVxjBgIHnPIs5D5WENJIX174TMUU1r26CncUlg8waU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fQuCefnHECg5/uop9AlUMr/9Le4MvFka3+vpKv1wR178qIr6yRXmz35ydWyfFRPEe
         R4ujOz7cefSC33v8WLiLZ8E+OUyLOwYF6nY2EETaRl8gJ3+uxPDfaNOmetGWm9flau
         LE+aelkRPs6kYBC9TDavnHOBrHypLQ9ZCO7EveQ8jE5imiMREXx+aw/RAkKBXZHVdS
         9FZk/RuzU7xHxJ4PHuT2TDHm1VxDte9Z4zWHVqMDfkcyuLmkpG1BtCNoXM6EyCv131
         N4nNZuxi9ere6NwAi2aRcb14csL+zKgtGup7Ta1W9FKm66OMtQqkwfguOAvbY8N8vH
         bEPFTne398stA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 89FDEC009;
        Fri, 24 Dec 2021 15:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640357808; bh=nEVxjBgIHnPIs5D5WENJIX174TMUU1r26CncUlg8waU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iXdVzxOv6RsOKwb0c+tWtgI30V4NUm4Xl+LFOakJds0yN1JiKhWY/ibKyUZIWlMgc
         iJwn3CN8cHbRrsiNQj0BYYRG5Dx7qGbtOKfFpp9MmcYaA7hUPfHMtM0BLNGvqcaRec
         0wrj+cnGY0qMRIuCxu7HYDyTE9oR5ud0+4WlLUL/n6LwvsRmaP/ypvnzFX8Gj9b6fU
         0WugExpRXRNTiv5B7PCOq833WD/FbmTnQLL+R1nz853Pm0SAXhGuXv8m+DFd6E9r3T
         ivnXbrtvxKQ0rQeHfGZuIO375qg/cnnWwpIKB1sFeu7+jfAhd2eefPcgeLq60wKCwi
         h6xvOUUiLKK0Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8adb1ba1;
        Fri, 24 Dec 2021 14:56:42 +0000 (UTC)
Date:   Fri, 24 Dec 2021 23:56:27 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
Message-ID: <YcXfm6U/6+Xmv7be@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a979a5bc-f2bc-7035-beed-6a3919471d39@virtuozzo.com>
 <d0e10f8b-565c-3772-75df-5cc2d729ff8a@virtuozzo.com>
 <05ab1af5-9b5f-f505-2a68-c90f50a1fb46@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote on Fri, Dec 24, 2021 at 01:18:54PM +0300:
> > On the other hand, just clearing the FL_SLEEP flag like you've done for
> > 9p will make the server think the lock has been queued when it hasn't
> > really been.
> > That means the client lock request will hang forever and never be
> > granted even when the lock becomes available later on, so unless I
> > misunderstood something here I don't think that's a reasonable fallback.
> 
> I did not get your this statement. Could you please elaborate it in more details?
> 
> Right now nfsd/lockd/ksmbd drop FL_SLEEP on own side, and this looks acceptable for them:
> instead of blocking lock they submit non-blocking SETLK and it's enough to avoid server deadlock. 
> 
> If the lock is already taken: SETLK just return an error and will not wait.
> I'm agree it isn't ideal, and perhaps  can cause server will return some unexpected errno,
> but I do not see how it can make the server think the lock has been queued.

Right, sorry I was still under the assumption that SETLK+sleep would
return error + enqueue something.
Reading again it must return FILE_LOCK_DEFERRED if enqueued, so the
server can make the difference, and we're "just" not respecting the
client's request to enqueue the lock as you say -- I guess that's
acceptable.

> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 612e297f3763..27ede4a4a6f4 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -142,10 +142,15 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
>  		BUG();
>  
> -	res = locks_lock_file_wait(filp, fl);
> -	if (res < 0)
> -		goto out;
> -
> +	if ((fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd)) {
> +		res = posix_lock_file(filp, fl, NULL);

Should we also check fl->fl_flags & (FL_POSIX|FL_FLOCK) like
locks_lock_file_wait does, to call either posix_lock_file or ... there
doesn't seem to be an exported flock_lock_file equivalent in the other
case, so back to wait variant there?
(or rephrasing the question, what happens if the lock is a FL_FLOCK lock
and we call posix_lock_file on it? Or are we guaranted that if FL_SLEEP
is set we're about posix locks?)

> +		if (res)
> +			goto out;
> +	} else {
> +		res = locks_lock_file_wait(filp, fl);
> +		if (res < 0)
> +			goto out;
> +	}
>  	/* convert posix lock to p9 tlock args */
>  	memset(&flock, 0, sizeof(flock));
>  	/* map the lock type */

Vasily Averin wrote on Fri, Dec 24, 2021 at 03:07:38PM +0300:
 > On 24.12.2021 10:31, Dominique Martinet wrote:
> > If that process is made asynchronous, we need a way to run more
> > 9p-specific code in that one's lm_grant callback, so we can proceed onto
> > the second step which is...
> > 
> >  - send the lock request to the 9p server and wait for its reply
> > (note that the current code is always synchronous here: even if you
> > request SETLK without the SLEEP flag you can be made to wait here.
> > I have work in the closest to make some requests asynchronous, so
> > locking could be made asynchronous when that lands, but my code
> > introduced a race somewhere I haven't had the time to fix so this
> > improvement will come later)
> > 
> > What would you suggest with that?
> 
> It isn't necessary to make request asynchronous,
> it's enough to avoid blocking locks.

Well, it depends on what you have in mind with blocking.
A synchronous RPC to some server which might never reply if it doesn't
feel like it (bug or whatever) is very much blocking in my opinion.

> As far as  I understand blocking does not happen for SETLK command,
> so it should be enough to chenge first part and call non-blocking 
> posix_file_lock() instead of blocking locks_lock_file_wait().
> 
> It would be great to make processing of 2nd part asynchronous too,
> but I think it looks like over-engineering, because we even are not
> 100% sure that someone really uses this functionality.

Yes, it will have to wait anyway, that asynchronous code has been
waiting for me to debug it for at least two years so it won't be ready
tomorrow... Let's start with what we can do; I'm happy with your
approach if it doesn't bring obvious problems.

-- 
Dominique
