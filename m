Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF554E5E28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiCXFdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbiCXFdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990D939D3;
        Wed, 23 Mar 2022 22:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBFF60B9F;
        Thu, 24 Mar 2022 05:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADCC340ED;
        Thu, 24 Mar 2022 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648099908;
        bh=os3bm1B2+FNVW3MQRQJTczNi5tPtYTNSYb1u5n5+Apw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hH8hJWP0lJsoooAnsNX6zSq+ru8/kCxQ3oPMdMR+x0uCk72onSADEaP3uTuMklLKk
         87aVKBPtJ6o62+R73lvWg+JluUygONSnk5/tTAguXpF+d35PiASgWRuM0XwJlhVs6s
         SmA5N4hpRq5Mk9g13ZGU/izk6bAMDM39WT6E+smdOI+9/wTI1JxPtGn8y4Cq+dH+jM
         n2boLHvF3DHaItvXLr8OdYfjRdetVC727I8utvSlWUctlnLMf/wxDVTLDVCRrzS7/V
         c4x0YYwwmSKaxjwEaa4yE2iMVaEa1aiiaOYNeXP60HT7sVZuKRCyDqeFnOi6YJMdCA
         1JDZC5IaizckA==
Date:   Wed, 23 Mar 2022 22:31:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chandan Babu R <chandanrlinux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [xfs]  1fc3f2c3c9: xfstests.xfs.529.fail
Message-ID: <20220324053147.GR8224@magnolia>
References: <20220322135402.GB32582@xsang-OptiPlex-9020>
 <20220322162733.GP8241@magnolia>
 <20220323070834.GB16885@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323070834.GB16885@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add chandan to cc since he wrote the extent count checking patches]

On Wed, Mar 23, 2022 at 03:08:34PM +0800, Oliver Sang wrote:
> hi, Darrick,
> 
> On Tue, Mar 22, 2022 at 09:27:33AM -0700, Darrick J. Wong wrote:
> > On Tue, Mar 22, 2022 at 09:54:02PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 1fc3f2c3c928c88654d4716af5cc4dee07b3a1c4 ("xfs: only free posteof blocks on first close")
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
> > > 
> > > in testcase: xfstests
> > > version: xfstests-x86_64-1de1db8-1_20220217
> > > with following parameters:
> > > 
> > > 	disk: 4HDD
> > > 	fs: xfs
> > > 	test: xfs-group-52
> > > 	ucode: 0x21
> > > 
> > > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > 
> > > 
> > > on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > 
> > Could you export DIFF_LENGTH=0 in the test environment so that we get
> > the full diff here, please?
> 
> the full diff is as below (also attached dmesg, full log, log for 529 in case
> helpful):
> 
> xfs/529 [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/529.out.bad)
>     --- tests/xfs/529.out       2022-02-17 11:55:00.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/529.out.bad       2022-03-23 06:18:39.815036267 +0000
>     @@ -4,21 +4,4 @@
>      Inject reduce_max_iextents error tag
>      Create fragmented file
>      Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Fallocate unwritten extents
>     -Inject reduce_max_iextents error tag
>     -Fallocate fragmented file
>     -Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Directio write
>     -Inject reduce_max_iextents error tag
>     -Create fragmented file via directio writes
>     -Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Extend quota inodes
>     -Consume free space
>     -Create fragmented filesystem
>     -Inject reduce_max_iextents error tag
>     -Inject bmap_alloc_minlen_extent error tag
>     -Extend uquota file
>     -Verify uquota inode's extent count
>     +Extent count overflow check failed: nextents = 15

Hey Chandan, could you take a look at this, please?

--D

> 
> 
> > 
> > --D
> > 


