Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0F55766B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFWJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiFWJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:16:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4190042EC4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:16:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287D213D5;
        Thu, 23 Jun 2022 02:16:11 -0700 (PDT)
Received: from [192.168.178.35] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FB0F3F792;
        Thu, 23 Jun 2022 02:16:10 -0700 (PDT)
Message-ID: <24f2c018-488e-f9b2-3f72-66d7e17021e2@arm.com>
Date:   Thu, 23 Jun 2022 11:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: kernel/sched/fair.c:9246:53: error: use of undeclared identifier
 'select_idle_mask'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <202206221253.ZVyGQvPX-lkp@intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <202206221253.ZVyGQvPX-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 06:13, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
> head:   2059fff7a5a2b6016ef5843c673845283a00a646
> commit: a4a1ec79913664ac49b72cda8c3756c4da7c16b4 sched/fair: Rename select_idle_mask to select_rq_mask
> date:   19 hours ago
> config: s390-randconfig-r044-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221253.ZVyGQvPX-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/a4a1ec79913664ac49b72cda8c3756c4da7c16b4
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
>         git checkout a4a1ec79913664ac49b72cda8c3756c4da7c16b4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/
> 

[...]

>>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
>                                    struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>                                                                                    ^
>>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
>>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
>>> kernel/sched/fair.c:9246:21: error: initializing 'struct cpumask *' with an expression of incompatible type 'void'
>                                    struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>                                                    ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is due to commit f5b2eeb499910 ("sched/fair: Consider CPU affinity
when allowing NUMA imbalance in find_idlest_group()") which appeared on
tip sched/core and linux-next in the meantime.

Fixed in
https://lkml.kernel.org/r/250691c7-0e2b-05ab-bedf-b245c11d9400@arm.com .

Thanks!
