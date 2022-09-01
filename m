Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A65A94CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiIAKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiIAKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB91299EF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662028778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwR6m1mNjNfWvaLhiXToZ3vzYqKzUHc12aqdIUrXx2k=;
        b=NGNV+8O+/Sc98EJvYkrtYQ7VCL9nZWCUfjGr9gI30WIoSoBt+IzzW/i02HXoiBpMXdC+fe
        tj0JFuBpOiUjoXp2PgLP4wxmz7XPjXxJadXVY/dcVuaqyhcBahBmHbeyKbXU9G2b0xJG7M
        G7tVtXS76nEHHXjbfNZZ6BL6qjI4X4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-dvHVNWbQPz2J5P10mFWp8w-1; Thu, 01 Sep 2022 06:39:35 -0400
X-MC-Unique: dvHVNWbQPz2J5P10mFWp8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C306E8037AE;
        Thu,  1 Sep 2022 10:39:34 +0000 (UTC)
Received: from localhost (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 069B0492C3B;
        Thu,  1 Sep 2022 10:39:33 +0000 (UTC)
Date:   Thu, 1 Sep 2022 18:39:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 10/11] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <YxCL4q1YSbh5wr8i@MiWiFi-R3L-srv>
References: <20220820003125.353570-11-bhe@redhat.com>
 <202208201146.8VeY9pez-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208201146.8VeY9pez-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/20/22 at 11:41am, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: sh-allmodconfig
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/503a31451202f89e58bc5f0a49261398fafbd90e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>         git checkout 503a31451202f89e58bc5f0a49261398fafbd90e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare

I can only find binutils-sh-linux-gnu on fedora, but no gcc-sh-linux-gnu
for cross compiling superh kernel. So I tried above steps, but it failed
as below, any suggestion I can fix it to proceed for reproducing the
reporting issues? Thanks in advance.

[root@ampere-mtsnow-altra-09 ~]# ls
0day  anaconda-ks.cfg  bin  config  EFI_BOOT_ENTRY.TXT  linux  NETBOOT_METHOD.TXT  original-ks.cfg  RECIPE.TXT
[root@ampere-mtsnow-altra-09 ~]# ls 0day/gcc-12.1.0-nolibc/sh4-linux/bin/
sh4-linux-addr2line  sh4-linux-elfedit     sh4-linux-gcc-ranlib  sh4-linux-ld        sh4-linux-objdump  sh4-linux-strip
sh4-linux-ar         sh4-linux-gcc         sh4-linux-gcov        sh4-linux-ld.bfd    sh4-linux-ranlib
sh4-linux-as         sh4-linux-gcc-12.1.0  sh4-linux-gcov-dump   sh4-linux-lto-dump  sh4-linux-readelf
sh4-linux-c++filt    sh4-linux-gcc-ar      sh4-linux-gcov-tool   sh4-linux-nm        sh4-linux-size
sh4-linux-cpp        sh4-linux-gcc-nm      sh4-linux-gprof       sh4-linux-objcopy   sh4-linux-strings
[root@ampere-mtsnow-altra-09 ~]# ls bin
make.cross
[root@ampere-mtsnow-altra-09 ~]# cd linux/
[root@ampere-mtsnow-altra-09 linux]# ls
arch       certs    CREDITS        drivers  init      Kbuild   lib          Makefile  README   security  usr
block      config   crypto         fs       io_uring  Kconfig  LICENSES     mm        samples  sound     virt
build_dir  COPYING  Documentation  include  ipc       kernel   MAINTAINERS  net       scripts  tools
[root@ampere-mtsnow-altra-09 linux]# ls build_dir/  -a
.  ..  arch  .config  .gitignore  include  Makefile  scripts  source  usr

[root@ampere-mtsnow-altra-09 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare
Compiler will be installed in /root/0day
	not a dynamic executable
make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux- --jobs=160 W=1 O=build_dir ARCH=sh prepare
make[1]: Entering directory '/root/linux/build_dir'
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
  SYNC    include/config/auto.conf.cmd
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
/bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
  GEN     Makefile
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
/root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: unknown compiler
scripts/Kconfig.include:44: Sorry, this compiler is not supported.
make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
make[2]: *** [../Makefile:632: syncconfig] Error 2
make[1]: *** [/root/linux/Makefile:734: include/config/auto.conf.cmd] Error 2
make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
make[1]: Failed to remake makefile 'include/config/auto.conf'.
  GEN     Makefile
  SYSHDR  arch/sh/include/generated/uapi/asm/unistd_32.h
  SYSTBL  arch/sh/include/generated/asm/syscall_table.h
Error: kernelrelease not valid - run 'make prepare' to update it
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  HOSTCC  scripts/dtc/libfdt/fdt.o
  HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  HOSTCC  scripts/dtc/fdtoverlay.o
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/fdtoverlay
  HOSTLD  scripts/dtc/dtc
make[1]: Target 'prepare' not remade because of errors.
make[1]: Leaving directory '/root/linux/build_dir'
make: *** [Makefile:222: __sub-make] Error 2
make: Target 'prepare' not remade because of errors.

