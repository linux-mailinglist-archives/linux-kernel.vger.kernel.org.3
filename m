Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8D49340E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351506AbiASEhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:37:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52666 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351480AbiASEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:37:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6581DCE1BFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB83C340E3;
        Wed, 19 Jan 2022 04:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642567021;
        bh=AN8aeG3b+CT3HcQdlNb53hM0t8+Jr8CQLDOCleMNy4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxr+24Qpw8TzuvTH+unKn4QDbHYf7w9AXhF8p1OBr31dpgo5Xkehv9aoNUpQu6naU
         +xJUwhWerbo8602lxBw0hLH4IqjEnMqEgxEVOrHhTU+uoW4QJRwjWh+Hq4x6vQQbui
         0GNdrNwx9kQqBvwb9nR6I1K7xO+gerMZ6OvIqpfTlq57ePyGIsh4fGPl8ojiR12857
         Wu8MmvJ2CB1SAHyGqkFsOmKxMRRNi5k57o26Gre1FOxnPikO4hhfUIO1osuLqD1Vpe
         iZ1y/fXTj9kMXTh3rV7uRXujqeEmmyGpUiF5RAgSsUAlbw6+n2F3JDjsZ8i+M42s1k
         7+4mEeJIDjxGA==
Date:   Tue, 18 Jan 2022 20:37:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [djwong-xfs:vectorized-scrub 99/334]
 fs/xfs/scrub/fscounters.c:198 xchk_fscounters_freeze() warn: inconsistent
 returns '&sb->s_umount'.
Message-ID: <20220119043701.GC13563@magnolia>
References: <202201170928.GcIhOWMI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201170928.GcIhOWMI-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:58:29AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
> head:   8427da8e62fbcf9a04e5b2663fe60b97d6911417
> commit: 8dd594d12f08acc6c6fa388b2cae3e270bf8effc [99/334] xfs: stabilize fs summary counters for online fsck
> config: ia64-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170928.GcIhOWMI-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> fs/xfs/scrub/fscounters.c:198 xchk_fscounters_freeze() warn: inconsistent returns '&sb->s_umount'.
> 
> vim +198 fs/xfs/scrub/fscounters.c
> 
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  125  STATIC int
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  126  xchk_fscounters_freeze(
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  127  	struct xfs_scrub	*sc)
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  128  {
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  129  	struct xchk_fscounters	*fsc = sc->buf;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  130  	struct xfs_mount	*mp = sc->mp;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  131  	struct super_block	*sb = mp->m_super;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  132  	int			level;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  133  	int			error = 0;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  134  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  135  	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  136  		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  137  		mnt_drop_write_file(sc->file);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  138  	}
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  139  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  140  	/* Wait until we're ready to freeze or give up. */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  141  	down_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  142  	while (sb->s_writers.frozen != SB_UNFROZEN) {
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  143  		up_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  144  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  145  		if (xchk_should_terminate(sc, &error))
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  146  			return error;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  147  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  148  		delay(HZ / 10);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  149  		down_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  150  	}
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  151  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  152  	if (sb_rdonly(sb)) {
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  153  		sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  154  		goto done;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  155  	}
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  156  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  157  	sb->s_writers.frozen = SB_FREEZE_WRITE;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  158  	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  159  	up_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  160  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  161  	down_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  162  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  163  	/* Now we go and block page faults... */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  164  	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  165  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_PAGEFAULT - 1);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  166  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  167  	/*
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  168  	 * All writers are done so after syncing there won't be dirty data.
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  169  	 * Let xfs_fs_sync_fs flush dirty data so the VFS won't start writeback
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  170  	 * and to disable the background gc workers.
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  171  	 */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  172  	error = sync_filesystem(sb);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  173  	if (error) {
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  174  		sb->s_writers.frozen = SB_UNFROZEN;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  175  		for (level = SB_FREEZE_PAGEFAULT; level >= 0; level--)
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  176  			percpu_up_write(sb->s_writers.rw_sem + level);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  177  		wake_up(&sb->s_writers.wait_unfrozen);
> 
> Smatch wanted an up_write(&sb->s_umount); but this looks intentional?

Nope, that's a bug.  Thanks for catching that!

--D

> 8dd594d12f08acc Darrick J. Wong 2022-01-06  178  		return error;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  179  	}
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  180  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  181  	/* Now wait for internal filesystem counter */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  182  	sb->s_writers.frozen = SB_FREEZE_FS;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  183  	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_FS - 1);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  184  
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  185  	/*
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  186  	 * We do not need to quiesce the log to check the summary counters, so
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  187  	 * skip the call to xfs_fs_freeze here.  To prevent anyone else from
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  188  	 * unfreezing us, set the VFS freeze level to one higher than
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  189  	 * FREEZE_COMPLETE.
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  190  	 */
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  191  	sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  192  	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  193  		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0,
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  194  				_THIS_IP_);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  195  done:
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  196  	fsc->frozen = true;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  197  	up_write(&sb->s_umount);
> 8dd594d12f08acc Darrick J. Wong 2022-01-06 @198  	return 0;
> 8dd594d12f08acc Darrick J. Wong 2022-01-06  199  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
