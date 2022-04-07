Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1378D4F87EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiDGTSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiDGTSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7313F5F;
        Thu,  7 Apr 2022 12:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D2361E24;
        Thu,  7 Apr 2022 19:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5521C385A6;
        Thu,  7 Apr 2022 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649358965;
        bh=f00Btqo5DlYfrezMEow0LHeltiwKLZP1dw5RpNj8PqU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pmV6UORIfcoZ35qmnWfNUmbsgdEf6q+0/d3cbYHdOrPBecDHPOzFSZ++wVLcdeeg7
         4feOXerToNzwVYBQcs9s55GVMo5o8bGJQxOV1Oln/zYbOf0bprZpaod8JR8Q+zwtkH
         pbQ5p3OsnJqVlS5O+t3BO6Mzi1vRSRQMFL+zb98amlDxIbY2zDXfjyXgHavFDxUmgx
         XngXE3QqZkyYv+iSae8+b/JrJublzOcnRWGFsDILbtmVoF7zj1o7PBgJbPwkV3c0RL
         5zIZRJIl90va2X5MhCAdU+UoGldEstst38KJkOtqkJevrgM3pvobbmkVfM6LiAFg1v
         Hws4fdNOKvMfg==
Message-ID: <66740f5e59d52b600d5033a07b794b78dfaf3c18.camel@kernel.org>
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 15:16:03 -0400
In-Reply-To: <385d353d-56d8-8f2a-b468-2aae048f59ef@redhat.com>
References: <20220407151521.7968-1-lhenriques@suse.de>
         <385d353d-56d8-8f2a-b468-2aae048f59ef@redhat.com>
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

On Fri, 2022-04-08 at 03:03 +0800, Xiubo Li wrote:
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
> 
> IMO we'd better use truncate_inode_pages_range() after write. The above 
> means it's possibly will write the dirty pagecache back, which will 
> overwrite and corrupt the disk data just wrote.
> 

I disagree. We call filemap_write_and_wait_range at the start of this,
so any data that was dirty when we called write() will be written back
before the sync write.

If we truncate the range, then we'll potentially lose writes that came
in after write was issued but before truncate_inode_pages_range. I think
we'd rather let what we just wrote be clobbered in this situation than
lose a write altogether.

All of this is somewhat academic though. If you're mixing buffered and
direct writes like this without some sort of locking, then you're just
asking for trouble. The aim here is "sane behavior to the best of our
ability", but we can't expect it to always be sane when people do insane
things. ;)

> Though it seems impossible that these pagecaches will be marked dirty, 
> but this call is misleading ?
> 

Not impossible at all. You can open a file O_DIRECT and then mmap the fd
for PROT_WRITE (or just open the file a second time and do it).

We definitely recommend against mixing buffered and direct I/O, but
nothing really prevents someone from doing it. If the user is properly
using file locking, then there's really no reason it shouldn't work.

> 
> > +				inode->i_mapping,
> > +				pos >> PAGE_SHIFT,
> > +				(pos + len - 1) >> PAGE_SHIFT);
> > +		if (ret < 0) {
> > +			dout("invalidate_inode_pages2_range returned %d\n",
> > +			     ret);
> > +			ret = 0;
> > +		}
> >   		pos += len;
> >   		written += len;
> >   		dout("sync_write written %d\n", written);
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>
