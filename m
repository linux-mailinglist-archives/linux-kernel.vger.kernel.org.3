Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB394BEC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiBUVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:10:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBUVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:10:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DA23BE3;
        Mon, 21 Feb 2022 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3XWrSp9MPCbflQktKB/AZEZ+JYryAdnP57dBs2epTtQ=; b=C/A/SoowGurTWQTGVQNwenTa+F
        peiErWpc5iU56C9qttVFmOqcOuWg6kJkZoYhmj9aAhh8OIyv2Y3NylnScxwdIRvRGub1mJVdBe5BO
        Jm8tBH3FpZOcCc60sytOA5uQdwVuHhwKl1Denw4LRzQ4f8LAFm3tyMm7/IXyN5/5eym1pYk+LgLD0
        VnOXeLenlH3tng/W9++ql5YGabUDamfHWDDnYKzor+7xQJsyJHuRuAyQjPENemydczPyt3BDOvCPC
        331v01RRAQr+8GWjWVbovy4JEo1aM6IuJdZNpbFFX0OLPmVKdhFo0MmNPC6UbmoywqSrXHRbadtJQ
        ONeT7FUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMFwq-002Aen-3g; Mon, 21 Feb 2022 21:10:20 +0000
Date:   Mon, 21 Feb 2022 21:10:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <YhP/vPUcm4lUHzrg@casper.infradead.org>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
 <YhOaJ4cZU/1MiNI2@casper.infradead.org>
 <20220221205529.GH59715@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221205529.GH59715@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:55:29AM +1100, Dave Chinner wrote:
> On Mon, Feb 21, 2022 at 01:56:55PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 21, 2022 at 04:02:18PM +0800, kernel test robot wrote:
> > > commit: a0b99df1aa37d714eb80be5fb54efd56c88a3336 ("mm/readahead: Add large folio readahead")
> > 
> > > xfs/420	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/420.out.bad)
> > >     --- tests/xfs/420.out	2022-02-17 11:55:00.000000000 +0000
> > >     +++ /lkp/benchmarks/xfstests/results//xfs/420.out.bad	2022-02-20 20:34:22.430378506 +0000
> > >     @@ -13,9 +13,7 @@
> > >      Seek holes and data in file2
> > >      Whence	Result
> > >      DATA	0
> > >     -HOLE	131072
> > >     -DATA	196608
> > >     -HOLE	262144
> > >     +HOLE	524288
> > 
> > Confirm this test now fails.  I don't think it's actually a bug,
> > though.  I think the test is now using larger pages to cache the
> > file, and it fails to report that there's a hole in the file.
> > Maybe there actually isn't a hole in the file any more; using
> > larger pages to cache the file means we'll now write more data
> > than we used to.
> > 
> > Adding XFS people for their thoughts.
> > 
> > Complete output:
> > 
> > $ diff -u ../ktest/tests/xfstests/tests/xfs/420.out ktest-out/xfstests/xfs/420.out.bad
> > --- ../ktest/tests/xfstests/tests/xfs/420.out	2021-07-05 15:49:45.539887305 -0400
> > +++ ktest-out/xfstests/xfs/420.out.bad	2022-02-21 08:14:40.000000000 -0500
> > @@ -13,9 +13,7 @@
> >  Seek holes and data in file2
> >  Whence	Result
> >  DATA	0
> > -HOLE	131072
> > -DATA	196608
> > -HOLE	262144
> > +HOLE	524288
> >  Compare files
> >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > @@ -28,9 +26,7 @@
> >  Seek holes and data in file2
> >  Whence	Result
> >  DATA	0
> > -HOLE	131072
> > -DATA	196608
> > -HOLE	262144
> > +HOLE	524288
> >  Compare files
> >  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
> >  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> > 
> > So the file checksums are right, which means I didn't break the COW
> > functionality.  But we're no longer reporting a hole at 128k.
> 
> Can you post the contents of the 420.full output file so we can see
> what the output of the various commands that are run are? e.g.
> things like cowextsize that is configured, etc?

Sure!  It's short, so I've included it inline.


meta-data=/dev/sdc               isize=512    agcount=4, agsize=3670016 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=0
data     =                       bsize=1024   blocks=14680064, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=1024   blocks=10240, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
[0] /mnt/scratch/test-420
[524288] /mnt/scratch/test-420
wrote 131072/131072 bytes at offset 0
128 KiB, 128 ops; 0.0000 sec (1.327 GiB/sec and 1391304.3478 ops/sec)
wrote 524288/524288 bytes at offset 0
512 KiB, 512 ops; 0.0003 sec (1.341 GiB/sec and 1406593.4066 ops/sec)
wrote 131072/131072 bytes at offset 0
128 KiB, 128 ops; 0.0000 sec (1.822 GiB/sec and 1910447.7612 ops/sec)
CoW the shared part then write into the empty part
[524288] /mnt/scratch/test-420/file1
[524288] /mnt/scratch/test-420/file2
wrote 65536/65536 bytes at offset 0
64 KiB, 64 ops; 0.0001 sec (416.667 MiB/sec and 426666.6667 ops/sec)
wrote 65536/65536 bytes at offset 196608
64 KiB, 64 ops; 0.0000 sec (1.695 GiB/sec and 1777777.7778 ops/sec)
wrote 65536/65536 bytes at offset 0
64 KiB, 64 ops; 0.0000 sec (1.387 GiB/sec and 1454545.4545 ops/sec)
wrote 65536/65536 bytes at offset 196608
64 KiB, 64 ops; 0.0000 sec (1.526 GiB/sec and 1600000.0000 ops/sec)
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
/mnt/scratch/test-420/file1:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..255]:        128..383          0 (128..383)         256 100000
   1: [256..1023]:     hole                                   768
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
/mnt/scratch/test-420/file2:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..255]:        128..383          0 (128..383)         256 100000
   1: [256..1023]:     hole                                   768
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file3"]: Invalid argument
/mnt/scratch/test-420/file3:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..1023]:       512..1535         0 (512..1535)       1024
sync filesystem
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
/mnt/scratch/test-420/file1:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..127]:        128..255          0 (128..255)         128
   1: [128..255]:      256..383          0 (256..383)         128 100000
   2: [256..1023]:     hole                                   768
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
/mnt/scratch/test-420/file2:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..127]:        1536..1663        0 (1536..1663)       128
   1: [128..255]:      256..383          0 (256..383)         128 100000
   2: [256..383]:      hole                                   128
   3: [384..511]:      1920..2047        0 (1920..2047)       128
   4: [512..1023]:     hole                                   512
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file3"]: Invalid argument
/mnt/scratch/test-420/file3:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..1023]:       512..1535         0 (512..1535)       1024
Remount
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file1"]: Invalid argument
/mnt/scratch/test-420/file1:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..127]:        128..255          0 (128..255)         128
   1: [128..255]:      256..383          0 (256..383)         128 100000
   2: [256..1023]:     hole                                   768
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file2"]: Invalid argument
/mnt/scratch/test-420/file2:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..127]:        1536..1663        0 (1536..1663)       128
   1: [128..255]:      256..383          0 (256..383)         128 100000
   2: [256..383]:      hole                                   128
   3: [384..511]:      1920..2047        0 (1920..2047)       128
   4: [512..1023]:     hole                                   512
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["/mnt/scratch/test-420/file3"]: Invalid argument
/mnt/scratch/test-420/file3:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
   0: [0..1023]:       512..1535         0 (512..1535)       1024
