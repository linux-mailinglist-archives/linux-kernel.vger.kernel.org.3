Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07504C1CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbiBWUAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBWUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:00:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8412AC3;
        Wed, 23 Feb 2022 11:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4zIYZUfnCUJ42jAF/bPLTGZTUb50qciw4hI/4NRH8l4=; b=ReKMO7izG6nJBLOQR3BluNmlNF
        gmxqRneHzVlRPGdeJUglpxb7HeyZoWJ85fK5tjoTGIM02iwuF0zkmtsMUxYQ4pVYLFk/WGTJ6teHT
        V42q/naus0jOAtMgY8uVz9GMNFC9YhY6MLeeZ5Dla2NtaFKvdRtC2anUfYQpAt/OyR7ps4UlAUGML
        hIHKP+wqYLc0hm55fGdGSEuRNPg4L7qjVBjgzESu69ty7bavR1pK+WqtMvwNMwa1gIEuQ9nSjN9Uq
        aSw+ql30A1ib36cXxGci0RWX7JYY1VFUfr7gAEtm1Ken5ecxQJ+hxZv6jEJHCIAXPE0pI/R8UfqvR
        vH4bC0hA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMxnX-0045Nw-HR; Wed, 23 Feb 2022 19:59:39 +0000
Date:   Wed, 23 Feb 2022 19:59:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <YhaSK5C9rGVD+7OQ@casper.infradead.org>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
 <YhOaJ4cZU/1MiNI2@casper.infradead.org>
 <20220221205529.GH59715@dread.disaster.area>
 <YhP/vPUcm4lUHzrg@casper.infradead.org>
 <20220221214355.GI59715@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221214355.GI59715@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:43:55AM +1100, Dave Chinner wrote:
> On Mon, Feb 21, 2022 at 09:10:20PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 22, 2022 at 07:55:29AM +1100, Dave Chinner wrote:
> > > On Mon, Feb 21, 2022 at 01:56:55PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Feb 21, 2022 at 04:02:18PM +0800, kernel test robot wrote:
> > > > > commit: a0b99df1aa37d714eb80be5fb54efd56c88a3336 ("mm/readahead: Add large folio readahead")
> > > > 
> > > > > xfs/420	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/420.out.bad)
> > > > >     --- tests/xfs/420.out	2022-02-17 11:55:00.000000000 +0000
> > > > >     +++ /lkp/benchmarks/xfstests/results//xfs/420.out.bad	2022-02-20 20:34:22.430378506 +0000
> > > > >     @@ -13,9 +13,7 @@
> > > > >      Seek holes and data in file2
> > > > >      Whence	Result
> > > > >      DATA	0
> > > > >     -HOLE	131072
> > > > >     -DATA	196608
> > > > >     -HOLE	262144
> > > > >     +HOLE	524288
> > > > 
> > > > Confirm this test now fails.  I don't think it's actually a bug,
> > > > though.  I think the test is now using larger pages to cache the
> > > > file, and it fails to report that there's a hole in the file.
> > > > Maybe there actually isn't a hole in the file any more; using
> > > > larger pages to cache the file means we'll now write more data
> > > > than we used to.
> > > > 
> > > > Adding XFS people for their thoughts.
> > > > 
> > > > Complete output:
> > > > 
> > > > $ diff -u ../ktest/tests/xfstests/tests/xfs/420.out ktest-out/xfstests/xfs/420.out.bad
> > > > --- ../ktest/tests/xfstests/tests/xfs/420.out	2021-07-05 15:49:45.539887305 -0400
> > > > +++ ktest-out/xfstests/xfs/420.out.bad	2022-02-21 08:14:40.000000000 -0500
> > > > @@ -13,9 +13,7 @@
> > > >  Seek holes and data in file2
> > > >  Whence	Result
> > > >  DATA	0
> > > > -HOLE	131072
> > > > -DATA	196608
> > > > -HOLE	262144
> > > > +HOLE	524288
> > > >  Compare files
> > > >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> > > >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > > > @@ -28,9 +26,7 @@
> > > >  Seek holes and data in file2
> > > >  Whence	Result
> > > >  DATA	0
> > > > -HOLE	131072
> > > > -DATA	196608
> > > > -HOLE	262144
> > > > +HOLE	524288
> > > >  Compare files
> > > >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> > > >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > > > 
> > > > So the file checksums are right, which means I didn't break the COW
> > > > functionality.  But we're no longer reporting a hole at 128k.
> > > 
> > > Can you post the contents of the 420.full output file so we can see
> > > what the output of the various commands that are run are? e.g.
> > > things like cowextsize that is configured, etc?
> > 
> > Sure!  It's short, so I've included it inline.
> 
> Ok, I'll cut this up so it makes sense...
> 
> > 
> > 
> > meta-data=/dev/sdc               isize=512    agcount=4, agsize=3670016 blks
> >          =                       sectsz=512   attr=2, projid32bit=1
> >          =                       crc=1        finobt=1, sparse=1, rmapbt=1
> >          =                       reflink=1    bigtime=0
> > data     =                       bsize=1024   blocks=14680064, imaxpct=25
> >          =                       sunit=0      swidth=0 blks
> > naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> > log      =internal log           bsize=1024   blocks=10240, version=2
> >          =                       sectsz=512   sunit=0 blks, lazy-count=1
> > realtime =none                   extsz=4096   blocks=0, rtextents=0
> > Discarding blocks...Done.
> > [0] /mnt/scratch/test-420
> > [524288] /mnt/scratch/test-420
> > wrote 131072/131072 bytes at offset 0
> > 128 KiB, 128 ops; 0.0000 sec (1.327 GiB/sec and 1391304.3478 ops/sec)
> > wrote 524288/524288 bytes at offset 0
> > 512 KiB, 512 ops; 0.0003 sec (1.341 GiB/sec and 1406593.4066 ops/sec)
> > wrote 131072/131072 bytes at offset 0
> > 128 KiB, 128 ops; 0.0000 sec (1.822 GiB/sec and 1910447.7612 ops/sec)
> > CoW the shared part then write into the empty part
> > [524288] /mnt/scratch/test-420/file1
> > [524288] /mnt/scratch/test-420/file2
> > wrote 65536/65536 bytes at offset 0
> > 64 KiB, 64 ops; 0.0001 sec (416.667 MiB/sec and 426666.6667 ops/sec)
> > wrote 65536/65536 bytes at offset 196608
> > 64 KiB, 64 ops; 0.0000 sec (1.695 GiB/sec and 1777777.7778 ops/sec)
> > wrote 65536/65536 bytes at offset 0
> > 64 KiB, 64 ops; 0.0000 sec (1.387 GiB/sec and 1454545.4545 ops/sec)
> > wrote 65536/65536 bytes at offset 196608
> > 64 KiB, 64 ops; 0.0000 sec (1.526 GiB/sec and 1600000.0000 ops/sec)
> > xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
> > /mnt/scratch/test-420/file1:
> >  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
> >    0: [0..255]:        128..383          0 (128..383)         256 100000
> >    1: [256..1023]:     hole                                   768
> > xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
> > /mnt/scratch/test-420/file2:
> >  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
> >    0: [0..255]:        128..383          0 (128..383)         256 100000
> >    1: [256..1023]:     hole                                   768
> 
> So this is the extent list for file2 after the reflink. Note the
> hole at 128-512kB. The flags tell us the 128kB data extent is
> shared. There are no unwritten extents at all.

