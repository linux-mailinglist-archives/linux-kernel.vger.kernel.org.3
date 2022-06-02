Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE353BC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiFBQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiFBQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C19186281
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517376124C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAE7C385A5;
        Thu,  2 Jun 2022 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186224;
        bh=W5O8ejo2lynHExsg7SmZ23T0ewbI5BRRdUXjHeBiVuk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hyg4LWxhSZo+m/UlcArokupaDf/giYG5S+dhMdRVKkDTxnMwPXV1Woy5WBlhTCk0M
         e6XsUgI+A98NC2R3gouj8YR9aBdBdfxfPi7HS11Uj/BLWh96wyk/aIXAMmN99KiLfF
         PuwcKXTekfPw0EkTZO5G0xgY3jWlwK8zcwmFZ+p1bFvjkZX6b/8CmkCP8C1nXiJmXT
         6MBT57z7DtUoAyGeUji3YLfUe7gxO0xAKEGo6PwhgWFcThlyQTrl9FGLTz9vKwDcyZ
         7z+AzrQRMC2MNiK+NtkGCqSY23XL7h3Ljwrfj7egcKUyl5FD0Pl5GLhg+D3bI+LMw4
         gvKIwDxoNWcmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 468495C05C2; Thu,  2 Jun 2022 09:10:24 -0700 (PDT)
Date:   Thu, 2 Jun 2022 09:10:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2022.05.26a] BUILD REGRESSION
 2ba9ea99370a332f696257f3e4ab417d883f1aa4
Message-ID: <20220602161024.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <629867a8.4CyAPoTD53JAwVmA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629867a8.4CyAPoTD53JAwVmA%lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 03:32:56PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.26a
> branch HEAD: 2ba9ea99370a332f696257f3e4ab417d883f1aa4  fixup! rcu-tasks: Handle idle tasks for recently offlined CPUs
> 
> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/rcu/rcuscale.ko] undefined!
> ERROR: modpost: "rcu_trc_cmpxchg_need_qs" [kernel/torture.ko] undefined!

Good catch, I am folding a fix in with attribution.

							Thanx, Paul

> arch/alpha/include/asm/cmpxchg.h:62:17: error: cast to union type from type not present in union
> arch/arm/include/asm/cmpxchg.h:211:9: error: cast to union type from type not present in union
> arch/arm64/include/asm/cmpxchg.h:182:17: error: cast to union type from type not present in union
> arch/m68k/include/asm/cmpxchg.h:121:11: error: cast to union type from type not present in union
> arch/parisc/include/asm/cmpxchg.h:85:9: error: cast to union type from type not present in union
> arch/powerpc/include/asm/cmpxchg.h:474:6: error: cast to union type from type not present in union
> arch/s390/include/asm/cmpxchg.h:160:17: error: cast to union type from type not present in union
> arch/sparc/include/asm/cmpxchg_64.h:175:6: error: cast to union type from type not present in union
> include/asm-generic/cmpxchg.h:92:10: error: cast to union type from type not present in union
> include/linux/atomic/atomic-instrumented.h:1912:1: error: incompatible types when assigning to type 'union rcu_special' from type 'int'
> kernel/rcu/tasks.h:1243:8: error: initializing 'typeof (*(__ai_ptr))' (aka 'union rcu_special') with an expression of incompatible type 'int'
> kernel/rcu/tasks.h:1243:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
> kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- alpha-allyesconfig
> |   `-- arch-alpha-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- arm-randconfig-r005-20220531
> |   |-- arch-arm-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |   `-- include-linux-atomic-atomic-instrumented.h:error:incompatible-types-when-assigning-to-type-union-rcu_special-from-type-int
> |-- arm64-randconfig-r013-20220531
> |   `-- arch-arm64-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- i386-randconfig-a003
> |   |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
> |   `-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
> |-- m68k-allmodconfig
> |   `-- arch-m68k-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- m68k-defconfig
> |   |-- include-asm-generic-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |   `-- kernel-rcu-tasks.h:error:aggregate-value-used-where-an-integer-was-expected
> |-- parisc-allyesconfig
> |   `-- arch-parisc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- powerpc-allyesconfig
> |   `-- arch-powerpc-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- s390-randconfig-r044-20220531
> |   `-- arch-s390-include-asm-cmpxchg.h:error:cast-to-union-type-from-type-not-present-in-union
> |-- sparc-allyesconfig
> |   `-- arch-sparc-include-asm-cmpxchg_64.h:error:cast-to-union-type-from-type-not-present-in-union
> `-- x86_64-randconfig-a004
>     |-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-rcu-rcuscale.ko-undefined
>     `-- ERROR:rcu_trc_cmpxchg_need_qs-kernel-torture.ko-undefined
> 
> clang_recent_errors
> |-- arm64-buildonly-randconfig-r002-20220531
> |   `-- kernel-rcu-tasks.h:error:operand-of-type-union-rcu_special-where-arithmetic-or-pointer-type-is-required
> `-- hexagon-randconfig-r033-20220531
>     `-- kernel-rcu-tasks.h:error:initializing-typeof-(-(__ai_ptr))-(aka-union-rcu_special-)-with-an-expression-of-incompatible-type-int
> 
> elapsed time: 741m
> 
> configs tested: 84
> configs skipped: 3
> 
> gcc tested configs:
> arm                              allmodconfig
> arm                              allyesconfig
> arm64                            allyesconfig
> arm                                 defconfig
> arm64                               defconfig
> ia64                                defconfig
> ia64                             allmodconfig
> ia64                             allyesconfig
> m68k                                defconfig
> m68k                             allmodconfig
> m68k                             allyesconfig
> alpha                               defconfig
> csky                                defconfig
> nios2                            allyesconfig
> alpha                            allyesconfig
> sh                               allmodconfig
> arc                                 defconfig
> h8300                            allyesconfig
> xtensa                           allyesconfig
> parisc                              defconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> s390                             allyesconfig
> parisc64                            defconfig
> nios2                               defconfig
> arc                              allyesconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> i386                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> powerpc                          allyesconfig
> x86_64                        randconfig-a002
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> i386                          randconfig-a001
> i386                          randconfig-a003
> i386                          randconfig-a005
> x86_64                        randconfig-a015
> x86_64                        randconfig-a013
> x86_64                        randconfig-a011
> i386                          randconfig-a014
> i386                          randconfig-a012
> i386                          randconfig-a016
> arc                  randconfig-r043-20220531
> riscv                randconfig-r042-20220531
> s390                 randconfig-r044-20220531
> riscv                             allnoconfig
> riscv                            allyesconfig
> riscv                            allmodconfig
> riscv                    nommu_k210_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_virt_defconfig
> riscv                               defconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> x86_64                              defconfig
> x86_64                                  kexec
> x86_64                               rhel-8.3
> x86_64                           allyesconfig
> x86_64                    rhel-8.3-kselftests
> x86_64                           rhel-8.3-syz
> x86_64                          rhel-8.3-func
> x86_64                         rhel-8.3-kunit
> 
> clang tested configs:
> x86_64                        randconfig-a001
> x86_64                        randconfig-a003
> x86_64                        randconfig-a005
> i386                          randconfig-a002
> i386                          randconfig-a004
> i386                          randconfig-a006
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> i386                          randconfig-a013
> i386                          randconfig-a015
> i386                          randconfig-a011
> hexagon              randconfig-r041-20220531
> hexagon              randconfig-r045-20220531
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
