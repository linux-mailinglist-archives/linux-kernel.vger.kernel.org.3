Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7074828B6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 23:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiAAW2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 17:28:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:4762 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbiAAW2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 17:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641076083; x=1672612083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I+16jmq07WfKOd/yVI25PE4J4SHq/mttTv+WtICE5Cw=;
  b=GwNeMm9f3DQjYi6KDzr15nF5wjfbZDM+uEn7CDCcAjEU73ZNKTjzJzs+
   vzxWCExaSfLrb2sEbq+R6JNroKmIdUtGlryvnQpo7+qGC1utbj0au53L7
   WiC0DsKNVC17+f/+ZqRj7ZQI8gA8JytWJ3DHVyOKB4CcLbDvucwj0kkKz
   seRN0Ds7dLaXccrCkwOJggyrj/xEwKZA6QtTz0xsqdWAKItnbXzvpQnTt
   S71+DXjf696r9ESPM0aASvk8CfViPE58lVrBCeB4kmaeMf4p+IGpOIQw3
   iKpjjDDPO/6zPY7erI3oRiSxR7+0r7mI/b6SB83TLgZZgrrWpUlEVD2P/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="240746100"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="240746100"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 14:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="687774444"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jan 2022 14:28:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3mr2-000Cpy-8A; Sat, 01 Jan 2022 22:28:00 +0000
Date:   Sun, 2 Jan 2022 06:26:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>
Subject: fs/xfs/xfs_qm_syscalls.c:633:2: warning: Redundant assignment of
 'dqp' to itself. [selfAssignment]
Message-ID: <202201020427.HGE8ZXWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: 7ac6eb46c9f32d3e6ae37943191cd744ffa1ef33 xfs: fix up build warnings when quotas are disabled
date:   11 months ago
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_qm_syscalls.c:633:2: warning: Redundant assignment of 'dqp' to itself. [selfAssignment]
    xfs_qm_dqrele(dqp);
    ^
   fs/xfs/xfs_qm_syscalls.c:770:3: warning: Redundant assignment of 'ip->i_udquot' to itself. [selfAssignment]
     xfs_qm_dqrele(ip->i_udquot);
     ^
   fs/xfs/xfs_qm_syscalls.c:774:3: warning: Redundant assignment of 'ip->i_gdquot' to itself. [selfAssignment]
     xfs_qm_dqrele(ip->i_gdquot);
     ^
   fs/xfs/xfs_qm_syscalls.c:778:3: warning: Redundant assignment of 'ip->i_pdquot' to itself. [selfAssignment]
     xfs_qm_dqrele(ip->i_pdquot);
     ^

vim +/dqp +633 fs/xfs/xfs_qm_syscalls.c