My debugging indicates otherwise:

+++ b/fs/iomap/seek.c
@@ -15,6 +15,7 @@ static loff_t iomap_seek_hole_iter(const struct iomap_iter *it
er,
 {
        loff_t length = iomap_length(iter);

+printk("%s %ld %d:%lld,%lld\n", __func__, iter->inode->i_ino, iter->iomap.type, iter->iomap.length);
        switch (iter->iomap.type) {
        case IOMAP_UNWRITTEN:
                *hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
@@ -61,6 +62,7 @@ static loff_t iomap_seek_data_iter(const struct iomap_iter *iter,
 {
        loff_t length = iomap_length(iter);

+printk("%s %ld %d:%lld,%lld\n", __func__, iter->inode->i_ino, iter->iomap.type, iter->iomap.length);
        switch (iter->iomap.type) {
        case IOMAP_HOLE:
                return length;

gives me output:

00016 iomap_seek_hole_iter 68 2:131072,-131387284454392
00016 iomap_seek_hole_iter 68 0:393216,-131387284454392
00016 iomap_seek_data_iter 68 2:131072,-131387284454392
00016 iomap_seek_hole_iter 68 2:131072,-131387284454392
00016 iomap_seek_hole_iter 68 0:393216,-131387284454392
00016 iomap_seek_data_iter 68 0:393216,-131387284454392
00016 iomap_seek_hole_iter 69 2:131072,-131387284455352
00016 iomap_seek_hole_iter 69 3:393216,4503599627239424
00016 iomap_seek_data_iter 69 2:131072,-131387284455352
00016 iomap_seek_hole_iter 69 2:131072,-131387284455352
00016 iomap_seek_hole_iter 69 3:393216,4503599627239424

This is after the first call to drop_caches, so in userspace, we're
doing:
echo 1 > /proc/sys/vm/drop_caches

echo "CoW the shared part then write into the empty part" | tee -a $seqres.full
$XFS_IO_PROG -c "cowextsize" $testdir/file1 >> $seqres.full
grep 'order=[^0]' /sys/kernel/debug/tracing/trace
$XFS_IO_PROG -c "cowextsize" $testdir/file2 >> $seqres.full
grep 'order=[^0]' /sys/kernel/debug/tracing/trace
$XFS_IO_PROG -c "pwrite -S 0x63 0 $blksz" $testdir/file2 >> $seqres.full
grep 'order=[^0]' /sys/kernel/debug/tracing/trace
$XFS_IO_PROG -c "pwrite -S 0x63 $((blksz * 3)) $blksz" $testdir/file2 >> $seqres.full
grep 'order=[^0]' /sys/kernel/debug/tracing/trace

The calls to grep were added by me, and should show any order>0 pages
added to the page cache.  There are none, which seems like it would
exonerate large folios.  Of course, it must be this commit, so there
must be large pages.

Debugging continues ...
