Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9484C5246
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiBYXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBYXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:51:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51302203BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645833031; x=1677369031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hlTzqW3z1/Uly518VVFnnuVvZespwZ7eXVJbLMByNY=;
  b=hnAtbHaPhC0XmkZ1BGbzn0kYzh/g+Z2ewtnqbwk4TVdomhoCO6pO8J0J
   jZVuLZYr4+gzDQYZ3TalG4fP6WmIxIgRzsrCLaG6iinlX/6oTHDbASijb
   0W4lN0cQY0ztByYuM5zBOxNfyUNe3OawNfvFF38FgiFr+8YUt/iMyJSyV
   AOYXRpGECJNtOAKVtUeA5/9UbLr290ZrKEC/RfuF45d7oNnup2+9gbTRS
   hH6T9vDduYHo0ppSR2q+1EL2/lKMvm7F5PcFTm4B/NeCQVbtB2wOuKBaq
   znNfDutMjPuxzxzLXqVJKcFBMfkAGMgskZ4xHQK1AL5JklrzQxYc6mCjz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="236111539"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="236111539"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 15:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="544203787"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2022 15:50:27 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNkLz-0004py-5R; Fri, 25 Feb 2022 23:50:27 +0000
Date:   Sat, 26 Feb 2022 07:50:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Cheng <michael.cheng@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, willy@infradead.org,
        michael.cheng@intel.com, casey.g.bowman@intel.com,
        lucas.demarchi@intel.com, wayne.boyer@intel.com,
        tvrtko.ursulin@linux.intel.com, matthew.d.roper@intel.com,
        geert@linux-m68k.org
Subject: Re: [PATCH v1] Add struct folio to cacheflush.h
Message-ID: <202202260726.vS0w07OM-lkp@intel.com>
References: <20220225201248.984169-1-michael.cheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225201248.984169-1-michael.cheng@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.17-rc5 next-20220224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220226/202202260726.vS0w07OM-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f519440dbde207a6ade2472cd2e6c32028923342
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Cheng/Add-struct-folio-to-cacheflush-h/20220226-041442
        git checkout f519440dbde207a6ade2472cd2e6c32028923342
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> alpha-linux-ld: crypto/scatterwalk.o:(.sbss+0x0): multiple definition of `folio'; crypto/algapi.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: crypto/shash.o:(.sbss+0x0): multiple definition of `folio'; crypto/ahash.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: crypto/scompress.o:(.sbss+0x8): multiple definition of `folio'; crypto/acompress.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: net/sunrpc/xprt.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/socklib.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/xprtsock.o:(.sbss+0x10): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/sched.o:(.sbss+0x30): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/auth.o:(.sbss+0x8): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/auth_null.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/auth_unix.o:(.sbss+0x8): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/svc.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/svcsock.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/svcauth.o:(.sbss+0x8): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/svcauth_unix.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/addr.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/rpcb_clnt.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/timer.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/xdr.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/sunrpc_syms.o:(.sbss+0x8): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/cache.o:(.sbss+0x18): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/rpc_pipe.o:(.sbss+0x10): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/sysfs.o:(.sbss+0x18): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/svc_xprt.o:(.sbss+0x8): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/xprtmultipath.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/stats.o:(.sbss+0x0): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
   alpha-linux-ld: net/sunrpc/sysctl.o:(.sbss+0x10): multiple definition of `folio'; net/sunrpc/clnt.o:(.sbss+0x8): first defined here
--
>> alpha-linux-ld: fs/reiserfs/do_balan.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/namei.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/inode.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/file.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/dir.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/fix_node.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/super.o:(.sbss+0x10): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/prints.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/objectid.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/lbalance.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/ibalance.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/stree.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/hashes.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/tail_conversion.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/journal.o:(.sbss+0x10): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/resize.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/item_ops.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/ioctl.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/xattr.o:(.sbss+0x8): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/reiserfs/lock.o:(.sbss+0x0): multiple definition of `folio'; fs/reiserfs/bitmap.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_93cx6.o:(.sbss+0x0): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
   alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_pci.o:(.sbss+0x0): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
   alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_reg_print.o:(.sbss+0x0): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
   alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_osm.o:(.sbss+0x30): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
   alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_proc.o:(.sbss+0x0): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
   alpha-linux-ld: drivers/scsi/aic7xxx/aic7xxx_osm_pci.o:(.sbss+0x0): multiple definition of `folio'; drivers/scsi/aic7xxx/aic7xxx_core.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: fs/nfs/dir.o:(.sbss+0x8): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/file.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/getroot.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/inode.o:(.sbss+0x20): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/super.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/io.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/direct.o:(.sbss+0x10): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/pagelist.o:(.sbss+0x8): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/read.o:(.sbss+0x8): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/symlink.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/unlink.o:(.sbss+0x8): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/write.o:(.sbss+0x38): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/namespace.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/mount_clnt.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/nfstrace.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/export.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/sysfs.o:(.sbss+0x10): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/fs_context.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/sysctl.o:(.sbss+0x8): multiple definition of `folio'; fs/nfs/client.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: fs/nfs/proc.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/nfs2super.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/nfs2xdr.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/nfs2super.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: fs/nfs/nfs3client.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/nfs3super.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/nfs3proc.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/nfs3super.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfs/nfs3xdr.o:(.sbss+0x0): multiple definition of `folio'; fs/nfs/nfs3super.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: fs/nfsd/nfssvc.o:(.sbss+0x20): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/nfsctl.o:(.sbss+0x8): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/nfsproc.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/nfsfh.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/vfs.o:(.sbss+0x10): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/export.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/auth.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/lockd.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/nfscache.o:(.sbss+0x8): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/nfsxdr.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/stats.o:(.sbss+0x0): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
   alpha-linux-ld: fs/nfsd/filecache.o:(.sbss+0x40): multiple definition of `folio'; fs/nfsd/trace.o:(.sbss+0x0): first defined here
--
>> alpha-linux-ld: fs/lockd/clntproc.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/clntxdr.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/host.o:(.sbss+0x10): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svc.o:(.sbss+0x48): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svclock.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svcshare.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svcproc.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svcsubs.o:(.sbss+0x8): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/mon.o:(.sbss+0x10): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/xdr.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/clnt4xdr.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/xdr4.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/svc4proc.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here
   alpha-linux-ld: fs/lockd/procfs.o:(.sbss+0x0): multiple definition of `folio'; fs/lockd/clntlock.o:(.sbss+0x8): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
