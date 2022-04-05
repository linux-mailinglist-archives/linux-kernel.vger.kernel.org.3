Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2A4F4F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837218AbiDFApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573228AbiDES2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489725C2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=C5VgPld09iYiqC751h87aH+aMCuoBzx6fK1WSSESdHU=; b=SwViTp0djw63Y6CABGQ1kgy1MK
        Sg10F6y4NOV61Rir++P/63S/FDRiwka1up4YV6y051CJP7shE80m6qmKXXDsczK1vX8f2WKP/NjCZ
        Cj66jHxR6zi9Xx8507YAx1+F5xPyMjjvkV4J0t4jYmx3bfR2Nz3lFYHw3dSljv0jje09m/E2KkB4w
        KHtNtxVR8Q9eDKh1MccF4Ajd8SFB4xWUzBDuxTtApOaQSxvv9qe81W32p0JJbHPTK2GYyA8NRnJr8
        X91FZOL/Wbc8LXLnP4xXbiBpQszZNSdqgvbDwdqVx1MrEZxRwek7RYcv2W7/G6w8x/Z0oc3fG4TXA
        T0Spj4cQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbnsY-006x9i-PI; Tue, 05 Apr 2022 18:26:11 +0000
Message-ID: <019baa48-a594-ba00-67a9-b0eb62b32ac0@infradead.org>
Date:   Tue, 5 Apr 2022 11:26:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: drivers/cpuidle/cpuidle-riscv-sbi.c:79:16: error: variable has
 incomplete type 'struct sbiret'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <202204051441.dQ4w35Ga-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204051441.dQ4w35Ga-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/4/22 23:11, kernel test robot wrote:
> Hi Anup,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3123109284176b1532874591f7c81f3837bbdc17
> commit: c5179ef1ca0c39dab6955be6b0e3c034cc4164c8 RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
> date:   4 weeks ago
> config: riscv-randconfig-r022-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051441.dQ4w35Ga-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c5179ef1ca0c39dab6955be6b0e3c034cc4164c8
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 

[delete many build warnings and errors]

>    3 warnings and 17 errors generated.
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
>    Depends on CPU_IDLE && RISCV && RISCV_SBI
>    Selected by
>    - SOC_VIRT && CPU_IDLE

This Kconfig warning is the root of the problem. All of the build errors
and warnings can be fixed by something like so. Is it OK?

---
 arch/riscv/Kconfig.socs |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220404.orig/arch/riscv/Kconfig.socs
+++ linux-next-20220404/arch/riscv/Kconfig.socs
@@ -38,7 +38,7 @@ config SOC_VIRT
 	select SIFIVE_PLIC
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
-	select RISCV_SBI_CPUIDLE if CPU_IDLE
+	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
 	help
 	  This enables support for QEMU Virt Machine.
 
[snip]

Also, to the @bot:

Why does the reported Kconfig warning look like it was generated
by some older kconfig software?  Current Kconfig reports more info:

WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
  Depends on [n]: CPU_IDLE [=y] && RISCV [=y] && RISCV_SBI [=n]
  Selected by [y]:
  - SOC_VIRT [=y] && CPU_IDLE [=y]

Thanks.
> 
> :::::: The code at line 79 was first introduced by commit
> :::::: 6abf32f1d9c5009dcccded2c1e7ca899a4ab587b cpuidle: Add RISC-V SBI CPU idle driver
> 
> :::::: TO: Anup Patel <anup.patel@wdc.com>
> :::::: CC: Palmer Dabbelt <palmer@rivosinc.com>
> 

-- 
~Randy
