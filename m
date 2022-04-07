Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBE4F814F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiDGOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDGOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7E125595;
        Thu,  7 Apr 2022 07:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087D161BC5;
        Thu,  7 Apr 2022 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC2AC385A4;
        Thu,  7 Apr 2022 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649340523;
        bh=ydP1aVikhmIIcEnQD6MgKsKQRpvuR4lwhWVulh03A8E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jCzTejPJMfBHgKkfDyk1keI3z09aoSF3nLyXyo34h5NPI/8O0YWu2YbHN9TI+V6r0
         ByZwJxqnAWRDIN4vJledxnIbSssq/9wqvp7XiPFZy3b5hSfaQ3Yf5Xyx7n83/OQu85
         wa/GCU7NDItOyjRArlV/+mLTnl6ekf4oirBS+d8wh3EH+gdbS0YAS8/T9atJJLwYcU
         pD7EQka9IyHP0WPXvBIXJIy+p4oljawq6K2lFNLsTZI00FL9WlHH6zg5dw63zxlhFE
         PGRaOt9aMVgmccMOz2+SB9hUanTqyqNyl4ybIyJ1DsE6D6XS4y6qnS6HBpQ+fvVlY7
         rzUvHjsjT2FDA==
Message-ID: <5dc7945ab39aea9aae9834d3f5623ecbf251c262.camel@kernel.org>
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 10:08:41 -0400
In-Reply-To: <aaa78c1f1bfa7b8da8d8be0f3dcf2a42c9b838fd.camel@kernel.org>
References: <20220401133243.1075-1-lhenriques@suse.de>
         <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
         <878rsia391.fsf@brahms.olymp>
         <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com>
         <87zgky8n0o.fsf@brahms.olymp>
         <6306fba71325483a1ea22fa73250c8777ea647d7.camel@kernel.org>
         <321104e6-36db-c143-a7ba-58f9199e6fb7@redhat.com>
         <f0ed169ed02fe810076e959e9ec5455d9de4b4ff.camel@kernel.org>
         <7023b537-e7b6-0dd9-42bf-9d601ef69b58@redhat.com>
         <87pmlt85w5.fsf@brahms.olymp>
         <aaa78c1f1bfa7b8da8d8be0f3dcf2a42c9b838fd.camel@kernel.org>
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

