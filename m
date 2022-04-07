Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A24F8A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiDGUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiDGUgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09E33B014;
        Thu,  7 Apr 2022 13:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D4FB82919;
        Thu,  7 Apr 2022 20:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9CAC385A0;
        Thu,  7 Apr 2022 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362904;
        bh=aAhrXQxBRj4WNugGHY+9GVMQX5hwFeJidtueUCnQTWY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S21Jjxx4Id4duGdsHAGpiBp6xSthobM0Z655f8ZcV8TV+g4EbBjXUanFbjlQXIAJE
         ZRMq34Gjr7sHaSC0gZoN05RjbNTVs3NdWSxFgZAFHYzvRGhaL2e7Vg22YUvcjQwpEB
         1gUkxUXgDmWR+0+RAYiBowrsKvztQCJW8THXnQm5oVJKXO2CYd6dXSfdjkgbrpasXc
         rThRWF0jDfVzdvZHwLpAepiiEnggjv7TxDPgL2R9c0yxAnRPbOXDTpumXH1oFZ6//I
         tqznmo6A3za+asTGahH988ut4Ow8NhbZPrRAZhIuRG5H3G8ha1VfGQOGv64LVw+C/o
         1CYiPa1Gk/hiQ==
Message-ID: <c211631e19e8ed9c57cdb65a540ca3a38180016a.camel@kernel.org>
Subject: Re: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 16:21:42 -0400
In-Reply-To: <822cca41-f700-3cba-e2c8-d1fbe5a934b1@redhat.com>
References: <20220407151521.7968-1-lhenriques@suse.de>
         <385d353d-56d8-8f2a-b468-2aae048f59ef@redhat.com>
         <66740f5e59d52b600d5033a07b794b78dfaf3c18.camel@kernel.org>
         <822cca41-f700-3cba-e2c8-d1fbe5a934b1@redhat.com>
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

On Fri, 2022-04-08 at 03:24 +0800, Xiubo Li wrote:
> On 4/8/22 3:16 AM, Jeff Layton wrote:
> > On Fri, 2022-04-08 at 03:03 +0800, Xiubo Li wrote:
> > > On 4/7/22 11:15 PM, Luís Henriques wrote:
> > > > When doing a direct/sync write, we need to invalidate the page cache in
> > > > the range being written to.  If we don't do this, the cache will include
> > > > invalid data as we just did a write that avoided the page cache.
> > > > 
> > > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > > ---
> > > >    fs/ceph/file.c | 19 ++++++++++++++-----
> > > >    1 file changed, 14 insertions(+), 5 deletions(-)
> > > > 
> > > > Changes since v3:
> > > > - Dropped initial call to invalidate_inode_pages2_range()
> > > > - Added extra comment to document invalidation
> > > > 
> > > > Changes since v2:
> > > > - Invalidation needs to be done after a write
> > > > 
> > > > Changes since v1:
> > > > - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> > > > - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
> > > > 
> > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > index 5072570c2203..97f764b2fbdd 100644
> > > > --- a/fs/ceph/file.c
> > > > +++ b/fs/ceph/file.c
> > > > @@ -1606,11 +1606,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > > >    		return ret;
> > > >    
> > > >    	ceph_fscache_invalidate(inode, false);
> > > > -	ret = invalidate_inode_pages2_range(inode->i_mapping,
> > > > -					    pos >> PAGE_SHIFT,
> > > > -					    (pos + count - 1) >> PAGE_SHIFT);
> > > > -	if (ret < 0)
> > > > -		dout("invalidate_inode_pages2_range returned %d\n", ret);
> > > >    
> > > >    	while ((len = iov_iter_count(from)) > 0) {
> > > >    		size_t left;
> > > > @@ -1938,6 +1933,20 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > > >    			break;
> > > >    		}
> > > >    		ceph_clear_error_write(ci);
> > > > +
> > > > +		/*
> > > > +		 * we need to invalidate the page cache here, otherwise the
> > > > +		 * cache will include invalid data in direct/sync writes.
> > > > +		 */
> > > > +		ret = invalidate_inode_pages2_range(
> > > IMO we'd better use truncate_inode_pages_range() after write. The above
> > > means it's possibly will write the dirty pagecache back, which will
> > > overwrite and corrupt the disk data just wrote.
> > > 
> > I disagree. We call filemap_write_and_wait_range at the start of this,
> > so any data that was dirty when we called write() will be written back
> > before the sync write.
> > 
> > If we truncate the range, then we'll potentially lose writes that came
> > in after write was issued but before truncate_inode_pages_range. I think
> > we'd rather let what we just wrote be clobbered in this situation than
> > lose a write altogether.
> > 
> > All of this is somewhat academic though. If you're mixing buffered and
> > direct writes like this without some sort of locking, then you're just
> > asking for trouble. The aim here is "sane behavior to the best of our
> > ability", but we can't expect it to always be sane when people do insane
> > things. ;)
> 
> Just in the case Luis hit. Before writing the new data the mapping 
> happen when reading the src in copy_from_usr(). So once the writing done 
> the pagecache is caching the stale contents.
> 

Not just in that case.

You could have 2 unrelated processes, one doing DIO writes and one doing
mmap writes. You're likely to end up with a mess unless you're very
careful with what you're doing, but there should be some expectation
that it will work if you serialize things correctly and/or have them
writing to their own areas of the file, etc.

In any case, we'll never get perfect cache coherency, and I figure that
until the write returns, what's in the pagecache ought to be considered
valid.

> > > Though it seems impossible that these pagecaches will be marked dirty,
> > > but this call is misleading ?
> > > 
> > Not impossible at all. You can open a file O_DIRECT and then mmap the fd
> > for PROT_WRITE (or just open the file a second time and do it).
> > 
> > We definitely recommend against mixing buffered and direct I/O, but
> > nothing really prevents someone from doing it. If the user is properly
> > using file locking, then there's really no reason it shouldn't work.
> > 
> > > > +				inode->i_mapping,
> > > > +				pos >> PAGE_SHIFT,
> > > > +				(pos + len - 1) >> PAGE_SHIFT);
> > > > +		if (ret < 0) {
> > > > +			dout("invalidate_inode_pages2_range returned %d\n",
> > > > +			     ret);
> > > > +			ret = 0;
> > > > +		}
> > > >    		pos += len;
> > > >    		written += len;
> > > >    		dout("sync_write written %d\n", written);
> > > > 
> 

-- 
Jeff Layton <jlayton@kernel.org>
