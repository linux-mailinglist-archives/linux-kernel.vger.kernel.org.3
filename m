Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66385A966A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiIAMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiIAMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:11:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EF1402B;
        Thu,  1 Sep 2022 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662034301; x=1693570301;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KH4wwLYYR22LaR2ahETD9PzcSMcK/GwXPV7wTEaIDMY=;
  b=PIGYH/m0Zt7SCHSxOVr8e11FUvyHWhyYGFaDbpovwzVPziPnTY59HsCA
   PxRMOqu3yyvi3KScnkVlgVT1U6flruidIYRjU1+yyX6/2iBfy/YzJtatl
   W1MbwNrFDhaRArL2UGhZYCODA+hXCsyZIAQoLm+ZViEWKy0g1Yq2YgEpE
   IA4HA03j3r4ipIh7gATH5jB6w2edptlbhH2h3GEWIWaELEsPtcHM3RUYI
   ZOC5QfZhJNo3thwRLTT+WJgDCIXMQrhyiIlTiE/oMhIncuN51Z1WBdAkk
   +kjckC0lZQLItwNKkZRFI4jshMKJTPG2KzYtHDzpLE3O/5sCcoGNtXQVi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278714086"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="278714086"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:11:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673821546"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.213.173]) ([10.254.213.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 05:11:36 -0700
Subject: Re: [kbuild-all] Re: [PATCH v2 10/11] sh: mm: Convert to
 GENERIC_IOREMAP
To:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <20220820003125.353570-11-bhe@redhat.com>
 <202208201146.8VeY9pez-lkp@intel.com> <YxCL4q1YSbh5wr8i@MiWiFi-R3L-srv>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <bdb4982b-cb3c-c4a5-a97b-f1b2c0483ef8@intel.com>
Date:   Thu, 1 Sep 2022 20:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YxCL4q1YSbh5wr8i@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 6:39 PM, Baoquan He wrote:
> Hi,
> 
> On 08/20/22 at 11:41am, kernel test robot wrote:
>> Hi Baoquan,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> config: sh-allmodconfig
>> compiler: sh4-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/503a31451202f89e58bc5f0a49261398fafbd90e
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>>          git checkout 503a31451202f89e58bc5f0a49261398fafbd90e
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare
> 
> I can only find binutils-sh-linux-gnu on fedora, but no gcc-sh-linux-gnu
> for cross compiling superh kernel. So I tried above steps, but it failed
> as below, any suggestion I can fix it to proceed for reproducing the
> reporting issues? Thanks in advance.

Hi Baoquan,

Sorry for the inconvenience, /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin
/sh4-linux-gcc is for x86_64 machine, as the name "ampere-mtsnow-altra",
is it a arm server?

the tool for arm64 can be downloaded from 
https://cdn.kernel.org/pub/tools/crosstool/files/bin/arm64/12.1.0/

Best Regards,
Rong Chen

> 
> [root@ampere-mtsnow-altra-09 ~]# ls
> 0day  anaconda-ks.cfg  bin  config  EFI_BOOT_ENTRY.TXT  linux  NETBOOT_METHOD.TXT  original-ks.cfg  RECIPE.TXT
> [root@ampere-mtsnow-altra-09 ~]# ls 0day/gcc-12.1.0-nolibc/sh4-linux/bin/
> sh4-linux-addr2line  sh4-linux-elfedit     sh4-linux-gcc-ranlib  sh4-linux-ld        sh4-linux-objdump  sh4-linux-strip
> sh4-linux-ar         sh4-linux-gcc         sh4-linux-gcov        sh4-linux-ld.bfd    sh4-linux-ranlib
> sh4-linux-as         sh4-linux-gcc-12.1.0  sh4-linux-gcov-dump   sh4-linux-lto-dump  sh4-linux-readelf
> sh4-linux-c++filt    sh4-linux-gcc-ar      sh4-linux-gcov-tool   sh4-linux-nm        sh4-linux-size
> sh4-linux-cpp        sh4-linux-gcc-nm      sh4-linux-gprof       sh4-linux-objcopy   sh4-linux-strings
> [root@ampere-mtsnow-altra-09 ~]# ls bin
> make.cross
> [root@ampere-mtsnow-altra-09 ~]# cd linux/
> [root@ampere-mtsnow-altra-09 linux]# ls
> arch       certs    CREDITS        drivers  init      Kbuild   lib          Makefile  README   security  usr
> block      config   crypto         fs       io_uring  Kconfig  LICENSES     mm        samples  sound     virt
> build_dir  COPYING  Documentation  include  ipc       kernel   MAINTAINERS  net       scripts  tools
> [root@ampere-mtsnow-altra-09 linux]# ls build_dir/  -a
> .  ..  arch  .config  .gitignore  include  Makefile  scripts  source  usr
> 
> [root@ampere-mtsnow-altra-09 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare
> Compiler will be installed in /root/0day
> 	not a dynamic executable
> make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux- --jobs=160 W=1 O=build_dir ARCH=sh prepare
> make[1]: Entering directory '/root/linux/build_dir'
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
>    SYNC    include/config/auto.conf.cmd
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
> /bin/sh: line 1: /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: cannot execute binary file: Exec format error
>    GEN     Makefile
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    HOSTCC  scripts/kconfig/confdata.o
>    HOSTCC  scripts/kconfig/expr.o
>    LEX     scripts/kconfig/lexer.lex.c
>    YACC    scripts/kconfig/parser.tab.[ch]
>    HOSTCC  scripts/kconfig/menu.o
>    HOSTCC  scripts/kconfig/preprocess.o
>    HOSTCC  scripts/kconfig/symbol.o
>    HOSTCC  scripts/kconfig/util.o
>    HOSTCC  scripts/kconfig/lexer.lex.o
>    HOSTCC  scripts/kconfig/parser.tab.o
>    HOSTLD  scripts/kconfig/conf
> /root/0day/gcc-12.1.0-nolibc/sh4-linux/bin/sh4-linux-gcc: unknown compiler
> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
> make[2]: *** [../Makefile:632: syncconfig] Error 2
> make[1]: *** [/root/linux/Makefile:734: include/config/auto.conf.cmd] Error 2
> make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
> make[1]: Failed to remake makefile 'include/config/auto.conf'.
>    GEN     Makefile
>    SYSHDR  arch/sh/include/generated/uapi/asm/unistd_32.h
>    SYSTBL  arch/sh/include/generated/asm/syscall_table.h
> Error: kernelrelease not valid - run 'make prepare' to update it
>    HOSTCC  scripts/dtc/dtc.o
>    HOSTCC  scripts/dtc/flattree.o
>    HOSTCC  scripts/dtc/fstree.o
>    HOSTCC  scripts/dtc/data.o
>    HOSTCC  scripts/dtc/livetree.o
>    HOSTCC  scripts/dtc/treesource.o
>    HOSTCC  scripts/dtc/srcpos.o
>    HOSTCC  scripts/dtc/checks.o
>    HOSTCC  scripts/dtc/util.o
>    LEX     scripts/dtc/dtc-lexer.lex.c
>    YACC    scripts/dtc/dtc-parser.tab.[ch]
>    HOSTCC  scripts/dtc/libfdt/fdt_ro.o
>    HOSTCC  scripts/dtc/libfdt/fdt.o
>    HOSTCC  scripts/dtc/libfdt/fdt_wip.o
>    HOSTCC  scripts/dtc/libfdt/fdt_sw.o
>    HOSTCC  scripts/dtc/libfdt/fdt_rw.o
>    HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
>    HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
>    HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
>    HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
>    HOSTCC  scripts/dtc/fdtoverlay.o
>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>    HOSTLD  scripts/dtc/fdtoverlay
>    HOSTLD  scripts/dtc/dtc
> make[1]: Target 'prepare' not remade because of errors.
> make[1]: Leaving directory '/root/linux/build_dir'
> make: *** [Makefile:222: __sub-make] Error 2
> make: Target 'prepare' not remade because of errors.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
