Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B14C84B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiCAHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiCAHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:12:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D937A9A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646118698; x=1677654698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7ESzQYUAvvUNEJwaw5lridID5w/kruqkaekP5hLO+4=;
  b=XY3/kpXxi6V1kfgOija5Wmv3wC6OnjQS3Tcql7oKmMre+mLFJTc7TBOX
   eJSbyhinsy8f/kBsP6iY7X3jdWU1UDbu18IYm6XOV0I87sd0MpYIj7Cag
   K5zeTdfl5YBC3J0HBvr3OwXlOREOjIkDNQGKGl2YoT5pcD3z8EPY1tK9j
   mTeZTLL9mXWJBs5BgbqgG1oWoL1iQoNG4VvslQDPo9Y0LHx/gzcvFdrxV
   WJHUdmGSITtELdzT/xzIGb7Fudn+raw/4obXWzFQCxbPoNnuYnNjhNSfL
   qLI06Y7JjQsv+uiiBKfcbP+1MUGKq/KgsRSEBk8muMmrYD1BeFoui6vEf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253001946"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="253001946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="639274100"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2022 23:11:31 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOwfS-00006J-EX; Tue, 01 Mar 2022 07:11:30 +0000
Date:   Tue, 1 Mar 2022 15:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     kbuild-all@lists.01.org, David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH v2] mm/slub: initialize stack depot in boot process
Message-ID: <202203011512.U0o5cAx4-lkp@intel.com>
References: <Yh2Uxh9DMndwjGcb@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh2Uxh9DMndwjGcb@ip-172-31-19-208.ap-northeast-1.compute.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka/slub-stackdepot-v1]
[also build test ERROR on linus/master v5.17-rc6 next-20220228]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hyeonggon-Yoo/mm-slub-initialize-stack-depot-in-boot-process/20220301-113825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git slub-stackdepot-v1
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220301/202203011512.U0o5cAx4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/dd9dbeec7444b13b510dc4a863e9593d1799f965
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hyeonggon-Yoo/mm-slub-initialize-stack-depot-in-boot-process/20220301-113825
        git checkout dd9dbeec7444b13b510dc4a863e9593d1799f965
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/ebda.o: in function `slab_stack_depot_init':
>> ebda.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/main.o: in function `slab_stack_depot_init':
   main.c:(.text+0x32): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/do_mounts.o: in function `slab_stack_depot_init':
   do_mounts.c:(.text+0x5): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/noinitramfs.o: in function `slab_stack_depot_init':
   noinitramfs.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: init/init_task.o: in function `slab_stack_depot_init':
   init_task.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/syscall_32.o: in function `slab_stack_depot_init':
   syscall_32.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/common.o: in function `slab_stack_depot_init':
   common.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/vma.o: in function `slab_stack_depot_init':
   vma.c:(.text+0x1d0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/entry/vdso/extable.o: in function `slab_stack_depot_init':
   extable.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/core.o: in function `slab_stack_depot_init':
   core.c:(.text+0x903): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/amd/core.o: in function `slab_stack_depot_init':
   core.c:(.text+0x70b): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/core.o: in function `slab_stack_depot_init':
   core.c:(.text+0x1cbc): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/bts.o: in function `slab_stack_depot_init':
   bts.c:(.text+0x6b2): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/ds.o: in function `slab_stack_depot_init':
   ds.c:(.text+0x14ad): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/knc.o: in function `slab_stack_depot_init':
   knc.c:(.text+0x2b1): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/lbr.o: in function `slab_stack_depot_init':
   lbr.c:(.text+0x6c8): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p4.o: in function `slab_stack_depot_init':
   p4.c:(.text+0x5f8): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/p6.o: in function `slab_stack_depot_init':
   p6.c:(.text+0xc4): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/intel/pt.o: in function `slab_stack_depot_init':
   pt.c:(.text+0x641): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/events/zhaoxin/core.o: in function `slab_stack_depot_init':
   core.c:(.text+0x460): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/realmode/init.o: in function `slab_stack_depot_init':
   init.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/process_32.o: in function `slab_stack_depot_init':
   process_32.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/signal.o: in function `slab_stack_depot_init':
   signal.c:(.text+0x5b4): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/traps.o: in function `slab_stack_depot_init':
   traps.c:(.text+0x288): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/idt.o: in function `slab_stack_depot_init':
   idt.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq.o: in function `slab_stack_depot_init':
   irq.c:(.text+0x4f): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq_32.o: in function `slab_stack_depot_init':
   irq_32.c:(.text+0x1): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/dumpstack_32.o: in function `slab_stack_depot_init':
   dumpstack_32.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/time.o: in function `slab_stack_depot_init':
   time.c:(.text+0xd): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/ioport.o: in function `slab_stack_depot_init':
   ioport.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/dumpstack.o: in function `slab_stack_depot_init':
   dumpstack.c:(.text+0x11e): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/nmi.o: in function `slab_stack_depot_init':
   nmi.c:(.text+0x74): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/setup.o: in function `slab_stack_depot_init':
   setup.c:(.text+0x3): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/x86_init.o: in function `slab_stack_depot_init':
   x86_init.c:(.text+0x39): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/i8259.o: in function `slab_stack_depot_init':
   i8259.c:(.text+0x2c4): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irqinit.o: in function `slab_stack_depot_init':
   irqinit.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/irq_work.o: in function `slab_stack_depot_init':
   irq_work.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/probe_roms.o: in function `slab_stack_depot_init':
   probe_roms.c:(.text+0x1a3): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/sys_ia32.o: in function `slab_stack_depot_init':
   sys_ia32.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/bootflag.o: in function `slab_stack_depot_init':
   bootflag.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/e820.o: in function `slab_stack_depot_init':
   e820.c:(.text+0xbf): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/pci-dma.o: in function `slab_stack_depot_init':
   pci-dma.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/quirks.o: in function `slab_stack_depot_init':
   quirks.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/topology.o: in function `slab_stack_depot_init':
   topology.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/kdebugfs.o: in function `slab_stack_depot_init':
   kdebugfs.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/alternative.o: in function `slab_stack_depot_init':
   alternative.c:(.text+0x320): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/hw_breakpoint.o: in function `slab_stack_depot_init':
   hw_breakpoint.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/rtc.o: in function `slab_stack_depot_init':
   rtc.c:(.text+0x41): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/pci-iommu_table.o: in function `slab_stack_depot_init':
   pci-iommu_table.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/process.o: in function `slab_stack_depot_init':
   process.c:(.text+0xcf): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here
   ld: arch/x86/kernel/fpu/init.o: in function `slab_stack_depot_init':
   init.c:(.text+0x0): multiple definition of `slab_stack_depot_init'; arch/x86/kernel/head32.o:head32.c:(.text+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
