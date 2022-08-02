Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63312587740
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiHBGuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHBGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:50:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E8D47
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659423011; x=1690959011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D11ZLMA31eDJtO1OR12nAEfBAMu9aBfNDNBgKIPvU7U=;
  b=muzpKLRKE7SpWkkCOIVaULT0ffBJo4f1YDKcyDxhg4WFr55lxC/JXj0S
   wpI5xAZ2By4ncAMrkg9w3FLqMxa/2o5rZOjyuWGNYJPdnobbYKY4/ZAay
   vLDucBAiryFBOSNky+jgbtKzLxsOo2pGvJ8WpDLGEvySvdD/m/FxctFqF
   cNty+8yeRtydYckkwe+9r9mzhpHzhCHILTGeBRXyj17biTtrl1LGw0dUO
   IjiPL0UqNHzYEsAFxMUPY+IuUNDoyZK4vl/N3eXdMinyfCDhlqgZDtbww
   J4ihz9xnoQj/HzIyA/OqHTlYHvkf/HLOrUMEFjzc9OGPv0zku4IHuN9Sv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269104569"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269104569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 23:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="552810210"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2022 23:50:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIljD-000Fn5-34;
        Tue, 02 Aug 2022 06:50:07 +0000
Date:   Tue, 2 Aug 2022 14:49:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Add .percent suffix option to histogram
 values
Message-ID: <202208021438.2r5RXlo9-lkp@intel.com>
References: <165932284978.2881436.13536997915615710506.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165932284978.2881436.13536997915615710506.stgit@devnote2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Masami,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[also build test ERROR on linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-hist-Add-percentage-histogram-suffixes/20220801-110217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: i386-randconfig-a001-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021438.2r5RXlo9-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/aef5f602ee3aa9ca07402c1d3da0642e932c1b3a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masami-Hiramatsu-Google/tracing-hist-Add-percentage-histogram-suffixes/20220801-110217
        git checkout aef5f602ee3aa9ca07402c1d3da0642e932c1b3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __udivdi3
   >>> referenced by trace_events_hist.c:5211 (kernel/trace/trace_events_hist.c:5211)
   >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
   >>> referenced by trace_events_hist.c:0 (kernel/trace/trace_events_hist.c:0)
   >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
   >>> referenced by trace_events_hist.c:5211 (kernel/trace/trace_events_hist.c:5211)
   >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
   >>> referenced 1 more times

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
