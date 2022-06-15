Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFA54CAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353542AbiFOOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:10:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D1443C6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655302245; x=1686838245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEDJ0OMV+LdMlTGSurlp2v82NpIT0qPCJR7vqwow24s=;
  b=XQ9vmmcHDCRMzx1jctvyonW2SAwIHDMxCQAQ7BLaoEkvBoJ6Wtn1IEQ8
   rVcwXGKuzGNfqaqGKAVlkKwKjU/6CHUH17Qhdpnm1UUG9Gq0Hd/IOXr08
   sw9FF7gx9mS5M3qCn19qD6Q0MwEcQnB0T1NkLeSGlJnqaXW+yRLoJN4cD
   JG6pwbv5ltZMjMxGW3AyQ5CiF73zOvJwhOWZU1DmEriHMXuonI4w61Cuu
   t2BtMav+nXIK7UTF3Mqm7HkHDw6IhR4vDIyPcEbyaWmNFL4SxWi7jzwPK
   6i1n1nbLX2Mn0ExOlnA+xS8WgR/ogdWsrqlgk5jIARCTG47ZEgAaJRaEr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279019812"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279019812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="572037608"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2022 07:09:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1Tht-000Muf-Dt;
        Wed, 15 Jun 2022 14:09:17 +0000
Date:   Wed, 15 Jun 2022 22:08:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] highmem: Make __kunmap_{local,atomic}() take "const void
 *"
Message-ID: <202206152120.ql9qAwG5-lkp@intel.com>
References: <20220614142531.16478-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614142531.16478-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/highmem-Make-__kunmap_-local-atomic-take-const-void/20220614-222749
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220615/202206152120.ql9qAwG5-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/558ba1aeb12cc7940165f07160e51afb0bc1a64b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/highmem-Make-__kunmap_-local-atomic-take-const-void/20220614-222749
        git checkout 558ba1aeb12cc7940165f07160e51afb0bc1a64b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from fs/open.c:16:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from fs/open.c:16:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from fs/open.c:16:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from fs/open.c:16:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
--
   In file included from include/linux/highmem.h:13,
                    from fs/pipe.c:21:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from fs/pipe.c:21:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from fs/pipe.c:21:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from fs/pipe.c:21:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   fs/pipe.c: At top level:
   fs/pipe.c:757:15: warning: no previous prototype for 'account_pipe_buffers' [-Wmissing-prototypes]
     757 | unsigned long account_pipe_buffers(struct user_struct *user,
         |               ^~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:763:6: warning: no previous prototype for 'too_many_pipe_buffers_soft' [-Wmissing-prototypes]
     763 | bool too_many_pipe_buffers_soft(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:770:6: warning: no previous prototype for 'too_many_pipe_buffers_hard' [-Wmissing-prototypes]
     770 | bool too_many_pipe_buffers_hard(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:777:6: warning: no previous prototype for 'pipe_is_unprivileged_user' [-Wmissing-prototypes]
     777 | bool pipe_is_unprivileged_user(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:1253:5: warning: no previous prototype for 'pipe_resize_ring' [-Wmissing-prototypes]
    1253 | int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
         |     ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/linux/blk-mq.h:5,
                    from fs/io_uring.c:60:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/linux/blk-mq.h:5,
                    from fs/io_uring.c:60:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/linux/blk-mq.h:5,
                    from fs/io_uring.c:60:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/linux/blk-mq.h:5,
                    from fs/io_uring.c:60:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:3196:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    3196 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
--
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/sunrpc/auth.h:14,
                    from include/linux/sunrpc/svc.h:18,
                    from include/linux/sunrpc/svc_xprt.h:11,
                    from fs/nfsd/export.c:19:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/sunrpc/auth.h:14,
                    from include/linux/sunrpc/svc.h:18,
                    from include/linux/sunrpc/svc_xprt.h:11,
                    from fs/nfsd/export.c:19:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/sunrpc/auth.h:14,
                    from include/linux/sunrpc/svc.h:18,
                    from include/linux/sunrpc/svc_xprt.h:11,
                    from fs/nfsd/export.c:19:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/sunrpc/auth.h:14,
                    from include/linux/sunrpc/svc.h:18,
                    from include/linux/sunrpc/svc_xprt.h:11,
                    from fs/nfsd/export.c:19:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:979:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
     979 |         struct inode            *inode;
         |                                  ^~~~~
--
   In file included from include/linux/highmem.h:13,
                    from include/linux/pagemap.h:11,
                    from include/linux/nfs_fs.h:24,
                    from fs/nfs/nfstrace.c:5:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:11,
                    from include/linux/nfs_fs.h:24,
                    from fs/nfs/nfstrace.c:5:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/pagemap.h:11,
                    from include/linux/nfs_fs.h:24,
                    from fs/nfs/nfstrace.c:5:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:11,
                    from include/linux/nfs_fs.h:24,
                    from fs/nfs/nfstrace.c:5:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from fs/nfs/nfstrace.h:1670,
                    from fs/nfs/nfstrace.c:10:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./nfstrace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.
--
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/nfs4.h:19,
                    from fs/nfsd/export.h:11,
                    from fs/nfsd/trace.h:13,
                    from fs/nfsd/trace.c:4:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/nfs4.h:19,
                    from fs/nfsd/export.h:11,
                    from fs/nfsd/trace.h:13,
                    from fs/nfsd/trace.c:4:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/nfs4.h:19,
                    from fs/nfsd/export.h:11,
                    from fs/nfsd/trace.h:13,
                    from fs/nfsd/trace.c:4:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:40,
                    from include/linux/inet.h:42,
                    from include/linux/sunrpc/msg_prot.h:200,
                    from include/linux/nfs4.h:19,
                    from fs/nfsd/export.h:11,
                    from fs/nfsd/trace.h:13,
                    from fs/nfsd/trace.c:4:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from fs/nfsd/trace.h:1152,
                    from fs/nfsd/trace.c:4:
   include/trace/define_trace.h: At top level:
   include/trace/define_trace.h:95:42: fatal error: ./trace.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
         |                                          ^
   compilation terminated.


vim +203 include/linux/highmem-internal.h

f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  199  
558ba1aeb12cc7 Fabio M. De Francesco 2022-06-14  200  static inline void __kunmap_local(const void *addr)
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  201  {
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  202  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18 @203  	kunmap_flush_on_unmap(addr);
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  204  #endif
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  205  }
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  206  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
