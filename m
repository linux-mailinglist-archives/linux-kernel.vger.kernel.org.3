Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECE4E32F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiCUWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiCUWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:47:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65693A35C8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF33B81A7D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF7DC340E8;
        Mon, 21 Mar 2022 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899949;
        bh=v7iFu1pvBkesNTpkONQEEnUI82Fc3+fzP2D8hT+4H+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InOebjhs2iP9JpMUBePghbNI1h3pcvyWi2si9MKsRovRyimuyh+l3la7ejYMWv/V7
         i5bfZI6iXRLuRjOQD3Q2oh5Y12hFD77MAopZ6v71E5VvNNI2Ghd3bSoBOXyD/ja0XN
         Mn+LsmWl5voPEf/ZzvZcb0ri6sLVNnaDJlu7EIs7l5oyjTduHA18zswqUh4k3iHogM
         nIAI24F1VkWwuk1yP9wLE7mjXRnqWn82GS+9iEesBjENaK7zb3LmPYn/w8s1rDgkB4
         7Wwi5Xuoxx5r4zpDZf5X10BDMt/qW2zMl26EhhL3ULm9QACwBGRIeqAdbFL9ujFV/L
         hEnhdb5m7xcyg==
Date:   Mon, 21 Mar 2022 14:59:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild] [djwong-xfs:djwong-wtf 349/351]
 fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code
 'error'
