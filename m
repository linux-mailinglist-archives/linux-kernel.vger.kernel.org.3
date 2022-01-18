Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23424492FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349428AbiARU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349276AbiARU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642539489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9WqescKjIAzil7l6cr9HCVfXjlyRssVLY+HORpld6I=;
        b=PwBnb0Egc7pTUBTaL2QM9J7a1MnoZd9pL1LL8FwGUs0+Pcq/Rq70Nklro/A9Xgb/mkxsHz
        XEEwgvzjC0k01D+INW1le0D4oreCsh/LsQCoN/jh6HVYZag3+BOGHAcgPA7AmfaR1GQFNW
        Kh2ewv3iMss/QxPy1IJ8Qg15fIJuVD8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-9gCoO90WMWmLdkxF8K4O0A-1; Tue, 18 Jan 2022 15:58:07 -0500
X-MC-Unique: 9gCoO90WMWmLdkxF8K4O0A-1
Received: by mail-qv1-f71.google.com with SMTP id a10-20020a056214062a00b0041f0242eb11so522543qvx.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9WqescKjIAzil7l6cr9HCVfXjlyRssVLY+HORpld6I=;
        b=HoSY2Ge0j978YDI+JWAhUZ70fsUJ+CafkE+Yc14hpF3BzqUw0Z+TTSOGcKW1oXxH2U
         PL5MtF560ffshU9cyYT1DtiMevLZt6UCLbtDGLIpcUCoc5jnsoSbpooQYnYpLLNqzILz
         KrEE0ozc5Iit6R02OKvIAtbSE3QqUtDPRxryFWxTqGVDnPOTOpRdgE2dvA4WeBOttkXS
         cEhJJsJU4/b6QS5s8wvRyvtLwQDZAbn1g1/j42HJVPDqodkgwyZ2lRqC/3Bdoj7GWXaa
         nT+bbabtqRtvE8Ks1mt/jUiaCb7P/8LUpMyBzbn+y7Z/3V3QAnukhmDTF51ffLt3RMMr
         Rj4A==
X-Gm-Message-State: AOAM533bS3YO9hHApeVF8scfXcnGVTKVU4+M5VBNt2Jtrc3EnN2RSwI7
        is3KgT0rIjA5XIiodt6q0KAvxo2Nj+WAAekdfoVrhwOu9IaX/J+V8abmLOQjTAYTvWO2PuXv96Z
        Jg09mbirLnjUmCnxGIHfI2Rna
X-Received: by 2002:a05:620a:2448:: with SMTP id h8mr4958217qkn.231.1642539487281;
        Tue, 18 Jan 2022 12:58:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq3Ndqgu/1eSPl8H1/GfW4nW+qGmp6SP+v18upZ87Y6BP23e5HdqaD5fVe/w9z/YJHEmEHtw==
X-Received: by 2002:a05:620a:2448:: with SMTP id h8mr4958206qkn.231.1642539487045;
        Tue, 18 Jan 2022 12:58:07 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id az15sm5128276qkb.124.2022.01.18.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 12:58:06 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:58:04 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <Yecp3DspJOkhaDGV@bfoster>
References: <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
 <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
 <YebFCeLcbziyMjbA@bfoster>
 <YecGC06UrGrfonS0@bfoster>
 <YecTA9nclOowdDEu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YecTA9nclOowdDEu@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:20:35PM +0000, Al Viro wrote:
> On Tue, Jan 18, 2022 at 01:25:15PM -0500, Brian Foster wrote:
> 
> > If I go back to the inactive -> reclaimable grace period variant and
> > also insert a start_poll_synchronize_rcu() and
> > poll_state_synchronize_rcu() pair across the inactive processing
> > sequence, I start seeing numbers closer to ~36k cycles. IOW, the
> > xfs_inodegc_inactivate() helper looks something like this:
> > 
> >         if (poll_state_synchronize_rcu(ip->i_destroy_gp))
> >                 xfs_inodegc_set_reclaimable(ip);
> >         else
> >                 call_rcu(&VFS_I(ip)->i_rcu, xfs_inodegc_set_reclaimable_callback);
> > 
> > ... to skip the rcu grace period if one had already passed while the
> > inode sat on the inactivation queue and was processed.
> > 
> > However my box went haywire shortly after with rcu stall reports or
> > something if I let that continue to run longer, so I'll probably have to
> > look into that lockdep splat (complaining about &pag->pag_ici_lock in
> > rcu context, perhaps needs to become irq safe?) or see if something else
> > is busted..
> 
> Umm...  Could you (or Dave) describe where does the mainline do the
> RCU delay mentioned several times in these threads, in case of
> 	* unlink()
> 	* overwriting rename()
> 	* open() + unlink() + close() (that one, obviously, for regular files)
> 

If you're referring to the existing rcu delay in XFS, I suspect that
refers to xfs_reclaim_inode(). The last bits of that function remove the
inode from the perag tree and then calls __xfs_inode_free(), which frees
the inode via rcu callback.

BTW, I think the experiment above is either going to require an audit to
make the various _set_reclaimable() locks irq safe or something a bit
more ugly like putting the inode back on a workqueue after the rcu delay
to make the state transition. Given the incremental improvement from
using start_poll_synchronize_rcu(), I replaced the above destroy side
code with a cond_synchronize_rcu(ip->i_destroy_gp) call on the
iget/recycle side and see similar results (~36k cycles per 60s, but so
far without any explosions).

Brian

> The thing is, if we already do have an RCU delay in there, there might be
> a better solution - making sure it happens downstream of d_drop() (in case
> when dentry has other references) or dentry going negative (in case we are
> holding the sole reference to it).
> 
> If we can do that, RCU'd dcache lookups won't run into inode reuse at all.
> Sure, right now d_delete() comes last *and* we want the target inode to stay
> around past the call of ->unlink().  But if you look at do_unlinkat() you'll
> see an interesting-looking wart with ihold/iput around vfs_unlink().  Not
> sure if you remember the story on that one; basically, it's "we'd rather
> have possible IO on inode freeing to happen outside of the lock on parent".
> 
> nfsd and mqueue do the same thing; ksmbd does not.  OTOH, ksmbd appears to
> force the "make victim go unhashed, sole reference or not".  ecryptfs
> definitely does that forcing (deliberately so).
> 
> That area could use some rethinking, and if we can deal with the inode reuse
> delay while we are at it...
> 
> Overwriting rename() is also interesting in that respect, of course.
> 
> I can go and try to RTFS my way through xfs iget-related code, but I'd
> obviously prefer to do so with at least some overview of that thing
> from the folks familiar with it.  Seeing that it's a lockless search
> structure, missing something subtle there is all too easy, especially
> with the lookup-by-fhandle stuff in the mix...
> 

