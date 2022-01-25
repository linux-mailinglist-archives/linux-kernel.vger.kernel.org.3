Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5549BE46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiAYWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:14:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45284 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:14:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B03CDB81B6B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ED3C340E0;
        Tue, 25 Jan 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643148856;
        bh=wzQ7De1OASBwcj3eJi86mBXPWkiGQw8ikhGXdFZuX4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CD6N+fucU5W+Oe0l9yslZOos70un8YyAOxgmEVyiljOD5LNiUrrshae3qKmqz/UfW
         zRo5ffiEfJbWjIcVeOeKFBVlfi8vThLQ4Dp7jTb25WDhtEwOg+GO8zQJV0sgnYoc7B
         zUBR3soAR5Uil1cGxJO4zU/P2+yKngc3sDIJFNcBvovrpmW1Iv9kvRVwMBCQVDwATl
         hF6ATYuwsiQq+b8Tc4GiWzJMQISjrXzgNWvEqpruia1PUZaQu8HmvOW10mpVu3jwoz
         Oo1lIDqQOZbnTen10a52SgQm6goBIQ4PCtwIU9xzZ5vRJTkrP6ydheCM6WG71/qvO3
         j2hYTsaW5tIcg==
Date:   Tue, 25 Jan 2022 22:13:58 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Harry Austen <harryausten@hotmail.co.uk>
Cc:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fileattr_set unsupported attribute
 handling
Message-ID: <YfB2Jqs3RGRnH63R@gmail.com>
References: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
 <Ye79OLCFLR3H+GnY@gmail.com>
 <AM6PR10MB2838705554FCB6ACE86F12BBFA5F9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2838705554FCB6ACE86F12BBFA5F9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:01:49PM +0000, Harry Austen wrote:
> On Monday, 24 January 2022 19:25:44 GMT Eric Biggers wrote:
> > On Sat, Jan 22, 2022 at 12:59:03PM +0000, Harry Austen wrote:
> > > FS_IOC_SETFLAGS ioctl should return EOPNOTSUPP if the file attribute
> > > (e.g. FS_NOCOW_FL) is not supported, rather than silently ignoring it
> > > and returning success.
> > > 
> > > Fixes: 9b1bb01c8ae7 (f2fs: convert to fileattr)
> > > Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>
> > > ---
> > > 
> > >  fs/f2fs/file.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 92ec2699bc85..061bf35c2582 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -3085,9 +3085,8 @@ int f2fs_fileattr_set(struct user_namespace
> > > *mnt_userns,> 
> > >  		return -EIO;
> > >  	
> > >  	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
> > >  	
> > >  		return -ENOSPC;
> > > 
> > > -	if (fsflags & ~F2FS_GETTABLE_FS_FL)
> > > +	if (fsflags & ~F2FS_SETTABLE_FS_FL)
> > > 
> > >  		return -EOPNOTSUPP;
> > > 
> > > -	fsflags &= F2FS_SETTABLE_FS_FL;
> > > 
> > >  	if (!fa->flags_valid)
> > >  	
> > >  		mask &= FS_COMMON_FL;
> > 
> > This is intentional, and matches what ext4 does; see the comment in the ext4
> > implementation of this:
> > 
> >         /*
> >          * chattr(1) grabs flags via GETFLAGS, modifies the result and
> >          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
> >          * more restrictive than just silently masking off visible but
> >          * not settable flags as we always did.
> >          */
> 
> Ah, my apologies. I thought it looked a little too obvious. Clearly I
> should have looked at the ext4 code. Please disregard this patch.
> 
> Is there anything else that could be done to improve unsettable
> attribute handling? For example, is there a reason FS_NOCOW_FL is
> gettable but not settable? Could it be added to the settable list?

A lot of flags are gettable by FS_IOC_GETFLAGS but not settable by
FS_IOC_SETFLAGS, typically because they can only be set through a dedicated
interface.  For example, the encrypt flag can only be set using
FS_IOC_SET_ENCRYPTION_POLICY, or via inheritance.

> > 
> > Also, even if this patch was correct, the Fixes tag is wrong.
> 
> Having looked at this a bit more, I assume you are saying this due to
> the missing double quotes around the commit summary? (just so I know for
> next time as this is my first attempt at sending a kernel patch)
> 

There's that, but more importantly the commit you listed is wrong.  The relevant
code was added by an earlier commit, and that commit just moved it.

- Eric