> 2022-03-23 06:18:24 export TEST_DIR=/fs/sdb1
> 2022-03-23 06:18:24 export TEST_DEV=/dev/sdb1
> 2022-03-23 06:18:24 export FSTYP=xfs
> 2022-03-23 06:18:24 export SCRATCH_MNT=/fs/scratch
> 2022-03-23 06:18:24 mkdir /fs/scratch -p
> 2022-03-23 06:18:24 export SCRATCH_DEV=/dev/sdb4
> 2022-03-23 06:18:24 export SCRATCH_LOGDEV=/dev/sdb2
> 2022-03-23 06:18:24 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
> 2022-03-23 06:18:24 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
> DIFF_LENGTH=
> 0
> END
> 2022-03-23 06:18:24 sed "s:^:xfs/:" //lkp/benchmarks/xfstests/tests/xfs-group-52
> 2022-03-23 06:18:24 ./check xfs/520 xfs/522 xfs/523 xfs/524 xfs/525 xfs/526 xfs/527 xfs/529
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 lkp-ivb-d05 5.17.0-rc8-00340-g1fc3f2c3c928 #1 SMP Mon Mar 21 07:17:57 CST 2022
> MKFS_OPTIONS  -- -f /dev/sdb4
> MOUNT_OPTIONS -- /dev/sdb4 /fs/scratch
> 
> xfs/520	 3s
> xfs/522	[not run] need configuration file support in mkfs.xfs
> xfs/523	[not run] need configuration file support in mkfs.xfs
> xfs/524	[not run] need configuration file support in mkfs.xfs
> xfs/525	[not run] need configuration file support in mkfs.xfs
> xfs/526	[not run] need configuration file support in mkfs.xfs
> xfs/527	 2s
> xfs/529	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/529.out.bad)
>     --- tests/xfs/529.out	2022-02-17 11:55:00.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/529.out.bad	2022-03-23 06:18:39.815036267 +0000
>     @@ -4,21 +4,4 @@
>      Inject reduce_max_iextents error tag
>      Create fragmented file
>      Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Fallocate unwritten extents
>     -Inject reduce_max_iextents error tag
>     -Fallocate fragmented file
>     -Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Directio write
>     -Inject reduce_max_iextents error tag
>     -Create fragmented file via directio writes
>     -Verify $testfile's extent count
>     -Disable reduce_max_iextents error tag
>     -* Extend quota inodes
>     -Consume free space
>     -Create fragmented filesystem
>     -Inject reduce_max_iextents error tag
>     -Inject bmap_alloc_minlen_extent error tag
>     -Extend uquota file
>     -Verify uquota inode's extent count
>     +Extent count overflow check failed: nextents = 15
> Ran: xfs/520 xfs/522 xfs/523 xfs/524 xfs/525 xfs/526 xfs/527 xfs/529
> Not run: xfs/522 xfs/523 xfs/524 xfs/525 xfs/526
> Failures: xfs/529
> Failed 1 of 8 tests
> 

> meta-data=/dev/sdb4              isize=512    agcount=4, agsize=32768 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>          =                       reflink=0
> data     =                       bsize=4096   blocks=131072, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=1605, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> wrote 4096/4096 bytes at offset 0
> 4 KiB, 1 ops; 0.0185 sec (216.099 KiB/sec and 54.0249 ops/sec)
> wrote 4096/4096 bytes at offset 8192
> 4 KiB, 1 ops; 0.0157 sec (253.888 KiB/sec and 63.4719 ops/sec)
> wrote 4096/4096 bytes at offset 16384
> 4 KiB, 1 ops; 0.0158 sec (251.620 KiB/sec and 62.9050 ops/sec)
> wrote 4096/4096 bytes at offset 24576
> 4 KiB, 1 ops; 0.0160 sec (248.648 KiB/sec and 62.1620 ops/sec)
> wrote 4096/4096 bytes at offset 32768
> 4 KiB, 1 ops; 0.0160 sec (249.423 KiB/sec and 62.3558 ops/sec)
> wrote 4096/4096 bytes at offset 40960
> 4 KiB, 1 ops; 0.0158 sec (251.604 KiB/sec and 62.9010 ops/sec)
> wrote 4096/4096 bytes at offset 49152
> 4 KiB, 1 ops; 0.0161 sec (247.755 KiB/sec and 61.9387 ops/sec)
> wrote 4096/4096 bytes at offset 57344
> 4 KiB, 1 ops; 0.0159 sec (250.878 KiB/sec and 62.7195 ops/sec)
> pwrite: File too large
> pwrite: File too large
> pwrite: File too large
> pwrite: File too large
> pwrite: File too large
> pwrite: File too large
> pwrite: File too large

> QA output created by 529
> Format and mount fs
> * Delalloc to written extent conversion
> Inject reduce_max_iextents error tag
> Create fragmented file
> Verify $testfile's extent count
> Extent count overflow check failed: nextents = 15

