Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADE4D6901
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbiCKTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiCKTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:13:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87E45AC6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647025972; x=1678561972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avT+4TnON8uQFynhMWL9RnsVIOvaVLLk/mGKUdy8nA4=;
  b=ClQh7SKl4nCJzqjimRvrvzp6xY8jMSM6Hc/Creefom4TaDjHbLgO2xmW
   BeBUPccs37ZwfJwq0U1jJpftmk3wkW4Xc+WPJmoe9fCGMyfYXyTdTSA4w
   5Nezmp9HdsBKVHrDaBf6o8/ENqcweaHpjTkcx6yRrUoLZl2Faui9muUhJ
   OFsjvBMJVHE7AL9CyYYHd88AYD7GcKqcElZzALcKpMGm44skgjFI9YoqV
   drtHYXozQ2+iJHRdy/S6SrUZcJ36HpXxkkx7ayxNTlmJBD2KsY/jOU2px
   MJQ381GhWOoXi7K95qx7CV/khWdpsNPBnzfAJjBNi70kha5+ZM2NC0DkA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="253198460"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="253198460"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 11:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="511476030"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 11:12:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSkgy-0006yN-Aa; Fri, 11 Mar 2022 19:12:48 +0000
Date:   Sat, 12 Mar 2022 03:12:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, mark-pk.tsai@mediatek.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] tracing: make tracer_init_tracefs initcall asynchronous
Message-ID: <202203120304.sJ9EJI90-lkp@intel.com>
References: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311112656.25348-1-mark-pk.tsai@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mark-PK-Tsai/tracing-make-tracer_init_tracefs-initcall-asynchronous/20220311-192857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: riscv-randconfig-r042-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120304.sJ9EJI90-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/134c5fb991a16bf28b500e8e52296447013b5b01
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mark-PK-Tsai/tracing-make-tracer_init_tracefs-initcall-asynchronous/20220311-192857
        git checkout 134c5fb991a16bf28b500e8e52296447013b5b01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa792a): Section mismatch in reference from the function tracefs_init() to the function .init.text:create_trace_instances()
The function tracefs_init() references
the function __init create_trace_instances().
This is often because tracefs_init lacks a __init
annotation or the annotation of create_trace_instances is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xade5e): Section mismatch in reference from the function event_trace_init() to the function .init.text:early_event_add_tracer()
The function event_trace_init() references
the function __init early_event_add_tracer().
This is often because event_trace_init lacks a __init
annotation or the annotation of early_event_add_tracer is wrong.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
