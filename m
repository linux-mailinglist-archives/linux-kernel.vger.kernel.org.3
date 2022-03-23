Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46854E4D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiCWHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCWHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:33:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215372E39
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648020746; x=1679556746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pg6B+KmGvKKujuAKRQLIEwtAyGH6ZHBl+FQiT5TgXYk=;
  b=E++i6Vb5zLxH1rwt001aGTczdaka+tilU6GS1nCWx/YUCLixeh/OYPiy
   XLnBVLUjS2OweyEwrU2OVWL74IgRjrQsY06un4t/yenHALt3JoDhW3s75
   qQ5uA1NB5vO0+J0fi9i2LJcI+Rz6O0QmXNaLnQxmkMBzDxOdbdwFRDOLv
   iZzVr3b5whKKIhLUZK7LFF1+CQSYwop090WCCsJiv4jXN6fvo1ji85rfx
   EVs1SQvXPRVD1n1V8Vv9ZphhYgSKvgfP8Pw4Tob4CJLSL8Ah+Ib9I3NmH
   ij4dgQBZGL2IUoO/Dwn3qqvuNeQyldPgDd2yeE6fqXxV5mH7M1lO7VkpR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="240205935"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="240205935"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="515681265"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2022 00:32:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWvTh-000Jna-Eu; Wed, 23 Mar 2022 07:32:21 +0000
Date:   Wed, 23 Mar 2022 15:31:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, hridya@google.com,
        surenb@google.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] android: binder: Fix duplicate included asm/pgtable.h
