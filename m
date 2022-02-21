Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF94BECC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiBUVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiBUVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:44:22 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDEA722BC4;
        Mon, 21 Feb 2022 13:43:57 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F08C710C803E;
        Tue, 22 Feb 2022 08:43:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMGTL-00EpLz-5t; Tue, 22 Feb 2022 08:43:55 +1100
Date:   Tue, 22 Feb 2022 08:43:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <20220221214355.GI59715@dread.disaster.area>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
 <YhOaJ4cZU/1MiNI2@casper.infradead.org>
 <20220221205529.GH59715@dread.disaster.area>
 <YhP/vPUcm4lUHzrg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhP/vPUcm4lUHzrg@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6214079c
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=OBJqqLH7MXPXxCrpcxsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:10:20PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 07:55:29AM +1100, Dave Chinner wrote:
> > On Mon, Feb 21, 2022 at 01:56:55PM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 21, 2022 at 04:02:18PM +0800, kernel test robot wrote:
> > > > commit: a0b99df1aa37d714eb80be5fb54efd56c88a3336 ("mm/readahead: Add large folio readahead")
> > > 
> > > > xfs/420	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/420.out.bad)
> > > >     --- tests/xfs/420.out	2022-02-17 11:55:00.000000000 +0000
> > > >     +++ /lkp/benchmarks/xfstests/results//xfs/420.out.bad	2022-02-20 20:34:22.430378506 +0000
> > > >     @@ -13,9 +13,7 @@
> > > >      Seek holes and data in file2
> > > >      Whence	Result
> > > >      DATA	0
> > > >     -HOLE	131072
> > > >     -DATA	196608
> > > >     -HOLE	262144
> > > >     +HOLE	524288
> > > 
> > > Confirm this test now fails.  I don't think it's actually a bug,
> > > though.  I think the test is now using larger pages to cache the
> > > file, and it fails to report that there's a hole in the file.
> > > Maybe there actually isn't a hole in the file any more; using
> > > larger pages to cache the file means we'll now write more data
> > > than we used to.
> > > 
> > > Adding XFS people for their thoughts.
> > > 
> > > Complete output:
> > > 
> > > $ diff -u ../ktest/tests/xfstests/tests/xfs/420.out ktest-out/xfstests/xfs/420.out.bad
> > > --- ../ktest/tests/xfstests/tests/xfs/420.out	2021-07-05 15:49:45.539887305 -0400
> > > +++ ktest-out/xfstests/xfs/420.out.bad	2022-02-21 08:14:40.000000000 -0500
> > > @@ -13,9 +13,7 @@
> > >  Seek holes and data in file2
> > >  Whence	Result
> > >  DATA	0
> > > -HOLE	131072
> > > -DATA	196608
> > > -HOLE	262144
> > > +HOLE	524288
> > >  Compare files
> > >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> > >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > > @@ -28,9 +26,7 @@
> > >  Seek holes and data in file2
> > >  Whence	Result
> > >  DATA	0
> > > -HOLE	131072
> > > -DATA	196608
> > > -HOLE	262144
> > > +HOLE	524288
> > >  Compare files
> > >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> > >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > > 
> > > So the file checksums are right, which means I didn't break the COW
> > > functionality.  But we're no longer reporting a hole at 128k.
> > 
> > Can you post the contents of the 420.full output file so we can see
> > what the output of the various commands that are run are? e.g.
> > things like cowextsize that is configured, etc?
> 
> Sure!  It's short, so I've included it inline.

Ok, I'll cut this up so it makes sense...