Message-ID: <20220321215908.GL8241@magnolia>
References: <202203190831.AYu7l0vX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203190831.AYu7l0vX-lkp@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:33:02AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git  djwong-wtf
> head:   baa8d54bb35559f0bc36ec9e9933bec9ab23e25f
> commit: b82670045aab66d3d66eca40f277354c3da07f1c [349/351] xfs: fallocate free space into a file
> config: openrisc-randconfig-m031-20220317 (https://download.01.org/0day-ci/archive/20220319/202203190831.AYu7l0vX-lkp@intel.com/config )
> compiler: or1k-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code 'error'
> 
> Old smatch warnings:
> fs/xfs/xfs_buf.h:430 xfs_buftarg_zeroout() warn: bitwise AND condition is false here
> 
> vim +/error +1372 fs/xfs/xfs_bmap_util.c
> 
> b82670045aab66 Darrick J. Wong 2022-01-06  1341  /* Find a free extent in this AG and map it into the file. */
> b82670045aab66 Darrick J. Wong 2022-01-06  1342  STATIC int
> b82670045aab66 Darrick J. Wong 2022-01-06  1343  xfs_map_free_extent(
> b82670045aab66 Darrick J. Wong 2022-01-06  1344  	struct xfs_inode	*ip,
> b82670045aab66 Darrick J. Wong 2022-01-06  1345  	struct xfs_perag	*pag,
> b82670045aab66 Darrick J. Wong 2022-01-06  1346  	xfs_agblock_t		*cursor,
> b82670045aab66 Darrick J. Wong 2022-01-06  1347  	xfs_agblock_t		end_agbno,
> b82670045aab66 Darrick J. Wong 2022-01-06  1348  	xfs_agblock_t		*last_enospc_agbno)
> b82670045aab66 Darrick J. Wong 2022-01-06  1349  {
> b82670045aab66 Darrick J. Wong 2022-01-06  1350  	struct xfs_bmbt_irec	irec;
> b82670045aab66 Darrick J. Wong 2022-01-06  1351  	struct xfs_mount	*mp = ip->i_mount;
> b82670045aab66 Darrick J. Wong 2022-01-06  1352  	struct xfs_trans	*tp;
> b82670045aab66 Darrick J. Wong 2022-01-06  1353  	xfs_off_t		endpos;
> b82670045aab66 Darrick J. Wong 2022-01-06  1354  	xfs_fsblock_t		fsbno;
> b82670045aab66 Darrick J. Wong 2022-01-06  1355  	xfs_extlen_t		len;
> b82670045aab66 Darrick J. Wong 2022-01-06  1356  	int			error;
> b82670045aab66 Darrick J. Wong 2022-01-06  1357  
> b82670045aab66 Darrick J. Wong 2022-01-06  1358  	if (fatal_signal_pending(current))
> b82670045aab66 Darrick J. Wong 2022-01-06  1359  		return -EINTR;
> b82670045aab66 Darrick J. Wong 2022-01-06  1360  
> b82670045aab66 Darrick J. Wong 2022-01-06  1361  	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, 0, 0, false,
> b82670045aab66 Darrick J. Wong 2022-01-06  1362  			&tp);
> b82670045aab66 Darrick J. Wong 2022-01-06  1363  	if (error)
> b82670045aab66 Darrick J. Wong 2022-01-06  1364  		return error;
> b82670045aab66 Darrick J. Wong 2022-01-06  1365  
> b82670045aab66 Darrick J. Wong 2022-01-06  1366  	error = xfs_alloc_find_freesp(tp, pag, cursor, end_agbno, &len);
> b82670045aab66 Darrick J. Wong 2022-01-06  1367  	if (error)
> b82670045aab66 Darrick J. Wong 2022-01-06  1368  		goto out_cancel;
> b82670045aab66 Darrick J. Wong 2022-01-06  1369  
> b82670045aab66 Darrick J. Wong 2022-01-06  1370  	/* Bail out if the cursor is beyond what we asked for. */
> b82670045aab66 Darrick J. Wong 2022-01-06  1371  	if (*cursor >= end_agbno)
> b82670045aab66 Darrick J. Wong 2022-01-06 @1372  		goto out_cancel;
> 
> This looks like it should have an error = -EINVAL;

Nope.  If xfs_alloc_find_freesp moves @cursor goes beyond end_agbno, we
want to exit early so that the xfs_map_free_extent caller will return to
userspace.

--D

> 
> b82670045aab66 Darrick J. Wong 2022-01-06  1373  
> b82670045aab66 Darrick J. Wong 2022-01-06  1374  	error = xfs_map_free_reserve_more(tp, ip, &len);
> b82670045aab66 Darrick J. Wong 2022-01-06  1375  	if (error)
> b82670045aab66 Darrick J. Wong 2022-01-06  1376  		goto out_cancel;
> b82670045aab66 Darrick J. Wong 2022-01-06  1377  
> b82670045aab66 Darrick J. Wong 2022-01-06  1378  	fsbno = XFS_AGB_TO_FSB(mp, pag->pag_agno, *cursor);
> b82670045aab66 Darrick J. Wong 2022-01-06  1379  	do {
> b82670045aab66 Darrick J. Wong 2022-01-06  1380  		error = xfs_bmapi_freesp(tp, ip, fsbno, len, &irec);
> b82670045aab66 Darrick J. Wong 2022-01-06  1381  		if (error == -EAGAIN) {
> b82670045aab66 Darrick J. Wong 2022-01-06  1382  			/* Failed to map space but were told to try again. */
> b82670045aab66 Darrick J. Wong 2022-01-06  1383  			error = xfs_trans_commit(tp);
> b82670045aab66 Darrick J. Wong 2022-01-06  1384  			goto out;
> b82670045aab66 Darrick J. Wong 2022-01-06  1385  		}
> b82670045aab66 Darrick J. Wong 2022-01-06  1386  		if (error != -ENOSPC)
> b82670045aab66 Darrick J. Wong 2022-01-06  1387  			break;
> b82670045aab66 Darrick J. Wong 2022-01-06  1388  		/*
> b82670045aab66 Darrick J. Wong 2022-01-06  1389  		 * If we can't get the space, try asking for successively less
> b82670045aab66 Darrick J. Wong 2022-01-06  1390  		 * space in case we're bumping up against per-AG metadata
> b82670045aab66 Darrick J. Wong 2022-01-06  1391  		 * reservation limits...
> b82670045aab66 Darrick J. Wong 2022-01-06  1392  		 */
> b82670045aab66 Darrick J. Wong 2022-01-06  1393  		len >>= 1;
> b82670045aab66 Darrick J. Wong 2022-01-06  1394  	} while (len > 0);
> b82670045aab66 Darrick J. Wong 2022-01-06  1395  	if (error == -ENOSPC && *last_enospc_agbno != *cursor) {
> b82670045aab66 Darrick J. Wong 2022-01-06  1396  		/*
> b82670045aab66 Darrick J. Wong 2022-01-06  1397  		 * ...but even that might not work if an AGFL fixup allocated
> b82670045aab66 Darrick J. Wong 2022-01-06  1398  		 * the block at *cursor.  The first time this happens, remember
> b82670045aab66 Darrick J. Wong 2022-01-06  1399  		 * that we ran out of space here, and try again.
> b82670045aab66 Darrick J. Wong 2022-01-06  1400  		 */
> b82670045aab66 Darrick J. Wong 2022-01-06  1401  		*last_enospc_agbno = *cursor;
> b82670045aab66 Darrick J. Wong 2022-01-06  1402  		error = 0;
> b82670045aab66 Darrick J. Wong 2022-01-06  1403  		goto out_cancel;
> b82670045aab66 Darrick J. Wong 2022-01-06  1404  	}
> b82670045aab66 Darrick J. Wong 2022-01-06  1405  	if (error)
> b82670045aab66 Darrick J. Wong 2022-01-06  1406  		goto out_cancel;
> b82670045aab66 Darrick J. Wong 2022-01-06  1407  
> b82670045aab66 Darrick J. Wong 2022-01-06  1408  	/* Update isize if needed. */
> b82670045aab66 Darrick J. Wong 2022-01-06  1409  	endpos = XFS_FSB_TO_B(mp, irec.br_startoff + irec.br_blockcount);
> b82670045aab66 Darrick J. Wong 2022-01-06  1410  	if (endpos > i_size_read(VFS_I(ip))) {
> b82670045aab66 Darrick J. Wong 2022-01-06  1411  		i_size_write(VFS_I(ip), endpos);
> b82670045aab66 Darrick J. Wong 2022-01-06  1412  		ip->i_disk_size = endpos;
> b82670045aab66 Darrick J. Wong 2022-01-06  1413  		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> b82670045aab66 Darrick J. Wong 2022-01-06  1414  	}
> b82670045aab66 Darrick J. Wong 2022-01-06  1415  
> b82670045aab66 Darrick J. Wong 2022-01-06  1416  	error = xfs_trans_commit(tp);
> b82670045aab66 Darrick J. Wong 2022-01-06  1417  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> b82670045aab66 Darrick J. Wong 2022-01-06  1418  	if (error)
> b82670045aab66 Darrick J. Wong 2022-01-06  1419  		return error;
> b82670045aab66 Darrick J. Wong 2022-01-06  1420  
> b82670045aab66 Darrick J. Wong 2022-01-06  1421  	*cursor += irec.br_blockcount;
> b82670045aab66 Darrick J. Wong 2022-01-06  1422  	return 0;
> b82670045aab66 Darrick J. Wong 2022-01-06  1423  out_cancel:
> b82670045aab66 Darrick J. Wong 2022-01-06  1424  	xfs_trans_cancel(tp);
> b82670045aab66 Darrick J. Wong 2022-01-06  1425  out:
> b82670045aab66 Darrick J. Wong 2022-01-06  1426  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> b82670045aab66 Darrick J. Wong 2022-01-06  1427  	return error;
> b82670045aab66 Darrick J. Wong 2022-01-06  1428  }
> 
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 