Message-ID: <202203231518.MbgChhiL-lkp@intel.com>
References: <1648004047-27716-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648004047-27716-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.17 next-20220322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Haowen-Bai/android-binder-Fix-duplicate-included-asm-pgtable-h/20220323-105551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 41197a5f11a4b2d11ac19bc62552022153032811
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220323/202203231518.MbgChhiL-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/fbefc2882dc44d2fec2f172519ed27fd7296d4ee
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Haowen-Bai/android-binder-Fix-duplicate-included-asm-pgtable-h/20220323-105551
        git checkout fbefc2882dc44d2fec2f172519ed27fd7296d4ee
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/android/binder.c: In function 'binder_txn_latency_free':
   drivers/android/binder.c:1499:2: error: implicit declaration of function 'trace_binder_txn_latency_free'; did you mean 'binder_txn_latency_free'? [-Werror=implicit-function-declaration]
    1499 |  trace_binder_txn_latency_free(t, from_proc, from_thread, to_proc, to_thread);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_txn_latency_free
   drivers/android/binder.c: In function 'binder_free_transaction':
   drivers/android/binder.c:1518:6: error: implicit declaration of function 'trace_binder_txn_latency_free_enabled' [-Werror=implicit-function-declaration]
    1518 |  if (trace_binder_txn_latency_free_enabled())
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_translate_binder':
   drivers/android/binder.c:2089:2: error: implicit declaration of function 'trace_binder_transaction_node_to_ref' [-Werror=implicit-function-declaration]
    2089 |  trace_binder_transaction_node_to_ref(t, node, &rdata);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_translate_handle':
   drivers/android/binder.c:2140:3: error: implicit declaration of function 'trace_binder_transaction_ref_to_node' [-Werror=implicit-function-declaration]
    2140 |   trace_binder_transaction_ref_to_node(t, node, &src_rdata);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c:2159:3: error: implicit declaration of function 'trace_binder_transaction_ref_to_ref' [-Werror=implicit-function-declaration]
    2159 |   trace_binder_transaction_ref_to_ref(t, node, &src_rdata,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_translate_fd':
   drivers/android/binder.c:2222:2: error: implicit declaration of function 'trace_binder_transaction_fd_send' [-Werror=implicit-function-declaration]
    2222 |  trace_binder_transaction_fd_send(t, fd, fixup->offset);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_transaction':
   drivers/android/binder.c:3004:2: error: implicit declaration of function 'trace_binder_transaction'; did you mean 'binder_transaction'? [-Werror=implicit-function-declaration]
    3004 |  trace_binder_transaction(reply, t, target_node);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_transaction
   drivers/android/binder.c:3042:2: error: implicit declaration of function 'trace_binder_transaction_alloc_buf'; did you mean 'binder_transaction_log_add'? [-Werror=implicit-function-declaration]
    3042 |  trace_binder_transaction_alloc_buf(t->buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_transaction_log_add
   drivers/android/binder.c:3425:2: error: implicit declaration of function 'trace_binder_transaction_failed_buffer_release'; did you mean 'binder_transaction_buffer_release'? [-Werror=implicit-function-declaration]
    3425 |  trace_binder_transaction_failed_buffer_release(t->buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_transaction_buffer_release
   drivers/android/binder.c: In function 'binder_free_buf':
   drivers/android/binder.c:3535:2: error: implicit declaration of function 'trace_binder_transaction_buffer_release'; did you mean 'binder_transaction_buffer_release'? [-Werror=implicit-function-declaration]
    3535 |  trace_binder_transaction_buffer_release(buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_transaction_buffer_release
   drivers/android/binder.c: In function 'binder_thread_write':
   drivers/android/binder.c:3557:3: error: implicit declaration of function 'trace_binder_command' [-Werror=implicit-function-declaration]
    3557 |   trace_binder_command(cmd);
         |   ^~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_stat_br':
   drivers/android/binder.c:3990:2: error: implicit declaration of function 'trace_binder_return'; did you mean 'trace_handle_return'? [-Werror=implicit-function-declaration]
    3990 |  trace_binder_return(cmd);
         |  ^~~~~~~~~~~~~~~~~~~
         |  trace_handle_return
   drivers/android/binder.c: In function 'binder_apply_fd_fixups':
   drivers/android/binder.c:4094:3: error: implicit declaration of function 'trace_binder_transaction_fd_recv' [-Werror=implicit-function-declaration]
    4094 |   trace_binder_transaction_fd_recv(t, fd, fixup->offset);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_thread_read':
   drivers/android/binder.c:4151:2: error: implicit declaration of function 'trace_binder_wait_for_work'; did you mean 'binder_wait_for_work'? [-Werror=implicit-function-declaration]
    4151 |  trace_binder_wait_for_work(wait_for_proc_work,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |  binder_wait_for_work
   drivers/android/binder.c:4481:3: error: implicit declaration of function 'trace_binder_transaction_received' [-Werror=implicit-function-declaration]
    4481 |   trace_binder_transaction_received(t);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_ioctl_write_read':
   drivers/android/binder.c:4824:3: error: implicit declaration of function 'trace_binder_write_done' [-Werror=implicit-function-declaration]
    4824 |   trace_binder_write_done(ret);
         |   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c:4837:3: error: implicit declaration of function 'trace_binder_read_done' [-Werror=implicit-function-declaration]
    4837 |   trace_binder_read_done(ret);
         |   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c: In function 'binder_ioctl':
   drivers/android/binder.c:5077:2: error: implicit declaration of function 'trace_binder_ioctl'; did you mean 'binder_ioctl'? [-Werror=implicit-function-declaration]
    5077 |  trace_binder_ioctl(cmd, arg);
         |  ^~~~~~~~~~~~~~~~~~
         |  binder_ioctl
   drivers/android/binder.c:5284:2: error: implicit declaration of function 'trace_binder_ioctl_done' [-Werror=implicit-function-declaration]
    5284 |  trace_binder_ioctl_done(ret);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
   drivers/android/binder_trace.h: At top level:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_ioctl'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(binder_ioctl,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_ioctl' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(binder_ioctl,
         | ^~~~~~~~~~~
   drivers/android/binder.c:5077:2: note: previous implicit declaration of 'trace_binder_ioctl' was here
    5077 |  trace_binder_ioctl(cmd, arg);
         |  ^~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_ioctl_done'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:75:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      75 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_ioctl_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_ioctl_done' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:75:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      75 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_ioctl_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c:5284:2: note: previous implicit declaration of 'trace_binder_ioctl_done' was here
    5284 |  trace_binder_ioctl_done(ret);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_write_done'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:76:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      76 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_write_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_write_done' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:76:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      76 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_write_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c:4824:3: note: previous implicit declaration of 'trace_binder_write_done' was here
    4824 |   trace_binder_write_done(ret);
         |   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_read_done'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:77:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      77 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_read_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_read_done' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:71:1: note: in expansion of macro 'DEFINE_EVENT'
      71 | DEFINE_EVENT(binder_function_return_class, name, \
         | ^~~~~~~~~~~~
   drivers/android/binder_trace.h:77:1: note: in expansion of macro 'DEFINE_BINDER_FUNCTION_RETURN_EVENT'
      77 | DEFINE_BINDER_FUNCTION_RETURN_EVENT(binder_read_done);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/android/binder.c:4837:3: note: previous implicit declaration of 'trace_binder_read_done' was here
    4837 |   trace_binder_read_done(ret);
         |   ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_wait_for_work'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:79:1: note: in expansion of macro 'TRACE_EVENT'
      79 | TRACE_EVENT(binder_wait_for_work,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_wait_for_work' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:79:1: note: in expansion of macro 'TRACE_EVENT'
      79 | TRACE_EVENT(binder_wait_for_work,
         | ^~~~~~~~~~~
   drivers/android/binder.c:4151:2: note: previous implicit declaration of 'trace_binder_wait_for_work' was here
    4151 |  trace_binder_wait_for_work(wait_for_proc_work,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_txn_latency_free'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(binder_txn_latency_free,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_txn_latency_free' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(binder_txn_latency_free,
         | ^~~~~~~~~~~
   drivers/android/binder.c:1499:2: note: previous implicit declaration of 'trace_binder_txn_latency_free' was here
    1499 |  trace_binder_txn_latency_free(t, from_proc, from_thread, to_proc, to_thread);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
   include/linux/tracepoint.h:283:2: error: conflicting types for 'trace_binder_txn_latency_free_enabled'
     283 |  trace_##name##_enabled(void)     \
         |  ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(binder_txn_latency_free,
         | ^~~~~~~~~~~
   drivers/android/binder.c:1518:6: note: previous implicit declaration of 'trace_binder_txn_latency_free_enabled' was here
    1518 |  if (trace_binder_txn_latency_free_enabled())
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:127:1: note: in expansion of macro 'TRACE_EVENT'
     127 | TRACE_EVENT(binder_transaction,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:127:1: note: in expansion of macro 'TRACE_EVENT'
     127 | TRACE_EVENT(binder_transaction,
         | ^~~~~~~~~~~
   drivers/android/binder.c:3004:2: note: previous implicit declaration of 'trace_binder_transaction' was here
    3004 |  trace_binder_transaction(reply, t, target_node);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_received'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:155:1: note: in expansion of macro 'TRACE_EVENT'
     155 | TRACE_EVENT(binder_transaction_received,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_received' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:155:1: note: in expansion of macro 'TRACE_EVENT'
     155 | TRACE_EVENT(binder_transaction_received,
         | ^~~~~~~~~~~
   drivers/android/binder.c:4481:3: note: previous implicit declaration of 'trace_binder_transaction_received' was here
    4481 |   trace_binder_transaction_received(t);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_node_to_ref'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:168:1: note: in expansion of macro 'TRACE_EVENT'
     168 | TRACE_EVENT(binder_transaction_node_to_ref,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_node_to_ref' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:168:1: note: in expansion of macro 'TRACE_EVENT'
     168 | TRACE_EVENT(binder_transaction_node_to_ref,
         | ^~~~~~~~~~~
   drivers/android/binder.c:2089:2: note: previous implicit declaration of 'trace_binder_transaction_node_to_ref' was here
    2089 |  trace_binder_transaction_node_to_ref(t, node, &rdata);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_ref_to_node'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:193:1: note: in expansion of macro 'TRACE_EVENT'
     193 | TRACE_EVENT(binder_transaction_ref_to_node,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_ref_to_node' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:193:1: note: in expansion of macro 'TRACE_EVENT'
     193 | TRACE_EVENT(binder_transaction_ref_to_node,
         | ^~~~~~~~~~~
   drivers/android/binder.c:2140:3: note: previous implicit declaration of 'trace_binder_transaction_ref_to_node' was here
    2140 |   trace_binder_transaction_ref_to_node(t, node, &src_rdata);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_ref_to_ref'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:218:1: note: in expansion of macro 'TRACE_EVENT'
     218 | TRACE_EVENT(binder_transaction_ref_to_ref,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_ref_to_ref' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:218:1: note: in expansion of macro 'TRACE_EVENT'
     218 | TRACE_EVENT(binder_transaction_ref_to_ref,
         | ^~~~~~~~~~~
   drivers/android/binder.c:2159:3: note: previous implicit declaration of 'trace_binder_transaction_ref_to_ref' was here
    2159 |   trace_binder_transaction_ref_to_ref(t, node, &src_rdata,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_fd_send'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:246:1: note: in expansion of macro 'TRACE_EVENT'
     246 | TRACE_EVENT(binder_transaction_fd_send,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_fd_send' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:246:1: note: in expansion of macro 'TRACE_EVENT'
     246 | TRACE_EVENT(binder_transaction_fd_send,
         | ^~~~~~~~~~~
   drivers/android/binder.c:2222:2: note: previous implicit declaration of 'trace_binder_transaction_fd_send' was here
    2222 |  trace_binder_transaction_fd_send(t, fd, fixup->offset);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_fd_recv'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:264:1: note: in expansion of macro 'TRACE_EVENT'
     264 | TRACE_EVENT(binder_transaction_fd_recv,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_fd_recv' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:264:1: note: in expansion of macro 'TRACE_EVENT'
     264 | TRACE_EVENT(binder_transaction_fd_recv,
         | ^~~~~~~~~~~
   drivers/android/binder.c:4094:3: note: previous implicit declaration of 'trace_binder_transaction_fd_recv' was here
    4094 |   trace_binder_transaction_fd_recv(t, fd, fixup->offset);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_alloc_buf'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:302:1: note: in expansion of macro 'DEFINE_EVENT'
     302 | DEFINE_EVENT(binder_buffer_class, binder_transaction_alloc_buf,
         | ^~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_alloc_buf' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:302:1: note: in expansion of macro 'DEFINE_EVENT'
     302 | DEFINE_EVENT(binder_buffer_class, binder_transaction_alloc_buf,
         | ^~~~~~~~~~~~
   drivers/android/binder.c:3042:2: note: previous implicit declaration of 'trace_binder_transaction_alloc_buf' was here
    3042 |  trace_binder_transaction_alloc_buf(t->buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_buffer_release'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:306:1: note: in expansion of macro 'DEFINE_EVENT'
     306 | DEFINE_EVENT(binder_buffer_class, binder_transaction_buffer_release,
         | ^~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_buffer_release' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:306:1: note: in expansion of macro 'DEFINE_EVENT'
     306 | DEFINE_EVENT(binder_buffer_class, binder_transaction_buffer_release,
         | ^~~~~~~~~~~~
   drivers/android/binder.c:3535:2: note: previous implicit declaration of 'trace_binder_transaction_buffer_release' was here
    3535 |  trace_binder_transaction_buffer_release(buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_transaction_failed_buffer_release'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:310:1: note: in expansion of macro 'DEFINE_EVENT'
     310 | DEFINE_EVENT(binder_buffer_class, binder_transaction_failed_buffer_release,
         | ^~~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_transaction_failed_buffer_release' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
     542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:310:1: note: in expansion of macro 'DEFINE_EVENT'
     310 | DEFINE_EVENT(binder_buffer_class, binder_transaction_failed_buffer_release,
         | ^~~~~~~~~~~~
   drivers/android/binder.c:3425:2: note: previous implicit declaration of 'trace_binder_transaction_failed_buffer_release' was here
    3425 |  trace_binder_transaction_failed_buffer_release(t->buffer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_command'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:390:1: note: in expansion of macro 'TRACE_EVENT'
     390 | TRACE_EVENT(binder_command,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_command' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:390:1: note: in expansion of macro 'TRACE_EVENT'
     390 | TRACE_EVENT(binder_command,
         | ^~~~~~~~~~~
   drivers/android/binder.c:3557:3: note: previous implicit declaration of 'trace_binder_command' was here
    3557 |   trace_binder_command(cmd);
         |   ^~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from drivers/android/binder.c:66:
>> include/linux/tracepoint.h:245:21: warning: conflicting types for 'trace_binder_return'
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:406:1: note: in expansion of macro 'TRACE_EVENT'
     406 | TRACE_EVENT(binder_return,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:245:21: error: static declaration of 'trace_binder_return' follows non-static declaration
     245 |  static inline void trace_##name(proto)    \
         |                     ^~~~~~
   include/linux/tracepoint.h:419:2: note: in expansion of macro '__DECLARE_TRACE'
     419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
         |  ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:553:2: note: in expansion of macro 'DECLARE_TRACE'
     553 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
         |  ^~~~~~~~~~~~~
   drivers/android/binder_trace.h:406:1: note: in expansion of macro 'TRACE_EVENT'
     406 | TRACE_EVENT(binder_return,
         | ^~~~~~~~~~~
   drivers/android/binder.c:3990:2: note: previous implicit declaration of 'trace_binder_return' was here
    3990 |  trace_binder_return(cmd);
         |  ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/trace_binder_ioctl +245 include/linux/tracepoint.h

7ece55a4a3a04a Josh Triplett            2012-09-04  228  
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  229  /*
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  230   * Make sure the alignment of the structure in the __tracepoints section will
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  231   * not add unwanted padding between the beginning of the section and the
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  232   * structure. Force alignment to the same alignment as the section start.
3a630178fd5f30 Dave Hansen              2014-08-07  233   *
3a630178fd5f30 Dave Hansen              2014-08-07  234   * When lockdep is enabled, we make sure to always do the RCU portions of
a15920bea0428c Mathieu Desnoyers        2015-11-02  235   * the tracepoint code, regardless of whether tracing is on. However,
a15920bea0428c Mathieu Desnoyers        2015-11-02  236   * don't check if the condition is false, due to interaction with idle
a15920bea0428c Mathieu Desnoyers        2015-11-02  237   * instrumentation. This lets us find RCU issues triggered with tracepoints
a15920bea0428c Mathieu Desnoyers        2015-11-02  238   * even when this tracepoint is off. This code has no purpose other than
a15920bea0428c Mathieu Desnoyers        2015-11-02  239   * poking RCU a bit.
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  240   */
1746fd4416ed55 Steven Rostedt (VMware   2021-02-08  241) #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
de394e7568ce2c peterz@infradead.org     2020-09-08  242  	extern int __traceiter_##name(data_proto);			\
de394e7568ce2c peterz@infradead.org     2020-09-08  243  	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
7e066fb870fcd1 Mathieu Desnoyers        2008-11-14  244  	extern struct tracepoint __tracepoint_##name;			\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18 @245  	static inline void trace_##name(proto)				\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  246  	{								\
c5905afb0ee655 Ingo Molnar              2012-02-24  247  		if (static_key_false(&__tracepoint_##name.key))		\
d25e37d89dd2f4 Steven Rostedt (VMware   2020-08-18  248) 			__DO_TRACE(name,				\
1746fd4416ed55 Steven Rostedt (VMware   2021-02-08  249) 				TP_ARGS(args),				\
d54b6eeb553c89 Steven Rostedt (VMware   2017-04-07  250) 				TP_CONDITION(cond), 0);			\
a05d59a5673339 Steven Rostedt (Red Hat  2015-02-06  251) 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
3a630178fd5f30 Dave Hansen              2014-08-07  252  			rcu_read_lock_sched_notrace();			\
3a630178fd5f30 Dave Hansen              2014-08-07  253  			rcu_dereference_sched(__tracepoint_##name.funcs);\
3a630178fd5f30 Dave Hansen              2014-08-07  254  			rcu_read_unlock_sched_notrace();		\
3a630178fd5f30 Dave Hansen              2014-08-07  255  		}							\
2fbb90db1b8fcc Steven Rostedt           2012-02-07  256  	}								\
7ece55a4a3a04a Josh Triplett            2012-09-04  257  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
1746fd4416ed55 Steven Rostedt (VMware   2021-02-08  258) 			    PARAMS(cond))				\
38516ab59fbc5b Steven Rostedt           2010-04-20  259  	static inline int						\
38516ab59fbc5b Steven Rostedt           2010-04-20  260  	register_trace_##name(void (*probe)(data_proto), void *data)	\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  261  	{								\
de7b2973903c6c Mathieu Desnoyers        2014-04-08  262  		return tracepoint_probe_register(&__tracepoint_##name,	\
de7b2973903c6c Mathieu Desnoyers        2014-04-08  263  						(void *)probe, data);	\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  264  	}								\
38516ab59fbc5b Steven Rostedt           2010-04-20  265  	static inline int						\
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  266) 	register_trace_prio_##name(void (*probe)(data_proto), void *data,\
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  267) 				   int prio)				\
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  268) 	{								\
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  269) 		return tracepoint_probe_register_prio(&__tracepoint_##name, \
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  270) 					      (void *)probe, data, prio); \
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  271) 	}								\
7904b5c4988e18 Steven Rostedt (Red Hat  2015-09-22  272) 	static inline int						\
38516ab59fbc5b Steven Rostedt           2010-04-20  273  	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  274  	{								\
de7b2973903c6c Mathieu Desnoyers        2014-04-08  275  		return tracepoint_probe_unregister(&__tracepoint_##name,\
de7b2973903c6c Mathieu Desnoyers        2014-04-08  276  						(void *)probe, data);	\
53da59aa6dd881 Mathieu Desnoyers        2010-04-30  277  	}								\
38516ab59fbc5b Steven Rostedt           2010-04-20  278  	static inline void						\
38516ab59fbc5b Steven Rostedt           2010-04-20  279  	check_trace_callback_type_##name(void (*cb)(data_proto))	\
53da59aa6dd881 Mathieu Desnoyers        2010-04-30  280  	{								\
7c65bbc7dcface Steven Rostedt (Red Hat  2014-05-06  281) 	}								\
7c65bbc7dcface Steven Rostedt (Red Hat  2014-05-06  282) 	static inline bool						\
7c65bbc7dcface Steven Rostedt (Red Hat  2014-05-06  283) 	trace_##name##_enabled(void)					\
7c65bbc7dcface Steven Rostedt (Red Hat  2014-05-06  284) 	{								\
7c65bbc7dcface Steven Rostedt (Red Hat  2014-05-06  285) 		return static_key_false(&__tracepoint_##name.key);	\
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  286  	}
97e1c18e8d17bd Mathieu Desnoyers        2008-07-18  287  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
