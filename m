Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA66547FB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhL0JSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhL0JSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:18:14 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E36C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:18:14 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 68087C01C; Mon, 27 Dec 2021 10:18:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640596691; bh=9GoJxDqGjcRle+gYeU2D7CR3n3CaZRrEOUstVUe74VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycasObKFmpSLBqcmWah4MDS1LqNP8bZObSLD04HdpKMMrTa1F7dAmZzyf62nEDVvg
         OaXhhRbLFmGi20MZZJrii8+wYVt6TAgzVpvfvlmLRygMKwO6YedzbtQA4ZWonv4Bkl
         Kk8m73x8cTd3WWMPNaAxZlJigQ+q9e02cs0iF6I7Cx828LelwLWYdSD+CmW+KbYG1Z
         wgUGSLJhOovhgzyIk4CPMe7et2rRfMfognVxeIMEtKEPupvrkdd4p1lgs3sHttobOK
         4fizV6lEWEHVy5YEizkQ7c416k0gL9IaRJrG6SVze4q7ffYhI6LgZNCshi2xY17pxQ
         n8ItYg4kAo3iQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B119CC009;
        Mon, 27 Dec 2021 10:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1640596690; bh=9GoJxDqGjcRle+gYeU2D7CR3n3CaZRrEOUstVUe74VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE3RL9Lfba9zohoMYxbfHrOgN+G5nc+mQ7bzQHl3IEMCp1gE+Z5bUaUBrX6yyzlpH
         JJxwIXxKFKKlu3JnPVP1B9ypXFR/dWOK0AtsEWr+IE5vhWHRPmewvkBs9mcmJ1/JCM
         WQHuzfdeI+54QKnxGlISNgCKJLHteqIjKaM6KokGiNqcwRYACEzQxVSW7WR7rHwqIz
         kkbpiS50cQA99f70yGEHqWLE3SIg2frMPf/pfVEHrQOZFZOsqbS7bClwUk3fvtPNtF
         E2QHv8aDA2mTdqE1aB6nVNqIvW4pbLGBcEQyV/ZzVv6xOqJTUYTnRSGMwFZ1ZBxaXw
         Gwni0bpjLfMGQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 65fabf50;
        Mon, 27 Dec 2021 09:18:05 +0000 (UTC)
Date:   Mon, 27 Dec 2021 18:17:49 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
Message-ID: <YcmEvWm5dB4/d224@codewreck.org>
References: <YcXfm6U/6+Xmv7be@codewreck.org>
 <5ec8d1c6-e410-e297-0d3a-037c7de30b6b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ec8d1c6-e410-e297-0d3a-037c7de30b6b@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote on Mon, Dec 27, 2021 at 10:42:48AM +0300:
> > Should we also check fl->fl_flags & (FL_POSIX|FL_FLOCK) like
> > locks_lock_file_wait does, to call either posix_lock_file or ... there
> > doesn't seem to be an exported flock_lock_file equivalent in the other
> > case, so back to wait variant there?
> > (or rephrasing the question, what happens if the lock is a FL_FLOCK lock
> > and we call posix_lock_file on it? Or are we guaranted that if FL_SLEEP
> > is set we're about posix locks?)
> 
> SETLK with FL_SLEEP flag can be set by kernel export threads for posix locks only.

I see.
Would it make sense to add a WARN_ON or similar in case that ever
changes in the future?

I'd be more comfortable with one given it'd be quite a sneaky bug when
it does (locks will still appear to work, just wrong kind of locks...).
I assume that if it ever does all filesystems will be reviewed for
it... But sometimes it's best to make sure.

> > Well, it depends on what you have in mind with blocking.
> > A synchronous RPC to some server which might never reply if it doesn't
> > feel like it (bug or whatever) is very much blocking in my opinion.
> 
> The main goal is to avoid deadlock of server threads.
> It is acceptable to sleep or process such a request for a very long time,
> however it is unacceptable to wait for another command to remove our lock,
> because there can be no available working threads to process this command:
> all of them can be busy by processing of blocking locks. 

Ok, that makes sense to me.

I'm happy with the current patch except for my paranoia on that fcntl
lock check, let me know what you think about it and I'll apply either
this or a new version.

Thanks!
-- 
Dominique
