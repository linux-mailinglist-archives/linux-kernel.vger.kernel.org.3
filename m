Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414724F955B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiDHMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiDHMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02043F94EF;
        Fri,  8 Apr 2022 05:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1244B62075;
        Fri,  8 Apr 2022 12:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0B0C385A8;
        Fri,  8 Apr 2022 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419495;
        bh=DvBk2NjJx6xXxR2HYjxT2aaULsB7g1Rt0KWFngBdd8E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M51P4EIJLO414AKWYGjdmcOo1wICr/XU/d4sLqUWKXCvZlVosh/fGh7xdDLXXjMXh
         af9h17GGPTvTPJw//GOCLPewgaMJGnD/4Lthuv94VRVkHVmpFKU+y1eel9H+4WCI/P
         TUwYVh/2wvBqi0bhdWNrI+5QVUb7dDcFxD1iKTvug/R5NPnly1TTbQcLIeyjWNjItN
         ng26CBwvQIWNN/PvEjbM6exg/0CMSn3RiLmEXs4zGe2yU8rTi8/w0C/Lx1s25hs0T/
         V5jePEzuNuzhYX3ZBWwZRuTOC5y8yh7yeoA4ZuN5Hit+0VVwt3X1xbs31F8voYq4Qj
         hmg6qLPUHXOpA==
Message-ID: <947af0b22bf50affa504bc0ca45fb0e290fc7805.camel@kernel.org>
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Apr 2022 08:04:53 -0400
In-Reply-To: <0133ed11-bb90-9337-e787-66851cbbc379@redhat.com>
References: <20220407151521.7968-1-lhenriques@suse.de>
         <0133ed11-bb90-9337-e787-66851cbbc379@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-08 at 10:47 +0800, Xiubo Li wrote:
> On 4/7/22 11:15 PM, Luís Henriques wrote:
> > When doing a direct/sync write, we need to invalidate the page cache in
> > the range being written to.  If we don't do this, the cache will include
> > invalid data as we just did a write that avoided the page cache.
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> >   fs/ceph/file.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > Changes since v3:
> > - Dropped initial call to invalidate_inode_pages2_range()
> > - Added extra comment to document invalidation
> > 
> > Changes since v2:
> > - Invalidation needs to be done after a write
> > 
> > Changes since v1:
> > - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> > - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
> > 
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 5072570c2203..97f764b2fbdd 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1606,11 +1606,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> >   		return ret;
> >   
> >   	ceph_fscache_invalidate(inode, false);
> > -	ret = invalidate_inode_pages2_range(inode->i_mapping,
> > -					    pos >> PAGE_SHIFT,
> > -					    (pos + count - 1) >> PAGE_SHIFT);
> > -	if (ret < 0)
> > -		dout("invalidate_inode_pages2_range returned %d\n", ret);
> >   
> >   	while ((len = iov_iter_count(from)) > 0) {
> >   		size_t left;
> > @@ -1938,6 +1933,20 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> >   			break;
> >   		}
> >   		ceph_clear_error_write(ci);
> > +
> > +		/*
> > +		 * we need to invalidate the page cache here, otherwise the
> > +		 * cache will include invalid data in direct/sync writes.
> > +		 */
> > +		ret = invalidate_inode_pages2_range(
> > +				inode->i_mapping,
> > +				pos >> PAGE_SHIFT,
> > +				(pos + len - 1) >> PAGE_SHIFT);
> > +		if (ret < 0) {
> > +			dout("invalidate_inode_pages2_range returned %d\n",
> > +			     ret);
> > +			ret = 0;
> 
> For this, IMO it's not safe. If we just ignore it the pagecache will 
> still have invalid data.
> 

That data is not invalid. It's dirty data from a buffered write that
raced with the DIO/sync write we're handling here. i.e. another write
came in while we were already processing the DIO write, but after the
point where we called filemap_write_and_wait.

When two write() calls to the same data are racing like that, the
outcome is undefined. We can't be certain which one will prevail as the
kernel could handle them in either order.

The good news with Ceph/RADOS is that you shouldn't end up with a torn
write, unless the write happens to span multiple objects. Not much we
can do about that though.

> I think what the 'ceph_direct_read_write()' does is more correct, it 
> will make sure all the dirty pages are writeback from the pagecaches by 
> using 'invalidate_inode_pages2_range()' without blocking and later will 
> do the invalidate blocked by using 'truncate_inode_pages_range()' if 
> some pages are not unmaped in 'invalidate_inode_pages2_range()' when EBUSY.
> 

I'm not convinced this is any better, and it's attempting to impose a
deterministic outcome on a situation that is non-deterministic by
nature.

> This can always be sure that the pagecache has no invalid data after 
> write finishes. I think why it use the truncate helper here is because 
> it's safe and there shouldn't have any buffer write happen for DIO ?
> 
> But from my understanding the 'ceph_direct_read_write()' is still buggy. 
> What if the page fault happen just after 'truncate_inode_pages_range()' 
> ? Will this happen ? Should we leave this to use the file lock to 
> guarantee it in user space ?
> 
> Thought ?

Again, we can't really predict what the outcome of two racing writes to
the same area will do, so I don't see that there is a problem.

-- 
Jeff Layton <jlayton@kernel.org>
