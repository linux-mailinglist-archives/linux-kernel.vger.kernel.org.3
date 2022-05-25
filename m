Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B4533E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiEYNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEYNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BA8AE4A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7067E618A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9266C385B8;
        Wed, 25 May 2022 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653486906;
        bh=CfTnJGKVhNF7utIbRmhwjcNqoeDAqEuAB058VrAEaMo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dK62jYdhh0oqaxPkMhGszJoMLLikYD3FnVg0hAUHnYV035ocX/GJ9e3pLgJZ3GTnG
         nEcxyWu8jc1dU7OtLdHyUJgU7YfBVK/4ydKndrJJyqmcxa0oHevaiIVOB7PTW1ZgH8
         vWxlM1O2oAUPMGT7pJbX0AbZjcBSFOFXFq50KLMew+1qIcIUpRMXh9doIq4eN1WMMV
         ZQ8VwMW+g2pjta8ZfrQ+y6ErQCiVRsDfbjEsTecW0KkRlI9ixJK6630KV9sLX7J8A5
         NC9Spzv/t4bvLH+9qTInq1Obqjk7UF90ph/E4FpvEWnsjBhEcwUj5KJfIA0+PHqafs
         1Ksz5C/5soAaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 732515C018D; Wed, 25 May 2022 06:55:06 -0700 (PDT)
Date:   Wed, 25 May 2022 06:55:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2022.05.18a] BUILD SUCCESS
 9735325cf6f7eb6cdcf1ad875b49faa72f288f79
Message-ID: <20220525135506.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <628daef3.rSmQa/YrjedRRrS9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628daef3.rSmQa/YrjedRRrS9%lkp@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:22:11PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.05.18a
> branch HEAD: 9735325cf6f7eb6cdcf1ad875b49faa72f288f79  fixup! rcu-tasks: Scan running tasks for RCU Tasks Trace readers
> 
> Unverified Warning (likely false positive, please contact us if interested):
> 
> kernel/rcu/tasks.h:1514 rcu_tasks_trace_pregp_step() error: uninitialized symbol 'rtpcp'.

It did happen to point out a bug in this case, but the compiler cannot
know that the loop in which it is initialized must execute at least once
because there cannot be zero CPUs.  So it really is always initialized,
so lack of initialization is not the problem.  The problem instead is
that it will likely have the wrong value after the loop completes.

It could just as well be that the code following the loop wanted to
use the rtpcp corresponding to the last CPU visited by that loop, and
knowing that there will always be a last CPU.

So this diagnostic might sometimes be useful, and it might point out some
tricky bugs, but it is going to require a lot of human time and attention.

As always, choose wisely!

							Thanx, Paul

> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- i386-randconfig-m021
>     `-- kernel-rcu-tasks.h-rcu_tasks_trace_pregp_step()-error:uninitialized-symbol-rtpcp-.
> 
> elapsed time: 1725m
> 
> configs tested: 130
> configs skipped: 3
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> gcc tested configs:
> arm64                               defconfig
> arm64                            allyesconfig
> arm                              allmodconfig
> arm                                 defconfig
> arm                              allyesconfig
> i386                          randconfig-c001
> sh                              ul2_defconfig
> arc                 nsimosci_hs_smp_defconfig
> m68k                            mac_defconfig
> m68k                          sun3x_defconfig
> arm                      integrator_defconfig
> m68k                          hp300_defconfig
> arm                        cerfcube_defconfig
> arc                     nsimosci_hs_defconfig
> m68k                         amcore_defconfig
> arm                           imxrt_defconfig
> arm                        realview_defconfig
> sparc64                          alldefconfig
> arm                             ezx_defconfig
> sh                     sh7710voipgw_defconfig
> powerpc                        warp_defconfig
> sh                           se7206_defconfig
> m68k                             alldefconfig
> arm                       multi_v4t_defconfig
> xtensa                          iss_defconfig
> mips                     loongson1b_defconfig
> um                                  defconfig
> powerpc                         wii_defconfig
> sh                          r7780mp_defconfig
> nios2                         3c120_defconfig
> ia64                                defconfig
> riscv                             allnoconfig
> m68k                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> nios2                            allyesconfig
> alpha                               defconfig
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
> sparc                               defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> i386                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> x86_64               randconfig-a002-20220523
> x86_64               randconfig-a001-20220523
> x86_64               randconfig-a003-20220523
> x86_64               randconfig-a006-20220523
> x86_64               randconfig-a004-20220523
> i386                 randconfig-a004-20220523
> i386                 randconfig-a001-20220523
> i386                 randconfig-a003-20220523
> i386                 randconfig-a002-20220523
> i386                 randconfig-a006-20220523
> i386                 randconfig-a005-20220523
> x86_64                        randconfig-a011
> x86_64                        randconfig-a013
> x86_64                        randconfig-a015
> i386                          randconfig-a012
> i386                          randconfig-a014
> i386                          randconfig-a016
> arc                  randconfig-r043-20220524
> s390                 randconfig-r044-20220524
> riscv                randconfig-r042-20220524
> arc                  randconfig-r043-20220523
> s390                 randconfig-r044-20220522
> riscv                               defconfig
> riscv                    nommu_virt_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_k210_defconfig
> riscv                            allmodconfig
> riscv                            allyesconfig
> x86_64                    rhel-8.3-kselftests
> um                           x86_64_defconfig
> um                             i386_defconfig
> x86_64                                  kexec
> x86_64                              defconfig
> x86_64                           allyesconfig
> x86_64                               rhel-8.3
> x86_64                          rhel-8.3-func
> x86_64                           rhel-8.3-syz
> x86_64                         rhel-8.3-kunit
> 
> clang tested configs:
> arm                        mvebu_v5_defconfig
> mips                       rbtx49xx_defconfig
> riscv                          rv32_defconfig
> arm                          moxart_defconfig
> mips                        maltaup_defconfig
> powerpc                 mpc836x_mds_defconfig
> powerpc                     akebono_defconfig
> powerpc                      walnut_defconfig
> arm                          pcm027_defconfig
> powerpc                          g5_defconfig
> powerpc                      katmai_defconfig
> mips                            e55_defconfig
> powerpc                      obs600_defconfig
> x86_64                        randconfig-a005
> x86_64                        randconfig-a001
> x86_64                        randconfig-a003
> i386                          randconfig-a002
> i386                          randconfig-a006
> i386                          randconfig-a004
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> i386                          randconfig-a011
> i386                          randconfig-a013
> i386                          randconfig-a015
> hexagon              randconfig-r041-20220523
> hexagon              randconfig-r045-20220524
> hexagon              randconfig-r041-20220524
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
