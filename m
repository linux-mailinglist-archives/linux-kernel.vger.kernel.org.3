Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8046B0B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhLGCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:38:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:23857 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236369AbhLGCh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:37:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234986689"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="234986689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461079104"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2021 18:34:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muQJG-000M1x-9u; Tue, 07 Dec 2021 02:34:26 +0000
Date:   Tue, 7 Dec 2021 10:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 12/15] fs/nfs/super.c:500:2: warning:
 unannotated fall-through between switch labels
Message-ID: <202112071015.2kelJDK1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   667fe15e9d8a4b978367248bdf40bcd31620a08d
commit: d198aebeccadd6b073da47c96f4c6e4a23e970f1 [12/15] NFS: Add a "tls=" NFS mount option
config: i386-randconfig-a013-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071015.2kelJDK1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=d198aebeccadd6b073da47c96f4c6e4a23e970f1
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout d198aebeccadd6b073da47c96f4c6e4a23e970f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfs/super.c:500:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   fs/nfs/super.c:500:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +500 fs/nfs/super.c

   424	
   425	/*
   426	 * Describe the mount options in force on this server representation
   427	 */
   428	static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
   429					   int showdefaults)
   430	{
   431		static const struct proc_nfs_info {
   432			int flag;
   433			const char *str;
   434			const char *nostr;
   435		} nfs_info[] = {
   436			{ NFS_MOUNT_SOFT, ",soft", "" },
   437			{ NFS_MOUNT_SOFTERR, ",softerr", "" },
   438			{ NFS_MOUNT_SOFTREVAL, ",softreval", "" },
   439			{ NFS_MOUNT_POSIX, ",posix", "" },
   440			{ NFS_MOUNT_NOCTO, ",nocto", "" },
   441			{ NFS_MOUNT_NOAC, ",noac", "" },
   442			{ NFS_MOUNT_NONLM, ",nolock", "" },
   443			{ NFS_MOUNT_NOACL, ",noacl", "" },
   444			{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
   445			{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
   446			{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
   447			{ 0, NULL, NULL }
   448		};
   449		const struct proc_nfs_info *nfs_infop;
   450		struct nfs_client *clp = nfss->nfs_client;
   451		u32 version = clp->rpc_ops->version;
   452		int local_flock, local_fcntl;
   453	
   454		nfs_show_nfs_version(m, version, clp->cl_minorversion);
   455		seq_printf(m, ",rsize=%u", nfss->rsize);
   456		seq_printf(m, ",wsize=%u", nfss->wsize);
   457		if (nfss->bsize != 0)
   458			seq_printf(m, ",bsize=%u", nfss->bsize);
   459		seq_printf(m, ",namlen=%u", nfss->namelen);
   460		if (nfss->acregmin != NFS_DEF_ACREGMIN*HZ || showdefaults)
   461			seq_printf(m, ",acregmin=%u", nfss->acregmin/HZ);
   462		if (nfss->acregmax != NFS_DEF_ACREGMAX*HZ || showdefaults)
   463			seq_printf(m, ",acregmax=%u", nfss->acregmax/HZ);
   464		if (nfss->acdirmin != NFS_DEF_ACDIRMIN*HZ || showdefaults)
   465			seq_printf(m, ",acdirmin=%u", nfss->acdirmin/HZ);
   466		if (nfss->acdirmax != NFS_DEF_ACDIRMAX*HZ || showdefaults)
   467			seq_printf(m, ",acdirmax=%u", nfss->acdirmax/HZ);
   468		if (!(nfss->flags & (NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR)))
   469				seq_puts(m, ",hard");
   470		for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
   471			if (nfss->flags & nfs_infop->flag)
   472				seq_puts(m, nfs_infop->str);
   473			else
   474				seq_puts(m, nfs_infop->nostr);
   475		}
   476		rcu_read_lock();
   477		seq_printf(m, ",proto=%s",
   478			   rpc_peeraddr2str(nfss->client, RPC_DISPLAY_NETID));
   479		rcu_read_unlock();
   480		if (clp->cl_nconnect > 0)
   481			seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
   482		if (version == 4) {
   483			if (clp->cl_max_connect > 1)
   484				seq_printf(m, ",max_connect=%u", clp->cl_max_connect);
   485			if (nfss->port != NFS_PORT)
   486				seq_printf(m, ",port=%u", nfss->port);
   487		} else
   488			if (nfss->port)
   489				seq_printf(m, ",port=%u", nfss->port);
   490	
   491		seq_printf(m, ",timeo=%lu", 10U * nfss->client->cl_timeout->to_initval / HZ);
   492		seq_printf(m, ",retrans=%u", nfss->client->cl_timeout->to_retries);
   493		seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
   494		switch (clp->cl_tls_policy) {
   495		case NFS_CS_TLS_AUTO:
   496			seq_printf(m, ",tls=auto");
   497			break;
   498		case NFS_CS_TLS_REQUIRED:
   499			seq_printf(m, ",tls=required");
 > 500		default:
   501			break;
   502		}
   503	
   504		if (version != 4)
   505			nfs_show_mountd_options(m, nfss, showdefaults);
   506		else
   507			nfs_show_nfsv4_options(m, nfss, showdefaults);
   508	
   509		if (nfss->options & NFS_OPTION_FSCACHE)
   510			seq_puts(m, ",fsc");
   511	
   512		if (nfss->options & NFS_OPTION_MIGRATION)
   513			seq_puts(m, ",migration");
   514	
   515		if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG) {
   516			if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
   517				seq_puts(m, ",lookupcache=none");
   518			else
   519				seq_puts(m, ",lookupcache=pos");
   520		}
   521	
   522		local_flock = nfss->flags & NFS_MOUNT_LOCAL_FLOCK;
   523		local_fcntl = nfss->flags & NFS_MOUNT_LOCAL_FCNTL;
   524	
   525		if (!local_flock && !local_fcntl)
   526			seq_puts(m, ",local_lock=none");
   527		else if (local_flock && local_fcntl)
   528			seq_puts(m, ",local_lock=all");
   529		else if (local_flock)
   530			seq_puts(m, ",local_lock=flock");
   531		else
   532			seq_puts(m, ",local_lock=posix");
   533	
   534		if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
   535			if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
   536				seq_puts(m, ",write=wait");
   537			else
   538				seq_puts(m, ",write=eager");
   539		}
   540	}
   541	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