On Thu, 2022-04-07 at 09:23 -0400, Jeff Layton wrote:
> On Thu, 2022-04-07 at 12:55 +0100, Luís Henriques wrote:
> > Xiubo Li <xiubli@redhat.com> writes:
> > 
> > > On 4/6/22 9:41 PM, Jeff Layton wrote:
> > > > On Wed, 2022-04-06 at 21:10 +0800, Xiubo Li wrote:
> > > > > On 4/6/22 7:48 PM, Jeff Layton wrote:
> > > > > > On Wed, 2022-04-06 at 12:33 +0100, Luís Henriques wrote:
> > > > > > > Xiubo Li <xiubli@redhat.com> writes:
> > > > > > > 
> > > > > > > > On 4/6/22 6:57 PM, Luís Henriques wrote:
> > > > > > > > > Xiubo Li <xiubli@redhat.com> writes:
> > > > > > > > > 
> > > > > > > > > > On 4/1/22 9:32 PM, Luís Henriques wrote:
> > > > > > > > > > > When doing DIO on an encrypted node, we need to invalidate the page cache in
> > > > > > > > > > > the range being written to, otherwise the cache will include invalid data.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > > > > > > > > > ---
> > > > > > > > > > >      fs/ceph/file.c | 11 ++++++++++-
> > > > > > > > > > >      1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > > > > > > 
> > > > > > > > > > > Changes since v1:
> > > > > > > > > > > - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> > > > > > > > > > > - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
> > > > > > > > > > > 
> > > > > > > > > > > Note: I'm not really sure this last change is required, it doesn't really
> > > > > > > > > > > affect generic/647 result, but seems to be the most correct.
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > > > > > > > index 5072570c2203..b2743c342305 100644
> > > > > > > > > > > --- a/fs/ceph/file.c
> > > > > > > > > > > +++ b/fs/ceph/file.c
> > > > > > > > > > > @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > > > > > > > > > >      	if (ret < 0)
> > > > > > > > > > >      		return ret;
> > > > > > > > > > >      -	ceph_fscache_invalidate(inode, false);
> > > > > > > > > > > +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
> > > > > > > > > > >      	ret = invalidate_inode_pages2_range(inode->i_mapping,
> > > > > > > > > > >      					    pos >> PAGE_SHIFT,
> > > > > > > > > > >      					    (pos + count - 1) >> PAGE_SHIFT);
> > > > > > > > > > The above has already invalidated the pages, why doesn't it work ?
> > > > > > > > > I suspect the reason is because later on we loop through the number of
> > > > > > > > > pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().
> > > > > > > > Checked the 'copy_page_from_iter()', it will do the kmap for the pages but will
> > > > > > > > kunmap them again later. And they shouldn't update the i_mapping if I didn't
> > > > > > > > miss something important.
> > > > > > > > 
> > > > > > > > For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context inplace,
> > > > > > > > IMO if it needs to map the page and it should also unmap it just like in
> > > > > > > > 'copy_page_from_iter()'.
> > > > > > > > 
> > > > > > > > I thought it possibly be when we need to do RMW, it may will update the
> > > > > > > > i_mapping when reading contents, but I checked the code didn't find any
> > > > > > > > place is doing this. So I am wondering where tha page caches come from ? If that
> > > > > > > > page caches really from reading the contents, then we should discard it instead
> > > > > > > > of flushing it back ?
> > > > > > > > 
> > > > > > > > BTW, what's the problem without this fixing ? xfstest fails ?
> > > > > > > Yes, generic/647 fails if you run it with test_dummy_encryption.  And I've
> > > > > > > also checked that the RMW code was never executed in this test.
> > > > > > > 
> > > > > > > But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
> > > > > > > change the inode->i_mapping.
> > > > > > > 
> > > > > > No, kmap/unmap are all about high memory and 32-bit architectures. Those
> > > > > > functions are usually no-ops on 64-bit arches.
> > > > > Yeah, right.
> > > > > 
> > > > > So they do nothing here.
> > > > > 
> > > > > > > In my debugging this seemed to be the case
> > > > > > > for the O_DIRECT path.  That's why I added this extra call here.
> > > > > > > 
> > > > > > I agree with Xiubo that we really shouldn't need to invalidate multiple
> > > > > > times.
> > > > > > 
> > > > > > I guess in this test, we have a DIO write racing with an mmap read
> > > > > > Probably what's happening is either that we can't invalidate the page
> > > > > > because it needs to be cleaned, or the mmap read is racing in just after
> > > > > > the invalidate occurs but before writeback.
> > > > > This sounds a possible case.
> > > > > 
> > > > > 
> > > > > > In any case, it might be interesting to see whether you're getting
> > > > > > -EBUSY back from the new invalidate_inode_pages2 calls with your patch.
> > > > > > 
> > > > > If it's really this case maybe this should be retried some where ?
> > > > > 
> > > > Possibly, or we may need to implement ->launder_folio.
> > > > 
> > > > Either way, we need to understand what's happening first and then we can
> > > > figure out a solution for it.
> > > 
> > > Yeah, make sense.
> > > 
> > 
> > OK, so here's what I got so far:
> > 
> > When we run this test *without* test_dummy_encryption, ceph_direct_read_write()
> > will be called and invalidate_inode_pages2_range() will do pretty much
> > nothing because the mapping will be empty (mapping_empty(inode->i_mapping)
> > will return 1).  If we use encryption, ceph_sync_write() will be called
> > instead and the mapping, obviously, be will be empty as well.
> > 
> > The difference between in encrypted vs non-encrypted (and the reason the
> > test passes without encryption) is that ceph_direct_read_write()
> > (non-encrypted) will call truncate_inode_pages_range() at a stage where
> > the mapping is not empty anymore (iter_get_bvecs_alloc will take care of
> > that).
> > 
> 
> Wait...why does iter_get_bvecs_alloc populate the mapping? The iter in
> this case is almost certainly an iov_iter from userland so none of this
> should have anything to do with the pagecache.
> 
> I suspect the faulting in occurs via the mmap reader task, and that the
> truncate_inode_pages_range calls just happen enough to invalidate it.
> 
> >  In the encryption path (ceph_sync_write) the mapping will be
> > filled with copy_page_from_iter(), which will fault and do the read.
> > Because we don't have the truncate_inode_pages_range(), the cache will
> > contain invalid data after the write.  And that's why the extra
> > invalidate_inode_pages2_range (or truncate_...) fixes this.
> > 
> 
> I think what we may want to do is consider adding these calls into
> ceph_page_mkwrite:
> 
>         if (direct_lock)
>                 ceph_start_io_direct(inode);
>         else
>                 ceph_start_io_write(inode);
> 
> ...and similar ones (for read) in ceph_filemap_fault, along with "end"
> calls to end the I/Os.
> 
> This is how we handle races between buffered read/write and direct I/O,
> and I suspect the mmap codepaths may just need similar treatment.
> 
> Thoughts?

No, Luis tried this and said that it deadlocked on IRC. It seems obvious
in retrospect...

What we probably need to do is call filemap_write_and_wait_range before
issuing a direct or sync read or write. Then for direct/sync writes, we
also want to call invalidate_inode_pages2_range after the write returns.

We might consider doing an invalidation before issuing the call, but I
think it wouldn't help this testcase. generic/647 is doing O_DIRECT
writes to the file from a buffer that is mmapped from the same file. If
you invalidate before the write occurs you'll just end up faulting the
pages right back in.
-- 
Jeff Layton <jlayton@kernel.org>
