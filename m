Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75059B31D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHUK0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHUK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518818370
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661077608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3QVb79a/vM9MbV5I6Z+Mja7e4xfR8TMDPfEhKJPwL8=;
        b=BOfJrOsXvBkqzUyoLtvulP475jjMB4eUFfjnc4FpI6uQSDpoU5bQSI4wYwLBM36/FEjO+g
        lxIjIf3Dl+EOg3J+bYG0toA5B0yaBeSFykBMDyt4K1wnQSCdoj6OL3/PqarNstxTPBlovg
        /gZgy7UEVsCK8H9WE3mxoobxMyNrpaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-6cl6ybc1OPmEWafrk-we5w-1; Sun, 21 Aug 2022 06:26:44 -0400
X-MC-Unique: 6cl6ybc1OPmEWafrk-we5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53132811E75;
        Sun, 21 Aug 2022 10:26:44 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82408141511A;
        Sun, 21 Aug 2022 10:26:43 +0000 (UTC)
Date:   Sun, 21 Aug 2022 18:26:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwIIYHYnkJkY4yf3@MiWiFi-R3L-srv>
References: <20220820003125.353570-9-bhe@redhat.com>
 <202208201135.YyN9CXsu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208201135.YyN9CXsu-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/20/22 at 12:03pm, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: parisc-randconfig-r005-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201135.YyN9CXsu-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>         git checkout 570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc prepare

Thanks for reporting. While it failed with "hppa-linux-gcc: unknown compiler" as below showing. Could you help check and tell what's wrong?

[root@ ~]# ls
0day  anaconda-ks.cfg  bin  EFI_BOOT_ENTRY.TXT  linux  NETBOOT_METHOD.TXT  original-ks.cfg  RECIPE.TXT
[root@ ~]# ls 0day/gcc-12.1.0-nolibc/
hppa-linux  x86_64-gcc-12.1.0-nolibc_hppa-linux.tar.xz
[root@ ~]# ls bin/make.cross 
bin/make.cross
[root@ ~]# pwd
/root
[root@ ~]# cd linux/
[root@ linux]# pwd
/root/linux

[root@ linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=/root/linux/build_dir ARCH=parisc prepare
Compiler will be installed in /root/0day
PATH=/root/0day/gcc-12.1.0-nolibc/hppa-linux/bin:/root/.local/bin:/root/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
make --keep-going --jobs=160 W=1 O=/root/linux/build_dir ARCH=parisc prepare
make[1]: Entering directory '/root/linux/build_dir'
/root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: /root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: cannot execute binary file
  SYNC    include/config/auto.conf.cmd
/root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: /root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: cannot execute binary file
  GEN     Makefile
hppa-linux-gcc: unknown compiler
scripts/Kconfig.include:44: Sorry, this compiler is not supported.
make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
make[2]: *** [../Makefile:632: syncconfig] Error 2
make[1]: *** [/root/linux/Makefile:734: include/config/auto.conf.cmd] Error 2
make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
make[1]: Failed to remake makefile 'include/config/auto.conf'.
  GEN     Makefile
Error: kernelrelease not valid - run 'make prepare' to update it
make[1]: Target 'prepare' not remade because of errors.
make[1]: Leaving directory '/root/linux/build_dir'
make: *** [Makefile:222: __sub-make] Error 2
make: Target 'prepare' not remade because of errors.


> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/parisc/include/asm/io.h:315,
>                     from include/linux/io.h:13,
>                     from include/linux/irq.h:20,
>                     from arch/parisc/include/asm/hardirq.h:13,
>                     from include/linux/hardirq.h:11,
>                     from arch/parisc/kernel/asm-offsets.c:21:
> >> include/asm-generic/iomap.h:97: warning: "ioremap_wc" redefined
>       97 | #define ioremap_wc ioremap
>          | 
>    arch/parisc/include/asm/io.h:135: note: this is the location of the previous definition
>      135 | #define ioremap_wc(addr, size)  \
>          | 
>    include/linux/io.h: In function 'pci_remap_cfgspace':
> >> include/linux/io.h:89:44: error: implicit declaration of function 'ioremap'; did you mean 'ioremap_np'? [-Werror=implicit-function-declaration]
>       89 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
>          |                                            ^~~~~~~
>          |                                            ioremap_np
> >> include/linux/io.h:89:42: warning: pointer/integer type mismatch in conditional expression
>       89 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
>          |                                          ^
>    cc1: some warnings being treated as errors
>    make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1207: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:222: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +89 include/linux/io.h
> 
> 7d3dcf26a6559f Christoph Hellwig 2015-08-10  72  
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  73  #ifdef CONFIG_PCI
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  74  /*
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  75   * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> b10eb2d50911f9 Hector Martin     2021-03-25  76   * Posting") mandate non-posted configuration transactions. This default
> b10eb2d50911f9 Hector Martin     2021-03-25  77   * implementation attempts to use the ioremap_np() API to provide this
> b10eb2d50911f9 Hector Martin     2021-03-25  78   * on arches that support it, and falls back to ioremap() on those that
> b10eb2d50911f9 Hector Martin     2021-03-25  79   * don't. Overriding this function is deprecated; arches that properly
> b10eb2d50911f9 Hector Martin     2021-03-25  80   * support non-posted accesses should implement ioremap_np() instead, which
> b10eb2d50911f9 Hector Martin     2021-03-25  81   * this default implementation can then use to return mappings compliant with
> b10eb2d50911f9 Hector Martin     2021-03-25  82   * the PCI specification.
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  83   */
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  84  #ifndef pci_remap_cfgspace
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  85  #define pci_remap_cfgspace pci_remap_cfgspace
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  86  static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  87  					       size_t size)
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  88  {
> b10eb2d50911f9 Hector Martin     2021-03-25 @89  	return ioremap_np(offset, size) ?: ioremap(offset, size);
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  90  }
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  91  #endif
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  92  #endif
> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  93  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 

