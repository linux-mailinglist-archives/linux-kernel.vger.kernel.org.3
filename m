Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD3492474
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiARLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:15:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:12189 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239291AbiARLOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504478; x=1674040478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q2jcRMclITKS1y7RVxNKJzqrOreAAQ8ecw2T5Cgu6W4=;
  b=fgJGS+QFc1gyvfr0elVoygafIINHsSJHI9tfVWQ0tHR6kYntvKV0ahkP
   eQVC6g5lxJ8iQTJiWq6ewVg2Ku3Is13MTcuSTKUvroJUTVxI2eIi/oewM
   qKcZjxpbJ1FgZgx1OAIQdDOs2s03d3uvcMi3JWvHdco7n5gr2pQcaUslQ
   llqIO2MbTxEEoDiSwvtG5uXvBEWDzDoMGv+ltc9cIUI8nqRCXzbSrxSXG
   VFaNlYeMsSaGCJ3mtXGPQqOO03du+l8bymle7cp8jF5Be+nnR1UQVpS6d
   cP1PL9jm6YM3PJMoYLFH5LeqGMBi5C1QNG5nsOau7BzS/nL1PTM0gy+Bk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269172810"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="269172810"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="595031365"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRa-000CVQ-63; Tue, 18 Jan 2022 11:14:30 +0000
Date:   Tue, 18 Jan 2022 19:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: fs/nfsd/nfs4proc.c:1219:17: warning: 'strncpy' specified bound 63
 equals destination size
Message-ID: <202201181657.6QL0fpaT-lkp@intel.com>
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
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: f4e44b393389c77958f7c58bf4415032b4cda15b NFSD: delay unmount source's export after inter-server copy completed.
date:   8 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220118/202201181657.6QL0fpaT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4e44b393389c77958f7c58bf4415032b4cda15b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4e44b393389c77958f7c58bf4415032b4cda15b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/esw/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/net/wireless/broadcom/brcm80211/brcmsmac/ drivers/net/wireless/intel/iwlwifi/ fs/nfsd/

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
