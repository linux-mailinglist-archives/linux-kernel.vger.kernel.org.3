Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBD47ECAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351811AbhLXHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbhLXHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:32:06 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5AEC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:32:05 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 527CFC01D; Fri, 24 Dec 2021 08:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640331124; bh=fQFh70LIKS+fc6EM46i8xVd3yum4u2d4HWSgc/deHEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJwVM3zcZXmAb5k5D0aVF+YqYcJUcZCWgq5t/ORw9j9S2gCVkzZAtPDcaVkxVEDi5
         3xscFEKhn3hUeXlTIwiS5uInYIRuUOnU4ju9xIRq7bxa0qnpbHRO9WftRgjyA6lMtd
         XSc3wiWX0ENospAbrewFLRxsBAPiCJnKqsQieWMm1pz218tqbPqslTAmZ5jaIXiMmU
         7kI7vAWUPSsB2jb5fCXFpfBaa2ovRFPAwFeKbZhkLYSwF8T79WA/vELvjVyS3ZaCvD
         XFV34Kp0rLLcI0s4C0PlwcAyfrq5AokVzeD+zUsFatTXDb2ZWzjANVEPV2zpPSUGV2
         15RHWGH49q9JQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B3E4AC009;
        Fri, 24 Dec 2021 08:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640331122; bh=fQFh70LIKS+fc6EM46i8xVd3yum4u2d4HWSgc/deHEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FP5trq7+lSUifaeHJ07uIZXd/hreIq3qIDae8XcukWedgoNOPzD5mgZRJBLDLlQ7o
         yaIQPHrRhPY4bHPFDKNmdQqV35qGG/Tv7fYg097a3TY4DeJ2AeUU0bm9nNh7Jc4TnT
         lvEcAWdN89nj41jkX7VIU2+y9nr6FGO7xZJj6T14cuZFdPdBtpw/Eslo5SYlwMgR+n
         GH3ru1ThWqz6z+d6IGla514BKr0AezJhQALihsHwpuAh0S/7Cn5+khhYSOchgU3crr
         Y9TsJhQYbljaa7d2WEyb3MEpJPCunThbqvf2q4dOEZYk7hN/hb1CUqHrQho+a2jLYB
         5+JqlAs3sAyjw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6bbcff1c;
        Fri, 24 Dec 2021 07:31:56 +0000 (UTC)
Date:   Fri, 24 Dec 2021 16:31:40 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
Message-ID: <YcV3XDFw5sMyvTVL@codewreck.org>
References: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
 <YcUCvUF10TKg2wDI@codewreck.org>
 <644227dc-4771-3111-aabd-20ac12b69a2d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <644227dc-4771-3111-aabd-20ac12b69a2d@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote on Fri, Dec 24, 2021 at 10:08:57AM +0300:
> > I'm not up to date with lock mechanisms, could you confirm I understand
> > the flags right?
> > - F_SETLK: tries to lock, on conflict return immediately with error
> > - F_SETLKW|FL_SLEEP: tries to lock, on conflict wait for lock to become available
> > - F_SETLKW: not possible through flock/fcntl setlk, can happen otherwise?
> > but for 9p purpose same as above.
> > - F_SETLK|FL_SLEEP: tries to lock, on conflict ????? you'd want it to
> > return immediately but setup some callback to be woken up? how could
> > that work without passing some wake up struct? or just behave as plain
> > F_SETLK? but then FL_SLEEP has no purpose, I don't get it.
> 
> I apologize in advance for the long answer, but I tried to state all the details
> of the detected problem.
> 
> Below is description copy-pasted from comment above vfs_lock_file()

Thanks, I hadn't noticed this comment this morning.

> "
>  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
>  * locks, the ->lock() interface may return asynchronously, before the lock has
>  * been granted or denied by the underlying filesystem, if (and only if)
>  * lm_grant is set. Callers expecting ->lock() to return asynchronously
>  * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
>  * the request is for a blocking lock. When ->lock() does return asynchronously,
>  * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
>  * request completes.

Ok so that's the part I was missing.
The file_lock struct will have fl_lmops->lm_grant set in this case and
we just need to remember that and call lm_grant when the lock has been set...

> They all are servers, and they can receive blocking lock requests from own clients.
> They all cannot process such requests synchronously because it causes server deadlock.
> In simplest form, if single threaded nfsd is blocked on processing such request,
> whole nfs server cannot process any other commands.

Note 9p does not have an fh_to_dentry op (no open by handle type of
calls, the protocol just has no way of dealing with it), so I believe
knfsd cannot re-export 9p filesystems and wouldn't be surprised if
others can't either -- as thus this all might not be an issue for you if
F_SETLK|FL_SLEEP users all are such servers


> One of our customers tried to export fuse/glusters via nfsd and reported about
> memory corruption in nfsd4_lock() function. We found few related bugs in nfsd,
> however finally we noticed that fuse blocks on processing such requests. 
> During investigation we have found that fuse just ignored F_SETLK command,
> handled FL_SLEEP flag and submitted blocking FUSE_SETLKW command.

I'm not sure I understand how upgrading to SETLKW is worse than dropping
the FL_SLEEP flag (I mean, I see it's bad as it wasn't what the server
expects, but while it will block a thread for an undefined period of
time and may cause deadlocks I don't see how it would cause memory
corruptions?)

> Answering on you question: it's ok to ignore of FL_SLEEP flag for F_SETLK command,

On the other hand, just clearing the FL_SLEEP flag like you've done for
9p will make the server think the lock has been queued when it hasn't
really been.
That means the client lock request will hang forever and never be
granted even when the lock becomes available later on, so unless I
misunderstood something here I don't think that's a reasonable fallback.
So...

> It would be even better to use posix_lock_file() instead of locks_lock_file_wait(),
> but I cannot do it without your assistance.

let's try to fix this properly instead, I'm happy to help.

Basically 9p does things in two steps:
 - first it tries to get the lock locally at the vfs level.
I'm not familiar with all the locking helpers we have at disposal, but
as long as the distinction between flock and posix locks is kept I'm
happy with anything here.

If that process is made asynchronous, we need a way to run more
9p-specific code in that one's lm_grant callback, so we can proceed onto
the second step which is...

 - send the lock request to the 9p server and wait for its reply
(note that the current code is always synchronous here: even if you
request SETLK without the SLEEP flag you can be made to wait here.
I have work in the closest to make some requests asynchronous, so
locking could be made asynchronous when that lands, but my code
introduced a race somewhere I haven't had the time to fix so this
improvement will come later)



What would you suggest with that?


-- 
Dominique
