Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3A4F04C1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357816AbiDBQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357826AbiDBQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78702132EBA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 111C9616E8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C38DC340F3;
        Sat,  2 Apr 2022 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648915908;
        bh=CNi5BhB2Pfe+7ZRjxOOMrputi5ySIyr2QrGcrCv5xPc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Fm066Ks8rPFnfLKfxZsFdhyHNvT5uXgb6nCNrutqvNtfRhOnzooLGgLzf82/vi6Np
         97Ut9PmBGfAhlx7fP3qr2tce4VDFFElAgqvSEpMCNOgc+XE2WGIu+Z54dtZ5aC2ax6
         FGtSbKR/jX4IL1ZpzX6KgjiP2ACuoKGRo1YYCiM46L3BkPy2bbNbZi4FY/V18DCTdO
         bXJA5jZwdatubg9tmMv8aVopRxkyvnmONTit1Lh+ZwnWSGHfxeS9iaJVPivquTplol
         CyCwaP24bVF/40apcXBm4U/UNOxaeiwgI78+PbZmj6bMC2M5StwCqedMVN4B+h6rGt
         8RfLhAHVQhpxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B04D5C084F; Sat,  2 Apr 2022 09:11:48 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:11:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [paulmck-rcu:fastexp.2022.04.01a] BUILD REGRESSION
 d9f3e7d671416fdf5b61f094765754269b652db0
Message-ID: <20220402161148.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <62486f05.ithFB6YqfjaeQiXK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62486f05.ithFB6YqfjaeQiXK%lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 11:43:01PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.01a
> branch HEAD: d9f3e7d671416fdf5b61f094765754269b652db0  EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/lkml/202204021454.WDwBbwVL-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void

Adding Aneesh on CC.  My kneejerk reaction would be to add a
"return 0" to this function, but there might be a reason why it
looks like this:

	/*
	 * This should never get called
	 */
	static inline int get_hugepd_cache_index(int index)
	{
		BUG();
	}

Working on the other problem with RCU's Kconfig options.

							Thanx, Paul

> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- powerpc64-randconfig-c003-20220402
>     `-- arch-powerpc-include-asm-book3s-pgtable-64k.h:error:no-return-statement-in-function-returning-non-void
> 
> elapsed time: 819m
> 
> configs tested: 124
> configs skipped: 3
> 
> gcc tested configs:
> arm64                               defconfig
> arm                              allmodconfig
> arm                                 defconfig
> arm                              allyesconfig
> arm64                            allyesconfig
> i386                          randconfig-c001
> xtensa                  audio_kc705_defconfig
> arc                 nsimosci_hs_smp_defconfig
> powerpc                      ppc6xx_defconfig
> arm                        cerfcube_defconfig
> arm                        realview_defconfig
> arm                      jornada720_defconfig
> arm                          exynos_defconfig
> powerpc                 mpc85xx_cds_defconfig
> powerpc64                           defconfig
> m68k                       m5208evb_defconfig
> powerpc                      makalu_defconfig
> sh                           se7721_defconfig
> powerpc                           allnoconfig
> arm                       aspeed_g5_defconfig
> mips                      loongson3_defconfig
> riscv                            allmodconfig
> alpha                               defconfig
> arm                         vf610m4_defconfig
> powerpc                         wii_defconfig
> sh                        dreamcast_defconfig
> powerpc                mpc7448_hpc2_defconfig
> powerpc                 canyonlands_defconfig
> mips                  maltasmvp_eva_defconfig
> s390                       zfcpdump_defconfig
> mips                         cobalt_defconfig
> sh                           se7712_defconfig
> x86_64                        randconfig-c001
> arm                  randconfig-c002-20220402
> ia64                             allmodconfig
> ia64                             allyesconfig
> ia64                                defconfig
> m68k                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> nios2                            allyesconfig
> alpha                            allyesconfig
> h8300                            allyesconfig
> xtensa                           allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> s390                                defconfig
> s390                             allmodconfig
> parisc                              defconfig
> parisc64                            defconfig
> parisc                           allyesconfig
> s390                             allyesconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> i386                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> i386                          randconfig-a001
> i386                          randconfig-a003
> i386                          randconfig-a005
> x86_64                        randconfig-a015
> x86_64                        randconfig-a013
> x86_64                        randconfig-a011
> i386                          randconfig-a014
> i386                          randconfig-a012
> i386                          randconfig-a016
> arc                  randconfig-r043-20220402
> s390                 randconfig-r044-20220402
> riscv                randconfig-r042-20220402
> riscv                               defconfig
> riscv                    nommu_virt_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_k210_defconfig
> riscv                             allnoconfig
> riscv                            allyesconfig
> x86_64                    rhel-8.3-kselftests
> um                             i386_defconfig
> um                           x86_64_defconfig
> x86_64                          rhel-8.3-func
> x86_64                                  kexec
> x86_64                              defconfig
> x86_64                           allyesconfig
> x86_64                         rhel-8.3-kunit
> x86_64                               rhel-8.3
> 
> clang tested configs:
> x86_64                        randconfig-c007
> i386                          randconfig-c001
> powerpc              randconfig-c003-20220402
> riscv                randconfig-c006-20220402
> mips                 randconfig-c004-20220402
> arm                  randconfig-c002-20220402
> powerpc                      obs600_defconfig
> arm                        neponset_defconfig
> powerpc                     mpc512x_defconfig
> arm                           spitz_defconfig
> arm                       spear13xx_defconfig
> mips                      bmips_stb_defconfig
> powerpc                     mpc5200_defconfig
> mips                           mtx1_defconfig
> powerpc                 mpc832x_mds_defconfig
> powerpc                    ge_imp3a_defconfig
> mips                           ip28_defconfig
> arm                         bcm2835_defconfig
> powerpc                   microwatt_defconfig
> x86_64                        randconfig-a005
> i386                          randconfig-a002
> i386                          randconfig-a006
> i386                          randconfig-a004
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> x86_64                        randconfig-a012
> i386                          randconfig-a013
> i386                          randconfig-a011
> i386                          randconfig-a015
> hexagon              randconfig-r041-20220402
> hexagon              randconfig-r045-20220402
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