d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  496  
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  497  /*
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  498   * Adjust quota limits, and start/stop timers accordingly.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  499   */
fcafb71b57a039 fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2009-02-09  500  int
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  501  xfs_qm_scall_setqlim(
b136645116e547 fs/xfs/xfs_qm_syscalls.c       Brian Foster      2013-03-18  502  	struct xfs_mount	*mp,
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  503  	xfs_dqid_t		id,
1a7ed271653a4f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-15  504  	xfs_dqtype_t		type,
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  505  	struct qc_dqblk		*newlim)
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  506  {
8a7b8a89a3ae5b fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-04-20  507  	struct xfs_quotainfo	*q = mp->m_quotainfo;
b136645116e547 fs/xfs/xfs_qm_syscalls.c       Brian Foster      2013-03-18  508  	struct xfs_dquot	*dqp;
b136645116e547 fs/xfs/xfs_qm_syscalls.c       Brian Foster      2013-03-18  509  	struct xfs_trans	*tp;
be6079461abf79 fs/xfs/xfs_qm_syscalls.c       Carlos Maiolino   2016-02-08  510  	struct xfs_def_quota	*defq;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  511  	struct xfs_dquot_res	*res;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  512  	struct xfs_quota_limits	*qlim;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  513  	int			error;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  514  	xfs_qcnt_t		hard, soft;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  515  
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  516  	if (newlim->d_fieldmask & ~XFS_QC_MASK)
2451337dd04390 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2014-06-25  517  		return -EINVAL;
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  518  	if ((newlim->d_fieldmask & XFS_QC_MASK) == 0)
c472b432759765 fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-05-06  519  		return 0;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  520  
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  521  	/*
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  522  	 * We don't want to race with a quotaoff so take the quotaoff lock.
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  523  	 * We don't hold an inode lock, so there's nothing else to stop
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  524  	 * a quotaoff from happening.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  525  	 */
8a7b8a89a3ae5b fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-04-20  526  	mutex_lock(&q->qi_quotaofflock);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  527  
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  528  	/*
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  529  	 * Get the dquot (locked) before we start, as we need to do a
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  530  	 * transaction to allocate it if it doesn't exist. Once we have the
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  531  	 * dquot, unlock it so we can start the next transaction safely. We hold
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  532  	 * a reference to the dquot, so it's safe to do this unlock/lock without
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  533  	 * it being reclaimed in the mean time.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  534  	 */
30ab2dcf2c0693 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2018-05-04  535  	error = xfs_qm_dqget(mp, id, type, true, &dqp);
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  536  	if (error) {
2451337dd04390 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2014-06-25  537  		ASSERT(error != -ENOENT);
8a7b8a89a3ae5b fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-04-20  538  		goto out_unlock;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  539  	}
be6079461abf79 fs/xfs/xfs_qm_syscalls.c       Carlos Maiolino   2016-02-08  540  
ce6e7e79ced35a fs/xfs/xfs_qm_syscalls.c       Eric Sandeen      2020-05-21  541  	defq = xfs_get_defquota(q, xfs_dquot_type(dqp));
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  542  	xfs_dqunlock(dqp);
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  543  
253f4911f297b8 fs/xfs/xfs_qm_syscalls.c       Christoph Hellwig 2016-04-06  544  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_qm_setqlim, 0, 0, 0, &tp);
253f4911f297b8 fs/xfs/xfs_qm_syscalls.c       Christoph Hellwig 2016-04-06  545  	if (error)
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  546  		goto out_rele;
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  547  
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  548  	xfs_dqlock(dqp);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  549  	xfs_trans_dqjoin(tp, dqp);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  550  
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  551  	/*
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  552  	 * Update quota limits, warnings, and timers, and the defaults
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  553  	 * if we're touching id == 0.
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  554  	 *
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  555  	 * Make sure that hardlimits are >= soft limits before changing.
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  556  	 *
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  557  	 * Update warnings counter(s) if requested.
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  558  	 *
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  559  	 * Timelimits for the super user set the relative time the other users
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  560  	 * can be over quota for this file system. If it is zero a default is
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  561  	 * used.  Ditto for the default soft and hard limit values (already
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  562  	 * done, above), and for warnings.
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  563  	 *
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  564  	 * For other IDs, userspace can bump out the grace period if over
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  565  	 * the soft limit.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  566  	 */
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  567  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  568  	/* Blocks on the data device. */
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  569  	hard = (newlim->d_fieldmask & QC_SPC_HARD) ?
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  570  		(xfs_qcnt_t) XFS_B_TO_FSB(mp, newlim->d_spc_hardlimit) :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  571  			dqp->q_blk.hardlimit;
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  572  	soft = (newlim->d_fieldmask & QC_SPC_SOFT) ?
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  573  		(xfs_qcnt_t) XFS_B_TO_FSB(mp, newlim->d_spc_softlimit) :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  574  			dqp->q_blk.softlimit;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  575  	res = &dqp->q_blk;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  576  	qlim = id == 0 ? &defq->blk : NULL;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  577  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  578  	if (xfs_setqlim_limits(mp, res, qlim, hard, soft, "blk"))
b136645116e547 fs/xfs/xfs_qm_syscalls.c       Brian Foster      2013-03-18  579  		xfs_dquot_set_prealloc_limits(dqp);
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  580  	if (newlim->d_fieldmask & QC_SPC_WARNS)
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  581  		xfs_setqlim_warns(res, qlim, newlim->d_spc_warns);
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  582  	if (newlim->d_fieldmask & QC_SPC_TIMER)
11d8a919027585 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-08-17  583  		xfs_setqlim_timer(mp, res, qlim, newlim->d_spc_timer);
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  584  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  585  	/* Blocks on the realtime device. */
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  586  	hard = (newlim->d_fieldmask & QC_RT_SPC_HARD) ?
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  587  		(xfs_qcnt_t) XFS_B_TO_FSB(mp, newlim->d_rt_spc_hardlimit) :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  588  			dqp->q_rtb.hardlimit;
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  589  	soft = (newlim->d_fieldmask & QC_RT_SPC_SOFT) ?
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  590  		(xfs_qcnt_t) XFS_B_TO_FSB(mp, newlim->d_rt_spc_softlimit) :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  591  			dqp->q_rtb.softlimit;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  592  	res = &dqp->q_rtb;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  593  	qlim = id == 0 ? &defq->rtb : NULL;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  594  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  595  	xfs_setqlim_limits(mp, res, qlim, hard, soft, "rtb");
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  596  	if (newlim->d_fieldmask & QC_RT_SPC_WARNS)
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  597  		xfs_setqlim_warns(res, qlim, newlim->d_rt_spc_warns);
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  598  	if (newlim->d_fieldmask & QC_RT_SPC_TIMER)
11d8a919027585 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-08-17  599  		xfs_setqlim_timer(mp, res, qlim, newlim->d_rt_spc_timer);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  600  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  601  	/* Inodes */
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  602  	hard = (newlim->d_fieldmask & QC_INO_HARD) ?
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  603  		(xfs_qcnt_t) newlim->d_ino_hardlimit :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  604  			dqp->q_ino.hardlimit;
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  605  	soft = (newlim->d_fieldmask & QC_INO_SOFT) ?
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  606  		(xfs_qcnt_t) newlim->d_ino_softlimit :
d3537cf93e5e2f fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  607  			dqp->q_ino.softlimit;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  608  	res = &dqp->q_ino;
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  609  	qlim = id == 0 ? &defq->ino : NULL;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  610  
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  611  	xfs_setqlim_limits(mp, res, qlim, hard, soft, "ino");
14bf61ffe6ac54 fs/xfs/xfs_qm_syscalls.c       Jan Kara          2014-10-09  612  	if (newlim->d_fieldmask & QC_INO_WARNS)
d1520deab039ca fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  613  		xfs_setqlim_warns(res, qlim, newlim->d_ino_warns);
df42ce64dc3eb7 fs/xfs/xfs_qm_syscalls.c       Eric Sandeen      2020-05-21  614  	if (newlim->d_fieldmask & QC_INO_TIMER)
11d8a919027585 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-08-17  615  		xfs_setqlim_timer(mp, res, qlim, newlim->d_ino_timer);
df42ce64dc3eb7 fs/xfs/xfs_qm_syscalls.c       Eric Sandeen      2020-05-21  616  
df42ce64dc3eb7 fs/xfs/xfs_qm_syscalls.c       Eric Sandeen      2020-05-21  617  	if (id != 0) {
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  618  		/*
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  619  		 * If the user is now over quota, start the timelimit.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  620  		 * The user will not be 'warned'.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  621  		 * Note that we keep the timers ticking, whether enforcement
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  622  		 * is on or off. We don't really want to bother with iterating
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  623  		 * over all ondisk dquots and turning the timers on/off.
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  624  		 */
c8c753e19a7650 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  625  		xfs_qm_adjust_dqtimers(dqp);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  626  	}
985a78fdde15e1 fs/xfs/xfs_qm_syscalls.c       Darrick J. Wong   2020-07-14  627  	dqp->q_flags |= XFS_DQFLAG_DIRTY;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  628  	xfs_trans_log_dquot(tp, dqp);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  629  
70393313dd0b26 fs/xfs/xfs_qm_syscalls.c       Christoph Hellwig 2015-06-04  630  	error = xfs_trans_commit(tp);
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  631  
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21  632  out_rele:
f648167f3ac790 fs/xfs/xfs_qm_syscalls.c       Dave Chinner      2013-05-21 @633  	xfs_qm_dqrele(dqp);
8a7b8a89a3ae5b fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-04-20  634  out_unlock:
8a7b8a89a3ae5b fs/xfs/quota/xfs_qm_syscalls.c Christoph Hellwig 2010-04-20  635  	mutex_unlock(&q->qi_quotaofflock);
e5720eec0548c0 fs/xfs/quota/xfs_qm_syscalls.c David Chinner     2008-04-10  636  	return error;
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  637  }
^1da177e4c3f41 fs/xfs/quota/xfs_qm_syscalls.c Linus Torvalds    2005-04-16  638  

:::::: The code at line 633 was first introduced by commit
:::::: f648167f3ac79018c210112508c732ea9bf67c7b xfs: avoid nesting transactions in xfs_qm_scall_setqlim()

:::::: TO: Dave Chinner <dchinner@redhat.com>
:::::: CC: Ben Myers <bpm@sgi.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