> 
> 
> meta-data=/dev/sdc               isize=512    agcount=4, agsize=3670016 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=1
>          =                       reflink=1    bigtime=0
> data     =                       bsize=1024   blocks=14680064, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=1024   blocks=10240, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> Discarding blocks...Done.
> [0] /mnt/scratch/test-420
> [524288] /mnt/scratch/test-420
> wrote 131072/131072 bytes at offset 0
> 128 KiB, 128 ops; 0.0000 sec (1.327 GiB/sec and 1391304.3478 ops/sec)
> wrote 524288/524288 bytes at offset 0
> 512 KiB, 512 ops; 0.0003 sec (1.341 GiB/sec and 1406593.4066 ops/sec)
> wrote 131072/131072 bytes at offset 0
> 128 KiB, 128 ops; 0.0000 sec (1.822 GiB/sec and 1910447.7612 ops/sec)
> CoW the shared part then write into the empty part
> [524288] /mnt/scratch/test-420/file1
> [524288] /mnt/scratch/test-420/file2
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 64 ops; 0.0001 sec (416.667 MiB/sec and 426666.6667 ops/sec)
> wrote 65536/65536 bytes at offset 196608
> 64 KiB, 64 ops; 0.0000 sec (1.695 GiB/sec and 1777777.7778 ops/sec)
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 64 ops; 0.0000 sec (1.387 GiB/sec and 1454545.4545 ops/sec)
> wrote 65536/65536 bytes at offset 196608
> 64 KiB, 64 ops; 0.0000 sec (1.526 GiB/sec and 1600000.0000 ops/sec)
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
> /mnt/scratch/test-420/file1:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..255]:        128..383          0 (128..383)         256 100000
>    1: [256..1023]:     hole                                   768
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
> /mnt/scratch/test-420/file2:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..255]:        128..383          0 (128..383)         256 100000
>    1: [256..1023]:     hole                                   768

So this is the extent list for file2 after the reflink. Note the
hole at 128-512kB. The flags tell us the 128kB data extent is
shared. There are no unwritten extents at all.

> > >  Seek holes and data in file2
> > >  Whence	Result
> > >  DATA	0
> > > -HOLE	131072
> > > -DATA	196608
> > > -HOLE	262144
> > > +HOLE	524288

indicates the file is completely full of data at this point. Based
on the extent list, and looking at the current
iomap_seek_hole/data() implementation, this looks wrong.

Technically speaking, however, it is valid because holes are allowed
to be reported as data but not vice versa. That said, in this case
there are no unwritten extents so iomap_seek_hole/data should be
reporting the exact on-disk extent mapping and not even be looking
at the page cache contents. The page cache is only only for
unwritten extents, and there are none of them so page cache
footprint should not change this result.

> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file3"]: Invalid argument
> /mnt/scratch/test-420/file3:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..1023]:       512..1535         0 (512..1535)       1024
> sync filesystem
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
> /mnt/scratch/test-420/file1:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        128..255          0 (128..255)         128
>    1: [128..255]:      256..383          0 (256..383)         128 100000
>    2: [256..1023]:     hole                                   768
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
> /mnt/scratch/test-420/file2:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        1536..1663        0 (1536..1663)       128
>    1: [128..255]:      256..383          0 (256..383)         128 100000
>    2: [256..383]:      hole                                   128
>    3: [384..511]:      1920..2047        0 (1920..2047)       128
>    4: [512..1023]:     hole                                   512

And the extent list after we've overwritten the first 64kB and
another 64kB write at 192kB. Note that the 64kB hole at 128kB is
still there.

> > > @@ -13,9 +13,7 @@
> > >  Seek holes and data in file2
> > >  Whence	Result
> > >  DATA	0
> > > -HOLE	131072
> > > -DATA	196608
> > > -HOLE	262144
> > > +HOLE	524288

And this still looks wrong. Again, no unwritten extents, so we
should just be reporting the on-disk extent layout here.

> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file3"]: Invalid argument
> /mnt/scratch/test-420/file3:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..1023]:       512..1535         0 (512..1535)       1024
> Remount
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
> /mnt/scratch/test-420/file1:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        128..255          0 (128..255)         128
>    1: [128..255]:      256..383          0 (256..383)         128 100000
>    2: [256..1023]:     hole                                   768
> xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
> /mnt/scratch/test-420/file2:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        1536..1663        0 (1536..1663)       128
>    1: [128..255]:      256..383          0 (256..383)         128 100000
>    2: [256..383]:      hole                                   128
>    3: [384..511]:      1920..2047        0 (1920..2047)       128
>    4: [512..1023]:     hole                                   512

This is after mount/unmount, where there is now no page cache over
the file. This reports the same layout as bmap does (i.e. matches
the golden output) and is obviously correct.

This smells of a bug in the large folio patchset as the on-disk
extent layouts are correct and unchanged. The question now is what
if the large folio patchset doing to iomap_seek_hole/data that makes
it behave differently to the current code?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
