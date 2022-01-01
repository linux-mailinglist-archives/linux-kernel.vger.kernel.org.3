Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F117248285D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiAATwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 14:52:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:44897 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbiAATwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 14:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641066720; x=1672602720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9i/COeshf5x4ApTz/al0/whNQxxuNdp97SvyRRsoaKo=;
  b=mTKC6qfBqyLKZarRgDsIz/nXgOl+0rVVFrvaRQLY1RrNhUb/6oBUwGXD
   P/QNrQ1TiV0twhxcPbgDmNsk3HUAPh0LhBTDPzUY9w9kJig6gMS2VKEqH
   uq/9jucS3fW1bRnYS6MuRbUqH1KrGXbYU1LIOmF5UUPYzEFIES9OaxZG4
   GawOI/iI87J+M/crGi46YavYcBtWTAMDZVsJzYfZkBPuI7CNbF28SAwDM
   spc+NYDvsXaHa+F+I74vTL0rjZTDCzo+4NkZkhaoGv/y43k5VaXV7HX3a
   IacfAP92p2lO4DLRyD+IblMLvUKPD59dSpNkaulib+rHCdq2M/7zB6jcD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="305276777"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="305276777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 11:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="573362762"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2022 11:51:58 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3kQ2-000CmQ-7Q; Sat, 01 Jan 2022 19:51:58 +0000
Date:   Sun, 2 Jan 2022 03:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: fs/nfsd/nfs4proc.c:1219:17: warning: 'strncpy' specified bound 63
 equals destination size
Message-ID: <202201020346.aY1Or5Ed-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: f4e44b393389c77958f7c58bf4415032b4cda15b NFSD: delay unmount source's export after inter-server copy completed.
date:   7 months ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20220102/202201020346.aY1Or5Ed-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4e44b393389c77958f7c58bf4415032b4cda15b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4e44b393389c77958f7c58bf4415032b4cda15b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfsd/nfs4proc.c: In function 'nfsd4_ssc_setup_dul.constprop':
>> fs/nfsd/nfs4proc.c:1219:17: warning: 'strncpy' specified bound 63 equals destination size [-Wstringop-truncation]
    1219 |                 strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1219 fs/nfsd/nfs4proc.c

  1174	
  1175	/*
  1176	 * setup a work entry in the ssc delayed unmount list.
  1177	 */
  1178	static int nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
  1179			struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
  1180	{
  1181		struct nfsd4_ssc_umount_item *ni = 0;
  1182		struct nfsd4_ssc_umount_item *work = NULL;
  1183		struct nfsd4_ssc_umount_item *tmp;
  1184		DEFINE_WAIT(wait);
  1185	
  1186		*ss_mnt = NULL;
  1187		*retwork = NULL;
  1188		work = kzalloc(sizeof(*work), GFP_KERNEL);
  1189	try_again:
  1190		spin_lock(&nn->nfsd_ssc_lock);
  1191		list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
  1192			if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
  1193				continue;
  1194			/* found a match */
  1195			if (ni->nsui_busy) {
  1196				/*  wait - and try again */
  1197				prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
  1198					TASK_INTERRUPTIBLE);
  1199				spin_unlock(&nn->nfsd_ssc_lock);
  1200	
  1201				/* allow 20secs for mount/unmount for now - revisit */
  1202				if (signal_pending(current) ||
  1203						(schedule_timeout(20*HZ) == 0)) {
  1204					kfree(work);
  1205					return nfserr_eagain;
  1206				}
  1207				finish_wait(&nn->nfsd_ssc_waitq, &wait);
  1208				goto try_again;
  1209			}
  1210			*ss_mnt = ni->nsui_vfsmount;
  1211			refcount_inc(&ni->nsui_refcnt);
  1212			spin_unlock(&nn->nfsd_ssc_lock);
  1213			kfree(work);
  1214	
  1215			/* return vfsmount in ss_mnt */
  1216			return 0;
  1217		}
  1218		if (work) {
> 1219			strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
  1220			refcount_set(&work->nsui_refcnt, 2);
  1221			work->nsui_busy = true;
  1222			list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
  1223			*retwork = work;
  1224		}
  1225		spin_unlock(&nn->nfsd_ssc_lock);
  1226		return 0;
  1227	}
  1228	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
